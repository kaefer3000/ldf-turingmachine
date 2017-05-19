#!/bin/bash

LDF=~/workspace/linked-data-fu/bin/ldfu.sh

if [ ! -f $LDF ]; then
  echo Linked Data-Fu executable not found
  exit 1
fi

echo
echo ======================================================================================================
echo === TURING MACHINE THAT STARTS SOMEWHERE ON THE TAPE AND TURNS ZEROES TO ONES GOING ONLY LEFTWARDS ===
echo ======================================================================================================

# Cleanup
curl --fail -X DELETE http://localhost:8080/rwldresources/ || { echo an error occurred related to the web resources maintaining tape, state, and program ; exit 1 ; }

echo
echo === INITIALISING TAPE ===

set -x
# Tape initialisation
curl -X PUT http://localhost:8080/rwldresources/p00 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p01> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p01 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p02> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p02 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p03> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p03 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p04> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p04 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p05> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p05 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p06> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p06 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p07> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p07 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p08> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p08 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p09> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p09 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p10> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p10 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p11> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p11 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p12> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p12 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p13> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p13 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p14> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p14 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p15> . ' -Hcontent-type:text/turtle
curl -X PUT http://localhost:8080/rwldresources/p15 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p16> . ' -Hcontent-type:text/turtle

{ set +x; } 2>/dev/null

echo
echo === INITIALISING TURING MACHINE STATE ===

set -x
# State initialisieren
curl -X PUT http://localhost:8080/rwldresources/tm1 --data-binary ' @prefix tm: <http://www.example.org/turing-machine#> . <> tm:hasInitialPosition <p09> ; tm:hasCurrentPosition <p09> ; tm:hasCurrentState <A> .' -Hcontent-type:text/turtle
{ set +x; } 2>/dev/null

echo
echo === INITIALISING TURING MACHINE TRANSITION FUNCTION ===

set -x
# Transition function initialisieren
curl -X PUT http://localhost:8080/rwldresources/tr1 --data-binary @zero-to-one.ttl -Hcontent-type:text/turtle
{ set +x; } 2>/dev/null

echo
echo ========================================================================
echo === INITIALISATION DONE. PERFORMING THE STEPS FOR THE TURING MACHINE ===
echo ========================================================================

# Loop the Turing machine's stepwise execution
while true
do

echo
echo === PERFORMING STEP ===
# Performing the actual step
$LDF -p data-retrieval.n3 -p tmrules.n3

echo
echo === CURRENT TURING MACHINE STATE ===
# Outputting the current machine state
$LDF -p data-retrieval.n3 -q tmquery.rq - 2>/dev/null

echo
echo === CURRENT TURING MACHINE TAPE STATE ===
# Outputting the current tape state
$LDF -p data-retrieval.n3 -q tapequery.rq - 2>/dev/null | (read -r; printf "%s\n" "$REPLY"; sort -u)

echo

read -n1 -rsp $'Press any key to continue with the next step or Ctrl+C to exit...\n'

done

