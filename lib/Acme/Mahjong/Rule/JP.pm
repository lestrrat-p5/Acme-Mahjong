# $Id: JP.pm 17455 2008-08-11 14:26:36Z daisuke $

package Acme::Mahjong::Rule::JP;
use Moose;

with 'Acme::Mahjong::Rule';

no Moose;

sub calculate {
    my ($self, %args) = @_;

    my $hand = $args{hand};
    # pre-analyze the suits/kinds for easier calculation

    my @tiles = $hand->tiles;
    my %meta;

    my %kinds;
    foreach my $tile (@tiles) {
        if ($tile->isa('Acme::Mahjong::Tile::Suited')) {
            $kinds{ $tile->suit }++;
        } elsif ($tile->isa('Acme::Mahjong::Tile::Wind')) {
            $kinds{ wind }++;
        } elsif ($tile->isa('Acme::Mahjong::Tile::Dragon')) {
            $kinds{ dragon }++;
        }
    }
    $meta{ kinds } = \%kinds;

    $self->fu2score(
        $self->hand2fu( hand => $hand, %args, meta => \%meta )
    );
}

sub hand2fu {
    
}

sub fu2score {
    my ($self, %args) = @_;

    my $fu = $args{fu};
    my $hon = $args{hon};

    if (my $r = $fu % 10) {
        $fu -= $r;
        $fu += 10;
    }

    if ( $hon >= 5 ) {
        goto MANGAN;
    } elsif ($hon == 3 && $fu > 60 || $hon == 4 && $fu > 30) {
        $hon = 5;
        goto MANGAN;
    }

    my $score = 0;
    if ($args{oya}) {
        $score = (24 * $fu) * ( 2 ** $hon );
    } else {
        $score = (16 * $fu) * ( 2 ** $hon );
    }

    if (my $r = $score % 100) {
        $score -= $r;
        $score += 100;
    }
    return $score;

MANGAN:
    # 満貫以降の点数計算は比較的シンプル
    $score = 0;
    if ($hon == 5) {
        $score = 8000;
    } elsif ($hon <= 7) {
        $score = 12000;
    } elsif ($hon <= 10) {
        $score = 16000;
    } elsif ($hon <= 12) {
        $score = 24000;
    } else {
        $score = 32000;
    }

    if ($args{oya}) {
        $score *= 1.5;
    }

    return $score;
}

1;

__END__

=head1 NAME

Acme::Mahjong::Rule::JP - A Generic Rule For Japan

=cut