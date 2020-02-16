package requests

import (
	"fmt"
	"io/ioutil"
	"net/http"

	erros "github.com/imthaghost/goclone/errors"
)

// GET request to a url
func GetURL(url string) {
	res, err := http.Get(url)
	erros.Check(err)
	robots, err := ioutil.ReadAll(res.Body)
	defer res.Body.Close()
	erros.Check(err)
	fmt.Printf("%s", robots)
}
