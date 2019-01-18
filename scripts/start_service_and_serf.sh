SERF_NODE=0

function start_service_and_serf {
    SERF_NODE=$((SERF_NODE+1))
    SERF_MEMBER_IP=$SERF_MEMBER_NET.$SERF_NODE
    SERF_RPC_IP=$SERF_RPC_NET.$SERF_NODE
    SERVICE_NAME="$1"
    SERVICE_NODE="$2"
    RECEIVE_MEMBERS=${3:-""}
    RECEIVE=""
    SERVICE_NAME_LOW=$(echo "$SERVICE_NAME" | tr '[:upper:]' '[:lower:]')
    [[ "$RECEIVE_MEMBERS" == "receive-member-events" ]] && RECEIVE=1        

    varname=${SERVICE_NAME}_NET
    SERVICE_IP=$(echo $(eval echo "\$$varname")).$SERVICE_NODE

    #varname=${SERVICE_NAME}_COUNT
    #SERVICE_COUNT=$(echo $(eval echo "\${$varname:-0}")).$SERF_NODE
    #SERVICE_COUNT=$(("))

    echo "----- Starting $SERVICE_NAME Node $SERVICE_NODE -----"
    echo -e SERF_MEMBER_IP:'\t'$SERF_MEMBER_IP
    echo -e SERF_RPC_IP:'\t'$SERF_RPC_IP
    echo -e ${SERVICE_NAME}_IP:'\t'$SERVICE_IP
    scripts/start_$SERVICE_NAME_LOW.sh $SERVICE_IP
    NODE_NAME=$(echo ${SERVICE_NAME_LOW}_${SERVICE_NODE})
    scripts/start_serf.sh $SERVICE_NAME_LOW $NODE_NAME $SERF_MEMBER_IP $SERF_RPC_IP $SERVICE_IP $RECEIVE
}
