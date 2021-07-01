$(function() {

  var user = $('.user');
  // $('.with-user').children().each(function(index) {
  //   var element = $(`.with-user > .category-group:eq(${index}) > .mind-card`);
  //   connectLine(user, element);
  //   $(`.with-user > .category-group:eq(${index}) > .with-category`).children().each(function(index2) {
  //     var element2 = $(`.with-user > .category-group:eq(${index}) > .with-category > .child-group:eq(${index2}) > .mind-card`);
  //     connectLine(element, element2);
  //     $(`.with-user > .category-group:eq(${index}) > .with-category > .child-group:eq(${index2}) > .with-child`).children().each(function(index3) {
  //       var element3 = $(`.with-user > .category-group:eq(${index}) > .with-category > .child-group:eq(${index2}) > .with-child > .mind-card:eq(${index3})`);
  //       connectLine(element2, element3);
  //     });
  //   });
  // });
  $('.category').each(function(index) {
    var childElement = $(`.category:eq(${index})`);
    var parentElement = childElement.closest('.children').prev();
    console.log(childElement);
    console.log(parentElement);
    connectLine(childElement, parentElement);
  })

  $('.memo').each(function(index) {
    var childElement = $(`.memo:eq(${index})`);
    var parentElement = childElement.closest('.children').prev();
    console.log(childElement);
    console.log(parentElement);
    connectLine(childElement, parentElement);
  })



  function connectLine(element1, element2) {
    var x1, y1;
    var x2, y2;

    var element1pos = element1.offset();
    var element2pos = element2.offset();

    x1 = element1pos.left + element1.width() + 40 + 1 + - 200;
    y1 = element1pos.top + element1.height() / 2 + 20 + 5;

    x2 = element2pos.left + 1 + 200;
    y2 = element2pos.top + element2.height() / 2 + 20 + 5;

    // 始点と終点の距離
    var x12 = x2 - x1;
    var y12 = y2 - y1;

    // 始点の制御点
    var X1 = x1 + x12 * 0.6;
    // var Y1 = y1 + y12;
    var Y1 = y1;
    // 終点の制御点
    // var X2 = x2 - x12;
    var X2 = x2 - x12 * 0.6;
    var Y2 = y2;

    var body = $('body');

    var path = `<svg class="minds-svg">
  <path d="M ${x1} ${y1} C ${X1} ${Y1} ${X2} ${Y2} ${x2} ${y2}" stroke="black" fill="transparent" /></svg>`;

    $('body').append(path);
  }
});
