=NAME T - An easy way of writing test assertions which output good test descriptions and error messages

=begin DESCRIPTION
T is a L<Raku|https://www.raku-lang.ir/en/> module for writing test
assertions which output good test descriptions and error messages.

It provides the C<t> keyword for writing test assertions which takes an expression of form C«<got> <infix> <expected>».

Goals of the module:
=item Write less but more readable test code
=item Get a useful test description and failure message
=end DESCRIPTION

=begin SYNOPSIS
=begin code :lang<raku>
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
=end code
=end SYNOPSIS

=begin INSTALLATION
You need to have L<Raku|https://www.raku-lang.ir/en/> and L<zef|https://github.com/ugexe/zef>, then run:

=begin code :lang<console>
zef install --/test "T:auth<zef:CIAvash>"
=end code

or if you have cloned the repo:

=begin code :lang<console>
zef install .
=end code
=end INSTALLATION

=begin TESTING
=begin code :lang<console>
prove6 -I. -v
=end code
or:
=begin code :lang<console>
prove -ve 'raku -I.' --ext rakutest
=end code
=end TESTING

use QAST:from<NQP>;
use Test;

our sub T::t ($got, &op, $expected, Str:D $description) is test-assertion {
    cmp-ok $got, &op, $expected, $description
}

role T::Grammar:auth($?DISTRIBUTION.meta<auth>) {
    rule statement_control:sym<t> {
        <sym> <test>
    }
    token test {
        <EXPR>
    }
}

role T::Actions:auth($?DISTRIBUTION.meta<auth>) {
    method statement_control:sym<t> (Mu $/) {
        my $test      := $/.hash<test>;
        my $test_expr := $test.hash<EXPR>;
        my $OPER      := $test_expr.hash<OPER>;

        $/.panic: 'T: test needs to be of form <got> <infix> <expected>' unless $test_expr.list.elems == 2 && $OPER.defined;

        my $got         := $test_expr.list[0].made;
        my $expected    := $test_expr.list[1].made;
        my $description := QAST::SVal.new: value => $test.Str;

        my $op := $OPER.made || QAST::Var.new: :name("&infix" ~ $*W.canonicalize_pair('', $OPER)), :scope<lexical>;

        make QAST::Op.new: :op<call>, :name<&T::t>, $got, $op, $expected, $description
    }
}

$*LANG.define_slang: 'MAIN',
                     $*LANG.slang_grammar('MAIN').^mixin(T::Grammar),
                     $*LANG.actions.^mixin(T::Actions)

=REPOSITORY L<https://github.com/CIAvash/T>

=BUGS L<https://github.com/CIAvash/T/issues>

=AUTHOR Siavash Askari Nasr L<https://www.ciavash.name>

=COPYRIGHT Copyright © 2022 Siavash Askari Nasr

=begin LICENSE
This file is part of T.

T is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

T is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with T.  If not, see <http://www.gnu.org/licenses/>.
=end LICENSE
