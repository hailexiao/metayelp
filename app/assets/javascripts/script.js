$('#up-vote').on('click', function(e) {
      e.preventDefault();
      var $this = $(this);
      var reviewId = $this.attr('data');

       $.ajax({
         method: 'POST',
         url: '/upvote/' + reviewId,
         dataType: 'json'
       })
       .done(function(resp) {
          var div = $this.parent()
          div.find('.upvote-count').html(resp.upvotesCount);
          div.find('.downvote-count').html(resp.downvotesCount);
       });
    });

$('#down-vote').on('click', function(e) {
      e.preventDefault();

      var $this = $(this);
      var reviewId = $this.attr('data');

      $.ajax({
        method: 'POST',
        url: '/downvote/' + reviewId,
        dataType: 'json'
      })
       .done(function(resp) {
          var div = $this.parent()
          div.find('.downvote-count').html(resp.downvotes_count);
          div.find('.upvote-count').html(resp.upvotes_count);
       });
    });
