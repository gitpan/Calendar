#!/usr/bin/perl -w
# cal-test.pl --- Generate date for 200 years since 1900
# Author: Ye Wenbin <wenbinye@gmail.com>
# Created: 01 Jan 2008
# Version: 0.01

use warnings;
use strict;

use Calendar::Gregorian;
use Calendar::China;
use Calendar::Julian;

my $date = Calendar::Gregorian->new(1, 1, 1900);
my $abs = $date->absolute_date;
my $max = 365 * 200;

$Calendar::Gregorian::default_format = "%A => (%m %d %y)";
$Calendar::Julian::default_format = "%A => (%m %d %y)";
$Calendar::China::default_format = "%A => (%c %y %m %d)";
sub Calendar::format_m { return shift->month; }
sub Calendar::format_y { return shift->year; }
sub Calendar::format_d { return shift->day; }
sub Calendar::China::format_c { return shift->cycle; }
sub Calendar::China::format_m { return shift->month; }
sub Calendar::China::format_y { return shift->year; }
sub Calendar::China::format_d { return shift->day; }

create_data('gregorian', $abs, $max);
create_data('julian', $abs, $max);
create_data('china', $abs, $max);

sub create_data {
    my ($type, $start, $days, $file) = @_;
    $file ||= "cal-pl";
    my $package = "Calendar::". ucfirst($type);
    my $date = $package->new($start);
    # my $fh = \*STDOUT;
    open(my $fh, ">", "$file-$type.txt") or die "Can't create file $file-$type.txt: $!";
    for ( 1 .. $days ) {
        print {$fh} $date, "\n";
        $date++;
    }
}

__END__

=head1 NAME

cal-test.pl - Describe the usage of script briefly

=head1 SYNOPSIS

cal-test.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for cal-test.pl, 

=head1 AUTHOR

Ye Wenbin, E<lt>wenbinye@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Ye Wenbin

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
