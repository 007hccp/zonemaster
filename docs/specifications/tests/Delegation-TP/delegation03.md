## DELEGATION03: No truncation of referrals

### Test case identifier

**DELEGATION03:** No truncation of referrals

### Objective

The Domain Name System defaults to using UDP for queries and answers with a
DNS payload limit of 512 bytes. Larger replies cause an initial truncation
indication leading to a subsequent handling via TCP with substantially
higher overhead. EDNS0 is used to allow for larger UDP responses thus
reducing the need for use of TCP.

But [IANA](https://www.iana.org/help/nameserver-requirements) still
maintains that referrals from the parent zone name servers must fit into
a non-EDNS0 UDP DNS packet.

In this test, the authoritative and additional section of the referral
response from the domain must fit into a 512 byte UDP packet.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. Obtains the IP addresss of the name servers from the parent using
   [Method4](../Methods.md) and the child using [Method5](../Methods.md).
3. An empty DNS answer packet is generated.
4. All the data from step 2 is added to the packet.
5. If the size of the packet is more than 512 bytes, then the test fails.

### Outcome(s)

If the created packet fits into 512 byte UDP packet, then the test succeeds.

### Special procedural requirements

None

### Intercase dependencies

None
