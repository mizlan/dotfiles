$url = $ARGV[0] or die "need url";

($user, $repo, $branch, $path) = $url =~ m#github.com/(.+?)/(.+?)/blob/(.+?)/(.+)#;

$raw = "https://raw.githubusercontent.com/$user/$repo/$branch/$path";

print $raw,$/;
($scriptname) = $path =~ m#([^/]+)$#;

`curl $raw > ~/.irssi/scripts/$scriptname`
