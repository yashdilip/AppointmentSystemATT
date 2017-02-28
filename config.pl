#!"C:\xampp\perl\bin\perl.exe"
print "Content-type : text/html\n\n";

package appointmentsys;
#MySQL Database Configuration

my $dsn = "DBI:mysql:appointmentdb:localhost";
my $username = "root";
my $password = "root";

sub get_dsn {
	return $dsn;
};
sub get_username {
	return $username;
};
sub get_password {
	return $password;
};