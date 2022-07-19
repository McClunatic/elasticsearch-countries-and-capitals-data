# syntax=docker/dockerfile:1
FROM elasticsearch:8.3.2

# See: https://stackoverflow.com/questions/35526532/how-to-add-an-elasticsearch-index-during-docker-build

# Make elasticsearch write to /data (not declared as a volume in elasticsearch image)
# RUN mkdir /data \
#     && chown -R elasticsearch:elasticsearch /data \
RUN echo 'es.path.data: /data' >> config/elasticsearch.yml \
    && echo 'path.data: /data' >> config/elasticsearch.yml

# Copy local resources
ADD elasticsearch-countries-and-capitals-data.tar.xz /tmp

COPY import-data.sh /tmp

# Get utilities: wait-for-it and node
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh \
    /tmp/wait-for-it.sh

# See README: wget this first to add it to local context
ADD node-v16.16.0-linux-x64.tar.xz /tmp

# Add node to PATH
ENV PATH="/tmp/node-v16.16.0-linux-x64/bin:${PATH}"

# Add elasticdump to PATH via node global install
RUN npm install --location=global elasticdump

RUN /docker-entrypoint.sh elasticsearch -p /tmp/epid & \
    /bin/bash /tmp/wait-for-it.sh -t 0 localhost:9200 -- /tmp/import-data.sh; \
    kill $(cat /tmp/epid) && wait $(cat /tmp/epid); \
    exit 0;