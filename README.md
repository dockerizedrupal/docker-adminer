# docker-adminer

A [Docker](https://docker.com/) container for [Adminer](http://www.adminer.org/).

## Run the container

Using the `docker` command:

    CONTAINER="adminerdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /adminer/ssl/certs \
      -v /adminer/ssl/private \
      simpledrupalcloud/data:latest

    CONTAINER="adminer" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from adminerdata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/adminer:latest

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-adminer.git "${TMP}" \
      && cd "${TMP}" \
      && sudo fig up

## Connect directly to MySQL server by linking with another Docker container

    CONTAINER="adminerdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /adminer/ssl/certs \
      -v /adminer/ssl/private \
      simpledrupalcloud/data:latest
      
    CONTAINER="adminer" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from adminerdata \
      --link mysqld:mysqld \
      -e SERVER_NAME="localhost" \
      -e MYSQLD_USERNAME="root" \
      -e MYSQLD_PASSWORD="root" \
      -d \
      simpledrupalcloud/adminer:latest

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-adminer.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t simpledrupalcloud/adminer:latest . \
      && cd -

## Back up Adminer data

    sudo docker run \
      --rm \
      --volumes-from adminerdata \
      -v $(pwd):/backup \
      simpledrupalcloud/data:latest tar czvf /backup/adminerdata.tar.gz /adminer/ssl/certs /adminer/ssl/private

## Restore Adminer data from a backup

    sudo docker run \
      --rm \
      --volumes-from adminerdata \
      -v $(pwd):/backup \
      simpledrupalcloud/data:latest tar xzvf /backup/adminerdata.tar.gz

## License

**MIT**
