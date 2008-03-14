use inc::Module::Install;

name 'Data-Session';
all_from 'lib/Data/Session.pm';

requires 'DateTime';
requires 'Moose';
requires 'MooseX::AttributeHelpers';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
