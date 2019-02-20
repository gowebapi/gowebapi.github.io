# Go Web Assembly target

The output should be considers as helping libraries to _syscall/js_ than a standalone library. For some types, e.g. _any_ is converted into _js.Value_. For
other types, most of them implement js.Wrapper.

## Status/TODO

* Method/Enum rename - transformation support to get a better API.
* Union support are missing as methods depending of this is not easy to use.
