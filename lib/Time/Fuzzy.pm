#
# This file is part of Time::Fuzzy
# Copyright (c) 2007 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#

package Time::Fuzzy;

use warnings;
use strict;

use DateTime;

use base qw[ Exporter ];
our @EXPORT = qw[ fuzzy ];

our $VERSION = '0.11';


#--
# private vars

my %daytime = ( # define the periods of the day
    'night'         => [ 0, 1, 2, 3, 4 ],
    'early morning' => [ 5, 6, 7 ],
    'morning'       => [ 8, 9, 10 ],
    'noon'          => [ 11, 12, 13 ],
    'afternoon'     => [ 14, 15, 16, 17, 18 ],
    'evening'       => [ 19, 20, 21 ],
    'late evening'  => [ 22, 23 ],
);
my @daytime; # a 24-slots array, one for each hour
{ # init @daytime by walking %daytime
    foreach my $dt ( keys %daytime ) {
        my $hours = $daytime{$dt};
        $daytime[$_] = $dt for @$hours;
    }
}


#--
# public subs

sub fuzzy {
    my $dt = $_[0] || DateTime->now;
    return $daytime[$dt->hour];
}


1;
__END__

=head1 NAME

Time::Fuzzy - Time read like a human, with some fuzziness



=head1 SYNOPSIS

    use Time::Fuzzy;

    my $now = fuzzy();
    my $fuz = fuzzy( DateTime->new(...) );




=head1 DESCRIPTION

Nobody will ever say "it's 11:57". People just say "it's noon".

This Perl module does just the same: it adds some human fuzziness to the
way computer deal with time.




=head1 FUNCTIONS

=head2 my $fuzzy = fuzzy( [ $dt ] )

Return the fuzzy time defined by C<$dt>, a C<DateTime> object. If no
argument, return the (fuzzy) current time.



=head1 BUGS

Please report any bugs or feature requests to C<< < bug-time-fuzzy at
rt.cpan.org> >>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Time-Fuzzy>.  I will be
notified, and then you'll automatically be notified of progress on your
bug as I make changes.



=head1 SEE ALSO

C<Time::Fuzzy> development takes place on
L<http://time-fuzzy.googlecode.com> - feel free to join us.


You can also look for information on this module at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Time-Fuzzy>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Time-Fuzzy>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Time-Fuzzy>

=back



=head1 AUTHOR

Jerome Quelin, C<< <jquelin at cpan.org> >>



=head1 COPYRIGHT & LICENSE

Copyright (c) 2007 Jerome Quelin, all rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

