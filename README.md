# CPSC 4840/5840: Default Environment for Assignment 5

This repository shows how one can build an ubuntu 24.04 environment to test or develop a react app with the dependencies required for Assignment 5. The course staff will be using this container to test our apps developed for the course. The apps are expected to run with:
```bash
$ npm install
$ npm run dev
```

## Dependencies

- [Docker](https://docs.docker.com/desktop/setup/install/) -- Needed to create container
- [XQuartz](https://www.xquartz.org/) -- Needed to export display in OSX

## Quick Start

After having both Docker (and XQuarts in OSX), run:

```bash
$ ./build_container.sh react-env:latest # builds container
$ ./run_container.sh react-env:latest <path-to-folder-with-react-app># runs container in interactive mode, exporting display, and setting an optional folder with a react app in the /app directory of the container
```

If the `run_container.sh` script fails due to an errro that says `check if the path is correct and if the daemon is running`, then make sure to open the Docker Desktop app in OSX before running the script.

## Files

- **Dockerfile:** Instructions to build docker image. Creates Ubuntu 24.04 image with nvm 24.12.0, npm 11.7.0, react 19.2.4, and vite 8.0.0
- **build_container.sh:** Convenience script to build container
- **run_container.sh:** Convenience script to run container with Internet access and exporting display
