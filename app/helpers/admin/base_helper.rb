module Admin::BaseHelper
	def user_status_index(state)
		case state
		when 0 
			"success"
		when 1
			"success"
		when 2
			"info"
		when 3
			"warning"
		when 4
			"danger"
		end
	end

	def human_enum_name(model, attr)
		I18n.t("activerecord.attributes.#{model.model_name.i18n_key}.#{attr.to_s}.#{model.send(attr)}")
	end
end