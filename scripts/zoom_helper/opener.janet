(import sh)

(defn first-last [l]
  [(first l) (last l)])

(defn init [l]
  (slice l 0 -2))

(def config
  (->>
    "/Users/michaellan/scripts/zoom_helper/zoom_links"
    (slurp)
    (init)
    (string/split "\n")
    (map string/trim)
    (filter |(and (> (length $0) 0) (not (string/has-prefix? "#" $0))))
    (map |(string/split " " $0))
    (map first-last)
    (flatten)
    (apply table)))

(def choice (sh/$< choose -f "Roboto Mono" -b "abc8d6" -c "0f4661"
                   < ,(-> config keys (string/join "\n"))))

(defn needs-delay [choice]
  (= (last choice) 42)) # asterisk

(if (needs-delay choice)
  (do
    (print "needs delay")
    (sh/$ open -a zoom.us)
    (os/sleep 3)))

(sh/$ open -a zoom.us ,(config choice))
