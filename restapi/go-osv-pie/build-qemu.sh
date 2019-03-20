go build -buildmode=pie -o rest
strip rest
capstan package compose -v go-osv-pie
