{ config, pkgs, ...}:
{


  
  
  ####################################################################################################
  # Packages
  ####################################################################################################
  
  environment.systemPackages = with pkgs; [
    
    # Editors
    vim helix
    
    # Network Utils
    wget   
 
    # Terminal Utils
    tree unzip fzf jq fastfetch

    # Rust Utils
    bat eza fd ripgrep zoxide

  ];


  # EOF
  ####################################################################################################



}
