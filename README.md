# What is that for?

Extends ActiveRecord by adding `pluck_to_hash` method that returns array of hashes instead of array of arrays. Useful when plucking multiple columns for rendering json or you need to access individual fields in your view for example.

[![Gem Version](https://badge.fury.io/rb/pluck_to_hash.png)](http://badge.fury.io/rb/pluck_to_hash) [![Build Status](https://travis-ci.org/girishso/pluck_to_hash.svg?branch=master)](https://travis-ci.org/girishso/pluck_to_hash)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pluck_to_hash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pluck_to_hash

## Usage

Usage is similar to `ActiveRecord.pluck`, for example

```ruby
Post.limit(2).pluck_to_hash(:id, :title)
#
# [{:id=>213, :title=>"foo"}, {:id=>214, :title=>"bar"}]
#

Post.limit(2).pluck_to_hash(:id)
#
# [{:id=>213}, {:id=>214}]
#
```

Or use the shorter alias `pluck_h`

```ruby
Post.limit(2).pluck_h(:id)
#
# [{:id=>213}, {:id=>214}]
#
```

## Why not `ActiveRecord.select` or `ActiveRecord.as_json`?

Here are results of "benchmark" tests performed on MacBook Air. Each method did 10 runs, rejected the 2 highest and 2 lowest times and average the remaining 6. Ran these tests on about 40,000 records. We notice that `pluck_to_hash` is almost 4x faster than `select` and about 8x faster than `as_json`. As with all the "benchmarks", you should take these results with a pinch of salt!

```ruby
# Node.pluck_h(:id, :title)
# Node.select(:id, :title).to_a
# Node.select(:id, :title).as_json

                    user     system      total        real
pluck_to_hash   0.145000   0.005000   0.150000 (  0.164836)
select          0.566667   0.010000   0.576667 (  0.590911)
as_json         1.196667   0.010000   1.206667 (  1.222286)
```

## Contributing

1. Fork it ( https://github.com/girishso/pluck_to_hash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Licence
MIT License

Brought to you by: [Cube Root Software](http://www.cuberoot.in) &copy; 2015
