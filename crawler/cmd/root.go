package cmd

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

var (
	// Used for flags.
	cfgFile     string
	userLicense string

	rootCmd = &cobra.Command{
		Use:   "goclone",
		Short: "goclone is a fast website cloner",
		Long: `
		 Easily copy websites to your computer with goclone
		 goclone is a utility that allows you to download a website
		 from the Internet to a local directory, building recursively
		 all directories, getting html, images, and other files from 
		 the server to your computer.
		 
		 See Full Documentation: https://github.com/imthaghost/goclone`,
		Args: cobra.MaximumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println(strings.Join(args, " "))
		},
	}
)

// Execute executes the root command.
func Execute() error {
	return rootCmd.Execute()
}

func init() {

	//rootCmd.PersistentFlags().StringP("author", "a", "YOUR NAME", "author name for copyright attribution")
	// rootCmd.AddCommand(addCmd)
	// rootCmd.AddCommand(initCmd)
}

func initConfig() {
	fmt.Println("Initial configuration")
}
