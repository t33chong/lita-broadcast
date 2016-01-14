# lita-broadcast

[![Build Status](https://travis-ci.org/tristaneuan/lita-broadcast.png?branch=master)](https://travis-ci.org/tristaneuan/lita-broadcast)
[![Coverage Status](https://coveralls.io/repos/tristaneuan/lita-broadcast/badge.png)](https://coveralls.io/r/tristaneuan/lita-broadcast)

**lita-broadcast** is a handler for [Lita](https://github.com/litaio/lita) that allows messages to be sent to multiple channels simultaneously.

## Installation

Add lita-broadcast to your Lita instance's Gemfile:

``` ruby
gem "lita-broadcast"
```

## Usage

The command `tell #room1 #room2: <your message here>` will send everything to the right of the `:` to #room1 and #room2.

For example,
```
<john> lita: tell #engineering #operations #helpdesk: hello
```
The channels #engineering #operations and #helpdesk will all see the message:
```
<lita> @john says: hello
```

## License

[MIT](http://opensource.org/licenses/MIT)
