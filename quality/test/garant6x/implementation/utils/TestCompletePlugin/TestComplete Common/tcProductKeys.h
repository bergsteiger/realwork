// =============================================================================================
// AutomatedQA SDK - Copyright (c) AutomatedQA Corp.
//
// This file is part of AutomatedQA SDK
//
// =============================================================================================
// 
// NOTE: Keep this file synchronized with tcProductKeys.pas
//

#pragma once

  // =====================================================
  // NOTE: Do not change these product keys!!!
  // =====================================================

extern "C" const GUID __declspec(selectany) cProductKey_TC_Enterprise     =
    {0xD0D30094, 0xD31C, 0x48f8, {0xB4, 0x28, 0x72, 0xD9, 0x5A, 0x73, 0x8C, 0xF3}};
extern "C" const GUID __declspec(selectany) cProductKey_TC_EnterpriseDemo =
    {0xD0D30094, 0x321C, 0x41d3, {0xBE, 0xEC, 0x73, 0xC0, 0xFE, 0xC5, 0xCD, 0x12}};

extern "C" const GUID __declspec(selectany) cProductKey_TC_Standard       =
    {0xE0D30094, 0x47D6, 0x477f, {0xA6, 0xD7, 0x0C, 0xA9, 0x7F, 0xB9, 0x1A, 0x43}};
extern "C" const GUID __declspec(selectany) cProductKey_TC_StandardDemo   =
    {0xE0D30094, 0xE78C, 0x4611,{0xA7, 0x8C, 0xE0, 0xB0, 0x53, 0x11, 0x8A, 0xF5}};

extern "C" const GUID __declspec(selectany) cProductKey_TC_Personal       =
    {0xF0D30094, 0xD9CD, 0x410e, {0xAD, 0x06, 0xA9, 0x71, 0xDC, 0x4D, 0xC7, 0x5B}};
extern "C" const GUID __declspec(selectany) cProductKey_TC_PersonalDemo   =
    {0xF0D30094, 0xCD34, 0x4272, {0x80, 0xA0, 0x71, 0xD4, 0x3D, 0xC1, 0xDF, 0xDD}};

extern "C" const GUID __declspec(selectany) cProductKey_TE_Enterprise     =
    {0xC0D30094, 0x2F7F, 0x4669, {0x9A, 0x33, 0xFB, 0x08, 0x1D, 0x60, 0x64, 0x5B}};
extern "C" const GUID __declspec(selectany) cProductKey_TE_EnterpriseDemo =
    {0xC0D30094, 0xF86B, 0x427d, {0x86, 0x42, 0xE4, 0xDD, 0xDE, 0x3D, 0x55, 0x1B}};

extern "C" const GUID __declspec(selectany) cProductKey_TE_Standard       =
    {0xB0D30094, 0x47ED, 0x48fe, {0x81, 0x36, 0x7B, 0xEA, 0xC0, 0xCE, 0x35, 0x29}};
extern "C" const GUID __declspec(selectany) cProductKey_TE_StandardDemo   =
    {0xB0D30094, 0x48F3, 0x4af0, {0xB1, 0x59, 0x60, 0x67, 0xB7, 0x56, 0xEA, 0x6D}};

extern "C" const GUID __declspec(selectany) cProductKey_TR                =
    {0xA0D30094, 0xEE9A, 0x45a5, {0xA5, 0x81, 0xBA, 0x8E, 0x54, 0x4D, 0xE1, 0xDC}};
extern "C" const GUID __declspec(selectany) cProductKey_TR_Demo           =
    {0xA0D30094, 0x4E82, 0x49e4, {0xA7, 0x96, 0xF3, 0x0D, 0x7F, 0x8E, 0xD8, 0x12}};


extern "C" const GUID __declspec(selectany) * cAllProduct[] =
{
	&cProductKey_TC_Enterprise     ,
	&cProductKey_TC_EnterpriseDemo ,
	&cProductKey_TC_Standard       ,
	&cProductKey_TC_StandardDemo   ,
	&cProductKey_TC_Personal       ,
	&cProductKey_TC_PersonalDemo   ,
	&cProductKey_TE_Enterprise     ,
	&cProductKey_TE_EnterpriseDemo ,
	&cProductKey_TE_Standard       ,
	&cProductKey_TE_StandardDemo   ,
	&cProductKey_TR                ,
	&cProductKey_TR_Demo
};

extern "C" const GUID __declspec(selectany) * cTCProduct[] =
{
	&cProductKey_TC_Enterprise     ,
	&cProductKey_TC_EnterpriseDemo ,
	&cProductKey_TC_Standard       ,
	&cProductKey_TC_StandardDemo   ,
	&cProductKey_TC_Personal       ,
	&cProductKey_TC_PersonalDemo
};

extern "C" const GUID __declspec(selectany) * cTEProduct[] =
{
	&cProductKey_TE_Enterprise     ,
	&cProductKey_TE_EnterpriseDemo ,
	&cProductKey_TE_Standard       ,
	&cProductKey_TE_StandardDemo
};

extern "C" const GUID __declspec(selectany) * cEnterpriseProductOnly[] =
{
        &cProductKey_TC_Enterprise     ,
        &cProductKey_TC_EnterpriseDemo ,
        &cProductKey_TE_Enterprise     ,
        &cProductKey_TE_EnterpriseDemo ,
        &cProductKey_TR                ,
        &cProductKey_TR_Demo
};
