# $Id: Hand.pm 17430 2008-08-11 10:05:56Z daisuke $

package Acme::Mahjong::Hand;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'Acme::Mahjong::Hand::TileList'
    => as 'ArrayRef'
#    => where { 
#        my $list = $_;
#        ! grep { $_->does('Acme::Mahjong::Tile') } @$list;
#    }
#    => where { 
#    => message { "Hand must be less than 14 tiles" }
;

has 'tiles' => (
    is => 'rw',
    isa => 'Acme::Mahjong::Hand::TileList',
    required => 1,
    default => sub { +[] },
);

no Moose;

sub add {
    my ($self, %args) = @_;
    my $tile = $args{tile};
    my @tiles = @{ $self->tiles };
    push @tiles, $tile;

    $self->tiles( \@tiles ); # so that type checking is triggered
}

sub remove {
    my ($self, %args) = @_;

    my $tile = $args{tile};
    my $tiles = $self->tiles;
    for my $i (0..scalar(@$tiles)) {
        my $cur = $tiles->[$i];
        if ($cur->eq( $tile ) ) {
            splice( @$tiles, $i, 1 );
            last;
        }
    }
}

sub sort {
    my $self = shift;

    my %suit;
    my %dragon;
    my %wind;

    foreach my $tile (@{ $self->tiles }) {
        if ($tile->isa('Acme::Mahjong::Tile::Suited')) {
            $suit{ $tile->suit } ||= [];
            push @{ $suit{ $tile->suit } }, $tile;
        } elsif ( $tile->isa('Acme::Mahjong::Tile::Dragon')) {
            $dragon{ $tile->suit } ||= [];
            push @{ $dragon{ $tile->label } }, $tile;
        } elsif ( $tile->isa('Acme::Mahjong::Tile::Wind')) {
            $wind{ $tile->suit } ||= [];
            push @{ $wind{ $tile->label } }, $tile;
        } else {
            confess "Don't know what to do with $tile";
        }
    }

    return (
        (map { sort @{ $suit{ $_ } } } keys %suit),
        (map { @{$dragon{$_}} } keys %dragon),
        (map { @{$wind{$_}} } keys %wind),
    );
}

1;