# docker-authz-plugin
Docker Authz Plugin template

This is a template project to for creating an [access authorization plugin](https://docs.docker.com/engine/extend/plugins_authorization/) for the Docker Engine. 

Note **this plugin does exactly nothing**. It's just an empty template.

## Why?

Plugins were introduced in the Docker Engine in 1.10, as a v1 implementation ([legacy plugins](https://docs.docker.com/engine/extend/legacy_plugins/)), and further extended in 1.13, as a v2 implementation ([managed plugins](https://docs.docker.com/engine/extend/)).

Because I needed to create a **very basicy authz plugin** from scratch but I had found many different (and complex) ways to do that so I decided to create a very simple and reusable template.

### Goals
- To be useful for creating [managed plugins](https://docs.docker.com/engine/extend/)
- To use the [docker's go-plugins-helpers](https://github.com/docker/go-plugins-helpers) library
- To use Go modules

### Non-goals
- To implement a [legacy plugin](https://docs.docker.com/engine/extend/legacy_plugins/)
- To implement other type of plugins 
- To implement any specific logic

## Usage

First, prepare your project:
- Click on the green "Use this template" button above
- Rename any occurence of `leogr/docker-authz-plugin` as you need
- Edit `plugin.go` implemeting your plugin logic 

Then create and install your plugin:
- `make create` builds the plugin and add it to your local Docker
- `make enable` tells Docker to enable the plugin
> If you want to to use a remote registry, use `docker plugin push` and `docker plugin install` instead of `make enable`

With the plugin installed and enabled, the Docker daemon needs to be configured to make use of the plugin. This can be done by editing the daemon's configuration file (eg. `/etc/docker/daemon.json`):
```json
{
    "authorization-plugins": ["leogr/docker-authz-plugin:dev"]
}
```
> Please, use your plugin name if you had renamed it.

Finally, you need to restart the daemon.

If you're using `systemctl` just run: 
```shell
$ systemctl restart docker.service
```
Otherwise, a rude alternative is:
```shell
$ sudo kill -HUP $(pidof dockerd)
```

Enjoy!