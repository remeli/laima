# -*- encoding : utf-8 -*-
class Admin::JobsController < ApplicationController
  before_filter :access
  respond_to :html
  layout 'admin'
  
  def index
    @jobs = Job.page(params[:page]).per(6)
    respond_with @jobs
  end
  
  def show
    @job = Job.find(params[:id])
    respond_with @job
  end
  
  def new
    @job = Job.new
    respond_with @job
  end
  
  def edit
    @job = Job.find(params[:id])
    respond_with @job
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = "Работа успешно добавлена"
      respond_with(@job, :location => admin_jobs_path)
    else
      render 'new'
    end
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = "Работа успешно обновлена"
      respond_with(@job, :location => admin_jobs_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to(admin_jobs_path, :notice => "Работа успешно удалена")
  end
  
end
