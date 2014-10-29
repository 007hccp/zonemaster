Engine - Functional Test requirements
======================================

Objective
----------
The purpose of Zonemaster tool is to test the quality of a DNS delegation.
The tool comprises of three different functional blocks: 
   1. Test engine – which comprises of necessary source code to run test
implementations and report results
   2. Web GUI – will enable users to provide input (such as a domain name 
with different options) and call the test engine and read results from a web
browser
   3. CLI – will enable users to provide input (such as a domain name with
different options) and call the test engine and read results from a text
console

The objective of this document is to run functional tests for the two
functional blocks – Test engine and GUI. As of now CLI is not within the
scope of this document.

Scope
------

The test specifciation (which is part of the test engine) implemented has already
gone/going through the process of unit testing. Unit testing is done to
confirm that a unitary code (such as a single test case source code)
component provides the correct output for a given input. 

Functional tests are intended to verify whether the code (written as part of
the test engine) accurately detects the DNS problem's it is meant to detect
with neither false positive nor false negative. As part of writing the
functional tests for the test engine, following steps should be followed:
   * Write the functional test requirements
   * Follow the method (as done for unit tests) to elaborate the test
   requirements
   * Write simple scripts to launch the test or use the CLI.  Compare the 
   results of the test with the results of both Zonecheck and DNScheck


|Req| Test requirement                           |Explanation|Status|
|:--|:-------------------------------------------|-----------|------|
|FR01|A DNS query with a label that exceeds the maximum length - 63 characters|[RESTRICTION01](../specifications/functional-tests/Restriction-TP/restriction01.md)||
|FR02|A FQDN that exceeds the maximum length - 255 octets|[RESTRICTION02](../specifications/functional-tests/Restriction-TP/restriction02.md)||
|FR03|A host name label with other than letters, digits and '-'character|[RESTRICTION03](../specifications/functional-tests/Restriction-TP/restriction03.md)||
|FR04|CNAME RRs collision (If a CNAME RR is present at a node, no other data should be present; (3.6.2) - RFC 1034)|[CONFIGURATION01](../specifications/functional-tests/Configuration-TP/configuration01.md)||
|FR05|Zone cyclic dependency|[CONFIGURATION02](../specifications/functional-tests/Configuration-TP/configuration02.md)||
|FR06|Lame delegation |[CONFIGURATION03](../specifications/functional-tests/Configuration-TP/configuration03.md)||
|FR07|Delegation Inconsistency|[CONFIGURATION04](../specifications/functional-tests/Configuration-TP/configuration04.md)||
|FR08|Test whether the tool correctly treats the name error with "NXDOMAIN" in response|[BEHAVIOR01](../specifications/functional-tests/Behavior-TP/behavior01.md)|OK|
|FR09|Test whether the tool correctly treats when "no such data exist"  with "NODATA" in response|[BEHAVIOR02](../specifications/functional-tests/Behavior-TP/behavior02.md)||
|FR10|Match the results with existing ZC when certain protocols are disabled (e.g.IPv6)|[BEHAVIOR03](../specifications/functional-tests/Behavior-TP/behavior03.md)||
|FR11|Test whether the tool run only appropriate tests when the default test profile is modified|[BEHAVIOR04](../specifications/functional-tests/Behavior-TP/behavior04.md)|KO|
|FR12|Capable of running the test when the delegation parameters are specified|[BEHAVIOR05](../specifications/functional-tests/Behavior-TP/behavior06.md)|OK|
|FR13|Able to test un-delegated domain|[BEHAVIOR06](../specifications/functional-tests/Behavior-TP/behavior06.md)|OK|
|FR14|Check whether timestamps on the test being run are being displayed|[BEHAVIOR07](../specifications/functional-tests/Behavior-TP/behavior07.md)|KO|
|FR15|With the report flag enabled check whether the tool reports tests as they are being run|[BEHAVIOR08](../specifications/functional-tests/Behavior-TP/behavior08.md)|
|FR16|IDN verification |[BEHAVIOR09](../specifications/functional-tests/Behavior-TP/behavior09.md)|OK|
|FR17|Displays verbose information when launched with appropriate flags|[BEHAVIOR10](../specifications/functional-tests/Behavior-TP/behavior10.md)|OK|
|FR18|Test whether the tool triggers appropriate error code when the server is misconfigured|[BEHAVIOR11](../specifications/functional-tests/Behavior-TP/behavior11.md)|
|FR19|Test whether the tool respond with one or more RRs if data does exist for the DNS query in question|[BEHAVIOR12](../specifications/functional-tests/Behavior-TP/behavior12.md)|

