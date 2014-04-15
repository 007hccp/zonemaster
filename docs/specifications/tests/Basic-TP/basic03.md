## BASIC03: The _Broken but functional_ test

### Test case identifier
**BASIC03** The _Broken but functional_ test

### Objective

The case where a domain is too broken to be fully tested but functional
enough for simple web browsing should be detected. This test should only
be performed if the BASIC02 test has failed.

### Inputs

1. A list of name server names taken from the parent domain
2. and the IP addresses corresponding to those names.

The addresses should come from glue address records for in-bailiwick
name server names, and from separate recursive queries for out-of-bailiwick
name server names.

### Ordered description of steps to be taken to execute the test case

1. An A query for the child domain name with the label 'www' prepended is
   sent to each address from the input parameters, and the responses
   recorded.
2. If no answer from the above queries contain any A record, this test
   fails.

### Outcome(s)

If at least one recorded response contains at least one A record for the
requested name, this test succeeds.

### Special procedural requirements
This test should only be performed if the BASIC02 test has failed.

### Intercase dependencies

Only perform this test if BASIC02 fails.
