#!/bin/zsh

log_tag='ProxyAutoToggle'
ssid='kuroken_network'
find-ssid() {
  if nmcli -t -f name connection show --active | grep $ssid >/dev/null; then
      return 0
  fi
  return 1
}

kde-proxy-toggle() {
  user="${1:? username}"
  mode="${2:? 0 or 1}"
  sudo --user="${user}" --group="${user}" kwriteconfig5 --file kioslaverc --group 'Proxy Settings' --key ProxyType "${mode}"
  sudo --user="${user}" --group="${user}" dbus-send --type=signal /KIO/Scheduler org.kde.KIO.Scheduler.reparseSlaveConfiguration string:''
}

if find-ssid; then
    logger "user: ${user}"
    kde-proxy-toggle "${user}" 1
else
    logger "proxy: disable"
    kde-proxy-toggle "${user}" 0
fi
logger -p user.notice -t "${log_tag}" "configuration done."

