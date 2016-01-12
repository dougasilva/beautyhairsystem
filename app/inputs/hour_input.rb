class HourInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    @builder.select(attribute_name, hour_options,
                    { selected: selected_value },
                    { class: 'input-medium' })
  end

  private

  def hour_options
    hour = [['Selecione...', '00:00']]
    (8..21).each do |h|
      %w(00 15 30 45).each do |m|
        hour.push ["#{h}:#{m}", "#{'%02d' % h}:#{m}"]
      end
    end
    hour
  end

  def selected_value
    value = object.send(attribute_name)
    value && value.strftime("%H:%M")
  end
end
