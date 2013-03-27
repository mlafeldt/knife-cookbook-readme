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

#### Step 1

Populate the `metadata.rb` of your cookbook according to Opscode's
[documentation](http://docs.opscode.com/config_rb_metadata.html). Particular
attention should be paid to documenting the recipes, attributes, platform
compatibility and cookbook requirements (i.e. depends, recommends, suggests etc).

#### Step 2

At the top of each cookbook, add a detailed documentation section such as;

    =begin
    #<
    The recipe is awesome. It does thing 1, thing 2 and thing 3!
    #>
    =end

#### Step 3

In each LWRP, add detailed documentation such as;

    =begin
    #<
    This creates and destroy the awesome service.

    @action create  Create the awesome service.
    @action destroy Destroy the awesome service.

    @section Examples

        # An example of my awesome service
        mycookbook_awesome_service "my_service" do
          port 80
        end
    #>
    =end

    ...

    #<> @attribute port The port on which the HTTP service will bind.
    attribute :port, :kind_of => Integer, :default => 8080

It should be noted that the documentation of the LWRP requires that the user
document the actions, using `@action <action> <description>` and the attributes
using `@attribute <attribute> <description>` so that there is meaningful
descriptions for the actions and attributes in the generated README.

The documentation will be added at the start of the LWRP documentation
except if marked with `@section <heading>`, in which case it will be added
to the head of the LWRP documentation.

#### Step 4

Finally the user should add some documentation fragments into the `doc/` dir.
Most importantly you should add `doc/overview.md` which will be included at the
start of the readme. The remaining fragments will be included at the end of the
readme.

#### Step 5


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

#### Single line comments

    #<> This is some documentation

#### Multi-line comments using begin/end

    =begin
    #<
    This is some documentation
    #>
    =end

#### Multi-line comments without using begin/end

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
