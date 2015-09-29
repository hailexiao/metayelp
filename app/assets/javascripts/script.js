$('#up-vote').on('click', function(e) {
      e.preventDefault();

      var $this = $(this);
      var reviewId = $this.attr('data-review-id');
      var yelperId = $this.attr('data-yelper-id');

       $.ajax({
         method: 'POST',
         url: '/yelpers/' + yelperId + '/reviews/' + reviewId + '/upvotes',
         dataType: 'json'
       }).done(function(resp) {
          var div = $this.parent();
          div.find('.upvote-count').html(resp.upvotesCount);
          div.find('.downvote-count').html(resp.downvotesCount);
       });
    });

$('#down-vote').on('click', function(e) {
      e.preventDefault();
      var $this = $(this);
      var reviewId = $this.attr('data-review-id');
      var yelperId = $this.attr('data-yelper-id');

      $.ajax({
        method: 'POST',
        url: '/yelpers/' + yelperId + '/reviews/' + reviewId + '/downvotes',
        dataType: 'json'
      }).done(function(resp) {
          var div = $this.parent();
          div.find('.downvote-count').html(resp.downvotesCount);
          div.find('.upvote-count').html(resp.upvotesCount);
       });
    });
