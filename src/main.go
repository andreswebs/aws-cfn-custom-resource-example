package main

import (
	"context"
	"log"

	"encoding/json"

	"github.com/aws/aws-lambda-go/cfn"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(cfn.LambdaWrap(crHandler))
}

// crHandler handles Custom Resource events from CloudFormation
func crHandler(ctx context.Context, event cfn.Event) (string, map[string]interface{}, error) {

	log.Print(printJSON(event))

	name, _ := event.ResourceProperties["Name"].(string)

	data := map[string]interface{}{
		"Name": name,
	}

	return name, data, nil
}

func printJSON(i interface{}) string {
	s, _ := json.Marshal(i)
	return string(s)
}
