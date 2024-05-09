A section I had in my introduction, but might have gone a bit too deep into
stuff better served in the Project chapter.

\section{Project overview}

For this thesis, we will build a Functions-as-a-Service platform prototype,
named Nebula for brevity, that we deploy to a typical Debian web server. To
compare functions compiled and packaged into WebAssembly modules, we will write
standalone functions in Rust that we both A. compile to WebAssembly+WASI and B.
build as ordinary Rust binaries and package into a lightweight Docker image.
These WebAssembly modules and Docker images will be deployed to the web server,
ready to be called by our test scripts.

On this server we will support running functions both as WebAssembly modules and
Docker Images, using a respective runtime for each. For WebAssembly Nebula will
use the Wasmtime project as runtime, while Docker relies on the Docker CLI tool.
The act of calling these functions will be exposed as API endpoints, which
allows a test script to call functions in succession in order to simulate user
load.

Furthermore, a simple application will be written that hits this endpoint X
amount of times with Y amount of different input values. Nebula will benchmark
each individual function request based on the _Instant_ crate in Rust, which in
turn will be stored in a JSON file with metric information. This list of
function results and metrics will lay the foundation for the findings the
experiments will reveal, which we will go into detail later.

_Hopefully_, there will also be time to set up Nebula to run on a Raspberry PI
that I can measure power consumption of during load of the web server, but this
is paragraph won't make it into the final paper, it's more of a TODO to me, to
not forget (how could I) to attempt to measure power consumption as well.

---

As cloud computing matured, its journey first unfolded in two significant waves,
each marking a new age of innovation and addressing the dynamic needs and
challenges of digital infrastructure. This evolution reflects the industry's
efforts to optimize resource efficiency, reducing operational costs, and
minimize environmental impacts.

---

Building your own developer platform on top of Kubernetes, much like building
your own infrastructure, also entails a significant cost. Often, developers wish
to launch specialized smaller services without having to grapple with
complicated orchestration, and this wish is what spawned _serverless_ computing.
Despite its somewhat misleading name, serverless doesn't imply the absence of a
server. Instead, it means that the responsibility of server management has
shifted from the developer to a third party provider.

\subsection{Major vendors in Serverless}

The concept of "the cloud" isn't owned by any single organization, but rather,
through the collective effort of industry players including Amazon, Microsoft,
Google, Alibaba and DigitalOcean, among others. This essay delves into some
challenges faced by the biggest three vendors: Amazon, Google and Microsoft.

Amazon Web Services (AWS) provides [AWS Lambdas][11], a technology that hinges
on their proprietary Firecracker - a streamlined virtualization technology for
executing functions. Interestingly, for this thesis, is that Amazon's Prime
Video streaming service transitioned recently from a serverless architecture to
a monolithic system to meet specific service demands. One might question whether
this reflects the suitability of serverless systems for cloud computing, or for
specific use cases like theirs [(Kolny, M. 2023. Accessed 29.05.23)][12]. Some
discussions suggest that their need to process videos frame by frame led to
astronomical costs on their sibling company's FaaS, Amazon Lambda.

Google provides [Google Cloud Functions][13], which allow developers to write
and execute functions in languages such as Node.js, Python, Go and execute them
in response to events. Google's approach to function execution centeres around
container technology [(Wayner, P. 2018. Accessed 29.05.23)][14].

Microsoft's [Azure Functions][15] is a Faas platform that enables developers to
create and execute functions written in languages like C#, JavaScript, Python.
Similar to Google, they also harness the power of containers to execute these
functions.

---

For many companies, the cloud has proved to be a super power, where companies
can focus on deploying their own applications and services to their users
without worrying about the underlying infrastructure. Some of these benefits
include:

\begin{table}[ht] \centering \caption{Cloud Computing Benefits}
\begin{tabular}{>{\raggedright\arraybackslash}p{0.3\linewidth}
>{\raggedright\arraybackslash}p{0.6\linewidth}} \toprule \textbf{Benefit} &
\textbf{Description} \\ \midrule

\rowcolor{green!10} Cost efficiency & Cloud computing can help companies by
reducing upfront infrastructure costs and optimize expenses as they scale.
\citep{davethomas2009}. \\

Scalability & Offers the ability to efficiently scale operations and resources
in response to changing demand \citep{davethomas2009}. \\

\rowcolor{green!10} Reduced IT overhead & Cloud providers manage the underlying
infrastructure, allowing companies to focus on software.\\

Accessibility & Cloud computing enables companies to serve their services to
anyone that can connect to the internet, enabling consumers to access services
with greater freedom. \\

\bottomrule \end{tabular} \label{table:benefits} \end{table}

However, in the field of ICT, one truth prevails: the inevitability of
trade-offs. Every decision in software engineering involves weighing different
factors against each other, such as performance against simplicity, or between
speed of delivery and robustness \citep{lelekSoftwareMistakesTradeoffs2022}.
This rings especially true in the world of cloud computing where, depending on
the scale of your company, the way you set up your services on the cloud can
have large implications. Some of these trade-offs include:

\newpage

\begin{table}[ht] \centering \caption{Cloud Computing Trade-offs}
\begin{tabular}{>{\raggedright\arraybackslash}p{0.3\linewidth}
>{\raggedright\arraybackslash}p{0.6\linewidth}} \toprule \textbf{Trade-off} &
\textbf{Description} \\ \midrule

\rowcolor{red!10} Cost management & Despite its potential for cost savings,
managing and optimizing cloud expenses remains a challenge for many
organizations \citep{rimolCloudMigrationCosts2021}. \\

Energy consumption & The environmental impact and energy usage of data centers
pose significant sustainability challenges. Data centers alone account for
approximately 1\% of the world's energy consumption \citep{freitag2021}. \\

\rowcolor{red!10} Performance and Latency issues & With slow internet access,
the experience of using a cloud service can vary. Loss of data, wrong data
saved, depending on the companies strategies.\\

Data security and Privacy risks & Storing sensitive data on a third-party cloud
servers can raise concerns about data privacy, security breaches, and compliance
with regional and national regulations
\citep{subashiniSurveySecurityIssues2011}. \\

\bottomrule \end{tabular} \label{table:tradeoffs} \end{table}

Weighing these benefits and trade-offs against each other is part of any
companies cloud strategy, but more and more companies opt for adopting cloud in
some shape or form in their portfolio.

---

<!--
It is important to note is that these measurements and estimates comes with a
certain level of uncertainty, yet they offer a glimpse into the current and
future challenges of cloud computing's energy consumption. As demand for cloud
services continues to rise, there is a pressing need to explore alternative
technologies that can enhance energy efficiency without compromising on the
performance, availability and scalability of that the users expect.

One prevalent method for building cloud applications today involves using
serverless computing platforms, such as Amazon's *AWS Lambdas*, or Google's
*Cloud Functions*. These platforms let developers deploy code into containers
executed upon request. Despite the benefits, such as the ability to run software
across different architectures, this approach introduces a startup latency for
the containers. This latency is negligible for long-running services, but
significant for on-demand functions.

This thesis proposes exploring WebAssembly and the WebAssembly System Interface
(WASI) as innovative choices for deploying functions to public cloud services.
WebAssembly, originally developed for efficient execution in web browsers,
combined with WASI, enables WebAssembly to run on servers, potentially offering
a more efficient way to package and deploy functions.
-->

---

\newpage

WebAssembly, originally designed for running demanding computations in web
browsers, present a promising technology that could help reduce the energy
consumption of cloud services. It offers an interesting option for packaging
functions with its compact binary format and fast execution time. This has the
potiential to significantly reduce startup latency and resource overhead
associated with traditional serverless platforms. This increased efficiency
could lead to a direct decrease in energy consumption for cloud services, which
in turn could motivate the industry to adopt alternative technology that enable
a more sustainable cloud.

\todo{Rewrite the rest of this section, it's a bit of a mess right now}

The WebAssembly team defines WebAssembly as such:

\begin{tcolorbox}[ definitionstyle, title=WebAssembly definition, ] WebAssembly
(abbreviated Wasm) is a binary instruction format for a stack-based virtual
machine. Wasm is designed as a portable compilation target for programming
languages, enabling deployment on the web for client and server applications.

\hfill \href{https://webassembly.org}{webassembly.org}

\end{tcolorbox}

In other words, WebAssembly is a low-level code format designed to serve as a
compilation target for high-level programming languages. It's a binary format
that gets executed by a stack-based virtual machine, similar to how Java
bytecode runs on the Java Virtual Machine (JVM). It was originally designed for
running in a browser environment, and every major browser has implemented a way
for running it.

WebAssembly have promising properties that makes it interesting to investigate
if it can find a home outside the browser environment it was designed for:

\textit{Efficiency and Speed}: WebAssembly was designed to be fast, enabling
near-native performance. Its binary format is compact and designed for quick
decoding, contributing to quicker startup times, important aspects of cloud
native applications.

\textit{Safety and Security}: WebAssembly is designed to run safely in a secure
sandbox. Each WebAssembly module executes within a confined environment without
direct access to the host system's resources. This isolation of processes is
inherent in WebAssembly's design, promoting secure practices.

\textit{Portability}: WebAssembly's platform-agnostic design makes it highly
portable. It can run across a variety of different system architectures. For
cloud native applications, this means WebAssembly modules, once compiled, can
run anywhere - from the edge to the server - on any environment.

\textit{Language Support}: A large amount of programming languages can already
target WebAssembly. This means developers are not restricted to a particular
language when developing applications intended to be deployed as WebAssembly
modules. This provides greater flexibility to leverage the most suitable
languages for particular tasks.

In contrast, traditional methods such as deployment with containers or VMs can
be resource-intensive, slower to boot up, less secure due to a larger surface
attack area, and less efficient. Given these, WebAssembly, with its efficiency,
security, and portability, can potentially offer an attractive alternative
deployment method for building and running cloud native applications, like the
"Academemes" service we will explore in this essay.

WebAssembly (WASM) and [WebAssembly System Interface (WASI)][16] present
promising choices to traditional ways of deploying and hosting Function as a
Service (FaaS) platforms, offering several notable advantages, in terms of
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

In summary, introducing WASM+WASI as a component for deploying and hosting FaaS
platforms can offer significant benefits. Focusing on energy efficiency and
reduced startup times, this approach could pave the way for more sustainable,
efficient, and responsive cloud services. In the context of our "Academemes"
service, this could lead to a scalable, performant, and environmentally friendly
platform.

---

To measure power consumed by Nebula, the MQTT and Modbus TCP protocols will be
explored to read energy readings from a Gude Expert Controller 1105. Modbus is a
widely adopted industrial communication protocol that enables the exchange of
data between devices and control systems (Modbus Organization, 2012). The Modbus
TCP variant leverages the TCP/IP protocol for communication, making it suitable
for Ethernet-based networks and enabling remote monitoring and control of
devices.

The Gude Expert Controller 1105 is a building automation and control system
designed for monitoring and managing various aspects of building operations,
including energy consumption (Gude, n.d.). By integrating with this controller
via Modbus TCP, near real-time energy consumption data from the monitored
devices and systems can be retrieved.

Previous research has demonstrated the effectiveness of Modbus-based energy
monitoring in various domains. Saha et al. (2021) developed a Modbus-based
energy monitoring system for industrial applications, enabling the collection
and analysis of energy data from multiple devices. Their system facilitated
energy audits and the implementation of energy-saving strategies, resulting in
significant cost reductions.

By leveraging the Modbus TCP protocol and the Gude Expert Controller 1105,
accurate energy consumption data from the cloud computing environment can be
collected. The collected data can be analyzed and correlated with various
factors, such as workload characteristics, resource utilization, and the
deployment of different technologies (e.g., containers, WebAssembly). This
analysis contributes to a deeper understanding of the energy implications of
these technologies and provides valuable insights for optimizing energy
efficiency in cloud computing environments.

---

\subsection{Power Consumption Calculation Techniques}

In addition to communication protocols, various techniques have been explored
for calculating and estimating power consumption in computing systems. Rivoire
et al. (2007) proposed a model for estimating the power consumption of servers
based on CPU utilization and performance counters. Kansal et al. (2010)
developed a software-based technique for estimating the energy consumption of
mobile devices using a finite state machine model.

These protocols and techniques have been widely adopted in energy monitoring
systems across various domains, including industrial, commercial, and
residential settings. By leveraging these approaches, accurate energy
consumption data can be collected and analyzed, enabling informed
decision-making and the implementation of energy-efficient strategies in cloud
computing environments.

---

There are several cloud providers who have added support for running \ac{Wasm}
on their cloud offerings. Cloudflare
Workers^[https://developers.cloudflare.com/workers/runtime-apis/webassembly/],
and Fastly
Compute@Edge^[https://www.fastly.com/products/edge-compute/serverless] have
added support, while Fermyon have built an entire cloud architecture around the
binary format with their Fermyon Cloud^[https://www.fermyon.com/cloud]. Fermyon
has also open sourced their developer tool Spin^[https://www.fermyon.com/spin],
a tool that lets developers create, build and test applications written in a
supported
language^[https://developer.fermyon.com/spin/v2/language-support-overview] and
deploy it to a Fermyon Platform instance, either self-hosted or on their own
service.
