package xpath

import (
	"github.com/antchfx/htmlquery"
)

// Article structure
type Article struct {
	Title    string
	ImageURL string
	Src      string
}

const (
	baseURL = "https://www.wsj.com"
	wsjURL  = "https://www.wsj.com/search/term.html?KEYWORDS="
)

// News ...
func News(ticker string) Article {
	url := wsjURL + ticker
	doc, err := htmlquery.LoadURL(url)
	if err != nil {
		panic(err)
	}
	s2 := htmlquery.FindOne(doc, pricepath)
	title := string(htmlquery.InnerText(s2))
	s3 := htmlquery.Find(doc, imagepath)
	imagelink := string(htmlquery.SelectAttr(s3[0], "src"))
	s4 := htmlquery.Find(doc, articleURL)
	href := string(htmlquery.SelectAttr(s4[0], "href"))
	article := Article{title, imagelink, yahoofinanceURL + href}
	return article
}
