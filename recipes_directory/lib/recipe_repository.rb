class RecipeRepository
  def all
    sql = 'SELECT id, name, cooking_time, rating FROM recipes;'
    results_list = DatabaseConnection.exec_params(sql, [])
    recipes = []
    results_list.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']
      recipes << recipe
    end
    recipes
  end

  def find(id)
    sql = 'SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;'
    sql_param = [id]
    record = DatabaseConnection.exec_params(sql, sql_param)
    recipe = Recipe.new
    recipe.id = record[0]['id']
    recipe.name = record[0]['name']
    recipe.cooking_time = record[0]['cooking_time']
    recipe.rating = record[0]['rating']
    recipe
  end
end