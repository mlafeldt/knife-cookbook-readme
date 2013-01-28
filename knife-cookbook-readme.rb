#!/usr/bin/env ruby
#
# Knife plugin to generate skeleton README.md from a cookbook's metadata.rb file
#
# Copyright (C) 2012-2013 Mathias Lafeldt <mathias.lafeldt@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
           :description => 'Include version constraints for platforms and dependencies'

    option :template_file,
           :short       => '-t',
           :long        => '--template FILE',
           :default     => File.expand_path("../README.md.erb",
                                            Pathname.new(__FILE__).realpath),
           :description => 'Set template file used to render README.md'

    def run
      unless (metadata_file = name_args.first)
        ui.fatal 'Please provide metadata.rb file as argument'
        exit(1)
      end

      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file(metadata_file)

      model = ReadmeModel.new(metadata, config[:constraints])
      template = File.read(config[:template_file])
      eruby = Erubis::Eruby.new(template)
      result = eruby.result(model.get_binding)

      ui.output(result)
    end
  end

  class ReadmeModel
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
