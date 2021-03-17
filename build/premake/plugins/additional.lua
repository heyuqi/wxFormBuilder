-----------------------------------------------------------------------------
--  Name:        additional.lua
--  Purpose:     Additional controls plugin project build script.
--  Author:      Andrea Zanellato
--  Modified by:
--  Created:     21/10/2011
--  Copyright:   (c) 2011 wxFormBuilder Team
--  Licence:     GNU General Public License Version 2
-----------------------------------------------------------------------------
project "additional-components-plugin"
    kind                "SharedLib"
    targetname          "additional"
    files               {"../../../plugins/additional/additional.cpp"}
    includedirs
    {
        "../../../subprojects/ticpp", "../../../sdk/plugin_interface"
    }
    defines             {"BUILD_DLL", "TIXML_USE_TICPP"}
    links               {"plugin-interface", "TiCPP"}

if wxCompiler == "vc" then
    libs = "core,adv,html,richtext,propgrid,stc,ribbon,aui"
else
    libs = "std,richtext,propgrid,stc,ribbon,aui"
end

if wxUseMediaCtrl then
    defines             {"USE_MEDIACTRL"}
    libs                = libs .. ",media"
end

	if wxArchitecture then
		buildoptions	{"-arch " .. wxArchitecture}
	end

    configuration "not vs*"
        buildoptions        "-std=c++14"

    configuration "not windows"
        targetdir       "../../../output/lib/wxformbuilder"

    configuration "windows"
        targetprefix    "lib"
        targetdir       "../../../output/plugins/additional"

    configuration "Debug"
        targetsuffix    ( DebugSuffix )
        wx_config       { Libs=libs, Debug="yes" }

    configuration "Release"
        wx_config       { Libs=libs }

    configuration {"not vs*", "Release"}
        buildoptions    {"-fno-strict-aliasing"}
