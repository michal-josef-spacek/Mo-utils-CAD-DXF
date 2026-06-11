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

=pod

=encoding utf8

=head1 NAME

Mo::utils::CAD::DXF - Mo utilities for CAD::DXF data.

=head1 SYNOPSIS

 use Mo::utils::CAD::DXF qw(check_30x_text_len);

 check_30x_text_len($self, $key, $length);

=head1 DESCRIPTION

Mo utilities for checking text values for DXF group codes 300-309.

=head1 SUBROUTINES

=head2 C<check_30x_text_len>

 check_30x_text_len($self, $key, $length);

Check parameter defined by C<$key> for maximum text length in DXF group codes
300-309. Escaped unicode sequences like C<\U+00E9> are counted as characters.

Put error if check isn't ok.

Returns undef.

=head1 ERRORS

 check_30x_text_len():
         Parameter '%s' has bad length.
                 Value: %s
                 Expected bytes length: %s
                 Real bytes length: %s

=head1 EXAMPLES

=head2 EXAMPLE1

=for comment filename=check_30x_text_len_ok.pl

 use strict;
 use warnings;

 use Mo::utils::CAD::DXF qw(check_30x_text_len);

 my $self = {
         'key' => 'fo\U+00E9',
 };
 check_30x_text_len($self, 'key', 3);

 # Print out.
 print "ok\n";

 # Output:
 # ok

=head2 EXAMPLE2

=for comment filename=check_30x_text_len_fail.pl

 use strict;
 use warnings;

 use Error::Pure;
 use Mo::utils::CAD::DXF qw(check_30x_text_len);

 $Error::Pure::TYPE = 'Error';

 my $self = {
         'key' => 'fo\U+00E9',
 };
 check_30x_text_len($self, 'key', 2);

 # Print out.
 print "ok\n";

 # Output like:
 # #Error [..DXF.pm:?] Parameter 'key' has bad length.

=head1 DEPENDENCIES

L<Exporter>,
L<Error::Pure>,
L<Readonly>.

=head1 SEE ALSO

=over

=item L<Mo>

Micro Objects. Mo is less.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Mo-utils-CAD-DXF>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2026 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
