$(function() {

  // お気に入りhover
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
  
  // リツイートダイアログ表示
  $('.glyphicon-retweet').click(function () {
    $('#retweet_id').val($(this).attr('data-micropost'));
    $('#retweet_content').val('');  // 空にする
    $('#retweetModal').modal();
  });
  
  $('#retweet_content').keyup(function() {
    if ($('#retweet_content').val().length != 0) {
      // ボタン名をツイートに変更する
      $('#retweet_btn').hide();
      $('#tweet_btn').show();
    }
    else {
      $('#tweet_btn').hide();
      $('#retweet_btn').show();
    }
  });
  
  // リツイートダイアログ起動時の処理
  // 現状特になし
  $('#retweetModal').on('show.bs.modal', function (event) {
  });
  
  // フラッシュメッセージを消す
  $('.alert-success').fadeOut(3000);
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
//function execRetweet(micropost_id) {
//  $('#retweet_form_' + micropost_id).submit();
//}

