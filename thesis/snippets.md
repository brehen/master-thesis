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
