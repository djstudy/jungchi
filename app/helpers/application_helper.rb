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
      meta_image = "<meta property=\"og:image\" content=\"#{reporting_results.first[:representative].profile_result_img_url}\" />" 
      meta_title = "<meta property=\"og:title\" content=\"#{reporting_named_result[:representative].name} 보다는 #{reporting_results.first[:representative].name}\" />"       
    end

    meta_site_name = "<meta property=\"og:site_name\" content=\"정친(政親)\" />" 
    meta_url = "<meta property=\"og:url\" content=\"#{request.original_url}\" />" 
    meta_description = "<meta property=\"og:description\" content=\"국회의원 300명 중에 당신의 정친(政親)은 누굴까요? 나경원? 이완구? 문재인? 안철수? 정친(政親)은 5분 안으로 300명의 국회의원 중 당신과 가장 잘 맞는 정치인을 찾아드립니다.\" />" 
    meta_app_id = "<meta property=\"fb:app_id\" content=\"475973985913779\" />" 
    meta_title + meta_site_name + meta_url + meta_image + meta_description + meta_app_id
  end
end
