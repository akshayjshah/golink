## Go 1.10 Linker Flags

This is a tiny example using Go 1.10's scoped linker flags. Run it like so:

```sh
go get github.com/akshayjshah/golink
cd $GOPATH/src/github.com/akshayjshah/golink
sh demo.sh
```

Setting linker flags with `-ldflags=all="<flags>"` works, but unnecessarily
forces a rebuild of all packages. I'm having trouble scoping the `-ldflags`
argument to the correct package. Any ideas?

## Solved!

This is related to https://github.com/golang/go/issues/24456, which tracks
a regression in the Go tool - as of 1.10.0, it treats `go build github.com/foo/bar/./`
and `go build github.com/foo/bar` differently. The latter fixes the issue above.
