#!/usr/bin/env ruby

require 'chef/knife'

module KnifePlugins
  class CookbookReadmeFrom < Chef::Knife
    deps do
      require 'chef/cookbook/metadata'
      require 'erubis'
      require 'pathname'
    end

    banner 'knife cookbook readme from FILE (options)'

    option :constraints,
           :short       => '-c',
           :long        => '--constraints',
           :boolean     => true,
           :default     => false,
           :description => 'Show version constraints for platforms and dependencies'

    option :template_file,
           :short       => '-t',
           :long        => '--template FILE',
           :default     => File.expand_path("../README.md.erb",
                                            Pathname.new(__FILE__).realpath),
           :description => 'Set template file to use'

    def run
      metadata_file = name_args.first
      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file(metadata_file)

      controller = Controller.new(metadata, config[:constraints])
      template = File.read(config[:template_file])
      eruby = Erubis::Eruby.new(template)
      result = eruby.result(controller.get_binding)

      ui.output(result)
    end
  end

  class Controller
    DEFAULT_CONSTRAINT = ">= 0.0.0".freeze

    def initialize(metadata, constraints=false)
      @metadata = metadata
      @constraints = constraints
    end

    def description
      @metadata.description
    end

    def platforms
      @metadata.platforms.map do |platform, version|
        format_constraint(platform.capitalize, version)
      end
    end

    def dependencies
      @metadata.dependencies.map do |cookbook, version|
        format_constraint(cookbook, version)
      end
    end

    def attributes
      @metadata.attributes.map do |attr, options|
        name = "node['#{attr.gsub("/", "']['")}']"
        [name, options['description'], options['default']]
      end
    end

    def recipes
      @metadata.recipes
    end

    def author
      @metadata.maintainer
    end

    def author_email
      @metadata.maintainer_email
    end

    def copyright_year
      Time.now.year
    end

    def license
      @metadata.license
    end

    def get_binding
      binding
    end

    private

    def format_constraint(name, version)
      if @constraints && version != DEFAULT_CONSTRAINT
        "#{name} (#{version})"
      else
        name
      end
    end
  end
end
