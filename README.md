# Logrotate to S3

Configuration for logrotate to upload files to S3 for future processing.

## Setup

Install aws cli

```sh
pip install awscli
```

Move s3upload.sh to `/etc/logrotate.d/s3/s3upload.sh`

edit /etc/logrotate.d/nginx

```
/var/log/nginx/*.log {
        daily
        missingok
        rotate 14
        compress
        delaycompress
        notifempty
        create 0640 www-data adm
        dateext
        sharedscripts
        prerotate
                if [ -d /etc/logrotate.d/httpd-prerotate ]; then \
                        run-parts /etc/logrotate.d/httpd-prerotate; \
                fi \
        endscript
        postrotate
                /etc/logrotate.d/s3/s3upload.sh
                invoke-rc.d nginx rotate >/dev/null 2>&1
        endscript
}
```