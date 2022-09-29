// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "cocoon"
import "@hotwired/turbo-rails"
import "controllers"
import "custom/bootstrap.bundle.min"
import "custom/jquery-1.11.0.min"
import "custom/jquery-migrate-1.2.1.min"
// import jQuery from "jquery"
import "custom/slick.min"
import "custom/templatemo"
import "custom/templatemo.min"
import "custom/image_upload"
import "custom/image_preview"
import "custom/custom"
import "custom/common"
import { addStock } from "custom/custom"
import { removeField } from "custom/custom"
document.addEventListener('turbo:load', () => {
  if (document.querySelector('#fieldsetContainer')) {
    addStock();
    removeField();
  }
})
