<div align='center'>

# inception
#### _Containarised wordpress via docker-compose_

[The project](#the-project) ~
[Setup the project](#setup-the-project)

</div>

## The project
This project allows setting up a WordPress instance extremely fast and
with minimal configuration by using `docker-compose`.

Two networks are created so direct access to the `db` is possible from
the `wordpress` instance, and the `wordpress` instance can only be accessed
from the `nginx` webserver.

## Setup the project
1. Clone the repository
2. Edit your `/etc/hosts` and add `127.0.0.1 mmartin.42.fr`
3. Copy the file `srcs/env.example` to `srcs/.env` and change the variables
4. `make`

A website must be available to you under `mmartin.42.fr` with a fully configured
wordpress instance.
