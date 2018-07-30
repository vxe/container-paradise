
(defn mkdir-p [path]
                  (clojure.java.io/make-parents (expand-home path)))

(defn pwd []
  (System/getProperty "user.dir"))

(defn ls-ltrh
          ([]
           (println (:out (sh "ls" "-ltrh"))))
          ([value]
           (:out (sh "ls" "-ltrh"))))
