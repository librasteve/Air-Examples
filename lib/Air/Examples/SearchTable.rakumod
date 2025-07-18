use Air::Functional;
use Air::Component;

my @components = <SearchTable>;

use Red:api<2>;

model Person {
    has Int      $.id         is serial;
    has Str      $.firstName  is column;
    has Str      $.lastName   is column;
    has Str      $.email      is column;
    has Str      $.city       is column;

    method ^populate($model) {
        for json-data() -> %record {
            $model.^create(|%record);
        }
    }
}

red-defaults “SQLite”;
Person.^create-table;
Person.^populate;

# Verify test records were created
#note Person.^all.map({ $_.firstName ~ ' ' ~ $_.lastName }).join(", ");

role HxSearchBox {
    method hx-search-box(--> Hash()) {
        :hx-put("{self.url}/{self.id}/search"),
        :hx-trigger<keyup changed delay:500ms, search>,
        :hx-target<#search-results>,
        :hx-swap<outerHTML>,
        :hx-indicator<.htmx-indicator>,
    }
}

class SearchBox does HxSearchBox {
    has $.url;
    has $.id;
    has $.title;

    multi method HTML {
        div [
            h3 [
                $!title,
                span :class<htmx-indicator>,
                    [img :src</img/bars.svg>; '  Searching...']
            ];

            input :type<search>, :name<needle>, |$.hx-search-box,
                :placeholder<Begin typing to search...>;
        ]
    }
}

class Results does Component {
    has @.data is rw = [];

    multi method HTML {
        tbody :id<search-results>,
            do for @!data {
                tr
                    td .firstName, td .lastName, td .email
            }
    }
}

class SearchTable does Component {
    has Str  $.title = 'Search';
    has      $.thead = <First Last Email>;

    has SearchBox $.searchbox .= new: :url(self.url), :id(self.id), :$!title;
    has Results   $.results   .= new;

    method thead {
        tr do for |$!thead -> $cell {
            th :scope<col>, $cell
        }
    }

    method search(:$needle) is controller{:http-method('PUT')} {

        sub check($_) { .fc.contains($needle.fc) }

        $!results.data = Person.^all.grep: {
            $_.firstName.&check ||
            $_.lastName.&check  ||
            $_.email.&check
        };

        $!results;
    }

    multi method HTML {
        [
            $!searchbox.HTML;

            table :class<striped>, [
                thead $.thead;
                tbody :id<search-results>;
            ];
        ]
    }
}

##### HTML Functional Export #####

# put in all the tags programmatically
# viz. https://docs.raku.org/language/modules#Exporting_and_selective_importing

my package EXPORT::DEFAULT {
    for @components -> $name {
        OUR::{'&' ~ $name.lc} :=
            sub (*@a, *%h) {
                ::($name).new( |@a, |%h ).HTML;
            }
    }
}

##### Person Data #####

use JSON::Fast;
sub json-data {
    from-json q:to/END/;
    [
        {"firstName": "Venus", "lastName": "Grimes", "email": "lectus.rutrum@Duisa.edu", "city": "Ankara"},
        {"firstName": "Fletcher", "lastName": "Owen", "email": "metus@Aenean.org", "city": "Niort"},
        {"firstName": "William", "lastName": "Hale", "email": "eu.dolor@risusodio.edu", "city": "Te Awamutu"},
        {"firstName": "TaShya", "lastName": "Cash", "email": "tincidunt.orci.quis@nuncnullavulputate.co.uk", "city": "Titagarh"},
        {"firstName": "Kevyn", "lastName": "Hoover", "email": "tristique.pellentesque.tellus@Cumsociis.co.uk", "city": "Cuenca"},
        {"firstName": "Jakeem", "lastName": "Walker", "email": "Morbi.vehicula.Pellentesque@faucibusorci.org", "city": "St. Andrä"},
        {"firstName": "Malcolm", "lastName": "Trujillo", "email": "sagittis@velit.edu", "city": "Fort Resolution"},
        {"firstName": "Wynne", "lastName": "Rice", "email": "augue.id@felisorciadipiscing.edu", "city": "Kinross"},
        {"firstName": "Evangeline", "lastName": "Klein", "email": "adipiscing.lobortis@sem.org", "city": "San Giovanni in Galdo"},
        {"firstName": "Jennifer", "lastName": "Russell", "email": "sapien.Aenean.massa@risus.com", "city": "Laives/Leifers"},
        {"firstName": "Rama", "lastName": "Freeman", "email": "Proin@quamPellentesquehabitant.net", "city": "Flin Flon"},
        {"firstName": "Jena", "lastName": "Mathis", "email": "non.cursus.non@Phaselluselit.com", "city": "Fort Simpson"},
        {"firstName": "Alexandra", "lastName": "Maynard", "email": "porta.elit.a@anequeNullam.ca", "city": "Nazilli"},
        {"firstName": "Tallulah", "lastName": "Haley", "email": "ligula@id.net", "city": "Bay Roberts"},
        {"firstName": "Timon", "lastName": "Small", "email": "velit.Quisque.varius@gravidaPraesent.org", "city": "Girona"},
        {"firstName": "Randall", "lastName": "Pena", "email": "facilisis@Donecconsectetuer.edu", "city": "Edam"},
        {"firstName": "Conan", "lastName": "Vaughan", "email": "luctus.sit@Classaptenttaciti.edu", "city": "Nadiad"},
        {"firstName": "Dora", "lastName": "Allen", "email": "est.arcu.ac@Vestibulumante.co.uk", "city": "Renfrew"},
        {"firstName": "Aiko", "lastName": "Little", "email": "quam.dignissim@convallisest.net", "city": "Delitzsch"},
        {"firstName": "Jessamine", "lastName": "Bauer", "email": "taciti.sociosqu@nibhvulputatemauris.co.uk", "city": "Offida"},
        {"firstName": "Gillian", "lastName": "Livingston", "email": "justo@atiaculisquis.com", "city": "Saskatoon"},
        {"firstName": "Laith", "lastName": "Nicholson", "email": "elit.pellentesque.a@diam.org", "city": "Tallahassee"},
        {"firstName": "Paloma", "lastName": "Alston", "email": "cursus@metus.org", "city": "Cache Creek"},
        {"firstName": "Freya", "lastName": "Dunn", "email": "Vestibulum.accumsan@metus.co.uk", "city": "Heist-aan-Zee"},
        {"firstName": "Griffin", "lastName": "Rice", "email": "justo@tortordictumeu.net", "city": "Montpelier"},
        {"firstName": "Catherine", "lastName": "West", "email": "malesuada.augue@elementum.com", "city": "Tarnów"},
        {"firstName": "Jena", "lastName": "Chambers", "email": "erat.Etiam.vestibulum@quamelementumat.net", "city": "Konya"},
        {"firstName": "Neil", "lastName": "Rodriguez", "email": "enim@facilisis.com", "city": "Kraków"},
        {"firstName": "Freya", "lastName": "Charles", "email": "metus@nec.net", "city": "Arzano"},
        {"firstName": "Anastasia", "lastName": "Strong", "email": "sit@vitae.edu", "city": "Polpenazze del Garda"},
        {"firstName": "Bell", "lastName": "Simon", "email": "mollis.nec.cursus@disparturientmontes.ca", "city": "Caxias do Sul"},
        {"firstName": "Minerva", "lastName": "Allison", "email": "Donec@nequeIn.edu", "city": "Rio de Janeiro"},
        {"firstName": "Yoko", "lastName": "Dawson", "email": "neque.sed@semper.net", "city": "Saint-Remy-Geest"},
        {"firstName": "Nadine", "lastName": "Justice", "email": "netus@et.edu", "city": "Calgary"},
        {"firstName": "Hoyt", "lastName": "Rosa", "email": "Nullam.ut.nisi@Aliquam.co.uk", "city": "Mold"},
        {"firstName": "Shafira", "lastName": "Noel", "email": "tincidunt.nunc@non.edu", "city": "Kitzbühel"},
        {"firstName": "Jin", "lastName": "Nunez", "email": "porttitor.tellus.non@venenatisamagna.net", "city": "Dreieich"},
        {"firstName": "Barbara", "lastName": "Gay", "email": "est.congue.a@elit.com", "city": "Overland Park"},
        {"firstName": "Riley", "lastName": "Hammond", "email": "tempor.diam@sodalesnisi.net", "city": "Smoky Lake"},
        {"firstName": "Molly", "lastName": "Fulton", "email": "semper@Naminterdumenim.net", "city": "Montese"},
        {"firstName": "Dexter", "lastName": "Owen", "email": "non.ante@odiosagittissemper.ca", "city": "Bousval"},
        {"firstName": "Kuame", "lastName": "Merritt", "email": "ornare.placerat.orci@nisinibh.ca", "city": "Solingen"},
        {"firstName": "Maggie", "lastName": "Delgado", "email": "Nam.ligula.elit@Cum.org", "city": "Tredegar"},
        {"firstName": "Hanae", "lastName": "Washington", "email": "nec.euismod@adipiscingelit.org", "city": "Amersfoort"},
        {"firstName": "Jonah", "lastName": "Cherry", "email": "ridiculus.mus.Proin@quispede.edu", "city": "Acciano"},
        {"firstName": "Cheyenne", "lastName": "Munoz", "email": "at@molestiesodalesMauris.edu", "city": "Saint-Léonard"},
        {"firstName": "India", "lastName": "Mack", "email": "sem.mollis@Inmi.co.uk", "city": "Maryborough"},
        {"firstName": "Lael", "lastName": "Mcneil", "email": "porttitor@risusDonecegestas.com", "city": "Livorno"},
        {"firstName": "Jillian", "lastName": "Mckay", "email": "vulputate.eu.odio@amagnaLorem.co.uk", "city": "Salvador"},
        {"firstName": "Shaine", "lastName": "Wright", "email": "malesuada@pharetraQuisqueac.org", "city": "Newton Abbot"},
        {"firstName": "Keane", "lastName": "Richmond", "email": "nostra.per.inceptos@euismodurna.org", "city": "Canterano"},
        {"firstName": "Samuel", "lastName": "Davis", "email": "felis@euenim.com", "city": "Peterhead"},
        {"firstName": "Zelenia", "lastName": "Sheppard", "email": "Quisque.nonummy@antelectusconvallis.org", "city": "Motta Visconti"},
        {"firstName": "Giacomo", "lastName": "Cole", "email": "aliquet.libero@urnaUttincidunt.ca", "city": "Donnas"},
        {"firstName": "Mason", "lastName": "Hinton", "email": "est@Nunc.co.uk", "city": "St. Asaph"},
        {"firstName": "Katelyn", "lastName": "Koch", "email": "velit.Aliquam@Suspendisse.edu", "city": "Cleveland"},
        {"firstName": "Olga", "lastName": "Spencer", "email": "faucibus@Praesenteudui.net", "city": "Karapınar"},
        {"firstName": "Erasmus", "lastName": "Strong", "email": "dignissim.lacus@euarcu.net", "city": "Passau"},
        {"firstName": "Regan", "lastName": "Cline", "email": "vitae.erat.vel@lacusEtiambibendum.co.uk", "city": "Pergola"},
        {"firstName": "Stone", "lastName": "Holt", "email": "eget.mollis.lectus@Aeneanegestas.ca", "city": "Houston"},
        {"firstName": "Deanna", "lastName": "Branch", "email": "turpis@estMauris.net", "city": "Olcenengo"},
        {"firstName": "Rana", "lastName": "Green", "email": "metus@conguea.edu", "city": "Onze-Lieve-Vrouw-Lombeek"},
        {"firstName": "Caryn", "lastName": "Henson", "email": "Donec.sollicitudin.adipiscing@sed.net", "city": "Kington"},
        {"firstName": "Clarke", "lastName": "Stein", "email": "nec@mollis.co.uk", "city": "Tenali"},
        {"firstName": "Kelsie", "lastName": "Porter", "email": "Cum@gravidaAliquam.com", "city": "İskenderun"},
        {"firstName": "Cooper", "lastName": "Pugh", "email": "Quisque.ornare.tortor@dictum.co.uk", "city": "Delhi"},
        {"firstName": "Paul", "lastName": "Spencer", "email": "ac@InfaucibusMorbi.com", "city": "Biez"},
        {"firstName": "Cassady", "lastName": "Farrell", "email": "Suspendisse.non@venenatisa.net", "city": "New Maryland"},
        {"firstName": "Sydnee", "lastName": "Velazquez", "email": "mollis@loremfringillaornare.com", "city": "Stroe"},
        {"firstName": "Felix", "lastName": "Boyle", "email": "id.libero.Donec@aauctor.org", "city": "Edinburgh"},
        {"firstName": "Ryder", "lastName": "House", "email": "molestie@natoquepenatibus.org", "city": "Copertino"},
        {"firstName": "Hadley", "lastName": "Holcomb", "email": "penatibus@nisi.ca", "city": "Avadi"},
        {"firstName": "Marsden", "lastName": "Nunez", "email": "Nulla.eget.metus@facilisisvitaeorci.org", "city": "New Galloway"},
        {"firstName": "Alana", "lastName": "Powell", "email": "non.lobortis.quis@interdumfeugiatSed.net", "city": "Pitt Meadows"},
        {"firstName": "Dennis", "lastName": "Wyatt", "email": "Morbi.non@nibhQuisquenonummy.ca", "city": "Wrexham"},
        {"firstName": "Karleigh", "lastName": "Walton", "email": "nascetur.ridiculus@quamdignissimpharetra.com", "city": "Diksmuide"},
        {"firstName": "Brielle", "lastName": "Donovan", "email": "placerat@at.edu", "city": "Kolmont"},
        {"firstName": "Donna", "lastName": "Dickerson", "email": "lacus.pede.sagittis@lacusvestibulum.com", "city": "Vallepietra"},
        {"firstName": "Eagan", "lastName": "Pate", "email": "est.Nunc@cursusNunc.ca", "city": "Durness"},
        {"firstName": "Carlos", "lastName": "Ramsey", "email": "est.ac.facilisis@duinec.co.uk", "city": "Tiruvottiyur"},
        {"firstName": "Regan", "lastName": "Murphy", "email": "lectus.Cum@aptent.com", "city": "Candidoni"},
        {"firstName": "Claudia", "lastName": "Spence", "email": "Nunc.lectus.pede@aceleifend.co.uk", "city": "Augusta"},
        {"firstName": "Genevieve", "lastName": "Parker", "email": "ultrices@inaliquetlobortis.net", "city": "Forbach"},
        {"firstName": "Marshall", "lastName": "Allison", "email": "erat.semper.rutrum@odio.org", "city": "Landau"},
        {"firstName": "Reuben", "lastName": "Davis", "email": "Donec@auctorodio.edu", "city": "Schönebeck"},
        {"firstName": "Ralph", "lastName": "Doyle", "email": "pede.Suspendisse.dui@Curabitur.org", "city": "Linkebeek"},
        {"firstName": "Constance", "lastName": "Gilliam", "email": "mollis@Nulla.edu", "city": "Enterprise"},
        {"firstName": "Serina", "lastName": "Jacobson", "email": "dictum.augue@ipsum.net", "city": "Hérouville-Saint-Clair"},
        {"firstName": "Charity", "lastName": "Byrd", "email": "convallis.ante.lectus@scelerisquemollisPhasellus.co.uk", "city": "Brussegem"},
        {"firstName": "Hyatt", "lastName": "Bird", "email": "enim.Nunc.ut@nonmagnaNam.com", "city": "Gdynia"},
        {"firstName": "Brent", "lastName": "Dunn", "email": "ac.sem@nuncid.com", "city": "Hay-on-Wye"},
        {"firstName": "Casey", "lastName": "Bonner", "email": "id@ornareelitelit.edu", "city": "Kearny"},
        {"firstName": "Hakeem", "lastName": "Gill", "email": "dis@nonummyipsumnon.org", "city": "Portico e San Benedetto"},
        {"firstName": "Stewart", "lastName": "Meadows", "email": "Nunc.pulvinar.arcu@convallisdolorQuisque.net", "city": "Dignano"},
        {"firstName": "Nomlanga", "lastName": "Wooten", "email": "inceptos@turpisegestas.ca", "city": "Troon"},
        {"firstName": "Sebastian", "lastName": "Watts", "email": "Sed.diam.lorem@lorem.co.uk", "city": "Palermo"},
        {"firstName": "Chelsea", "lastName": "Larsen", "email": "ligula@Nam.net", "city": "Poole"},
        {"firstName": "Cameron", "lastName": "Humphrey", "email": "placerat@id.org", "city": "Manfredonia"},
        {"firstName": "Juliet", "lastName": "Bush", "email": "consectetuer.euismod@vitaeeratVivamus.co.uk", "city": "Lavacherie"},
        {"firstName": "Caryn", "lastName": "Hooper", "email": "eu.enim.Etiam@ridiculus.org", "city": "Amelia"}
    ]
    END
}
