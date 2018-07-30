(ns home.core
  (:require 
   [home.lib :refer :all])
  (:use [clojure.java.shell :only [sh]]))

(defn gen-deployment-yaml
  ([app-name image]
   {:apiVersion "apps/v1"
    :kind "Deployment"
    :metadata {:name (str app-name "-" image "-" (rand-int 10000))
               :labels {:app app-name}}
    :spec {:replicas 1
           :selector {:matchLabels {:app app-name}}
           :template {:metadata {:labels {:app app-name}}
                      :spec {:containers [{:name app-name :image image}]}}}})

  ([app-name image   deployment-name ]
   {:apiVersion "apps/v1"
    :kind "Deployment"
    :metadata {:name (str app-name "-" image "-" (rand-int 10000))
               :labels {:app app-name}}
    :spec {:replicas 1
           :selector {:matchLabels {:app app-name}}
           :template {:metadata {:labels {:app app-name}}
                      :spec {:containers [{:name app-name :image image}]}}}})

  ([app-name image deployment-name replicas]
   {:apiVersion "apps/v1"
    :kind "Deployment"
    :metadata {:name (str app-name "-" image "-" (rand-int 10000))
               :labels {:app app-name}}
    :spec {:replicas replicas
           :selector {:matchLabels {:app app-name}}
           :template {:metadata {:labels {:app app-name}}
                      :spec {:containers [{:name app-name :image image}]}}}}))

(defn gen-pod-yaml [image-spec]
  {:apiVersion "v1"
   :kind "Pod"
   :metadata {:name (str "pod-" (rand-int 10000))}
   :spec image-spec})



;; takes in a vector of (n - 1) maps and a command as the last element, eg for 2 imags 

;; (gen-pod-yaml [{:name "name1"
;;                                  :image "image1"
;;                                  }
;;                                 {:name "name2"
;;                                  :image "image2"
;;                                  }
;;                                 {:command "[\"/bin/sh\", \"-c\", \"while : ;do curl http://localhost:80/; sleep 10; done\"]"}
;;                                 ])

(defn kubectl-create-deployment
  ([app-name image-name deployment-name]
   (let [identifier (rand-int 10000)
         config-file (spit (str app-name "-" image-name "-" identifier ".yaml")
                           (yaml.core/generate-string
                            (gen-deployment-yaml
                             app-name
                             image-name
                             (str deployment-name "-" identifier))
                            :dumper-options {:flow-style :block}))]
     (println (:out (sh "kubectl" "get" "deployment")))
     (println (:out (sh "kubectl" "create" "-f" (str app-name "-" image-name "-" identifier ".yaml"))))))
  ([app-name image-name deployment-name replicas]
   (let [identifier (rand-int 10000)
         config-file (spit (str app-name "-" image-name "-" identifier ".yaml")
                           (yaml.core/generate-string
                            (gen-deployment-yaml
                             app-name
                             image-name
                             (str deployment-name "-" identifier)
                             replicas
                             )
                            :dumper-options {:flow-style :block}))]
     (println (:out (sh "kubectl" "get" "deployment")))
     (println (:out (sh "kubectl" "create" "-f" (str app-name "-" image-name "-" identifier ".yaml")))))))

(defn kubectl-create-pod
  ([container-config pod-name]
   (let [identifier (rand-int 10000)
         config-file (spit (str pod-name "-" identifier ".yaml")
                           (yaml.core/generate-string
                            (gen-pod-yaml
                             container-config)
                            :dumper-options {:flow-style :block}))]
     (println (:out (sh "kubectl" "get" "pods")))
     (println (:out (sh "kubectl" "create" "-f" (str pod-name "-" identifier ".yaml")))))))

(defn kubectl-get-deployments []
  (println (:out (sh "kubectl" "get" "deployment"))))

(defn kubectl-delete-deployment [deployment]
  (println (:out (sh "kubectl" "delete" "deploy" deployment))))

(defn kubectl-get-pods []
  (println (:out (sh "kubectl" "get" "pods"))))

(defn kubectl-delete-pod [pod]
    (println (:out (sh "kubectl" "delete" "pod" pod))))

(defn kubectl-list-pods []
  (map (fn [lines]
         (-> lines
             (clojure.string/split #"\s+")
             first))
       (rest (clojure.string/split-lines (:out (sh "kubectl" "get" "pods"))))))

(defn kubectl-delete-all-pods []
  (for [pod (kubectl-list-pods)]
    (kubectl-delete-pod pod)))

(def xml:core-site
[:configuration
        [:property
         [:name "hadoop.tmp.dir"]
         [:value "/usr/local/Cellar/hadoop/hdfs/tmp"]
         [:description "A base for other temporary directories."]]
        [:property
         [:name "fs.default.name"]
         [:value "hdfs://localhost:8020"]]
        ]
)

(def xml:mapred-site 
  [:configuration
   [:property
    [:name "mapred.job.tracker"]
    [:value "localhost:8021"]]])

(def xml:hdfs-site 
  [:configuration
   [:property
    [:name "dfs.replication"]
    [:value]]])

(defn hadoop:generate-configurations []
  (xml-print-str
   (xml-print-str xml:core-site)
   "/usr/local/Cellar/hadoop/3.0.0/libexec/etc/hadoop/core-site.xml"
   ))

(def atm--clojars (atom {}))

(defn io-web--get-clojars-data
  ([]
   (:body (clj-http.client/get "https://clojars.org/repo/all-jars.clj")))
  ([output]
   (cond (= "cli" output)
         (println    (:body (clj-http.client/get "https://clojars.org/repo/all-jars.clj")))
         (= "json" output)
         (cheshire.core/generate-string (:body (clj-http.client/get "https://clojars.org/repo/all-jars.clj")))))
    ([output value]
     (cond (= "cli" output)
           (swap! atm--clojars assoc :cli
                  (:body (clj-http.client/get "https://clojars.org/repo/all-jars.clj")))
           (= "json" output)
           (swap! atm--clojars assoc :json
                  (cheshire.core/generate-string (:body (clj-http.client/get "https://clojars.org/repo/all-jars.clj")))))))

(def country-codes-data (clojure.data.csv/read-csv (curl "https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv")))

(def country-codes
      (into {} (for* [code country-codes-data]
                     {(keyword
                       (-> code
                           first
                           clojure.string/lower-case
                           (clojure.string/replace #"[\s]" "-" )
                           (clojure.string/replace
                            #"[+()',;]" "")))
                      [(rest code)]})))

(def airport-data (clojure.data.csv/read-csv (curl "https://raw.githubusercontent.com/datasets/airport-codes/master/data/airport-codes.csv")))

(def airport-info
  (into {} (for* [code airport-data]
                 {(keyword (second (reverse code)))
                  [(rest (reverse code))]})))
