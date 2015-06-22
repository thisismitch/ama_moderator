$(function(){

  $('.barGraph').each(function(){
    var upVotes = $(this).data('votes-up');
    var downVotes = $(this).data('votes-down');
    var total = upVotes + downVotes;
    var upPerc = upVotes/total*100;
    var downPerc = downVotes/total*100;

    $(this).append('<div class="barGraph-upVotes" style="width:' + upPerc + '%;"></div><div class="barGraph-downVotes" style="width:' + downPerc + '%;"></div>');

  })
})