#!/bin/sh

# kafka topic服务脚本,包括创建，描述，list，delete 四种比较常用的对topic的操作

# 获得命令参数，暂时包括 create、desc、list、delete四种操作
cmdop=$1;

#topic的名称
topic_name=$2;

#if [ $# -ne 2]; then
#    echo "list op"
#    #exit 1
#fi

#kafka集群在zk上元信息，等broker等一些信息,注意这个zookeeper_kafka地址得根据kafka server的属性文件的属性值确定zookeeper.connect
zookeeper_kafka='--zookeeper ××××:2181,××××:2181,××××:2181/kafka';
script_common='sh ./bin/kafka-topics.sh';
outputInfoColorBefore='\033[44;37m'
outputInfoColorAfter='\033[0m'
errorInfoColorBefore='\033[41;37m'
if [ $cmdop = 'list' ]
then
 	info="list kafka集群所有topic..."; 
 	echo -e "$outputInfoColorBefore $info $outputInfoColorAfter"
 	cmd='list';
 	$script_common --$cmd $zookeeper_kafka
elif [ $cmdop = 'create' ]
then
 	info="创建topic ->"$topic_name
 	echo -e "$outputInfoColorBefore $info $outputInfoColorAfter"
 	cmd='create';
 	$script_common --$cmd $zookeeper_kafka --replication-factor 3 --partitions 3 --topic $topic_name
elif [ $cmdop = 'desc' ]
then
 	info="描述topic ->"$topic_name",的partition、副本、ISR信息:"
 	echo -e "$outputInfoColorBefore $info $outputInfoColorAfter"
 	cmd='describe';
 	$script_common --$cmd $zookeeper_kafka --topic $topic_name
elif [ $cmdop = 'delete' ]
then
 	info="删除topic:"$topic_name" ........."
 	echo -e "$outputInfoColorBefore $info $outputInfoColorAfter"
 	cmd='delete';
 	$script_common $zookeeper_kafka --$cmd --topic $topic_name
else
 	echo -e "$errorInfoColorBefore 输入的topic op有误!,正确的topic op操作为list、create、desc、delete $outputInfoColorAfter";
 	exit 1
fi
