class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
    @users = User.all
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    Rails.logger.debug "@@@@@@@@ #{@wiki.inspect}"

    if current_user.save
        redirect_to :root
        #redirect_to @wiki, notice: "Your wiki was created successfully"
    else
        flash[:error] = "There was an error creating your wiki"
        @users = User.all
        render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wikis = Wiki.all
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
   if  @wiki.save
    redirect_to @wiki, notice: "Your wiki was edited"
   else
    flash[:error] = "There was an error editing your wiki"
    render :new
   end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaborators)
  end
end