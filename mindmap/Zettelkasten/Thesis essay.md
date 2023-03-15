{{date:YYYYMMDD}}{{time:HHmm}}
Status: #idea

Tags: #msater-thesis

# Thesis essay

> `academemes.com` : A case study on energy effiency for cloud native application deployment

## Introduction

> If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!
>
> &mdash;
> [_Solomon Hykes, founder of Docker_](https://twitter.com/solomonstre/status/1111004913222324225?lang=en)

<!-- The general topic. -->

In our world wide web we rely on thousands upon thousands of different services that attempt to solve every issue known to mankind (thus far). These services need to be developed, deployed and hosted on machines that require energy to run.

<!-- Two common ways to solve "the cloud" -->

Today we have two very widely used ways to deploy and host these services. This can be done by using Virtual Machines that you install full operating systems on, in order to run a web server that provides a set service. This approach generally require you to have the machine turned on at all times, in order to keep up availability, and can be hard to scale.

Another approach is to build an image that is deployed and run on containers through a container orchestration tool suck as Docker Swarm or Kubernetes. These images are often quite large and require a lot of networking traffic to transfer between various machines.

<!-- The effect of these common ways -->

Both approaches can require a lot of computing power that has resulted in major vendors building giant data centers that combined puts out 2.5% to 3.7% of all global greenhouse gas emissions. <!-- source pending -->

<!-- Introducing a new hot contender that we want to compare with -->

Solomon Hykes, the creator of Docker, has suggested that if WebAssembly had existed in 2008, he would not have created Docker. WebAssembly was originally developed with a philosophy that it should be able to run on all kinds of browsers on all kinds of devices. This philosohy translated well when WebAssembly System Interface was developed as a way to run WASM on any kind of hardware. This resulted in an alternative way to deploy web applications, namely WASM modules that is designed to run on any kind of hardware with near-native efficiency.

<!-- What can we do with this knowledge -->

Using a technology like WASM modules, which can be compiled and targeted by many well-established technologies, could reduce the startupand runtime dramatically as opposed to the previously mentioned approaches, and thus enable companies to drastically reduce the carbon footprint of their services.

<!-- Note: Not 100% sure yet if I want to focus on serverless deployments and functions-as-a-service for the experiments. WASM modules seems like a very good fit for this space, so I'm inclined to approach the further work with Joachim's suggestion for setting up our own serverless sandbox in the Energy Læbs -->

## Background

<!-- Note from Marius: I initially wrote this for my motivation, but after a while I noticed that it might be a bit too detailed and long winded, and perhaps would be better to incorporate as part of the background information for the thesis? -->

To serve these services we need resources to run the computation required to solve a request. These resources were uausally owned and managed by companies on-premise, but today we rent hardware from someone else. This concept is popularised through the term _cloud computing_ and is the basis for what we now know as _the cloud_. Two of the most widely used means of cloud computing today is through virtual machines, or VM's, and containerisation.

VMs are essentially full operating systems that run "on top" of another operating system through virtualisation, where we can install a OS of our choice, granted the underlying hardware supports it. On these machines we usually have full control of the environment granted by the vendor and we can deploy and host full servers that run all the time and are thus always available to resolve requests.

There are many benefits to this approach, as opposed to managing your own infrastructure, but there are also some drawbacks. Leaving VMs running all the time on a set amount of resources is both inefficient and hard to scale with increased traffic. As a way to combat these drawbacks, we have seen the rise of containerisation the past decade.

A very popular option for packaging applications in containers is the open source project Docker. This technology allowed developers to develop, package and deploy applications easily. One of the biggest challenges for those working with containers, is deployment and orchestration at scale. which saw the rise of Google's Kubernetes, a tool that most companies attempt to incorporate into their platform.

`Initial thoughts here: Based on my assumption that serverless services might be more energy efficient if vendors explore WebAssembly modules as opposed to classic container orchestration, it would be fruitful to gauge the current market to paint a picture to any fellow student at IFI what the current status quo is.`

### Google Cloud

`What offerings do Google Cloud have for serverless architecture?`

### Azure

`What offerings to Microsoft have for this space, and what are some issues related to startup times and runtimes that might incur higher energy usage?`

### AWS

`What do Bezos offer?`

## Analysis

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