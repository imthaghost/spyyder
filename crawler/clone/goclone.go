package main

import (
	"fmt"
	"os"

	"github.com/gocolly/colly"
)

// check command line arguments
func checkArgs(arg []string) bool {
	if len(arg) == 0 {
		return false
	}
	return true
}

func main() {
	args := os.Args[1:]
	if checkArgs(args) {
		//url := "http://" + args[0]
		// Instantiate default collector
		c := colly.NewCollector()

		// On every a element which has href attribute call callback
		c.OnHTML("a[href]", func(e *colly.HTMLElement) {
			link := e.Attr("href")
			// Print link
			fmt.Printf("Link found: %q -> %s\n", e.Text, link)
			// Visit link found on page
			// Only those links are visited which are in AllowedDomains
			c.Visit(e.Request.AbsoluteURL(link))
		})

		// Before making a request print "Visiting ..."
		c.OnRequest(func(r *colly.Request) {
			fmt.Println("Visiting", r.URL.String())
		})

		// Start scraping on https://hackerspaces.org
		c.Visit("http://" + string(args[0]))
	}
}
