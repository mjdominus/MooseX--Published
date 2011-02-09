
package MooseX::Publish;
use Moose ();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
      with_meta => [ qw(publish) ],
      class_metaroles => { class => [qw(MooseX::Publish::CanQueryPublished)],
                           method => [ qw(MooseX::Publish::Published) ] },
);

sub publish {
  my ($meta, $name, $code) = @_;

  my $method = $meta->method_metaclass->wrap(
    $code,
    name => $name,
    package_name => $meta->name,
  );

  $method->is_published(1);
  $meta->add_method($name, $method);
}

{
  package MooseX::Publish::CanQueryPublished;
  use Moose::Role;
  use Moose::Util ();

  sub get_all_published_method_names {
    my ($meta) = @_;
    return map $_->name, $meta->get_all_published_methods;
  }

  sub get_all_published_methods {
    my ($meta) = @_;
    return grep Moose::Util::does_role($_, "MooseX::Publish::Published")
      && $_->is_published,
        $meta->get_all_methods;
  }
}

{
  package MooseX::Publish::Published;
  use Moose::Role;

  has is_published => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
   );
}

1;
