class FiguresController < ApplicationController
  
  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end
  
  get '/figures/:id' do 
    @figures = Figure.all
    @figure = Figure.find_by(params[:id])
    binding.pry
    erb :'/figures/show'
  end
  
  post '/figures' do 
    if !params[:figure]["name"].empty?
      @figure = Figure.create(name: params[:figure]["name"])
    end

    if !params[:title]["name"].empty? 
      title = Title.create(name: params[:title]["name"])
      @figure.titles << title
    end
    params["figure"][:title_ids].each do |id|
      new_id = Title.find_by_id(id)
      @figure.titles << new_id
    end
    
    if !params[:landmark]["name"].empty? && !params[:landmark]["year"].empty?
      landmark = Landmark.create(name: params[:landmark]["name"], year_completed: params[:landmark]["year"])
      @figure.landmarks << landmark
    end
    
    params[:figure][:landmark_ids].each do |id|
      new_id = Landmark.find_by_id(id)
      @figure.landmark_ids << new_id
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  
end
