class CA
  class Reward
    class Ad
      attr_reader :c_id, :c_owner_id, :content_name, :career,
                  :banner_text_1, :banner_img_1, :banner_img_alt,
                  :content_exp, :max_point, :scheme, :attribute,
                  :appli_url, :platform, :distributors, :count_type_for_user,
                  :banner_id, :pb_wait_time, :ad_tag_of_point_back,
                  :site_name, :point_unit, :is_app, :is_install_action,
                  :charge_type, :charge_exp, :action_cate_id, :ranking_update_date,
                  :delivery_target, :has_video, :video_ad_c_id,
                  :video_point, :content_manage_category, :total_p_cnt, :cv_points,
                  :cate_name

      def initialize(data = {})
        data.each_pair do |k, v|
          instance_variable_set("@#{k}", v) if k != 'p'
        end

        p = *data['p']
        @cv_points = p.map do |i|
          begin
            CA::Reward::CvPoint.new i
          rescue => e
            puts e
            p i
            raise e
          end
        end
      end
    end
  end
end
