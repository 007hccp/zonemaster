## CONNECTIVITY03: IPv6 address not part of bogon prefix

### Test case identifier

**CONNECTIVITY03:** IPv6 address not part of bogon prefix

### Objective

A bogon prefix is a route that should never appear in the Internet routing
table. A packet routed over the public Internet (not including over VPNs or
other tunnels) should never have a source address in a bogon range.

Bogons are reserved address defined in [RFC
1918](http://tools.ietf.org/html/rfc1918), [RFC
5735](http://tools.ietf.org/html/rfc5735) and [RFC
6598](http://tools.ietf.org/html/rfc6598) and are netblocks that have not
yet been allocated to a RIR by IANA.

The objective of this test case is to verify that the IPv6 addresses to
which the child domain resolves is not that is defined as 'bogon prefix'.

### Inputs

1. The domain to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
   [Method3](../Methods.md)
2. Obtains the IPv6 addresss of the name servers from [Method4]
   (../Methods.md) and [Method5](../Methods.md)
3. If any of the addresses obtained from the name servers is part of a bogon
   [where to get a list]?

### Outcome(s)

If there is no match in the IPv6 bogon prefix blacklist for all the listed
name servers then the test case passes.

### Special procedural requirements

None

### Intercase dependencies

None
