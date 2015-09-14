$(function($){
  var labels = [ '赤', '橙', '黄', '緑', '青', '藍', '紫' ];
  var colors = [ 'E60012', 'F39800', 'FFF100', '009944', '0068B7', '1D2088', '920783'];

  $("#small-selector").colorbox({
    labels: labels,
    colors: colors,
    width: 50,
    height: 50,
    top: 0,
    left: 0,
    perLine: 7,
    onSelect: function($selected, color, index, label){
			$("#colorIndex").val(index);
		}
  });
});

// 色を設定する
function setColor(colorIndex) {
  if (colorIndex == '') {
    colorIndex = 0;
  }
  $("#small-selector").colorbox('setColorIndex', parseInt(colorIndex));
  $("#colorIndex").val(0);
}
