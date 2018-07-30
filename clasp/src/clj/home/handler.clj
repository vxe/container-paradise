(ns home.handler
  (:require [compojure.api.sweet :refer :all]
            [ring.util.http-response :refer :all]
            [clojure.tools.logging :as log]
            [home.core :refer :all]
            [home.lib :refer :all]
            [home.spotify.core :refer :all]
            [ring.adapter.jetty]
            [clojure.tools.nrepl.server :as nrepl-server])
  (:gen-class))

  (def emacs-routes
       (context "/emacs" []
            :tags ["emacs"]

            (GET "/all-clojars" []
                 :return String
                 ;; :query-params [x :- Long, y :- Long]
                 :summary "Get all jars on Clojars"
                 (ok {:result (:cli @atm--clojars)}))

            #_      (POST "/echo" []
                          :return Pizza
                          :body [pizza Pizza]
                          :summary "echoes a Pizza"
                          (ok pizza)))
    )

  (def spotify-routes
    (context "/spotify" []
             :tags ["music"]

             (GET "/search" []
                  :return String
                  ;; :query-params [x :- Long, y :- Long]
                  :summary "Get all jars on Clojars"
                  (ok {:result (:cli @atm--clojars)}))
             (GET "/login" [code & other-junk]
                  :return String
                  ;; :query-params [refresh_token :- String]
                  :summary "catch spotify login token "
                  (ok (io-mem--set-authorization-code code)))

             #_      (POST "/echo" []
                           :return Pizza
                           :body [pizza Pizza]
                           :summary "echoes a Pizza"
                           (ok pizza))))


  (def bounce-favicon
    (context "/" []
             :tags ["util"]

             (GET "/favicon.ico" []
                  :return String
                  ;; :query-params [x :- Long, y :- Long]
                  :summary "Get all jars on Clojars"
                  (ok {:result "insert favicon here"}))))
  
(def app
  (api
   {:swagger
    {:ui "/"
     :spec "/swagger.json"
     :data {:info {:title "My-clojure!"
                   :description "all my clojure"}
            :tags [{:name "api", :description "some apis"}]}}}
   bounce-favicon
   emacs-routes
   spotify-routes))



;; (defn nrepl-handler []
;;   (require 'cider.nrepl)
;;   (ns-resolve 'cider.nrepl 'cider-nrepl-handler))





