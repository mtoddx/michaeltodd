#!/bin/bash

# Favicon Generator Script
# Usage: ./generate-favicons.sh source-image.png

if [ $# -eq 0 ]; then
    echo "❌ Error: No source image provided"
    echo "Usage: ./generate-favicons.sh source-image.png"
    echo ""
    echo "The source image should be:"
    echo "  - Square (1:1 aspect ratio)"
    echo "  - At least 512x512 pixels"
    echo "  - PNG format with transparency (optional)"
    exit 1
fi

SOURCE_IMAGE=$1
OUTPUT_DIR="assets/images"

# Check if source image exists
if [ ! -f "$SOURCE_IMAGE" ]; then
    echo "❌ Error: Source image '$SOURCE_IMAGE' not found"
    exit 1
fi

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "❌ Error: ImageMagick is not installed"
    echo ""
    echo "Install it with:"
    echo "  macOS: brew install imagemagick"
    echo "  Ubuntu: sudo apt-get install imagemagick"
    echo "  Windows: Download from https://imagemagick.org/script/download.php"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "🎨 Generating favicons from $SOURCE_IMAGE..."
echo ""

# Generate favicons
echo "📐 Creating favicon-16x16.png..."
convert "$SOURCE_IMAGE" -resize 16x16 "$OUTPUT_DIR/favicon-16x16.png"

echo "📐 Creating favicon-32x32.png..."
convert "$SOURCE_IMAGE" -resize 32x32 "$OUTPUT_DIR/favicon-32x32.png"

echo "📐 Creating apple-touch-icon.png..."
convert "$SOURCE_IMAGE" -resize 180x180 "$OUTPUT_DIR/apple-touch-icon.png"

echo "📐 Creating android-chrome-192x192.png..."
convert "$SOURCE_IMAGE" -resize 192x192 "$OUTPUT_DIR/android-chrome-192x192.png"

echo "📐 Creating android-chrome-512x512.png..."
convert "$SOURCE_IMAGE" -resize 512x512 "$OUTPUT_DIR/android-chrome-512x512.png"

echo ""
echo "✅ All favicons generated successfully!"
echo ""
echo "Files created in $OUTPUT_DIR/:"
echo "  ✓ favicon-16x16.png"
echo "  ✓ favicon-32x32.png"
echo "  ✓ apple-touch-icon.png"
echo "  ✓ android-chrome-192x192.png"
echo "  ✓ android-chrome-512x512.png"
echo ""
echo "🚀 Next steps:"
echo "  1. Test your site: bundle exec jekyll serve"
echo "  2. Check favicons in browser"
echo "  3. Test on mobile devices"
