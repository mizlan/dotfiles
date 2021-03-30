#!/usr/bin/env bb

(defn extract-content-line
  [lines]
  (filter #(str/includes? %1 "data-content") lines))

(defn html-decode
  "custom decoder for the escaped output"
  [s]
  (-> s
      (str/replace "&amp;" "&")
      (str/replace "&quot;" "\"")))

;; For search queries
(defn uri-encode
  [s]
  (str/replace s #"\W" #(str "%" (format "%x" (-> % first int)))))

(defn extract-info
  "Extracts the relevant fields from results"
  [results]
  (map #(select-keys % [:votes :rating :tab_url]) results))

(defn sort-score
  [{:keys [votes rating]}]
  (* rating (Math/sqrt votes)))

(defn round-score
  [score]
  (/ (Math/round (* 100 score)) 100.0))

(defn get-results
  [link]
  (-> link
      slurp
      str/split-lines
      extract-content-line
      first
      (str/replace #".+?(\{.+\}).*" "$1")
      html-decode
      (json/parse-string keyword)
      :store
      :page
      :data
      :results))

(defn format-entry
  "Format a search result entry"
  [[item-idx {:keys [votes rating song_name]}]]
  (format "(%3d) [%-30s] %-4.2f★ %6d✓" (inc item-idx) song_name (float rating) votes))

(defn display-entries
  [entries]
  (println "Search results:")
  (->> entries
       (map vector (range))
       (map format-entry)
       (run! println)))

(defn str->int
  [s]
  (try
    (Integer/parseInt s)
    (catch Exception e nil)))

(defn valid-choice?
  "Given user input choice and options seq, determine if choice was valid"
  [choice options]
  (if-let [i (str->int choice)]
    (if (<= 1 i (count options)) i false)
    false))

(defn prompt
  [options]
  (println "Hit ENTER for choice 1, otherwise type a number and then hit ENTER")
  (let [choice (read-line)]
    (if (empty? (str/trim choice))
      1
      (if-let [c (valid-choice? choice options)]
        c
        (recur options)))))

(comment
  (def data (get-results "https://www.ultimate-guitar.com/search.php?search_type=title&value=bruno%20mars%20when%20i%20was%20your%20man"))
  (def processed (->> data
                      ; extract-info
                      (filter :votes)
                      (filter :rating)
                      (filter :tab_url)
                      (sort-by sort-score)
                      reverse))
  (display-entries processed))

(def search-query-link
 "https://www.ultimate-guitar.com/search.php?search_type=title&value=%s")

(defn run-pipeline
  []
  (println "Query:")
  (let [processed-data (->> (read-line)
                            uri-encode
                            (format search-query-link)
                            get-results
                            (filter :votes)
                            (filter :rating)
                            (filter :tab_url)
                            (sort-by sort-score)
                            reverse
                            (take 10))]
    (display-entries processed-data)
    (let [user-choice (prompt processed-data)]
      (->> user-choice
           dec
           (nth processed-data)
           :tab_url
           clojure.java.browse/browse-url))))

(run-pipeline)
