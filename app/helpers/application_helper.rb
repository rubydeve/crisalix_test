module ApplicationHelper
    def toastr_flash
        flash.each_with_object([]) do |(type, message), flash_messages|
          type = 'info' if type == 'notice'
          type = 'success' if type == 'success'
          type = 'error' if type == 'error'
          type = 'warning' if type == 'warning'
    
          text = "<script>toastr.#{type}('#{message}', {  progressBar: true })</script>"
          flash_messages << text.html_safe if message
    
        end.join("\n").html_safe
    end
    
end
