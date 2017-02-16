#created by: akash
#!/bin/bash
if [ ! -z $1 ]
then
	# if $1 is not null.
	apt_conf=/etc/apt/apt.conf
	env=/etc/environment
	Change_Proxy(){
		if [ ! -z $2 ] && [ ! -z $3 ]
		then
			auth=$2:$3@
		else
			auth=""
		fi
		echo "Switching proxy to 172.31.$1"
		echo "Changing values in $env....."
		sudo sed -i 's/^http_proxy.*$/http_proxy=\"http:\/\/'$auth'172.31.'$1':3128\/\"/' $env
		sudo sed -i 's/^https_proxy.*$/https_proxy=\"https:\/\/'$auth'172.31.'$1':3128\/\"/' $env
		echo "Changing values in $apt_conf....."
		sudo sed -i 's/^Acquire::http::proxy.*$/Acquire::http::proxy \"http:\/\/'$auth'172.31.'$1':3128\/\";/' $apt_conf
		sudo sed -i 's/^Acquire::https::proxy.*$/Acquire::https::proxy \"https:\/\/'$auth'172.31.'$1':3128\/\";/' $apt_conf
		echo "Reloading variables in $env for this Terminal..."
		source $env
	}
	
	if [ $1 == "100.14" ] || [ $1 == "100.25" ] || [ $1 == "100.26" ] || [ $1 == "100.27" ] || [ $1 == "100.28" ] || [ $1 == "100.30" ] || [ $1 == "102.14" ] || [ $1 == "102.29" ] || [ $1 == "103.29" ];
	then
		Change_Proxy $1 "edcguest" "edcguest"
	elif [ $1 == "100.29" ]
	then
		# no auth for his proxy..!
		Change_Proxy $1
	elif [ $1 == "13.135" ] || [ $1 == "9.7" ];
	then
		echo "Proxy exists.. but unknown username & password"
		#Change_Proxy $1 "user" "pass"
	else
		echo -e "No such proxy exists in MNNIT :(\nABORTING...."
	fi
else
	echo "`basename $0`"
	echo -e "\e[4mWARNING:\e[24m This tools requires root permission."
	echo -e "This tool changes the files /etc/apt/apt.conf AND /etc/environment for accessing the network over authenticated proxy servers.\n\e[1m===::: USAGE :::===\e[21m\n$0 x.y\nWhere \"x\" and \"y\" are values in 172.31.x.y\n[Here, 172.31.x.y are the proxies used in MNNIT.]\n\e[1m\e[93m[Example for 172.31.100.14=> $0 100.14]\e[21m"
	exit 0 
fi
