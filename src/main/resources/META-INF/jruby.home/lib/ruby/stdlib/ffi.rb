require 'ffi/ffi'

if RUBY_PLATFORM=='java' and defined?('ENV_JAVA') and ENV_JAVA.has_key?('os.name') and ENV_JAVA['os.name']=~/^win/i
  # monkeypatch
  # on jruby, aliasing java-ffi methods with ruby-ffi methods.
  class ::FFI::Pointer
    ['16','32','64'].each do |nb|
      ['uint','int'].each do |type|
        alias_method "read_#{type}#{nb}".to_sym, "get_#{type}#{nb}".to_sym
        alias_method "write_#{type}#{nb}".to_sym, "put_#{type}#{nb}".to_sym
      end
    end
  end
end
