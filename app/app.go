package main

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
)

const (
	version = "1.0"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal("please specify port argument")
	}
	port := os.Args[1]
	r := gin.Default()
	body := gin.H{
		"data":    "welcome",
		"version": version,
	}
	r.GET("/", func(c *gin.Context) {
		hostname, err := os.Hostname()
		if err == nil {
			body["hostname"] = hostname
		} else {
			body["error"] = err.Error()
		}
		c.JSON(http.StatusOK, body)
	})
	r.Run(":" + port)
}
