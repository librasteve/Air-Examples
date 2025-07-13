use Air::Functional :BASE;
use Air::Base;
use Air::Component;

class Dashboard does Section {
    method STYLE {
        Q:to/END/;

        .dashboard {
          display: flex;
          flex-wrap: wrap;
          gap: 1rem;
          justify-content: flex-start;
        }

        .box {
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
                section :class<dashboard>, [
                    article :class<box>, :style('order: 1'), h2 'Analytics';
                    article :class<box>, :style('order: 2'), h2 'Traffic';
                    article :class<box>, :style('order: 3'), h2 'Comments';
                    article :class<box>, :style('order: 4'), h2 'Quick Draft';
                    article :class<box>, :style('order: 5'), h2 'Recent Activity';
                    article :class<box>, :style('order: 6'), h2 'Site Overview';
                    article :class<box>, :style('order: 7'), h2 'News';
                ];
            ];
        ];
}
