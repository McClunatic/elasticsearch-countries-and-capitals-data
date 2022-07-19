# elasticsearch-countries-and-capitals data

This repository hosts the data preloaded in the
`deepset/elasticsearch-countries-and-capitals` Docker image, recovered using
[elasticsearch-dump](https://github.com/elasticsearch-dump/elasticsearch-dump).
The name of the Elasticsearch index for the above container is `document`.

## Building the container

As a prerequisite step, download the Node.js LTS v16.16.0 Linux binaries
into the local directory, the Docker context:

```sh
$ wget https://nodejs.org/dist/v16.16.0/node-v16.16.0-linux-x64.tar.xz
```

> Why do this? To take advantage of `xz` decompression that `ADD` does
> automatically for local files. Alternatively, this could be handled
> by chaining `curl` and `tar` in the Dockerfile, but that requires `xz`
> be in the image. This approach may ultimately be preferred, but to
> keep the image size small, would require a multi-stage build.

Run docker build and tag appropriately:

```sh
$ docker build -t <tag> .
```