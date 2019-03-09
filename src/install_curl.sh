case ${info[0]} in
    osx)
        brew install curl
        ;;
    debian|ubuntu)
        sudo -E apt-get install -y curl
        ;;
esac