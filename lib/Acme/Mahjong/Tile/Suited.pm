# $Id: Suited.pm 17434 2008-08-11 10:58:46Z daisuke $

package Acme::Mahjong::Tile::Suited;
use Moose;
use Moose::Util::TypeConstraints;
use overload
    '""' => \&as_string,
    fallback => 1
;

with 'Acme::Mahjong::Tile';

has 'suit' => (
    is => 'ro',
    isa => enum([ qw(CIRCLE BAMBOO COIN) ]),
    required => 1
);

has 'number' => (
    is => 'ro',
    isa => enum([ 1..9 ]),
    required => 1
);

no Moose;

sub as_string {
    my $self = shift;
    join('/', $self->suit, $self->number);
}

1;
