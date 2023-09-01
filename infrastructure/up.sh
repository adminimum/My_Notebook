#!/bin/bash

declare -A data_outputs_map

key_name=""
private_ip_KubeMaster=""
private_ip_KubeNode=""
private_ip_MysqlServer=""
private_ip_WebServer=""
public_ip_WebServer=""
s3_bucket_dom_name=""
s3_bucket_name=""
vpc_id=""
aws_iam_s3_user=""

# Parser data from terraform show to map
function _parser(){
    if [ $(echo ${1} | grep "=") ]
    then
        _key_name=$(echo $1 | cut -d" " -f1)
        _value=$(echo $1 | cut -d'"' -f2)
        data_outputs_map["$_key_name"]="$_value"
    fi
}

# Terraform applying 
terraform apply -var="ssh_key=$(cat ~/.ssh/id_rsa.pub)"
if [ "$?" -ne '0' ]
then
    echo "[ERR] Error while executing terraform apply" > &2 
    exit 1
fi

# Parsing data from outputs of terraform
IFS=$'\n'
for kv_line in $(terraform show)
do
_parser $kv_line
done
IFS=$" "

# Create access and secret keys for the user
user_s3_creds=`aws iam create-access-key --user-name ${data_outputs_map["aws_iam_s3_user"]}`
echo $user_s3_creds > data/user_s3_creds.json
access_key_s3=$(echo $user_s3_creds | jq -r '.AccessKey.AccessKeyId')
secret_key_s3=$(echo $user_s3_creds | jq -r '.AccessKey.SecretAccessKey')

# Generating config file for pushing data to the servers ansible/secrets/aws_s3_access_configure
echo "[default]" > ansible/secrets/aws_s3_access_configure 
echo "aws_access_key_id = ${access_key_s3}" >> ansible/secrets/aws_s3_access_configure
echo "aws_secret_access_key = ${secret_key_s3}" >> ansible/secrets/aws_s3_access_configure

