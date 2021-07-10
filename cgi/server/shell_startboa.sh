#!/bin/bash

USERNAME="web-boa"
GROUPNAME="web-boa"
FILE_BOA="boa"
SERVER_ROOT="root_server"
TARGETS=("$SERVER_ROOT")
FILE_BOA_CONF="boa.conf"
YES="yes"
NO="no"

FILE_BOA_CONF_PATH="$SERVER_ROOT/$FILE_BOA_CONF"

shell_fun_change_pri(){
    echo "--- boa file privileges($1)"

    PRIVILEGE="700"
    if [ $1 = "out" ]; then
        PRIVILEGE="777"
    fi

    for var_str in ${TARGETS[*]}
    do
        commands="sudo chown $USERNAME:$GROUPNAME $var_str -R"
        echo $commands
        $($commands)
        commands="sudo chmod $PRIVILEGE $var_str -R"
        echo $commands
        $($commands)
    done
};



shell_fun_exit(){
    echo "--- Shell terminated ---"
    exit
}

echo "--- Shell start ---"
echo "--- current path: "$(pwd)

# 还原权限
shell_fun_change_pri out

# 判断 boa 是否存在
if [ ! -x "$FILE_BOA" ]; then
    echo "file $FILE_BOA not exist!"
    shell_fun_exit
fi

# 判断 root_server 是否存在
if [ ! -d "$SERVER_ROOT" ]; then
    echo "dir $SERVER_ROOT not exist, creating..."
    mkdir $SERVER_ROOT
fi

# 判断配置文件 boa.conf 是否存在
if [ ! -f "$FILE_BOA_CONF_PATH" ]; then
    echo "file $FILE_BOA_CONF_PATH not exist!"
    shell_fun_exit
fi

# 检查用户是否存在
if ! id -u $USERNAME > /dev/null 2>&1; then 
    echo "User $USERNAME not exist!"
    read -p "Generate user $USERNAME?  [$YES/$NO] " CHOICE
    if [ $CHOICE = $YES ]; then
        sudo useradd $USERNAME
    else 
        shell_fun_exit
    fi
fi

# 修改权限
shell_fun_change_pri in

# running boa
sudo ./boa -c $SERVER_ROOT -f $FILE_BOA_CONF

echo "--- Shell finished ---"