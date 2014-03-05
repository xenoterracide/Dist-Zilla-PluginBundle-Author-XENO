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
		[ NextRelease => {
			format => '%-9v %{yyyy-MM-dd}d',
		}, ],
		[ MetaNoIndex => {
			file => 'perlcritic.rc',
		}, ],
		[ PruneFiles => {
			filenames => [ qw( dist.ini weaver.ini ) ],
		}, ],
		[ 'Git::NextVersion' => {
			version_regexp => '^(.+)$',
			first_version  => 0.001000,
		}, ],
		[ AutoMetaResources => {
			'homepage' => 'https://metacpan.org/dist/%{dist}',
			'bugtracker.github' => 'user:xenoterracide',
			'repository.github' => 'user:xenoterracide',
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

		CheckChangesHasContent
		Git::Remote::Check
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

=method configure
