module ApplicationHelper
  def full_title page_title
    base_title = t "sample_app.index.ror_tu_app"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
