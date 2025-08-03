#!/usr/bin/env raku


use Air::Functional :BASE;
use Air::Base;
use Air::Form;

use Red:api<2>;

model Contact does Form {
    has Int      $.id         is serial is hidden;
    has Str      $.first-name is column is validated(%va<name>);
    has Str      $.last-name  is column is validated(%va<name>)  is required;
    has Str      $.email      is column is validated(%va<email>) is required is email;
    has Str      $.city       is column is validated(%va<text>);

    method form-routes {
        self.init;

        self.submit: -> Contact $form {
            if $form.is-valid {
                note "Got form data: $form.form-data()";
                self.finish: 'Contact info received!'
            }
            else {
                self.retry: $form
            }
        }
    }

    method ^populate($model) {
        for json-data() -> %record {
            $model.^create(|%record);
        }
    }
}

red-defaults “SQLite”;
Contact.^create-table;
Contact.^populate;

#note Contact.^all.map({ $_.first-name ~ ' ' ~ $_.last-name }).join(", ");

my $contact-form = Contact.empty;

class Index is Page {
    has Str $.title       = 'hÅrc';
    has Str $.description = 'HTMX, Air, Red, Cro';

    has Nav $.nav = nav(
        logo    => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        widgets => [lightdark],
                                 );

    has Footer $.footer   = footer p ['Aloft on ', b 'åir'];
}
sub index(*@a, *%h) { Index.new( |@a, |%h ) };

my $site =
    site :register[$contact-form],
        index
        main
            content [
                h2 'Contact Form';
                $contact-form;
            ];
;

$site.serve;



##### Contact Data #####

use JSON::Fast;
sub json-data {
    from-json q:to/END/;
    [
        {"first-name": "Venus", "last-name": "Grimes", "email": "lectus.rutrum@Duisa.edu", "city": "Ankara"},
        {"first-name": "Fletcher", "last-name": "Owen", "email": "metus@Aenean.org", "city": "Niort"},
        {"first-name": "William", "last-name": "Hale", "email": "eu.dolor@risusodio.edu", "city": "Te Awamutu"},
        {"first-name": "TaShya", "last-name": "Cash", "email": "tincidunt.orci.quis@nuncnullavulputate.co.uk", "city": "Titagarh"},
        {"first-name": "Kevyn", "last-name": "Hoover", "email": "tristique.pellentesque.tellus@Cumsociis.co.uk", "city": "Cuenca"},
        {"first-name": "Jakeem", "last-name": "Walker", "email": "Morbi.vehicula.Pellentesque@faucibusorci.org", "city": "St. Andrä"},
        {"first-name": "Malcolm", "last-name": "Trujillo", "email": "sagittis@velit.edu", "city": "Fort Resolution"},
        {"first-name": "Wynne", "last-name": "Rice", "email": "augue.id@felisorciadipiscing.edu", "city": "Kinross"},
        {"first-name": "Evangeline", "last-name": "Klein", "email": "adipiscing.lobortis@sem.org", "city": "San Giovanni in Galdo"},
        {"first-name": "Jennifer", "last-name": "Russell", "email": "sapien.Aenean.massa@risus.com", "city": "Laives/Leifers"},
        {"first-name": "Rama", "last-name": "Freeman", "email": "Proin@quamPellentesquehabitant.net", "city": "Flin Flon"},
        {"first-name": "Jena", "last-name": "Mathis", "email": "non.cursus.non@Phaselluselit.com", "city": "Fort Simpson"},
        {"first-name": "Alexandra", "last-name": "Maynard", "email": "porta.elit.a@anequeNullam.ca", "city": "Nazilli"},
        {"first-name": "Tallulah", "last-name": "Haley", "email": "ligula@id.net", "city": "Bay Roberts"},
        {"first-name": "Timon", "last-name": "Small", "email": "velit.Quisque.varius@gravidaPraesent.org", "city": "Girona"},
        {"first-name": "Randall", "last-name": "Pena", "email": "facilisis@Donecconsectetuer.edu", "city": "Edam"},
        {"first-name": "Conan", "last-name": "Vaughan", "email": "luctus.sit@Classaptenttaciti.edu", "city": "Nadiad"},
        {"first-name": "Dora", "last-name": "Allen", "email": "est.arcu.ac@Vestibulumante.co.uk", "city": "Renfrew"},
        {"first-name": "Aiko", "last-name": "Little", "email": "quam.dignissim@convallisest.net", "city": "Delitzsch"},
        {"first-name": "Jessamine", "last-name": "Bauer", "email": "taciti.sociosqu@nibhvulputatemauris.co.uk", "city": "Offida"},
        {"first-name": "Gillian", "last-name": "Livingston", "email": "justo@atiaculisquis.com", "city": "Saskatoon"},
        {"first-name": "Laith", "last-name": "Nicholson", "email": "elit.pellentesque.a@diam.org", "city": "Tallahassee"},
        {"first-name": "Paloma", "last-name": "Alston", "email": "cursus@metus.org", "city": "Cache Creek"},
        {"first-name": "Freya", "last-name": "Dunn", "email": "Vestibulum.accumsan@metus.co.uk", "city": "Heist-aan-Zee"},
        {"first-name": "Griffin", "last-name": "Rice", "email": "justo@tortordictumeu.net", "city": "Montpelier"},
        {"first-name": "Catherine", "last-name": "West", "email": "malesuada.augue@elementum.com", "city": "Tarnów"},
        {"first-name": "Jena", "last-name": "Chambers", "email": "erat.Etiam.vestibulum@quamelementumat.net", "city": "Konya"},
        {"first-name": "Neil", "last-name": "Rodriguez", "email": "enim@facilisis.com", "city": "Kraków"},
        {"first-name": "Freya", "last-name": "Charles", "email": "metus@nec.net", "city": "Arzano"},
        {"first-name": "Anastasia", "last-name": "Strong", "email": "sit@vitae.edu", "city": "Polpenazze del Garda"},
        {"first-name": "Bell", "last-name": "Simon", "email": "mollis.nec.cursus@disparturientmontes.ca", "city": "Caxias do Sul"},
        {"first-name": "Minerva", "last-name": "Allison", "email": "Donec@nequeIn.edu", "city": "Rio de Janeiro"},
        {"first-name": "Yoko", "last-name": "Dawson", "email": "neque.sed@semper.net", "city": "Saint-Remy-Geest"},
        {"first-name": "Nadine", "last-name": "Justice", "email": "netus@et.edu", "city": "Calgary"},
        {"first-name": "Hoyt", "last-name": "Rosa", "email": "Nullam.ut.nisi@Aliquam.co.uk", "city": "Mold"},
        {"first-name": "Shafira", "last-name": "Noel", "email": "tincidunt.nunc@non.edu", "city": "Kitzbühel"},
        {"first-name": "Jin", "last-name": "Nunez", "email": "porttitor.tellus.non@venenatisamagna.net", "city": "Dreieich"},
        {"first-name": "Barbara", "last-name": "Gay", "email": "est.congue.a@elit.com", "city": "Overland Park"},
        {"first-name": "Riley", "last-name": "Hammond", "email": "tempor.diam@sodalesnisi.net", "city": "Smoky Lake"},
        {"first-name": "Molly", "last-name": "Fulton", "email": "semper@Naminterdumenim.net", "city": "Montese"},
        {"first-name": "Dexter", "last-name": "Owen", "email": "non.ante@odiosagittissemper.ca", "city": "Bousval"},
        {"first-name": "Kuame", "last-name": "Merritt", "email": "ornare.placerat.orci@nisinibh.ca", "city": "Solingen"},
        {"first-name": "Maggie", "last-name": "Delgado", "email": "Nam.ligula.elit@Cum.org", "city": "Tredegar"},
        {"first-name": "Hanae", "last-name": "Washington", "email": "nec.euismod@adipiscingelit.org", "city": "Amersfoort"},
        {"first-name": "Jonah", "last-name": "Cherry", "email": "ridiculus.mus.Proin@quispede.edu", "city": "Acciano"},
        {"first-name": "Cheyenne", "last-name": "Munoz", "email": "at@molestiesodalesMauris.edu", "city": "Saint-Léonard"},
        {"first-name": "India", "last-name": "Mack", "email": "sem.mollis@Inmi.co.uk", "city": "Maryborough"},
        {"first-name": "Lael", "last-name": "Mcneil", "email": "porttitor@risusDonecegestas.com", "city": "Livorno"},
        {"first-name": "Jillian", "last-name": "Mckay", "email": "vulputate.eu.odio@amagnaLorem.co.uk", "city": "Salvador"},
        {"first-name": "Shaine", "last-name": "Wright", "email": "malesuada@pharetraQuisqueac.org", "city": "Newton Abbot"},
        {"first-name": "Keane", "last-name": "Richmond", "email": "nostra.per.inceptos@euismodurna.org", "city": "Canterano"},
        {"first-name": "Samuel", "last-name": "Davis", "email": "felis@euenim.com", "city": "Peterhead"},
        {"first-name": "Zelenia", "last-name": "Sheppard", "email": "Quisque.nonummy@antelectusconvallis.org", "city": "Motta Visconti"},
        {"first-name": "Giacomo", "last-name": "Cole", "email": "aliquet.libero@urnaUttincidunt.ca", "city": "Donnas"},
        {"first-name": "Mason", "last-name": "Hinton", "email": "est@Nunc.co.uk", "city": "St. Asaph"},
        {"first-name": "Katelyn", "last-name": "Koch", "email": "velit.Aliquam@Suspendisse.edu", "city": "Cleveland"},
        {"first-name": "Olga", "last-name": "Spencer", "email": "faucibus@Praesenteudui.net", "city": "Karapınar"},
        {"first-name": "Erasmus", "last-name": "Strong", "email": "dignissim.lacus@euarcu.net", "city": "Passau"},
        {"first-name": "Regan", "last-name": "Cline", "email": "vitae.erat.vel@lacusEtiambibendum.co.uk", "city": "Pergola"},
        {"first-name": "Stone", "last-name": "Holt", "email": "eget.mollis.lectus@Aeneanegestas.ca", "city": "Houston"},
        {"first-name": "Deanna", "last-name": "Branch", "email": "turpis@estMauris.net", "city": "Olcenengo"},
        {"first-name": "Rana", "last-name": "Green", "email": "metus@conguea.edu", "city": "Onze-Lieve-Vrouw-Lombeek"},
        {"first-name": "Caryn", "last-name": "Henson", "email": "Donec.sollicitudin.adipiscing@sed.net", "city": "Kington"},
        {"first-name": "Clarke", "last-name": "Stein", "email": "nec@mollis.co.uk", "city": "Tenali"},
        {"first-name": "Kelsie", "last-name": "Porter", "email": "Cum@gravidaAliquam.com", "city": "İskenderun"},
        {"first-name": "Cooper", "last-name": "Pugh", "email": "Quisque.ornare.tortor@dictum.co.uk", "city": "Delhi"},
        {"first-name": "Paul", "last-name": "Spencer", "email": "ac@InfaucibusMorbi.com", "city": "Biez"},
        {"first-name": "Cassady", "last-name": "Farrell", "email": "Suspendisse.non@venenatisa.net", "city": "New Maryland"},
        {"first-name": "Sydnee", "last-name": "Velazquez", "email": "mollis@loremfringillaornare.com", "city": "Stroe"},
        {"first-name": "Felix", "last-name": "Boyle", "email": "id.libero.Donec@aauctor.org", "city": "Edinburgh"},
        {"first-name": "Ryder", "last-name": "House", "email": "molestie@natoquepenatibus.org", "city": "Copertino"},
        {"first-name": "Hadley", "last-name": "Holcomb", "email": "penatibus@nisi.ca", "city": "Avadi"},
        {"first-name": "Marsden", "last-name": "Nunez", "email": "Nulla.eget.metus@facilisisvitaeorci.org", "city": "New Galloway"},
        {"first-name": "Alana", "last-name": "Powell", "email": "non.lobortis.quis@interdumfeugiatSed.net", "city": "Pitt Meadows"},
        {"first-name": "Dennis", "last-name": "Wyatt", "email": "Morbi.non@nibhQuisquenonummy.ca", "city": "Wrexham"},
        {"first-name": "Karleigh", "last-name": "Walton", "email": "nascetur.ridiculus@quamdignissimpharetra.com", "city": "Diksmuide"},
        {"first-name": "Brielle", "last-name": "Donovan", "email": "placerat@at.edu", "city": "Kolmont"},
        {"first-name": "Donna", "last-name": "Dickerson", "email": "lacus.pede.sagittis@lacusvestibulum.com", "city": "Vallepietra"},
        {"first-name": "Eagan", "last-name": "Pate", "email": "est.Nunc@cursusNunc.ca", "city": "Durness"},
        {"first-name": "Carlos", "last-name": "Ramsey", "email": "est.ac.facilisis@duinec.co.uk", "city": "Tiruvottiyur"},
        {"first-name": "Regan", "last-name": "Murphy", "email": "lectus.Cum@aptent.com", "city": "Candidoni"},
        {"first-name": "Claudia", "last-name": "Spence", "email": "Nunc.lectus.pede@aceleifend.co.uk", "city": "Augusta"},
        {"first-name": "Genevieve", "last-name": "Parker", "email": "ultrices@inaliquetlobortis.net", "city": "Forbach"},
        {"first-name": "Marshall", "last-name": "Allison", "email": "erat.semper.rutrum@odio.org", "city": "Landau"},
        {"first-name": "Reuben", "last-name": "Davis", "email": "Donec@auctorodio.edu", "city": "Schönebeck"},
        {"first-name": "Ralph", "last-name": "Doyle", "email": "pede.Suspendisse.dui@Curabitur.org", "city": "Linkebeek"},
        {"first-name": "Constance", "last-name": "Gilliam", "email": "mollis@Nulla.edu", "city": "Enterprise"},
        {"first-name": "Serina", "last-name": "Jacobson", "email": "dictum.augue@ipsum.net", "city": "Hérouville-Saint-Clair"},
        {"first-name": "Charity", "last-name": "Byrd", "email": "convallis.ante.lectus@scelerisquemollisPhasellus.co.uk", "city": "Brussegem"},
        {"first-name": "Hyatt", "last-name": "Bird", "email": "enim.Nunc.ut@nonmagnaNam.com", "city": "Gdynia"},
        {"first-name": "Brent", "last-name": "Dunn", "email": "ac.sem@nuncid.com", "city": "Hay-on-Wye"},
        {"first-name": "Casey", "last-name": "Bonner", "email": "id@ornareelitelit.edu", "city": "Kearny"},
        {"first-name": "Hakeem", "last-name": "Gill", "email": "dis@nonummyipsumnon.org", "city": "Portico e San Benedetto"},
        {"first-name": "Stewart", "last-name": "Meadows", "email": "Nunc.pulvinar.arcu@convallisdolorQuisque.net", "city": "Dignano"},
        {"first-name": "Nomlanga", "last-name": "Wooten", "email": "inceptos@turpisegestas.ca", "city": "Troon"},
        {"first-name": "Sebastian", "last-name": "Watts", "email": "Sed.diam.lorem@lorem.co.uk", "city": "Palermo"},
        {"first-name": "Chelsea", "last-name": "Larsen", "email": "ligula@Nam.net", "city": "Poole"},
        {"first-name": "Cameron", "last-name": "Humphrey", "email": "placerat@id.org", "city": "Manfredonia"},
        {"first-name": "Juliet", "last-name": "Bush", "email": "consectetuer.euismod@vitaeeratVivamus.co.uk", "city": "Lavacherie"},
        {"first-name": "Caryn", "last-name": "Hooper", "email": "eu.enim.Etiam@ridiculus.org", "city": "Amelia"}
    ]
    END
}
