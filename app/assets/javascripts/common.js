$(function() {

  // お気に入りホバー
  $('.glyphicon-star-empty').hover(function() {
    $(this).removeClass('glyphicon-star-empty');
    $(this).addClass('glyphicon-star');
  },
  function() {
    $(this).removeClass('glyphicon-star');
    $(this).addClass('glyphicon-star-empty');
  });
  
  $('.glyphicon-star').hover(function() {
    $(this).removeClass('glyphicon-star');
    $(this).addClass('glyphicon-star-empty');
  },
  function() {
    $(this).removeClass('glyphicon-star-empty');
    $(this).addClass('glyphicon-star');
  });
})

// お気に入り登録
function execFavorite(micropost_id) {
  $('#favorite_form_' + micropost_id).submit();
}

// お気に入り解除
function execUnFavorite(micropost_id) {
  $('#unFavorite_form_' + micropost_id).submit();
}

// リツイート
function execFavorite(micropost_id) {
  $('#favorite_form_' + micropost_id).submit();
}

