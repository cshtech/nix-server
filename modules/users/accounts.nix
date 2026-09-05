{ config, pkgs, ... }:
{


  
  ####################################################################################################
  # User Accounts
  ####################################################################################################


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."csh" = {
    isNormalUser = true;
    description = "csh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    openssh.authorizedKeys.keyFiles = [
      # ./secrets/authorized_keys
      ../../secrets/authorized_keys
    ];
  };



}
