# Gets a required configuration key from the git config
#
# @param string the name of the hook
# @param string the name of the configuration key
# @param string the name of the variable where the return value should be stored
#
# @return int   0: success
#               1: misuse
#               2: key not set
function get_hook_required_config()
{
    if [ $# -ne 3 ]
    then
        echo "Usage: $0(<hook>, <option>, <return_variable_name>)"
        return 1
    fi
    local __resultvar=$3
    git config --get hooks.$1.$2 > /dev/null
    if [ $? -ne 0 ]
    then
        echo "$2 configuration key of the $1 plugin must be set."
        echo "You may set it like this : git config hooks.$1.$2 some_value"
        return 2
    fi
    local output=$(git config --get hooks.$1.$2)
    eval $__resultvar="'$output'"
    return 0
}

