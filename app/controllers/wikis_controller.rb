class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if  @wiki.save
        redirect_to @wiki, notice: "Your wiki was created successfully"
    else
        flash[:error] = "There was an error creating your wiki"
        render :new
    end
  end

  def show
    @wiki = Wiki.find_by_slug(params[:id])
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def index
    @wikis = Wiki.all
  end

  def edit
    @wiki = Wiki.find_by_slug(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find_by_slug(params[:id])
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
    params.require(:wiki).permit(:title, :body, :private)
  end
end