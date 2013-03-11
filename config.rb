# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# Set this to the root of your project when deployed:
http_path = "/"
sass_dir = "stylesheets"

css_dir = "stylesheets"
css_path = css_dir

images_dir = "images"
images_path = images_dir

javascripts_dir = "scripts"
javascripts_path = javascripts_dir

fonts_dir = "fonts"
fonts_path = fonts_dir

generated_images_dir = images_dir + '/generated'
generated_images_path = generated_images_dir
http_generated_images_path = http_path + generated_images_dir

sass_options = (environment == :production) ? { :quiet => true } : { :debug_info => true }
disable_warnings = (environment == :production) ? true : false 

