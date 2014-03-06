# Namespacing

Namespacing adds namespaces to Ruby by taking inspiration from how Clojure handles its namespaces.
It is primarly a simplification of the existing module syntax. Great for deeply nested modules or for attempting a more functinoal approach to writing Ruby code.

## Installation

Add this line to your application's Gemfile:

    gem 'namespacing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install namespacing

## Usage

Simply require the gem and decide the scope you'd like to have it at. To use it in the global scope, you'll want to extend `Object`

```rb
require 'namespacing'

class Object
  include Namespacing
end

ns 'my_app.dojo.util.options' do
  def names
    %w(on off maybe 7 42 tuesday)
  end
end
```
Then this code can be called with: 
```rb
MyApp::Dojo::Util::Options.names 
#=> ['on', 'off', 'maybe', '7', '42', 'tuesday']
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/namespacing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
