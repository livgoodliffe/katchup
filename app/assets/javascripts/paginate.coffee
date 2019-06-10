$ ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 2100
        $('.pagination').text("Loading more products...")
        $.getScript(url)
    $(window).scroll()
