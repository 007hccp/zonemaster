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



|Req| Test requirement                           |Explanation|
|:--|:-------------------------------------------|-----------|
|FR01|A DNS query with a label that exceeds the maximum length - 63 characters|[Test-Case01](../specifications/functional-tests/test-case01.md)|
|FR02|A FQDN that exceeds the maximum length - 255 octets||
|FR03|A host name label with other than letters, digits and '-' character ||
|FR04|CNAME RRs collision (If a CNAME RR is present at a node, no other data should be present; (3.6.2) - RFC 1034) ||
|FR05|Error in the RR format (3.3 - RFC 1035)||
|FR06|Test whether the tool correctly treats the name error with "NXDOMAIN" in response||
|FR07|Test whether the tool correctly treats when "no such data exist"  with "NODATA" in response||
|FR08|Test whether the tool triggers appropriate error when network connectivity is disabled||
|FR09|Test whether the tool triggers appropriate error when network connectivity is enabled||
|FR10|Match the results with existing ZC/DC when certain protocols are disabled (e.g. IPv6||
|FR11|Test whether the tool Run only appropriate tests when the default test profile is modified||
|FR12|Capable of running the test when the delegation parameters are specified||
|FR13|Able to test non delegated domain||
|FR14|Check whether timestamps on the test being run are being displayed||
|FR15|With the report flag enabled check whether the tool reports tests as they are being run||
|FR16|Check whether the tool displays statistics on network performance, RTT: min, max, stddev, avg, per protocol and queries sent per name server||
|FR17|Provides the same results as in ZC/DC when IDNs are used||
|FR18|Test whether the tool displays verbose information when launched with appropriate flags||
|FR19|Test whether the tool triggers appropriate error code when the server is misconfigured||
|FR20|Test whether the tool respond with one or more RRs if data does exist for the DNS query in question||
|FR21|Triggers when NS RRset declared at the parent is not the same as the one declared in the child zone||
|FR22|Triggers when glue A record does not point to the same IP address as the corresponding authoritative A record||
|FR23|Triggers when the TTL values are not consistent for the same RRset in both parent and child zone||
|FR24|When a nameserver that is registered in the DNS system as authoritative for a zone , does not provide authoritative answers for the zone ||
|FR25|A nameserver that is authoritative for a zone does not have authoritative data||
|FR26|Triggers when, in order to resolve a zone 'x', the resolver needs to query 'y', which in order to be resolved requires 'x' to be resolved first - - "Zone cyclic dependency"||

