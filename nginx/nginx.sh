#!/bin/bash
##################################################
# AUTHOR: Neo <netkiller@msn.com>
# WEBSITE: http://www.netkiller.cn
# Description��zabbix ͨ�� status ģ���� nginx
# Note��Zabbix 3.2
# DateTime: 2016-11-22
##################################################

HOST="localhost"
PORT="80"

function check() {
	/sbin/pidof nginx | wc -l 
}

function active() {
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Active' | awk '{print $NF}'
}
function accepts() { 
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| awk NR==3 | awk '{print $1}'
}
function handled() { 
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| awk NR==3 | awk '{print $2}'
}
function requests() {
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| awk NR==3 | awk '{print $3}'
}
function reading() { 
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Reading' | awk '{print $2}'
}
function writing() { 
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Writing' | awk '{print $4}'
}
function waiting() { 
	/usr/bin/curl -s "http://$HOST:$PORT/status/" 2>/dev/null| grep 'Waiting' | awk '{print $6}'
}

case "$1" in
	check)
		check
		;;
	active)
		active
		;;
	accepts)
		accepts
		;;
	handled)
		handled
		;;
	requests)
		requests
		;;
	reading)
		reading
		;;
	writing)
		writing
		;;
	waiting)
		waiting
		;;

	*)
		echo $"Usage $0 {check|active|accepts|handled|requests|reading|writing|waiting}"
		exit		
esac