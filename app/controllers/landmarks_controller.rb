class LandmarksController < ApplicationController

  get '/landmarks' do 
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end
  
  get '/landmarks/new' do 
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do 
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  post '/landmarks' do 
    if !params[:landmark].empty? 
      @landmark = Landmark.create(params[:landmark])
      @landmark
      redirect to "/landmarks/#{@landmark.id}"
    end
  end

  get '/landmarks/:id/edit' do 
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/edit'
  end
  
  patch '/landmarks/:id' do 
    @landmark = Landmark.find_by_id(params[:id])
    if @landmark
      @landmark.update(params[:landmark])
    redirect to "/landmarks/#{@landmark.id}"
    end
  end

end
