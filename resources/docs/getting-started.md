# Getting started

> **NOTE:** Silvermoon is in active development, you may experience bugs, rough edges and major API changes between versions

## What is Silvermoon

Silvermoon is a HTML preprocessor with power of Lua embeded into it. That means you can
easily create dynamic web pages with simple lua-in-html scripts.

<br />

Meanwhile Silvermoon aims to have the most HTML compatability as possible, it still might fail to parse HTML if you feed it very malformed HTML.

<br />

It supports:

- Web servers with FastCGI support
- LuaRocks packages
- Standalone Lua files

This documentation assumes you have following knowledge:

- Website basics (HTML,CSS and JS) skills
- Moderate Lua programming skills

## Installation {#Install}

### Precompiled binaries

Visit [GitHub releases page](https://github.com/IEatUranium238/silvermoon/releases) to download the binary.

> **NOTE:** Currently compiled binaries are only avaible for Linux (x86_64 64 bit systems)

### Compiling it yourself

<br />

**You will need:**

<br />

**Tools:**

- Compiler that supports c++ 23 or later
- CMake

**Libraries:**

- pugixml
- luajit
- libfcgi

**After installing needed tools and libraries run following:**

```bash
cmake -S . -B build
cmake --build build --config Release
```

If everything goes smoothly you will see a silvermoon binary in build folder.

## Binary set up

After either downloading the binary or compiling its recommended to move it to a folder on your OS's PATH

<br />

To test it, try running it you should see following:

```text
FastCGI server started on port 9000
```

It means that silvermoon has started and is ready to preprocess html files via FastCGI requests on port 9000

## Server set up

For this section we will use Apache web server as example.

For other servers see their documentation on connecting FastCGI applications.

> **NOTE:** You will need to enable `mod_proxy_fcgi` module on Apache for this to work

### Set up with TCP

Include following in your apache config such as 000-default.conf:

```text
# Fix mime type problems
RemoveType .sm
AddType text/html .sm

# Set main file
DirectoryIndex index.sm

<Directory /var/www/html>
  Require all granted
  AllowOverride All

  # Handle files
  <FilesMatch "\.sm$">
    SetHandler "proxy:fcgi://127.0.0.1:9000"
  </FilesMatch>
</Directory>
```

> **NOTE:** change var/www/html to your web root if different!

### Using UNIX sockets

To use UNIX sockets with Silvermoon set up following:

1. Set `SM_USE_UNIXSOCKS` env variable to "true" (A string, not a boolean)
2. For previous config change SetHandler to

```text
SetHandler "unix:/var/run/silvermoon_fcgi.sock"
```

## Setting up as service

**Linux (systemd):**

<br />

Create following file at `/etc/systemd/system/silvermoon.service`:

```ini
[Unit]
Description=Silvermoon HTML preprocessor
After=network.target

[Service]
Type=simple
User=nobody # Replace with your user
WorkingDirectory=/usr/local/bin # Change to sm's binary parent folder if needed
ExecStart=/usr/local/bin/silvermoon # Change to sm's binary name if needed
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```
> **NOTE:** Remove comments before running the service!

> **NOTE:** Adjust User, WorkingDirectory, and ExecStart to match your setup.

To run, execute following:

```bash
sudo systemctl enable silvermoon
sudo systemctl start silvermoon
```

<br />

**Windows (powershell):**

```pwsh
New-Service -Name "Silvermoon HTML preprocessor" -BinaryPathName "C:\Path\to\silvermoon" -StartupType Automatic
```

> **NOTE:** Change "C:\Path\to\silvermoon" to your Silvermoon's binary path

## What's next?

- [Write your first silvermoon web page](/docs/first-steps)

- [Lua API referance](/docs/api)
