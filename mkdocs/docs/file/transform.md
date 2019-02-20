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

## Callback

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|

## Dictionary

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|

## Enum

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|
|.prefix|prefix that is added to every enum value|nothing|
|.suffix|suffix that is added to every enum value|enum name|

## Interface

Interfaces have following properites

|Syntax Name|Description|Default|
|-----------|-----------|-------|
|.package|package name|first part of the input file|
|.name|type output name|idl type name in public access format|
|.constPrefix|a prefix added to all type constants|empty|
|.constSuffix|a suffix added to all type constants|interface name|
|.constructorName|name of constructor|"New" + instance name|
