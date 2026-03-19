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

# Foot length data: min and max in inches and millimeters for each size
$length_data = {
  '4' => { min_inches: 8.669, max_inches: 8.835, min_mm: 220.2, max_mm: 224.4 },
  '4 1/2' => { min_inches: 8.839, max_inches: 9.000, min_mm: 224.5, max_mm: 228.6 },
  '5' => { min_inches: 9.004, max_inches: 9.165, min_mm: 228.7, max_mm: 232.8 },
  '5 1/2' => { min_inches: 9.169, max_inches: 9.335, min_mm: 232.9, max_mm: 237.1 },
  '6' => { min_inches: 9.339, max_inches: 9.500, min_mm: 237.2, max_mm: 241.3 },
  '6 1/2' => { min_inches: 9.504, max_inches: 9.665, min_mm: 241.4, max_mm: 245.5 },
  '7' => { min_inches: 9.669, max_inches: 9.835, min_mm: 245.6, max_mm: 249.8 },
  '7 1/2' => { min_inches: 9.839, max_inches: 10.000, min_mm: 249.9, max_mm: 254.0 },
  '8' => { min_inches: 10.004, max_inches: 10.165, min_mm: 254.1, max_mm: 258.2 },
  '8 1/2' => { min_inches: 10.169, max_inches: 10.335, min_mm: 258.3, max_mm: 262.5 },
  '9' => { min_inches: 10.339, max_inches: 10.500, min_mm: 262.6, max_mm: 266.7 },
  '9 1/2' => { min_inches: 10.504, max_inches: 10.665, min_mm: 266.8, max_mm: 270.9 },
  '10' => { min_inches: 10.669, max_inches: 10.835, min_mm: 271.0, max_mm: 275.2 },
  '10 1/2' => { min_inches: 10.839, max_inches: 11.000, min_mm: 275.3, max_mm: 279.4 },
  '11' => { min_inches: 11.004, max_inches: 11.165, min_mm: 279.5, max_mm: 283.6 },
  '11 1/2' => { min_inches: 11.169, max_inches: 11.335, min_mm: 283.7, max_mm: 287.9 },
  '12' => { min_inches: 11.339, max_inches: 11.500, min_mm: 288.0, max_mm: 292.1 },
  '12 1/2' => { min_inches: 11.504, max_inches: 11.665, min_mm: 292.2, max_mm: 296.3 },
  '13' => { min_inches: 11.669, max_inches: 11.835, min_mm: 296.4, max_mm: 300.6 },
  '13 1/2' => { min_inches: 11.839, max_inches: 12.000, min_mm: 300.7, max_mm: 304.8 },
  '14' => { min_inches: 12.004, max_inches: 12.165, min_mm: 304.9, max_mm: 309.0 },
  '14 1/2' => { min_inches: 12.169, max_inches: 12.335, min_mm: 309.1, max_mm: 313.3 },
  '15' => { min_inches: 12.339, max_inches: 12.500, min_mm: 313.4, max_mm: 317.5 }
}
