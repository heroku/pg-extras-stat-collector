require 'sinatra/base'
require 'sequel'

class Collector < Sinatra::Base
  COMMANDS = %w[
    cache_hit 
    index_usage
    blocking
    locks
    mandelbrot
    total_index_size
    index_size
    unused_indexes
    seq_scans
    long_running_queries
    bloat
    vacuum_stats
    extensions
    outliers
  ]
  DB = Sequel.connect(ENV['DATABASE_URL'])

  configure do
    enable :logging, :dump_errors
    set :raise_errors, true
  end

  get '/' do
    status 200
  end

  post '/command' do
    if COMMANDS.include? params[:command]
      DB[:commands].insert(command: params[:command])
      status 200
    else
      puts "bad param"
      status 403
    end
  end
end
