while true; do
  cd /home/shree/lab/bash
  sleep 120
  if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null; then
    echo "server running at $(date)"
    cd /home/shree/server/apache-tomcat-9.0.48/logs
    FILENAME = 'catalina.out'  
    SIZE = $(du -sb $FILENAME | awk '{ print $0}')
    cd $basedir
    if (($SIZE > 2)); then
      echo "catalina.out size exceed"
      cd /home/shree/server/apache-tomcat-9.0.48/logs
      echo $(pwd)
      rm catalina.out
      cd /home/shree/server/apache-tomcat-9.0.48/bin
      ./shutdown.sh
      sleep 60
      ./startup.sh
      cd /home/shree/lab/bash
    fi
  else
    echo "server down at $(date)"
    kill 8080
    cd /home/shree/server/apache-tomcat-9.0.48/logs
    FILENAME = 'catalina.out'
    SIZE = $(du -sb $FILENAME | awk '{ print $0}')

    if (($SIZE > 2147483648)); then
      echo "catalina.out size exceed"
      rm catalina.out
      cd /home/shree/server/apache-tomcat-9.0.48/bin
      ./shutdown.sh
      sleep 60
      ./startup.sh
      cd /home/shree/lab/bash
      return
    fi
    cd /home/shree/server/apache-tomcat-9.0.48/bin
    ./startup.sh
  fi
done
