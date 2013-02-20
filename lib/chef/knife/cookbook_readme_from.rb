require 'chef/knife'
require 'pathname'

module KnifeCookbookReadme
  class CookbookReadmeFrom < Chef::Knife
    deps do
      require 'chef/cookbook/metadata'
      require 'erubis'
      require 'knife_cookbook_readme/readme_model'
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
           :default     => File.expand_path('../../../../templates/README.md.erb',
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
end
