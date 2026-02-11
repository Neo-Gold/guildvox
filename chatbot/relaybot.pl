#!/usr/bin/perl

use strict;
use warnings;

 # Configure the bots.
my $botnick_1 = "Guildvox-Sophie";
my $server_1 = "irc.libera.chat";
my $port_1 = "6667";
my $channel_1 = "#guildvox";
 # Turn ssl support off.
my $ssl_1 = "0";

my $botnick_2 = "Diana";
my $server_2 = "192.168.1.84";
my $port_2 = "6667";
my $channel_2 = "#guildvox";
 # Turn ssl support on. POE::Component::SSLify required.
my $ssl_2 = "0";

 # Create a RelayBot class using Bot::BasicBot as parent.
package RelayBot;
use base qw(Bot::BasicBot);

 # Override BasicBot's said method.
sub said {
        my ($self, $message) = @_;
 # This "if" is necessary for forwarding addressed messages in full.
         $message->{body} = "$message->{address}: ".
         "$message->{body}" if $message->{address};
         $self->altbot->relay($message);
}

 # Custom methods we create just for RelayBot.
sub altbot {
        my $self = shift();
        return ${$self->{alt_bot}};
}

sub relay {
        my ($self, $message) = @_;
 # This "if" prevents the bot from relaying private messages.
        if ( $message->{channel} eq ($self->altbot->channels)[0] ) {
                 $message->{channel} = ($self->channels)[0];
                 $message->{body} = $message->{who}.
                 " said: ".$message->{body};
                 $self->say(
                         channel => ($self->channels)[0],
                         body => $message->{body}
                 );
         }
}

 # Main program begins
package main;
use POE;

 # Create RelayBot objects.
my ($bot_1, $bot_2);

$bot_1 = RelayBot->new(
        server => "$server_1",
        port => "$port_1",
        channels => ["$channel_1"],
        nick => "$botnick_1",
        username => "$botnick_1",
        name => "$botnick_1",
        alt_bot => \$bot_2,
        ssl => "$ssl_1",
        no_run => 1,
);

$bot_2 = RelayBot->new(
         server => "$server_2",
         port => "$port_2",
         channels => ["$channel_2"],
         nick => "$botnick_2",
         username => "$botnick_2",
         name => "$botnick_2",
         alt_bot => \$bot_1,
         ssl => "$ssl_2",
         no_run => 1,
);

 # Launch RelayBot objects and connect.
$bot_1->run();
$bot_2->run();
$poe_kernel->run();
