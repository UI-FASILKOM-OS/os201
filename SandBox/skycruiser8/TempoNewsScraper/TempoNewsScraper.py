#!/usr/bin/env python3
"""
TempoNewsScanner.py
==============================================================================
Author: Rafi Muhammad Daffa (skycruiser8)

INFO:
Scrapes news content from Tempo news agency (Indonesia) by utilizing
HTML5 semantic-oriented tags (especially <article>) to find the relevant
content. Currently oriented for majalah.tempo.co site's structure only.

VERSION:
v0 (2020-04-06 07:36 UTC+7) - Initial Commit

This is free software :)
"""
import re
import urllib.request

"""
Gets the entire response body from a URL
"""
def get_raw_data(url):
    return urllib.request.urlopen(url).read().decode("utf-8")

"""
Replaces old paragraph tags (only <P>) to a standard one (<p> and </p)
"""
def normalize_paragraph(data):
    data = data.replace("<P>","<p>")
    data = data.replace("\n","</p>")
    return data

"""
Cleans all HTML tags and symbols from a data string
"""
def clean_html_data(data):
    regex = re.compile("<.*?>|&.*?;")
    return re.sub(regex,"",data)

"""
Gets content enclosed by a certain HTML tag from a data.
Returns a 2-tuple (data, last index)
"""
def get_data_by_html_tag(data, tag):
    # Checks paragraph for <P> tags (old)
    if data.find("<P>") != -1 and tag == "p":
        data = normalize_paragraph(data)
    start_tag = f"<{tag}>"
    end_tag = f"</{tag}>"
    start = data.find(start_tag)
    end = data.find(end_tag,start)
    return (clean_html_data(data[start+len(start_tag):end]).strip(),end)

"""
Gets title, introduction, author, and content data and merges them as multiple lines.
"""
def get_contents(url):
    data = get_raw_data(url)
    data = data[data.find("<article"):data.find('<div id="dablewidget_"')]
    title = get_data_by_html_tag(data,"h1")
    intro = get_data_by_html_tag(data[title[1]:], "h4")
    author = get_data_by_html_tag(data[intro[1]:],"h2")
    content = get_data_by_html_tag(data[author[1]:],"p")
    return "\n".join([title[0],intro[0],author[0],content[0]])

def main():
    with open("ListLink.txt", "r") as fo:
        links = fo.read().split("\n")
        for url in links:
            print("="*79)
            print(get_contents(url))

if __name__ == "__main__":
    main()