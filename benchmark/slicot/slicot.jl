using MAT

S = SUITE["SLICOT"] = BenchmarkGroup(["expmv"])

slicot_models = ["beam",
                 "build",
                 "CDplayer",
                 "eady",
                 "fom",
                 "heat-cont",
                 "heat-disc",
                 "iss",
                 "MNA_1",
                 "MNA_2",
                 "MNA_3",
                 "MNA_4",
                 "MNA_5",
                 "Orr-Som",
                 "pde",
                 "peec",
                 "random",
                 "tline"]

begin
    for si in slicot_models
        file = matopen("benchmark/slicot/" * si * ".mat")
        A = read(file, "A")
        N = eltype(A)
        n = size(A, 1)

        v =  zeros(N, n)
        v[1] = one(N)
        S[si, n, "concentrated"] = @benchmarkable expmv(-1e-3, $A, $v)

        v = fill(one(N)/sqrt(n), n)
        S[si, n, "uniform"] = @benchmarkable expmv(-1e-3, $A, $v)
    end
end
