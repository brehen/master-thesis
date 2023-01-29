# Master thesis project description

This document is part of my initial thoughts on writing a Master Thesis at UiO.
Joachim and Michael @ Programming Technology urged me to start writing this
document, so that I can get started with something.

In this document I will attempt to summarise our discussions and try to land a
topic and project description for a Master Thesis due the summer of '24.

<!--toc:start-->

- [Master thesis project description](#master-thesis-project-description)
  - [Tentative title for thesis](#tentative-title-for-thesis)
  - [Motivation](#motivation)
  - [Hypothesis](#hypothesis)
  - [Method](#method)
  - [Perspectivication](#perspectivication)
  - [Learning outcome](#learning-outcome)
  - [References](#references)
    - [The original description](#the-original-description)
  - [Suggested topics](#suggested-topics)

<!--toc:end-->

## Tentative title for thesis

<!-- Suggestion from Joachim. -->

`academemes.com` : A case study on energy effiency for cloud native application
deployment.

Exploring the use of Rust and WebAssembly for building cloud native
applications: A performance, efficiency and mobility analysis.

## Motivation

> If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!
>
> &mdash;
> [_Solomon Hykes, founder of Docker_](https://twitter.com/solomonstre/status/1111004913222324225?lang=en)

<!-- What is the general topic. -->

The internet of today is made up of interconnected services across the world. It
isn't obvious how to build such services, nor how they should communicate.
However, some conventions seems to be emerging.

<!-- A presentation of one such conventions -->

A common convention, is to build an image to be deployed and run using a
container orchestration tool such as Docker Swarm or Kubernetes. Images are
commonly gigabytes of data that need to transfer between various machines, and
even building the environment required to run them, can require a lot of
computing power.

<!-- A presentation of another convention -->

Another convention, is that of serverless services, where the focus is to move
from building the environment yourself, but rather writing code that serve a
specific purpose while the infrastructure is (generally) managed by someone
else. This allows servers to spin up a process for running a specific task, and
then turn it off again once it's done. Between each request, the service doesn't
occupy any hardware, and thus doesn't cause any monetary/computational cost.

<!-- Potential issues related to the previous conventions -->

But these services are often written in languages that require to run on
specific infrastructure to work. These requirements can cause the service to
have pretty high startup times (often referred to as cold starts) and thus incur
a high impact on the environment. A way to mitigate this, is to keep the server
running at all times and serve services on the same "serverless server". This
could cause security issues, if two different companies share the same
infrastructure without being able to control what the services are able to
access on the same machine.

<!-- Present the basis for my motivation based on the issue related to the
conventions above -->

Is it possible to eat your cake and have it too?

My motivation for this thesis is to research alternative technologies that might
enable developers to create distributed cloud native applications that are more
efficient, more secure and reduce the environmental footprint from running.

## Hypothesis

<!-- from Joachim : it seems to me like you are trying to express two
different hypothesis here. Decide if your thesis is about mobility, or about
deployment/orchestration. It sounds to me (based on the introduction), that
you are converging on deployment. So the hypothesis should say "We can use
technology T to solve problem X, and in doing so, we can build and deploy
webapplications more efficiently than that which is the current
convention". The hypothesis doesn't have to hold (your thesis is about doing
the investigation, and concluding if it holds or not). -->

> A web application can become more responsive by solving a mobility problem, by
> running the code closer to the end user. If the web application can be
> compiled to smaller packages, require less computing time to startup and
> perform an operation we could reduce the amount of power required.

## Method

> Description of the method I intend to use to research the proposed hypothesis.

For the thesis research my initial thoughts are to attempt to create something
that I can run simulations/experiments on in an attempt to measure how much
runtime each tehnology uses, and thus attempt to calculate how much
computational power we can save on more efficient runtimes.

<!-- from Joachim : Good, but can you design a more precise initial
"measuring stick". Say, a list of 5 parameters that you think are important,
and a description of how you intend to measure them?-->
<!-- My measuring stick 🥍 -->

To support this, I will spend some time during the next semester reading up on
related literature that can teach me about the underlying technology behind
cloud native applications.

## Perspectivication

Modern software development is driven by financial considerations that
presure software vendors to build and deploy software hastily. This kind of
short-term thinking evidentally has long term consequenses on maintainability,
but perhaps also on financial externalities, such as carbon footprint.

Short sighted thinking is about looking into the market and identifying
promising off-the-shelf technology. We hope that the result of this work
will help future software vendors make the right decision regarding WASM+WASI.

## Learning outcome

My goal for the research is to learn:

- More about the exciting alternatives for the future of cloud native
  application development.
- How much potential power we can save from more efficient runtimes.
- How to immerse myself deep into a topic and gain the experience provided from
  writing a longer academic research paper based in prior research.

---

## References

### The original description

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
