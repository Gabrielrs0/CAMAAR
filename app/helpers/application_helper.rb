# app/helpers/application_helper.rb
module ApplicationHelper
  def etapa_button_class(etapa)
    if @completed_steps.include?(etapa)
      "bg-green-600"
    else
      "bg-green-300"
    end
  end
    def sidebar_class(path)
    is_active = current_page?(path)
    base = "block px-4 py-2 rounded hover:bg-gray-700 transition-all"
    active = "bg-gray-900 font-semibold"
    is_active ? "#{base} #{active}" : base
  end
end
