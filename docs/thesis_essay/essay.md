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

<!-- Some benefits and challenges -->

Some benefits include:

- Reduced total cost of ownership: Cloud computing has enabled companies to take
  their computing needs to the next level. Startups who can't afford neither the
  cost or time required to build their own infrastructure, and larger companies
  that want to iterate faster and decrease their lead time from idea to
  production [[5]](https://www.jot.fm/contents/issue_2009_05/column4.html).

- Scalability is one of the most significant benefits of cloud computing. As
  organizations expand, so do their customer needs and the complexity of their
  application infrastructure. Each additional feature brings with it additional
  costs, highlighting the importance of efficient resource management to
  optimize hardware investments in a cloud computing environment
  [[6]](https://www.jot.fm/contents/issue_2009_05/column4.html).

Some challenges include:

- Cost: Managing the cost of cloud computing is an ongoing challenge, with
  Gartner predicting that through 2024, 60% of infrastructure and operations
  (I&O) leaders will encounter cloud costs that are higher than budgeted for.
  [[8]](https://www.gartner.com/smarterwithgartner/6-ways-cloud-migration-costs-go-off-the-rails).

- Energy usage: The challenge of energy usage in cloud computing is a
  significant concern, with data centers alone accounting for approximately 1%
  of the world's electricity consumption
  [[9]](https://www.cisco.com/c/dam/m/en_us/solutions/industries/docs/gov/government-global-energy-divide-white-paper.pdf).
  This staggering statistic highlights the need to explore strategies and
  measures to mitigate energy usage in data centers. By reducing energy
  consumption, not only can costs be reduced, but also the carbon footprint
  associated with running the cloud can be lessened. Decreasing energy usage in
  data centers is expected to yield cost savings and contribute to the overall
  sustainability goals by reducing the cloud's environmental impact.

### Traditional Deployment Methods: Virtual machines and Containers

<!-- Introduce the concept of "the first two waves of cloud computing" -->

In the era preceding cloud computing, companies bought, set up and managed their
own infrastructure. This necessitated having in-house infrastructure engineers
to maintain on-premise data centers or servers, leading to significant cost.
Sensing the potential in offering managed infrastructure, Amazon launched its
subsidiary, Amazon Web Services, during the mid-2000s.

The launch of AWS's Amazon S3 cloud service in March 2006, followed by Elastic
Compute Cloud (EC2) in August the same year
[[15]](https://aws.amazon.com/blogs/aws/amazon_ec2_beta/), marked a major
turning point in application development and deployment, and popularized cloud
computing. EC2, as an Infrastructure-as-a-Service platform, empowered developers
to run virtual machines remotely. While similar services existed before 2006,
Amazon's large customer base helped them gain significant traction, effectively
bringing cloud computing to the mainstream.

<!-- The second wave -->

As we entered the 2010s, the focus shifted from Virtual Machines to containers,
largely due to the limitations of VMs in efficiency, resource utilization, and
application deployment speed. Containers, being a lightweight alternative to
VMs, designed to overcome these hurdles
[[16]](https://www.researchgate.net/publication/309961613_Containers_and_Virtual_Machines_at_Scale_A_Comparative_Study).

In contrast to VMs, which require installation of resource-intensive operating
systems and minutes to start up, containers along with their required OS
components, could start up in seconds. Typically managed by orchestration tools
like Kubernetes [[17]](https://kubernetes.io/), containers enabled applications
to package alongside their required OS components, facilitating scalability in
response to varying service loads. Consequently, an increasing number of
companies have since established platform teams to build orchestrated developers
platforms, thereby simplifying application development in Kubernetes clusters.

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

### Some major vendors in Serverless

The concept of "the cloud" isn't owned by any single organization, but rather,
through the collective effort of industry players including Amazon, Microsoft,
Google, Alibaba and DigitalOcean, among others. This essay delves into some
challenges faced by the biggest three vendors: Amazon, Google and Microsoft.

Amazon Web Services (AWS) provides AWS Lambdas
[[10]](https://aws.amazon.com/lambda/), a technology that hinges on their
proprietary Firecracker - a streamlined virtualization technology for executing
functions. Interestingly, for this thesis, is that Amazon's Prime Video
streaming service transitioned recently from a serverless architecture to a
monolithic system to meet specific service demands. One might question whether
this reflects the suitability of serverless systems for cloud computing, or for
specific use cases like theirs
[[11]](https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90).
Some discussions suggest that their need to process videos frame by frame led to
astronomical costs on their sibling company's FaaS, Amazon Lambda.

Google provides Google Cloud Functions
[[12]](https://cloud.google.com/functions), which allow developers to write and
execute functions in languages such as Node.js, Python, Go and execute them in
response to events. Google's approach to function execution centeres around
container technology
[[13]](https://www.infoworld.com/article/3265750/serverless-in-the-cloud-aws-vs-google-cloud-vs-microsoft-azure.html).

Microsoft's Azure Functions
[[14]](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview?pivots=programming-language-csharp)
is a Faas platform that enables developers to create and execute functions
written in languages like C#, JavaScript, Python. Similar to Google, they also
harness the power of containers to execute these functions.

<!-- Introduce FaaS as a concept and its role in "serverless" cloud computing  -->
<!-- Challenges associated with FaaS, including cold start latency -->

### WebAssembly: A new paradigm?

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
