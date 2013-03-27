module KnifeCookbookReadme
  class ResourceModel

    attr_reader :name
    attr_reader :native_resource

    def initialize(cookbook_name, file)
      @file = file
      @name = File.basename(file, '.rb')
      @native_resource = build_native_from_file(cookbook_name, file)
      load_descriptions
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
      description = [action_descriptions[action.to_s]]
      if default_action == action
        description << "Default Action."
      end
      description.compact.join(' ')
    end

    def action_descriptions
      @action_descriptions ||= {}
    end

    def attributes
      @native_resource.attribute_specifications.keys
    end

    def attribute_description(attribute)
      description = [attribute_descriptions[attribute.to_s]]

      specification = @native_resource.attribute_specifications[attribute]
      if specification && specification.has_key?(:default)
        default_value = specification[:default].inspect.gsub(/(\\|\`|\*|\_|\{|\}|\[|\]|\(|\)|\#|\+|\-|\.|\!)/) { |a| "\\#{a}" }
        description << "Defaults to #{default_value}."
      end

      description.compact.join(' ')
    end

    def attribute_descriptions
      @attribute_descriptions ||= {}
    end

    def top_level_description(section)
      (top_level_descriptions[section.to_s] || []).join("\n")
    end

    def top_level_descriptions
      @top_level_descriptions ||= {}
    end

    private

    def load_descriptions
      current_section = 'main'
      @native_resource.description.each_line do |line|
        if /^ *\@action ([^ ]*) (.*)$/ =~ line
          action_descriptions[$1] = $2.strip
        elsif /^ *\@attribute ([^ ]*) (.*)$/ =~ line
          attribute_descriptions[$1] = $2.strip
        elsif /^ *\@section ([^ ]*) *$/ =~ line
          current_section = $1.strip
        else
          lines = (top_level_descriptions[current_section] || [])
          lines << line.chomp
          top_level_descriptions[current_section] = lines
        end
      end
    end

    include ::Chef::Mixin::ConvertToClassName

    def build_native_from_file(cookbook_name, filename)
      resource_class = Class.new(DocumentingLWRPBase)

      resource_class.resource_name = filename_to_qualified_string(cookbook_name, filename)
      resource_class.run_context = nil
      resource_data = IO.read(filename)
      resource_data = resource_data.gsub(/^=begin *\n *\#\<\n(.*?)^ *\#\>\n=end *\n/m) do
        "desc <<DOCO\n#{$1}\nDOCO\n"
      end
      resource_data = resource_data.gsub(/^ *\#\<\n(.*?)^ *\#\>\n/m) do
        "desc <<DOCO\n#{$1.gsub(/^ *\# ?/, '')}\nDOCO\n"
      end
      resource_data = resource_data.gsub(/^ *\#\<\> (.*?)$/) do
        "desc #{$1.inspect}\n"
      end

      resource_class.class_eval(resource_data, filename, 1)

      resource_class
    end
  end

  class DocumentingLWRPBase < ::Chef::Resource::LWRPBase

    class << self
      def attribute_specifications
        @attribute_specifications ||= {}
      end

      def desc(description)
        @description = "#{@description}#{description}\n"
      end

      def description
        @description || ""
      end
    end

    def self.attribute(attr_name, validation_opts={})
      result = super(attr_name, validation_opts)
      attribute_specifications[attr_name] = validation_opts
      result
    end
  end
end
