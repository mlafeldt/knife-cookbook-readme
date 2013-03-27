# knife-cookbook-doc

This is a knife plugin to help create and maintain a README.md for a cookbook.
As much as possible the plugin makes use of the same metadata as used by chef
when generating the documentation. The plugin will also scan the source files
for annotations present in comments. Users can also add fragments of markdown
into the doc/ directory to merge into the generated README.md file.

The goal is to keep the code as the authoritative source of information. The
hope is that keeping the documentation close to the code will help to maintain
it's currency.

## Getting Started


## Installation

You can install the plugin via RubyGems:

    $ gem install knife-cookbook-doc

Alternatively, you can install the plugin from source:

    $ git clone git://github.com/realityforge/knife-cookbook-doc.git
    $ cd knife-cookbook-doc/
    $ bundle install
    $ bundle exec rake install

Afterwards, the new knife command `knife cookbook doc DIR` will be available.

## Usage

    knife cookbook doc COOKBOOK_DIR (options)

        -o, --output-file FILE           Set the output file to render to relative to cookbook dir. Defaults to README.md
        -t, --template FILE              Set template file used to render README.md

    Examples:

        knife cookbook doc path/to/cookbook
        knife cookbook doc path/to/cookbook --template README.md.erb

## Further Details

The documentation is generated from the following sources;

* `metadata.rb` is the source for attribute, recipe and cookbook metadata.
* Detailed documentation for each recipe is included in comments in the recipe.
* LWRP resource files (`resources/*.rb`) define the set of actions and attributes
  supported by the LWRP.
* The LWRP resource files (`resources/*.rb`) also include detailed documentation
  about the LWRP, it's actions and it's parameters in comments.

### Documentation in comments

The documentation stored in comments comes in three forms;

- Single line comments

      #<> This is some documentation

- Multi-line comments using begin/end

      =begin
      #<
      This is some documentation
      #>
      =end

- Multi-line comments without using begin/end

      #<
      # This is some documentation
      #>

This is a knife plugin to help create and maintain a README.md for a cookbook.
The plugin uses metadata present in the `metadata.rb` file as well as the
LWRP resource files (resources/*.rb) to generate the readme. The plugin also
uses annotations present in the comments of the source files to collect metadata
that is not yet exposed as code.

 It is also possible to include fragments
of markdown retrieved from the doc/ directory for when the documentation can not be
derived from the code.

## Credit

The plugin was originally written by Mathias Lafeldt as a way to create
initial README.md from the metadata.rb. It was subsequently rewritten by
Peter Donald to gather information from the other files within the cookbook.
All credit to Mathias for his wonderful idea.
