---
to: src/install_<%= name || 'sample' %>.sh
---
#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "<%= name %>" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt install -y <%= name %>
            ;;
        osx)
            brew install <%= name %>
            ;;
    esac
fi
