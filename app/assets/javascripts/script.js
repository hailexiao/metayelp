$('#up-vote').on('click', function(e) {
      e.preventDefault();
      var $this = $(this);
      var reviewId = $this.attr('data');

      $.post('/upvote/' + reviewId)
       .done(function(resp) {
          var div = $this.parent()
          div.find('.upvote-count').html(resp.upvotes_count);
          div.find('.downvote-count').html(resp.downvotes_count);
       })
    })c

$('#down-vote').on('click', function(e) {
      e.preventDefault();

      var $this = $(this);
      var reviewId = $this.attr('data');

      $.post('/downvote/' + reviewId)
       .done(function(resp) {
          var div = $this.parent()
          div.find('.downvote-count').html(resp.downvotes_count);
          div.find('.upvote-count').html(resp.upvotes_count);
       })
    })
