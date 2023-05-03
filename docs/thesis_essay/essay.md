# Thesis essay

> `academemes.com` : A case study on energy effiency for cloud native
> application deployment

## Introduction

> If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!
>
> &mdash;
> [_Solomon Hykes, founder of Docker_](https://twitter.com/solomonstre/status/1111004913222324225?lang=en)

<!-- The general topic. -->

The world wide web comprises countless services designed to cater to a wide
range of human needs. To address these needs, these services must be: developed,
deployed, and hosted on machines that consume energy.

<!-- Two common ways to solve "the cloud" -->

We have two widely used ways to deploy and host these services and web
applications. One of these is by using Virtual Machines where you install full
operating systems on restricted resources, but this requires you to have the
machine turned on at all times availability, and can be hard to scale.

Or, to build services that scale well another approach emerged; through building
an image that deploy and run on containers through a container orchestration
tool such as Docker Swarm or Kubernetes. These images are often large and
require a lot of networking traffic to transfer between machines.

<!-- The effect of these common ways -->

Both approaches require a lot of computing power that has resulted in major
vendors building giant data centers that, when combined, puts out 2.5% to 3.7%
of all global greenhouse gas emissions. [1] Are there any ways for us to attempt
to mitigate this, using alternative technologies?

<!-- Our saviour, Wasm-->

Solomon Hykes suggested in his tweet from 2019 that if _WebAssembly_ and the
_WebAssembly System Interface_ project had existed in 2008, there would not have
been a need to develop Docker.

<!-- TODO: Weave these two paragraphs together -->

WebAssembly, initially developed to run on all browsers and devices, found a new
application when the WebAssembly System Interface allowed it to run on and
interface with any hardware. This development model has led to an alternative
deployment method using WebAssembly modules designed for near-native efficiency
on any hardware.

## Background

This master thesis explores the hyphothesis:

> it is possible to develop a FaaS platform that scale to near-zero resource
> usage without comprimising availability, by exclusively running WebAssembly
> modules

To test this, we will develop a prototype FaaS written in Rust, and attempt to
scale to near-zero by implementing a simple service for serving memes on the
internet that is virtually always available, but also more energy efficient than
contending alternatives.

### Cloud Computing: An Overview

<!-- What is the cloud and its significance in todays web -->
<!-- Introduce benefits and challenges associated with cloud computing. Some
important points for this thesis: Scalability, cost and energy efficiency -->
<!-- What are some major players, and how are they attempting to solve the same
problems? -->

### Traditional Deployment Methods: Virtual machines and Containers

<!-- Introduce the concept of "the first two waves of cloud computing" -->
<!-- Describe each wave and detail advantages and disadvantages to each -->

### Function-as-a-Service (FaaS)

<!-- Introduce FaaS as a concept and its role in "serverless" cloud computing  -->
<!-- Challenges associated with FaaS, including cold start latency -->

### WebAssembly: A new paradigm

<!-- Provide an overview of WebAssembly, its purpose, and its advantages over
traditional deployment methods. -->

<!-- Introduce WASI -->

<!-- Discuss advantages to introducing Wasm+Wasi component modules as an
alternative way to deploy and host FaaS platforms. Focus on startup times and
energy efficiency. Runtime efficiency is also nice, but maybe not a focus for
this thesis -->

### Hypothesis Revisited

`Initial thoughts here: Based on my assumption that serverless services might be more energy efficient if vendors explore WebAssembly modules as opposed to classic container orchestration, it would be fruitful to gauge the current market to paint a picture to any fellow student at IFI what the current status quo is.`

### Google Cloud

`What offerings do Google Cloud have for serverless architecture?`

### Azure

`What offerings do Microsoft have for this space, and what are some issues related to startup times and runtimes that might incur higher energy usage?`

### AWS

`What do Bezos offer?`

## Analysis

### Serverless

`What is serverless, and what are the alternatives?`

``

### Startup times in serverless

### Energy

`Is it possible to measure how much energy a serverless architecture spends on spinning up, running and spinning down services?`

### Design specification

`What will my experiments look like?`

`More specifically, how will we setup a academemes webpage that provides academic memes through a serverless application? Should I make both an implementation in Docker with Node as a backend and one version written in Rust that gets compiled into webassembly and deployed as [[WebAssembly Modules]]?`

---

## References

---

## Related resources

<https://techmonitor.ai/focus/how-green-is-your-cloud>

<https://www.redhat.com/en/blog/history-containers>

<https://theshiftproject.org/en/article/lean-ict-our-new-report/>
