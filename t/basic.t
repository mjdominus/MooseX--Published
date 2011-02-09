use Demo;
use Test::More;
use Test::Deep;
use strict;
use warnings;

cmp_deeply([Demo->meta->get_all_method_names], superbagof(qw(secret public)));
cmp_deeply([Demo->meta->get_all_published_method_names], ["public"]);

done_testing;


