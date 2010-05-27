use strict;
use Test::More (tests => 21);
use List::Util qw(shuffle);

BEGIN
{
    use_ok "Acme::Mahjong";
    use_ok "Acme::Mahjong::Rule::JP";
}

{
    my $m = Acme::Mahjong->new(
        rule => Acme::Mahjong::Rule::JP->new()
    );

    ok($m);
    isa_ok($m, 'Acme::Mahjong');

    my $deck = $m->deck_create();
    my $hand = $m->hand_create();

    ok($deck);
    isa_ok($deck, 'Acme::Mahjong::Deck');

    ok($hand);
    isa_ok($hand, 'Acme::Mahjong::Hand');
}

{
    my $m = Acme::Mahjong->new(
        rule => Acme::Mahjong::Rule::JP->new()
    );

    my $hand = $m->hand_create();

    ok($hand);
    isa_ok($hand, 'Acme::Mahjong::Hand');

    my @tiles = (
        Acme::Mahjong::Tile::Suited->new( suit => 'BAMBOO', number => 2 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'BAMBOO', number => 3 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'BAMBOO', number => 4 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'COIN', number => 2 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'COIN', number => 3 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'COIN', number => 4 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'CIRCLE', number => 2 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'CIRCLE', number => 3 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'CIRCLE', number => 4 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'CIRCLE', number => 6 ),
        Acme::Mahjong::Tile::Suited->new( suit => 'CIRCLE', number => 6 ),
    );
    
    $hand->add( tile => $_ ) for (shuffle @tiles);

    my @sorted = $hand->sort;
    my $prev;
    foreach my $tile (@sorted) {
        if ( ! $prev ) {
            ok($tile);
        } else {
            if ($prev->suit eq $tile->suit) {
                ok( $prev->number <= $tile->number );
            } else {
                is ( $tile->number , 2, "Got $tile" );
            }
        }
        $prev = $tile;
    }
}


