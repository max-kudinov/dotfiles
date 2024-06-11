function vpn --wraps='sudo openvpn /etc/openvpn/client/aws_vpn_auto.ovpn' --wraps='sudo openvpn /etc/openvpn/client/aws_vpn_auto.ovpn --config --daemon' --wraps='sudo openvpn --config /etc/openvpn/client/aws_vpn_auto.ovpn --daemon' --description 'alias vpn=sudo openvpn --config /etc/openvpn/client/aws_vpn_auto.ovpn --daemon'
  sudo openvpn --config /etc/openvpn/client/aws_vpn_auto.ovpn --daemon $argv
        
end
