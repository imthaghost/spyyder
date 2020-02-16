package file

import (
	"io/ioutil"

	erros "github.com/imthaghost/goclone/errors"
)

// ReadContents reads contents of a given file path
func ReadContents(path string) []byte {
	content, err := ioutil.ReadFile(path)
	// nil check
	erros.Check(err)
	return content
}
