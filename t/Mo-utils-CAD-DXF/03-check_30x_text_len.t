use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean err_msg_hr);
use Mo::utils::CAD::DXF qw(check_30x_text_len);
use Test::More 'tests' => 11;
use Test::NoWarnings;

# Test.
my $self = {
	'key' => 'foo',
};
my $ret = check_30x_text_len($self, 'key', 3);
is($ret, undef, 'Right bytes length is present (expected 3, real 3).');

# Test.
$self = {
	'key' => 'foo',
};
$ret = check_30x_text_len($self, 'key', 10);
is($ret, undef, 'Right bytes length is present (ascii, expected 10, real 3).');

# Test.
$self = {
	'key' => 'foo',
};
$ret = check_30x_text_len($self, 'key', 3);
is($ret, undef, 'Right bytes length is present (ascii, expected 3, real 3).');

# Test.
$self = {
	'key' => 'fo\U+00E9',
};
$ret = check_30x_text_len($self, 'key', 3);
is($ret, undef, 'Right bytes length is present (unicode, expected 3, real 3).');

# Test.
$self = {};
$ret = check_30x_text_len($self, 'key');
is($ret, undef, "Right, key doesn't exists.");

# Test.
$self = {
	'key' => undef,
};
$ret = check_30x_text_len($self, 'key');
is($ret, undef, "Value is undefined, that's ok.");

# Test.
$self = {
	'key' => 'fo\U+00E9',
};
eval {
	check_30x_text_len($self, 'key', 2);
};
is($EVAL_ERROR, "Parameter 'key' has bad length.\n",
	"Parameter 'key' has bad length (fo\\U+00E9, 2 characters).");
my $err_msg_hr = err_msg_hr();
is($err_msg_hr->{'Expected bytes length'}, 2, 'Test error parameter (Expected bytes length: 2).');
is($err_msg_hr->{'Real bytes length'}, 3, "Test error parameter (Real bytes length: 3).");
is($err_msg_hr->{'Value'}, 'fo\U+00E9', "Test error parameter (Value: fo\\U+00E9).");
clean();
