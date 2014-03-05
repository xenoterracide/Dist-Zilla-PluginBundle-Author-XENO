package Dist::Zilla::PluginBundle::Author::XENO;
use 5.008;
use strict;
use warnings;

# VERSION

use Moose;
with qw(
	Dist::Zilla::Role::PluginBundle::Easy
);

has install => (
	isa     => 'Bool',
	is      => 'ro',
	lazy    => 1,
	default => 1,
);

sub configure {
	my $self = shift;

	my @plugins = (
		[ PruneFiles => {
			filenames => [ qw( dist.ini weaver.ini ) ],
		}, ],
		[ 'Git::NextVersion' => {
			version_regexp => '^(.+)$',
			first_version  => 0.001000,
		}, ], qw(
		AutoPrereqs
		ReadmeFromPod
		OurPkgVersion
		PodWeaver

		MetaProvides::Package
		MetaJSON

		RunExtraTests
		PodCoverageTests
		PodSyntaxTests
		Test::ReportPrereqs
		Test::Compile
		Test::EOL
		Test::Portability
		Test::Perl::Critic

		ContributorsFromGit

		Test::UnusedVars
		Test::CPAN::Meta::JSON
		Test::DistManifest
		Test::Version
		Test::CPAN::Changes
		Test::MinimumVersion

		Git::Remote::Check
		CheckChangesHasContent
	));

	push @plugins, (
		[ 'InstallRelease' => { install_command => "cpanm ." } ],
	) if $self->install;

# must be last
	push @plugins, ('Clean'),

	$self->add_plugins( @plugins );
	return;
}

1;

# ABSTRACT: Author Bundle for Caleb Cushing

=head1 SYNOPSIS

in C<dist.ini>

	[@Author::XENO]
	install = 0 ; optional, disables InstallRelease

=head1 INSTALL

This will get you everything

   cpanm --with-recommends Dist::Zilla::PluginBundle::Author::XENO

=method configure
