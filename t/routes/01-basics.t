use v6;

use Test;
plan 9;

use Routes;
ok 1, 'We use Routes and we are still alive';

use Routes::Route;
ok 1, 'We use Routes::Route and we are still alive';

my $r = Routes.new;

dies_ok { $r.add: Routes::Route.new }, 
        '.add adds only complete Route objects';

$r.add: Routes::Route.new( pattern => '', code => { "Krevedko" } );

is $r.dispatch(['']), 
    'Krevedko', 
    "Root pattern [''] works";

ok $r.add( ['foo', 'bar'], { "Yay" } ), 
    '.add(@pattern, $code) -- shortcut for adding a Route object';

nok $r.dispatch(['foo']), 
    'Routes returns False if it can\'t find matched Route and does not have a default';

is $r.dispatch(['foo', 'bar']), 
    "Yay", 
    "Dispatch to Route ['foo', 'bar'])";

$r.default = { "Woow" };

is $r.dispatch(['foo', 'bar', 'baz']), 
    "Woow", 
    'Dispatch to default, when have no matched Route';

is $r.dispatch(['foo', 'bar']),
    'Yay',
    "Dispatch ['foo', 'bar'] again";

# vim:ft=perl6
