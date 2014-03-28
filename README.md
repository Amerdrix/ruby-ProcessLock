# ProcessLock

Provides a process level synchronization context, allowing only a single process to execute a section of code any given
time.

Windows is currently not supported.

## Installation

Add this line to your application's Gemfile:

    gem 'ProcessLock'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ProcessLock

## Usage


Wrap any code you want to run in a synchronized context with

    ProcessLock.ensure_only_process do
      # Your code here
    end

Process lock will automatically infer a key based on the current file and method which is running. Optionally you can
specify a your self `ensure_only_process(:your_key_here)`


## Contributing

1. Fork it ( http://github.com/<Amerdrix>/ProcessLock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
