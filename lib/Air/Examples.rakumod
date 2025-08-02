unit class Air::Examples;

#use Air::Examples::Site00-Nano;
#use Air::Examples::Site01-Minimal;
#use Air::Examples::Site02-Sections;
#use Air::Examples::Site03-Pages;
#use Air::Examples::Site04-HarcStack;
#use Air::Examples::Site05-PagesFunc;
#use Air::Examples::Site06-Semantic;
#use Air::Examples::Site07-BaseExamples;
#use Air::Examples::Site08-SearchTable;
#use Air::Examples::Site09-Todos;
#use Air::Examples::Site10-Counter;
#use Air::Examples::Site11-Form;
#use Air::Examples::Site12-FormShort;
#use Air::Examples::Site13-FormRed;
#use Air::Examples::Site14-CounterRed;
#use Air::Examples::Site15-TodosRed;
#use Air::Examples::Site16-Hilite;
#use Air::Examples::Site17-Dashboard;
use Air::Examples::Site18-EditRow;

sub routes is export {
    SITE.routes
}
