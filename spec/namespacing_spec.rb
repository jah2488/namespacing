require_relative '../lib/namespacing'

class Object
  include Namespacing
end

describe Namespacing do

  context 'ns' do

    it 'creates all methods in the nested namespace/module' do
      ns 'my_app.dojo.util.options' do
        def names
          %w(john jill steve carol)
        end
      end
      expect(MyApp::Dojo::Util::Options.names).to eq(%w(john jill steve carol))
    end

    it 'custom deliminators can optionally be specified' do
      ns 'my_app|dojo|util|options', '|' do
        def names
          %w(john jill steve carol)
        end
      end
      expect(MyApp::Dojo::Util::Options.names).to eq(%w(john jill steve carol))
    end
  end

  context 'nest_mod' do

    it 'creates a module given a string and block' do
      nest_mod(['greeter'], Proc.new {
        @hello = 'hello'
        def greet
          @hello
        end
      })
      expect(Greeter.greet).to eq('hello')
    end

    it 'creates nested modules' do
      nest_mod(['dojo', 'util', 'options'], Proc.new {
        def names
          %w(john jill steve carol)
        end
      })
      expect(Dojo::Util::Options.names).to eq(%w(john jill steve carol))
    end
  end

  context 'find_or_create_constant_in_module' do
    it { expect(find_or_create_constant_in_module(Kernel, 'Hello')).to eq(Hello)    }
    it { expect(find_or_create_constant_in_module(Kernel, 'Hello')).to be_a(Module) }
  end

  context 'to_const' do

    it 'hello -> Hello' do
      expect(to_const('hello')).to eq('Hello')
    end

    it 'hello_world -> HelloWorld' do
      expect(to_const('hello_world')).to eq('HelloWorld')
    end
  end
end
