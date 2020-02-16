package file

import (
	"os"

	erros "github.com/imthaghost/goclone/errors"
)

// MakeProject initialize project folder
func MakeProject(dir string) {
	if _, err := os.Stat(dir); os.IsNotExist(err) {
		err = os.MkdirAll(dir, 0755)
		erros.Check(err)
	}
}
