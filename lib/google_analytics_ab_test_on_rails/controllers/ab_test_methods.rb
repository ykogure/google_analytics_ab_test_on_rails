module GoogleAnalyticsAbTestOnRails
  module Controllers
    module AbTestMethods
      extend ActiveSupport::Concern

      included do
        helper_method :ab_test_start
        helper_method :ab_tests
        helper_method :get_ab_test_value
      end

      ### ABテストを簡易に実装するためのメソッド
      ## View側でもController側でも使えます
      # View側ex1.
      # <% ab_test_start(ab_test_name) do |ab_test_value| %>
      #   <% if ab_test_value == 'A' %>
      #   ~~~~
      # <% end %>
      # View側ex2. イベントカテゴリを変更する場合や、ab_testが3種類以上等の場合
      # <% ab_test_start(ab_test_name, ['A', 'B', 'C'], event_category: 'aaa') do |ab_test_value| %>
      #   <% if ab_test_value == 'A' %>
      #   ~~~~
      # <% end %>
      # View側ex3. ABの割合を5:5以外にする場合
      # <% ab_test_start(ab_test_name, {'A' => 9, 'B' => 1}) do |ab_test_value| %>
      #   <% if ab_test_value == 'A' %>
      #   ~~~~
      # <% end %>
      # Controller側ex1.
      # @ab_test_value = ab_test_start(ab_test_name, {'A' => 9, 'B' => 1})
      # ※View側で@ab_test_valueを使って場合分け
      def ab_test_start(ab_test_name, ab_test_values = ['true', 'false'], **args, &block)
        ab_test_session_key = :"ga_ab_test_#{ab_test_name}"

        # ABテスト一覧をABテストマネージャに表示する用
        # 既に同じビューやコントローラ内で実行されている場合は再度処理は行わない
        @ab_tests ||= {}
        @ab_tests[ab_test_name] = ab_test_values if @ab_tests[ab_test_name].blank?

        value = get_ga_ab_test_value(params)
        if value
          session[ab_test_session_key] = value

          # GoogleAnalyticsではセッションが30分で切れてしまうため、30分毎にABテストイベントを再送信するためのcookie情報
          cookies[:"#{ab_test_session_key}_for_ga_session"] = {value: true, expires: 30.minutes.from_now}

          @data_layers << GTM::DataLayer.new({
            event:           'ab_test',
            event_category:  (args[:event_category].present? ? args[:event_category] : "#{controller_path}##{action_name}"),
            ab_test_title:   ab_test_name,
            ab_test_pattern: session[ab_test_session_key]
          })
        end

        # GoogleAnalyticsではセッションが30分で切れてしまうため、30分毎にABテストイベントを再送信する
        if cookies[:"#{ab_test_session_key}_for_ga_session"].blank?
          cookies[:"#{ab_test_session_key}_for_ga_session"] = {value: true, expires: 30.minutes.from_now}

          @data_layers << GTM::DataLayer.new({
            event:           'ab_test',
            event_category:  (args[:event_category].present? ? args[:event_category] : "#{controller_path}##{action_name}"),
            ab_test_title:   ab_test_name,
            ab_test_pattern: session[ab_test_session_key]
          })
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
        def get_ga_ab_test_value(params)
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
