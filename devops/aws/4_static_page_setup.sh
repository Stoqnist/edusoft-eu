#!/bin/bash

# Static page setup script
# This script sets up the static page for video playback

# Create the static page directory
mkdir -p static-page
cd static-page

# Create index.html with video player
cat > index.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Video Player</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f0f0;
        }
        .video-container {
            max-width: 800px;
            width: 100%;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        video {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="video-container">
        <video id="videoPlayer" controls>
            <source src="" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
    <script>
        // Function to get signed URL from your backend
        async function getSignedUrl(videoKey) {
            // Replace with your backend API endpoint
            const response = await fetch(\`/api/get-signed-url?key=\${videoKey}\`);
            const data = await response.json();
            return data.signedUrl;
        }

        // Initialize video player with signed URL
        async function initializePlayer() {
            const videoKey = new URLSearchParams(window.location.search).get('video');
            if (videoKey) {
                const signedUrl = await getSignedUrl(videoKey);
                document.getElementById('videoPlayer').src = signedUrl;
            }
        }

        // Initialize player when page loads
        window.addEventListener('load', initializePlayer);
    </script>
</body>
</html>
EOL

# Create README with deployment instructions
cat > README.md << EOL
# Static Video Player Page

This is a secure video player page that works with CloudFront-protected videos.

## Deployment Instructions

1. Create a new GitHub repository
2. Push these files to the repository
3. Enable GitHub Pages in repository settings
4. Set the deployment branch and folder
5. Access your site at the provided GitHub Pages URL

## Usage

Access the player with a video key parameter:
\`\`\`
https://your-github-pages-url/?video=path/to/video.mp4
\`\`\`

Note: Make sure to update the API endpoint in the JavaScript code to point to your backend service that generates signed URLs.
EOL

echo "Static page files created!"
echo "Please create a GitHub repository and follow the deployment instructions in README.md"