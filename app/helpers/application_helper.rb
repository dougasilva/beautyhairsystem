module ApplicationHelper
  def format_phone(phone)
    tel_formatado = '('
    tel_formatado << phone[0..1]
    tel_formatado << ') '
    tel_formatado << phone[2..5]
    tel_formatado << '-'
    tel_formatado << phone[6..9]
    tel_formatado
  end

  def format_cell_phone(cell_phone)
    tel_formatado = '('
    tel_formatado << cell_phone[0..1]
    tel_formatado << ') '
    tel_formatado << cell_phone[2..6]
    tel_formatado << '-'
    tel_formatado << cell_phone[7..10]
    tel_formatado
  end

  def format_cep(cep)
    cep_formatado = cep[0..4]
    cep_formatado << '-'
    cep_formatado << cep[5..7]
    cep_formatado
  end
end
