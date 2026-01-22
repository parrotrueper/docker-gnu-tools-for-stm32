#!/usr/bin/env bash

echo "Build the GNU Tools ARM Embedded toolchain for STM32"

set -e

echo "Fetching the sources..."
git clone https://github.com/STMicroelectronics/gnu-tools-for-stm32.git

pushd gnu-tools-for-stm32 || exit 1
  git checkout 14.3.rel1
popd || exit 1


dkr_image_name="gnu-tools-for-stm32-builder"
echo "Building Docker image: ${dkr_image_name}"
docker build -t "${dkr_image_name}" .

echo "Building the toolchain inside the Docker container..."
#shellcheck disable=SC2312
docker run --rm -v "$(pwd)/gnu-tools-for-stm32":/workspace "${dkr_image_name}" bash -c "./build-toolchain.sh --build_type=native --skip_steps=manual,mingw,package_bins,package_sources"

echo "Build completed. The toolchain is available in the 'gnu-tools-for-stm32' directory."
cp -r gnu-tools-for-stm32/pkg ./

echo "Do you want to clean up the source directory? (y/n)"
read -r response
if [[ "${response}" == "y" || "${response}" == "Y" ]]; then
    #shellcheck disable=SC2312
    docker run --rm -v "$(pwd)":/workspace "${dkr_image_name}" bash -c "rm -rf ./gnu-tools-for-stm32"
    echo "Source directory cleaned up."
else
  echo "Source directory retained."
fi

echo "Toolchain is availalbe in the 'pkg' directory."
ls -lh pkg
echo "Done."
