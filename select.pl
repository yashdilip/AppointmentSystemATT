#!"C:\xampp\perl\bin\perl.exe"
print "Content-type : text/html\n\n";

package appointmentsys;
use strict;
use DBI;
use JSON;

require "config.pl";

#DATABASE CONNECTION
my $dbh = DBI-> connect(get_dsn(), get_username(), get_password() ,{ RaiseError => 1 }) or die "DBI::errstr: $DBI::errstr";

#SELECT
my $query=qq(select date_time,description from appointment);
my $query_handle = $dbh->prepare($query);

#EXECUTE
$query_handle->execute() or die $DBI::errstr;

my @result;

while ( my $row = $query_handle->fetchrow_hashref ){
    push @result, $row;
}

#DATABASE DISCONNECT
$dbh->disconnect();

#TO JSON
print to_json(\@result);