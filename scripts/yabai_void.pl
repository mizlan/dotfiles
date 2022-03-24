use feature 'say';
use strict;
use warnings;

my $skhd_path = "$ENV{HOME}/.config/skhd/skhdrc";

open(SKHD, '<', $skhd_path) or die $!;

my $skhd_text  = join "", <SKHD>;

my %keybind_hash = (
  Chromium => q(cmd + shift - return),
  Messenger => q(cmd + shift - m),
  kitty => q(cmd + shift - e),
  Discord => q(cmd + shift - d),
);

my @data = qx(yabai -m query --windows | jq '.[] | [.id, .app, .space] | join (" ")');

my @add_lines;

for (@data) {
  /^"(\d+) (.+) (\d+)"$/;

  if (my $keybind = $keybind_hash{$2}) {
    push @add_lines, "$keybind : yabai -m space --focus $3; yabai -m window --focus $1";
    delete($keybind_hash{$2});
  }
}

my $add_text = join "\n", @add_lines;

$skhd_text =~ s/^(# speed-dial.*?\n).*/$1$add_text/ms;

open(SKHD, '>', $skhd_path) or die $!;
say SKHD $skhd_text
