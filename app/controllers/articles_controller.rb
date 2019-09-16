class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order("created_at DESC")
  end

  def new
    @articles = Article.new
  end

  def edit
  end

  def show
  end

  def create
    @article = Article.new(article_params)
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
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end

