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

use base qw[ Exporter ];
our @EXPORT = qw[ fuzzy ];

our $VERSION = '0.01';


sub fuzzy {
    return "noon";
}


1;
__END__

=head1 NAME

Time::Fuzzy - Time read like a human, with some fuzziness



=head1 SYNOPSIS

    use Time::Fuzzy;
    print fuzzy( ) . "\n";



=head1 DESCRIPTION

=head1 EXPORT

Nothing is exported by default.



=head1 FUNCTIONS

=head2 fuzzy( )

Return ...


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

