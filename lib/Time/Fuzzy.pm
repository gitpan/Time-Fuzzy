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
use DateTime::Duration;

use base qw[ Exporter ];
our @EXPORT = qw[ fuzzy ];

our $VERSION   = '0.21';
our $FUZZINESS = 'medium';

#--
# private vars

# - for medium fuzziness
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

# - for low fuzziness
my @hourtime = ( # defining the periods of the hour
    "%s o'clock", 'five past %s', 'ten past %s',
    'quarter past %s', 'twenty past %s', 'twenty five past %s',
    'half past %s', 'twenty five to %2$s', 'twenty to %2$s',
    'quarter to %2$s', 'ten to %2$s', 'five to %2$s',
    q{%2$s o'clock}, # needed for 58-59
);
my @hours = (
    'midnight',
    qw[ one two three four five six seven eight nine ten eleven noon ],
    qw[ one two three four five six seven eight nine ten eleven midnight ],
);


#--
# public subs

sub fuzzy {
    my $dt = $_[0] || DateTime->now( time_zone=>"local" );
    my %fuzzysub = (
        low    => \&_fuzzy_low,
        medium => \&_fuzzy_medium,
    );
    return $fuzzysub{$FUZZINESS}->($dt);
}


#--
# private subs

#
# my $fuz = _fuzzy_low($dt)
#
# Return a fuzzy time defined by $dt. The fuzziness is a bit low, that
# is, 5 minutes in this case.
#
sub _fuzzy_low {
    my ($dt1) = @_;

    my $sector = int( ($dt1->minute + 2) / 5 );
    my $hour1 = $hours[$dt1->hour];
    
    # compute next hour, for 2nd half of the hour.
    my $dt2   = $dt1 + DateTime::Duration->new(hours=>1);
    my $hour2 = $hours[$dt2->hour];

    # midnight or noon don't need o'clock appended.
    return $hour1
        if ($sector==0  && $dt1->hour==0)    # 0:01
        || ($sector==0  && $dt1->hour==12);  # 12:02
    return $hour2
        if ($sector==12 && $dt1->hour==23)   # 23:58
        || ($sector==12 && $dt1->hour==11);  # 11:59

    # compute fuzzy.
    my $fuzzy = sprintf $hourtime[$sector], $hour1, $hour2;
    return $fuzzy;
}


#
# my $fuz = _fuzzy_medium($dt)
#
# Return a fuzzy time defined by $dt. The fuzziness is medium, that
# is, around 3 hours in this case.
#
sub _fuzzy_medium {
    my ($dt) = @_;
    return $daytime[$dt->hour];
}


1;
__END__

=head1 NAME

Time::Fuzzy - Time read like a human, with some fuzziness



=head1 SYNOPSIS

    use Time::Fuzzy;

    my $now = fuzzy();
    $Time::Fuzzy::FUZZINESS = 'low';
    my $fuz = fuzzy( DateTime->new(...) );




=head1 DESCRIPTION

Nobody will ever say "it's 11:57". People just say "it's noon".

This Perl module does just the same: it adds some human fuzziness to the
way computer deal with time.




=head1 FUNCTIONS

=head2 my $fuzzy = fuzzy( [ $dt ] )

Return the fuzzy time defined by C<$dt>, a C<DateTime> object. If no
argument, return the (fuzzy) current time.



=head2 Fuziness factor

By default, C<Time::Fuzzy> is using a medium fuzziness factor. You can
change that by modifying C<$Time::Fuzzy::FUZZINESS>. The accepted values
are C<low> and C<medium>.



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

