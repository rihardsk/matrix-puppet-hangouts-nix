# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3 -e hangups
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell hasAttr optionalString;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
    # patching pip so it does not try to remove files when running nix-shell
    # overrides =
    #   self: super: {
    #     bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
    #       patchPhase = (optionalString (hasAttr "patchPhase" old) old.patchPhase) + ''
    #         sed -i               -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"                  $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
    #       '';
    #     });
    #   };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable}               python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs //                                            { meta = drv.meta; });
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "ConfigArgParse" = python.mkDerivation {
      name = "ConfigArgParse-0.11.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/45/87/a815edcdc867de0964e5f1efef6db956bbb6fe77dbe3f273f2aeab39cbe8/ConfigArgParse-0.11.0.tar.gz"; sha256 = "6c8ae823f6844b055f2a3aa9b51f568ed3bd7e5be9fba63abcaf4bdd38a0ac89"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/bw2/ConfigArgParse";
        license = licenses.mit;
        description = "A drop-in replacement for argparse that allows options to also be set via config files and/or environment variables.";
      };
    };



    "MechanicalSoup" = python.mkDerivation {
      name = "MechanicalSoup-0.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/50/ae/015244f26e2603b15f796fdd42aa99d20c9a395606900909e119a971fa8e/MechanicalSoup-0.6.0.zip"; sha256 = "e2b950c11fc5414d246b3c82024272d7ba729ab1f90534fc65fc445a63b7434d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."beautifulsoup4"
      self."requests"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/hickford/MechanicalSoup";
        license = licenses.mit;
        description = "A Python library for automating interaction with websites";
      };
    };



    "ReParser" = python.mkDerivation {
      name = "ReParser-1.4.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a7/eb/8bd06ddaeb3d5963abb0e2e2f14f2fa975b32fafe198254bfb4106ed9415/ReParser-1.4.3.tar.gz"; sha256 = "e69caf58a29d6e04723f6a7a456d304b7acfcf413957dafcd90ee49eccc2d15a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/xmikos/reparser";
        license = licenses.mit;
        description = "Simple regex-based lexer/parser for inline markup";
      };
    };



    "aiohttp" = python.mkDerivation {
      name = "aiohttp-3.6.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/10/28/ab9decdf95f0b2babe509f264ca531fd6c910615e0b4be5f240dba500832/aiohttp-3.6.1.tar.gz"; sha256 = "fc55b1fec0e4cc1134ffb09ea3970783ee2906dc5dfd7cd16917913f2cfed65b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."async-timeout"
      self."attrs"
      self."chardet"
      self."multidict"
      self."yarl"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/aiohttp";
        license = licenses.asl20;
        description = "Async http client/server framework (asyncio)";
      };
    };



    "appdirs" = python.mkDerivation {
      name = "appdirs-1.4.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/48/69/d87c60746b393309ca30761f8e2b49473d43450b150cb08f3c6df5c11be5/appdirs-1.4.3.tar.gz"; sha256 = "9e5896d1372858f8dd3344faf4e5014d21849c756c8d5701f78f8a103b372d92"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ActiveState/appdirs";
        license = licenses.mit;
        description = "A small Python module for determining appropriate platform-specific dirs, e.g. a \"user data dir\".";
      };
    };



    "async-timeout" = python.mkDerivation {
      name = "async-timeout-3.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a1/78/aae1545aba6e87e23ecab8d212b58bb70e72164b67eb090b81bb17ad38e3/async-timeout-3.0.1.tar.gz"; sha256 = "0c3c816a028d47f659d6ff5c745cb2acf1f966da1fe5c19c77a70282b25f4c5f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/async_timeout/";
        license = licenses.asl20;
        description = "Timeout context manager for asyncio programs";
      };
    };



    "attrs" = python.mkDerivation {
      name = "attrs-19.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/bd/69/2833f182ea95ea1f17e9a7559b8b92ebfdf4f68b5c58b15bc10f47bc2e01/attrs-19.2.0.tar.gz"; sha256 = "f913492e1663d3c36f502e5e9ba6cd13cf19d7fab50aa13239e420fef95e1396"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };



    "beautifulsoup4" = python.mkDerivation {
      name = "beautifulsoup4-4.8.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/23/7b/37a477bc668068c23cb83e84191ee03709f1fa24d957b7d95083f10dda14/beautifulsoup4-4.8.0.tar.gz"; sha256 = "25288c9e176f354bf277c0a10aa96c782a6a18a17122dba2e8cec4a97e03343b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."soupsieve"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.crummy.com/software/BeautifulSoup/bs4/";
        license = licenses.mit;
        description = "Screen-scraping library";
      };
    };



    "certifi" = python.mkDerivation {
      name = "certifi-2019.9.11";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/62/85/7585750fd65599e88df0fed59c74f5075d4ea2fe611deceb95dd1c2fb25b/certifi-2019.9.11.tar.gz"; sha256 = "e4f3620cfea4f83eedc95b24abd9cd56f3c4b146dd0177e83a21b4eb49e21e50"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };



    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"; sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };



    "hangups" = python.mkDerivation {
      name = "hangups-0.4.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/98/e1/809ced9bbab2356a381465201d02017c12819999c9776dc4bd3293713bc9/hangups-0.4.9.tar.gz"; sha256 = "4a29b30aa1cb3650b825dfc88c8147dc88a83b11226d6875f54192c6508984cb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ConfigArgParse"
      self."MechanicalSoup"
      self."ReParser"
      self."aiohttp"
      self."appdirs"
      self."async-timeout"
      self."protobuf"
      self."readlike"
      self."requests"
      self."urwid"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tdryer/hangups";
        license = licenses.mit;
        description = "the first third-party instant messaging client for Google Hangouts";
      };
    };



    "idna" = python.mkDerivation {
      name = "idna-2.8";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"; sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };



    "multidict" = python.mkDerivation {
      name = "multidict-4.5.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7f/8f/b3c8c5b062309e854ce5b726fc101195fbaa881d306ffa5c2ba19efa3af2/multidict-4.5.2.tar.gz"; sha256 = "024b8129695a952ebd93373e45b5d341dbb87c17ce49637b34000093f243dd4f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/multidict";
        license = licenses.asl20;
        description = "multidict implementation";
      };
    };



    "protobuf" = python.mkDerivation {
      name = "protobuf-3.6.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1b/90/f531329e628ff34aee79b0b9523196eb7b5b6b398f112bb0c03b24ab1973/protobuf-3.6.1.tar.gz"; sha256 = "1489b376b0f364bcc6f89519718c057eb191d7ad6f1b395ffd93d1aa45587811"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://developers.google.com/protocol-buffers/";
        license = "3-Clause BSD License";
        description = "Protocol Buffers";
      };
    };



    "readlike" = python.mkDerivation {
      name = "readlike-0.1.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/03/a4/8267929e370c0167b138df47ee120fc79f820b2f4d0791f611d934921552/readlike-0.1.2.tar.gz"; sha256 = "08645493a24eecbcad70a5ed7fbf1a3820ba5e57e9690297edc485c2992f66b2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://jangler.info/code/readlike";
        license = licenses.mit;
        description = "GNU Readline-like line editing module";
      };
    };



    "requests" = python.mkDerivation {
      name = "requests-2.22.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz"; sha256 = "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."chardet"
      self."idna"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.12.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"; sha256 = "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "soupsieve" = python.mkDerivation {
      name = "soupsieve-1.9.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7f/4e/95a13527e18b6f1a15c93f1c634b86d5fa634c5619dce695f4e0cd68182f/soupsieve-1.9.4.tar.gz"; sha256 = "605f89ad5fdbfefe30cdc293303665eff2d188865d4dbe4eb510bba1edfbfce3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/facelessuser/soupsieve";
        license = licenses.mit;
        description = "A modern CSS selector implementation for Beautiful Soup.";
      };
    };



    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.6";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ff/44/29655168da441dff66de03952880c6e2d17b252836ff1aa4421fba556424/urllib3-1.25.6.tar.gz"; sha256 = "9a107b99a5393caf59c7aa3c1249c16e6879447533d0887f4336dde834c7be86"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."idna"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };



    "urwid" = python.mkDerivation {
      name = "urwid-1.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/85/5d/9317d75b7488c335b86bd9559ca03a2a023ed3413d0e8bfe18bea76f24be/urwid-1.3.1.tar.gz"; sha256 = "cfcec03e36de25a1073e2e35c2c7b0cc6969b85745715c3a025a31d9786896a1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://urwid.org/";
        license = licenses.lgpl2;
        description = "A full-featured console (xterm et al.) user interface library";
      };
    };



    "yarl" = python.mkDerivation {
      name = "yarl-1.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fb/84/6d82f6be218c50b547aa29d0315e430cf8a23c52064c92d0a8377d7b7357/yarl-1.3.0.tar.gz"; sha256 = "024ecdc12bc02b321bc66b41327f930d1c2c543fa9a561b39861da9388ba7aa9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."idna"
      self."multidict"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/yarl/";
        license = licenses.asl20;
        description = "Yet another URL library";
      };
    };

  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [

  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )
