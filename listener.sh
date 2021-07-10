while true; do
  cd /home/shree/lab/bash/tomcatListener
  sleep 2
  if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null; then
    echo "server running at $(date)"
    cd /home/shree/server/apache-tomcat-9.0.48/logs
    FILENAME='catalina.out'
    SIZE=$(du -sb $FILENAME | awk '{ print $0}')
    if (($SIZE > 2234232230000000000)); then
      echo "catalina.out size exceed"
      cd /home/shree/server/apache-tomcat-9.0.48/logs
      rm catalina.out
      cd /home/shree/server/apache-tomcat-9.0.48/bin
      ./shutdown.sh
      sleep 60
      ./startup.sh
      cd /home/shree/lab/bash/tomcatListener
    else
      cd /home/shree/lab/bash/tomcatListener
    fi
  else
    echo "server down at $(date)"
    cd /home/shree/server/apache-tomcat-9.0.48/logs
    FILENAME='catalina.out'
    SIZE=$(du -sb $FILENAME | awk '{ print $0}')
    echo "size is::"$SIZE
    if (($SIZE > 2147483648000000000)); then
      echo "catalina.out size exceed"
      rm catalina.out
      cd /home/shree/server/apache-tomcat-9.0.48/bin
      ./shutdown.sh
      sleep 60
      ./startup.sh
      curl --ssl-reqd \ 
        --url 'smtps://smtp.gmail.com:465' \
        --user 'email@gmail.com:password' \
        --mail-from 'email@gmail.com' \
        --mail-rcpt 'shreeraione@gmail.com' \
        --upload-file mail.txt
      cd /home/shree/lab/bash/tomcatListener
      return
    fi
    cd /home/shree/server/apache-tomcat-9.0.48/bin
    ./startup.sh
    cd /home/shree/lab/bash/tomcatListener
    curl --ssl-reqd \
      --url 'smtps://smtp.gmail.com:465' \
      --user 'email@gmail.com:Linux_ubuntu1' \
      --mail-from 'rcemail@gmail.com' \
      --mail-rcpt 'rcemail@gmail.com' \
      --upload-file mail.txt
  fi
done
