# frozen_string_literal: true

require './utility_methods'

namespace :import do
  desc 'Import data from files in /stocks directory'
  task stocks: :environment do
    directory = 'stocks'
    file_names = find_file_names(directory)
    if check_for_duplicate_stocks(directory) == true
      remove_duplicate_stocks
    end
    file_names.each do |file_name|
      file_data = read_file(directory + '/' + file_name)
      puts file_data[1]
      file_data.each do |line|
        daydate, open, high, low, close, volume, openint = line.split(',', 7)
        puts 'daydate: ' + daydate.to_s
        puts 'open: ' + open.to_s
        puts 'high:' + high.to_s
        puts 'low: ' + low.to_s
        puts 'close:' + close.to_s
        puts 'volume: ' + volume.to_s
        puts 'openint: ' + openint.to_s
        puts
      end
    end
  end
end

def check_for_duplicate_stocks(directory)
  symbol_names = find_symbol_names(directory)
  sql_string = 'SELECT symbol FROM stocks'
  new_stocks = get_results(sql_string, symbol_names)
  if new_stocks != nil
    return true
  end

  sql_string = 'SELECT symbol FROM etfs'
  new_etfs = get_results(sql_string, symbol_names)
end

def get_results(sql_string, symbol_names)
  new_symbols = Array[]
  results = ActiveRecord::Base.connection.execute(sql_string)
  results.each do |result|
    symbol_names.each do |symbol|
      if symbol != result
        new_symbols.push(symbol)
      end
    end
  end
  new_symbols
end
