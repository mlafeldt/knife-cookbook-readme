module KnifeCookbookReadme
  class ReadmeModel
    DEFAULT_CONSTRAINT = ">= 0.0.0".freeze

    def initialize(metadata, constraints, resources)
      @metadata = metadata
      @constraints = constraints
      @resources = resources
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

    def attributes
      @metadata.attributes.map do |attr, options|
        name = "node['#{attr.gsub("/", "']['")}']"
        [name, options['description'], options['default']]
      end
    end

    def recipes
      @metadata.recipes
    end

    def maintainer
      @metadata.maintainer
    end

    def maintainer_email
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
