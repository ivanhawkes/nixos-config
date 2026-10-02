{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Local inference requirements.
    (llama-cpp.override { cudaSupport = true; })
    nvtopPackages.nvidia
  ];
}
