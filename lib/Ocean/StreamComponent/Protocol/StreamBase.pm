package Ocean::StreamComponent::Protocol::StreamBase;

use strict;
use warnings;

use parent 'Ocean::StreamComponent::Protocol';

use Ocean::Config;
use Ocean::Error;
use Ocean::Constants::StreamErrorType;
use Ocean::Constants::ProtocolPhase;

sub on_client_received_stream {
    my ($self, $attrs) = @_;

    my $version = $attrs->{version} || '';
    unless ($version eq '1.0') {
        Ocean::Error::ProtocolError->throw(
            type => Ocean::Constants::StreamErrorType::UNSUPPORTED_VERSION);
    }
    my $to = $attrs->{to} || Ocean::Config->instance->get(server => q{domain});
    unless ($to eq Ocean::Config->instance->get(server => q{domain}) ) {
        Ocean::Error::ProtocolError->throw(
            type => Ocean::Constants::StreamErrorType::HOST_UNKNOWN, 
        );
    }

    $self->{_delegate}->on_protocol_open_stream(
        $self->get_features());

    $self->{_delegate}->on_protocol_step(
         $self->get_next_phase());
}

sub get_features {
    my $self = shift;
    Ocean::Error::AbstractMethod->throw(
        message => q{Ocean::StreamComponent::Protocol::StreamBase::get_features}, 
    );
}

sub get_next_phase {
    my $self = shift;
    Ocean::Error::AbstractMethod->throw(
        message => q{Ocean::StreamComponent::Protocol::StreamBase::get_next_phase}, 
    );
}

1;