#!/bin/bash

# Author: Tobias Käfer

echo
echo ======================================================================================================
echo === TURING MACHINE THAT STARTS SOMEWHERE ON THE TAPE AND TURNS ZEROES TO ONES GOING ONLY LEFTWARDS ===
echo ======================================================================================================

[[ $# -ne 2 ]] && { echo ; echo "Usage: <path-to-ldfu.sh> <uri-of-ldp-container>" ; exit 1 ; }

LDF=$1
LDPC=$2

[[ ! "$LDPC" == */ ]] && { echo ; echo "The LDPC URI should end in a slash" ; exit 1 ; }

if [ ! -f $LDF ]; then
  echo
  echo Linked Data-Fu executable not found
  exit 1
fi

# Cleanup
curl --fail -X DELETE $LDPC || { echo an error occurred related to the ldp container maintaining tape, state, and program ; exit 1 ; }

echo
echo "=== OVERWRITING data-retrieval.n3 FOR YOUR LDPC IMPLEMENTATION ==="

# Creating data-retrieval.n3
echo "@prefix http: <http://www.w3.org/2011/http#>." > data-retrieval.n3
echo "@prefix http_m: <http://www.w3.org/2011/http-methods#>." >> data-retrieval.n3
echo "@prefix ldp: <http://www.w3.org/ns/ldp#> ." >> data-retrieval.n3
echo "{ _:h http:mthd http_m:GET ; http:requestURI <$LDPC> . }" >> data-retrieval.n3
echo "{ <$LDPC> ldp:contains ?y . } => { [] http:mthd http_m:GET; http:requestURI ?y . } ." >> data-retrieval.n3

echo
echo === INITIALISING TAPE ===

set -x
# Tape initialisation
curl -X PUT "$LDPC"p00 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p01> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p01 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p02> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p02 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p03> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p03 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p04> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p04 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p05> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p05 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p06> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p06 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p07> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p07 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p08> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p08 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p09> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p09 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p10> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p10 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p11> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p11 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p12> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p12 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p13> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p13 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "0" ; rdf:rest <p14> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p14 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p15> . ' -Hcontent-type:text/turtle
curl -X PUT "$LDPC"p15 --data-binary ' @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . <> rdf:first "X" ; rdf:rest <p16> . ' -Hcontent-type:text/turtle

{ set +x; } 2>/dev/null

echo
echo === INITIALISING TURING MACHINE STATE ===

set -x
# State initialisieren
curl -X PUT "$LDPC"tm1 --data-binary ' @prefix tm: <http://www.example.org/turing-machine#> . <> tm:hasInitialPosition <p09> ; tm:hasCurrentPosition <p09> ; tm:hasCurrentState <A> .' -Hcontent-type:text/turtle
{ set +x; } 2>/dev/null

echo
echo === INITIALISING TURING MACHINE TRANSITION FUNCTION ===

set -x
# Transition function initialisieren
curl -X PUT "$LDPC"tr1 --data-binary @zero-to-one.ttl -Hcontent-type:text/turtle
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

