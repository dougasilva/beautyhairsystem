reservas =
  init: ->
    $("#reserva_servico_id").click ->
      $('#reserva_profissional_id').empty()
      servico = $('#reserva_servico_id').val()
      url = "#{reservas.url}#{servico}"
      console.log(url)
      $.getJSON(url,{}, (data) ->
        $.each(data, (i, obj) ->
          console.log(obj)
          $('#reserva_profissional_id').append(
            $('<option></option>')
              .val(obj['id'])
              .html(obj['nome'])
          )
        )
      )
  url: '/profissionais.json?servico='

$(document).ready reservas.init
