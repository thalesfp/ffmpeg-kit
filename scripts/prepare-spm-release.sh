#!/bin/bash

# Script to prepare SPM release by updating Package.swift with actual checksums
# Usage: ./scripts/prepare-spm-release.sh <version> <xcframework-directory>

set -e

VERSION=$1
XCFRAMEWORK_DIR=$2

if [ -z "$VERSION" ] || [ -z "$XCFRAMEWORK_DIR" ]; then
    echo "Usage: $0 <version> <xcframework-directory>"
    echo "Example: $0 6.1.0 prebuilt/bundle-apple-xcframework-ios"
    exit 1
fi

echo "Preparing SPM release for version $VERSION"
echo "Using xcframeworks from: $XCFRAMEWORK_DIR"

# Create zips and calculate checksums
cd "$XCFRAMEWORK_DIR"
CHECKSUMS=""

for framework in *.xcframework; do
    if [ -d "$framework" ]; then
        ZIP_NAME="${framework%.xcframework}.xcframework.zip"

        # Create zip if it doesn't exist
        if [ ! -f "$ZIP_NAME" ]; then
            echo "Creating $ZIP_NAME..."
            zip -r "$ZIP_NAME" "$framework" -q
        fi

        # Calculate checksum
        CHECKSUM=$(swift package compute-checksum "$ZIP_NAME")
        FRAMEWORK_NAME="${framework%.xcframework}"

        echo "$FRAMEWORK_NAME: $CHECKSUM"
        CHECKSUMS="${CHECKSUMS}${FRAMEWORK_NAME}:${CHECKSUM}\n"
    fi
done

cd - > /dev/null

# Update Package.swift with actual checksums
PACKAGE_SWIFT="Package.swift"
TEMP_FILE="Package.swift.tmp"

cp "$PACKAGE_SWIFT" "$TEMP_FILE"

# Update version in URLs
sed -i '' "s|/v[0-9.]*[^/]*/|/v${VERSION}/|g" "$TEMP_FILE"

# Update checksums
echo -e "$CHECKSUMS" | while IFS=: read -r framework checksum; do
    if [ ! -z "$framework" ] && [ ! -z "$checksum" ]; then
        # Update placeholder checksum
        sed -i '' "s|PLACEHOLDER_CHECKSUM_${framework^^}|${checksum}|g" "$TEMP_FILE"

        # Also update any existing checksums for this framework
        sed -i '' "/name: \"$framework\"/,/checksum:/ s/checksum: \".*\"/checksum: \"${checksum}\"/" "$TEMP_FILE"
    fi
done

mv "$TEMP_FILE" "$PACKAGE_SWIFT"

echo ""
echo "Package.swift updated successfully!"
echo ""
echo "Next steps:"
echo "1. Review the updated Package.swift"
echo "2. Commit the changes"
echo "3. Create a git tag: git tag v${VERSION}"
echo "4. Push the tag: git push origin v${VERSION}"
echo "5. Upload the .xcframework.zip files to the GitHub release"