{{date:YYYYMMDD}}{{time:HHmm}}
Status: #doing

Tags: #master #description

# Project Description

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

`academemes.com` : A case study on energy effiency for cloud native application
deployment

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

A common convention, is to build an image to be deployed and run using a
container orchestration tool such as Docker Swarm or Kubernetes. Images are
commonly gigabytes of data that need to transfer between various machines, and
even building the environment required to run them, and then running them, can require a lot of
computing power.

<!-- The paradigm that Solomon Hykes suggests -->

Solomon Hykes, the creator of Docker, has suggested that if WebAssembly existed back in the late 2000's, he would not have had the need to create Docker at all. As he has stated on Twitter, WebAssembly, a technology initially developed with browsers in mind in order to run front-end applications more efficiently on user devices, have in recent years seen supporting technology to reap the same kinds of benefits on the server through WASI (WebAssembly System Interface). With potentially faster startup times and run times, we should explore whether or not adopting this technology can help us save energy with the reduced amount of computing power required to run out cloud native applications.

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

<!-- Goal in hand-in: My goal for the research is to be able to analyse the design space for crafting
cloud native applications with respect to energy efficiency. -->

<!-- In general, my learning outcomes should be something testable -->

My goal for the research is:

Learning outcome: How to: How to benchmark for
energy consumption is nice to know.
Learning outcome: Learn how to write energy
efficient programs using Rust compiled to Webassembly.
Be able to describe and understand the paradigms presented above.
Be able to compare web application deployment paradigms.

1. Learn how to benchmark for energy consumption on a given device/server.
2. Learn how to write energy efficient programs using Rust compiled to Wasm.
3. Be able to describe and understand paradigms described in the motivation.
4. Be able to compare web application deployment paradigms.




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


---
# References