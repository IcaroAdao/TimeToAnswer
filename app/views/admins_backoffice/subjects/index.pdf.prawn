prawn_document do |pdf|
  pdf.text 'Lista de assuntos:'
  pdf.move_down 20
  pdf.table @subjects.collect{|s| [s.id,s.description]}
end