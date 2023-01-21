package main

import (
	"fmt"

	"github.com/matg94/portfolio-site/controller"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
)

func SetupGinServer() {
	router := gin.Default()
	router.Use(cors.Default())
	router.Use(static.Serve("/", static.LocalFile("./build", true)))
	router.GET("/hello", controller.GetHello)
	router.Run()
}

func main() {
	SetupGinServer()
	fmt.Println("Test")
}
