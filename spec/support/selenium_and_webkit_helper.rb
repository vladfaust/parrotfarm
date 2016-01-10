# This dynamically turns transactional fixtures off,
# which significantly reduces testing speed, but needed for capybara JS tests.
#
# Thanks to Wei Lu for solution!
# http://weilu.github.io/blog/2012/11/10/conditionally-switching-off-transactional-fixtures

module SeleniumAndWebkitHelper
  def self.included(base)
    base.class_eval do
      self.use_transactional_fixtures = false if metadata[:js]
    end
  end

  def select_value (id)
    find("##{id} option:checked").text
  end
end