# Sorry™ API - Ruby

[![Build status from Codeship](https://codeship.com/projects/c176af60-b8a7-0133-9729-0e8881fc1b37/status?branch=master)](https://codeship.com/) [![Gem Version](https://badge.fury.io/rb/sorry-api-ruby.svg)](https://badge.fury.io/rb/sorry-api-ruby)

> An easy to use Ruby wrapper for the [Sorry™](http://www.sorryapp.com) Status Page API. For details on what you can do with the API please check our [API Documentation](https://docs.sorryapp.com/api/v1/).

## Installation

To install the gem into the application you need to add it to your Gemfile.

```ruby
gem "sorry-api-ruby"
```

Once this has been done you can run `bundle install` to install the gem into your bundle.

## Configuration

Once the gem is installed you're ready to get up and running with it.

```ruby
client = Sorry::Api::Client.new('put your access token in here')
```

You can also instantiate the client without an access token, and it'll look for an ENV variable called 'SORRY_ACCESS_TOKEN' which is the preferable more-secure option if you're only ever connecting to a single Sorry™ account.

## Usage

Now you have your client you can begin to make requests to the API. This is done my chaining methods to match the path defined in the [Documentation](https://docs.sorryapp.com/api/v1/), and then terminate the call by the method you wish to perform i.e. *get(), create(), update() or delete().*

##### GET

```ruby
client.pages.get # => Lists all the pages in the account.
client.pages('kjh324jh').get # => Returns a single page with the given ID.
client.pages('kjh324jh').brand.get # => Returns the pages brand settings.
```

##### POST/PUT

```ruby
client.pages.create(:name => 'My New Status Page') # => Creates a new page.
client.pages('kjh324jh').update(:name => 'My Pages New Name') # => Updates the name of the page.
```

##### DELETE

```ruby
client.pages('kjh324jh').delete # => Deletes the page with the given ID.
```

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code.

Once you are happy that your contribution is ready for production please send us a pull request, at which point we'll review the code and merge it in.

## Versioning

For transparency and insight into our release cycle, and for striving to maintain backward compatibility, This project will be maintained under the Semantic Versioning guidelines as much as possible.

Releases will be numbered with the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, please visit <http://semver.org/>.

## Authors & Contributors

**Robert Rawlins**

+ <http://twitter.com/sirrawlins>
+ <https://github.com/SirRawlins>

**Robin Geall**

+ <http://twitter.com/robingeall>

## Copyright

&copy; Copyright 2016 - See [LICENSE](LICENSE) for details.