#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

my $site =
    site :register[Air::Plugin::Hilite.new],
        page main grid :cols(2), :gap(6), [
            hilite :lang('python'), q:to/HILITE/;
                """Python Lark-grammar parser for the invoice DSL. (130 loc)"""

                from dataclasses import dataclass, field
                from lark import Lark, Transformer

                GRAMMAR = r"""
                    start: invoice_line (_NL | field_line | item_line | tax_line)*

                    invoice_line: _WS? "invoice" _WS ID _NL
                    field_line:   _WS? "date"   _WS DATE           _NL
                                | _WS? "client" _WS ESCAPED_STRING  _NL
                    item_line:    _WS? "item" _WS ESCAPED_STRING _WS "hours" \
                                      _WS NUMBER _WS "rate" _WS NUMBER _NL
                    tax_line:     _WS? "tax" _WS PERCENT _NL

                    DATE:    /\d{4}-\d{2}-\d{2}/
                    ID:      /[A-Za-z0-9_-]+/
                    PERCENT: /\d+(\.\d+)?%/
                    _NL:     /[ \t]*\r?\n/
                    _WS:     /[ \t]+/

                    %import common.NUMBER
                    %import common.ESCAPED_STRING
                """


                @dataclass
                class Item:
                    description: str
                    hours: float
                    rate: float

                    @property
                    def subtotal(self):
                        return self.hours * self.rate


                @dataclass
                class Invoice:
                    id: str = ""
                    date: str = ""
                    client: str = ""
                    items: list = field(default_factory=list)
                    tax_rate: float = 0.0

                    @property
                    def subtotal(self):
                        return sum(i.subtotal for i in self.items)

                    @property
                    def tax(self):
                        return self.subtotal * self.tax_rate

                    @property
                    def total(self):
                        return self.subtotal + self.tax


                class InvoiceTransformer(Transformer):
                    def start(self, items):
                        inv = Invoice()
                        for item in items:
                            if isinstance(item, dict):
                                inv.__dict__.update(item)
                            elif isinstance(item, Item):
                                inv.items.append(item)
                        return inv

                    def invoice_line(self, tokens):
                        return {"id": str(tokens[0])}

                    def field_line(self, tokens):
                        # tokens[0] is either DATE or ESCAPED_STRING; infer key from type
                        token = tokens[0]
                        if token.type == "DATE":
                            return {"date": str(token)}
                        else:
                            return {"client": str(token).strip('"')}

                    def item_line(self, tokens):
                        desc = str(tokens[0]).strip('"')
                        hours = float(tokens[1])
                        rate = float(tokens[2])
                        return Item(desc, hours, rate)

                    def tax_line(self, tokens):
                        return {"tax_rate": float(str(tokens[0]).rstrip("%")) / 100}


                _parser = Lark(GRAMMAR, parser="earley", ambiguity="resolve")


                def parse(text: str) -> Invoice:
                    tree = _parser.parse(text.strip() + "\n")
                    return InvoiceTransformer().transform(tree)


                def render(inv: Invoice) -> str:
                    lines = [
                        f"Invoice: {inv.id}",
                        f"Date:    {inv.date}",
                        f"Client:  {inv.client}",
                        "",
                        f"{'Description':<30} {'Hours':>6} {'Rate':>8} {'Subtotal':>10}",
                        "-" * 58,
                    ]
                    for item in inv.items:
                        lines.append(f"{item.description:<30} {item.hours:>6.1f} \
                            {item.rate:>8.2f} {item.subtotal:>10.2f}")
                    lines += [
                        "-" * 58,
                        f"{'Subtotal':>46} {inv.subtotal:>10.2f}",
                        f"{'Tax (' + str(int(inv.tax_rate * 100)) + '%)':>46} {inv.tax:>10.2f}",
                        f"{'Total':>46} {inv.total:>10.2f}",
                    ]
                    return "\n".join(lines)


                EXAMPLE = """\
                invoice INV-001
                  date 2026-04-29
                  client "Acme Corp"

                  item "Website redesign"  hours 10  rate 150
                  item "Hosting setup"     hours 2   rate 100

                  tax 8%
                """

                if __name__ == "__main__":
                    inv = parse(EXAMPLE)
                    print(render(inv))

                HILITE

            hilite q:to/HILITE/;


                #| Raku Grammar parser for the Invoice DSL. (92 loc)

                use Actionable;


                grammar Grammar {
                    token TOP {
                        <invoice-line>
                        [ \n+ <ws> [ <field-line> | <item-line> ] ]*
                        \n*
                    }
                    rule  invoice-line { invoice  <id>                  }
                    rule  field-line   { | date   <date>
                                         | client <client=quoted>
                                         | tax    <tax-rate=number> '%' }
                    rule  item-line    { item     <description=quoted>
                                         hours    <hours=number>
                                         rate     <rate=number>         }
                    token id     { <[A..Za..z0..9_-]>+       }
                    token date   { \d**4 '-' \d**2 '-' \d**2 }
                    token quoted { '"' <( <-["]>+ )> '"'     }
                    token number { \d+ [ '.' \d+ ]?          }
                    token ws { \h* }  #horizontal whitespace only
                }




                class Item does Actionable {
                    has Str  $.description;
                    has Real $.hours;
                    has Real $.rate;
                    method subtotal { $.hours * $.rate }
                }






                class Invoice does Actionable {
                    has Str  $.id       is rw = "";
                    has Str  $.date     is rw = "";
                    has Str  $.client   is rw = "";
                    has Real $.tax-rate is rw = 0.0;
                    has Item @.items;
                    method transform(Str $attr, $raw) {
                        $attr eq 'tax-rate' ?? $raw / 100 !! $raw
                    }
                    method subtotal { [+] @.items.map(*.subtotal) }
                    method tax      { $.subtotal * $.tax-rate }
                    method total    { $.subtotal + $.tax }
                }









                class Actions {
                    method TOP($/) {
                        my $inv = Invoice.action($<head-line>);
                         { $inv.action($_) } for $<info-line>;
                         { $inv.items.push(Item.action($_)) } for $<item-line>;
                        make $inv;
                    }
                }





























                sub parse(Str $text --> Invoice) {
                    Grammar.parse($text, :actions(Actions.new)).made;
                }


                sub render(Invoice $inv --> Str) {
                    my @lines = (
                        "Invoice: {$inv.id}",
                        "Date:    {$inv.date}",
                        "Client:  {$inv.client}",
                        "",
                        sprintf("%-30s %6s %8s %10s", "Description", "Hours", "Rate", "Subtotal"),
                        "-" x 58,
                    );
                    for $inv.items {
                        @lines.append: sprintf("%-30s %6.1f %8.2f %10.2f",
                            .description, .hours, .rate, .subtotal);
                    }
                    my $tax-label = "Tax ({$inv.tax-rate * 100}%)";
                    @lines.append: [
                        "-" x 58,
                        sprintf("%46s %10.2f", "Subtotal",  $inv.subtotal),
                        sprintf("%46s %10.2f", $tax-label,  $inv.tax),
                        sprintf("%46s %10.2f", "Total",     $inv.total),
                    ];
                    @lines.join("\n");
                }


                my $EXAMPLE = q:to/END/;
                invoice INV-001
                  date 2026-04-29
                  client "Acme Corp"

                  item "Website redesign"  hours 10  rate 150
                  item "Hosting setup"     hours 2   rate 100

                  tax 8%
                END

                my $inv = parse($EXAMPLE);
                say render($inv);

                HILITE
            ];

$site.serve;

