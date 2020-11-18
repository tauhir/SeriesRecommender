class AddUserReftoSearches < ActiveRecord::Migration[6.0]
  def change
    add_reference :searches, :user, index: true
  end
end
