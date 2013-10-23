class DateValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    final_value = if !value.is_a?(DateTime)
      record.errors[attribute] << "is not a DateTime object."
    end
  end
end
