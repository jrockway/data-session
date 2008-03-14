use strict;
use warnings;
use Test::Exception;
use Test::More tests => 8;

use ok 'Data::Session';
use ok 'Data::Session::Plugin::Expires';

my $is_expired = 0;

{ no warnings 'redefine';
  *Data::Session::Plugin::Expires::is_expired = sub { $is_expired };
}

my $expires = Moose::Meta::Class->create_anon_class(
    superclasses => ['Data::Session'],
    roles        => ['Data::Session::Plugin::Expires'],
);

my $session = $expires->name->new( expires => time );
isa_ok $session, 'Data::Session';

lives_ok { $session->set( foo => 'bar' ) } 'setting session lives';
lives_ok { is $session->get('foo'), 'bar', 'set/get works' } 'getting from session lives';

$is_expired = 1;

throws_ok { $session->get('foo') } qr/This session has expired/,
  'expired session cannot get';

throws_ok { $session->set( bar => 'baz' ) } qr/This session has expired/,
  'expired session cannot set';

