class CommentsController < ApplicationController

    before_action :find_message, only: [:create, :update, :edit, :destroy]
    before_action :find_comment, only: [:update, :edit, :destroy]

    def create
        @message =Message.find(params[:message_id])
        @comment =@message.comments.create(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
          redirect_to message_path(@message)
        else
          render 'new'
        end
    end

    def edit       #Only responsible for view file
    end

    def update     # repsponsible for update in database
      if @comment.update(comment_params)
        redirect_to message_path(@message)
      else
        render 'edit'
      end
    end

    def destroy
      @comment.destroy
      redirect_to message_path(@message)
    end

    private

    def comment_params 
        params.require(:comment).permit(:comment)
    end

    def find_message
      @message = Message.find(params[:message_id])
    end

    def find_comment
      @comment = @message.comments.find(params[:id])
    end

end
