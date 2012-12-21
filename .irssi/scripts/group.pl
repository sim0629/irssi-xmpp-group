use Irssi;
use Time::HiRes;

sub short_nick {
    my ($nick) = @_;
    my ($id, $domain) = split /@/, $nick, 2;
    return $id;
}

my @users;

sub message_private {
    my ($server, $msg, $raw_nick, $address) = @_;
    my ($nick) = split /\//, $raw_nick, 2;
    if(!(grep {$_ eq $nick} @users)) {
        push @users, $nick;
        #$server->command("MSG $nick <users> @users");
    }
    my @lines = split /\n/, $msg;
    my $name = short_nick $nick;
    foreach my $line (@lines) {
        foreach my $user (@users) {
            $server->command("MSG $user $name: $line") if($user ne $nick);
        }
        Time::HiRes::sleep(0.1);
    }
}

Irssi::signal_add("message private", "message_private");

