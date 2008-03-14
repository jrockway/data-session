package Data::Session;
use Moose;
use MooseX::AttributeHelpers;

has 'data' => (
    metaclass => 'Collection::Hash',
    isa       => 'HashRef',
    default   => sub { +{} },
    provides  => {
        get => 'get',
        set => 'set',
    },
);

1;
