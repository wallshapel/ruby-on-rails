class Article < ApplicationRecord
	
	has_rich_text :content # Indicamos al modelo que esta entidad va a usar texto enriquecido en alguna vista
	belongs_to :user
	has_many :has_categories
	has_many :categories, through: :has_categories
	attr_accessor :category_elements # Con esto agregamos una nueva propiedad de lectura y escritura a la clase 'Category'
	
	def save_categories
		# Iteramos el arreglo
		category_elements.each do |category_id| # A cada elemeto iterable lo llamamos 'category_id'
			# Por cada elemento del arreglo preguntamos si existe en la DB y si no, entonces creamos un registro en la tabla asociativa
			has_category  = HasCategory.find_or_create_by(article: self, category_id: category_id)	# con 'self' hacemos referencia al articulo actual 								
		end			
			
	end		

end
