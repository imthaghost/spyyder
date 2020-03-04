package collector

import (
	"fmt"

	"github.com/gocolly/colly"
)

const (
	baseURL = "https://www.wsj.com"
	wsjURL  = "https://www.wsj.com/search/term.html?KEYWORDS="
)

// Crawler ustalized colly as a collector
func Crawler(ticker string) {
	// Instantiate default collector
	c := colly.NewCollector(
		colly.Async(true),
	)
	// On every a element which has href attribute call callback
	c.OnHTML("a[href]", func(e *colly.HTMLElement) {
		link := e.Attr("href")
		// Print link
		fmt.Printf("Link found: %q -> %s\n", e.Text, link)
	})
	// Before making a request print "Visiting ..."
	c.OnRequest(func(r *colly.Request) {
		fmt.Println("Visiting", r.URL.String())
	})
	// Start scraping
	c.Visit(wsjURL + ticker)
	c.Wait()
}
