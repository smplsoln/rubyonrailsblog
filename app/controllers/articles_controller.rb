class ArticlesController < ApplicationController

  # order: index, show, new, edit, create, update and destroy
  #   articles  GET    /articles(.:format)          articles#index
  #             POST   /articles(.:format)          articles#create
  #   new_article GET    /articles/new(.:format)      articles#new
  #   edit_article GET    /articles/:id/edit(.:format) articles#edit
  #   article     GET    /articles/:id(.:format)      articles#show
  #              PATCH  /articles/:id(.:format)      articles#update
  #              PUT    /articles/:id(.:format)      articles#update
  #              DELETE /articles/:id(.:format)      articles#destroy

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  # index action
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  # edit action
  def create
    # render plain: params[:article].inspect
    # @article = Article.new(params[:article])
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      # for better security specify the exact params allowed
      params.require(:article).permit(:title, :text)
    end

end
