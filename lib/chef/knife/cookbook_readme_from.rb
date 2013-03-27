require 'chef/knife'
require 'pathname'

module KnifeCookbookReadme
  class CookbookReadmeFrom < Chef::Knife
    deps do
      require 'chef/cookbook/metadata'
      require 'erubis'
      require 'knife_cookbook_readme/readme_model'
      require 'knife_cookbook_readme/resource_model'
    end

    banner 'knife cookbook readme from FILE (options)'

    option :constraints,
           :short       => '-c',
           :long        => '--constraints',
           :boolean     => true,
           :default     => true,
           :description => 'Include version constraints for platforms and dependencies'

    option :output_file,
           :short       => '-o',
           :long        => '--output-file FILE',
           :default     => 'README.md',
           :description => 'Set the output file to render to relative to metadata.rb. Defaults to README.md'

    option :template_file,
           :short       => '-t',
           :long        => '--template FILE',
           :default     => Pathname.new("#{File.dirname(__FILE__)}/README.md.erb").realpath,
           :description => 'Set template file used to render README.md'

    def run
      unless (metadata_file = name_args.first)
        ui.fatal 'Please provide metadata.rb file as argument'
        exit(1)
      end

      cookbook_dir = File.dirname(metadata_file)

      metadata = Chef::Cookbook::Metadata.new
      metadata.from_file(metadata_file)

      resources = []
      Dir["#{cookbook_dir}/resources/*.rb"].each do |resource_filename|
        resources << ResourceModel.new(metadata.name, resource_filename)
      end

      model = ReadmeModel.new(metadata, config[:constraints], resources)

      template = File.read(config[:template_file])
      eruby = Erubis::Eruby.new(template)
      result = eruby.result(model.get_binding)

      File.open("#{cookbook_dir}/#{config[:output_file]}",'wb') do |f|
        f.write result
      end
    end
  end
end
