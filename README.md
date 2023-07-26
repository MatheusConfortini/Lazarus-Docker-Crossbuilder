# Lazarus-Docker-Crossbuilder
Docker image of Lazarus for easy cross-compilation Windows and Linux x86/x64.

## Description

This Docker image is based on Ubuntu and comes pre-installed with Lazarus, FPC (Free Pascal Compiler), JSign (for signing Windows executables), and other necessary packages for cross-compilation. It was created out of the need to automate the compilation process for a project and streamline the release process. The image supports cross-compilation for Windows and Linux x86x64 platforms and works seamlessly with ACBR.

## Getting Started

To use this Docker image, you can pull it from Docker Hub:

https://hub.docker.com/r/matheusconf/lazarus-crossbuilder

## How to Use

To compile your Lazarus projects and packages, simply use the following command:

lazbuild <your-project-file.lpi>


