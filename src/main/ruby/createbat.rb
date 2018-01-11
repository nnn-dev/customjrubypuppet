#!/bin/ruby
# encoding: UTF-8

require 'fileutils'

def generate_batch(bindir, filename, destdir)
  script_name = filename + ".bat"
  Fileutils.mkdir_p(destdir) unless File.exists?(destdir)
  script_path = File.join destdir, File.basename(script_name)
  File.open(script_path, 'w', crlf_newline: true) do |file|
    file.puts "@ECHO OFF"
    file.puts "@jruby \"%~dpn0\" %*"
  end
end

bindir=ARGV[0]
destdir=ARGV[1]
Dir.glob(bindir+"/*").each do |script|
  generate_batch(bindir,script,destdir) if script !~ /\.bat$/
end
