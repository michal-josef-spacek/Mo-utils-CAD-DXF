#!/usr/bin/env perl

use strict;
use warnings;

use Mo::utils::CAD::DXF qw(check_30x_text_length);

my $self = {
        'key' => 'fo\U+00E9',
};
check_30x_text_length($self, 'key', 3);

# Print out.
print "ok\n";

# Output:
# ok