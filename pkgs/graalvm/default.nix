{ graalvm11-ce }:

graalvm11-ce.overrideAttrs(oldAttrs: {
  # from https://github.com/NixOS/nixpkgs/pull/110567
  installPhase = graalvm11-ce.installPhase + ''
    # jni.h expects jni_md.h to be in the header search path.
    [ -d $out/include/linux/ ] && ln -s $out/include/linux/*_md.h $out/include/
    [ -d $out/include/darwin/ ] && ln -s $out/include/darwin/*_md.h $out/include/
  '';
})
