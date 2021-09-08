# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  # boolean green or red
  def boolean_label(value)
    case value
      when true
        # content_tag(:span, "Yes", class: "badge badge-success")
        content_tag(:span, value=("Oui"), class: "badge bg-success")
      when false
        content_tag(:span, value=("Non"), class: "badge bg-danger")
    end
  end
end
