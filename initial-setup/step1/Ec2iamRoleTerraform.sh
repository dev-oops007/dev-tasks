
#it is optional , if yu have terraform instance in your aws cloud 
#them you can use it 
# Variables
ROLE_NAME="TerraformIAMRole"
POLICY_NAME="TerraformS3AccessPolicy"
BUCKET_NAME="dev-test-tf-state"
OBJECT_KEY_PATH="terraform"

# Create the IAM role trust policy
cat > trust-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com" # Update this if needed for a specific service
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

# Create the IAM role
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://trust-policy.json

# Create the IAM policy for S3 access
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

# Create the IAM policy
aws iam create-policy --policy-name $POLICY_NAME --policy-document file://s3-policy.json

# Attach the policy to the role
POLICY_ARN=$(aws iam list-policies --query "Policies[?PolicyName=='$POLICY_NAME'].Arn | [0]" --output text)
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN

# Output the role details
aws iam get-role --role-name $ROLE_NAME

