class FiguresController < ApplicationController
  
  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end
  
  get '/figures/:id' do 
    @figure= Figure.find_by(params[:id])
    erb :'/figures/show'
  end
  
  post '/figures' do 
    if !params[:figure]["name"].empty?
      @figure = Figure.create(name: params[:figure]["name"])
    end
    if !params[:title]["name"].empty? 
      title = Title.create(name: params[:title]["name"])
      @figure.title_ids << title
      @figure.title_ids = params["figure"][:title_ids]
      @figure.save
    end
    if !params[:landmark]["name"].empty? && !params[:landmark]["year"].empty?
      landmark = Landmark.create(name: params[:landmark]["name"], year_completed: params[:landmark]["year"])
      @figure.landmarks << landmark
    end
    @figure.save
    binding.pry
  end
  
end
