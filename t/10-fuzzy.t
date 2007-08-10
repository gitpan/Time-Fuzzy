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

use Test::More tests => 2;
use Time::Fuzzy;

# fuzzy
my $dt = DateTime->new(year=>1976, hour=>20);
is  ( fuzzy($dt), 'evening',           'basic fuzzy() usage' );
like( fuzzy(),    qr/ning|noon|night/, 'fuzzy() called without param' );

exit;
