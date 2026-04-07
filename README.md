# Default Environment for Assignment 5

This repository shows how one can build an ubuntu 24.04 environment to test or develop a react app with the dependencies required for Assignment 5.

## Dependencies

- [Docker](https://docs.docker.com/desktop/setup/install/) -- Needed to create container
- [XQuartz](https://www.xquartz.org/) -- Needed to export display in OSX

## Quick Start

After having both Docker (and XQuarts in OSX), run:

```bash
$ ./build_container.sh # builds container
$ ./run_container.sh # runs container in interactive mode
```

## Files

- **Dockerfile:** Instructions to build docker image. Creates Ubuntu 24.04 image with nvm 24.12.0, npm 11.7.0, react 19.2.4, and vite 8.0.0
- **build_container.sh:** Convenience script to build container
- **run_container.sh:** Convenience script to run container with Internet access and exporting display
