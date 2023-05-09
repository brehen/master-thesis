# Academemes: Leveraging Rust and WebAssembly to create an energy-efficient web service for serving Academic Memes

> If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!
>
> &mdash;
> [_Solomon Hykes, founder of Docker_](https://twitter.com/solomonstre/status/1111004913222324225?lang=en)

## Introduction

<!-- The general topic. -->

The rapid growth of cloud computing the past decade has led to the cloud
consuming enormous amounts of energy. The entire ICT (Information- and
Communication Technology) industry emits 2.1% to 3.9% of global green gas
emission. Data centers, which are at the core of cloud computing, consume a
significant amount of energy, estimated at around 200 TWh/yr or 1% of the worlds
electricity. [1](http://dx.doi.org/10.1016/j.patter.2021.100340) This energy
consumption could grow to between 15-30% of electricity consumption in some
countries by 2030. Allthough data centers strive to reach a net zero sum carbon
footprint, there are still a lot of electricity genereated by fossil fuels, a
leading contributer to climate change.
[2](https://doi.org/10.1038/s41558-020-0837-6)

Important to note is that these measurements and estimates comes with some level
of uncertainty, but give us a rough idea of the current and future situation. As
demand for cloud services continues to rise, there is a pressing need to explore
alternative methods that can help improve energy efficiency, while maintaining
the performance, availability and scalability of these services.

This essay investigates the potential for utilizing technologies like Rust and
WebAssembly to develop a prototype Function-as-a-Service (FaaS) platform. This
prototype will aim to address the energy efficiency problem in cloud computing
by serving academic memes through a web service.

### Hypothesis

This master thesis explores the following hyphothesis:

> it is possible to develop a FaaS platform that scale to near-zero resource
> usage without sacrificing consistency/latency, by exclusively running
> WebAssembly modules

To test this, we will develop a prototype FaaS written in Rust, and attempt to
scale to near-zero by implementing a simple service for serving memes on the
internet that is virtually always available, but also more energy efficient than
contending alternatives.

## Background

### Cloud Computing: An Overview

<!-- What is the cloud and its significance in todays web -->

Cloud computing, more commonly known as _the cloud_, refers to the delivery of
computing services, such as storage, processing power, databases and software,
served over the internet, instead of running on locally owned hardware
(on-premise). For companies, this has proved to be a super power, where
businesses can focus on deploying their own applications and services to their
users without worrying about the underlying infrastructure.

<!-- Introduce benefits and challenges associated with cloud computing. Some
important points for this thesis: Scalability, cost and energy efficiency -->

<!-- TODO: Rewrite these points from lists to paragraph-->

Some benefits:

- Cloud computing has enabled companies to take their computing needs to the
  next level. Startups who can't afford neither the cost or time required to
  build their own infrastructure, and larger companies that want to iterate
  faster and decrease their lead time from idea to production. !Source pending.
- Scalability: With the advent of containerization and orchestration (more on
  that later), companies are less prone to outages based on varying degrees of
  usage of their services. Example: Walmart is available in june, as well as on
  Black Friday. !Source pending.
- Increased security, with third party vendors putting multi-million dollar
  efforts into keeping their services secure to keep their customers. !Source
  pending.

Some challenges:

- Scalability: How do cloud companies maximize their investment in hardware? Do
  they let users have their alloted resources on a given piece of hardware sit
  idly by during periods of low usage?
- Cost: This relates to energy usage, and with rising energy costs in the world,
  this becomes an even bigger issue every day. This also includes investment in
  the actual hardware (storage/cpu/ram)
- Energy usage: Data centers alone use 1% of the worlds electricity [1]. Are
  there any ways to reduce this? Reducing energy usage should also lead to
  reduced costs and lessen the carbon footprint of running the cloud.

<!-- What are some major players, and how are they attempting to solve the same
problems? -->

There doesn't exist any one company that "owns" the cloud, but we have vendors
that together make up what we have today. These vendors include Amazon,
Microsoft, Google, Alibaba, DigitalOcean and more.

- Google: Google Cloud Functions is their FaaS
- Amazon: Amazon Lambda
  - Side note: Amazon's streaming service; Prime Video, moved away from a
    serverless architecture back to running a monolith to meet the service's
    specific requirements. Is this due to serverless being a poor fit for cloud
    computing, or a poor fit for their exact use case? Read some material online
    on this, that their use case was to process videoes frame by frame, which
    ran up insane costs on their sibling companys FaaS, Amazon Lambda. (Marius
    note: Maybe a FaaS running WebAssembly wouldn't rack up these insane costs?
    🤷)
- Microsoft: Their cloud offerings include Azure Functions
  <!-- According to
  most people I met at WASM IO, this platform is very lackluster -->

### Traditional Deployment Methods: Virtual machines and Containers

<!-- Introduce the concept of "the first two waves of cloud computing" -->

Before the cloud companies had to buy, build and maintain their own
infrastructure. This required employing their own infrastructure engineers in
order to manage their on-premise data centers or servers incurring high cost. In
the mid 00s Amazon saw the potential of a market of managed infrastructure and
launched their subsidiary Amazon Web Services, Inc. (AWS). On March 14, 2006,
AWS launched Amazon S3 cloud storage followed by Elastic Compute Cloud (EC2) in
August 2006. The launch of these two products brought the cloud to the
mainstream, and changed how we develop and deploy services.
[x](https://aws.amazon.com/blogs/aws/amazon_ec2_beta/)

Elastic Compute Cloud is an Infrastructure-as-a-Service platform that allows
developers to run virtual machines externally. It provides resizable compute
capacity in the cloud, enabling developers to borrow and configure virtual
servers to run their applications. There were a couple of other companies that
offered similar services before 2006, but Amazon gained significant traction and
attention due to its large customer base and are commonly attributed as the
first company that brought cloud computing to the masses.

<!-- Moved the following text from the previous introduction, and should
definetly rewrite it -->

We have two widely used ways to deploy and host these services and web
applications. One of these is by using Virtual Machines where you install full
operating systems on restricted resources, but this requires you to have the
machine turned on at all times availability, and can be hard to scale.

Or, to build services that scale well another approach emerged; through building
an image that deploy and run on containers through a container orchestration
tool such as Docker Swarm or Kubernetes. These images are often large and
require a lot of networking traffic to transfer between machines.

Both approaches require a lot of computing power that has resulted in major
vendors building giant data centers that, when combined, puts out 2.5% to 3.7%
of all global greenhouse gas emissions. [1] Are there any ways for us to attempt
to mitigate this, using alternative technologies?

<!-- Describe each wave and detail advantages and disadvantages to each -->

### Serverless and Function-as-a-Service (FaaS)

<!-- the waves of cloud sounds _maybe_
a bit too pop cultury/marketingy for a academic paper? -->

<!-- Introduce FaaS as a concept and its role in "serverless" cloud computing  -->
<!-- Challenges associated with FaaS, including cold start latency -->

### WebAssembly: A new paradigm

<!-- Provide an overview of WebAssembly, its purpose, and its advantages over
traditional deployment methods. -->

WebAssembly, also known as Wasm, is a binary instruction format for a
stack-based virtual machine. It is designed as a portable compilation target for
programming languages, enabling deployment on the web for client and server
applications. [x](https://webassembly.org/) Wasm was initially designed and
developed to complement JavaScript in the browser, but its philosophy of "Run
everywhere, efficient, fast and secure" translated well into the server
landscape as well.

Solomon Hykes suggested in his tweet from 2019 that if _WebAssembly_ and the
_WebAssembly System Interface_ project had existed in 2008, there would not have
been a need to develop Docker.

<!-- TODO: Weave these two paragraphs together -->

WebAssembly, initially developed to run on all browsers and devices, found a new
application when the WebAssembly System Interface allowed it to run on and
interface with any hardware. This development model has led to an alternative
deployment method using WebAssembly modules designed for near-native efficiency
on any hardware.

<!-- Introduce WASI -->

WASI is pretty cool.

<!-- Discuss advantages to introducing Wasm+Wasi component modules as an
alternative way to deploy and host FaaS platforms. Focus on startup times and
energy efficiency. Runtime efficiency is also nice, but _maybe_ not a focus for
this thesis -->

### Hypothesis Revisited

`Initial thoughts here: Based on my assumption that serverless services might be more energy efficient if vendors explore WebAssembly modules as opposed to classic container orchestration, it would be fruitful to gauge the current market to paint a picture to any fellow student at IFI what the current status quo is.`

## Related Work

## Proposed _methodology_

## Preliminary ideas and future direction

### Design specification

`What will my experiments look like?`

<!--More specifically, how will we setup a academemes webpage that provides academic
memes through a serverless application? Should I make both an implementation in
Docker with Node as a backend and one version written in Rust that gets compiled
into webassembly and deployed as [[WebAssembly Modules]]?-->

### Energy

> Is it possible to measure how much energy a serverless architecture spends on
> spinning up, running and spinning down services?

---

## References

---

## Related resources

<https://techmonitor.ai/focus/how-green-is-your-cloud>

<https://www.redhat.com/en/blog/history-containers>

<https://theshiftproject.org/en/article/lean-ict-our-new-report/>

```
```
