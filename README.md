# holodev

## Um holodeck para desenvolvedores de software

Ferramenta para facilitar criação de Linux Containers para desenvolvimento
em sistemas Debian.

O nome `holodev` é uma referência ao Holodeck de Star Trek:

* https://en.wikipedia.org/wiki/Holodeck

## sudo

Infelizmente o suporte a "unprivileged containers" no Debian Jessie
não é maduro o suficiente, então o `holodev` precisa do `sudo` para
criar e executar "privileged containers".

## Instalando em Debian Jessie ou testing

Adicione o seguinte repositório ao sources.list:

    deb http://debian.joenio.me unstable/

Baixe a chave do repositório Debian:

    # wget -O - http://debian.joenio.me/signing.asc | apt-key add -

E instale o pacote `holodev`:

    # apt-get update
    # apt-get install holodev

## Usando

O script `holodev` cria Linux Containers usando o nome do diretório corrente,
ele atende a situação onde para cada projeto (diretório) tenho um container
para desenvolvimento, de forma que eu não poluo meu sistema com dependencias
de desenvolvimento.

Se estou no diretório chamado `noosfero` será criado um container de mesmo
nome, exemplo:

    ~/src/noosfero$ holodev create

Um container chamado `noosfero` será criado usando Debian Wheezy (padrão),
se eu quero usar Jessie ao invés de Wheezy devo informar como parâmetro:

    ~/src/noosfero$ holodev create jessie

## Autor

* Joenio Costa <joenio@colivre.coop.br>

## Licença

GNU GPLv2+
