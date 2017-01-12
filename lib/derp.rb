true_false_correlation = state_wide_correlation.map do |correlation|
  if  correlation > 0.6 && correlation < 1.5
    correlation = true
  else
    false
  end
end
end
correlation_true_count = true_false_correlation.count do |correlation|
correlation == true
if correlation_true_count.to_f >= (true_false_correlation.count * 0.7)
  true
else
  false
end
end
