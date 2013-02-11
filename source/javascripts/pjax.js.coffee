jQuery ->

  # Make sure pushState is supported before continuing
  if history.pushState
    jQuery('body').on 'click', '.DWjax', ->
      element = jQuery(this)
      href = element.attr('href')
      new DWjax(href, true)
      false

    jQuery(window).bind 'popstate', (e)->
      if window.pushed == true || typeof window.pushed == "undefined"
        console.log 'going back!'
        new DWjax(location.pathname, false)

class DWjax
  constructor: (url, push) ->
    @url = url
    @push = push
    this.retrieveHTML()

  retrieveHTML: ->
    jQuery.ajax @url,
      type: 'GET',
      dataType: 'html'
    .done (data, textStatus, jqXHR) => 
      @data = jQuery(data)
      this.updatePage()
      console.log 'Success'

    .fail (jqXHR, textStatus, errorThrown) ->
      window.location = @url
      console.log 'Failure'

  updatePage: ->
    @title = @data.filter('title').first().text()
    @content = @data.find('div#wrapper').html()
    console.log 'Loading data for ' + @url

    jQuery('div#wrapper').html(@content)
    document.title = @title

    if @push
      window.history.pushState(null, null, @url)
      window.pushed = true
