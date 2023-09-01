class ArticlesController < ApplicationController
  
  # Middleware que ejecuta la función `find_article` antes de ejecutar cierto métodos
  before_action :find_article, only: [:show, :edit, :update, :destroy, :article_params]
  # before_action :find_article, except: [:create, :new] # Esta es la forma inversa de la línea anterior

  # No crear, editar, actualizar ni eliminar a los usuarios que no estén logueados
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :by_user]

  def index
    @articles = Article.all
  end
  
  def show
    # Ya no necesitamos buscar el artículo aquí, ya que lo hace el `before_action`
  end

  def new
    @article = Article.new
    @article.title = 'demo'
    @categories = Category.all
  end

  def create
    # Emplear esta forma si no hay relaciones
    # @article = Article.create(
    #   title: params[:article][:title], 
    #   content: params[:article][:content]
    # )

    #Emplear esta forma si hay relaciones
    # Forma manual de pasar parámetros
    # @article = current_user.articles.create(
    #   title: params[:article][:title], 
    #   content: params[:article][:content]
    # )

    #Emplear esta forma si hay relaciones
    #Forma reducida de pasar parámetros. `article_params` está definida como método en esta misma clase
    @article = current_user.articles.create(article_params)    
    @article.save_categories # Este método lo hemnos definido en la clase Article, para salvar los registros en la tabla asociativa

    redirect_to articles_path
  end

  def edit
    # Ya no necesitamos buscar el artículo aquí, ya que lo hace el `before_action`
    @categories = Category.all
  end

  def update
    # Froma manual de pasar parámetros 
    # @article.update(
    #   title: params[:article][:title], 
    #   content: params[:article][:content]
    # )

    # Forma reducida de pasar parámetros. `article_params` está definida como método en esta misma clase
    @article.update(article_params)
    @article.save_categories # Este método lo hemnos construido en la clase Article, para salvar los registros en la tabla asociativa

    redirect_to @article
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  # Método que devolera los artículos por el id de un autor
  def by_user
    @user = User.find(params[:id]) # El nombre del parámetro tiene que coincidir con el de la ruta que invoca este método   
  end

  # Buscar un articulo por su id
  def find_article
    @article = Article.find(params[:id])
  end

  # Para pasar parámetros de forma reducida y no tener que ponerlo en el create y en el update, duplicando código
  def article_params
    # Dentro de permit se ponen los parámetros que se esperan del artículo
    params.require(:article).permit(:title, :content, category_elements: []) # 'category_elements' está definida en el modelo article como attr_accesor y va a llegar como arreglo
  end

end
