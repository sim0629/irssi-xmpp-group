use Irssi;

sub short_nick {
    my ($nick) = @_;
    my ($id, $domain) = split /@/, $nick, 2;
    return $id;
}

my @users;

sub message_private {
    my ($server, $msg, $nick, $address) = @_;
    if(!(grep {$_ eq $nick} @users)) {
        push @users, $nick;
        #$server->command("MSG $nick <users> @users");
    }
    foreach my $user (@users) {
        $server->command("MSG $user <".(short_nick $nick)."> $msg") if($user ne $nick);
    }
}

Irssi::signal_add( "message private", "message_private" );

