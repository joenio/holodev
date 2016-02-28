[![Build Status](https://travis-ci.org/lappis-tools/holodev.svg?branch=master)](https://travis-ci.org/lappis-tools/holodev)

# holodev

## Um holodeck para desenvolvedores de software

Ferramenta para facilitar criação de Linux Containers para desenvolvimento
em sistemas Debian.

O nome `holodev` é uma referência ao Holodeck de Star Trek:

* http://en.wikipedia.org/wiki/Holodeck

Distribuições GNU/Linux suportadas:

* Debian
  * Squeezy (não suportado)
  * Wheezy (não suportado)
  * Jessie
  * Stretch
* Ubuntu
  * Precise (não suportado)
  * Trusty
  * Utopic (não testado)
  * Vivid
  * Wily

## sudo

Infelizmente o suporte a "unprivileged containers" no Debian Jessie
não é maduro o suficiente, então o `holodev` precisa do `sudo` para
criar e executar "privileged containers".

## Instalando em Debian Jessie ou testing

Adicione o seguinte repositório ao sources.list:

    deb http://debian.joenio.me unstable/

Baixe a chave do repositório Debian:

    # wget -O - http://debian.joenio.me/signing.asc | apt-key add -

E instale:

    # apt-get update
    # apt-get install holodev

## Usando

O script `holodev` cria Linux Containers usando o diretório corrente mais o
branch `git` para compor o nome do container, ele cobre o cenário onde para
cada projeto (diretório) existe um Linux Container, de forma que não seja
necessário instalar dependencias de desenvolvimento em seu sistema real.

Exemplo, no diretório `noosfero` na branch `master` será criado um container
chamado `noosfero-master`:

    ~/src/noosfero$ holodev create

O container `noosfero-master` será criado com Debian Wheezy (padrão), caso
deseje informar outra versão do Debian basta usar a opção `--release`:

    ~/src/noosfero$ holodev create --release jessie

Caso não deseje utilizar o branch `git` para compor o nome do container use a
opção `--no-branch`:

    ~/src/noosfero$ holodev create --no-branch

Criará um container chamado `noosfero`.

## Desenvolvimento

O `holodev` possui uma pequena suíte de testes implementada com base no
`shunit2`:

* http://github.com/kward/shunit2

Para rodar estes testes é preciso instalar o `vagrant`, `virtualbox` e executar
o comando `vagrant up`. Em alguns casos pode ser necessário instalar o
`virtualbox-guest-utils` e executar o seguinte:

    dpkg-reconfigure virtualbox-dkms

Utilize o script `development-setup.sh` (como root ou sudo) para instalar
as dependencias de desenvolvimento em seu sistema.

## Autor

* Joenio Costa <joenio@colivre.coop.br>

## Licença

GNU GPLv2+
