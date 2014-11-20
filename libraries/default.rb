class Chef
  class Recipe
    def skip_unsupported_platform
      unless supported_platform?
        Chef::Log.info("Unsupported platform #{node[:platform]} in #{cookbook_name}::#{recipe_name}, skipping recipe")
        Chef::Log.debug("You said to skip unsupported platforms in #{cookbook_name}::#{recipe_name}")
        Chef::Log.debug("and #{node['platform']} is unsupported by cookbook #{cookbook_name}. Update the cookbook's metadata")
        Chef::Log.debug("if this is a supported platform, or remove #{cookbook_name}::#{recipe_name} from the node.")
      end
    end

    def supported_platform?
      !!run_context.cookbook_collection[cookbook_name].metadata.platforms.find { |k,v| Gem::Dependency.new(k,v).match?(node['platform'], node['platform_version']) }
    end
  end
end
