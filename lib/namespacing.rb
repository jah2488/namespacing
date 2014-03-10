module Namespacing
  def ns(namespace, delim = '.', &block)
    make_namespaces(namespace.split(delim), block)
  end

  private
  def make_namespaces(namespaces, block)
    modules = namespaces.each_with_object([Kernel]) do |namespace, modules|
      modules << constant_in(modules.last, to_const(namespace)).tap do |mod|
        make_module_methods_accessible(mod)
      end
    end
    modules.last.module_exec(&block)
  end

  def constant_in(obj, str)
    return obj.const_get(str) if obj.const_defined?(str)
    obj.const_set(str, Module.new)
  end

  def make_module_methods_accessible(mod)
    mod.module_exec { extend self }
  end

  def to_const(str)
    str.split('_').map(&:capitalize).join
  end
end
