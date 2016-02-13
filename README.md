# GuessStruct

Struct class that guess attributes type.

```ruby
A = GuessStruct.new(:foo, :bar, :baz)
A.definition #=> {:foo=>nil, :bar=>nil, :baz=>nil}
a = A.new(foo: 1)
A.definition #=> {:foo=>Fixnum, :bar=>nil, :baz=>nil}
a.foo #=> 1
a.to_h #=> {:foo => 1, :bar => nil, :baz => nil}
a.foo = 'a' #=> GuessStruct::GuessError: A#foo expect Fixnum got "a"

# allow nil input. But not clear defined type.
a.foo = nil
A.definition #=> {:foo=>Fixnum, :bar=>nil, :baz=>nil}

# share guess type in class
A.new(foo: :sym) #=> GuessStruct::GuessError: A#foo expect Fixnum got "a"
A.new(foo: 10) #=> #<A foo=10, bar=nil, baz=nil>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'guess_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guess_struct

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
