
package Demo;
use Moose;
use MooseX::Publish;

sub secret { "secret" }
publish public => sub { "public" };

no Moose;
1;

