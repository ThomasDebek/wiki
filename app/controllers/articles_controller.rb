class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category].blank?
      @articles = Article.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @articles = Article.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def new
    #@article = Article.new
    @article = current_user.articles.build
  end

  def edit
  end

  def show
  end

  def create
    #@article = Article.new(article_params)
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article
    else
      render action: 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render action: 'edit'
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path
    else
      flash[:notice] = "Somthing is wrong try again"
    end
  end


  private

  def article_params
    params.require(:article).permit(:title, :content, :email, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
