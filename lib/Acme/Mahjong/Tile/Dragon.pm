# $Id: Dragon.pm 17403 2008-08-11 07:16:52Z daisuke $

package Acme::Mahjong::Tile::Dragon;
use Moose;
use Moose::Util::TypeConstraints;

with 'Acme::Mahjong::Tile';

has 'label' => (
    is => 'ro',
    isa => enum( [ qw( RED GREEN WHITE ) ] ),
    required => 1
);

no Moose;

1;