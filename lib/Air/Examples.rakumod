use v6.d;
use Term::Choose;

unit module Examples;
=begin rakudoc
Get the examples from the bin file and allow for a choice
=end rakudoc 
multi sub MAIN {
    my $this = 'Air-examples.raku';
    my $ex-dir = 'x-bin';

    my @examples = $ex-dir.IO.dir(test=>/'.raku'/)>>.basename.grep({ !m/$this/ }).sort;
    my $tc = Term::Choose.new(
        :1mouse,
        :0order,
        :2color,
        :0clear-screen
    );

    my $chosen;
    my $proc;
    $chosen = $tc.choose( @examples, :2layout, :0default );
    say "Running example: $chosen\nUse Ctr-C to stop server";
    $proc = run ($*EXECUTABLE, '-I.', "$ex-dir/$chosen");
}
