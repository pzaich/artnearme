module Api
  class MuseumsController < ApplictionController
    def index
      @museums = Search.new(params[:query], params[:location]).museums
      flash[:notice] = "Sorry we couldn't find anything nearby that matches your search."
      respond_with @museums
    end

    def show
      @museum = Museum.find params[:id]
      @artist = Artist.search_by_name(params[:query]).first
      @paintings = @museum.paintings(params[:query])
      respond_to do |f|
        f.js
        f.html do
          params[:location] = @museum.to_coordinates
          render 'static/home'
        end
      end
    end
  end
end