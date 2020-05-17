

Got `arm64` Amazon Linux 2 AMI IDs by doing these queries:

```
for region in us-east-1 us-east-2 ; do
    aws ec2 describe-images \
        --owners amazon \
        --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????.?*-arm64-*' \
        'Name=state,Values=available' \
        --region ${region}
done
```

I had to narrow the list of availability zones for us-east-2 because as of 5/17/2020, there do not seem to be m6g.xlarge's available in a or b.

Also, as of 5/17/2020, the spot prices are much better in the us-east-1 AZs versus in us-east-2c.  About $0.08 versus $0.16.