function getNestedValue(){
    local obj="$1"
    local key="$2"
    local isFound="$3"
    if [[ ! -z "$obj" && ! "$obj" =~ ^\{\} && -z "$isFound" ]]; then
    echo null
    return;
    fi
    local objKeys
    objKeys=$(jq 'keys' <<< "$obj")
    if [[ ! -z "$isFound" || "$objKeys" =~ "\"$key\"" ]]; then
    local keyValue
    keyValue=$(jq -r ".[\"$key\"]" <<< "$obj")
    if [[ "$keyValue" =~ ^\{\} ]]; then
    getNestedValue "$keyValue" "$(getKey "$keyValue")" "true"
    else
    echo "$keyValue"
    fi
    else
    local nestedKey
    nestedKey=$(getKey "$obj")
    getNestedValue "$(jq ".[\"$nestedKey\"]" <<< "$obj")" "$key" "false"
    fi
}
function getKey(){
    local obj="$1"
    local keys
    keys=$(jq 'keys | .[0]' <<< "$obj")
    echo "$keys"
}
obj='{"a":{"b":{"c":"d"}}}'
value=$(getNestedValue "$obj" "a/b/c")
echo "$value"