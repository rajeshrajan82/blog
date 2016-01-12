module ApplicationHelper
  def text_with_icon(text, icon)
    unless text.blank?
      return ('<i class="'+ icon + '"></i> ' + text).html_safe
    end
  end

  def icon_text(text,icon)
    return ("<i class='#{icon}'> #{text}</i>").html_safe
  end

  def show_icon(icon)
    unless icon.blank?
      return ('<i class="'+ icon + '"></i>').html_safe
    end
  end
  
  def show_button(value)
    unless value.blank?
      return ('<button type="button" class="btn btn-primary">'+value+'</button>').html_safe
    end
  end
  
  def formatted_date(date)
    date.strftime("%d-%m-%Y")
  end
end
