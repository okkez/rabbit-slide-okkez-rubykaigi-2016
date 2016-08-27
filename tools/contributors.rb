require "octokit"
require "open-uri"
require "fileutils"

Octokit.auto_paginate = true

def fetch_avatars(owner, repo)
  FileUtils.mkdir_p("images/contributors-#{repo}")
  contributors = Octokit.contributors("#{owner}/#{repo}", false)
  contributors.each.with_index do |contributor, index|
    rank = "%03d" % [index]
    login = contributor[:login]
    avatar_url = contributor[:avatar_url]
    open(avatar_url) do |io|
      ext = io.content_type.split("/").last
      File.write("images/contributors-#{repo}/#{rank}_#{login}.#{ext}", io.read,  mode: "wb")
    end
  end
end

fetch_avatars("rurema", "doctree")
fetch_avatars("rurema", "bitclust")

