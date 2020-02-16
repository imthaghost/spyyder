package erros

// error checker
func Check(e error) {
	if e != nil {
		panic(e)
	}
}
