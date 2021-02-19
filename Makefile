.PHONY: test build package deploy publish

ifndef stack
STACK_NAME := custom-example
endif

test:
	go test ./src

build:
	sam build

package: build
	sam package \
  	--template-file .aws-sam/build/template.yaml \
  	--output-template-file .aws-sam/build/packaged.yaml \
  	--s3-bucket "${S3_BUCKET}" \
		--s3-prefix "${STACK_NAME}"

publish: package
	sam publish \
    --template .aws-sam/build/packaged.yaml
