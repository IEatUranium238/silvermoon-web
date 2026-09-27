# Configuration and security

## Configuration

Silvermoon allows you to configure it via env variables.

- `SM_USE_UNIXSOCKS` - Use UNIX sockets to connect to FastCGI server
- `SM_SOCK_GROUP` - The group to give socket permisions

## Security

By default Silvermoon blocks usage of all these APIs:

- os.exit
- collectgarbage
- io.open
- os.remove
- os.rename
- load
- loadstring
- dofile
- loadfile
- os.execute
- io.popen

But some of these APIs may be needed in applications, so we allow you to re-enable them via env variables.

<br />

`SM_ENABLE_RISKY_OPEN="true"` - Unblocks:

- io.open

`SM_ENABLE_VERY_RISKY_ADVANCED_FS="true"` - Unblocks:

- os.remove
- os.rename

`SM_ENABLE_RISKY_CODELOADING="true"` - Unblocks:

- load
- loadstring
- dofile
- loadfile

`SM_ENABLE_VERY_RISKY_SHELL="true"` - Unblocks:

- os.execute
- io.popen

It's a good practice not to enable these unless your app needs them. Otherwise leave them disabled.

<br />

Also, if you need to enable them, make sure you don't take untrusted user input into them. Unless you are sure you have validated and cleanded it.

## Whats next?

- [Lua API referance](/docs/api)
