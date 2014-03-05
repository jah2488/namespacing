require "namespacing/version"

module Namespacing
  def ns(namespace, delim = '.', &block)
    nest_mod(namespace.split(delim), block)
  end

  private
  def nest_mod(mod = Kernel, module_names, block)
    return mod.module_exec(&block) if module_names.empty?
    find_or_create_constant_in_module(mod, to_const(module_names.first)).tap do |this|
      make_module_methods_accessible(this)
      this.module_exec do
        nest_mod(this, module_names.drop(1), block)
      end
    end
  end

  def make_module_methods_accessible(mod)
    mod.module_exec { extend self }
  end

  def find_or_create_constant_in_module(mod, str)
    return mod.const_get(str) if mod.const_defined?(str)
    return mod.const_set(str, Module.new)
  end

  def to_const(str)
    str.split('_')
       .map(&:capitalize)
       .join
  end
end
