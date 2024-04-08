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
