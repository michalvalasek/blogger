# frozen_string_literal: true

require 'thor'

module Blogger
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'blogger version'
    def version
      require_relative 'version'
      puts "v#{Blogger::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'create', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def create(*)
      if options[:help]
        invoke :help, ['create']
      else
        require_relative 'commands/create'
        Blogger::Commands::Create.new(options).execute
      end
    end
  end
end
