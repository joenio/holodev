# noosfero-dev-environment

Automate setup of Noosfero development environment using Docker
with a Debian Wheezy image.

Create a local "noosfero" image based on Debian Wheezy:

    $ ./create-docker-image.sh

You need to do it only once.

Go to Noosfero source-code

### abre um console para um novo container usando a imagem "noosfero"

    ~/noosfero$ docker run -v $(pwd):/noosfero -i -t noosfero /noosfero/script/development

### abre console para um container em execução

    ~/noosfero$ docker exec -it 984dc591efc7 /bin/bash

