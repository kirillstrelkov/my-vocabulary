# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
glyphicon_ok_html = "<span class='glyphicon glyphicon-ok' aria-hidden='true'>"
$(document).ready ->
  $('.select-all').click ->
    rows = $('table tbody tr')
    number_of_rows = rows.length
    selected = $('table td.status span').length
    rows.each ->
      if number_of_rows == selected
        select_row($(this), false)
      else
        select_row($(this), true)

  $('#translate').click ->
    lang_code1 = $('#lang_code1').val()
    lang_code2 = $('#lang_code2').val()
    text = $('#q').val()
    lang_pair = lang_code1 + "-" + lang_code2
    # TODO: add check for lang_pair NOT here but in controller
    $.getJSON '/dictionary/yandex/lookup', {text: text, lang_pair: lang_pair}, (resp)->
      $('table tbody').empty()
      $(resp).each (i, e)->
        lang_pair = e['lang_pair']
        pos = e['pos']
        text = e['text']
        tr = e['tr']
        $('table tbody').append("<tr class='translation cursor-pointer'><td class='status'>" + glyphicon_ok_html + "</td><td class='lang_pair'>"+lang_pair+"</td><td class='pos'>"+pos+"</td><td class='text1'>"+text+"</td><td class='text2'>"+tr+"</td></tr>")
      $('table tr.translation').click ->
          tr = $(this)
          glyph = 'span.glyphicon'
          if tr.find(glyph).length == 0
            select_row(tr, true)
          else
            select_row(tr, false)

  select_row = (row, selected)->
    row = $(row)
    glyph = 'span.glyphicon'
    status = $(row.find('td.status'))
    if selected
      if row.find(glyph).length == 0
        status.append($(glyphicon_ok_html))
    else
      if row.find(glyph).length != 0
        status.empty()

  $('#add-words').click ->
    $('td.status > span.glyphicon').each ->
      row = $(this).parent().parent()
      lang_pair = row.find('td.lang_pair').text()
      lang_pair = lang_pair.split('-')
      lang_code1 = lang_pair[0]
      lang_code2 = lang_pair[1]
      pos = row.find('td.pos').text()
      text1 = row.find('td.text1').text()
      text2 = row.find('td.text2').text()

      data = {
        word: {
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          pos: pos,
          text1: text1,
          text2: text2
        }
      }
      $.post('/words.json', data, (resp)->
        message = "Pair '#{resp['text1']} - #{resp['text2']}' was added successfully"
        $('.alerts').append("""
<div class="alert alert-success alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  #{message}
</div>
""")
        $('.alert-dismissible .close').click ->
          $(this).parent().remove()
      ).error (resp)->
        message = $.map(resp.responseJSON, (v,k)->
          k + " " + v.join(', ');
        ).join('. ')
        $('.alerts').append("""
<div class="alert alert-warning alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  #{message}
</div>
""")
        $('.alert-dismissible .close').click ->
          $(this).parent().remove()
