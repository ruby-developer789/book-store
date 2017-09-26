$(document).on("change", ".update-quantity", function(e){
  var quantity = $(this).val();
  if(parseInt(quantity) == 0 || parseInt(quantity) < 0){
    $(this).val(1);
    quantity = 1;
  }
  var productId = $(this).closest('tr').attr('id');
  $.ajax({
      url: '/carts/add_to_cart',
      method: 'GET',
      data: { product_id: productId, quantity: quantity }
    }).success(function (data) {
      console.log(data);
    }).error(function (data) {
      console.log(data);
    })
})