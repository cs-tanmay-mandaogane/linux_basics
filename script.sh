#!/bin/bash 

one(){
    read -p "Enter word to search : " word
    grep -c $word /var/log/messages
}

two(){
    if [[ ! -e /home/csadmin/test.log ]]; then
    echo "creating test.log as it was absent"
    touch /home/csadmin/test.log
    chmod +rwx test.log
    fi

    echo "copying 100 lines from /var/log/messages to /home/csadmin/test.log"
    tail -n 100 /var/log/messages > /home/csadmin/test.log
}   

three(){
    echo "changing user and permission of test.log file to csadmin user"
    chown -v csadmin /home/csadmin/test.log
    chmod u+rwx /home/csadmin/test.log
}

four(){
    read word1
    read word2
    echo "changing occurences of $word1 to $word2 in file test.log"
    sed "s/$word1/$word2/g" /home/csadmin/test.log
}

five(){
    read -p "enter user of instance : " user  
    read -p "enter your IP address of instance : " IP 
    #read -p "enter your password" pass
    read -p "enter path to copy " path
    scp /home/csadmin/test.log $user@$IP:$path
}

show_menus() {
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. print count of lines having cyops-auth in /var/log/messages"
	echo "2. copy the last 100 lines from the /var/log/messages to /home/csadmin/test.log file"
    echo "3. change the permission of the above test.log file to csadmin user"
    echo "4. from the test.log file replace all the occurrence of a word"
    echo "5. copy the file from 4th step to another linux machine"
	echo "6. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 6] " choice
	case $choice in
		1) one ;;
		2) two ;;
        3) three ;;
        4) four ;;
        5) five ;;
		6) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

while true
do
	show_menus
	read_options
done