#!/usr/bin/perl

use strict;
use warnings;

 # Create a HelloBot class using Bot::BasicBot as parent.
package HelloBot;
use base qw(Bot::BasicBot);

 # Override BasicBot's connected method.
sub connected {
        my $self = shift;
        $self->say(
                channel => ($self->channels)[0],
                body => "Hello, World!",
        );
        $self->shutdown;
}

 # Main program begins.
package main;

 # Create a HelloBot instance
my $bot = HelloBot->new(
     server      => 'irc.libera.chat',
     port        => '6667',
     channels    => ['#guildvox'],
     nick        => 'HelloBot',
     name        => 'Hello Bot',
     flood       => '1',
);

 # Run the instance we just created.
$bot->run();
