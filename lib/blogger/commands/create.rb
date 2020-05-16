# frozen_string_literal: true

require_relative '../command'

require 'pry'

module Blogger
  module Commands
    class Create < Blogger::Command
      def initialize(options)
        @options = options
        @entry = {}
        @weblog_dir = "ABSOLUTE_PATH_HERE"
      end

      def execute(input: $stdin, output: $stdout)
        @entry = prompt.collect do
          key(:date).ask('Date:', default: Date.today)
          key(:title).ask('Title:', required: true)
          key(:url).ask('URL:')
          key(:comment).ask('Comment:')
        end

        print_preview

        if prompt.yes?('Save the entry?')
          write_to_data_file
          prompt.ok("Entry written to data file.")

          if prompt.yes?('Publish?')
            git_commit_and_push
            prompt.ok("Entry published to weblog.")
          end
        end
      end

      private

      def write_to_data_file
        require 'json'
        path = "#{@weblog_dir}/_data/weblog.json"
        entries = JSON::parse(File.read(path))
        entries.unshift(@entry)
        File.write(path, JSON.pretty_generate(entries))
      end

      def git_commit_and_push
        g_add = "git add _data/weblog.json"
        g_commit = "git commit -m 'Update weblog.'"
        g_push = "git push -u origin master"
        cmd.run "(cd #{@weblog_dir}; #{g_add}; #{g_commit})"
      end

      def print_preview
        puts
        puts pastel.magenta(@entry[:date])
        puts pastel.yellow(@entry[:title])
        if @entry[:url].to_s.strip.empty?
          puts pastel.bright_black "NO URL"
        else
          puts pastel.bright_blue(@entry[:url])
        end
        if @entry[:comment].to_s.strip.empty?
          puts pastel.bright_black "NO COMMENT"
        else
          puts markdown.parse(@entry[:comment])
        end
        puts
      end
    end
  end
end
