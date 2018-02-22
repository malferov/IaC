package main

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
)

func main() {
	port := os.Args[1]
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"data": "welcome", "status": http.StatusOK})
	})
	r.GET("/health", func(c *gin.Context) {
		body := map[string]interface{}{}
		req, err := http.NewRequest("GET", "http://localhost:9200/_cluster/health", nil)
		if err != nil {
			log.Println(err)
		}
		req.SetBasicAuth("elastic", "changeme")
		client := &http.Client{}
		resp, err := client.Do(req)
		if err != nil {
			log.Println(err)
		}
		defer resp.Body.Close()
		err = json.NewDecoder(resp.Body).Decode(&body)
		if err != nil {
			log.Println(err)
		}
		c.JSON(http.StatusOK, body)
	})
	r.Run(":" + port)
}
