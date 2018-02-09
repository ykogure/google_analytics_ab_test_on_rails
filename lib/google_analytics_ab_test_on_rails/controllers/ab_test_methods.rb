module GoogleAnalyticsAbTestOnRails
  module Controllers
    module AbTestMethods
      extend ActiveSupport::Concern

      included do
        helper_method :ab_test_start
        helper_method :ab_tests
        helper_method :get_ab_test_value
      end
      
      def ab_test_start(ab_test_name, ab_test_values = ['true', 'false'], **args, &block)
        ab_test_session_key = :"ga_ab_test_#{ab_test_name}"

        # ABテスト一覧をABテストマネージャに表示する用
        # 既に同じビューやコントローラ内で実行されている場合は再度処理は行わない
        @ab_tests ||= {}
        @ab_tests[ab_test_name] = ab_test_values if @ab_tests[ab_test_name].blank?

        value = get_ga_ab_test_value(ab_test_name, ab_test_values, params)
        if value
          session[ab_test_session_key] = value

          # GoogleAnalyticsではセッションが30分で切れてしまうため、30分毎にABテストイベントを再送信するためのcookie情報
          cookies[:"#{ab_test_session_key}_for_ga_session"] = {value: true, expires: 30.minutes.from_now}

          if GoogleAnalyticsAbTestOnRails.config.sender == :gtm
            @gtm_on_rails_data_layer.push({
              event:           'ab_test',
              event_category:  (args[:event_category].present? ? args[:event_category] : "#{controller_path}##{action_name}"),
              ab_test_title:   ab_test_name,
              ab_test_pattern: session[ab_test_session_key]
            })
          elsif :analytics_js
          end
        end

        # GoogleAnalyticsではセッションが30分で切れてしまうため、30分毎にABテストイベントを再送信する
        if cookies[:"#{ab_test_session_key}_for_ga_session"].blank?
          cookies[:"#{ab_test_session_key}_for_ga_session"] = {value: true, expires: 30.minutes.from_now}

          if GoogleAnalyticsAbTestOnRails.config.sender == :gtm
            @gtm_on_rails_data_layer.push({
              event:           'ab_test',
              event_category:  (args[:event_category].present? ? args[:event_category] : "#{controller_path}##{action_name}"),
              ab_test_title:   ab_test_name,
              ab_test_pattern: session[ab_test_session_key]
            })
          elsif :analytics_js
          end
        end

        if block_given?
          yield(session[ab_test_session_key])
        else
          return session[ab_test_session_key]
        end
      end

      def ab_tests
        @ab_tests ||= []
      end

      def get_ab_test_value(ab_test_name)
        session["ga_ab_test_#{ab_test_name}"]
      end
      
      private
        def get_ga_ab_test_value(ab_test_name, ab_test_values, params)
          ab_test_session_key = :"ga_ab_test_#{ab_test_name}"
          if (params.dig(:ga_ab_test_force_change, ab_test_name).present? && session[ab_test_session_key] != params.dig(:ga_ab_test_force_change, ab_test_name))
            value = params.dig(:ga_ab_test_force_change, ab_test_name)
          elsif session[ab_test_session_key].blank?
            # 確率設定
            if ab_test_values.is_a?(Hash)
              values = ab_test_values.map{|value, count| count.times.map{value}}.flatten
            else
              values = ab_test_values
            end
            value = values.sample
          end
          value
        end
    end
  end
end
