module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('$.active').zero?
  end

  def disable_modal_fade
    page.evaluate_script('$(".fade").removeClass("fade")')
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end