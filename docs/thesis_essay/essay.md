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

This master thesis explores the hyphothesis "it is possible to develop a FaaS
platform that scale to zero, without losing availability, but the price is that
we run WebAssembly." To test this, we will develop a prototype FaaS written in
Rust, and attempt to scale to zero by implementing a simple service for serving
memes on the internet that is always available, but energy efficient.

## Background

<!-- Note from Marius: I initially wrote this for my motivation, but after a while I noticed that it might be a bit too detailed and long winded, and perhaps would be better to incorporate as part of the background information for the thesis? -->

To serve these services we need resources to run the computation required to
solve a request. These resources were uausally owned and managed by companies
on-premise, but today we rent hardware from someone else. This concept is
popularised through the term _cloud computing_ and is the basis for what we now
know as _the cloud_. Two of the most widely used means of cloud computing today
is through virtual machines, or VM's, and containerisation.

VMs are essentially full operating systems that run "on top" of another
operating system through virtualisation, where we can install a OS of our
choice, granted the underlying hardware supports it. On these machines we
usually have full control of the environment granted by the vendor and we can
deploy and host full servers that run all the time and are thus always available
to resolve requests.

There are many benefits to this approach, as opposed to managing your own
infrastructure, but there are also some drawbacks. Leaving VMs running all the
time on a set amount of resources is both inefficient and hard to scale with
increased traffic. As a way to combat these drawbacks, we have seen the rise of
containerisation the past decade.

A popular option for packaging applications in containers is the open source
project Docker. This technology allowed developers to develop, package and
deploy applications easily. One of the biggest challenges for those working with
containers, is deployment and orchestration at scale. which saw the rise of
Google's Kubernetes, a tool that most companies attempt to incorporate into
their platform.

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
