require 'rails/generators'

module Purecss
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates/", __FILE__)
      argument :stylesheets_type, :type => :string, :default => 'responsive', :banner => '*responsive or nonresponsive'


      def add_purecss
        copy_file layout_type(stylesheets_type), "app/assets/stylesheets/purecss.css"

        css_manifest = 'app/assets/stylesheets/application.css'
        if File.exist?(css_manifest)
          style_require_block = " *= require purecss\n"
          insert_into_file css_manifest, style_require_block, :after => "require_self\n"
        else
          copy_file "application.css", "app/assets/stylesheets/application.css"
        end
      end

      private
      def layout_type(type)
        if type == 'responsive' or type == 'nonresponsive'
          "#{stylesheets_type}.css"
        else
          raise "'#{stylesheets_type}'' is not recognized, use either 'responsive' or 'nonresponsive'"
        end
      end
    end
  end
end
