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

IFS=$'\n'
for kv_line in $(terraform show)
do
_parser $kv_line
done
IFS=$" "

# Deleting keys of s3_access_user
access_s3_key_id=$(aws iam list-access-keys --user-name ${data_outputs_map["aws_iam_s3_user"]} | jq -r '.AccessKeyMetadata[0].AccessKeyId')
aws iam update-access-key --access-key-id $access_s3_key_id --status Inactive --user-name ${data_outputs_map["aws_iam_s3_user"]}
aws iam delete-access-key --access-key-id $access_s3_key_id --user-name ${data_outputs_map["aws_iam_s3_user"]}

# Terraform destroying
terraform destroy -var="ssh_key=$(cat ~/.ssh/id_rsa.pub)"
if [ "$?" -ne '0' ]
then
    echo "[ERR] Error while executing terraform destroy" > &2 
    exit 1
fi