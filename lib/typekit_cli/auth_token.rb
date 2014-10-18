module TypeKitCli
  class AuthToken < Thor
    CACHE_FILE = "#{Dir.home}/.typekit"
    no_commands{
      def get_token
        auth_token = nil
        if File.exist?(CACHE_FILE)
          File.open(CACHE_FILE, 'r') { |file| auth_token = file.gets }
        else
          auth_token = prompt_for_token
        end
        auth_token
      end

    }

    private
    def prompt_for_token
      auth_token = ask("Typekit API Token:")
      if yes?("Would you like to cache this token? [y/N]:")
        say("Token will be cached to in #{CACHE_FILE} file")
        File.open(CACHE_FILE, 'w') { |file| file.write(auth_token) }
      end
      auth_token
    end
  end
end

