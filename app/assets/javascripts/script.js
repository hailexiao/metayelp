$('#up-vote').on('click', function(e) {
      e.preventDefault();
      var $this = $(this);
      var reviewId = $this.attr('data');

      $.post('/upvote/' + reviewId)
       .done(function(resp) {
          $this.find('.upvote-count').html(resp.upvotes_count);
       })
    })

$('#down-vote').on('click', function(e) {
      e.preventDefault();

      var $this = $(this);
      var reviewId = $this.attr('data');

      $.post('/downvote/' + reviewId)
       .done(function(resp) {
          $this.find('.downvote-count').html(resp.upvotes_count);
       })
    })
