#!/bin/dash

# 647CFB82-C327-493D-A90E-EC3774CA33FE is Dell
# 37D8832A-2D66-02CA-B9F7-8F30A301B230 is MacBook

yabai -m query --displays | jq -r '
  .[] | 
  (
    if .uuid == "647CFB82-C327-493D-A90E-EC3774CA33FE" then
      .spaces[] | "\(. ) top_padding 10"
    elif .uuid == "37D8832A-2D66-02CA-B9F7-8F30A301B230" then
      .spaces[] | "\(. ) top_padding 10"
    else
      empty
    end
  )
' | xargs -L 1 yabai -m config --space
