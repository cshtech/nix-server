{ config, pkgs, ... }:

{

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  # Enable the Tailscale daemon
  # services.tailscale.enable = true;

  #   services.tailscale = {
  #   enable = true;
  #   # Required on NixOS to permit the server to route outbound network packets
  #   useRoutingFeatures = "server"; 
  # };

  # Ensure the host OS allows IP packet forwarding globally
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };


  # Optional: open the default firewall port for Tailscale
  # networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # Optional: install the tailscale CLI utility into your system environment
  environment.systemPackages = [ pkgs.tailscale ];




  # # 1. Enable Tailscale and open its native UDP port
  # services.tailscale = {
  #   enable = true;
  #   useRoutingFeatures = "server"; # Allows the server to act as an Exit Node
  # };
  # networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # # 2. Enable IP Forwarding at the host kernel level
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };

  # # 3. Configure the firewall to perform Network Address Translation (NAT)
  # # This takes the incoming internet traffic from your phone and routes it out to the web
  # networking.nat = {
  #   enable = true;
  #   externalInterface = "enp2s0"; # ⚠️ Change this to match your main host network interface (e.g. wlan0, enp3s0)
  #   internalInterfaces = [ "tailscale0" ];
  # };




  # # 1. Enable Tailscale and authorize routing features natively
  # services.tailscale = {
  #   enable = true;
  #   useRoutingFeatures = "server"; # Explicitly authorizes system exit node routing
  # };
  # networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # # 2. Turn on Kernel Packet Forwarding globally
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };

  # # 3. Configure Network Address Translation (NAT) to forward your phone's traffic
  # networking.nat = {
  #   enable = true;
  #   externalInterface = "enp2s0"; # Your confirmed host internet adapter
  #   internalInterfaces = [ "tailscale0" ];
  # };


  # # 1. Enable Tailscale and authorize routing features natively
  # services.tailscale = {
  #   enable = true;
  #   useRoutingFeatures = "server"; # Allows the server to act as an Exit Node
  # };
  # networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # # 2. FIX: Set Reverse Path Filtering to "loose" so NixOS allows the exit node traffic
  # # networking.firewall.enable = true;
  # # networking.firewall.checkReversePath = "loose";
  # # networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # networking.firewall = {
  #   enable = true;
  #   trustedInterfaces = [ "tailscale0" ];
  #   checkReversePath = "loose";
  
  #   # Force NAT masquerading from Tailscale interface to your ethernet card
  #   extraCommands = ''
  #     iptables -t nat -A POSTROUTING -o enp2s0 -j MASQUERADE
  #     iptables -A FORWARD -i tailscale0 -o enp2s0 -j ACCEPT
  #     iptables -A FORWARD -i enp2s0 -o tailscale0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  #   '';
  # };

  # # Official NixOS method to configure UDP GRO forwarding cleanly across boots
  # services.networkd-dispatcher = {
  #   enable = true;
  #   rules."50-tailscale-optimizations" = {
  #     onState = [ "routable" ];
  #     script = ''
  #       ${pkgs.ethtool}/bin/ethtool -K enp2s0 rx-udp-gro-forwarding on rx-gro-list off || true
  #     '';
  #   };
  # };

  # # 3. Turn on Kernel Packet Forwarding globally
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };

  # # Fix the Tailscale UDP GRO forwarding warning permanently
  # boot.postBootCommands = ''
  #   ${pkgs.ethtool}/bin/ethtool -K enp2s0 rx-udp-gro-forwarding on rx-gro-list off
  # '';


  # # Force network optimizations directly on the interface configuration
  # # networking.interfaces.enp2s0.ethtool.settings = {
  # #   rx-udp-gro-forwarding = true;
  # #   rx-gro-list = false;
  # # };

  # # 4. Standard NAT setup for your internet exit interface
  # networking.nat = {
  #   enable = true;
  #   externalInterface = "enp2s0"; 
  #   internalInterfaces = [ "tailscale0" ];
  # };







  # 1. Enable Tailscale and authorize routing features natively
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server"; # Handles kernel sysctl parameters and routing flags cleanly
  };
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # 2. Configure Firewall, Path Filtering, and Native NAT Translation
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";    # Crucial: Allows asymmetric response routes
  };

  # Use the native NixOS NAT module instead of raw iptables text blocks
  networking.nat = {
    enable = true;
    externalInterface = "enp2s0";
    internalInterfaces = [ "tailscale0" ];
  };

  # 3. Clean up the UDP GRO optimization fix into one reliable systemd boot service
  # (This completely eliminates the networkd-dispatcher and postBootCommands conflicts)
  systemd.services.tailscale-gro-fix = {
    description = "Tailscale UDP GRO Forwarding Fix for enp2s0";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.ethtool}/bin/ethtool -K enp2s0 rx-udp-gro-forwarding on rx-gro-list off";
    };
  };



 # to trick the server into thinking a monitor is attached, so i never freezes again
  boot.kernelParams = [
    "video=HDMI-a-1:1920*1080@60e"
  ];

















  
  
}
