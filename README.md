knife-cookbook-readme
=====================

Knife plugin to generate skeleton `README.md` from a cookbook's `metadata.rb` file


Installation
------------

Clone the repository and copy the plugin files to your home chef directory:

    $ git clone git://github.com/mlafeldt/knife-cookbook-readme.git
    $ cd knife-cookbook-readme/
    $ mkdir -p ~/.chef/plugins/knife/
    $ cp knife-cookbook-readme.rb README.md.erb ~/.chef/plugins/knife/

Afterwards, the new knife command `knife cookbook readme from FILE` will be
available.


Usage
-----

    knife cookbook readme from FILE (options)

        -c, --constraints                Include version constraints for platforms and dependencies
        -t, --template FILE              Set template file used to render README.md

    Examples:

        knife cookbook readme from path/to/metadata.rb
        knife cookbook readme from path/to/metadata.rb --constraints >README.md
        knife cookbook readme from path/to/metadata.rb --template README.md.erb


Note that the command will write the generated output to STDOUT. Simply redirect
the output to `README.md` to write to a file.


License
-------

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


Contact
-------

* Web: <https://github.com/mlafeldt/knife-cookbook-readme>
* Mail: <mathias.lafeldt@gmail.com>
* Twitter: [@mlafeldt](https://twitter.com/mlafeldt)
