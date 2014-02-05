## CONNECTIVITY01: The child domain must accessible over UDP on port 53

### Test case identifier
**CONNECTIVITY01:**  The child domain must accessible over UDP on port 53

### Objective
The child domain must answer DNS queries on UDP

### Inputs
1. The FQDN of the child domain's authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. A SOA query is sent over UDP to all authoritative name servers of the child domain
2. If the FQDN has a single address, then the test fails if a query destined to that addresses does not provide an answer within a particular time period (the threshhold time should be decided)
3. If the FQDN has multiple addresses, then the test  fails if none of those addresses provide an answer within the specified threshhold time


### Outcome(s)
If there is a response from all the listed name servers within the threshhold period, then the test succeeds
### Special procedural requirements

### Intercase dependencies
None
