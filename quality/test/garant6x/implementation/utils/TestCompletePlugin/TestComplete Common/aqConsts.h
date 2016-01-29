// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================
// 
// NOTE: Keep this file synchronized with aqConsts.pas
//

#pragma once

// Command Line
#define cSilentCmdLine       L"SilentMode"
#define cErrorOnlyMode       L"ErrorOnlyMode"
#define cErrorAndWarningMode L"ErrorAndWarningMode"

// Copyright
#define cAQACopyright        L"Copyright (c) AutomatedQA Corp."

// Standard actions categories
#define SAC_File    L"File"
#define SAC_Edit    L"Edit"
#define SAC_Search  L"Search"
#define SAC_View    L"View"
#define SAC_Project L"Project"
#define SAC_Options L"Options"
#define SAC_Help    L"Help"

// Actions Execute Context Type
extern "C" const GUID __declspec(selectany) AECT_NOCONTEXT_TYPE =
    {0x00000000, 0x0000, 0x0000,{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}};
extern "C" const GUID __declspec(selectany) AECT_PANELS_TYPE =
    {0x379ADD9F, 0xF930, 0x43B1,{0xB9, 0x55, 0x8A, 0x02, 0x6D, 0x2E, 0x55, 0x85}};

// Product Integration type
extern "C" const GUID __declspec(selectany) PIT_NATIVE =
    {0x7A5E736F, 0x1621, 0x4DF5,{0x99, 0xE4, 0xD7, 0xB2, 0x47, 0x16, 0xBD, 0xC1}};
extern "C" const GUID __declspec(selectany) PIT_CONSOLE =
    {0x47813466, 0xECEE, 0x4EB9,{0x94, 0x30, 0xFF, 0xB4, 0xD5, 0x7B, 0xF8, 0x03}};
extern "C" const GUID __declspec(selectany) PIT_VS_PACKAGE =
    {0x6C2B7520, 0x485E, 0x458E,{0xB6, 0xB6, 0x5F, 0x31, 0x62, 0x93, 0xED, 0x04}};
extern "C" const GUID __declspec(selectany) PIT_DELPHI_PACKAGE =
    {0xBEAF6BE4, 0xEBA4, 0x4D09,{0xB1, 0x5A, 0xC5, 0x39, 0xF9, 0xD0, 0x00, 0x90}};


extern "C" const GUID __declspec(selectany) *cAllIntegrationType[] =
{
	&PIT_NATIVE,
	&PIT_CONSOLE,
	&PIT_VS_PACKAGE,
	&PIT_DELPHI_PACKAGE
};

extern "C" const GUID __declspec(selectany) *cVisualIntegrationType[] =
{
	&PIT_NATIVE,
	&PIT_VS_PACKAGE,
	&PIT_DELPHI_PACKAGE
};

// Option slice IDs
extern "C" const GUID __declspec(selectany) SLICE_CURRENT_USER =
    {0x62556A6E, 0x9287, 0x431E,{0xAF, 0x25, 0xB2, 0x05, 0xE7, 0xAD, 0xE3, 0xCD}};
extern "C" const GUID __declspec(selectany) SLICE_USER_APP_DATA =
    {0x031E6698, 0xCCF7, 0x49F0,{0xA9, 0x56, 0xBB, 0xAF, 0xF6, 0x2C, 0xA4, 0x75}};
extern "C" const GUID __declspec(selectany) SLICE_ALL_USER =
    {0x943D33F3, 0x3D39, 0x43E3,{0x8A, 0xD5, 0x3C, 0x51, 0xCA, 0x8C, 0x21, 0xAF}};
extern "C" const GUID __declspec(selectany) SLICE_CURRENT_INTEGRATION_TYPE =
    {0x6F5594CA, 0x79FF, 0x4D20,{0x8D, 0x65, 0x1E, 0xA6, 0xDA, 0x3B, 0x5E, 0xC4}};
extern "C" const GUID __declspec(selectany) SLICE_ALL_INTEGRATION_TYPE =
    {0x80EBEF5C, 0xB5B9, 0x46D7,{0x82, 0xCC, 0xBE, 0xD1, 0x83, 0x7B, 0xAA, 0x40}};
extern "C" const GUID __declspec(selectany) SLICE_VIEW =
    {0xDB162DC1, 0x78FC, 0x43C9,{0x83, 0x0C, 0x6E, 0xA8, 0x02, 0x49, 0x7A, 0xF5}};

extern "C" const GUID __declspec(selectany) STID_Unit =
    {0x2D5FA8BA, 0x8143, 0x4F46, {0x95, 0x51, 0xF0,	0xA5, 0x2E, 0x1A, 0xFB, 0x13}};