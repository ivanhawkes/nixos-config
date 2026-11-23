{ config, pkgs, ... }:

let
  # Hosts that run the NVIDIA driver get Blender built with CUDA and OptiX, so Cycles
  # renders on the graphics cards, with or without a display. The plain build has no GPU
  # kernels and does not look in /run/opengl-driver for the driver's libraries.
  nvidia = builtins.elem "nvidia" config.services.xserver.videoDrivers;
in
{
  environment.systemPackages = [
    (
      if nvidia then
        # Not in the binary cache (CUDA is unfree): this compiles Blender, OpenUSD and
        # OpenImageDenoise, about 50 minutes on lythir, once per nixpkgs update that
        # touches them. Only the kernel for the RTX 50 series (sm_120) is built; a host
        # with an older NVIDIA card needs its own architecture added here.
        pkgs.blender.override {
          cudaSupport = true;
          cudaArches = [ "sm_120" ];
        }
      else
        pkgs.blender
    )
  ];
}
