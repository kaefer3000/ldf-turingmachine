#!/bin/sh

LDF=~/workspace/linked-data-fu/bin/ldfu.sh

# Cleanup
curl -X DELETE localhost:8080/rwldresources/ || exit 1

# Tape initialisation
curl -X PUT localhost:8080/rwldresources/p01 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p02> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p02 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p03> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p03 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p04> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p04 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p05> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p05 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p06> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p06 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p07> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p07 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p08> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p08 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p09> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p09 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p10> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p10 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p11> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p11 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p12> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p12 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p13> . ' -Hcontent-type:text/turtle
curl -X PUT localhost:8080/rwldresources/p13 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p14> . ' -Hcontent-type:text/turtle

# State initialisieren
curl -X PUT localhost:8080/rwldresources/tm1 --data-binary ' @prefix tm: <http://www.example.org/turing-machine#> . <> tm:hasInitialPosition <p09> ; tm:hasCurrentPosition <p09> ; tm:hasCurrentState <A> .' -Hcontent-type:text/turtle

# Transition function initialisieren

curl -X PUT localhost:8080/rwldresources/tr1 --data-binary @tmtransitions.ttl -Hcontent-type:text/turtle

echo $LDF -p data-retrieval.n3 -p tmrules.n3

