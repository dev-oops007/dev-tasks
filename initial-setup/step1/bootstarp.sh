# I generally handle this situation by creating a simple bootstrap shell script. 
# It creates things like:

# The s3 bucket for state storage
# Adds versioning to said bucket
# a terraform IAM user and group with certain policies I'll need for terraform builds

