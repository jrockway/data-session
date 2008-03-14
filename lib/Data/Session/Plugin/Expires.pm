package Data::Session::Plugin::Expires;
use Moose::Role;
use Moose::Util::TypeConstraints;
use DateTime;

requires 'get';
requires 'set';

subtype 'DateTime'
  => from 'Ref',
  => where { $_->isa('DateTime') };

coerce 'DateTime'
  => from 'Int'
  => via { DateTime->from_epoch( epoch => $_ ) };

has 'expires' => (
    is       => 'rw',
    isa      => 'DateTime',
    coerce   => 1,
    required => 1,
);

sub is_expired {
    my $self = shift;
    return 1 if DateTime->now > $self->expires;
    return;
}

before qw/get set/ => sub {
    my $self = shift;
    confess 'This session has expired' if $self->is_expired;
};

1;
