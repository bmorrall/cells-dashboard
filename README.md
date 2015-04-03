# cells-dashboard

Adds a DSL to the [apotonick/cells](https://github.com/apotonick/cells) gem that allows for grouping of cells (as widgets) into multiple independent Dashboards.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cells'
gem 'cells-dashboard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cells-dashboard

## Usage

Define your dashboards in your initializer (`config/initializers/cells_dashboard.rb`), using blocks with matching arguments to control if a cell should be diplayed.

```ruby
# Define a dashboard named `users`
Cells::Dashboard.create :users do
  # Render the `Users::ChangePasswordCell` cell, if the users password has expired
  add_widget 'users/change_password' do |user|
    user.password_expired?
  end

  # Render the `Users::HappyBirthdayCell` if today is the user's birthday
  add_widget 'users/happy_birthday' do |user|
    user.birthday == Date.today
  end

  # Render the `Users::CompletedProfileCell` if none of the conditional widgets will be displayed
  fallback 'users/completed_profile'
end
```

Define your cells, using a `#display` method that accepts the same arguments as the blocks in your initializer.

```ruby
# app/cells/users/change_password_cell.rb
class Users::ChangePasswordCell < Cell::Rails
  def display(user)
    @user = user
    render
  end
end
```

Add a `#render_dashboard` call to your views, ensuring the arguments given match the name of your dashboard, the conditional blocks in your initializer, and the `#display` methods in your cells.

```erb
<%- render_dashboard :users, current_user %>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cells-dashboard/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
