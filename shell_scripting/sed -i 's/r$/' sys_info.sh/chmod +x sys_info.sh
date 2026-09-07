PID   USER     TIME  COMMAND
    1 root      0:00 {init(docker-des} /init
    6 root      0:00 {init} plan9 --control-socket 6 --log-level 4 --server-fd 7 --pipe-fd 9 --log-truncate
    9 root      0:00 {SessionLeader} /init
   10 root      0:00 {Relay(11)} /init
   11 root      0:00 -sh
   24 root      0:00 sh sys_info.sh
   38 root      0:00 ps aux
