# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )
API_KEY="AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA"

module ActionDispatch
  class ShowExceptions
    def render_exception(env, exception)
      if exception.kind_of? ActionController::RoutingError
        render(500, 'it was routing error')
      else
        render(500, "some other error")
      end
    end
  end
end
