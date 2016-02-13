class GuessStruct
  require "guess_struct/version"
  GuessError = Class.new(StandardError)

  def initialize(**arg)
    sym_arg = {}
    arg.each do |k, v|
      sym_arg[k.to_sym] = v
    end
    self.class.members.each do |k|
      self[k] = sym_arg[k]
    end
  end

  def valid?(key, value)
    t = self.class.definition[key]
    return true if t.nil?
    return true if value.nil?
    return true if t === value
    false
  end

  def [](key)
    __send__ key
  end

  def []=(key, value)
    __send__ "#{key}=", value
  end

  def inspect
    m = to_h.map do |k, v|
      "#{k}=#{v.inspect}"
    end
    "#<#{self.class} #{m.join(', ')}>"
  end
  alias to_s inspect

  def to_h
    m = {}
    self.class.members.each do |k|
      m[k] = self[k]
    end
    m
  end

  class << self
    def definition
      const_get(:DEFINITION)
    end

    def members
      const_get(:MEMBERS)
    end

    def clear
      d = definition
      d.each_key do |k|
        d[k] = nil
      end
    end

    alias original_new new
    def new(*args, &block)
      c = Class.new(GuessStruct) do
        const_set :MEMBERS, args
        const_set :DEFINITION, Hash[members.map { |i| [i, nil] }]

        class << self
          alias_method :new, :original_new
        end

        args.each do |k|
          define_method(k) do
            instance_variable_get("@#{k}")
          end

          define_method("#{k}=") do |v|
            unless valid?(k, v)
              raise GuessError, "#{self.class}##{k} expect #{self.class.definition.fetch(k)} got #{v.inspect}"
            end
            self.class.definition[k] = v.class if !v.nil?
            instance_variable_set("@#{k}", v)
          end
        end
      end
      if block_given?
        c.module_eval(&block)
      end
      c
    end
  end
end
