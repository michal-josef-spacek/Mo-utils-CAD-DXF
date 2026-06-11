use strict;
use warnings;

use Mo::utils::CAD::DXF;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Mo::utils::CAD::DXF::VERSION, 0.01, 'Version.');
