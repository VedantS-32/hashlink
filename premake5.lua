project "libhl"
	kind "SharedLib"
	language "C"
	staticruntime "off"
	systemversion "latest"
	flags { "MultiProcessorCompile" }

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    
    includedirs {
        "src",
        "include",
        "include/pcre"
    }
    
    files {
        -- PCRE sources
        "include/pcre/pcre2_auto_possess.c",
        "include/pcre/pcre2_chartables.c",
        "include/pcre/pcre2_compile.c",
        "include/pcre/pcre2_config.c",
        "include/pcre/pcre2_context.c",
        "include/pcre/pcre2_convert.c",
        "include/pcre/pcre2_dfa_match.c",
        "include/pcre/pcre2_error.c",
        "include/pcre/pcre2_extuni.c",
        "include/pcre/pcre2_find_bracket.c",
        "include/pcre/pcre2_jit_compile.c",
        "include/pcre/pcre2_maketables.c",
        "include/pcre/pcre2_match_data.c",
        "include/pcre/pcre2_match.c",
        "include/pcre/pcre2_newline.c",
        "include/pcre/pcre2_ord2utf.c",
        "include/pcre/pcre2_pattern_info.c",
        "include/pcre/pcre2_script_run.c",
        "include/pcre/pcre2_serialize.c",
        "include/pcre/pcre2_string_utils.c",
        "include/pcre/pcre2_study.c",
        "include/pcre/pcre2_substitute.c",
        "include/pcre/pcre2_substring.c",
        "include/pcre/pcre2_tables.c",
        "include/pcre/pcre2_ucd.c",
        "include/pcre/pcre2_valid_utf.c",
        "include/pcre/pcre2_xclass.c",
        
        -- Standard library sources
        "src/std/array.c",
        "src/std/buffer.c",
        "src/std/bytes.c",
        "src/std/cast.c",
        "src/std/date.c",
        "src/std/debug.c",
        "src/std/error.c",
        "src/std/file.c",
        "src/std/fun.c",
        "src/std/maps.c",
        "src/std/math.c",
        "src/std/obj.c",
        "src/std/random.c",
        "src/std/regexp.c",
        "src/std/socket.c",
        "src/std/string.c",
        "src/std/sys.c",
        "src/std/track.c",
        "src/std/types.c",
        "src/std/ucs2.c",
        "src/std/thread.c",
        "src/std/process.c",
        
        -- Core sources
        "src/hl.h",
        "src/gc.c",
    }
    
    defines {
        "LIBHL_EXPORTS",
        "PCRE2_CODE_UNIT_WIDTH=16",
        "SUPPORT_JIT"
    }

    filter "action:vs*"
        buildoptions { "/utf-8" }
        postbuildcommands {
            ("{MKDIR} %{wks.location}/bin/" .. outputdir .. "/CGraphicsSandbox"),
            ("{COPY} %{cfg.buildtarget.relpath} %{wks.location}/bin/" .. outputdir .. "/CGraphicsSandbox")
        }

    filter "action:not vs*"
        postbuildcommands {
            ("mkdir -p \"%{wks.location}/bin/" .. outputdir .. "/CGraphicsSandbox\"|| exit 0"),
            ("cp -f %{cfg.buildtarget.relpath} %{wks.location}/bin/" .. outputdir .. "/CGraphicsSandbox")
        }

    filter "system:windows"
        defines {"_USRDLL", "HAVE_CONFIG_H", "PCRE2_CODE_UNIT_WIDTH=16"}
        links {"ws2_32.lib"}

    filter {"system:not windows"}
        defines {"HAVE_CONFIG_H", "PCRE2_CODE_UNIT_WIDTH=16"}
        links {"m", "dl", "pthread"}

    filter {"system:macosx"}
        files {
            "include/mdbg/mdbg.c",
            "include/mdbg/mach_excServer.c",
            "include/mdbg/mach_excUser.c"
        }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

-- project "hashlink"
-- 	kind "StaticLib"
-- 	language "C"
-- 	staticruntime "off"
-- 	systemversion "latest"
-- 	flags { "MultiProcessorCompile" }

--     targetdir ("bin/" .. outputdir .. "/%{prj.name}")
-- 	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    
--     includedirs {
--         "src",
--     }
    
--     files {        
--         -- Core sources
--         "src/hlmodule.h",
--         "src/code.c",
--         "src/module.c",
--         "src/opcodes.h",
--         "src/jit.c",
--         "src/profile.c",
--         "src/debugger.c",
--     }

--     defines {
--         "LIBHL_STATIC"
--     }

--     links {"libhl"}

--     filter "system:windows"
--         links {"ws2_32.lib"}

--     filter {"system:not windows"}
--         defines {"HAVE_CONFIG_H", "PCRE2_CODE_UNIT_WIDTH=16"}
--         links {"m", "dl", "pthread"}

--     filter {"system:macosx"}
--         files {
--             "include/mdbg/mdbg.c",
--             "include/mdbg/mach_excServer.c",
--             "include/mdbg/mach_excUser.c"
--         }

-- 	filter "configurations:Debug"
-- 		runtime "Debug"
-- 		symbols "on"

-- 	filter "configurations:Release"
-- 		runtime "Release"
-- 		optimize "on"