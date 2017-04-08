class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
  #  @articles = Article.all
  # Do articles pagination
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  #  @articles = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    debugger
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      #do something
      #change flash[:notice] to flash[:success] for _messages new layout.
      flash[:success] = "Article is successfully created."
      redirect_to article_path(@article)
    else
      render "new"
    end

  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    #respond_to do |format|
      if @article.update(article_params)
      #  format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @article }
        flash[:success] = "Article was successfully updated."
        redirect_to article_path(@article)
      else
      #  format.html { render :edit }
      #  format.json { render json: @article.errors, status: :unprocessable_entity }
        render 'edit'
      end
    #end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    #respond_to do |format|
    #  format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
    flash[:danger] = "Article was successfully destroyed."
    redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
