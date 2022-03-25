use Mac::Pasteboard;

# save old text, a la vim's savecpo
my $textSave = pbpaste();

# copy selected text
qx(cliclick kd:cmd t:c ku:cmd);
$_ = pbpaste();

# run text through perl one-liner
$output = eval $ARGV[0];

# paste edited text
pbcopy;
qx(cliclick kd:cmd t:v ku:cmd);

# restore old text
pbcopy($textSave);
