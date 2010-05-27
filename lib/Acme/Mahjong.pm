# $Id: Mahjong.pm 17437 2008-08-11 11:03:16Z daisuke $

package Acme::Mahjong;
use Moose;

our $VERSION   = '0.00001';
our $AUTHORITY = 'cpan:DMAKI';

has 'rule' => (
    is => 'ro',
    does => 'Acme::Mahjong::Rule',
    handles => [ qw(calculate hand_create deck_create) ]
);

no Moose;

1;

__END__

=head1 NAME

Acme::Mahjong - Simple Mahjong Utility

=head1 SYNOPSIS

  my $m = Acme::Mahjong->new(
    rule => Achme::Mahjong::Rule::JP->new(),
  );

  my $hand = $m->hand_create();
  my $deck = $m->deck_create();

  for( 1..13 ) {
    my $tile = $deck->next();
    $hand->add( tile => $tile );
  }

  my $score = $m->calculate(
    hand => $hand,
    deck => $deck,
  );

=head1 DESCRIPTION

Proof of concept release! Don't use this just yet!

Mahjong is a wonderful game, which could get you literally addicted.
However, the game involves exceptionally extraneous score calculation rules,
which may differe from place to place (Not only between countries, but there
are all sorts of local rules)

This module attempts to help with that process, along with whatever else that
we may be able to come up.

=head1 TODO

Still need to figure out the actual 'yaku' from the tiles.

=head1 AUTHOR

Daisuke Maki C<< <daisuke@endeworks.jp> >>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut