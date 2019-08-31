# frozen_string_literal: true

# Utility Methods
# Author:       ND Guthrie
# Date:         20190830
#

def find_file_names(directory)
  file_names = Array[]
  temp = Dir.entries(directory)
  temp.each do |symbol|
    if (symbol != '.') && (symbol != '..')
      file_names.push(symbol)
    end
  end
  file_names
end

def find_symbol_names(directory)
  symbol_names = Array []
  file_names = find_file_names(directory)
  file_names.each do |symbol|
    symbol_names.push(symbol.split('.', 3)[0])
  end
  symbol_names
end

def read_file(file_name)
  file_stream = File.open(file_name, 'r')
  file_data = file_stream.readlines
  file_stream.close
  file_data
end
