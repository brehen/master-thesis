# Academemes: Leveraging Rust and WebAssembly to create an energy-efficient web service for serving Academic Memes

> If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!

> [_Solomon Hykes, founder of Docker_](https://twitter.com/solomonstre/status/1111004913222324225?lang=en)

## Introduction

<!-- The general topic. -->

The rapid growth of cloud computing the past decade has led to the cloud
consuming enormous amounts of energy. The entire ICT (Information- and
Communication Technology) industry emits 2.1% to 3.9% of global green gas
emission. Data centers, which are at the core of cloud computing, consume a
significant amount of energy, estimated at around 200 TWh/yr or 1% of the worlds
electricity [[1]](http://dx.doi.org/10.1016/j.patter.2021.100340). This energy
consumption could grow to between 15-30% of electricity consumption in some
countries by 2030. Allthough data centers strive to reach a net zero sum carbon
footprint, there are still a lot of electricity genereated by fossil fuels, a
leading contributer to climate change
[[2]](https://doi.org/10.1038/s41558-020-0837-6).

Important to note is that these measurements and estimates comes with some level
of uncertainty, but give us a rough idea of the current and future situation. As
demand for cloud services continues to rise, there is a pressing need to explore
alternative methods that can help improve energy efficiency, while maintaining
the performance, availability and scalability of these services.

This essay investigates the potential for utilizing technologies like Rust
[[3]](https://www.rust-lang.org/) and WebAssembly
[[4]](https://webassembly.org/) to develop a prototype Function-as-a-Service
(FaaS) platform. This prototype will aim to address the energy efficiency
problem in cloud computing by serving academic memes through a web service.

### Hypothesis

This master thesis explores the following hyphothesis:

> It is possible to develop a FaaS platform that scale to near-zero resource
> usage without suffering the CAP-theorem.

To test this, we will develop a prototype Pure Functions as a Service written in
Rust, and attempt to scale to near-zero by implementing a simple service for
serving memes on the internet that remains consistent, is virtually always
available, and suffers no issues from partition tolerance (Consistency,
Availability, Partition Tolerance - CAP) while also being more energy efficient
than predominant alternatives.

## Background

### Cloud Computing: An Overview

<!-- What is the cloud and its significance in todays web -->

Cloud computing, more commonly known as _the cloud_, refers to the delivery of
computing services, such as storage, processing power, network, and software,
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
Microsoft, Google, Alibaba, DigitalOcean and more. This essay will point the
light on the three biggest vendors and some challenges they face.

Amazon Web Services (AWS) offers AWS Lambdas which relies on their proprietary
technology; Firecracker. Firecracker is a lightweight virtualization technology
that run their functions.

Side note: Amazon's streaming service; Prime Video, moved away from a serverless
architecture back to running a monolith to meet the service's specific
requirements. Is this due to serverless being a poor fit for cloud computing, or
a poor fit for their exact use case? Read some material online on this, that
their use case was to process videoes frame by frame, which ran up insane costs
on their sibling companys FaaS, Amazon Lambda. (Marius note: Maybe a FaaS
running WebAssembly wouldn't rack up these insane costs? 🤷)

Google offers Google Cloud Functions, and allow developers to write functions in
languages like Node, Python, Go and execute them in response to events. Google
relies on containers to execute these functions.
[x](https://www.infoworld.com/article/3265750/serverless-in-the-cloud-aws-vs-google-cloud-vs-microsoft-azure.html)

Microsoft has Azure Functions, a Faas platform that allows developers to create
and execute functions in C#, JavaScript, Python and more. They also rely on
containers for executing functions.

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

As we entered the 2010s, we saw that the trend began to shift from Virtual
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

WebAssembly (Wasm) is a binary instruction format designed as a stack-based
virtual machine. It aims to be a portable target for the compilation of
high-level languages like Rust, C++, Go and many others, enabling deployment on
the web for client and server applications. [x](https://webassembly.org/)
Originally designed and developed to complement JavaScript in the browser, it
now expands its scope to server-side applications, thanks to projects like
WebAssembly System Interface (WASI), which provides a standarized interface for
WebAssembly modules to interface with a system.

WebAssembly's design provides advantages over traditional deployments methods in
the context of cloud native applications:

_Efficiency and Speed_: Wasm was designed to be fast, enabling near-native
performance. Its binary format is compact and designed for quick decoding,
contributing to quicker startup times, an important aspect for server-side
applications. The performance gains could lead to less CPU usage, thereby
improving energy efficiency.

_Safety and Security_: WebAssembly is designed to be safe and sandboxed. Each
WebAssembly module executes within a confined environment without direct access
to the host system's resources. This isolation of processes is inherent in
WebAssembly's design, promoting secure practices.

_Portability_: WebAssembly's platform-agnostic design makes it highly portable.
It can run across a variety of different system architectures. For cloud native
applications, this means WebAssembly modules, once compiled, can run anywhere -
from the edge to the server, irrespective of the environment.

_Language Support_: A large amount of programming langauages can already target
WebAssembly. This means developers are not restricted to a particular language
when developing applications intended to be deployed as WebAssembly modules.
This provides greater flexibility to leverage the most suitable languages for
particular tasks.

In contrast, traditional methods such as deployment with containers or VMs can
be resource-intensive, slower to boot up, less secure due to a larger surface
attack area, and less efficient. Given these, WebAssembly, with its efficiency,
security, and portability, can potentially offer an attractive alternative
deployment method for building and running cloud native applications, like the
"Academemes" service we will explore in this essay.

<!-- Discuss advantages to introducing Wasm+Wasi component modules as an
alternative way to deploy and host FaaS platforms. Focus on startup times and
energy efficiency. Runtime efficiency is also nice, but _maybe_ not a focus for
this thesis -->

### Wasm+WASI: Towards Energy-efficient FaaS Platforms

WebAssembly (Wasm) and WebAssembly System Interface (WASI) present promising
alternatives to traditional ways of deploying and hosting Function as a Service
(FaaS) platforms, offering several notable advantages, especially in terms of
startup times and energy efficiency.

_Reduced Startup Times_: One of the greatest strengths of Wasm is its compact
binary format designed for quick decoding and efficient execution. It offers
near-native performance, which results in significantly reduced startup times
compared to container-based or VM-based solutions. In a FaaS context, where
functions need to spin up rapidly in response to events, this attribute is
particularly advantageous. This not only contributes to the overall performance
but also improves the user experience, as the latency associated with function
initialization is minimized.

_Improved Energy Efficiency_: Wasm's efficiency extends to energy use as well.
Thanks to its optimized execution, Wasm can accomplish the same tasks as
traditional cloud applications but with less computational effort. The CPU
doesn't need to work as hard, which results in less energy consumed. With data
centers being responsible for a significant portion of global energy consumption
and carbon emissions, adopting Wasm could lead to substantial energy savings and
environmental benefits.

_Scalability_: Wasm's small footprint and fast startup times make it an
excellent fit for highly scalable cloud applications. Its efficiency means it
can handle many more requests within the same hardware resources, hence reducing
the need for additional servers and thus reducing the energy footprint further.

_Portability and Flexibility_: WASI extends the portability of Wasm outside the
browser environment, making it possible to run Wasm modules securely on any
WASI-compatible runtime. This means that FaaS platforms can run these modules on
any hardware, operating system, or cloud provider that supports WASI. This
portability ensures flexibility and mitigates the risk of vendor lock-in.

While runtime efficiency is an important aspect and typically a strength of
Wasm, it might not be the primary focus of this thesis. That being said, it is
worth mentioning that the efficient execution of Wasm modules does contribute to
the overall operational efficiency and energy savings of Wasm-based FaaS
platforms.

In summary, introducing Wasm+WASI as a component for deploying and hosting FaaS
platforms can offer significant benefits. Focusing on energy efficiency and
reduced startup times, this approach could pave the way for more sustainable,
efficient, and responsive cloud services. In the context of our "Academemes"
service, this could lead to a scalable, performant, and environmentally friendly
platform.

## Methodology

This thesis will use an experimental research design to investigate the power
consumption under load of a FaaS platform developed with pure functions written
in Rust.

### System development

The first stage will involve developing a prototype PFaaS dubbet "Purify". This
platform will be developed using Rust and (might) compile to Wasm and Wasi that
runs on the Wasmtime runtime. This platform will require some way of "deploying"
functions compiled to Wasm that need to be pure.

### Benchmarking

Once the platform is developed, a series of benchmarking tests will be
conduncted. The intended web application that will test this platform, is
"Academemes.com", a web page that serves academic memes. These tests will
emulate users accessing academic memes through scripts and measure the
performance of the system under varying loads, capturing data on startup time,
execution time and (hopefully) energy consumption.

If there is enough interest and other students begin using the service, there
might be data from "real-life" use cases that would be interesting to compare.

### Energy measurement

The energy consumption of the system is a key focus of this thesis. To measure
this, I will rely on a device that's plugged into the computers motherboard
through its power pins that should be able to measure specific parts of the CPU.
These energy readings would then transmit to a USB device connected to the same
device, and feed the data to the benchmarking tools.

### Comparison

The power consumption of the "Purify" platform will be compared to either
existing FaaS platforms that can install locally, e.g. serverless.com, or by
replicating existing platforms built on top of Docker and Kubernetes. If this is
the case, the scope of the research will expand to learning these technologies,
and attempt to build a simple FaaS on top of these.

### Data Analysis

The data gathered from the benchmarking and energy measurement stages will be
analyzed to provide insights into the relationship between load, performance,
and energy consumption. The aim is to understand the impact of relying on
WebAssembly on the power efficiency of FaaS platforms.

By following this methodology, the thesi aims to contribute a practical analysis
of the potential for Rust and WebAssembly to enhance the power efficiency of
cloud computing platforms.

## Preliminary ideas and future direction

### Design specification

`What will my experiments look like?`

Some key points:

- Language: Rust
- Compilation target: Wasm+Wasi
- Runtime: Wasmtime or Wasmer
- Database required to store memes (Or fetch them from other locations)
- A frontend either written in Rust and server-rendered, or a separate client
  side Svelte application that interfaces with the functions through http.

<!--More specifically, how will we setup a academemes webpage that provides academic
memes through a serverless application? Should I make both an implementation in
Docker with Node as a backend and one version written in Rust that gets compiled
into webassembly and deployed as [[WebAssembly Modules]]?-->

### Energy

> Is it possible to measure how much energy a serverless architecture spends on
> spinning up, running and spinning down services?

---

CAP theorem states that distributed systems can only choose 2 from:

- Consistency
- Availability
- Partition tolerance

However, restricting ourselves pure functions guarantee all three

## References

---

## Related resources

<https://techmonitor.ai/focus/how-green-is-your-cloud>

<https://www.redhat.com/en/blog/history-containers>

<https://theshiftproject.org/en/article/lean-ict-our-new-report/>

```
```
