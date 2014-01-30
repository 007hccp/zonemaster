# List of basic DNS tests

This document uses the terminology defined in the [Master Test Plan](../Master%20Test%20Plan.md).

There is [an example implementation of these tests](https://github.com/dotse/new-dnscheck/blob/master/Giraffa/lib/Giraffa/Test/Basic.pm).

## Mapping from Requirements to Test Case

|Req| Description                                                          | Test Case |
|:--|:---------------------------------------------------------------------|:----------|
|R01|UDP connectivity|[CONNECTIVITY01](./connectivity01.md)|
|R02|TCP connectivity|[CONNECTIVITY02](./connectivity02.md)|
|R04|Address should not be part of a bogon prefix|[CONNECTIVITY03](./connectivity03.md)|
|R11|Nameserver addresses on the same subnet|[CONNECTIVITY04](./connectivity04.md)|
|R12|Nameserver addresses are all on the same subnet|[CONNECTIVITY05](./connectivity05.md)|
|R54|Nameservers belong all to the same AS|[CONNECTIVITY06](./connectivity06.md)|
