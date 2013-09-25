name              "git"
maintainer        "Mathias Lafeldt"
maintainer_email  "mathias.lafeldt@gmail.com"
license           "Apache 2.0"
description       "Installs Git from source and optionally configures it"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.1.1"
recipe            "git::source", "Installs Git from source"
recipe            "git::config", "Provisions a system-wide Git config"

supports "ubuntu"
supports "debian"

depends "build-essential"
