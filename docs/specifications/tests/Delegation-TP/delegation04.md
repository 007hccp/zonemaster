## DELEGATION04: Name server is authoritative

### Test case identifier

**DELEGATION04:** Name server is authoritative

### Objective

Subsection 6.1 of [RFC 2181](http://tools.ietf.org/html/rfc2181) specifies
that the nameservers must answer authoritatively for the domain. Answers
to queries to the name servers for the designated zone must have the "AA"
bit set.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. All name servers queried for the SOA record over TCP and UDP on port 53.
3. If any name server fail to give an authoritative answer ("AA-bit" is set
   in the answer), the test fails.

### Outcome(s)

If all the name servers answer with the AA-bit set, then the test succeeds.

### Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
