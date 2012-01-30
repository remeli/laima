module ApplicationHelper
  
  def errors_for_object(object)
    if object.errors.any?
      render(:partial => "shared/errors", :locals => {:object => object})  
    end
  end
  
end
