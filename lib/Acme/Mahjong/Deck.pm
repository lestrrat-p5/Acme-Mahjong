# $Id: Deck.pm 17418 2008-08-11 08:22:46Z daisuke $

package Acme::Mahjong::Deck;
use Moose;
use Moose::Util::TypeConstraints;
use Acme::Mahjong::Tile::Dragon;
use Acme::Mahjong::Tile::Suited;
use Acme::Mahjong::Tile::Wind;
use List::Util qw(shuffle);

subtype 'Acme::Mahjong::Deck::TileList'
    => as 'ArrayRef[Acme::Mahjong::Tile]'
    => where { scalar(@$_) <= 136 }
;

has 'tiles' => (
    is => 'rw',
    isa => 'Acme::Mahjong::Deck::TileList',
    required => 1,
    default => sub { +[] },
);

no Moose;

sub populate {
    my $self = shift;

    my @tiles;
    foreach my $suit qw(CIRCLE BAMBOO COIN) {
        foreach my $i (1..9) {
            push @tiles, Acme::Mahjong::Tile::Suited->new(
                suit => $suit,
                number => $i
            );
        }
    }
    
    foreach my $dragon qw( RED GREEN WHITE ) { 
        foreach my $i (1..4) {
            push @tiles, Acme::Mahjong::Tile::Dragon->new(label => $dragon);
        }
    }

    foreach my $wind qw( EAST SOUTH WEST NORTH ) {
        foreach my $i (1..4) {
            push @tiles, Acme::Mahjong::Tile::Wind->new(label => $wind);
        }
    }

    $self->tiles( [ shuffle @tiles ] );
}

1;
