class CommentsController < ApplicationController


#   article_comments GET    /articles/:article_id/comments(.:format)          comments#index
#                      POST   /articles/:article_id/comments(.:format)          comments#create
#  new_article_comment GET    /articles/:article_id/comments/new(.:format)      comments#new
# edit_article_comment GET    /articles/:article_id/comments/:id/edit(.:format) comments#edit
#      article_comment GET    /articles/:article_id/comments/:id(.:format)      comments#show
#                      PATCH  /articles/:article_id/comments/:id(.:format)      comments#update
#                      PUT    /articles/:article_id/comments/:id(.:format)      comments#update
#                      DELETE /articles/:article_id/comments/:id(.:format)      comments#destroy

  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end