# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# VARIABLES:
glyphicon_ok_html = "<span class='glyphicon glyphicon-ok' aria-hidden='true'>"

# FUNCTIONS:
update_session = ()->
  lang_code1 = $('#lang_code1').val()
  lang_code2 = $('#lang_code2').val()
  $.post('/session/update_lang_pair', { lang_pair: "#{lang_code1}-#{lang_code2}" })

add_alert = (type, message)->
  $('.alerts').append("""
<div class="alert alert-#{type} alert-dismissible" role="alert">
<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
#{message}
</div>
""")
  $('.alert-dismissible .close').click ->
    $(this).parent().remove()

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

load_languages_and_select_one = (lang_code, lang, selected_lang)->
  $.getJSON '/dictionary/yandex/pairs', {lang_code: lang_code, lang: lang}, (resp)->
    lang_select2 = $('#lang_code2')
    lang_select2.empty()
    $(resp).each (index, [text, value])->
      lang_select2.append("""<option value="#{value}">#{text}</option>""")
    if selected_lang
      lang_select2.val(selected_lang)
    else
      lang_select2.val(resp[0][1])
    lang_select2.selectpicker('refresh')
    update_session()

show_correct_card_and_disable_cards = ()->
  word_id = $('#cards .word').attr('data-word-id')
  $("#cards .card[data-word-id='#{word_id}']").addClass('btn-success')
  $("#cards .card").each ->
    $(this).addClass('disabled') if not $(this).hasClass('disabled')

b_show = (e)->
  e = $(e)
  if e.hasClass('hidden')
    e.removeClass('hidden')

b_hide = (e)->
  e = $(e)
  unless e.hasClass('hidden')
    e.addClass('hidden')

$(document).ready ->
  $('.selectpicker').selectpicker();

# EVENTS:
$(document).on 'click', '#try_it', (event)->
  guest_email = 'guest@localhost'
  $('#user_email').val(guest_email)
  $('#user_password').val(guest_email)
  $('#new_user').submit()

$(document).on 'click', '#change_langs', (event)->
  lang_code1 = $('#lang_code1').val()
  lang_code2 = $('#lang_code2').val()
  $('#lang_code1').val(lang_code2)
  $('#lang_code1').selectpicker('refresh')
  lang = $('body').prop('lang')
  load_languages_and_select_one(lang_code2, lang, lang_code1)
  update_session()

$(document).on 'keypress', '#q', (event)->
  $('#translate').click() if event.keyCode == 13

$(document).on 'click', '#next-word', (event)->
  if not $(this).hasClass('disabled')
    location.reload()
    # fixme use ajax and don't use page reload

$(document).on 'click', '#skip-word', (event)->
  next_word = $('#next-word')
  next_word.removeClass('disabled')
  b_show(next_word)
  b_hide(this)
  show_correct_card_and_disable_cards()

$(document).on 'change', '#lang_code1', (event)->
  lang_code = $(this).val()
  lang_code2 = $('#lang_code2').val()
  lang = $('body').prop('lang')
  load_languages_and_select_one(lang_code, lang, lang_code2)

$(document).on 'change', '#lang_code2', (event)->
  update_session()

$(document).on 'click', '.select-all', (event)->
  rows = $('table tbody tr')
  number_of_rows = rows.length
  selected = $('table td.status span').length
  rows.each ->
    if number_of_rows == selected
      select_row($(this), false)
    else
      select_row($(this), true)

$(document).on 'click', '#translate', (event)->
  $('.alerts').empty()
  lang_code1 = $('#lang_code1').val()
  lang_code2 = $('#lang_code2').val()
  text = $('#q').val()
  lang_pair = lang_code1 + "-" + lang_code2
  # TODO: add check for lang_pair NOT here but in controller
  $.getJSON '/dictionary/yandex/lookup', {text: text, lang_pair: lang_pair}, (resp)->
    $('table tbody').empty()
    if resp.code
      add_alert('warning', resp['message'])
    else if resp.length == 0
      add_alert('info', 'No translations were found')
    else
      $(resp).each (i, e)->
        lang_pair = e['lang_pair']
        pos = e['pos']
        text1_gender = if e['text_gen']? then e['text_gen'] else ''
        text2_gender = if e['tr_gen']? then e['tr_gen'] else ''
        text = e['text']
        tr = e['tr']
        $('table tbody').append("""
        <tr class='translation cursor-pointer'>
          <td class='status'></td>
          <td class='lang_pair'>#{lang_pair}</td>
          <td class='pos'>#{pos}</td>
          <td class='text1'>#{text}</td>
          <td class='text1_gender gender'>#{text1_gender}</td>
          <td class='text2'>#{tr}</td>
          <td class='text2_gender gender'>#{text2_gender}</td>
        </tr>
        """
        )
      $('table tr.translation').click ->
        tr = $(this)
        glyph = 'span.glyphicon'
        if tr.find(glyph).length == 0
          select_row(tr, true)
        else
          select_row(tr, false)

$(document).on 'click', '#cards .card', (event)->
  if $(this).hasClass('disabled')
    return false

  b_hide($('#skip-word'))
  b_show($('#next-word'))

  word_id = $('#cards .word').attr('data-word-id')
  trans_id = $(this).attr('data-word-id')
  $(this).removeClass('btn-default')
  if word_id == trans_id
    command = 'increase'
  else
    $(this).addClass('btn-danger')
    command = 'decrease'

  $.post('/update_score', {command: command, word_id: word_id}, (resp)->
    score_element = $('#score')
    score = parseInt(score_element.text())
    if command == 'increase'
      score += 1
    else if command == 'decrease'
      score -= 1
    score_element.text(score)

    show_correct_card_and_disable_cards()

    next_word_btn = $('#next-word')
    $.each(['disabled', 'btn-default'], (index, value)->
      if next_word_btn.hasClass(value)
        next_word_btn.removeClass(value)
    )
    next_word_btn.addClass('btn-primary')
  )

$(document).on 'click', '#add-words', (event)->
  $('.alerts').empty()
  glyphicons = $('td.status > span.glyphicon')
  if glyphicons.length == 0
    add_alert('warning', 'No translations were selected')

  glyphicons.each ->
    row = $(this).parent().parent()
    lang_pair = row.find('td.lang_pair').text()
    lang_pair = lang_pair.split('-')
    lang_code1 = lang_pair[0]
    lang_code2 = lang_pair[1]
    pos = row.find('td.pos').text()
    text1 = row.find('td.text1').text()
    text1_gender = row.find('td.text1_gender').text()
    text2 = row.find('td.text2').text()
    text2_gender = row.find('td.text2_gender').text()

    data = {
      word: {
        lang_code1: lang_code1,
        lang_code2: lang_code2,
        pos: pos,
        text1: text1,
        text1_gender: text1_gender,
        text2: text2,
        text2_gender: text2_gender,
      }
    }
    $.post('/words.json', data, (resp)->
      message = "Pair '#{resp['text1']} - #{resp['text2']}' was added successfully"
      add_alert('success', message)
      now_element = $('#number-of-words')
      number_of_words = parseInt(now_element.text())
      number_of_words += 1
      now_element.text(number_of_words)
    ).error (resp)->
      if resp.status == 422
        alert_type = 'warning'
      else
        alert_type = 'danger'
      message = $.map(resp.responseJSON, (v,k)->
        k + " " + v.join(', ');
      ).join('. ')
      add_alert(alert_type, message)
