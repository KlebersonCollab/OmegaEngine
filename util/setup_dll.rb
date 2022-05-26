require_relative '../lib/raylib'
 
case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  Raylib.load_lib(Dir.pwd + '/lib/' + 'libraylib.dll')
when /darwin/
  Raylib.load_lib(Dir.pwd + '/lib/' + 'libraylib.dylib')
when /linux/
  Raylib.load_lib(Dir.pwd + '/lib/' + 'libraylib.so')
else
  raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
end

include Raylib
