require 'RMagick'
include Magick
img = Image.read('lenna_in.png')[0]

# юзерские колонки и строки
columns = ARGV.first.to_i
rows = ARGV.last.to_i

# считаем ширину и высоту клетки
width = img.columns / columns
height = img.rows / rows

columns.times do |c|
  rows.times do |r|

    gc = Magick::Draw.new
    gc.stroke('transparent')
    # рассчитываем прозрачность заливки в зависимости от четности текушей колонки и строки
    if c.even?
      r.even? ? gc.fill_opacity(0) : gc.fill_opacity(0.45)
    else
      r.even? ? gc.fill_opacity(0.45) : gc.fill_opacity(0)
    end

    gc.fill = 'lime'

    # рисуем прямоугольник по координатам
    gc.rectangle(width*c, height*r, width*c+width, height*r+height)
    gc.draw(img)

  end
end

img.write 'lenna_out.png'

