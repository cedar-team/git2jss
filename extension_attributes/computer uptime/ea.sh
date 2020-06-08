!/bin/sh

days=`uptime | awk '{ print $4 }' | sed 's/,//g'`
num=`uptime | awk '{ print $3 }'`

# now check how long they've been awake
if [ $days = "days" ];

    <result>$num</result>
fi