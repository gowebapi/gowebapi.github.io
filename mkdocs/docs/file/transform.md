# Language transformation file

The transformation file are used to fix issues to get a final output that feels more "natrual" than working with raw generated files. Examples:

* Method and constant rename. Go doesn't have support for static methods and constants , javascript does. Any static methods writted outside of the structure and this can leed to name clash if two interfaces define the same static method.
* Enum value rename, e.g. by turning notification api "ltr" to LeftToRight.
* Move interfaces to other packages. DOM and HTML specification have cirular dependency between them, some interfaces/methods need to be moved to get a compilable output.

Current format using MarkDown ending to get some IDE syntax highlightning. With the exception for header tags (##), no other MarkDown synta is supported.

```markdown

# Initail header have no meaning

    Any line starting with tab or spaces is consider to be a comment line

## Foo ("WebIDL type name")

    any line starting with a dot is modificing properties on type it self, e.g. rename the type to Bar

.name = Bar

    any other lines with equal sign is renaming method or attributes to target lanaguage name.
methodName = languageName

    Developers need to invoke SayHelloWorld() in target language to trigger helloWorld() in javascript.
helloWorld = SayHelloWorld

```

## Type modifications

Following properties exist on different types that can be changed:

### Callback

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|

### Dictionary

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|

### Enum

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|
|.prefix|prefix that is added to every enum value|nothing|
|.suffix|suffix that is added to every enum value|enum name|

### Interface

Interfaces have following properites

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|
|.constPrefix|a prefix added to all type constants|empty|
|.constSuffix|a suffix added to all type constants|interface name|
|.constructorName|name of constructor|"New" + instance name|

## Modify multiple types at onces

Any property that under the initail will affect all idl types:

```markdown
# Foo

    all types in foo.idl will get below package

.package = hello/world/foo

## HelloWorld

    with the exception of HelloWorld that is changed to bar

.package = bar

```

Currently only __package__ is supported as file global change.

## Regular Expression

It's possible do a regular expression according to [Go regexp syntax](https://golang.org/pkg/regexp/).

Syntax wise: `@on [interface|enum|callback|dictionary] "expression" : normal command`

Example:

```markdown
# HTML

    all types matching below will be moved to new package

@on "HTML." : .package = github.com/gowebapi/webapi/html

    only moving enums

@on enum ".Event" : .package = github.com/gowebapi/webapi/html/event

    rename method or attribute name on matching interface types

@on interface "Hello." : name = GetHelloName

    ...

```

## Change Type

Sometimes it can be nessary to change the type on attributes. The main reason
is to break up circular dependency between packages. Example:

```markdown
# DOM Standard

.package = github.com/gowebapi/webapi/dom
.title = DOM Standard
.url = <https://dom.spec.whatwg.org/>

## Node

@changetype ownerDocument rawjs
```

It's current only possible to change to __rawjs__ that result in an undecoded __js.Value__.

## Spec File Information

The binding generator have the option to create a [specification status file](../status.md). Information to create that page is based on transformation file
by below property fields that need to be placed in the file header.

|Syntax Name|Description|
|.title|Specification title name|
|.url|Document link|

There is also template support, if a filename is detected with the same
start, but ends with `.tmpl.md`, specification status will replace
`%FULLSTATUS%` and `%SHORTSTATUS%`.
