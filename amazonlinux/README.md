
Got `arm64` Amazon Linux 2 AMI IDs by doing these queries:

```
ARCH=x86_64
ARCH=arm64
#REGION=us-east-1
REGION=us-east-2
PROFILE=jhu-langmead
aws ec2 --profile ${PROFILE} describe-images \
    --owners amazon \
    --filters "Name=name,Values=amzn2-ami-hvm-2.0.????????.?*-${ARCH}-*" \
    'Name=state,Values=available' \
    --region ${REGION}
```

Can also be convenient to pipe output from that command to this.  Can also add 2-digit 0-padded month after the year for more specificity:

```
grep -A 7 -B 1 'Description.*2021.* gp2'
```

Here's a short post on the difference between the AMIs that have `gp2` in the Description versus those that have `ebs` there: https://serverfault.com/questions/913237/difference-between-the-amazon-linux-2-ami.

TODO:
* Update Amazon Linux AMI to more recent if one exists
* Switch to "default bid" for spot
* 

I had to narrow the list of availability zones for us-east-2 because as of 5/17/2020, there do not seem to be m6g.xlarge's available in a or b.

Also, as of 5/17/2020, the spot prices are much better in the us-east-1 AZs versus in us-east-2c.  About $0.08 versus $0.16.