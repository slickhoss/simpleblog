class PostsController < ApplicationController
    http_basic_authenticate_with name: "slickhoss", password: "12345", except: [:index, :show]
    def index 
        #store all obj in the Post.model
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new 
        @post = Post.new
    end

    def create
        #create new post obj from Post.model
        @post = Post.new(post_params);

        #save new post obj to database
       if(@post.save)
            redirect_to @post #redirect to the submitted post
       else
        render 'new'
       end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if(@post.update(post_params))
            redirect_to @post #redirect to the submitted post
       else
        render 'edit'
       end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end

    #define structure for params
    private def post_params
        params.require(:post).permit(:title, :body)
    end
end
