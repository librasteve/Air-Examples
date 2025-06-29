use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

sub SITE is export {
    site :register[Air::Plugin::Hilite.new],
        page
            main
                hilite q:to/END/;
                    use Air::Functional :BASE;
                    use Air::Base;
                    use Air::Plugin::Hilite;

                    sub SITE is export {
                        site :register[Hilite.new],
                            index
                                main
                                    hilite 'say "yo, baby!"';
                    }
                END
}
