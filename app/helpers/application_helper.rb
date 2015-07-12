module ApplicationHelper
  def validation_state(model_instance, attribute)
    if model_instance.errors.any?
      if model_instance.errors[attribute].empty?
        "has-success"
      else
        "has-error"
      end
    end
  end

  def validation_state_feedback(model_instance, attribute)
    if model_instance.errors.any?
      if model_instance.errors[attribute].empty?
        "glyphicon-ok"
      else
        "glyphicon-remove"
      end
    end
  end

  def attribute_error_message(model_instance, attribute)
    model_instance.errors[attribute].join('\n')
  end

  def generate_og_tags(reporting_results, reporting_named_result)
    meta_image =""
    meta_title =""

    if reporting_results
      meta_image = "<meta property=\"og:image\" content=\"#{request.protocol}#{request.host_with_port}#{reporting_results.first[:representative].profile_result_og_img_url}\" />"
      meta_title = "<meta property=\"og:title\" content=\"#{reporting_named_result[:representative].name} 보다는 #{reporting_results.first[:representative].name}\" />"

      meta_description_content = "오히려 #{reporting_results.first[:representative].party} #{reporting_results.first[:representative].name} 의원과 #{reporting_results.first[:point]}%로 의견이 비슷하시네요. 비슷한 다른의원으론 "
      meta_description_content += reporting_results.map { |e| "#{e[:representative].name}"}.join(", ")
      meta_description_content += "의원 등이 있습니다."

      meta_description = "<meta property=\"og:description\" content=\"#{meta_description_content}\" />"

    else
      meta_image = "<meta property=\"og:image\" content=\"#{request.protocol}#{request.host_with_port}#{asset_path("jc_fb")}\" />"
      meta_title = "<meta property=\"og:title\" content=\"내게 딱맞는 국회의원 찾기\" />"
      meta_description = "<meta property=\"og:description\" content=\"국회의원 300명 중에 당신의 정친(政親)은 누굴까요? 나경원? 이완구? 문재인? 안철수? 정친(政親)은 5분 안으로 300명의 국회의원 중 당신과 가장 잘 맞는 정치인을 찾아드립니다.\" />"
    end
    meta_type = "<meta property=\"og:type\" content=\"website\" />"
    meta_site_name = "<meta property=\"og:site_name\" content=\"정친(政親)\" />"
    meta_url = "<meta property=\"og:url\" content=\"#{request.original_url}\" />"

    meta_app_id = "<meta property=\"fb:app_id\" content=\"475973985913779\" />"
    meta_title + meta_site_name + meta_url + meta_image + meta_description + meta_app_id + meta_type
    # meta_title + meta_site_name + meta_image + meta_description + meta_app_id + meta_type
  end
end
