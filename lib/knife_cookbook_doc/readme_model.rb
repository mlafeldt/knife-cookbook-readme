module KnifeCookbookDoc
  class ReadmeModel
    DEFAULT_CONSTRAINT = ">= 0.0.0".freeze

    def initialize(cookbook_dir, constraints)

      @metadata = Chef::Cookbook::Metadata.new
      @metadata.from_file("#{cookbook_dir}/metadata.rb")

      @resources = []
      Dir["#{cookbook_dir}/resources/*.rb"].sort.each do |resource_filename|
        @resources << ResourceModel.new(@metadata.name, resource_filename)
      end

      @fragments = {}
      Dir["#{cookbook_dir}/doc/*.md"].sort.each do |resource_filename|
        @fragments[::File.basename(resource_filename,'.md')] = IO.read(resource_filename)
      end

      @recipes = []
      @metadata.recipes.each do |name, description|
        @recipes << RecipeModel.new(name, description, "#{cookbook_dir}/recipes/#{name.gsub(/^.*\:(.*)$/,'\1')}.rb")
      end
      @metadata = @metadata
      @constraints = constraints
    end

    def fragments
      @fragments
    end

    def resources
      @resources
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

    def recommendations
      @metadata.recommendations.map do |cookbook, version|
        format_constraint(cookbook, version)
      end
    end

    def suggestions
      @metadata.suggestions.map do |cookbook, version|
        format_constraint(cookbook, version)
      end
    end

    def conflicting
      @metadata.conflicting.map do |cookbook, version|
        format_constraint(cookbook, version)
      end
    end

    def attributes
      @metadata.attributes.map do |attr, options|
        name = "node['#{attr.gsub("/", "']['")}']"
        [name, options['description'], options['default'], options['choice']]
      end
    end

    def recipes
      @recipes
    end

    def maintainer
      @metadata.maintainer
    end

    def maintainer_email
      @metadata.maintainer_email
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
