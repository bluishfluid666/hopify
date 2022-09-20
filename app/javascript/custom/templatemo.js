/*

TemplateMo 559 Zay Shop

https://templatemo.com/tm-559-zay-shop

*/

'use strict';
$(document).ready(function() {

    // Accordion
    var all_panels = $('.templatemo-accordion > li > ul').hide();

    $('.templatemo-accordion > li > a').click(function() {
        console.log('Hello world!');
        var target =  $(this).next();
        if(!target.hasClass('active')){
            all_panels.removeClass('active').slideUp();
            target.addClass('active').slideDown();
        }
      return false;
    });
    // End accordion

    // Product detail
    $('.product-links-wap a').click(function(){
      var this_src = $(this).children('img').attr('src');
      let sub_src = this_src.slice(0,this_src.indexOf("eyecatch"))
      let eyecatch_len = "eyecatch".length
      let sub_src2 = this_src.slice(this_src.indexOf("eyecatch")+eyecatch_len)
      this_src = sub_src + "on_preview" + sub_src2
      $('#product-detail').attr('src',this_src);
      return true;
    });
    $('#btn-minus').click(function(){
      var val = $("#var-value").html();
      val = (val=='1')?val:val;
      $("#var-value").html(val);
      $("#product-quanity").val(val);
      return false;
    });
    $('#btn-plus').click(function(){
      var val = $("#var-value").html();
      val;
      $("#var-value").html(val);
      $("#product-quantity").val(val);
      return false;
    });
    $('.btn-size').click(function(){
      var this_val = $(this).html();
      $("#product-size").val(this_val);
      $(".btn-size").removeClass('btn-secondary');
      $(".btn-size").addClass('btn-success');
      $(this).removeClass('btn-success');
      $(this).addClass('btn-secondary');
      return false;
    });
    // End roduct detail

});
