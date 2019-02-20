# File overview

The hardest part is not to write a WebIDL from a specification, but keeping it up to date. The philosophy is extract webidl from a third source, e.g. by taking all IDL part from the DOM specification (<https://dom.spec.whatwg.org)> and having all the modifications in other files.

The program need following input files:

* foo.idl - Main WebIDL file, a "1:1" copy of the specification.
* foo.addition.idl - Extra types and oddity that exist in the specification. E.g. the SVG IDL are refering to DOMRect that doesn't exist anywhere.
* foo.go.md - Language transformation file. To modify incoming WebIDL and turning it into something thats look like a "standard library"
* foo.doc.md - (Planned) API documentation file
