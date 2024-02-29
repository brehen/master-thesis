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
  - [Progress plan for thesis](#progress-plan-for-thesis)
  - [Relevant curriculum](#relevant-curriculum)

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

<!-- Solomon suggested that we use something else as a programming paradigm. We
should do so because it saves energy. Method: Here's an experiment that makes it
happen. Learning outcome: something testable to aim for.

Learning outcome: How to: How to benchmark for
energy consumption is nice to know.
Learning outcome: Learn how to write energy
efficient programs using Rust compiled to Webassembly.
Be able to describe and understand the paradigms presented above.
Be able to compare web application deployment paradigms.

-->

A common convention, is to build an image to be deployed and run using a
container orchestration tool such as Docker Swarm or Kubernetes. Images are
commonly gigabytes of data that need to transfer between various machines, and
even building the environment required to run them, can require a lot of
computing power.

<!-- A presentation of another convention -->

<!-- The paradigm that Solomon Hykes suggests  -->

Another convention, is that of serverless services, where the focus is to move
from building the environment yourself, but rather writing code that serve a
specific purpose while the infrastructure is (generally) managed by someone
else. This allows servers to spin up a process for running a specific task, and
then turn it off again once it's done. Between each request, the service doesn't
occupy any hardware, and thus doesn't cause any monetary/computational cost.

<!-- Potential issues related to the previous conventions -->

In either case, the conventions do not address the energy inefficiency of
virtualization, so some services have a pretty high startup times (often
referred to as cold starts) and thus incur a high impact on the environment. A
way to mitigate this, is to keep the server running at all times and serve
services on the same "serverless server". This could cause security issues, if
two different companies share the same infrastructure without being able to
control what the services are able to access on the same machine.

<!-- Present the basis for my motivation based on the issue related to the
conventions above -->

Is it possible to eat your cake and have it too?

My motivation for this thesis is to research alternative technologies that might
enable developers to create distributed cloud native applications that are more
efficient, more secure and reduce the environmental footprint from running.

## Hypothesis

> We can craft web applications that target WASM+WASI to create services that
> compile to smaller packages, require less computing time to startup and
> perform operations and thus reduce the energy required to distribute and
> operate our cloud native world.

## Method

> Description of the method I intend to use to research the proposed hypothesis.

For the thesis research my initial thoughts are to attempt to create something
that I can run simulations/experiments on in an attempt to measure how much
runtime each tehnology uses, and thus attempt to calculate how much
computational power we can save on more efficient runtimes.

Some parameters I think are important to research during my thesis:

1. Package size
   - What: How large are the files that need to be distributed?
   - How: Build different example applications and measure the resulting files.
2. Startup time/cold start
   - What: How long does it take to start a "cold" service?
   - How: Deploy example applications to virtual machines and measure the
     timings when requests come in.
3. Runtime
   - What: How long does the service spend on running the requested operation?
   - How: Deploy example applications and record timings from the moment it
     starts running, after startup.
4. Energy usage
   - What: How much power is consumed for an entire request?
   - How: On example machine, measure how much cpu/memory/storage is utilized
     for each request and over time.
5. Developer productivity
   - What: How do the technology help with making the developer more productive?
   - How: Attempt to write some example apps myself, and take notes while
     developing on how the ecosystem for the technologies I compare against are.
     Perhaps reach out to some developers and perform some interviews to gauge
     how the community experiences this.

To support this, I will spend some time during the next semester reading up on
related literature that can teach me about the underlying technology behind
cloud native applications.

## Perspectivication

Modern software development is driven by financial considerations that presure
software vendors to build and deploy software hastily. This kind of short-term
thinking evidentally has long term consequenses on maintainability, but perhaps
also on financial externalities, such as carbon footprint.

Short sighted thinking is about looking into the market and identifying
promising off-the-shelf technology. We hope that the result of this work will
help future software vendors make the right decision on WASM+WASI.

## Learning outcome

My goal for the research is to be able to analyse the design space for crafting
cloud native applications with respect to energy efficiency.

<!-- there Conjuectura  -->

<!--
Notes from Joachim.

-->

## Progress plan for thesis

1. 1st of March, begin researching relevant data material for further reading.
2. 1st of April, begin reading relevant research and start collecting potential
   related data points to the hypothesis.
3. 1st of May, hand in first draft of compulsory essay to supervisor
4. 1st of June, hand in compulsory essay and continue collecting data related to
   thesis.
5. 1st of October, start of the end of collecting relevant data to efficiency.
6. 1st of November, begin on first full draft of thesis
7. 1st of February 2024, hand in first draft of thesis to supervisor
8. 1st of April 2024, Hand in second draft to supervisor
9. 10th of May, hand in final thesis

## Where to go from Here

While in Bangkok:

- Rewrite the project description
  - Direct the focus towards the cloud efficiency and.
