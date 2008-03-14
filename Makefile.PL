use inc::Module::Install;

name 'Data-Session';
all_from 'lib/Data/Session.pm';

build_requires 'Test::More';
build_requires 'ok';

WriteAll();
