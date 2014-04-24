## ADDRESS02: Reverse DNS entry exists for name server IP address

### Test case identifier
**ADDRESS02** Reverse DNS entry should exist for name server IP address

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or blacklisted, DNS 
administrators should publish PTR records associated to name servers'
addresses.

[technical reference to be found]

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the IP addresses of each name server of the domain checked
   using [Method5](../Methods.md)

2. For each IP address, a recursive PTR query must be generated.

3. If any answer of the queries made in step 2 contains an RCODE other than
   NoError or if the answer doesn't include a PTR record, this test case fails.

### Outcome(s)

A list of of address with corresponding PTR records. These are the 
results of the PTR queries generated.

### Special procedural requirements

None.

### Intercase dependencies

The outcomes of this test is used as the input of ADDRESS03 test case.
