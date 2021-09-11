# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  invisible_captcha only: %i[create update]

  # Votes
  def upvote
    @post = Post.find(params[:id])
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end
    render 'vote.js.erb'
  end

  def downvote
    @post = Post.find(params[:id])
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else
      @post.downvote_by current_user
    end
    render 'vote.js.erb'
  end

  def purge_image
    @post = Post.find(params[:id])
    @post.image.purge
    redirect_back fallback_location: root_path, notice: 'Successfully'
  end

  def update_status
    @post = Post.find(params[:id])
    # if params[:status].present? && Post::STATUSES.include?(params[:status].to_sym)
    @post.update(status: params[:status])
    redirect_to @post, notice: "Le status de l'article à bien été changé à #{@post.status}"
    # else
    # redirect_to @post, notice: "Erreur lors de l'interraction"
    # end
  end

  # GET /posts or /posts.json
  def index
    if current_user.has_role? :admin
      # @pagy, @posts = pagy(Post.all.order(created_at: :desc), items: 4)
      @posts = policy_scope(Post).order(created_at: :desc)
      @pagy, @posts = pagy(Post.order(created_at: :desc))
      authorize @posts
    else
      redirect_to root_path, alert: "Vous n'avez pas l'autorisation !"
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts or /posts.json
  # @post = Post.new(post_params)
  # @post.user = current_user
  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        if current_user.has_any_role? :admin, :nouvel_utilisateur
          current_user.add_role :createur, @post
        else
          current_user.remove_role :createur, @post
        end
        PostMailer.with(user: current_user, post: @post).post_created.deliver_now
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    Post.public_activity_off
    respond_to do |format|
      if @post.update(post_params)
        Post.public_activity_on
        @post.create_activity "Titre mis à jour", parameters: { time_zone: Time.zone.now }
        if current_user.has_any_role? :admin, :nouvel_utilisateur
        else
          current_user.remove_role :createur, @post
        end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    # @post = Post.friendly.find(params[:id])
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :image, :status, images: [], tags: [])
  end
end
