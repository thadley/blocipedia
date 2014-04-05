class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
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
    @wiki = Wiki.find(params[:id])
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end