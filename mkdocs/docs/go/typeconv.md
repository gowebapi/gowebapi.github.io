# Type conversion

The following will be applied to different WebIDL types:

## any

Any type is currently handled converted into a _js.Value_.

## callback

A function is generated with conversion method.

> TODO: Move conversion Go->WASM from implementation to public method.

```webidl
callback Foo = void (int a, int b);
```

```golang
// FooFromJS is converted a returned js.Value into a function that can be invoked.
func FooFromJS(_value js.Value) FunctionStringCallback {
```

## callback interface

An interface that the developer should implement to get callback from javscript. There is a `NewFoo()` that is used to allocate a javascript
object that can be used to get callbacks. The function is retuning an instance of
type `FooValue` that holds the reference to underlaying javascript object.
On that instance there is also a `Release()` method that need to be invoked when
the callback is no longer needed.

If the interface is only having a single method, there will also a `NewFooFunc` method that is taking a function as input and will allocate corresponding javascript object. There is a generator option that let `NewFooFunc` a javascript function instead of an object.

```webidl
callback interface Foo {
    void bar();
};
```

## dictionary

Will generate a structure with corresponding field. When convered to/from _js.Value_, values are copied into a new javascript object.

> TODO: required values

## enum

A WebIDL enum is transformed into a Go enum.

Input

```webidl

enum Foo {
    "hello",
    "world"
};
```

Will be turned into following:

```golang
type Foo int

const (
    Hello Foo = iota
    World
)

```

## interface

The most used type in WebIDL. Generate a struct.

|Annotation   |Desciption|
|-------------|----------|
|NoGlobalScope|Generate an interface without a struct|

### constant

Any constants are converted into a Go _const_ value.

### attribute

For every attribute, a get and set method is generated. For read only attributes only a getter is created.

```webidl
interface Foo {
    attribute int bar;
};
```

### method

A Go method or function is created for every method, depending if it's static or not. The method is trying to take care most of the conversion code.

```webidl
interface Foo {
    int bar(int a, int b);
};
```

## sequence

For types that can be used as a _js.TypeArray_, a _js.Value_ is used as method input type. Other sequence types are converted part of method invoke.

## union

WebIDL keyword _or_ can be used to define multiple input or output values that can be returned. It's like a very limitied _any_ type.

> TODO: unions are currently completey unusable. Any method or attribute that is depending on this union get a reference to an empty interface.

Example:

```webidl
typedef (DOMString or Function) TimerHandler;
```
