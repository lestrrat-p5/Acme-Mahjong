# $Id: Wind.pm 17418 2008-08-11 08:22:46Z daisuke $

package Acme::Mahjong::Tile::Wind;
use Moose;
use Moose::Util::TypeConstraints;

with 'Acme::Mahjong::Tile';

has 'label' => (
    is => 'ro',
    isa => enum( [ qw( EAST SOUTH WEST NORTH ) ] ),
    required => 1,
);

no Moose;

1;