-- set project name
set_project("SPhysX")

-- set project version
set_version("5.1.2")

-- set language version: C++ 17
set_languages("cxx17")

-- global options
option("examples") -- build examples?
    set_default(true)
option_end()

-- if build on windows
if is_host("windows") then
    add_cxxflags("/Zc:__cplusplus", {tools = {"msvc", "cl"}}) -- fix __cplusplus == 199711L error
    add_cxxflags("/bigobj") -- avoid big obj
    if is_mode("debug") then
        set_runtimes("MTd")
    end
end

-- global rules
add_rules("mode.debug", "mode.release")
add_rules("plugin.vsxmake.autoupdate")
add_rules("plugin.compile_commands.autoupdate", {outputdir = ".vscode"})

-- add our own xmake-repo here
add_repositories("snow-leopard-engine-xmake-repo https://github.com/SnowLeopardEngine/xmake-repo.git dev")

function link_physx()
    -- add include dir
    add_includedirs("$(projectdir)/PhysX-CMake/physx/include", {public = true}) -- public: let other targets to auto include

    -- links
    add_linkdirs("$(projectdir)/Prebuilt/Libraries/$(plat)/$(arch)/$(mode)/")
    add_links("PhysX_static")
    add_links("PhysXCharacterKinematic_static")
    add_links("PhysXCommon_static")
    add_links("PhysXCooking_static")
    add_links("PhysXExtensions_static")
    add_links("PhysXFoundation_static")
    add_links("PhysXPvdSDK_static")
    add_links("PhysXVehicle_static")
end

-- if build examples, then include examples
if has_config("examples") then
    includes("Examples")
end