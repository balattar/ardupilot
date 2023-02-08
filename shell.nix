{ pkgs ? import <nixpkgs> { } }:

let pythonPackages = with pkgs.python3Packages; [
    pip
    pyserial
    future
    empy
    pexpect
    setuptools
    # dronecan
];
in
with pkgs; mkShell {
  name = "env";
  #   nativeBuildInputs = [ cmake ];
  buildInputs =  [
    genromfs
    gcc-arm-embedded
    gawk
    git
    gcc
  ] ++ pythonPackages;
  
  shellHook = ''
    # ./Tools/gittools/submodule-sync.sh
    export PYTHONPATH=$PWD/modules/DroneCAN/pydronecan:$PYTHONPATH
    ./waf distclean
    # CFLAGS="-arch x86_64" CXXFLAGS="-arch x86_64" LDFLAGS="-arch x86_64" \
    ./waf configure --board CubeOrange --debug && ./waf copter
  '';
}
