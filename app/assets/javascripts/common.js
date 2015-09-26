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
  
  // リツイートダイアログでボタン名変更
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
  
  // 画像選択エリアの表示/非表示
  $('.glyphicon-camera').click(function() {
    $('#image_uploader').toggle();
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
function execRetweet(micropost_id) {
  $('#retweet_id').val(micropost_id);
  $('#retweet_content').val('');  // 空にする
  $('#retweetModal').modal();
}

// リツイート解除
function execUnRetweet(micropost_id) {
  $('#unRetweet_form_' + micropost_id).submit();
}

