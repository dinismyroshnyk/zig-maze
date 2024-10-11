{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = with pkgs; [
        zig
        pkg-config
        xorg.libX11
        xorg.libXrandr
        xorg.libXi
        xorg.libXcursor
        xorg.libXinerama
        libGL
        libGLU
        alsa-lib
        wayland
        wayland-protocols
        libxkbcommon
    ];

    shellHook = ''
        export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
            pkgs.libGL
            pkgs.xorg.libX11
            pkgs.xorg.libXrandr
            pkgs.xorg.libXi
            pkgs.xorg.libXcursor
            pkgs.xorg.libXinerama
            pkgs.wayland
            pkgs.libxkbcommon
        ]}:$LD_LIBRARY_PATH

        # Unset NIX_CFLAGS_COMPILE to avoid Zig warnings
        unset NIX_CFLAGS_COMPILE

        # Zig-specific environment variables
        export ZIG_SYSTEM_LINKER_HACK=1

        # Aliases
        alias cls='clear'
        alias build='zig build'
        alias run='zig build run'
    '';
}