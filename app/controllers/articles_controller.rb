class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to @article
    else
      flash[:danger] = "Some errors prevented the article from being saved, please try again"
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
