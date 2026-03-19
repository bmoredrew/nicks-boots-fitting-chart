#!/usr/bin/env ruby
# frozen_string_literal: true

require './calculate'
require './display'

# Input measurements
length = 10.125
target_ball = 10.875  # 10 7/8"
target_instep = 11.25 # 11 1/4"
target_heel = 13.5    # 13 1/2"

puts "Analyzing measurements:"
puts "  Length: 10 1/8\" (#{length}\")"
puts "  Ball: 10 7/8\" (#{target_ball}\")"
puts "  Instep: 11 1/4\" (#{target_instep}\")"
puts "  Heel: 13 1/2\" (#{target_heel}\")"
puts

# Find length size
puts "LENGTH-BASED SIZE:"
$length_data.each do |size, data|
  if length >= data[:min_inches] && length <= data[:max_inches]
    puts "  ✓ Size #{size.sub(' 1/2', '½')}: #{data[:min_inches]}\"-#{data[:max_inches]}\""
  end
end
puts

# Check widths for size 8
puts "WIDTH OPTIONS FOR SIZE 8:"
puts "%-8s  %-10s  %-10s  %-10s  %s" % ['Width', 'Ball', 'Instep', 'Heel', 'Fit?']
puts "-" * 60

$widths.each do |width|
  data = $data['8'][width]
  ball = data[:ball][:wholes] + data[:ball][:eighths] / 8.0
  instep = data[:instep][:wholes] + data[:instep][:eighths] / 8.0
  heel = data[:heel][:wholes] + data[:heel][:eighths] / 8.0
  
  ball_fit = ball >= target_ball
  instep_fit = instep >= target_instep
  heel_fit = heel >= target_heel
  all_fit = ball_fit && instep_fit && heel_fit
  
  ball_display = display(data[:ball])
  instep_display = display(data[:instep])
  heel_display = display(data[:heel])
  
  fit_marker = all_fit ? "✓ FIT" : ""
  puts "%-8s  %-10s  %-10s  %-10s  %s" % [width, ball_display + '"', instep_display + '"', heel_display + '"', fit_marker]
end

puts
puts "BEST MATCHES (by total distance from target measurements):"
puts

# Calculate distance for all sizes/widths
matches = []
['7 1/2', '8', '8 1/2'].each do |size|
  next unless $data[size]
  
  $widths.each do |width|
    data = $data[size][width]
    ball = data[:ball][:wholes] + data[:ball][:eighths] / 8.0
    instep = data[:instep][:wholes] + data[:instep][:eighths] / 8.0
    heel = data[:heel][:wholes] + data[:heel][:eighths] / 8.0
    
    # Calculate absolute distance from target for each measurement
    ball_diff = (ball - target_ball).abs
    instep_diff = (instep - target_instep).abs
    heel_diff = (heel - target_heel).abs
    
    # Total distance (you could also weight these differently)
    total_distance = ball_diff + instep_diff + heel_diff
    
    matches << {
      size: size,
      width: width,
      ball: ball,
      instep: instep,
      heel: heel,
      distance: total_distance,
      ball_diff: ball_diff,
      instep_diff: instep_diff,
      heel_diff: heel_diff
    }
  end
end

# Sort by total distance and show top 5
matches.sort_by! { |m| m[:distance] }
matches.first(5).each_with_index do |match, index|
  size_display = match[:size].sub(' 1/2', '½')
  puts "#{index + 1}. Size #{size_display} #{match[:width]}"
  puts "   Ball: #{match[:ball]}\" (#{match[:ball_diff] > 0 ? '+' : ''}#{sprintf('%.3f', match[:ball] - target_ball)}\")"
  puts "   Instep: #{match[:instep]}\" (#{match[:instep_diff] > 0 ? '+' : ''}#{sprintf('%.3f', match[:instep] - target_instep)}\")"
  puts "   Heel: #{match[:heel]}\" (#{match[:heel_diff] > 0 ? '+' : ''}#{sprintf('%.3f', match[:heel] - target_heel)}\")"
  puts "   Total deviation: #{sprintf('%.3f', match[:distance])}\"" 
  puts
end
