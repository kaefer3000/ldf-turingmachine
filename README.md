# An implementation of a Turing Machine using Linked Data-Fu and a Linked Data Platform Container

## tl; dr

In [sample.out](sample.out) you find the output of the Turing Machine implementation programmed to check 6 for divisibility by 3. In the last iteration, the accepting state has been reached.

## Steps to try it yourself:
* Obtain requirements
  * Get a LDPC. Tested with my [LDBBC 0.0.5](https://github.com/kaefer3000/ldbbc/releases/tag/0.0.5)
  * Get Linked Data-Fu. Tested with [Linked Data-Fu 0.9.11](http://linked-data-fu.github.io/releases/0.9.11/)
* Prepare
  * Run the LDPC, eg. by deploying LDBBC on a [Jetty](http://eclipse.org/jetty/)
  * Unzip Linked Data-Fu
* Run the Turing Machine examples
  * Pattern:
    * `$ <runnerScript.sh>  <path-to-ldfu.sh> <URI-of-root-ldpc-resource>`
  * Zeroing the tape leftwards starting somewhere in the middle, eg.:
    * `$ ./runZeroToOne.sh ~/ldf/bin/ldfu.sh http://localhost:8080/ldbbc/`
  * Check 4 for divisibility by 3, eg.:
    * `$ runDiv-By-3_4.sh ~/ldf/bin/ldfu.sh http://localhost:8080/ldbbc/`
  * Check 6 for divisibility by 3, eg.:
    * `$ runDiv-By-3_6.sh ~/ldf/bin/ldfu.sh http://localhost:8080/ldbbc/`
