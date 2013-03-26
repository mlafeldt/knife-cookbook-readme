module KnifeCookbookReadme
  class ResourceModel

    attr_reader :name
    attr_reader :native_resource

    def initialize(cookbook_name, file)
      @file = file
      @name = File.basename(file, '.rb')
      @native_resource = build_native_from_file(cookbook_name, file)
    end

    # Return the unique set of actions, with the default one first, if there is a default
    def actions
      unless @actions
        @actions = [default_action].compact + @native_resource.actions.sort.uniq.select { |a| a != default_action }
      end
      @actions
    end

    def default_action
      @native_resource.default_action
    end

    def action_description(action)
      ""
    end

    def attributes
      @native_resource.attribute_specifications.keys
    end

    def attribute_description(attribute)
      description = ""
      specification = @native_resource.attribute_specifications[attribute]
      if specification && specification.has_key?(:default)
        default_value = specification[:default].inspect.gsub(/(\\|\`|\*|\_|\{|\}|\[|\]|\(|\)|\#|\+|\-|\.|\!)/) {|a| "\\#{a}"}
        description = "#{description} Defaults to #{default_value}."
      end
      description
    end

    private

    include ::Chef::Mixin::ConvertToClassName

    def build_native_from_file(cookbook_name, filename)
      resource_class = Class.new(DocumentingLWRPBase)

      resource_class.resource_name = filename_to_qualified_string(cookbook_name, filename)
      resource_class.run_context = nil
      resource_class.class_from_file(filename)

      resource_class
    end
  end

  class DocumentingLWRPBase < ::Chef::Resource::LWRPBase

    class << self
      def attribute_specifications
        @attribute_specifications ||= {}
      end
    end

    def self.attribute(attr_name, validation_opts={})
      result = super(attr_name, validation_opts)
      attribute_specifications[attr_name] = validation_opts
      result
    end
  end
end
