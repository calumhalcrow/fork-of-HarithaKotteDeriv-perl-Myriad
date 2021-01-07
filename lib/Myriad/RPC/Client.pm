package Myriad::RPC::Client;

use strict;
use warnings;

# VERSION
# AUTHORITY

no indirect qw(fatal);
use utf8;

=encoding utf8

=head1 NAME

Myriad::RPC::Client - microservice RPC client abstraction

=head1 SYNOPSIS

 my $client = $myriad->rpc_client;

=head1 DESCRIPTION

=cut

use Myriad::Exception::Builder category => 'rpc_client';

=head2 Exceptions

=cut

=head2 RPCFailed

The RPC call has been performed correctly but the results are an error.

=cut

declare_exception RPCFailed => (message => 'Your operation failed');

use Myriad::RPC::Client::Implementation::Redis;

sub new {
    my ($class, %args) = @_;
    my $transport = delete $args{transport};

    # Passing args individually looks tedious but this is to avoid
    # L<IO::Async::Notifier> exception when it doesn't recognize the key.

    if ($transport eq 'redis') {
        return Myriad::RPC::Client::Implementation::Redis->new(
            redis   => $args{redis},
        );
    }
}

1;
