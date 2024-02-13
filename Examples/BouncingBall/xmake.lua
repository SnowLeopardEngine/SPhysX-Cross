-- target defination, name: BouncingBall
target("BouncingBall")
    -- set target kind: executable
    set_kind("binary")

    -- add source files
    add_files("main.cpp")

    link_physx()

    -- defines
    if is_mode("debug") then
        add_defines("_DEBUG")
    end

    if is_plat("windows") then
        -- copy necessary dlls
        local dll_dir = "Prebuilt/Libraries/$(plat)/$(arch)/$(mode)/dll"

        after_build(function (target)
            os.cp(dll_dir .. "/*", target:targetdir())
        end)
    end