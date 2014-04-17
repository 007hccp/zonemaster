## ADDRESS03: Reverse DNS entry matches name server name

### Test case identifier
**ADDRESS03** Reverse DNS entry matches name server name

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or blacklisted, DNS 
administrators should publish PTR records associated to name servers'
addresses.

### Inputs

a. The domain name to be tested.

b. The list of domain names retrieved upon reverse DNS queries 
   regarding the domain name servers'addresses (see paragraph 
   "Outcomes" of test case [ADDR02](addr02.md)

c. the list of the domain name servers and their corresponding 
   addresses as retrieved by the method described in paragraph
   "Get the IP address records from the child zone" in 
   [Master Test Plan](../Master Test Plan.md)

### Ordered description of steps to be taken to execute the test case

1. Parse the list of domain name server's addresses and their 
   corresponding PTR records (list b of the inputs).

2. If an IP address has no matching PTR record, the whole test 
   case fails.

3. If an IP address has one or more PTR records, then parse this 
   list of domain names.

3a. If a domain name matches one of the domain name servers (list
    c of the inputs) and the IP address parsed at step 1 matches
	one of the addresses associated to the domain name in list c, 
	then this IP address is considered good, continue and go to
	step 2. Otherwise, continue parsing PTR records attached to 
	the same IP address and go to step 3. If no more PTR records
	are left, the whole test case fails.

   

### Outcome(s)

Multiple addresses and multiple PTR records are allowed. The test 
succeeds if every name server address has a corresponding PTR 
record and this record matches the server name.
If one address doesn't match, the whole test case fails.


### Special procedural requirements

Even though it is recommended to publish reverse DNS entries for name servers
IP addresses, this test should not be blocking for the rest of the test cases
and should only issue a warning rather than an error.

### Intercase dependencies

The input of this test comes from the outcomes of test case ADDR02.
