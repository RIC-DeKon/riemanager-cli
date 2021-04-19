#!/bin/bash
# RIECOIN MANAGER v01

# RIECOINCORE
core_version="riecoin-fd6b6bbe2468"
core_x8664="https://github.com/riecointeam/riecoin/releases/download/v0.21.0/riecoin-fd6b6bbe2468-x86_64-linux-gnu.tar.gz"
core_aarch64="https://github.com/riecointeam/riecoin/releases/download/v0.21.0/riecoin-fd6b6bbe2468-aarch64-linux-gnu.tar.gz"
core_arm="https://github.com/riecointeam/riecoin/releases/download/v0.21.0/riecoin-fd6b6bbe2468-arm-linux-gnueabihf.tar.gz"
core_riscv64="https://github.com/riecointeam/riecoin/releases/download/v0.21.0/riecoin-fd6b6bbe2468-riscv64-linux-gnu.tar.gz"

# BOOTSTRAP
bootstrap_main="https://riecoin.dev/files/w/images/6/61/Riecoin_Blockchain.zip"
strap_zip="Riecoin_Blockchain.zip"
strap_version="Riecoin_1486806_2021-04-05"
bootstrap_test="https://riecoin.dev/files/w/images/0/03/Riecoin_Testnet_Blockchain.zip"
straptest_zip="Riecoin_Testnet_Blockchain.zip"
straptest_version="Riecoin_Testnet_93526_2021-04-05"

# RIEMINER
rieminer_http="https://github.com/Pttn/rieMiner/releases/download/0.92/rieMiner0.92dDeb64"
rieminer_version="rieMiner0.92dDeb64"

# DISK LIMIT
disk_core="2097152"
disk_strap="4194304"

# CPU OS
os_name=$(lsb_release -is)
os_codename=$(lsb_release -cs)
os_mode="unknown"

cpu_name=$(uname -m)
cpu_architecture="unknown"
cpu_mode="unknown"

if [ .$cpu_name = .'armv7l' ]; then
	os_mode="32"
	cpu_mode="32"
	cpu_architecture="arm"
	core_address="$core_arm"
	core_file="riecoin-fd6b6bbe2468-arm-linux-gnueabihf.tar.gz"
elif [ .$cpu_name = .'armv8l' ]; then
	os_mode="unknown"
	cpu_mode="64"
	cpu_architecture="arm"
	core_address="$core_arm"
	core_file="riecoin-fd6b6bbe2468-arm-linux-gnueabihf.tar.gz"
elif [ .$cpu_name = .'aarch64' ]; then
	os_mode="64"
	cpu_mode="64"
	cpu_architecture="arm"
	core_address="$core_aarch64"
	core_file="riecoin-fd6b6bbe2468-aarch64-linux-gnu.tar.gz"
elif [ .$cpu_name = .'riscv64' ]; then
	os_mode="64"
	cpu_mode="64"
	cpu_architecture="arm"
	core_address="$core_riscv64"
	core_file="riecoin-fd6b6bbe2468-riscv64-linux-gnu.tar.gz"
elif [ .$cpu_name = .'i386' ]; then
	os_mode='32'
	if [ .$(grep -o -w 'lm' /proc/cpuinfo | head -n 1) = .'lm' ]; then
		cpu_mode="64"
	else
		cpu_mode="32"
	fi
	cpu_architecture='x86'
elif [ .$cpu_name = .'i686' ]; then
	os_mode='32'
	if [ .$(grep -o -w 'lm' /proc/cpuinfo | head -n 1) = .'lm' ]; then
		cpu_mode="64"
	else
		cpu_mode="32"
	fi
	cpu_architecture="x86"
elif [ .$cpu_name = .'x86_64' ]; then
	os_mode="64"
	core_address="$core_x8664"
	core_file="riecoin-fd6b6bbe2468-x86_64-linux-gnu.tar.gz"
	if [ .$(grep -o -w 'lm' /proc/cpuinfo | head -n 1) = .'lm' ]; then
		cpu_mode="64"
	else
		cpu_mode="32"
	fi
	cpu_architecture="x86"
else
	echo "You are using an unsupported cpu "$cpu_name""
	exit
fi

# AUTOINSTALL 1/2
DIRECTORY=$PWD
if [ "$PWD" != ""$HOME"/RIEMANAGER" ]; then
clear
whiptail --clear --title "AUTO-INSTALL" --msgbox "             WELCOME ON\nAUTO-INSTALLATION OF RIECOIN MANAGER\n RIEMANAGER WILL SELF-INSTALL IN : \n       "$HOME"/RIEMANAGER/" 10 40 0
[ -d "$HOME"/RIEMANAGER/ ] && [ -e "$HOME"/RIEMANAGER/riemanager.sh ] && rm "$HOME"/RIEMANAGER/riemanager.sh
[ ! -d "$HOME"/RIEMANAGER/ ] && mkdir -p "$HOME"/RIEMANAGER/
cp "$PWD"/riemanager.sh "$HOME"/RIEMANAGER/ 
cd "$HOME"/RIEMANAGER/ && chmod u+x riemanager.sh && cd "$DIRECTORY"
[ -e riemanager.sh ] && rm riemanager.sh && cd "$HOME"/RIEMANAGER/ && ./riemanager.sh
elif [ "$PWD" = ""$HOME"/RIEMANAGER" ]; then



# MENU CORE
start_core(){

install_core(){
if [[ $disk_free -lt "$disk_core" ]]; then
whiptail --clear --title "ERROR" --msgbox "NOT ENOUGH SPACE NEED 2GO FOR INSTALL" 7 41 0
else
if : >/dev/tcp/8.8.8.8/53; then
	clear
		sudo cd ~/ > /dev/null 2>&1
		clear;
	{
    	sleep 0.5
    	echo -e "XXX\n0\nVERIFY AND INSTALL SYSTEM UPDATE... \nXXX"
		sudo apt-get update && sudo apt-get upgrade -y
		clear;	
    	sleep 1
    	echo -e "XXX\n20\nVERIFY AND INSTALL SYSTEM UPDATE... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n20\nINSTALL WGET... \nXXX"
		sudo apt-get install -y wget
		clear;
    	sleep 1
    	echo -e "XXX\n40\nINSTALL WGET... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n40\nDOWNLOAD RIECOIN CORE... PLEASE WAIT.\nXXX"
	cd /tmp/
	exit=0 && wget -q "$core_address" || exit=1
   		if [ "$exit" != "0" ]; then
		echo -e "XXX\n100\nDOWNLOAD RIECOIN CORE ERROR, CHECK YOUR INTERNET CONNECTION\nXXX"
		sleep 7
		[ -e "$core_file" ] && rm "$core_file"
  		else
    	sleep 1
    	echo -e "XXX\n60\nDOWNLOAD RIECOIN CORE... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n60\nINSTALL FILES... \nXXX"
	tar xvzf "$core_file" 2>&1
	cd "$core_version"/bin/
	sudo mv * /usr/bin/
	cd ..
	cd include
	sudo mv * /usr/include/
	cd ..
	cd lib
	sudo mv * /usr/lib/
	cd ..
	cd share/man/man1/
	sudo mv * /usr/share/man/man1/
    	sleep 1
    	echo -e "XXX\n80\nINSTALL FILES... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n80\nCLEAN INSTALL FILES... \nXXX"
	cd /tmp/
	rm -fr "$core_version"
	rm "$core_file"
    	sleep 1
    	echo -e "XXX\n99\nCLEAN INSTALL FILES... Done.\nXXX"
    	sleep 0.5
 	echo -e "XXX\n100\nINSTALLATION FINISHED\nXXX"
  	sleep 1
		fi
	} | whiptail --title "RIECOIN CORE INSTALLATION" --gauge "Please wait while installing" 6 60 0
else
whiptail --clear --title "ERROR" --msgbox "PLEASE CHECK YOUR INTERNET CONNECTION" 7 41 0
clear
fi
fi
}
#BOOTSTRAP MAINNET
install_strap(){
if [[ $disk_free -lt "$disk_strap" ]]; then
whiptail --clear --title "ERROR" --msgbox "NOT ENOUGH SPACE NEED 4GO FOR INSTALL" 7 41 0
else
[ -d "$HOME"/.riecoin/ ] && whiptail --clear --title "BOOTSTRAP RIECOIN CORE" --msgbox "    MAINNET DATA WAS FOUNDED. \n  IF YOU CONTINUE, ALL EXISTING\n   MAINNET DATA WILL BE ERASED.\nIF YOU NEED TO SAVE YOUR WALLET BEFORE STARTING, CHOOSE NO AFTER." 11 37 
if (whiptail --title "BOOTSTRAP RIECOIN CORE" --yesno "    DOWNLOAD MAINNET BLOCKCHAIN ?" 7 40); then
	if : >/dev/tcp/8.8.8.8/53; then
	clear
		sudo cd ~/ > /dev/null 2>&1
	clear
	{
    	sleep 0.5
    	echo -e "XXX\n0\n    VERIFY AND INSTALL SYSTEM UPDATE... PLEASE WAIT.\nXXX"
		sudo apt-get update && sudo apt-get upgrade -y > /dev/null 2>&1
    	sleep 1
    	echo -e "XXX\n20\n    VERIFY AND INSTALL SYSTEM UPDATE... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n20\n    INSTALL WGET... \nXXX"
		sudo apt-get install -y wget > /dev/null 2>&1
    	sleep 1
    	echo -e "XXX\n30\n    INSTALL WGET... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n30\n    INSTALL UNZIP... \nXXX"
		sudo apt-get install -y unzip > /dev/null 2>&1
    	sleep 1
    	echo -e "XXX\n40\n    INSTALL UNZIP... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n40\n    DOWNLOAD MAINNET BOOTSTRAP... PLEASE WAIT.\nXXX"
	cd /tmp/
	exit=0 && wget -q $bootstrap_main || exit=1
   		if [ "$exit" != "0" ]; then
		echo -e "XXX\n100\n    DOWNLOAD BOOTSTRAP ERROR, CHECK YOUR INTERNET CONNECTION\nXXX"
		sleep 7
		[ -e $strap_zip ] && rm $strap_zip
  		else
 	sleep 1
    	echo -e "XXX\n60\n    DOWNLOAD BOOTSTRAP... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n60\n    UNZIP FILES... \nXXX"
	unzip $strap_zip
    	sleep 1
    	echo -e "XXX\n80\n    UNZIP FILES... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n80\n    INSTALL FILES... \nXXX"
	cd $strap_version
	[ ! -d "$HOME"/.riecoin ] && mkdir -p "$HOME"/.riecoin
	mv * "$HOME"/.riecoin/
	cd /tmp/
	[ -d $strap_version ] && rm -fr $strap_version
	[ -e $strap_zip ] && rm $strap_zip
    	sleep 1
    	echo -e "XXX\n99\n    INSTALL FILES... Done.\nXXX"
    	sleep 0.5
 	echo -e "XXX\n100\n    INSTALLATION FINISHED\nXXX"
  	sleep 1
		fi
	} | whiptail --title "BOOTSTRAP INSTALLATION" --gauge "    Please wait while installing" 6 60 0
clear
else
whiptail --clear --title "ERROR" --msgbox "PLEASE CHECK YOUR INTERNET CONNECTION" 7 41 0
clear
fi
fi
fi
}
#BOOTSTRAP TESTNET
install_straptest(){
[ -d "$HOME"/.riecoin/testnet3/ ] && whiptail --clear --title "BOOTSTRAP RIECOIN CORE" --msgbox "    TESTNET DATA WAS FOUNDED. \n  IF YOU CONTINUE, ALL EXISTING\n   TESTNET DATA WILL BE ERASED.\nIF YOU NEED TO SAVE YOUR WALLET BEFORE STARTING, CHOOSE NO AFTER." 11 37 
if (whiptail --title "BOOTSTRAP RIECOIN CORE" --yesno "    DOWNLOAD TESTNET BLOCKCHAIN ?" 7 40); then
	if : >/dev/tcp/8.8.8.8/53; then
	clear
		sudo cd ~/ > /dev/null 2>&1
	clear
	{
    	sleep 0.5
    	echo -e "XXX\n0\n    VERIFY AND INSTALL SYSTEM UPDATE... PLEASE WAIT.\nXXX"
		sudo apt-get update && sudo apt-get upgrade -y > /dev/null 2>&1
    	sleep 1
    	echo -e "XXX\n20\n    VERIFY AND INSTALL SYSTEM UPDATE... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n20\n    INSTALL WGET... \nXXX"
		sudo apt-get install -y wget > /dev/null 2>&1
    	sleep 1
    	echo -e "XXX\n30\n    INSTALL WGET... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n30\n    INSTALL UNZIP... \nXXX"
		sudo apt-get install -y unzip > /dev/null 2>&1
    	sleep 1
    	echo -e "XXX\n40\n    INSTALL UNZIP... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n40\n    DOWNLOAD TESTNET BOOTSTRAP... PLEASE WAIT.\nXXX"
	cd /tmp/
	exit=0 && wget -q $bootstrap_test || exit=1
   		if [ "$exit" != "0" ]; then
		echo -e "XXX\n100\n    DOWNLOAD BOOTSTRAP ERROR, CHECK YOUR INTERNET CONNECTION\nXXX"
		sleep 7
		[ -e $straptest_zip ] && rm $straptest_zip
  		else
 	sleep 1
    	echo -e "XXX\n60\n    DOWNLOAD TESTNET BOOTSTRAP... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n60\n    UNZIP FILES... \nXXX"
	unzip $straptest_zip
    	sleep 1
    	echo -e "XXX\n80\n    UNZIP FILES... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n80\n    INSTALL FILES... \nXXX"
	cd $straptest_version
	[ -d "$HOME"/.riecoin/testnet3 ] && rm -fr "$HOME"/.riecoin/testnet3
	[ ! -d "$HOME"/.riecoin/testnet3 ] && mkdir -p "$HOME"/.riecoin/testnet3
	mv * "$HOME"/.riecoin/testnet3/
	cd /tmp/
	[ -d $straptest_version ] && rm -fr $straptest_version
	[ -e $straptest_zip ] && rm $straptest_zip
    	sleep 1
    	echo -e "XXX\n99\n    INSTALL FILES... Done.\nXXX"
    	sleep 0.5
 	echo -e "XXX\n100\n    INSTALLATION FINISHED\nXXX"
  	sleep 1
		fi
	} |whiptail --title "BOOTSTRAP INSTALLATION" --gauge "    Please wait while installing" 6 60 0
clear
else
whiptail --clear --title "ERROR" --msgbox "PLEASE CHECK YOUR INTERNET CONNECTION" 7 41 0
clear
fi
fi
}

wizard_core_conf(){
step_core_title="RIECOIN CORE WIZARD"
if (whiptail --title "$step_core_title" --yesno "START RIECOIN CONF WIZARD ?" 7 31); then
main_mode(){

rpc_bind(){
if (whiptail --clear --title "RPCBIND" --yesno "Bind to given address to listen for JSON-RPC connections. Do not expose the RPC server to untrusted networks such as the public internet! This option is ignored unless -rpcallowip is also passed. Port is optional and overrides -rpcport. May be needed for solo mining with:\n      127.0.0.1 or LAN (e. 192.168.1.15).\n              Configure RPC Bind ?" 14 52); then
inb=0
selected_binds[$inb]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCBIND address (without port) :" --nocancel 8 47 127.0.0.1 3>&1 1>&2 2>&3)"
let "inb = $inb + 1"
while (whiptail --clear --title "RPCBIND" --yesno "\n   Configure another RPC Bind ?" 8 40); do
selected_binds[$inb]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCBIND address (without port) :" --nocancel 8 47 192.168.1.10 3>&1 1>&2 2>&3)"
let "inb = $inb + 1"
done
fi
}

rpc_allow(){
if (whiptail --clear --title "RPCALLOWIP" --yesno "Allow JSON-RPC connections from specified source. This option can be specified multiple times. Needed to allow each miners IP for solo mining. For security, never use 0.0.0.0 but specify each connection ip.\n           Configure RPC Allow IP ?" 12 52); then
ina=0
selected_allows[$ina]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCALLOWIP address (without port or /24) :" --nocancel 8 47 192.168.1.12 3>&1 1>&2 2>&3)"
let "ina = $ina + 1"
while (whiptail --clear --title "RPCALLOWIP" --yesno "\n   Configure another RPC Allow IP ?" 8 40); do
selected_allows[$ina]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCALLOWIP address (without port or /24) :" --nocancel 8 47 192.168.1.13 3>&1 1>&2 2>&3)"
let "ina = $ina + 1"
done
fi
}

rpc_addnode(){
if (whiptail --clear --title "RPCADDNODE" --yesno "Add a node to connect to and attempt to keep the connection open. This option can be specified multiple times to add multiple nodes. Speed up synchronization, validations and create a persistent connection across the network.\n           Configure RPC AddNode ?" 12 52); then
inad=0
selected_addnodes[$inad]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCADDNODE address (with or without port) :" --nocancel 8 47 192.168.1.12:28333 3>&1 1>&2 2>&3)"
let "inad = $inad + 1"
while (whiptail --clear --title "RPCADDNODE" --yesno "\n   Configure another RPC AddNode ?" 8 40); do
selected_addnodes[$inad]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCADDNODE address (with or without port) :" --nocancel 8 47 192.168.1.13:28333 3>&1 1>&2 2>&3)"
let "inad = $inad + 1"
done
fi
}

TXINDEX=$(whiptail --clear --title "$step_core_title" --inputbox "\nTX-Index maintain a full transaction index on disk, used by the getrawtransaction rpc call. Option used by developers, exchanges, transaction explorers...\n         TX Index Yes(1) or No(0) :" --nocancel 12 47 0 3>&1 1>&2 2>&3)
[ "$TXINDEX" != "0" ] && [ "$TXINDEX" != "1" ] && whiptail --clear --title "ERROR" --msgbox "PLEASE CHOOSE ONLY 1 OR 0" 7 35 0 && exit
	RPCPORT=$(whiptail --clear --title "$step_core_title" --inputbox "\nRPC port: " --nocancel 8 47 28332 3>&1 1>&2 2>&3)
	P2PPORT=$(whiptail --clear --title "$step_core_title" --inputbox "\nP2P port: " --nocancel 8 47 28333 3>&1 1>&2 2>&3)
	RPCUSER=$(whiptail --clear --title "$step_core_title" --inputbox "\nRPC username:" --nocancel 8 47 username 3>&1 1>&2 2>&3)
	RPCPASS=$(whiptail --clear --title "$step_core_title" --inputbox "\nRPC password :" --nocancel 8 47 password 3>&1 1>&2 2>&3)
	rpc_bind
	rpc_allow
	rpc_addnode
	[ ! -d ~/.riecoin ] && mkdir -p ~/.riecoin
	cd ~/.riecoin/
	[ -e riecoin.conf ] && rm riecoin.conf

if [[ $selected_binds ]]; then
RPCBIND=$(for bind in "${selected_binds[@]}"; do
echo "rpcbind=$bind"
done)
fi

if [[ $selected_allows ]]; then
RPCALLOWIP=$(for allow in "${selected_allows[@]}"; do
echo "rpcallowip=$allow/24"
done)
fi

if [[ $selected_addnodes ]]; then
RPCADDNODE=$(for node in "${selected_addnodes[@]}"; do
echo "addnode=$node"
done)
fi

	echo "txindex="$TXINDEX"
server=1
daemon=1
"$MODE"
rpcport="$RPCPORT"
port="$P2PPORT"
rpcuser="$RPCUSER"
rpcpassword="$RPCPASS"
$RPCBIND
$RPCALLOWIP
$RPCADDNODE
addnode=147.135.86.84:28333 " > riecoin.conf

}

test_mode(){

rpc_bind(){
if (whiptail --clear --title "RPCBIND" --yesno "Bind to given address to listen for JSON-RPC connections. Do not expose the RPC server to untrusted networks such as the public internet! This option is ignored unless -rpcallowip is also passed. Port is optional and overrides -rpcport. May be needed for solo mining with:\n      127.0.0.1 or LAN (e. 192.168.1.15).\n              Configure RPC Bind ?" 14 52); then
inb=0
selected_tbinds[$inb]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCBIND address (without port) :" --nocancel 8 47 127.0.0.1 3>&1 1>&2 2>&3)"
let "inb = $inb + 1"
while (whiptail --clear --title "RPCBIND" --yesno "\n   Configure another RPC Bind ?" 8 40); do
selected_tbinds[$inb]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCBIND address (without port) :" --nocancel 8 47 192.168.1.10 3>&1 1>&2 2>&3)"
let "inb = $inb + 1"
done
fi
}

rpc_allow(){
if (whiptail --clear --title "RPCALLOWIP" --yesno "Allow JSON-RPC connections from specified source. This option can be specified multiple times. Needed to allow each miners IP for solo mining. For security, never use 0.0.0.0 but specify each connection ip.\n           Configure RPC Allow IP ?" 12 52); then
ina=0
selected_tallows[$ina]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCALLOWIP address (without port or /24) :" --nocancel 8 47 192.168.1.12 3>&1 1>&2 2>&3)"
let "ina = $ina + 1"
while (whiptail --clear --title "RPCALLOWIP" --yesno "\n   Configure another RPC Allow IP ?" 8 40); do
selected_tallows[$ina]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCALLOWIP address (without port or /24) :" --nocancel 8 47 192.168.1.13 3>&1 1>&2 2>&3)"
let "ina = $ina + 1"
done
fi
}

rpc_addnode(){
if (whiptail --clear --title "RPCADDNODE" --yesno "Add a node to connect to and attempt to keep the connection open. This option can be specified multiple times to add multiple nodes. Speed up synchronization, validations and create a persistent connection across the network.\n           Configure RPC AddNode ?" 12 52); then
inad=0
selected_taddnodes[$inad]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCADDNODE address (with or without port) :" --nocancel 8 47 192.168.1.12:28333 3>&1 1>&2 2>&3)"
let "inad = $inad + 1"
while (whiptail --clear --title "RPCADDNODE" --yesno "\n   Configure another RPC AddNode ?" 8 40); do
selected_taddnodes[$inad]="$(whiptail --clear --title "$step_core_title" --inputbox "\nRPCADDNODE address (with or without port) :" --nocancel 8 47 192.168.1.13:28333 3>&1 1>&2 2>&3)"
let "inad = $inad + 1"
done
fi
}

TTXINDEX=$(whiptail --clear --title "$step_core_title" --inputbox "\nTX-Index maintain a full transaction index on disk, used by the getrawtransaction rpc call. Option used by developers, exchanges, transaction explorers...\n         TX Index Yes(1) or No(0) :" --nocancel 12 47 0 3>&1 1>&2 2>&3)
[ "$TTXINDEX" != "0" ] && [ $TTXINDEX != "1" ] && whiptail --clear --title "ERROR" --msgbox "PLEASE CHOOSE ONLY 1 OR 0" 7 35 0 && exit
	TRPCPORT=$(whiptail --clear --title "$step_core_title" --inputbox "\nRPC port: " --nocancel 8 47 38332 3>&1 1>&2 2>&3)
	TP2PPORT=$(whiptail --clear --title "$step_core_title" --inputbox "\nP2P port: " --nocancel 8 47 38333 3>&1 1>&2 2>&3)
	TRPCUSER=$(whiptail --clear --title "$step_core_title" --inputbox "\nRPC username:" --nocancel 8 47 username 3>&1 1>&2 2>&3)
	TRPCPASS=$(whiptail --clear --title "$step_core_title" --inputbox "\nRPC password :" --nocancel 8 47 password 3>&1 1>&2 2>&3)
	rpc_bind
	rpc_allow
	rpc_addnode
	[ ! -d ~/.riecoin ] && mkdir -p ~/.riecoin
	cd ~/.riecoin/
	[ -e riecoin.conf ] && rm riecoin.conf

if [[ $selected_tbinds ]]; then
TRPCBIND=$(for tbind in "${selected_tbinds[@]}"; do
echo "rpcbind=$tbind"
done)
fi

if [[ $selected_tallows ]]; then
TRPCALLOWIP=$(for tallow in "${selected_tallows[@]}"; do
echo "rpcallowip=$tallow/24"
done)
fi

if [[ $selected_taddnodes ]]; then
TRPCADDNODE=$(for tnode in "${selected_taddnodes[@]}"; do
echo "addnode=$tnode"
done)
fi

	echo "testnet=1
txindex="$TTXINDEX"
server=1
daemon=1
"$MODE"
rpcport="$TRPCPORT"
port="$TP2PPORT"
rpcuser="$TRPCUSER"
rpcpassword="$TRPCPASS"
$TRPCBIND
$TRPCALLOWIP
$TRPCADDNODE
addnode=147.135.86.88:38333 " > riecoin.conf
}

MODE=$(whiptail --clear --title "$step_core_title" --inputbox "\nChoose network Mainnet (Main) or Testnet (Test)?" 8 52 Main 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
	if [ $MODE = "Main" -o $MODE = "main" -o $MODE = "MAIN" ]; then
		MODE="[main]"
		main_mode
	elif [ $MODE = "Test" -o $MODE = "test" -o $MODE = "TEST" ]; then
		MODE="[test]"
    		test_mode
	else	
	whiptail --clear --title "ERROR" --msgbox "PLEASE CHOOSE ONLY Main OR Test" 7 35 0
	clear
	fi
fi
fi
}

# START RIECOIND
riecoind_start(){
if [ ! -e /usr/bin/riecoind ]; then
whiptail --clear --title "ERROR" --msgbox "RIECOIN CORE IS NOT INSTALLED" 7 33 3>&1 1>&2 2>&3 
else
	(pgrep riecoind) && clear && whiptail --clear --title "RIECOIND" --msgbox "RIECOIND IS ALREADY STARTED" 7 31 || (if (whiptail --clear --title "RIECOIND" --yesno "       START RIECOIND ?" 7 32 3>&1 1>&2 2>&3); then
	riecoind -daemon
	whiptail --clear --title "RIECOIND" --msgbox "RIECOIND IS STARTED" 7 25 3>&1 1>&2 2>&3 && clear
	fi)
fi
}

# GET RIECOIND INFO
get_riecoind_info(){
(pgrep riecoind) && clear && whiptail --clear --title "RIECOIND INFO" --msgbox "$(riecoin-cli -getinfo)" 23 53 && clear || whiptail --clear --title "RIECOIND INFO" --msgbox "RIECOIND IS NOT STARTED" 7 27 && clear
}

# GET RIECOIND VERSION
get_riecoind_version(){
(pgrep riecoind) && clear && whiptail --clear --title "RIECOIND VERSION" --msgbox "$(riecoin-cli -version)" 7 55 && clear || whiptail --clear --title "RIECOIND VERSION" --msgbox "RIECOIND IS NOT STARTED" 7 27 && clear
}

# STOP RIECOIND
riecoind_stop(){
if [ ! /usr/bin/riecoin-tx ]; then
whiptail --clear --title "ERROR" --msgbox "RIECOIN CORE IS NOT INSTALLED" 7 33 3>&1 1>&2 2>&3 
else
	(pgrep riecoind) && clear && (if (whiptail --clear --title "RIECOIND" --yesno "       STOP RIECOIND ?" 7 32 3>&1 1>&2 2>&3); then
	 riecoin-cli stop && clear && whiptail --clear --title "RIECOIND" --msgbox "RIECOIND IS STOPPED" 7 25 3>&1 1>&2 2>&3
	fi) || whiptail --clear --title "RIECOIND" --msgbox "RIECOIND IS NOT STARTED" 7 27
fi
}

# UNINSTALL RIECOIN CORE DATA
uninstall_core(){
if (whiptail --title "RIECOIN CORE UNINSTALLATION" --yesno "UNINSTALL ALL RIECOIN CORE DATA AND WALLET ?" 7 48); then
	clear
	sudo cd ~/ > /dev/null 2>&1
	{
    	sleep 1
    	echo -e "XXX\n0\nDELETE FILES... \nXXX"	
	[ -d ~/.riecoin ] && rm -fr ~/.riecoin
	[ -e /usr/bin/riecoind ] && sudo rm /usr/bin/riecoind
	[ -e /usr/bin/riecoin-wallet ] && sudo rm /usr/bin/riecoin-wallet
	[ -e /usr/bin/riecoin-qt ] && sudo rm /usr/bin/riecoin-qt
	[ -e /usr/bin/riecoin-tx ] && sudo rm /usr/bin/riecoin-tx
	[ -e /usr/bin/riecoin-cli ] && sudo rm /usr/bin/riecoin-cli
	[ -e /usr/bin/test_riecoin ] && sudo rm /usr/bin/test_riecoin
	[ -e /usr/include/bitcoinconsensus.h ] && sudo rm /usr/include/bitcoinconsensus.h
	[ -e /usr/lib/libbitcoinconsensus.so ] && sudo rm /usr/lib/libbitcoinconsensus.so
	[ -e /usr/lib/libbitcoinconsensus.so.0 ] && sudo rm /usr/lib/libbitcoinconsensus.so.0
	[ -e /usr/lib/libbitcoinconsensus.so.0.0.0 ] && sudo rm /usr/lib/libbitcoinconsensus.so.0.0.0
	[ -e /usr/share/man/man1/bitcoin-wallet.1 ] && sudo rm /usr/share/man/man1/bitcoin-wallet.1
	[ -e /usr/share/man/man1/bitcoin-tx.1 ] && sudo rm /usr/share/man/man1/bitcoin-tx.1
	[ -e /usr/share/man/man1/bitcoin-qt.1 ] && sudo rm /usr/share/man/man1/bitcoin-qt.1
	[ -e /usr/share/man/man1/bitcoin-cli.1 ] && sudo rm /usr/share/man/man1/bitcoin-cli.1
	[ -e /usr/share/man/man1/bitcoind.1 ] && sudo rm /usr/share/man/man1/bitcoind.1
    	sleep 1
    	echo -e "XXX\n95\nDELETE FILES... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n100\nUNINSTALLATION FINISHED\nXXX"
    	sleep 1
	} |whiptail --title "RIECOIN CORE UNINSTALLATION" --gauge "Please wait while uninstalling" 6 60 0
fi
}

start_core2(){
while [ core ]; do
core_installed="INSTALLED    "
[ ! -e /usr/bin/riecoin-tx ] && core_installed="NOT INSTALLED"
riecoind_pgrep=$(pgrep riecoind) && riecoind_status="ON" || riecoind_status="OFF"

rieminer_installed="INSTALLED    "
[ ! -e "$HOME"/rieMiner/"$rieminer_version" ] && rieminer_installed="NOT INSTALLED"
rieminer_pgrep=$(pgrep rieMiner) && rieminer_status="ON" || rieminer_status="OFF"

OPTION=$(whiptail --clear --title "$core_version 2/2" --menu "\n  RIECOIN CORE : $core_installed          RIECOIND : $riecoind_status\n  RIEMINER APP : $rieminer_installed          RIEMINER : $rieminer_status" --cancel-button "Back" 17 60 7 \
"1" "GET RIECOIND INFO" \
"2" "GET RIECOIND VERSION" \
"3" "UNINSTALL RIECOIN CORE" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	if [[ $OPTION = 1 ]]; then
	get_riecoind_info
	fi
	if [[ $OPTION = 2 ]]; then
	get_riecoind_version
	fi
	if [[ $OPTION = 3 ]]; then
	uninstall_core
	fi
else
	break
fi
done
}

while [ core ]; do
core_installed="INSTALLED    "
[ ! -e /usr/bin/riecoin-tx ] && core_installed="NOT INSTALLED"
riecoind_pgrep=$(pgrep riecoind) && riecoind_status="ON" || riecoind_status="OFF"

rieminer_installed="INSTALLED    "
[ ! -e "$HOME"/rieMiner/"$rieminer_version" ] && rieminer_installed="NOT INSTALLED"
rieminer_pgrep=$(pgrep rieMiner) && rieminer_status="ON" || rieminer_status="OFF"

OPTION=$(whiptail --clear --title "$core_version 1/2" --menu "\n  RIECOIN CORE : $core_installed          RIECOIND : $riecoind_status\n  RIEMINER APP : $rieminer_installed          RIEMINER : $rieminer_status" --cancel-button "Back" 18 60 8 \
"1" "INSTALL/UPDATE RIECOIN CORE" \
"2" "BOOTSTRAP MAINNET" \
"3" "BOOTSTRAP TESTNET" \
"4" "WIZARD RIECOIN.CONF" \
"5" "EDIT RIECOIN.CONF" \
"6" "START RIECOIND" \
"7" "STOP RIECOIND" \
"8" "NEXT" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	if [[ $OPTION = 1 ]]; then
	install_core
	fi
	if [[ $OPTION = 2 ]]; then
	install_strap
	fi
	if [[ $OPTION = 3 ]]; then
	install_straptest
	fi
	if [[ $OPTION = 4 ]]; then
	wizard_core_conf
	fi
	if [[ $OPTION = 5 ]]; then
	nano "$HOME"/.riecoin/riecoin.conf
	fi
	if [[ $OPTION = 6 ]]; then
	riecoind_start
	fi
	if [[ $OPTION = 7 ]]; then
	riecoind_stop
	fi
	if [[ $OPTION = 8 ]]; then
	start_core2
	fi
else
	break
fi
done
}

# MENU RIEMINER
start_rieminer(){

install_rieminer(){
if : >/dev/tcp/8.8.8.8/53; then
	clear
		sudo cd ~/ > /dev/null 2>&1
		clear;
	{
	sleep 1
   	echo -e "XXX\n0\nVERIFY AND INSTALL SYSTEM UPDATE... \nXXX"
		sudo apt-get update && sudo apt-get upgrade -y	
		clear;
    	sleep 1
    	echo -e "XXX\n25\nVERIFY AND INSTALL SYSTEM UPDATE... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n25\nINSTALL WGET... \nXXX"
		sudo apt-get install -y wget
		clear;
    	sleep 1
    	echo -e "XXX\n50\nINSTALL WGET... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n50\nDOWNLOAD RIEMINER... \nXXX"
	[ ! -d ~/rieMiner ] && mkdir -p "$HOME"/rieMiner
	cd "$HOME"/rieMiner/ && exit=0 && wget -q $rieminer_http || exit=1
   		if [ "$exit" != "0" ]; then
		echo -e "XXX\n100\nDOWNLOAD RIEMINER ERROR, CHECK YOUR INTERNET CONNECTION\nXXX"
		sleep 7
  		else
    	sleep 1
    	echo -e "XXX\n75\nDOWNLOAD RIEMINER... Done.\nXXX"
    	sleep 0.5
    	echo -e "XXX\n75\nACTIVATE THE FILE... \nXXX"
	chmod u+x $rieminer_version
    	sleep 1
    	echo -e "XXX\n99\nACTIVATE THE FILE... Done.\nXXX"
    	sleep 1
    	echo -e "XXX\n100\nINSTALLATION FINISHED\nXXX"
    	sleep 1
		fi
	} | whiptail --title "RIEMINER INSTALLATION" --gauge "Please wait while installing" 6 60 0
		
else
whiptail --clear --title "ERROR" --msgbox "PLEASE CHECK YOUR INTERNET CONNECTION" 7 41 0
clear
fi
}

step_rieminer_conf(){
pool_mode(){
HOST=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nPool address (without port) :" --nocancel 8 47 147.135.86.84 3>&1 1>&2 2>&3)
	PORT=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nPool port (example: 5000) :" --nocancel 8 47 5000 3>&1 1>&2 2>&3)
	USER=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nPool username - ric address :" --nocancel 8 47 ric1q 3>&1 1>&2 2>&3)
	PASS=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nPool user password :" --nocancel 8 47 XXX 3>&1 1>&2 2>&3)
	THREADS=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nNumber of threads :" --nocancel 8 47 4 3>&1 1>&2 2>&3)
	[ ! -d ~/rieMiner ] && mkdir -p ~/rieMiner
	cd ~/rieMiner
	[ -e rieMiner.conf ] && rm rieMiner.conf
	echo "Mode = "$MODE"
Host = "$HOST"
Port = "$PORT"
Username = "$USER"
Password = "$PASS"
Threads = "$THREADS" " > rieMiner.conf
}

solo_mode(){
HOST=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nRiecoin Core (wallet) IP:" --nocancel 8 47 127.0.0.1 3>&1 1>&2 2>&3)
	PORT=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nRPC port: " --nocancel 8 47 28332 3>&1 1>&2 2>&3)
	USER=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nRPC username:" --nocancel 8 47 username 3>&1 1>&2 2>&3)
	PASS=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nRPC password :" --nocancel 8 47 password 3>&1 1>&2 2>&3)
	PAYOUT=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nPayout address: " --nocancel 8 47 ric1q 3>&1 1>&2 2>&3)
	THREADS=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nNumber of threads :" --nocancel 8 47 4 3>&1 1>&2 2>&3)
	[ ! -d ~/rieMiner ] && mkdir -p ~/rieMiner
	cd ~/rieMiner
	[ -e rieMiner.conf ] && rm rieMiner.conf
	echo "Mode = "$MODE"
Host = "$HOST"
Port = "$PORT"
Username = "$USER"
Password = "$PASS"
PayoutAddress = "$PAYOUT"
Threads = "$THREADS" " > rieMiner.conf
}

MODE=$(whiptail --title "RIEMINER CONFIGURATOR" --inputbox "\nSolo mining (Solo) or pooled mining (Pool)?" 8 47 Pool 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
	if [ $MODE = "solo" -o $MODE = "Solo" -o $MODE = "SOLO" ]; then
		MODE="Solo"
		solo_mode
	elif [ $MODE = "Pool" -o $MODE = "pool" -o $MODE = "POOL" ]; then
		MODE="Pool"
    		pool_mode
	else	
	whiptail --clear --title "ERROR" --msgbox "PLEASE CHOOSE ONLY Solo OR Pool" 7 35 0
	clear
	fi
fi
}

rieminer_delete(){
if (whiptail --title "RIEMINER UNINSTALLATION" --yesno "    UNINSTALL ALL RIEMINER DATA ?" 7 40); then
	{
    	echo -e "XXX\n0\nDELETE FILES... \nXXX"
	[ -d "$HOME"/rieMiner/ ] && rm -fr "$HOME"/rieMiner/
	sleep 1
    	echo -e "XXX\n95\nDELETE FILES... Done.\nXXX"
    	sleep 1
    	echo -e "XXX\n100\nUNINSTALLATION FINISHED\nXXX"
    	sleep 1
	} |whiptail --title "RIEMINER UNINSTALLATION" --gauge "Please wait while uninstalling" 6 60 0
fi
}

while [ rieminer ]; do

core_installed="INSTALLED    "
[ ! -e /usr/bin/riecoind ] && core_installed="NOT INSTALLED"
riecoind_pgrep=$(pgrep riecoind) && riecoind_status="ON" || riecoind_status="OFF"

rieminer_installed="INSTALLED    "
[ ! -e "$HOME"/rieMiner/"$rieminer_version" ] && rieminer_installed="NOT INSTALLED"
rieminer_pgrep=$(pgrep rieMiner) && rieminer_status="ON" || rieminer_status="OFF"

OPTION=$(whiptail --clear --title "$rieminer_version" --menu "\n  RIECOIN CORE : $core_installed          RIECOIND : $riecoind_status\n  RIEMINER APP : $rieminer_installed          RIEMINER : $rieminer_status" --cancel-button "Back" 17 60 7 \
"1" "INSTALL/UPDATE RIEMINER" \
"2" "WIZARD RIEMINER.CONF" \
"3" "EDIT RIEMINER.CONF" \
"4" "UNINSTALL RIEMINER" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	if [[ $OPTION = 1 ]]; then
	clear
	[ -e "$HOME"/rieMiner/"$rieminer_version" ] && rm "$HOME"/rieMiner/"$rieminer_version"
	install_rieminer
	elif [[ $OPTION = 2 ]]; then
	clear
	step_rieminer_conf
	elif [[ $OPTION = 3 ]]; then
	clear
	nano "$HOME"/rieMiner/rieMiner.conf
	elif [[ $OPTION = 4 ]]; then
	clear
	[ -e "$HOME"/rieMiner/"$rieminer_version" ] && rieminer_delete ||  whiptail --clear --title "ERROR" --msgbox "  RIEMINER IS NOT INSTALLED" 7 33 0
	fi
else
	break
fi
done
}

# MENU ABOUT
start_about(){

whiptail --clear --title "ABOUT" --msgbox "                  RIECOIN MANAGER v01
                 For Debian and Ubuntu
                Copyright (c) 2021 DeKon
             Copyright (c) 2021 Riecoin Team
\n           Discord: https://discord.gg/2sJEayC
           Twitter: https://twitter.com/Riecoin
         Reddit: https://www.reddit.com/r/Riecoin/
             Experimental Tool, MIT Licensed." 15 60 4

}

# SPLASHSCREEN
clear;
if (whiptail --title "RIECOIN MANAGER" --msgbox "
################################################# \
##############   ################################ \
#############  ####################     ######### \
#############  #################    ###   ####### \
##############   ############    #######  ####### \
################    #######   ################### \
##################     #    ##################### \
####################     ######################## \
###################    ########################## \
############              ####################### \
#################   ############################# \
##########              ######################### \
###############   ############################### \
##############   ############[_VERSION 1_]####### \
###########        ############################## \
#########           ############################# \
################################################# " 24 53) then
	clear;	
# MENU
while [ main ]; do
disk_free=$(df -Pk | grep -m1 '\/$' | awk '{print $4}')
disk_gui=$(df -Pkh | grep -m1 '\/$' | awk '{print $4}')
warning_space=""
[[ $disk_free -lt 4194304 ]] && warning_space="WARNING"
net_com=$(: >/dev/tcp/8.8.8.8/53) && net_status="ON" || net_status="OFF"
riecoind_pgrep=$(pgrep riecoind) && riecoind_status="ON" || riecoind_status="OFF"
rieminer_pgrep=$(pgrep rieMiner) && rieminer_status="ON" || rieminer_status="OFF"
OPTION_MAIN=$(whiptail --title "MENU" --menu "\n  CPU : "$cpu_name"                      INTERNET : $net_status\n  OS : "$os_name" "$os_codename" "$os_mode" bit          RIECOIND : "$riecoind_status"\n  DiskFree : "$disk_gui" "$warning_space"                   RIEMINER : $rieminer_status " --cancel-button "Exit" 17 60 6 \
"1" "RIECOIN CORE" \
"2" "RIEMINER" \
"3" "ABOUT" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	if [[ $OPTION_MAIN = 1 ]]; then
	clear
	start_core
	fi
	if [[ $OPTION_MAIN = 2 ]]; then
	clear
	start_rieminer
	fi
	if [[ $OPTION_MAIN = 3 ]]; then
	clear
	start_about
	fi
else
	clear
	exit
fi
done
fi


# AUTOINSTALL 2/2
else
whiptail --clear --title "ERROR" --msgbox "AUTO-INSTALLATION ERROR" 7 30 0
fi
