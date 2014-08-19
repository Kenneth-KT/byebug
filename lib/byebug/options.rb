module Byebug
  class Options
    def self.parse
      Slop.parse!(help: true, strict: true) do
        banner <<-EOB.gsub(/^ {12}/, '')
          byebug #{Byebug::VERSION}

          Usage: byebug [options] <script.rb> -- <script.rb parameters>
        EOB

        on :d , :debug, 'Set $DEBUG=true' do
          $DEBUG = true
        end

        on :I, :include=, 'Add PATH1[...[:PATHN]] to $LOAD_PATH.' do |path|
          $LOAD_PATH.unshift(*path.split(':'))
        end

        on :q, :quit, 'Quit when script finishes', default: true

        on :s, :stop, 'Stop when script is loaded', default: true

        on :x, :rc, 'Run byebug initialization file', default: true

        on :m, :'post-mortem', 'Run byebug in post-mortem mode', default: false

        on :r, :require=, 'Require library before script' do |name|
          require name
        end

        on :host=, 'Host for remote debugging', default: 'localhost'

        on :p, :port=, 'Port for remote debugging', as: Integer

        on :t, :trace, 'Turn on line tracing'

        on :v, :version, 'Print program version'
      end
    end
  end
end
