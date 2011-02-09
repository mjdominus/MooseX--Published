use Demo;
use Test::More;
use Test::Deep;
use strict;
use warnings;

cmp_deeply([Demo->meta->get_all_method_names], superbagof(qw(secret public)));
cmp_deeply([Demo->meta->get_all_published_method_names], ["public"]);
is(Demo->secret, "secret");
is(Demo->public, "public");
ok(  Demo->meta->find_method_by_name("public")->is_published);
ok(! Demo->meta->find_method_by_name("secret")->is_published);

done_testing;


