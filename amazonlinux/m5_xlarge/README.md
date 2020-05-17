

Got `x86_64` Amazon Linux 2 AMI IDs by doing these queries:

```
for region in us-east-1 us-east-2 ; do
    aws ec2 describe-images \
        --owners amazon \
        --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????.?*-x86_64-*' \
        'Name=state,Values=available' \
        --region ${region}
done
```
