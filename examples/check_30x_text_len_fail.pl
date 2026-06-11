#!/usr/bin/env perl

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