require 'chef/knife'
require 'pathname'

module KnifeCookbookReadme
  class CookbookReadmeFrom < Chef::Knife
    deps do
      require 'knife_cookbook_readme/metadata'
      require 'knife_cookbook_readme/readme'
      require 'knife_cookbook_readme/template'
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
           :default     => File.expand_path('../../../../template/README.md.erb',
                                            Pathname.new(__FILE__).realpath),
           :description => 'Set template file used to render README.md'

    def run
      metadata_file = name_args.first
      template_file = config[:template_file]
      constraints   = config[:constraints]

      unless metadata_file
        ui.fatal 'Please provide metadata.rb file as argument'
        exit 1
      end

      metadata = Metadata.from_file(metadata_file)
      template = File.read(template_file)
      readme = Readme.new(metadata, constraints)
      result = readme.render(template)

      ui.output(result)
    end
  end
end
