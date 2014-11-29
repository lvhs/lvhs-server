class FileInput < Formtastic::Inputs::FileInput

  #
  # Usage:
  #
  #  ActiveAdmin.register MyClass do
  #    form do |f|
  #      f.input :logo_image, :image_preview => true
  #    end
  #  end
  #

  def to_html
    input_wrapping do
      label_html <<
      builder.file_field(method, input_html_options) <<
      image_preview_content
    end
  end

  private

  def image_preview_content
    image_preview? ? image_preview_html : ""
  end

  def image_preview?
    options[:image_preview] && @object.send(method).present?
  end

  def image_preview_html
    template.image_tag(@object.send(method).url, :class => "image-preview")
  end
end
