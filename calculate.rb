# frozen_string_literal: true

$widths = %w[A B C D E EE F FF FFF FFFF]

$sizes = (4..15).step(0.5).map do |size|
  size.to_s.sub('.0', '').sub('.5', ' 1/2')
end

origins = {
  ball: { wholes: 7, eighths: 6 },
  instep: { wholes: 8, eighths: 0 },
  heel: { wholes: 11, eighths: 4 }
}

def add(quantity, eighths)
  quantity[:eighths] += eighths
  while quantity[:eighths] >= 8
    quantity[:wholes] += 1
    quantity[:eighths] = 0
  end
end

$data = {}

$sizes.each_with_index do |size, size_index|
  $data[size] = {}
  $widths.each_with_index do |width, width_index|
    ball = origins[:ball].dup
    instep = origins[:instep].dup
    heel = origins[:heel].dup
    width_index.times do
      add(ball, 2)
      add(instep, 2)
      add(heel, 2)
    end
    size_index.times do
      add(ball, 1)
      add(instep, 1)
      add(heel, 1)
    end
    $data[size][width] = { ball: ball, instep: instep, heel: heel }
  end
end
