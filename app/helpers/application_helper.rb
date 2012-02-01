#encoding: UTF-8

module ApplicationHelper
  
  def errors_for_object(object)
    if object.errors.any?
      render(:partial => "shared/errors", :locals => {:object => object})  
    end
  end

  def title
    base_title = "LAIMA - Профессиональная наружная реклама"
    if @title
      base_title + " / " + @title
    else
      base_title
    end
  end
  
  def eye_icon
    image_tag "/assets/eye-icon.png"
  end
  
  def edit_icon
    image_tag "/assets/edit-icon.png"
  end

  def delete_icon
    image_tag "/assets/delete-icon.gif"
  end
  
  def notice_msg(object)
    render :partial => "shared/notice", :locals => {:object => object}
  end

  def cut_text(object, length = 150)
    truncate(object, :length => length, :separator => ' ' ,:omission => " ...")
  end
  
  
  def price_download
    obj = load_pricelist
    if  obj == nil
      link_to("Скачать", "#")
    else
      link_to("Скачать", obj.xls.url)
    end
  end
end
