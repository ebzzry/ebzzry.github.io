Conkeror Bookmarks with emem
============================

<div class="center">August 16, 2015</div>
<div class="center">Updated: March 31, 2017</div>

>“Diplomacy is the art of saying ‘Nice doggie’ until you can find a rock.”<br>
>―Will Rogers

I wanted a simple, and easy way to view my bookmarks in [Conkeror](http://conkeror.org). However,
the proposed solutions on the wiki are not suitable for me. So, I rolled my own.


Table of contents
-----------------

- [Prerequisites](#prerequisites)
- [Extract the data](#extract)
- [Generate the bookmarks](#generate)
- [Create a command-line viewer](#cli)
- [Define conkeror commands](#commands)
- [Alternatives](#alternatives)
- [Managing the bookmarks](#managing)
- [Closing remarks](#closing)


<a name="prerequisites"></a> Prerequisites
------------------------------------------

One of the most important tool that you need to have is _sqlite3_. Chances are, your system already
provides a way to install it. To check if you have it, or to verify the installation, run:

```bash
$ sqlite3 --version
```

If it displays a version string, with a build date and hash, then you may continue.

You also need to have a Java Runtime Environment (JRE) installed. To determine if you have it, run:

```bash
$ java -version
```

If it reports a version number and other details, then you have Java installed. Otherwise, consult
your distro’s package system on how to install it.

Lastly, you need to have _emem_ properly installed. Follow the instructions
at <https://github.com/ebzzry/emem>. To verify that you have installed it properly, run:

```bash
$ emem --version
```

If it reports at least **emem-0.2.1**, then you’re good to go.


<a name="extract"></a> Extract the data
---------------------------------------

You need to have a way first to extract the data from the sqlite3 database, which Conkeror uses to
store the bookmarks.

Open your `~/.bashrc`, or whatever init file your shell uses, then append the snippet. Replace
**profile.default** with the correct profile name:

```bash
cob () {
  sqlite3 -separator ' <> ' \
    $HOME/.conkeror.mozdev.org/conkeror/profile.default/places.sqlite \
    'SELECT p.title, p.url FROM moz_bookmarks b INNER JOIN moz_places p \
    ON b.fk = p.id ORDER BY b.id DESC;' | uniq | perl -pe 's/\[//;s/\]//'
}
```

The command above selects the **title** and **url** columns from the **moz_bookmarks** table, then
sorts them by creation date.


<a name="generate"></a> Generate the bookmarks
----------------------------------------------

Next, you need to have a way to generate the HTML file that you’re going to view later in
Conkeror. Add the following to your `~/.bashrc`.

```bash
bmg () {
  local base=$HOME/bookmarks
  local file=$base/bookmarks.html
  trap "rm -f ${file}.tmp" HUP INT TERM ABRT

  [[ ! -d $base ]] && mkdir -p `dirname $file`

  cob | perl -pe 's/^(.*?)\ \<\>\ (.*)/* [\1](\2)/' | emem -T Bookmarks -o ${file}.tmp

  [[ -f ${file}.tmp ]] && mv -f ${file}.tmp $file
}
```

What it does is that it filters the output of **cob**, which _emem_ then uses to generate the HTML
file.


<a name="cli"></a> Create a command-line viewer
-----------------------------------------------

Now that you can build the HTML file, you need to have a command that will load the bookmarks in
Conkeror. Add the following to your `~/.bashrc`.

```bash
bm () {
  conkeror $HOME/bookmarks/bookmarks.html
}
```


<a name="commands"></a> Define conkeror commands
------------------------------------------------

Let’s now create the interactive commands for Conkeror, for generating and viewing the
bookmarks. Open your `~/.conkerorrc` file, then put the following:

```javascript
interactive(
    "b", "Generate the bookmarks file.",
    function (I) {
        var cwd = I.local.cwd;
        yield shell_command("bmg", $cwd = cwd);
    });

interactive(
    "bm", "Open the bookmarks in a new buffer.",
    function (I) {
        var cwd = I.local.cwd;
        yield shell_command("bm", $cwd = cwd);
    });
```

Then, re-read your rc:

```
M-x reinit RET
```

Generate the bookmarks themselves:

```
M-x b RET
```

Finally, view them:

```
M-x bm RET
```


<a name="alternatives"></a> Alternatives
----------------------------------------

I separated the procedure of generating the bookmarks, from viewing it, because I want to be able to
view the bookmarks file quickly, without waiting for the bookmarks to be generated.

You may, however, want to combine the building and viewing of the bookmarks into one. If that is you
want, put the following in your rc:

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


<a name="managing"></a> Managing the boomarks
---------------------------------------------

An easy way to manage the bookmarks is to use
the [SQLite Manager](https://github.com/lazierthanthou/sqlite-manager) extension. This extensions
lets you manage SQLite database inside the browser. By default it lets you open the **.sqlite**
files in your profile directory.

To install it, download the .xpi
file [here](https://github.com/lazierthanthou/sqlite-manager/releases), then follow the installation
instructions [here](http://conkeror.org/Extensions).

Let’s create a Conkeror command that will load the extension. Open your `~/.conkerorrc`, then add
the following:

```
interactive(
    "sqlite", "Open the SQLite Manager",
    function (I) {
        load_url_in_new_buffer("chrome://sqlitemanager/content/sqlitemanager.xul");
    });
    ```

Next, re-load your settings:

```
M-x reinit
```

Then, execute the following to load SQLite Manager:

```
M-x sqlite
```

In the drop-down box that says **(Select Profile Database)**, select **places.sqlite**, then hit
**Go**.

Do not, however, make modifications to any of the SQLite files in your profile, while Conkeror is
running. Doing so may make your browser unable to start, after you exit it, unless you restore from
“clean” SQLite files, while Conkeror is not running.


<a name="closing"></a> Closing remarks
--------------------------------------

The bookmarks displayed in `M-x bm`, will be sorted by time of creation, in a descending order. The
bookmarks listed are also not categorized by “folders”, in the manner of the Firefox’s Bookmarks
Manager.

In addition to SQLite Manager, you may also edit the `places.sqlite` file
with [sqlite3](https://www.sqlite.org/cli.html),
or [sqlitebrowser](https://github.com/sqlitebrowser/sqlitebrowser).
