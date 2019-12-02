
$ ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 3100
        $('.pagination').replaceWith("<img src='https://media3.giphy.com/media/xT9DPldJHzZKtOnEn6/200w.webp?cid=790b76115cff40a84262756a77999892&rid=200w.webp' class='pagination' alt='loading-spinner'>")
        $.getScript(url)
    $(window).scroll()
