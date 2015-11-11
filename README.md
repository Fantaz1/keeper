# Keeper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'keeper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keeper

## Usage

*app/models*
```ruby
class Company < ActiveRecord::Base
  has_many :users
end

class Address < ActiveRecord::Base
  has_many :users
end

class User < ActiveRecord::Base
  belongs_to :company
  belongs_to :address

  has_many :posts
  has_many :comments
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end
```

*Keeper class*
```ruby
class MyKeeper < Keeper::Base
  def initialize company
    @company = company
  end

  store :users, select: :address_id do
    @company.users.best_writers
  end

  store :posts, find: :title do
    Post.where(job_id: jobs_ids).published.with_rating(5)
  end

  store :comments, select: :user_id do
    Comment.where(post_id: posts_ids).activ
  end
end

keeper = MyKeeper.new(company)
keeper.users                              # all users from the company
# => User Load (150.8ms)  SELECT "users".* FROM "users" WHERE "users"."company_id" = 1
keeper.get_users(address.id)              # get all users for one address (no request)
keeper.get_user(12)                       # get user instance from collection by ID (no request)
keeper.users_ids                          # an array of users IDs (no request)

keeper.get_post('Super Title')            # get post by title
# => Post Load (150.8ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" IN (1,2,3,4,5, .... , 500)
keeper.posts                              # get all posts for all users (no request)
keeper.get_posts(user.id)                 # get posts for one user (no request)

keeper.comments                           # get all comments for all posts
# => Comment Load (150.8ms)  SELECT "comments".* FROM "comments" WHERE "comments"."post_id" IN (1,2,3,4,5, .... , 3000)
keeper.get_comments(user.id)              # get all comment that user with a given ID has left (no request)
keeper.get_comment(40)                    # get instance of comment with ID 40 (no request)
```

As you can see it sends only 3 requests to database:
- One to get all users
- One to get all posts
- One to get all comments

And that's all. You can get all nessesary data from this storage without any new requests to database.

If you will want to get all such comment in a regular way, you will do something like this:

```ruby
users = @company.users.best_writers

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/keeper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
