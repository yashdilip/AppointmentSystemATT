#!"C:\xampp\perl\bin\perl.exe"
print "Content-type : text/html\n\n";
package appointmentsys;
use DBI;
use strict;
use CGI;

require "config.pl";

#DATABASE CONNECTION
#"DBI:mysql:appointmentdb:localhost","root","root"

my $dbh = DBI-> connect(get_dsn(), get_username(), get_password(), { RaiseError => 1 }) or die "DBI::errstr: $DBI::errstr";

my $cgi = CGI ->new;

#FORM INPUT PARAMETERS FOR NEW APPOINTMENT
my $appointmentDate = $cgi->param('appointmentDate');
my $appointmentTime = $cgi->param('appointmentTime');
my $appointmentDescription = $cgi->param('appointmentDescription');

#INSERT DATA
my $str = $dbh->prepare("insert into appointment(date_time, description) values (?,?);");

#EXECUTE STATEMENT
$str->execute( $appointmentDate . " " . $appointmentTime, $appointmentDescription ) or die $DBI::errstr;

#DISCONNECT DB
$dbh->disconnect();

#RE-DIRECT ON SUBMIT DATA
my $url = "http://localhost/AppointmentSystemATT/appointment.html";
my $t = 1;
print "<META HTTP-EQUIV=refresh CONTENT=\"$t;URL=$url\">\n";
