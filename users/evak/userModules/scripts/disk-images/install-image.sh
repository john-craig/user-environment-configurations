#!/bin/bash

# if [[ "$1" == "completions"]]; then

# fi

TARGET_IMAGE=$1
TARGET_DEVICE=$2

if [[ -z $TARGET_IMAGE ]]; then
    echo "Must specify a target image"
    exit 1
fi

if [[ -z $TARGET_DEVICE ]]; then
    echo "Must specify a target device"
    exit 1
fi

# Function to prompt for confirmation
confirm_overwrite() {
    echo "WARNING: You are about to overwrite the contents of the device at $TARGET_DEVICE."
    echo "This action is irreversible! Are you sure you want to continue?"

    # Prompt user for input
    while true; do
        read -p "Type 'yes' to confirm, or 'no' to cancel: " choice
        case "$choice" in
            [Yy]* )  # If user enters 'yes' or 'y'
                echo "You confirmed that you want to overwrite the device."
                return 0  # Proceed with the action
                ;;
            [Nn]* )  # If user enters 'no' or 'n'
                echo "Operation canceled. No changes were made to the device."
                return 1  # Cancel the action
                ;;
            * )  # If input is anything other than 'yes' or 'no'
                echo "Please type 'yes' to confirm or 'no' to cancel."
                ;;
        esac
    done
}

echo "Building image for $TARGET_IMAGE"
build-image $TARGET_IMAGE

# The image may either be located at a path like
#   /tmp/image-result/iso/*.iso
# or,
#   /tmp/image-result/sd-image/*.img.zst
IMAGE_DIR=/tmp/image-result
IMAGE_PATH=$(find "$IMAGE_DIR/iso" -type f -name "*.iso" -print -quit)

ISO_IMAGE=false
if [[ -n $IMAGE_PATH ]]; then
    ISO_IMAGE=true
else
    IMAGE_PATH=$(find "$IMAGE_DIR/sd-image" -type f -name "*.img.zst" -print -quit)
fi

if [[ -z $IMAGE_PATH ]]; then
    echo "Unable to locate disk image in $IMAGE_DIR"
    exit 1
fi

echo "Image for $TARGET_IMAGE located at $IMAGE_PATH"

# Call the confirmation function
if confirm_overwrite; then
    # Perform the overwrite action (e.g., wiping the device)
    echo "Installing $TARGET_IMAGE onto $TARGET_DEVICE..."
    
    # Example action: Zeroing out the device (this will overwrite it)
    # WARNING: This will destroy all data on the device!
    if [[ $ISO_IMAGE == true ]]; then
        # ISO image can just be dd'd directly
        sudo dd if=$IMAGE_PATH of=$TARGET_DEVICE bs=1M status=progress
    else
        sudo unzstd $IMAGE_PATH -d -o $TARGET_DEVICE
    fi
else
    echo "No changes were made to $TARGET_DEVICE."
fi