use strict;
use inc::Module::Install;

name('Acme-Mahjong');
all_from('lib/Acme/Mahjong.pm');

requires 'Moose';
requires 'List::Util';

test_requires 'Test::More';
test_requires 'Test::UseAllModules';

auto_include;
WriteAll;