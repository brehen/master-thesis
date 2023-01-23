# Study plan

This document is part of my initial thoughts on writing a Master Thesis at UiO.
Joachim and Michael @ Programming Technology urged me to start writing this
document, so that I can get started with something.

In this document I will attempt to summarise our discussions and try to land a
temporary topic and description for a Master Thesis due the summer of 24.

<!--toc:start-->

- [Motivation](#motivation)
- [Hypothesis](#hypothesis)
- [Research](#research)
- [Perspectivication](#perspectivication)
- [Learning outcome](#learning-outcome)

<!--toc:end-->

## Suggested topics

Modern software systems' business requirements are pushing systems architecture
towards the cloud. It is not uncommon to do so by extending applications'
functionality to include a web-API, and then deploy the server on a virtual
machine (running server editions of e.g Ubuntu or Windows). Then a "frontend"
program is written, often in a different programming language, to call the
application remotely. However, cloud native applications can make radically more
efficient choices in all regards.

The topic of this thesis, is to investigate advanced options for cloud native
web application developers. And could include

1. Investigating languages like Scala or OCaml, that compile to java-script,
   such that the front- and backend programs can be written in the same
   language.
2. Investigate options for writing backend programs as operating systems
   modules, such as MirageOS, where the compiler may specialise the virtual
   machine to be a runtime for the applications' backend.
3. Design a measurement method for comparing historical ways of doing remote
   procedure calls (REST, gRPC, GraphQL, etc.). And use the comparison to try
   and design novel ways of calling procedures remotely.

In either case, leaning from an investigation is all about demonstrating
differences and evaluating them. As a vessel for demonstration, we have bought
`academemes.com`, which will host a social network platform for sharing academic
memes that relate to academic papers. The student is free to suggest features
for the page, that demonstrate their findings.

## Motivation

> If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!
>
> &mdash;
> [_Solomon Hykes, founder of Docker_](https://twitter.com/solomonstre/status/1111004913222324225?lang=en)

## Hypothesis

## Research

> Was this the third point?

## Perspectivication

> Optional

## Learning outcome
