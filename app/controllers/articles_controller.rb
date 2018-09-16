class ArticlesController < ApplicationController
  before_action :set_article, except: [:home, :index, :new, :create]
  before_action :require_user, except: [:home, :index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def home
    redirect_to articles_path if logged_in?
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to @article
    else
      flash.now[:danger] = "Some errors prevented the article from being saved, please try again"
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      flash.now[:danger] = "Some errors prevented the article from being updated, please try again"
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end
end
