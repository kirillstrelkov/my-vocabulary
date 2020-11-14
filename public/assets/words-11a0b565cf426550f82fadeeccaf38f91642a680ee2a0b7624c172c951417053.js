(function() {
  var add_alert, b_hide, b_show, glyphicon_ok_html, load_languages_and_select_one, select_row, show_correct_card_and_disable_cards, update_session;

  glyphicon_ok_html = "<span class='glyphicon glyphicon-ok' aria-hidden='true'>";

  update_session = function() {
    var lang_code1, lang_code2;
    lang_code1 = $('#lang_code1').val();
    lang_code2 = $('#lang_code2').val();
    return $.post('/session/update_lang_pair', {
      lang_pair: lang_code1 + "-" + lang_code2
    });
  };

  add_alert = function(type, message) {
    $('.alerts').append("<div class=\"alert alert-" + type + " alert-dismissible\" role=\"alert\">\n<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" + message + "\n</div>");
    return $('.alert-dismissible .close').click(function() {
      return $(this).parent().remove();
    });
  };

  select_row = function(row, selected) {
    var glyph, status;
    row = $(row);
    glyph = 'span.glyphicon';
    status = $(row.find('td.status'));
    if (selected) {
      if (row.find(glyph).length === 0) {
        return status.append($(glyphicon_ok_html));
      }
    } else {
      if (row.find(glyph).length !== 0) {
        return status.empty();
      }
    }
  };

  load_languages_and_select_one = function(lang_code, lang, selected_lang) {
    return $.getJSON('/dictionary/yandex/pairs', {
      lang_code: lang_code,
      lang: lang
    }, function(resp) {
      var lang_select2;
      lang_select2 = $('#lang_code2');
      lang_select2.empty();
      $(resp).each(function(index, arg) {
        var text, value;
        text = arg[0], value = arg[1];
        return lang_select2.append("<option value=\"" + value + "\">" + text + "</option>");
      });
      if (selected_lang) {
        lang_select2.val(selected_lang);
      } else {
        lang_select2.val(resp[0][1]);
      }
      lang_select2.selectpicker('refresh');
      return update_session();
    });
  };

  show_correct_card_and_disable_cards = function() {
    var word_id;
    word_id = $('#cards .word').attr('data-word-id');
    $("#cards .card[data-word-id='" + word_id + "']").addClass('btn-success');
    return $("#cards .card").each(function() {
      if (!$(this).hasClass('disabled')) {
        return $(this).addClass('disabled');
      }
    });
  };

  b_show = function(e) {
    e = $(e);
    if (e.hasClass('hidden')) {
      return e.removeClass('hidden');
    }
  };

  b_hide = function(e) {
    e = $(e);
    if (!e.hasClass('hidden')) {
      return e.addClass('hidden');
    }
  };

  $(document).ready(function() {
    return $('.selectpicker').selectpicker();
  });

  $(document).on('click', '#clear_search', function(event) {
    $('#q').val('');
    return $('#q').focus();
  });

  $(document).on('click', '#try_it', function(event) {
    var guest_email;
    guest_email = 'guest@localhost';
    $('#user_email').val(guest_email);
    $('#user_password').val(guest_email);
    return $('#new_user').submit();
  });

  $(document).on('click', '#change_langs', function(event) {
    var lang, lang_code1, lang_code2;
    lang_code1 = $('#lang_code1').val();
    lang_code2 = $('#lang_code2').val();
    $('#lang_code1').val(lang_code2);
    $('#lang_code1').selectpicker('refresh');
    lang = $('body').prop('lang');
    load_languages_and_select_one(lang_code2, lang, lang_code1);
    return update_session();
  });

  $(document).on('keypress', '#q', function(event) {
    if (event.keyCode === 13) {
      return $('#translate').click();
    }
  });

  $(document).on('click', '#next-word', function(event) {
    if (!$(this).hasClass('disabled')) {
      return location.reload();
    }
  });

  $(document).on('click', '#skip-word', function(event) {
    var next_word;
    next_word = $('#next-word');
    next_word.removeClass('disabled');
    b_show(next_word);
    b_hide(this);
    return show_correct_card_and_disable_cards();
  });

  $(document).on('change', '#lang_code1', function(event) {
    var lang, lang_code, lang_code2;
    lang_code = $(this).val();
    lang_code2 = $('#lang_code2').val();
    lang = $('body').prop('lang');
    return load_languages_and_select_one(lang_code, lang, lang_code2);
  });

  $(document).on('change', '#lang_code2', function(event) {
    return update_session();
  });

  $(document).on('click', '.select-all', function(event) {
    var number_of_rows, rows, selected;
    rows = $('table tbody tr');
    number_of_rows = rows.length;
    selected = $('table td.status span').length;
    return rows.each(function() {
      if (number_of_rows === selected) {
        return select_row($(this), false);
      } else {
        return select_row($(this), true);
      }
    });
  });

  $(document).on('click', '#translate', function(event) {
    var lang_code1, lang_code2, lang_pair, text;
    $('.alerts').empty();
    lang_code1 = $('#lang_code1').val();
    lang_code2 = $('#lang_code2').val();
    text = $('#q').val();
    lang_pair = lang_code1 + "-" + lang_code2;
    return $.getJSON('/dictionary/yandex/lookup', {
      text: text,
      lang_pair: lang_pair
    }, function(resp) {
      $('table tbody').empty();
      if (resp.code) {
        return add_alert('warning', resp['message']);
      } else if (resp.length === 0) {
        return add_alert('info', 'No translations were found');
      } else {
        $(resp).each(function(i, e) {
          var formatted_text1, formatted_text2, lang1, lang2, pos, text1, text1_gender, text2, text2_gender;
          lang_pair = e['lang_pair'];
          lang1 = lang_pair.split('-')[0];
          lang2 = lang_pair.split('-')[1];
          pos = e['pos'];
          text1_gender = e['text_gen'] != null ? e['text_gen'] : '';
          text2_gender = e['tr_gen'] != null ? e['tr_gen'] : '';
          text1 = e['text'];
          text2 = e['tr'];
          formatted_text1 = text1_gender ? text1 + "(" + text1_gender + ")" : text1;
          formatted_text2 = text2_gender ? text2 + "(" + text2_gender + ")" : text2;
          return $('table tbody').append("<tr class='translation cursor-pointer'\n  data-lang_pair='" + lang_pair + "' data-pos='" + pos + "'\n  data-text1='" + text1 + "' data-text1_gender='" + text1_gender + "'\n  data-text2='" + text2 + "' data-text2_gender='" + text2_gender + "'>\n  <td class='status'></td>\n  <td class='lang1 hidden-xs'>" + lang1 + "</td>\n  <td class='lang2 hidden-xs'>" + lang2 + "</td>\n  <td class='pos'>" + pos + "</td>\n  <td class='text1'>" + formatted_text1 + "</td>\n  <td class='text2'>" + formatted_text2 + "</td>\n</tr>");
        });
        return $('table tr.translation').click(function() {
          var glyph, tr;
          tr = $(this);
          glyph = 'span.glyphicon';
          if (tr.find(glyph).length === 0) {
            return select_row(tr, true);
          } else {
            return select_row(tr, false);
          }
        });
      }
    });
  });

  $(document).on('click', '#cards .card', function(event) {
    var command, trans_id, word_id;
    if ($(this).hasClass('disabled')) {
      return false;
    }
    b_hide($('#skip-word'));
    b_show($('#next-word'));
    word_id = $('#cards .word').attr('data-word-id');
    trans_id = $(this).attr('data-word-id');
    $(this).removeClass('btn-default');
    if (word_id === trans_id) {
      command = 'increase';
    } else {
      $(this).addClass('btn-danger');
      command = 'decrease';
    }
    return $.post('/update_score', {
      command: command,
      word_id: word_id
    }, function(resp) {
      var next_word_btn, score, score_element;
      score_element = $('#score');
      score = parseInt(score_element.text());
      if (command === 'increase') {
        score += 1;
      } else if (command === 'decrease') {
        score -= 1;
      }
      score_element.text(score);
      show_correct_card_and_disable_cards();
      next_word_btn = $('#next-word');
      $.each(['disabled', 'btn-default'], function(index, value) {
        if (next_word_btn.hasClass(value)) {
          return next_word_btn.removeClass(value);
        }
      });
      return next_word_btn.addClass('btn-primary');
    });
  });

  $(document).on('click', '#add-words', function(event) {
    var glyphicons;
    $('.alerts').empty();
    glyphicons = $('td.status > span.glyphicon');
    if (glyphicons.length === 0) {
      add_alert('warning', 'No translations were selected');
    }
    return glyphicons.each(function() {
      var data, lang_code1, lang_code2, lang_pair, pos, row, text1, text1_gender, text2, text2_gender;
      row = $(this).parent().parent();
      lang_pair = row.data('lang_pair').split('-');
      lang_code1 = lang_pair[0];
      lang_code2 = lang_pair[1];
      pos = row.data('pos');
      text1 = row.data('text1');
      text1_gender = row.data('text1_gender');
      text2 = row.data('text2');
      text2_gender = row.data('text2_gender');
      data = {
        word: {
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          pos: pos,
          text1: text1,
          text1_gender: text1_gender,
          text2: text2,
          text2_gender: text2_gender
        }
      };
      return $.post('/words.json', data, function(resp) {
        var message, now_element, number_of_words;
        message = "Pair '" + resp['text1'] + " - " + resp['text2'] + "' was added successfully";
        add_alert('success', message);
        now_element = $('#number-of-words');
        number_of_words = parseInt(now_element.text());
        number_of_words += 1;
        return now_element.text(number_of_words);
      }).error(function(resp) {
        var alert_type, message;
        if (resp.status === 422) {
          alert_type = 'warning';
        } else {
          alert_type = 'danger';
        }
        message = $.map(resp.responseJSON, function(v, k) {
          return k + " " + v.join(', ');
        }).join('. ');
        return add_alert(alert_type, message);
      });
    });
  });

}).call(this);
