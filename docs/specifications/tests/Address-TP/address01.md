## ADDRESS01: Name server address must be globally routable

### Test case identifier
**ADDRESS01** A name server address must be in the globally routable public
 address space.

### Objective

In order for the domain and its resources to be accessible, authoritative 
name servers must have addrresses in the routable public addressing space.

[RFC 1918](https://tools.ietf.org/rfc/rfc1918.txt) defines the private IPv4
address space and [RFC 6598](https://tools.ietf.org/rfc/rfc6598.txt) the IPv4
shared address space. 

[RFC 3330](https://tools.ietf.org/rfc/rfc3330.txt) and [RFC 5735]
(https://tools.ietf.org/rfc/rfc5735.txt) specify reserved and multicast blocks
that should not appear on the public Internet.

Finally, [RFC 5156](https://tools.ietf.org/rfc/rfc5156.txt) gives a compilation
of reserved and special use of IPv6 blocks that are invalid routing prefixes.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the IP addresses of each name server of the domain checked using
   [Method5](../Methods.md)

2. Each IP address has to be checked against the blocks listed in the table below.
 
3. If any IP address matches one of the block, the test case fails.


|Address Block                        | Description               | Reference |
|:------------------------------------|:--------------------------|:----------|
| 10/8, 172.16/12, 192.168/16         | Private IPv4 addresses    | RFC 1918  |                 
| 100.64.0.0/10                       | Shared IPv4 addresses     | RFC 6598  |
| 192.0.0.0/24			      | Reserved                  | RFC 5735  |
| 223.255.255.0/24		      | Reserved                  | RFC 3330  |
| 224.0.0.0/4		              | Multicast                 | RFC 3330  |
| 240.0.0.0/4		              | Reserved                  | RFC 3330  |
| ::1/128, ::/128, <br> ::ffff:0:0/96, <br> fe80::/10,<br> fc00::/7, 2001:db8::/32,<br> 5f00::/8, 3ffe::/16,<br>  2001:10::/28,<br> ::/0,<br> ff00::/8 | Special use IPv6 addresses| RFC 5156  |
| 192.88.99.0/24		      | 6to4 anycast              | RFC 5735  |
| 2002::/16                           | 6to4                      | RFC 5156  |
| 2001::/32                           | Teredo                    | RFC 5156  |
| ::<ipv4-address>/96                 | Deprecated                | RFC 5156  |

Table: Forbidden address blocks

### Outcome(s)

If one name server has one of its addresses matches a forbidden address block , the test fails.
If all the name server addresses are outside these forbidden blocks, the test case succeeds. 

### Special procedural requirements

None.

### Intercase dependencies

None.














