require 'rubygems'
require 'open-uri'

# Rake task for importing country names from Unicode.org's CLDR repository
# (http://www.unicode.org/cldr/data/charts/summary/root.html).
# 
# It parses a HTML file from Unicode.org for given locale and saves the 
# Rails' I18n hash in the plugin +locale+ directory
# 
# Don't forget to restart the application when you add new locale to load it into Rails!
# 
# == Example
#   rake import:country_select LOCALE=de
# 
# The code is deliberately procedural and simple, so it's easily
# understandable by beginners as an introduction to Rake tasks power.
# See http://github.com/joshmh/cldr/tree/master/converter.rb for much more robust solution

namespace :import do

  desc "Import country codes and names for various languages from the Unicode.org CLDR archive."
  task :country_select do
    begin
      require 'nokogiri'
    rescue LoadError
      puts "Error: Nokogiri library required to use this task (import:country_select)"
      exit
    end

    begin
      require 'ya2yaml'
    rescue LoadError
      puts "Error: ya2yaml library required to use this task (import:country_select)"
      exit
    end

    if RUBY_VERSION < '1.9'
      $KCODE = 'u'
    end

    # Setup variables
    locales = ENV['LOCALES']
    unless locales
      puts "\n[!] Usage: rake import:country_select LOCALES=de,en\n\n"
      exit 0
    end
    locales = locales.split(',')

    ignore_list = ENV['IGNORE'] ? ENV['IGNORE'].split(',') : []

    locales.each do |locale|

      # ----- Get the CLDR HTML     --------------------------------------------------
      begin
        puts "... getting the HTML file for locale '#{locale}'"
        doc = Nokogiri( open("http://www.unicode.org/cldr/data/charts/summary/#{locale}.html") )
      rescue => e
        puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
        exit 0
      end


      # ----- Parse the HTML with Hpricot     ----------------------------------------
      puts "... parsing the HTML file"
      countries = {}
      doc.search("//tr").each do |row|
        if row.search("td[@class='n']") && 
           row.search("td[@class='n']").inner_html =~ /^namesterritory$/ && 
           row.search("td[@class='g']").inner_html =~ /^[A-Z]{2}$/
          code   = row.search("td[@class='g']").inner_text.to_s
          next if ignore_list.include?(code)
          name   = row.search("td[@class='v']").inner_text.to_s
          countries[code] = name
          puts "#{code}: #{name}"
        end
      end


      # ----- Prepare the output format     ------------------------------------------
      output_hash = { locale => { 'countries' => countries } }

      # ----- Write the parsed values into file      ---------------------------------
      puts "\n... writing the output"
      filename = "countries.#{locale}.yml"
      File.open(filename, "w+") do |file|
        file.write output_hash.ya2yaml[5..-1]
      end
      
      puts "\n---\nWritten values for the '#{locale}' into file: #{filename}\n"
      # ------------------------------------------------------------------------------
    end
  end

end
