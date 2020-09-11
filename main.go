package main

import (
	"github.com/docker/go-plugins-helpers/authorization"
	"github.com/sirupsen/logrus"
)

func main() {
	logrus.Info("Plugin start")

	plugin, err := newPlugin()
	if err != nil {
		logrus.Fatal(err)
	}

	h := authorization.NewHandler(plugin)

	if err := h.ServeUnix("authz-plugin", 0); err != nil {
		logrus.Fatal(err)
	}
}
