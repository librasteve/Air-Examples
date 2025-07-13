use Air::Functional :BASE;
use Air::Base;
use Air::Component;

class Dashboard does Section {
    method STYLE {
        Q:to/END/;
        section {
          display: flex;
          flex-wrap: wrap;
          gap: 1rem;
          justify-content: flex-start;
        }

        article {
          display: flex;
          align-items: center;

          /* Responsive sizing */
          flex: 1 1 400px;
          min-width: 400px;
          max-width: 600px;
          height: 200px;
        }
        END
    }
}


sub SITE is export {
    site :register[Dashboard.new],
        page #:REFRESH(15),
        [
            header [
                nav :widgets(lightdark);
                h1 'Welcome to My Dashboard';
            ];

            main [
                section [
                    article :style('order: 1'), h2 'Analytics';
                    article :style('order: 2'), h2 'Traffic';
                    article :style('order: 3'), h2 'Comments';
                    article :style('order: 4'), h2 'Quick Draft';
                    article :style('order: 5'), h2 'Recent Activity';
                    article :style('order: 6'), h2 'Site Overview';
                    article :style('order: 7'), h2 'News';
                ];
            ];
        ];
}
