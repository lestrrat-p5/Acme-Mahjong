# $Id: Rule.pm 17415 2008-08-11 08:15:08Z daisuke $

package Acme::Mahjong::Rule;
use Moose::Role;
use Acme::Mahjong::Hand;
use Acme::Mahjong::Deck;

requires qw(calculate);

no Moose;

sub hand_create {
    return Acme::Mahjong::Hand->new;
}

sub deck_create {
    return Acme::Mahjong::Deck->new;
}

1;