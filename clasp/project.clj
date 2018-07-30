(defproject home "0.1.0-SNAPSHOT"
  :description "Parsec Production Environment Administration Tool!"
  :url "https://github.com/vxe/home"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}

  
  :min-lein-version "2.7.1"

  :dependencies [[org.clojure/clojure "1.9.0"]
                 ;; [com.apple.parsec.kafka/kafkaClient "1.1"]
                 ;; [com.apple.jett/rws "0.0.1"]
                 [metosin/compojure-api "1.1.11"]
                 [org.clojure/tools.logging "0.2.4"]
                 [org.slf4j/slf4j-log4j12 "1.7.1"]
                 [log4j/log4j "1.2.17" :exclusions [javax.mail/mail
                                                    javax.jms/jms
                                                    com.sun.jmdk/jmxtools
                                                    com.sun.jmx/jmxri]]

                 [com.rpl/specter "1.1.0"]
                 [clj-http "3.8.0"]
                 [com.spotify/docker-client "8.11.7"]
                 [com.cerner/clara-rules "0.17.0"]
                 [org.clojure/clojurescript "1.9.946"]
                 [org.clojure/core.async  "0.4.474"]
                 [reagent "0.7.0"]
                 [cheshire "5.8.0"]
                 [overtone/at-at "1.2.0"]
                 [luhhujbb/webhdfs-clj "0.1.6"]
                 [me.raynes/fs "1.4.6"]
                 [uio "1.1"]
                 [ymilky/franzy "0.0.2-SNAPSHOT"]
                 [ymilky/franzy-admin "0.0.1"]
                 [clj-ssh "0.5.14"]
                 [overtone/at-at "1.2.0"]
                 [while-let "0.2.0"]
                 [clj-time "0.14.2"]    ; remove
                 [clj-ssh "0.5.14"]
                 [clojure.java-time "0.3.1"]
                 [compojure "1.6.0"]
                 [ring/ring-core "1.6.3"]
                 [ring/ring-jetty-adapter "1.6.3"]
                 [ring/ring-devel "1.6.3"]
                 [ring/ring-json "0.4.0"]
                 [ring-middleware "0.1.0-SNAPSHOT"]
                 [ring "1.6.3"]
                 [garden "1.3.5"]
                 [re-com "2.1.0"]
                 [alandipert/storage-atom "2.0.1"]
                 [cljs-ajax "0.7.3"]
                 [cljs-http "0.1.45"]
                 [ring-cors "0.1.11"]
                 [jumblerg/ring.middleware.cors "1.0.1"]
                 [ring/ring-defaults "0.3.1"]
                 [fuck-cors "0.1.7"]
                 [http-kit "2.2.0"]
                 [incanter "1.9.2"]
                 [huri "0.10.0-SNAPSHOT"]
                 [semantic-csv "0.2.0"]
                 [clj-dns "0.0.3"]
                 [duratom "0.3.9"]
                 [com.cemerick/url "0.1.1"]
                 [lacij "0.10.0"]
                 [aysylu/loom "1.0.1"]
                 [ubergraph "0.5.0"]
                 [datascript "0.16.6"]
                 [gardendb "0.2.0"]
                 [rojure "0.2.1"]
                 [clucie "0.4.0"]
                 [clojure-opennlp "0.4.0"]
                 [clj-jgit "0.8.10"]
                 [liberator "0.15.1"]
                 ;; [org.clojure/tools.nrepl "0.2.13"]
                 ;; [cider/cider-nrepl "0.17.0"]
                 
                 ;; 
                 [metosin/vega-tools "0.2.0"]
                 [garden "1.3.5"]
                 [io.forward/yaml "1.0.8"]
                 [org.clojure/data.xml "0.0.8"]
                 [me.flowthing/sigel "0.2.0"]]
  

  :plugins [[lein-garden "0.3.0"]
            [lein-ring "0.12.0"]
            [lein-figwheel "0.5.16"]
            [lein-cljsbuild "1.1.7" :exclusions [[org.clojure/clojure]]]]
  
  :main home.handler
  :aot :all
  :uberjar-name "server.jar"
  :repl-options {:init-ns home.core}
  :source-paths ["src/clj"]
  :java-source-paths ["src/main"]

  :ring {:handler home.handler/app
         :nrepl {:start? true
                 :port 9003
                 }
         }
  
  :cljsbuild {:builds
              [{:id "dev"
                :source-paths ["src"]

                ;; The presence of a :figwheel configuration here
                ;; will cause figwheel to inject the figwheel client
                ;; into your build
                :figwheel {:on-jsload "auto-sre.web-ui/on-js-reload"
                           ;; :open-urls will pop open your application
                           ;; in the default browser once Figwheel has
                           ;; started and compiled your application.
                           ;; Comment this out once it no longer serves you.
                           :open-urls ["http://localhost:3449/index.html"]}

                :compiler {:main auto-sre.core
                           :asset-path "js/compiled/out"
                           :output-to "resources/public/js/compiled/auto_sre.js"
                           :output-dir "resources/public/js/compiled/out"
                           :source-map-timestamp true
                           ;; To console.log CLJS data-structures make sure you enable devtools in Chrome
                           ;; https://github.com/binaryage/cljs-devtools
                           :preloads [devtools.preload]}}
               ;; This next build is a compressed minified build for
               ;; production. You can build this with:
               ;; lein cljsbuild once min
               {:id "min"
                :source-paths ["src"]
                :compiler {:output-to "resources/public/js/compiled/auto_sre.js"
                           :main auto-sre.core
                           :optimizations :advanced
                           :pretty-print false}}]}



  
  ;; :garden {:builds [{:source-paths ["src"]
  ;;                    :stylesheet figwheel-garden.styles/style
  ;;                    :compiler {:output-to "resources/public/css/main.css"}}]}
  
  :figwheel { ;; :http-server-root "public" ;; default and assumes "resources"
             ;; :server-port 3449 ;; default
             ;; :server-ip "127.0.0.1"

             :css-dirs ["resources/public/css"] ;; watch and update CSS

             ;; Start an nREPL server into the running figwheel process
             ;; :nrepl-port 7888

             ;; Server Ring Handler (optional)
             ;; if you want to embed a ring handler into the figwheel http-kit
             ;; server, this is for simple ring servers, if this

             ;; doesn't work for you just run your own server :) (see lein-ring)

             ;; :ring-handler hello_world.server/handler


             ;; To be able to open files in your editor from the heads up display
             ;; you will need to put a script on your path.
             ;; that script will have to take a file path and a line number
             ;; ie. in  ~/bin/myfile-opener
             ;; #! /bin/sh
             ;; emacsclient -n +$2 $1
             ;;
             ;; :open-file-command "myfile-opener"

             ;; if you are using emacsclient you can just use
             ;; :open-file-command "emacsclient"

             ;; if you want to disable the REPL
             ;; :repl false

             ;; to configure a different figwheel logfile path
             ;; :server-logfile "tmp/logs/figwheel-logfile.log"

             ;; to pipe all the output to the repl
             ;; :server-logfile false
             }


  ;; Setting up nREPL for Figwheel and ClojureScript dev
  ;; Please see:
  ;; https://github.com/bhauman/lein-figwheel/wiki/Using-the-Figwheel-REPL-within-NRepl
  :profiles {:dev {:dependencies [[javax.servlet/javax.servlet-api "3.1.0"]
                                  [binaryage/devtools "0.9.9"]
                                  [figwheel-sidecar "0.5.16"]
                                  [cider/piggieback "0.3.1"]]
                   ;; need to add dev source path here to get user.clj loaded
                   :plugins [[lein-ring "0.12.0"]]
                   :source-paths ["src" "dev"]
                   ;; for CIDER
                   ;; :plugins [[cider/cider-nrepl "0.12.0"]]
                   :repl-options {:nrepl-middleware [cider.piggieback/wrap-cljs-repl]}
                   ;; need to add the compliled assets to the :clean-targets
                   :clean-targets ^{:protect false} ["resources/public/js/compiled"
                                                     :target-path]}})


(require 'cemerick.pomegranate.aether)
(cemerick.pomegranate.aether/register-wagon-factory!
 "http" #(org.apache.maven.wagon.providers.http.HttpWagon.))
