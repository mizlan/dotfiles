use Mac::Pasteboard;
use Cwd 'abs_path';

# save old text, a la vim's savecpo
my $textSave = pbpaste();

# run text through perl one-liner
$s = <STDIN>;
exit unless $s;
my ($file, $pg, $text) = $s =~ /(.*):Page (\d+): (.*)/;
$file = abs_path $file;

# paste edited text
pbcopy($text);
qx(psg $file $pg);
qx(cliclick kd:cmd t:fv ku:cmd kp:enter);

# restore old text
pbcopy($textSave);
qx(sleep 1);
qx(cliclick kp:esc);
