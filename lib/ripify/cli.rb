require 'optparse'
require 'ripper'
require 'pp'

module Ripify
  class Cli
    HELP_MESSAGE = <<-EOT
Usage: ripify COMMAND [options]

Accepted commands are:
 lex      Lexically analyzes the input.
 parse    Parses the input.

Options include:

EOT

    COMMAND_WHITELIST = %w(lex parse)

    attr_reader :options

    def initialize(args)
      parse! args
    end

    def lex
      contents = Ripper.lex read_in
      write_out contents
    rescue StandardError => e
      fail! e.message
    end

    def parse
      contents = Ripper.sexp read_in
      write_out contents
    rescue StandardError => e
      fail! e.message
    end

    def fail!(message = 'Invalid command passed')
      abort "ripify failed, message given: #{message}"
    end

    protected

    def read_in
      if @options[:file] && File.exists?(@options[:file])
        File.read @options[:file]
      else
        STDIN.read
      end
    end

    def write_out(contents)
      if @options[:file_out]
        pp contents, File.open(@options[:file_out], 'w+')
      else
        pp contents
      end
    end

    def parse!(args)
      @options ||= {}

      initialize_parser.parse! args
      return send(args[0].to_sym) if COMMAND_WHITELIST.include? args[0]

      fail!
    end

    def initialize_parser
      OptionParser.new do |opts|
        opts.banner = HELP_MESSAGE

        opts.on '-fFILE', '--file=FILE', 'File path to read, defaults to stdin.' do |v|
          @options[:file] = v
        end

        opts.on '-oFILE', '--out-file=FILE', 'File path to write, defaults to stdout.' do |v|
          @options[:out_file] = v
        end

        opts.on '-h', '--help', 'Prints this help message.' do |v|
          puts opts
          exit
        end
      end
    end
  end
end
