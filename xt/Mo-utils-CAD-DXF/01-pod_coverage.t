use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('Mo::utils::CAD::DXF', 'Mo::utils::CAD::DXF is covered.');
