class CommentsController < ApplicationController

	def index
    	@comments = Comment.paginate(page: params[:page], per_page: 5)
  	end

  def new
    @comment = Comment.new
  end

  def create
    #render plain: params[:article].inspect
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    #Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success]= "Commentaire est ajouté avec succès"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    
    if @comment.update(comment_params)
      flash[:success]= "Commentaire est mis à jour avec succès"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end


  def show

  end

  def destroy
    
    @article.destroy
    flash[:success]="Le commentaire a été supprimé avec succès"
    redirect_to articles_path
  end
  
  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def require_same_user
      if current_user != @comment.user && !current_user.admin?
        flash[:danger] ="Vous ne pouvez modifier ou bien supprimer que les articles que vous avez crées"
        redirect_to root_path
      end
    end
end