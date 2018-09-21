Microservices Factorial
=======================

A "Web Scale" implementation of the well known "factorial" function from "Mathematics".

A cluster of microservices in various languages - each implementation follows this algorithm:

```
* Receive a number as input
* If the number is less than two, return one
* Otherwise, call `http://factorial.apps.internal:8080/` providing one subtracted from the input
* Return the input multiplied by the number in the response
```

The result is a highly performant and resilient mathematical primitive.

