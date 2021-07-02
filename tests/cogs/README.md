# Cloud Optimized GeoTIFF (COG) Prototype

In this repository resides a `Dockerfile` which outlines how to pull Earth Observation imagery from the EarthExplore using the `landsatxplore` Python package and transform it into a COG.

Build the Docker container.
```sh
$ docker build -t stc/cog-test --build-arg LANDSAT_USER=YOUR_USERNAME --build-arg LANDSAT_PASSWORD=YOUR_PASSWORD .
```

Run the Docker container.
```sh
$ docker run -dt stc/cog-test
```

Interactively enter the Docker image.
```sh
$ docker exec -it IMAGE_NAME /bin/bash
```