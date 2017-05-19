#!/bin/sh

LDF=~/workspace/linked-data-fu/linked-data-fu-standalone/target/linked-data-fu-standalone-0.9.11-SNAPSHOT-bin/linked-data-fu-0.9.11-SNAPSHOT/bin/ldfu.sh

if [ ! -f $LDF ]; then
  exit 1
fi

# Cleanup
curl -X DELETE localhost:8080/rwldresources/ || exit 1

# Tape initialisation
curl -X PUT localhost:8080/rwldresources/p1  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p2>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p2  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p3>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p3  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "1" ; rdf:rest <p4>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p4  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p5>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p5  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p6>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p7  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p8>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p8  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p9>  . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p9  --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p10> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p10 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p11> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p11 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p12> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p12 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p13> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p13 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "#" ; rdf:rest <p14> . ' -Hcontent-type:text/turtle

# State initialisieren
curl -X PUT localhost:8080/rwldresources/tm1 --data-binary ' @prefix tm: <http://www.example.org/turing-machine#> . <> tm:hasInitialPosition <p3> ; tm:hasCurrentPosition <p3> ; tm:hasCurrentState <q0> .' -Hcontent-type:text/turtle

# Transition function initialisieren

curl -X PUT localhost:8080/rwldresources/tr1 --data-binary @divisible-by-3.ttl -Hcontent-type:text/turtle

echo $LDF -p data-retrieval.n3 -p tmrules.n3
