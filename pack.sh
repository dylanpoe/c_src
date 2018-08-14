set -eu


COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_RESET='\033[0m'


SOFT_VERSION=$1
COMMIT_ID=''
NOW_TIME=`date "+%Y-%m-%d_%H:%M:%S"`

GAME_DIR=`realpath $2`
ZONE=`basename $GAME_DIR`
echo "ZONE is $ZONE $GAME_DIR"

GAME_OBJ=/tmp/bin/game
ROBOT_OBJ=/tmp/bin/robot
LOGIN_OBJ=/tmp/bin/login
COUNT_OBJ=/tmp/bin/count
HALL_OBJ=/tmp/bin/hall
DATA_OBJ=/tmp/bin/data
MONITOR_OBJ=/tmp/bin/monitor
PUSH_OBJ=/tmp/bin/push

source ./conf.sh $ZONE

if [ "$ZONE" != "qingyuan" ]; then
    GAME_OBJ=`dirname $GAME_OBJ`"/$ZONE""_game"
    ROBOT_OBJ=`dirname $ROBOT_OBJ`"/$ZONE""_robot"
    LOGIN_OBJ=`dirname $LOGIN_OBJ`"/$ZONE""_login"
    COUNT_OBJ=`dirname $COUNT_OBJ`"/$ZONE""_count"
    HALL_OBJ=`dirname $HALL_OBJ`"/$ZONE""_hall"
    DATA_OBJ=`dirname $DATA_OBJ`"/$ZONE""_data"
    MONITOR_OBJ=`dirname $MONITOR_OBJ`"/$ZONE""_monitor"
    PUSH_OBJ=`dirname $DATA_OBJ`"/$ZONE""_push"
fi

# 游戏服和机器人二进制
if [ "$GAME_SWITCH" == "ON" ]; then
    cd $GAME_DIR 
    export GOPATH=`pwd`
    git checkout $GAME_BRANCH
    git pull origin $GAME_BRANCH
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo -e "$COLOR_GREEN building game & robot on $GAME_BRANCH ...$COLOR_RESET"
    go build  -o $GAME_OBJ -ldflags "-X main.Hall_commit=$COMMIT_ID -X 'main.BUILD_TIME=$NOW_TIME' -X main.VERSION=$SOFT_VERSION -s -w" src/server_game/game.go
    if [ $ROBOT_SWITCH == "ON" ]; then
        go build -o $ROBOT_OBJ -ldflags "-X main.Hall_commit=$COMMIT_ID -X 'main.BUILD_TIME=$NOW_TIME' -X main.VERSION=$SOFT_VERSION -s -w" src/server_robot/main.go
    fi
fi

if [ "$ZONE" == "lyg_xp" ]; then
    GAME2_OBJ=`dirname $GAME_OBJ`"/$ZONE""_game2"
    cd ~/project/lyg_gy
    git pull origin master
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo "$COLOR_GREEN building lyg_gy on master...$COLOR_RESET"
    go build  -o $GAME2_OBJ -ldflags "-X main.Hall_commit=$COMMIT_ID -X 'main.BUILD_TIME=$NOW_TIME' -X main.VERSION=$SOFT_VERSION -s -w" src/server_game/game.go
fi

# 登录服
if [ "$LOGIN_SWITCH" == "ON" ]; then
    cd /data/hongfu/project/union_login/
    export GOPATH=`pwd`
    git checkout $LOGIN_BRANCH
    git pull origin $LOGIN_BRANCH
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo -e "$COLOR_GREEN building login on $LOGIN_BRANCH ... $COLOR_RESET"
    go build  -o $LOGIN_OBJ -ldflags "-X main.Login_commit=$COMMIT_ID -X 'main.Mkpkg_time=$NOW_TIME' -X main.Pkg_version=$SOFT_VERSION -s -w" src/main.go
fi

# 统计服
if [ "$COUNT_SWITCH" == "ON" ]; then
    cd /data/hongfu/project/count/
    export GOPATH=`pwd`
    git checkout $COUNT_BRANCH
    git pull origin $COUNT_BRANCH
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo -e "$COLOR_GREEN building count on $COUNT_BRANCH ... $COLOR_RESET"
    go build  -o $COUNT_OBJ -ldflags "-X main.Count_commit=$COMMIT_ID -X 'main.Mkpkg_time=$NOW_TIME' -X main.Pkg_version=$SOFT_VERSION -s -w" src/statistic/main.go
fi

if [ "$HALL_SWITCH" == "ON" ]; then
    cd /data/hongfu/project/hall
    git checkout $HALL_BRANCH
    git pull origin $HALL_BRANCH
    export GOPATH=`pwd`
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo -e "$COLOR_GREEN building hall on $HALL_BRANCH ... $COLOR_RESET"
    go build  -o $HALL_OBJ -ldflags "-X main.Hall_commit=$COMMIT_ID -X 'main.BUILD_TIME=$NOW_TIME' -X main.VERSION=$SOFT_VERSION -s -w" src/main.go
fi

#数据api服 
#cd /data/hongfu/project/dataquery/
#export GOPATH=`pwd`
#git checkout $DATA_BRANCH
#git pull origin $DATA_BRANCH
#COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
#echo -e "$COLOR_GREEN building data api on $DATA_BRANCH 服... $COLOR_RESET"
#go build  -o $DATA_OBJ -ldflags "-X main.Dataquery_commit=$COMMIT_ID -X 'main.Mkpkg_time=$NOW_TIME' -X main.Pkg_version=$SOFT_VERSION -s -w" src/main.go

# 网关服
if [ "$MONITOR_SWITCH" == "ON" ]; then
    cd /data/hongfu/project/monitor/
    export GOPATH=`pwd`
    git pull origin master
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo -e "$COLOR_GREEN building monitor ... $COLOR_RESET"
    go build  -o $MONITOR_OBJ -ldflags "-X main.Login_commit=$COMMIT_ID -X 'main.Mkpkg_time=$NOW_TIME' -X main.Pkg_version=$SOFT_VERSION -s -w" src/main.go
fi

# push 服
if [ "$PUSH_SWITCH" == "ON" ]; then
    cd /data/hongfu/project/push/
    export GOPATH=`pwd`
    git pull origin master
    COMMIT_ID=`git log | head -n 1 | awk '{print $2}'`
    echo -e "$COLOR_GREEN building push... $COLOR_RESET"
    go build  -o $PUSH_OBJ -ldflags "-X main.Hall_commit=$COMMIT_ID -X 'main.BUILD_TIME=$NOW_TIME' -X main.VERSION=$SOFT_VERSION -s -w" src/main.go
fi

# 网页资源文件 
if [ "$ASSERTS_SWITCH" == "ON" ]; then
    cd $GAME_DIR
    git checkout $GAME_BRANCH
    git pull origin $GAME_BRANCH
    cp -rf bin/assets /tmp/bin
fi

# csv配置文件
if [ "$CSV_SWITCH" == "ON" ]; then
    cd $GAME_DIR
    git checkout $GAME_BRANCH
    git pull origin $GAME_BRANCH
    cp -rf bin/csv /tmp/bin
fi


FILE_NAME="bin-update-$NOW_TIME-$SOFT_VERSION.zip"
echo -e "file: $COLOR_GREEN $FILE_NAME $COLOR_RESET"
cd /tmp


echo $ZONE
if [ "$ZONE" == "hjpxmj258" ]; then
	ZONE="hjpxmj"
fi

if [ "$ZONE" == "hjgamj" ]; then
        ZONE="hjpxmj"
fi


echo $ZONE
zip -r /data/hongfu/$ZONE/update_files/${FILE_NAME} bin/
read -p "Press any key to continue." var

unzip -o /data/hongfu/$ZONE/update_files/${FILE_NAME} -d /data/game/$ZONE

