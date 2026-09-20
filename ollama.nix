{pkgs, libs, ...}:
{
services.ollama = {
  enable = true;
  
  # 1. Use the dedicated host option instead of environmentVariables
  host = "0.0.0.0"; 
  
  # 2. Tell NixOS to open port 11434 in the firewall automatically
  openFirewall = true; 
};
  # Enable Open WebUI service
  services.open-webui = {
    enable = true;
    # Open WebUI listens on port 8080 by default
    port = 8080; 
  };
}
