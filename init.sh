#!/bin/bash
echo 65535 > /proc/sys/net/core/somaxconn;
echo 0 > /proc/sys/net/ipv4/tcp_syncookies;