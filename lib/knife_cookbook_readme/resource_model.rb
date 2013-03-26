module KnifeCookbookReadme
  class ResourceModel

    attr_reader :name
    attr_reader :native_resource

    def initialize(cookbook_name, file)
      @file = file
      @name = File.basename(file,'.rb')
      @native_resource = ::Chef::Resource::LWRPBase.build_from_file(cookbook_name, file, nil)
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
  end
end
