using Pkg.Artifacts

include("artifacts_wrapper.jl")

# Get dycoms dataset folder:
dycoms_dataset =
  ArtifactsWrapper(joinpath(@__DIR__, "Artifacts.toml"), "dycoms",
    ArtifactFile[
    ArtifactFile(url="https://caltech.box.com/shared/static/bxau6i46y6ikxn2sy9krgz0sw5vuptfo.nc",
              filename="test_data_PhaseEquil.nc"),
    ]
    )
dycoms_dataset_path = get_data_folder(dycoms_dataset)


@testset "Data tests" begin
    FT = Float64
    e_int, ρ, q_tot, q_pt, T, p, θ_liq_ice = MT.tested_convergence_range(param_set, 50, FT)
    data = joinpath(dycoms_dataset_path, "test_data_PhaseEquil.nc")
    ds_PhaseEquil = Dataset(data, "r")
    e_int = Array{FT}(ds_PhaseEquil["e_int"][:])
    ρ = Array{FT}(ds_PhaseEquil["ρ"][:])
    q_tot = Array{FT}(ds_PhaseEquil["q_tot"][:])

    # ts = PhaseEquil.(Ref(param_set), e_int, ρ, q_tot) # Fails
end