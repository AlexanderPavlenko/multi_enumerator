# MultiEnumerator

Simultaneously process multiple enumerators.

[![Travis CI](https://secure.travis-ci.org/AlexanderPavlenko/multi_enumerator.png)](https://travis-ci.org/AlexanderPavlenko/multi_enumerator)
[![Coverage Status](https://coveralls.io/repos/AlexanderPavlenko/multi_enumerator/badge.png?branch=master)](https://coveralls.io/r/AlexanderPavlenko/multi_enumerator)

## Installation

Add this line to your application's Gemfile:

    gem 'multi_enumerator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_enumerator

## Usage

Main goal of MultiEnumerator is to reduce Array#zip abuse and simplify IO streams handling.

    a = [1, 2, 3].each
    b = [10, 20].each
    c = [30].each
    MultiEnumerator.build([a, b, c]).each do |*slice|
      puts slice.inspect
    end

    =>
    [1, 10, 30]
    [2, 20, #<StopIteration: iteration reached an end>]
    [3, #<StopIteration: iteration reached an end>, #<StopIteration: iteration reached an end>]

Instead of getting tons of StopIteration you may wish to specify a replacement.

    a = [1, 2, 3].each
    b = [10, 20].each
    c = [30].each
    MultiEnumerator.build(a, b, c, :ljust_with => nil).each do |*slice|
      puts slice.inspect
    end

    =>
    [1, 10, 30]
    [2, 20, nil]
    [3, nil, nil]

By default all enumerators are rewound on before the iterating.
This may be prevented by passing ```:rewind``` option.

    enum = [1, 2, 3].each
    enum.next  # skip first elem
    puts MultiEnumerator.build(enum, :rewind => false).each.to_a.inspect

    =>
    [2, 3]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
