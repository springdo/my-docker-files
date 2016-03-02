#!/bin/sh

cd /

# If config is done, sleep forever to fake service execution
if [ -f "/.cloudant-config-done" ]; then 
    exec tail -f /dev/null
fi

# You can update these values if needed
admin_user="admin"
admin_password="admin"
cloudant_password="admin"
haproxy_user="admin"
haproxy_password="admin"
jmxremote_password="jmxpass"
metrics_user="admin"
metrics_password="admin"
node_host=$(hostname)
node_ip=$(ip route get 1 | awk '{print $NF;exit}')

sed -e "s/\$\$admin_user/$admin_user/g;s/\$\$admin_password/$admin_password/g;s/\$\$cloudant_password/$cloudant_password/g;s/\$\$haproxy_user/$haproxy_user/g;s/\$\$haproxy_password/$haproxy_password/g;s/\$\$jmxremote_password/$jmxremote_password/g;s/\$\$metrics_user/$metrics_user/g;s/\$\$metrics_password/$metrics_password/g;s/\$\$node_host/$node_host/g;s/\$\$node_ip/$node_ip/g" configure.ini.single.template > configure.ini

sv start cloudant nginx clouseau || exit 1

/root/Cloudant/repo/configure.sh -q -c /configure.ini > /var/log/cloudant-install.log

# Regardless of configuration success, we won't retry it
exec touch /.cloudant-config-done