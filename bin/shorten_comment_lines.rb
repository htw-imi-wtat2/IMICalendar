require 'fileutils'
files = `rubocop --only Metrics/LineLength --format files`

files.each_line do |file_name|
  file_name = file_name.strip
  output_fn = "#{file_name}.shortened"
  output = File.open(output_fn, 'w')

  File.open(file_name).each do |line|
    m = /\A\s*(#)/.match(line)
    if m && line.size > 80
      i = line[0..79].rindex(' ')
      output.puts(line[0..(i - 1)])
      spaces = ' ' * m.begin(1)
      rest = line[(i + 1)..line.length]
      output.puts spaces + '# ' + rest
    else
      output.puts(line)
    end
  end
  FileUtils.mv output_fn, file_name
end
