class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
    @users = User.all_except(current_user)
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.user = current_user

    if current_user.save
        redirect_to @wiki, notice: "Your wiki was created successfully"
    else
        flash[:error] = "There was an error creating your wiki"
        render :new
    end
  end

  def show
    @wiki = Wiki.find_by_slug(params[:id])
    authorize @wiki
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def edit
    @wiki = Wiki.find_by_slug(params[:id])
    @users = User.all_except(current_user)
    authorize @wiki
  end

  def update
    params[:wiki][:collaborator_ids] ||= []
    @wiki = Wiki.find_by_slug(params[:id])
    @wiki.update_attributes(wiki_params)
    authorize @wiki
   if  @wiki.save
    redirect_to @wiki, notice: "Your wiki was edited"
   else
    flash[:error] = "There was an error editing your wiki"
    render :edit
   end
  end

  def destroy
    @wiki = Wiki.find_by_slug(params[:id])
    authorize @wiki
   if  @wiki.save
    redirect_to :root, notice: "Your wiki was deleted"
   else
    flash[:error] = "There was an error deleting your wiki"
    render :show
   end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :is_private, :collaborator_ids => [])
  end

end