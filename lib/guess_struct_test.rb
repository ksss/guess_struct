require "guess_struct"

module GuessStructTest
  def test_class(t)
    s = GuessStruct.new(:foo, :bar, :baz)
    unless Class === s
      t.error("GuessStruct instance is not Class")
    end
  end

  def test_make_struct(t)
    s = GuessStruct.new(:foo, :bar, :baz)
    si = s.new
    si.foo = 1
    unless 1 == si.foo
      t.error("set value was changed")
    end
    si.foo = 2
    unless 2 == si.foo
      t.error("set value was changed")
    end

    unless si.bar.nil? && si.baz.nil?
      t.error("other attr was changed")
    end

    begin
      si.foo = "a"
    rescue GuessStruct::GuessError
    else
      t.error("Not raise error when different type from first")
    end

    si = s.new
    begin
      si.foo = "a"
    rescue GuessStruct::GuessError
    else
      t.error("miss share guess class")
    end
    si.foo = 1
    si.foo = nil
    si.foo = 5
  end

  def test_make_struct_with_key_args(t)
    s = GuessStruct.new(:foo, :bar, :baz)
    si = s.new(foo: "a")
    unless "a" == si.foo
      t.error("initial value dose not setted")
    end

    si.foo = "b"
    unless "b" == si.foo
      t.error("initial value dose not setted")
    end

    begin
      si.foo = 1
    rescue GuessStruct::GuessError
    else
      t.error("invalid value")
    end

    begin
      s.new(foo: 1)
    rescue GuessStruct::GuessError
    else
      t.error("invalid value")
    end
  end

  def test_clear(t)
    s = GuessStruct.new(:foo, :bar, :baz)
    si = s.new(foo: :sym)
    unless s.definition == { foo: Symbol, bar: nil, baz: nil }
      t.error("definition miss")
    end
    s.clear
    unless s.definition == { foo: nil, bar: nil, baz: nil }
      t.error("clear miss")
    end
  end
end
