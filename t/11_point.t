use strict;
use Test::More (tests => 4 );

BEGIN
{
    use_ok("Acme::Mahjong::Rule::JP");
}

{
    my $rule = Acme::Mahjong::Rule::JP->new();

    my @patterns = (
        { fu => 37, hon => 3, score => 5200 },
        { fu => 71, hon => 3, score => 8000 },
        { fu =>  0, hon => 5, score => 8000 },
    );

    foreach my $data (@patterns) {
        my $score = $rule->fu2score( %$data );
        is( $score, $data->{score}, "expected $data->{score}, got $score (fu = $data->{fu}, hon = $data->{hon})" );
    }
}
