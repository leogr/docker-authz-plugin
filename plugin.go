package main

import (
	"github.com/docker/go-plugins-helpers/authorization"
)

func newPlugin() (*plugin, error) {
	return &plugin{}, nil
}

type plugin struct {
}

func (p *plugin) AuthZReq(req authorization.Request) authorization.Response {
	return authorization.Response{Allow: true}
}

func (p *plugin) AuthZRes(req authorization.Request) authorization.Response {
	return authorization.Response{Allow: true}
}
