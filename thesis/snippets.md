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
