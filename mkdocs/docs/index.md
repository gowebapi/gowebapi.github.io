# Welcome to Go Web API

This project is about accessing javascript from Go web assembly. It consists
of a binding generator and generated binding for e.g. DOM, HTML and WebGL.
The source files to binding program is [WebIDL files](file/webidl.md).

## Example code

A simple example can look like this:

```go
package main

import (
    "fmt"

    "github.com/gowebapi/webapi"
    "github.com/gowebapi/webapi/dom/domcore"
    "github.com/gowebapi/webapi/html"
)

func main() {
    // get the element
    element := webapi.GetWindow().Document().GetElementById("myButton")
    // cast it into correct class
    button := html.HTMLButtonElementFromJS(element)
    // change text
    button.SetInnerText("Press me!")

    // register a callback that will display a counter
    count := 1
    callback := domcore.EventHandlerToJS(func(event *domcore.Event) interface{} {
        button.SetInnerText(fmt.Sprint("Count: ", count))
        count++
        return nil
    })
    button.SetOnclick(callback)

    // prevent to program to terminate
    c := make(chan struct{}, 0)
    <-c
}
```

## Status/TODO

Currently the binder can process the DOM and HTML specification and create a compilable output. It's not 100% feature complete as the specifications depends
on other that is currently not processed.

There is also limitation in the Go language, see [overview page](go/overview.md) on how static methods etc is handeled.

API Documentation can be found here: [![GoDoc](https://godoc.org/github.com/gowebapi/webapi?status.svg)](https://godoc.org/github.com/gowebapi/webapi)

The project is currently targeting Go 1.12.

## GitHub repositories

Main repositories is [API bindings](https://github.com/gowebapi/webapi) and
[binder program](https://github.com/gowebapi/webidl-bind).
