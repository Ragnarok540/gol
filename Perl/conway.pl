use POSIX;
use Time::HiRes;

sub new_grid {
    my ($height, $width) = @_;
    my @grid = ();

    for ($i = 0; $i < $height; $i = $i + 1) {
        for ($j = 0; $j < $width; $j = $j + 1) {
            $grid[$i][$j] = 0;
        }
    }

    return @grid;
}

sub query {
    my ($x, $y) = @_;
    return $g[fmod($x, $h)][fmod($y, $w)];
}

sub assign {
    my ($x, $y, $state) = @_;
    $g[fmod($x, $h)][fmod($y, $w)] = $state;
}

sub count_neighbors {
    my ($x, $y) = @_;
    my $n  = query($x + 1, $y    );
    my $ne = query($x + 1, $y + 1);
    my $e  = query($x,     $y + 1);
    my $se = query($x - 1, $y + 1);
    my $s  = query($x - 1, $y    );
    my $sw = query($x - 1, $y - 1);
    my $w  = query($x,     $y - 1);
    my $nw = query($x + 1, $y - 1);
    return $n + $ne + $e + $se + $s + $sw + $w + $nw;
}

sub print_grid {
    foreach my $row (@g) {
        foreach my $col (@$row) {
            print $col == 0 ? "." : "#";
        }
        print "\n";
    }
}

sub game_logic {
    ($state, $neighbors) = @_;
    if ($state == 1) {
        if ($neighbors < 2) {
            return 0;
        }
        if ($neighbors > 3) {
            return 0;
        }
        return $state;
    } else {
        if ($neighbors == 3) {
            return 1;
        }
        return $state;
    }
}

sub step_cell {
    my ($x, $y) = @_;
    my $state = query($x, $y);
    my $neighbors = count_neighbors($x, $y);
    my $next_state = game_logic($state, $neighbors);
    return $next_state;
}

sub simulate {
    my @new_g = new_grid($h, $w);

    for ($i = 0; $i < $h; $i = $i + 1) {
        for ($j = 0; $j < $w; $j = $j + 1) {
            $new_g[$i][$j] = step_cell($i, $j);
        }
    }

    @g = @new_g;
}

sub clear_screen {
    print "\x1B[2J";
}

our $h = 10;
our $w = 20;
our @g = new_grid($h, $w);

assign(0, 3, 1);
assign(1, 4, 1);
assign(2, 2, 1);
assign(2, 3, 1);
assign(2, 4, 1);

print_grid;

while (true) {
    clear_screen;
    simulate;
    print_grid;
    Time::HiRes::sleep(0.1);
}

# perl conway.pl
