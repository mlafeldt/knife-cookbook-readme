require 'chef/knife'
require 'pathname'

module KnifeCookbookReadme
  class CookbookReadmeFrom < Chef::Knife
    deps do
      require 'knife_cookbook_readme'
    end

    banner 'knife cookbook readme from FILE (options)'

    option :template_file,
           :short       => '-t',
           :long        => '--template FILE',
           :default     => File.expand_path('../../../../template/README.md.erb',
                                            Pathname.new(__FILE__).realpath),
           :description => 'Set template file used to render README.md'

    def run
      metadata_file = name_args.first
      template_file = config[:template_file]

      unless metadata_file
        ui.fatal 'Please provide metadata.rb file as argument'
        exit 1
      end

      metadata = Metadata.from_file(metadata_file)
      template = File.read(template_file)
      result = Readme.new(metadata).render(template)

      ui.output(result)
    end
  end
end
