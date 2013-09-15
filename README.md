knife-cookbook-readme
=====================

This is a Knife plugin to generate a skeleton `README.md` file from a cookbook's
[metadata.rb](http://docs.opscode.com/essentials_cookbook_metadata.html) file.

- create the first bits of documentation you can build upon
- write documentation that is consistent among your or your team's cookbooks
- implement the [DRY/SPOT](http://c2.com/cgi/wiki?DontRepeatYourself) rule
  (`metadata.rb` is the authoritative source of information)


Installation
------------

You can install the plugin via RubyGems:

    $ gem install knife-cookbook-readme

Alternatively, you can install the plugin from source:

    $ git clone git://github.com/mlafeldt/knife-cookbook-readme.git
    $ cd knife-cookbook-readme/
    $ bundle install
    $ bundle exec rake install

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


Alternatives
------------

Here is a list of other documentation tools for Chef (sorted alphabetically):

* [knife-cookbook-doc](https://github.com/realityforge/knife-cookbook-doc)
  (based on knife-cookbook-readme,
  [blog post](http://realityforge.org/code/2013/04/01/documenting-cookbooks.html))
* [yard-chef](https://github.com/rightscale/yard-chef)


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


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


Contact
-------

* Web: <http://mlafeldt.github.com/knife-cookbook-readme>
* Mail: <mathias.lafeldt@gmail.com>
* Twitter: [@mlafeldt](https://twitter.com/mlafeldt)
