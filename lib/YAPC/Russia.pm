package YAPC::Russia;
{
  $YAPC::Russia::VERSION = '1.1.1';
}

# ABSTRACT: Perl conference YAPC::Russia


use strict;
use warnings FATAL => 'all';
use utf8;
use open qw(:std :utf8);

use Carp;

use Class::Date qw(date);



sub new {
    my ($class, %params) = @_;

    my $self = {};
    bless $self, $class;

    $self->{_year} = delete $params{year};
    croak 'No "year"' if not defined $self->{_year};

    croak 'Got unknown params: ' . join(', ', keys %params) if %params;

    $self->{_data} = $self->_get_data_for_year($self->{_year});

    return $self;
}


sub get_dates {
    my ($self) = @_;

    my @dates;
    foreach my $d (@{$self->{_data}->{dates}}) {
        push @dates, date($d);
    }

    return @dates;
}


sub get_place {
    my ($self) = @_;

    return $self->{_data}->{place};
}

sub _get_data_for_year {
    my ($self, $year) = @_;

    my %data = (
        2014 => {
            dates => [qw(2014-06-13 2014-06-14)],
            place => {
                city => 'Saint Petersburg',
                name_ru => 'Место Роста',
                address_ru => 'Курляндская, дом 5',
                site => 'http://mestorosta.biz',
                phone => '+7 812 648-13-81',
                foursquare => 'https://foursquare.com/v/%D0%BC%D0%B5%D1%81%D1%82%D0%BE-%D1%80%D0%BE%D1%81%D1%82%D0%B0/50fe895ce4b0382948fd8148',
            }
        },
    );

    if (exists $data{$year}) {
        return $data{$year};
    } else {
        croak 'Sorry, no data for year "' . $year . '"';
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

YAPC::Russia - Perl conference YAPC::Russia

=head1 VERSION

version 1.1.1

=head1 DESCRIPTION

Here is a simple object that gives data about Perl conference YAPC::Russia.

Several links about YAPC::Russia 2014:

L<http://event.yapcrussia.org/yr2014/>

L<https://www.facebook.com/events/317682595047028/>

L<https://vk.com/yapcrussia2014>

Module YAPC::Russia uses Semantic Versioning standart for version numbers.
Please visit L<http://semver.org/> to find out all about this great thing.

=head1 METHODS

=head2 new

    my $yr = YAPC::Russia->new(
        year => 2014,
    );

=head2 get_dates

Returns list of Class::Date objects with dates of the YAPC::Russia event.

    $yr->get_dates();

For the year 2014 it will return objects with dates:

    2014-06-13
    2014-06-14

=head2 get_place

Returns hashref with data about place where YAPC::Russia is held.

    $yr->get_place();

For the year 2014 it will return:

    {
        city => 'Saint Petersburg',
        name_ru => 'Место Роста',
        address_ru => 'Курляндская, дом 5',
        site => 'http://mestorosta.biz',
        phone => '+7 812 648-13-81',
        foursquare => 'https://foursquare.com/v/%D0%BC%D0%B5%D1%81%D1%82%D0%BE-%D1%80%D0%BE%D1%81%D1%82%D0%B0/50fe895ce4b0382948fd8148',
    }

=head1 AUTHOR

Ivan Bessarabov <ivan@bessarabov.ru>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ivan Bessarabov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
