using BinDeps

@BinDeps.setup

if is_windows()

    link = "https://github.com/peterwittek/somoclu/releases/download/1.7.2/somoclu-1.7.3-pre.tar.gz"
    libsomoclu = library_dependency("libsomoclu", aliases=["libsomoclu", "libsomoclu.dll"], os=:Windows)
    provides(Sources, Dict(URI(link) => libsomoclu))
    provides(BuildProcess, Autotools(libtarget = joinpath("src", "libsomoclu.dll"), configure_options=[AbstractString("--without-mpi")]), libsomoclu, os = :Windows)
    @BinDeps.install Dict(:libsomoclu => :libsomoclu)
    
else

    link = "https://github.com/peterwittek/somoclu/releases/download/1.7.2/somoclu-1.7.3-pre.tar.gz"
    libsomoclu = library_dependency("libsomoclu", aliases=["libsomoclu", "libsomoclu.so"], os=:Unix)
    provides(Sources, Dict(URI(link) => libsomoclu))
    provides(BuildProcess, Autotools(libtarget = joinpath("src", "libsomoclu.so"), configure_options=[AbstractString("--without-mpi")]), libsomoclu, os = :Unix)
    @BinDeps.install Dict(:libsomoclu => :libsomoclu)
end