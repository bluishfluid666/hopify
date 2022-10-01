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
// import "custom/image_upload"
import "custom/custom"
import "custom/common"
import { addStock } from "custom/custom"
import { removeField } from "custom/custom"
import "custom/image_preview"
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
document.addEventListener('turbo:load', () => {
  if (document.querySelector('#fieldsetContainer')) {
    addStock();
    removeField();
  }
  const sel = document.getElementById('cart_item_product_stock')
  if(sel){
    sel.addEventListener('change',function handleChange(event){
      let productStockId = event.target.value
      let productId = document.getElementById('product_id').value
      $.ajax({
        url: `/products/${productId}/change_price`,
        data: {"product_stock": productStockId},
        method: 'put',
        success: function (response){
          $("#pprice").html(`${response.price} $`)
        },
      });
    })
  }
  // function changeOnSelect(elmId, change){
  //   const sel = document.getElementById(`${elmId}`)
  //   sel.addEventListener('change',function handleChange(event){
  //     let productStockId = event.target.value
  //     let productId = document.getElementById('product_id').value
  //     $.ajax({
  //       url: `/products/${productId}/change_price`,
  //       data: {"product_stock": productStockId},
  //       method: 'put',
  //       success: function (response){
  //         $("#pprice").html(`${response.change} $`)
  //       },
  //     });
  //   })
  // }
  if($('[id="product_stock"]')){
    $('[id="product_stock"]').each((idx, prodStocks) => {
      prodStocks.addEventListener('change',function handleChange(event){
        let productStockId = event.target.value
        let productId = $('[id="product_id"]')[idx].value
        $.ajax({
          url: `/products/${productId}/change_price`,
          data: {"product_stock": productStockId},
          method: 'put',
          success: function (response){
            $(`#product_${productId}`).html(`${response.stock}`)
          },
        });
      })
  })
  }
  
  $('#cart_item_product_stock').on('change', function () {
    $(':input[type="submit"]').prop('disabled', !$(this).val());
  }).trigger('change');
})

