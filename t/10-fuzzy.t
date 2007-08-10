#!perl
#
# This file is part of Time::Fuzzy.
# Copyright (c) 2007 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
#

use strict;
use warnings;

use Test::More tests => 8;
use Time::Fuzzy;


# fuzziness: medium.
my $dt = DateTime->new(year=>1976, hour=>20, minute=>2);
is  ( fuzzy($dt), 'evening',           'basic fuzzy() usage' );
like( fuzzy(),    qr/ning|noon|night/, 'fuzzy() called without param' );


# fuzziness: low.
$Time::Fuzzy::FUZZINESS = 'low';
is( fuzzy($dt), "eight o'clock", 'basic fuzzy() usage' );
$dt->set( minute=>3 ); # should be enough to go to next sector
is( fuzzy($dt), 'five past eight', 'basic fuzzy() usage' );
$dt->set( hour=>23, minute=>58 );
is( fuzzy($dt), 'midnight', 'midnight case (just before)' );
$dt->set( hour=>0, minute=>1 );
is( fuzzy($dt), 'midnight', 'midnight case' );
$dt->set( hour=>11, minute=>59 );
is( fuzzy($dt), 'noon', 'noon case (just before)' );
$dt->set( hour=>12, minute=>0 );
is( fuzzy($dt), 'noon', 'noon case' );



exit;
