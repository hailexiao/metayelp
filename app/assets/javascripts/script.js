$('#up-vote').on('click', function(e) {
      e.preventDefault();

      var $this = $(this);
      var reviewId = $this.data('data-review-id');

      $.post('/reviews/' + reviewId + '/upvote')
       .done(function(resp) {
          $this.find('.upvote-count').html(resp.upvotes_count);
       })
    })

$('#down-vote').on('click', function(e) {
      e.preventDefault();

      var $this = $(this);
      var reviewId = $this.data('data-review-id');

      $.post('/reviews/' + reviewId + '/downvote')
       .done(function(resp) {
          $this.find('.downvote-count').html(resp.upvotes_count);
       })
    })
