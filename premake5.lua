workspace "Hazel"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir ="%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"

include "Hazel/vendor/GLFW"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/src/**/**.h",
		"%{prj.name}/src/**/**.cpp"
	}
	includedirs
	{
		"%{prj.name}/vendor/splog/include",
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}"
	}
	links
	{
		"GLFW",
		"%{prj.name}/vendor/GLFW/bin/Debug-windows-*/GLFW/GLFW.lib",
		"opengl32.lib"
	}
	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DDL"
		}
		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/SandBox")
		}

	filter "configurations:Debug"
			defines "HZ_DEBUG"
			symbols "on"

	filter "configurations:Release"
			defines "HZ_RELEASE"
			optimize "on"

	filter "configurations:Dist"
			defines "HZ_DIST"
			optimize "on"



project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}
	includedirs
	{
		"Hazel/vendor/splog/include",
		"Hazel/src"
	}
	links
	{
		"Hazel"
	}
	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
			defines "HZ_DEBUG"
			symbols "on"

	filter "configurations:Release"
			defines "HZ_RELEASE"
			optimize "on"

	filter "configurations:Dist"
			defines "HZ_DIST"
			optimize "on"