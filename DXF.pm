package Mo::utils::CAD::DXF;

use base qw(Exporter);
use strict;
use warnings;

use Error::Pure qw(err);
use Readonly;

Readonly::Array our @EXPORT_OK => qw(check_30x_text_len);

our $VERSION = 0.01;

sub check_30x_text_len {
	my ($self, $key, $length) = @_;

	_check_key($self, $key) && return;

	my $value = $self->{$key};
	$value =~ s/\\U\+([0-9A-Fa-f]+)/chr(hex($1))/eg;
	if (length($value) > $length) {
		err "Parameter '".$key."' has bad length.",
			'Value', $self->{$key},
			'Expected bytes length', $length,
			'Real bytes length', length($value),
		;
	}

	return;
}

sub _check_key {
	my ($self, $key) = @_;

	if (! exists $self->{$key} || ! defined $self->{$key}) {
		return 1;
	}

	return 0;
}

1;

__END__
