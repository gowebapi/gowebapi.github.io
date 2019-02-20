# WebIDL

> WebIDL specification can be found at <https://heycam.github.io/webidl/>

## Global scope

The specification files doesn't containts browsers global varibale scope, e.g. access to _window_. This can be defined with a special annotation _OnGlobalScope_ on a interface be able to define this methods and attributes. Please note that all attributes and methods need to be defined static to get correctly compilable code.

```webidl
[OnGlobalScope]
interface GlobalScope {
    // access to javascript document variable.
    static readonly attribute Document document;
    // access to javascript window variable.
    static readonly attribute Window window;
};
```

> Note: in the above example, to generator will create a function named Document() to get the document attribute. This will name clash with the interface Document. This is fixed by the language transformation file that is renaming the attribute in the final lanaguage.
