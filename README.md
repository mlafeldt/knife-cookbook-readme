knife-cookbook-doc
==================

This is a Knife plugin to generate a skeleton `README.md` file from a cookbook's
`metadata.rb` file.

The plugin helps to

- create the first bits of documentation you can build upon
- write documentation that is consistent among your or your team's cookbooks
- implement the [DRY/SPOT](http://c2.com/cgi/wiki?DontRepeatYourself) rule
  (`metadata.rb` is the authoritative source of information)


Installation
------------

You can install the plugin via RubyGems:

    $ gem install knife-cookbook-doc

Alternatively, you can install the plugin from source:

    $ git clone git://github.com/realityforge/knife-cookbook-doc.git
    $ cd knife-cookbook-doc/
    $ bundle install
    $ bundle exec rake install

Afterwards, the new knife command `knife cookbook doc DIR` will be available.


Usage
-----

    knife cookbook doc COOKBOOK_DIR (options)

        -o, --output-file FILE           Set the output file to render to relative to cookbook dir. Defaults to README.md
        -t, --template FILE              Set template file used to render README.md

    Examples:

        knife cookbook readme from path/to/cookbook
        knife cookbook readme from path/to/cookbook --template README.md.erb

Credit
------

The plugin was originally written by Mathias Lafeldt as a way to create
initial README.md from the metadata.rb. It was subsequently rewritten by
Peter Donald to gather information from the other files within the cookbook.
All credit to Mathias for his wonderful idea.
