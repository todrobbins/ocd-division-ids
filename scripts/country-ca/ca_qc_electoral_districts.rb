#!/usr/bin/env ruby
# coding: utf-8

require File.expand_path(File.join("..", "utils.rb"), __FILE__)

# Scrapes Quebec electoral district codes and names from electionsquebec.qc.ca

class QC < Runner
  def names
    puts CSV.generate_line(%w(id name))
    # No official government source has a full list of identifiers and names
    # with the correct dashes.
    CSV.parse(open("http://www.electionsquebec.qc.ca/documents/donnees-ouvertes/Liste_circonscriptions.txt").read.force_encoding("windows-1252").encode("utf-8"), :headers => true, :col_sep => ";").each do |row|
      output("province:qc/ed:", row["BSQ"], row["CIRCONSCRIPTION"])
    end
  end
end

QC.new("province-qc-electoral_districts.csv").run(ARGV)
