#!/bin/bash

# Variables
USER_NAME="TerraformBotUser"
POLICY_NAME="TerraformS3AccessPolicy"
BUCKET_NAME="dev-test-tf-state"
OBJECT_KEY_PATH="terraform"

echo "Create IAM user with no console access"
#aws iam create-user --user-name $USER_NAME

# Create access keys for the user
#aws iam create-access-key --user-name $USER_NAME > access-keys.json

echo "Access keys saved to access-keys.json. Keep them secure."

# Create the IAM policy for S3 backend access

cat > s3-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::$BUCKET_NAME",
      "Condition": {
        "StringLike": {
          "s3:prefix": ["$OBJECT_KEY_PATH/*"]
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::$BUCKET_NAME/$OBJECT_KEY_PATH/*"
    }
  ]
}
EOF 


echo " Creating the policy"
aws iam create-policy --policy-name $POLICY_NAME --policy-document file://s3-policy.json

echo " Attach the policy to the user"
POLICY_ARN=$(aws iam list-policies --query "Policies[?PolicyName=='$POLICY_NAME'].Arn | [0]" --output text)
echo " $POLICY_ARN "

aws iam attach-user-policy --user-name $USER_NAME_NAME --policy-arn $POLICY_ARN
echo "policy attached"

echo "Verify the user and policy attachment"
aws iam get-user --user-name $USER_NAME

echo "list attached policies on role"
aws iam list-attached-user-policies --user-name $USER_NAME
