NAME
====

T - An easy way of writing test assertions which output good test descriptions and error messages

DESCRIPTION
===========

T is a [Raku](https://www.raku-lang.ir/en/) module for writing test
assertions which output good test descriptions and error messages.

It provides the `t` keyword for writing test assertions which takes an expression of form `<got> <infix> <expected>`.

Goals of the module:
- Write less but more readable test code
- Get a useful test description and failure message

SYNOPSIS
========

```raku
use T:auth<zef:CIAash>;

t 4 == 4;
=output ok 1 - 4 == 4

t $my_great_module.return('something') eq 'something';
=output ok 2 - $my_great_module.return('something') eq 'something'

t $my_great_module.return('something else') eq 'something';
=output not ok 3 - $my_great_module.return('something else') eq 'something'
# Failed test '$my_great_module.return('something else') eq 'something''
# at ... line ...
# expected: "something"
#  matcher: 'infix:<eq>'
#      got: "something else"
```

INSTALLATION
============

You need to have [Raku](https://www.raku-lang.ir/en) and [zef](https://github.com/ugexe/zef), then run:

```console
zef install --/test "T:auth<zef:CIAvash>"
```

or if you have cloned the repo:

```console
zef install .
```

TESTING
=======
```console
prove6 -I. -v
```
or:
```console
prove -ve 'raku -I.' --ext rakutest
```

REPOSITORY
==========

[https://github.com/CIAvash/T/](https://github.com/CIAvash/T/)

BUG
===

[https://github.com/CIAvash/T/issues](https://github.com/CIAvash/T/issues)

AUTHOR
======

Siavash Askari Nasr - [https://www.ciavash.name](https://www.ciavash.name)

COPYRIGHT
=========

Copyright © 2022 Siavash Askari Nasr

LICENSE
=======

This file is part of T.

T is free software: you can redistribute it and/or modify it under the
terms of the GNU Lesser General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at
yoption) any later version.

T is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public
License along with T. If not, see <http://www.gnu.org/licenses/>.
