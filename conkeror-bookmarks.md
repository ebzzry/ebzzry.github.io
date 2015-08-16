Conkeror's Bookmarks
======================================================================

<center>2015-08-16 01:14:09</center>

I wanted a simple, and easy way to view my bookmarks in
[Conkeror](http://conkeror.org). However, the proposed solutions on
the wiki are not suitable for me. So, I rolled my own.


## Prerequisites

One of the most important tool that you need to have is the _sqlite3_
command. Chances are, your system provides a way to install it. To
check if you have it, or to verify the installation, run:

```bash
$ sqlite3 --version
```

If it displays a version string, with a build date and hash, then
you're set.

You also need to have a Java Runtime Environment (JRE) installed. To
determine if you have it, run:

```bash
$ java -version
```

If it reports a version number and other details, then you have Java
installed. Otherwise, consult your distro's package system on how to
install it.

Lastly, you need to have _emem_ properly installed. Follow the
instructions at <https://github.com/ebzzry/emem>. To verify that you
have installed it properly, run:

```bash
$ emem --version
```

If it reports at least `emem-0.2.1`, then you're good to go.


## Extract the Data

You need to have a way first to extract the data from a sqlite3
database, which Conkeror uses to store the bookmarks, among other
things. Open your `~/.bashrc`, or whatever your shell uses, then
append the following text. Replacing `profile.default` with the
correct profile name:

```bash
cob () {
  sqlite3 \
  $HOME/.conkeror.mozdev.org/conkeror/profile.default/places.sqlite \
  'SELECT p.title, p.url FROM moz_bookmarks b INNER JOIN moz_places p \
  ON b.fk = p.id ORDER BY b.id DESC;' | uniq
}
```

The command above selects the `title` and `url` columns from the
`moz_bookmarks` table, then sorts them by creation date.


## Generate the Bookmarks

Next, you need to have a way to generate the HTML file that
you're going to view later in Conkeror:

```bash
bmg () {
  local file=$HOME/bookmarks/bookmarks.html
  trap "rm -f ${file}.tmp" HUP INT TERM ABRT
  [[ ! -d $base ]] && mkdir -p `dirname $file`

  cob | perl -pe 's/^(.*?)\|(.*)/* [\1](\2)/' \
      | emem -T Bookmarks -o ${file}.tmp

  [[ -f ${file}.tmp ]] && mv -f ${file}.tmp $file
}
```

What it does is that it filters the output of `cob`, which `emem` then
uses to generate the HTML file.


## Create a CLI Viewer

Now that you can build the HTML file, you need to have a command that
will load the bookmarks in Conkeror:

```bash
bm () {
  conkeror $HOME/bookmarks/bookmarks.html
}
```

## Conkeror Commands

Let's now create interactive commands for Conkeror, for generating and
viewing the bookmarks:

```javascript
interactive(
    "bmg",
    "Generate the bookmarks file.",
    function (I) {
        var cwd = I.local.cwd;
        yield shell_command("bmg", $cwd = cwd);
    });

interactive(
    "bm",
    "Open the bookmarks in a new buffer.",
    function (I) {
        var cwd = I.local.cwd;
        yield shell_command("bm", $cwd = cwd);
    });
```

Re-read your rc:

```
M-x reinit RET
```

Finally, generate the bookmarks then view it:

```
M-x bmg RET
```

```
M-x bm RET
```


## Alternatives

I separated the procedure of generating the bookmarks, from viewing
it, because I want to be able to view the bookmarks file quickly,
without waiting for the bookmarks to be generated.

You may, however, want to combine the building and viewing of the
bookmarks into one. If that is you want, put the following in your
rc:

```
interactive(
    "bm",
    "Generate the bookmarks file, and open it in a new buffer.",
    function (I) {
        var cwd = I.local.cwd;
        yield shell_command("bmg; bm", $cwd = cwd);
    });
```

Invoke it with:

```
M-x bm RET
```

## Conclusion

The bookmarks displayed will be sorted by time of creation, in a
descending order.

There are caveats to this method, and one of them is that this is
strictly a viewer. If you want to edit your bookmarks, you may copy
the `places.sqlite` file to a Firefox profile, and use its built-in
Bookmarks Manager to edit it. You may also edit the file directly with
_sqlite3_, or _sqlitebrowser_ .
