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

In the era preceding cloud computing, companies were tasked with, buying,
setting up and managing their own infrastructure. This necessitated having
in-house infrastructure engineers to oversee their on-premise data centers or
servers, leading to considerable expenses. During the mid 00s Amazon recognized
the potential of a market of managed infrastructure and launched its subsidiary,
Amazon Web Services.

On March 14, 2006, AWS launched Amazon S3 cloud storage, a cloud storage
service, followed by Elastic Compute Cloud (EC2) in August 2006. The launch of
these two services revolutionized the landscape of application development and
deployment, making cloud computing widely accessible.
[x](https://aws.amazon.com/blogs/aws/amazon_ec2_beta/)

EC2, an Infrastructure-as-a-Service platform, changed the way developers worked
by enabling them to run virtual machines externally. While other companies had
ventured into similar services before 2006, Amazon's extensive customer base
enabled them to attract significant traction. Thus, Amazon is often credited
with making cloud computing a mainstream concept.

<!-- The second wave -->

As we entered the 2010s, we saw that the trend begant to shift from Virtual
Machines to containers. This transition was primarily driven by the limitations
associated with VMs, including efficiency, resource utilization and the speed of
application deployment. Containers, being a lightweight alternative to VMs, were
designed to address these issues.

Unlike VMs, which typically required the installation of resource-intensive
operating systems and took minutes to start up, containers could achive the same
in seconds. Containers package an application alongside with its required OS
components and is typically managed using orchastration tools like Kubernetes.
This approach allows companies to scale their resources in response to varying
service loads. As such, more and more companies have now established platform
teams tasked with constructing orchestrated developer platforms to simplify
application deployment in Kubernetes clusters.

### Serverless and Function-as-a-Service (FaaS)

Building your own developer platform on top of Kubernetes, much like building
your own infrastructure, also entails a significant cost. Often, developers wish
to launch specialized smaller services, without having to grapple with
complicated orchestration. This led to the emergence of the Serverless model.
Despite its somewhat misleading name, serverless doesn't imply the absence of a
server. Instead, it means that the responsibility of server management has
shifted from the developer to a third party provider.

From the advancements of serverless, we get its subset, Functions-as-a-Service,
or FaaS. Companies already in the cloud game decided to develop their own FaaS
platforms to attract developers interested in running their code, and not worry
about anything underneath.

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
everywhere, efficient, fast and secure" translates well into the server
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
