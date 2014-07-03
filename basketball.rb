require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

#
# Define your migrations here, they should take the form of:
#
# ActiveRecord::Migration.create_table :fruits do |t|
#   t.string :name
#   t.belongs_to :bowl
# end
#
# Repeat the above template for each table you need to create

ActiveRecord::Migration.create_table :players do |t|

end


#
# end migrations
#
# the following line executes the migrations, don't delete it
ActiveRecord::Migrator.up "db/migrate"




#
# Define your AR classes below:
# for example:
#
# class Fruit < ActiveRecord::Base
#   belongs_to :bowl
# end
#
# You can define multiple classes, one after another

class Player
end

class Sponsor
end

class Team
end


#
# end AR classes









##
## Revision 0
##
## After completing the following three steps, the Revision 0 tests should
## pass. Run the tests like so:
##
##     rspec basketball_spec.rb
##
## Read the messages and implement the migrations, associations, and validations to try some model TDDing.

