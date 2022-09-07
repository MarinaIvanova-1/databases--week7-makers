require_relative 'lib/database_connection'
require_relative 'lib/recipe'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')


recipes = RecipeRepository.new
recipes.all.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - Cooking time #{recipe.cooking_time} mins, Rating #{recipe.rating}"
end