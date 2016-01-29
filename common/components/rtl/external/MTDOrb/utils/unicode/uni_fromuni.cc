/*
 *  Code Set Converters for MICO
 *  Copyright (C) 1997 Marcus Mueller & Thomas Holubar
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Library General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Library General Public License for more details.
 *
 *  You should have received a copy of the GNU Library General Public
 *  License along with this library; if not, write to the Free
 *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *  For more information, visit the MICO Home Page at
 *  http://www.mico.org/
 *
 * 	date     vers.  name            reason
 *	97/07/01 0.1    mueller         CREATED
 */

#include <stdio.h>
#include <string.h>

#include "uni_unicode.h"
#include "uni_base64.h"
#include "uni_strtypes.h"
#include "uni_errors.h"
#include "uni_conversion.h"

#include <stdio.h>
#include <string.h>

#ifdef _WINDOWS
#pragma warning (disable: 4305 4309 4244 4018)
// pragma warning (default: 4305 ) // turn on

#endif


static char FindException(const cexcept *array, uni_ubyte arrlen,
                          register uni_ushort unicode);

static const char uni2ebcArray[] =  /* beginning with 0x20 (32) */
{
  0x40, 0x5A, 0x7E, 0x7B, 0x5B, 0x6C, 0x50, 0x7D,  /* 0x20-0x27 ( 32- 39) */
  0x4D, 0x5D, 0x5C, 0x4E, 0x6B, 0x6D, 0x4B, 0x61,  /* 0x28-0x2F ( 40- 47) */
  0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,  /* 0x30-0x37 ( 48- 55) */
  0xF8, 0xF9, 0x7A, 0x5E, 0x4C, 0x7E, 0x6E, 0x6F,  /* 0x38-0x3F ( 56- 63) */
  0x7C, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7,  /* 0x40-0x47 ( 64- 71) */
  0xC8, 0xC9, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,  /* 0x48-0x4F ( 72- 79) */
  0xD7, 0xD8, 0xD9, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6,  /* 0x50-0x57 ( 80- 87) */
  0xE7, 0xE8, 0xE9, '\0', '\0', '\0', '\0', 0x6D,  /* 0x58-0x5F ( 88- 95) */
  '\0', 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,  /* 0x60-0x67 ( 96-103) */
  0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,  /* 0x68-0x6F (104-111) */
  0x97, 0x98, 0x99, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6,  /* 0x70-0x77 (112-119) */
  0xA7, 0xA8, 0xA9, 0x8B, 0x6A, 0x9B, '\0', '\0'   /* 0x78-0x7F (120-127) */
};

static const cexcept exc2ebcArray[] =
{
  { 0x00A2 , 0x4A } , { 0x00AC , 0x5F } , { 0x00DF , 0xE1 }
};

static const uni_ubyte uni2htmlArray[] =  /* beginning with 0xa0 (160) */
{
   69,  59,  43,  83,  /* 0xA0-0xA3 (160-163) */
   45, 102,  40,  87,  /* 0xA4-0xA7 (164-167) */
   99,  44,  76,  63,  /* 0xA8-0xAB (168-171) */
   71,  88,  86,  65,  /* 0xAC-0xAF (172-175) */

   46,  82,  90,  91,  /* 0xB0-0xB3 (176-179) */
   33,  67,  81,  68,  /* 0xB4-0xB7 (180-183) */
   42,  89,  77,  85,  /* 0xB8-0xBB (184-187) */
   54,  53,  55,  61,  /* 0xBC-0xBF (188-191) */

    4,   2,   3,   6,  /* 0xC0-0xC3 (192-195) */
    7,   5,   1,   8,  /* 0xC4-0xC7 (196-199) */
   12,  10,  11,  13,  /* 0xC8-0xCB (200-203) */
   16,  14,  15,  17,  /* 0xCC-0xCF (204-207) */

    9,  18,  21,  19,  /* 0xD0-0xD3 (208-211) */
   20,  23,  24,  94,  /* 0xD4-0xD7 (212-215) */
   22,  27,  25,  26,  /* 0xD8-0xDB (216-219) */
   28,  30,  29,  92,  /* 0xDC-0xDF (220-223) */

   35,  31,  32,  38,  /* 0xE0-0xE3 (224-227) */
   39,  37,  34,  41,  /* 0xE4-0xE7 (228-231) */
   50,  48,  49,  52,  /* 0xE8-0xEB (232-235) */
   60,  57,  58,  62,  /* 0xEC-0xEF (236-239) */

   51,  72,  75,  73,  /* 0xF0-0xF3 (240-243) */
   74,  79,  80,  47,  /* 0xF4-0xF7 (244-247) */
   78,  98,  96,  97,  /* 0xF8-0xFB (248-251) */
  100, 101,  93, 103   /* 0xFC-0xFF (252-255) */

  /* special characters : 0x22   (unicode) => "quot"  (HTML) ('"')
  **                      0x26   (unicode) => "amp"   (HTML) (&)
  **                      0x3C   (unicode) => "lt"    (HTML) (<)
  **                      0x3E   (unicode) => "gt"    (HTML) (>)
  **                      0x2122 (unicode) => "trade" (HTML) (tm)
  **                      0x2013 (unicode) => "ndash" (HTML) (en dash)
  **                      0x2014 (unicode) => "mdash" (HTML) (em dash) */
};

static const char uni2macArray[] =  /* beginning with 0xA0 (160) */
{
  0xCA, 0xC1, 0xA2, 0xA3,  /* 0xA0-0xA3 (160-163) */
  0xDB, 0xB4, '\0', 0xA4,  /* 0xA4-0xA7 (164-167) */
  0xAC, 0xA9, 0xAB, 0xC7,  /* 0xA8-0xAB (168-171) */
  0xC2, 0xD0, 0xA8, '\0',  /* 0xAC-0xAF (172-175) */

  0xA1, 0xB1, '\0', '\0',  /* 0xB0-0xB3 (176-179) */
  0xAB, 0xB5, 0xA6, 0xE1,  /* 0xB4-0xB7 (180-183) */
  '\0', 0xF5, 0xAC, 0xC8,  /* 0xB8-0xBB (184-187) */
  '\0', '\0', '\0', 0xC0,  /* 0xBC-0xBF (188-191) */

  0xCB, 0xE7, 0xE5, 0xCC,  /* 0xC0-0xC3 (192-195) */
  0x80, 0x81, 0xA6, 0x82,  /* 0xC4-0xC7 (196-199) */
  0xE9, 0x83, 0xE6, 0xE8,  /* 0xC8-0xCB (200-203) */
  0xCD, 0xCA, 0xCB, 0xCC,  /* 0xCC-0xCF (204-207) */

  '\0', 0x84, 0xF1, 0xCE,  /* 0xD0-0xD3 (208-211) */
  0xCF, 0xCD, 0x85, '\0',  /* 0xD4-0xD7 (212-215) */
  0xAF, 0xF5, 0xF3, 0xF4,  /* 0xD8-0xDB (216-219) */
  0x86, '\0', '\0', 0xA7,  /* 0xDC-0xDF (220-223) */

  0x88, 0x87, 0x89, 0x8B,  /* 0xE0-0xE3 (224-227) */
  0x8A, 0x8C, 0xBE, 0x8D,  /* 0xE4-0xE7 (228-231) */
  0x8F, 0x8E, 0x90, 0x91,  /* 0xE8-0xEB (232-235) */
  0x93, 0x92, 0x94, 0x95,  /* 0xEC-0xEF (236-239) */

  '\0', 0x96, 0x98, 0x97,  /* 0xF0-0xF3 (240-243) */
  0x99, 0x9B, 0x9A, 0xD6,  /* 0xF4-0xF7 (244-247) */
  0xBF, 0x9D, 0x9C, 0x9E,  /* 0xF8-0xFB (248-251) */
  0x9F, '\0', '\0', 0xD8   /* 0xFC-0xFF (252-255) */
};

static const cexcept exc2macArray[] =
{
  { 0x0152 , 0xCE } , { 0x0153 , 0xCF } , { 0x0178 , 0xD9 } ,
  { 0x0192 , 0xC4 } , { 0x02C6 , 0xF6 } , { 0x02C7 , 0xF9 } ,
  { 0x02C9 , 0xF8 } , { 0x02CE , 0xFE } , { 0x02D8 , 0xFF } ,
  { 0x02D9 , 0xFA } , { 0x02DA , 0xFB } , { 0x02DB , 0xFC } ,
  { 0x02DC , 0xF7 } , { 0x03A9 , 0xBD } , { 0x03C0 , 0xB9 } ,
  { 0x2013 , 0xD0 } , { 0x2014 , 0xD1 } , { 0x2018 , 0xD4 } ,
  { 0x2019 , 0xD5 } , { 0x201A , 0xE2 } , { 0x201C , 0xD2 } ,
  { 0x201D , 0xD3 } , { 0x201E , 0xE3 } , { 0x2020 , 0xA0 } ,
  { 0x2021 , 0xE0 } , { 0x2026 , 0xC9 } , { 0x2031 , 0xE4 } ,
  { 0x2039 , 0xDC } , { 0x20A0 , 0xDD } , { 0x2122 , 0xAA } ,
  { 0x2190 , 0x1C } , { 0x2191 , 0x1E } , { 0x2192 , 0x1D } ,
  { 0x2193 , 0x1F } , { 0x2202 , 0xB6 } , { 0x2205 , 0xD7 } ,
  { 0x2206 , 0xC6 } , { 0x220E , 0xA5 } , { 0x220F , 0xB8 } ,
  { 0x2211 , 0xB7 } , { 0x2215 , 0xDA } , { 0x221A , 0xC3 } ,
  { 0x221E , 0xB0 } , { 0x222B , 0xBA } , { 0x2248 , 0xC5 } ,
  { 0x2260 , 0xAD } , { 0x2264 , 0xB2 } , { 0x2265 , 0xB3 } ,
  { 0xFB01 , 0xDE } , { 0xFB02 , 0xDF }
};

static const char uni2koiArray1[] =  /* beginning with 0x0410 (1040) */
{
  0xE1, 0xE2, 0xF7, 0xE7,  /* 0x0410-0x0413 (1040-1043) */
  0xE4, 0xE5, 0xF6, 0xFA,  /* 0x0414-0x0417 (1044-1047) */
  0xE9, 0xEA, 0xEB, 0xEC,  /* 0x0418-0x041B (1048-1051) */
  0xED, 0xEE, 0xEF, 0xF0,  /* 0x041C-0x041F (1042-1055) */

  0xF2, 0xF3, 0xF4, 0xF5,  /* 0x0420-0x0423 (1056-1059) */
  0xE6, 0xE8, 0xE3, 0xFE,  /* 0x0424-0x0427 (1060-1063) */
  0xFB, 0xFD, 0xFF, 0xF9,  /* 0x0428-0x042B (1064-1067) */
  0xF8, 0xFC, 0xE0, 0xF1,  /* 0x042C-0x042F (1068-1071) */

  0xC1, 0xC2, 0xD7, 0xC7,  /* 0x0430-0x0433 (1072-1075) */
  0xC4, 0xC5, 0xD6, 0xDA,  /* 0x0434-0x0437 (1076-1079) */
  0xC9, 0xCA, 0xCB, 0xCC,  /* 0x0438-0x043B (1080-1083) */
  0xCD, 0xCE, 0xCF, 0xD0,  /* 0x043C-0x043F (1084-1087) */

  0xD2, 0xD3, 0xD4, 0xD5,  /* 0x0440-0x0443 (1088-1091) */
  0xC6, 0xC8, 0xC3, 0xDE,  /* 0x0444-0x0447 (1092-1095) */
  0xDB, 0xDD, 0xDF, 0xD9,  /* 0x0448-0x044B (1096-1099) */
  0xD8, 0xDC, 0xC0, 0xD1   /* 0x044C-0x044F (1100-1103) */
};

static const char uni2koiArray2[] =  /* beginning with 0x2550 (9552) */
{
  0xA0, 0xA1, 0xA2, 0xA4,  /* 0x0250-0x0253 (9552-9555) */
  0xA5, 0xA6, 0xA7, 0xA8,  /* 0x0254-0x0257 (9556-9559) */
  0xA9, 0xAA, 0xAB, 0xAC,  /* 0x0258-0x025B (9560-9563) */
  0xAD, 0xAE, 0xAF, 0xB0,  /* 0x025C-0x025F (9564-9567) */

  0xB1, 0xB2, 0xB4, 0xB5,  /* 0x0260-0x0263 (9568-9571) */
  0xB6, 0xB7, 0xB8, 0xB9,  /* 0x0264-0x0267 (9572-9575) */
  0xBA, 0xBB, 0xBC, 0xBD,  /* 0x0268-0x026B (9576-9579) */
  0xBE                     /* 0x026C        (9578     ) */
};

static const cexcept exc2koiArray[] =
{
  { 0xA0   , 0x9A } , { 0xA9   , 0xBF } , { 0xB0   , 0x9C } , 
  { 0xB2   , 0x9D } , { 0xB7   , 0x9E } , { 0xF7   , 0x9F } , 
  { 0x0401 , 0xB3 } , { 0x0451 , 0xA3 } , { 0x220E , 0x94 } , 
  { 0x2219 , 0x95 } , { 0x221A , 0x96 } , { 0x2248 , 0x97 } , 
  { 0x2264 , 0x98 } , { 0x2265 , 0x99 } , { 0x2320 , 0x93 } , 
  { 0x2321 , 0x9B } , { 0x2500 , 0x80 } , { 0x2502 , 0x81 } , 
  { 0x250C , 0x82 } , { 0x2510 , 0x83 } , { 0x2514 , 0x84 } , 
  { 0x2518 , 0x85 } , { 0x251C , 0x86 } , { 0x2524 , 0x87 } , 
  { 0x252C , 0x88 } , { 0x2534 , 0x89 } , { 0x253C , 0x8A } , 
  { 0x2580 , 0x8B } , { 0x2584 , 0x8C } , { 0x2588 , 0x8D } , 
  { 0x258C , 0x8E } , { 0x2590 , 0x8F } , { 0x2591 , 0x90 } , 
  { 0x2592 , 0x91 } , { 0x2593 , 0x92 }
};

static const char uni2isoArray[] =  /* beginning with 0x0100 (256) */
{
  0xC0, 0xE0, 0xC3, 0xE3,  /* 0x0100-0x0103 (256-259) */
  0xA1, 0xB1, 0xC6, 0xE6,  /* 0x0104-0x0107 (260-263) */
  0xC6, 0xE6, 0xC5, 0xE5,  /* 0x0108-0x010B (264-267) */
  0xC8, 0xE8, 0xCF, 0xEF,  /* 0x010C-0x010F (268-271) */

  0xD0, 0xF0, 0xAA, 0xBA,  /* 0x0110-0x0113 (272-275) */
  '\0', '\0', 0xCC, 0xEC,  /* 0x0114-0x0117 (276-279) */
  0xCA, 0xEA, 0xCC, 0xEC,  /* 0x0118-0x011B (280-283) */
  0xD8, 0xF8, 0xAB, 0xBB,  /* 0x011C-0x011F (284-287) */

  0xD5, 0xF5, 0xAB, 0xBB,  /* 0x0120-0x0123 (288-291) */
  0xA6, 0xB6, 0xA1, 0xB1,  /* 0x0124-0x0127 (292-295) */
  0xA5, 0xB5, 0xCF, 0xEF,  /* 0x0128-0x012B (296-299) */
  '\0', '\0', 0xC7, 0xE7,  /* 0x012C-0x012F (300-302) */

  0xA9, 0xB9, '\0', '\0',  /* 0x0130-0x0133 (304-307) */
  0xAC, 0xBC, 0xD3, 0xF3,  /* 0x0134-0x0137 (308-311) */
  0xA2, 0xC5, 0xE5, 0xA6,  /* 0x0138-0x013B (312-315) */
  0xB6, 0xA5, 0xB5, '\0',  /* 0x013C-0x013F (316-319) */

  '\0', 0xA3, 0xB3, 0xD1,  /* 0x0140-0x0143 (320-323) */
  0xF1, 0xD1, 0xF1, 0xD2,  /* 0x0144-0x0147 (324-327) */
  0xF2, '\0', 0xBD, 0xBF,  /* 0x0148-0x014B (328-331) */
  0xD2, 0xF2, '\0', '\0',  /* 0x014C-0x014F (332-335) */

  0xD5, 0xF5, '\0', '\0',  /* 0x0150-0x0153 (336-339) */
  0xC0, 0xE0, 0xA3, 0xB3,  /* 0x0154-0x0157 (340-343) */
  0xD8, 0xF8, 0xA6, 0xB6,  /* 0x0158-0x015B (344-347) */
  0xDE, 0xFE, 0xAA, 0xBA,  /* 0x015C-0x015F (348-351) */

  0xA9, 0xB9, 0xDE, 0xFE,  /* 0x0160-0x0163 (352-355) */
  0xAB, 0xBB, 0xFC, 0xAD,  /* 0x0164-0x0167 (356-359) */
  0xDD, 0xFD, 0xDE, 0xFE,  /* 0x0168-0x016B (360-363) */
  0xDD, 0xFD, 0xD9, 0xF9,  /* 0x016C-0x016F (364-367) */

  0xDB, 0xFB, 0xD9, 0xF9,  /* 0x0170-0x0173 (368-371) */
  '\0', '\0', '\0', '\0',  /* 0x0174-0x0177 (372-375) */
  '\0', 0xAC, 0xBC, 0xAF,  /* 0x0178-0x017B (376-379) */
  0xBF, 0xAE, 0xBE, '\0'   /* 0x017C-0x017F (380-383) */
};

static const cexcept exc2iso2Array[] =
{
  { 0x02C7 , 0xB7 } , { 0x02D8 , 0xA2 } , { 0x02D9 , 0xFF } , 
  { 0x02DB , 0xB2 } , { 0x02DD , 0xBD } 
};

static const cexcept exc2iso3Array[] =
{
  { 0x02D8 , 0xA2 } , { 0x02D9 , 0xFF }
};

static const cexcept exc2iso4Array[] =
{
  { 0x02C7 , 0xB7 } , { 0x02C9 , 0xAF } , { 0x02D9 , 0xFF } ,
  { 0x02DB , 0xB2 }
};

static const cexcept exc2iso7Array[] =
{
  { 0x02BC , 0xA2 } , { 0x02BD , 0xA1 } , { 0x0385 , 0xB5 } ,
  { 0x0386 , 0xB6 } , { 0x0388 , 0xB8 } , { 0x0389 , 0xB9 } ,
  { 0x038A , 0xBA } , { 0x038C , 0xBC } , { 0x038E , 0xBE } ,
  { 0x038F , 0xBF }
};

static const cexcept exc2iso8Array[] =
{
  { 0x00D7 , 0xAA } , { 0x00E7 , 0xBA } , { 0x0333 , 0xDF }
};

static const cexcept exc2iso9Array[] =
{
  { 0x011E , 0xD0 } , { 0x011F , 0xF0 } , { 0x0130 , 0xDD } ,
  { 0x0131 , 0xFD } , { 0x015E , 0xDE } , { 0x015F , 0xFE }
};

static const cexcept exc2iso10Array[] =
{
  { 0x0110 , 0xA9 } , { 0x0111 , 0xB9 } , { 0x0112 , 0xA2 } ,
  { 0x0113 , 0xB2 } , { 0x0122 , 0xA3 } , { 0x0123 , 0xB3 } ,
  { 0x012A , 0xA4 } , { 0x012B , 0xB4 } , { 0x0130 , 0xBD } ,
  { 0x0136 , 0xA6 } , { 0x0137 , 0xB6 } , { 0x0138 , 0xFF } ,
  { 0x013B , 0xA8 } , { 0x013C , 0xA8 } , { 0x014A , 0xAF } ,
  { 0x015E , 0xBE } , { 0x0160 , 0xAA } , { 0x0161 , 0xBA } ,
  { 0x0166 , 0xAB } , { 0x0167 , 0xBB } , { 0x0168 , 0xD7 } ,
  { 0x0169 , 0xF7 } , { 0x016A , 0xAE } , { 0x016B , 0xBE } ,
  { 0x017D , 0xAC } , { 0x017E , 0xBC } , { 0x0335 , 0xAD } ,
  { 0x0336 , 0xBD }
};

static const char uni2ibmArray1[] =  /* beginning with 0xA0 (160) */
{
  0xFF, 0xAD, 0x9B, 0x9C,  /* 0xA0-0xA3 (160-163) */
  0xCF, 0x9D, 0xDD, 0x15,  /* 0xA4-0xA7 (164-167) */
  0xF9, 0xB7, 0xA6, 0xAE,  /* 0xA8-0xAB (168-171) */
  0xAA, 0xF0, 0xA9, 0xEE,  /* 0xAC-0xAF (172-175) */

  0xF8, 0xF1, 0xFD, 0xFC,  /* 0xB0-0xB3 (176-179) */
  0xEF, 0xE6, 0x14, 0xF9,  /* 0xB4-0xB7 (180-183) */
  0xF7, 0xD5, 0xA7, 0xAF,  /* 0xB8-0xBB (184-187) */
  0xAC, 0xAB, 0xF3, 0xA8,  /* 0xBC-0xBF (188-191) */

  0xB7, 0xB5, 0xB6, 0xC7,  /* 0xC0-0xC3 (192-195) */
  0x8E, 0x8F, 0x92, 0x80,  /* 0xC4-0xC7 (196-199) */
  0xD4, 0x90, 0xD2, 0xD3,  /* 0xC8-0xCB (200-203) */
  0xDE, 0xD6, 0xD7, 0xD8,  /* 0xCC-0xCF (204-207) */

  0xD1, 0xA5, 0xE3, 0xE0,  /* 0xD0-0xD3 (208-211) */
  0xE2, 0xE5, 0x99, 0x8E,  /* 0xD4-0xD7 (202-215) */
  0x9D, 0xEB, 0xE9, 0xEA,  /* 0xD8-0xDB (216-219) */
  0x9A, 0xED, 0xE8, 0xE1,  /* 0xDC-0xDF (220-223) */

  0x85, 0xA0, 0x83, 0xC6,  /* 0xE0-0xE3 (224-227) */
  0x84, 0x86, 0x91, 0x87,  /* 0xE4-0xE7 (228-231) */
  0x8A, 0x82, 0x88, 0x89,  /* 0xE8-0xEB (232-235) */
  0x8D, 0xA1, 0x8C, 0x8B,  /* 0xEC-0xEF (236-239) */

  0xD0, 0xA4, 0x95, 0xA2,  /* 0xF0-0xF3 (240-243) */
  0x93, 0xE4, 0x94, 0xF6,  /* 0xF4-0xF7 (244-247) */
  0x9B, 0x97, 0xA3, 0x96,  /* 0xF8-0xFB (248-251) */
  0x81, 0xEC, 0xE7, 0x98,  /* 0xFC-0xFF (252-255) */

  '\0', '\0', 0xC6, 0xC7,  /* 0x0100-0x0103 (256-259) */
  0xA4, 0xA5, 0x8F, 0x86,  /* 0x0104-0x0107 (260-263) */
  '\0', '\0', '\0', '\0',  /* 0x0108-0x010B (264-267) */
  0xAC, 0x9F, 0xD2, 0xD4,  /* 0x010C-0x010F (268-271) */

  0xD1, 0xD0, '\0', '\0',  /* 0x0110-0x0113 (272-275) */
  '\0', '\0', '\0', '\0',  /* 0x0114-0x0117 (276-279) */
  0xA8, 0xA9, 0xB7, 0xD8,  /* 0x0118-0x011B (280-283) */
  '\0', '\0', '\0', '\0',  /* 0x011C-0x011F (284-287) */

  '\0', '\0', '\0', '\0',  /* 0x0120-0x0123 (288-291) */
  '\0', '\0', '\0', '\0',  /* 0x0124-0x0127 (292-295) */
  '\0', '\0', '\0', '\0',  /* 0x0128-0x012B (296-299) */
  '\0', '\0', '\0', '\0',  /* 0x012C-0x012F (300-302) */

  '\0', '\0', '\0', '\0',  /* 0x0130-0x0133 (304-307) */
  '\0', '\0', '\0', '\0',  /* 0x0134-0x0137 (308-311) */
  '\0', 0x91, 0x92, '\0',  /* 0x0138-0x013B (312-315) */
  '\0', 0x95, 0x96, '\0',  /* 0x013C-0x013F (316-319) */

  '\0', 0x9D, 0x88, 0xE5,  /* 0x0140-0x0143 (320-323) */
  0xE4, '\0', '\0', 0xD5,  /* 0x0144-0x0147 (324-327) */
  0xE5, '\0', '\0', '\0',  /* 0x0148-0x014B (328-331) */
  '\0', '\0', '\0', '\0',  /* 0x014C-0x014F (332-335) */

  0x8A, 0x8B, '\0', '\0',  /* 0x0150-0x0153 (336-339) */
  0xE8, 0xEA, '\0', '\0',  /* 0x0154-0x0157 (340-343) */
  0xFC, 0xFD, 0x97, 0x98,  /* 0x0158-0x015B (344-347) */
  '\0', '\0', 0xB8, 0xAD,  /* 0x015C-0x015F (348-351) */

  0xE6, 0xE7, 0xDD, 0xEE,  /* 0x0160-0x0163 (352-355) */
  0x9B, 0x9C, '\0', '\0',  /* 0x0164-0x0167 (356-359) */
  '\0', '\0', '\0', '\0',  /* 0x0168-0x016B (360-363) */
  '\0', '\0', 0xDE, 0x85,  /* 0x016C-0x016F (364-367) */

  0xEB, 0xFB, '\0', '\0',  /* 0x0170-0x0173 (368-371) */
  '\0', '\0', '\0', '\0',  /* 0x0174-0x0177 (372-375) */
  '\0', 0x8D, 0xAB, 0xBD,  /* 0x0178-0x017B (376-379) */
  0xBE, 0xA6, 0xA7, '\0'   /* 0x017C-0x017F (380-383) */
};

static const char uni2ibmArray2[] =  /* beginning with 0x2550 (9552) */
{
  0xCD, 0xBA, 0xD5, 0xD6,  /* 0x0250-0x0253 (9552-9555) */
  0xC9, 0xB8, 0xB7, 0xBB,  /* 0x0254-0x0257 (9556-9559) */
  0xD4, 0xD3, 0xC8, 0xBE,  /* 0x0258-0x025B (9560-9563) */
  0xBD, 0xBC, 0xC6, 0xC7,  /* 0x025C-0x025F (9564-9567) */

  0xCC, 0xB5, 0xB6, 0xB9,  /* 0x0260-0x0263 (9568-9571) */
  0xD1, 0xD2, 0xCB, 0xCF,  /* 0x0264-0x0267 (9572-9575) */
  0xD0, 0xCA, 0xD8, 0xD7,  /* 0x0268-0x026B (9576-9579) */
  0xCE                     /* 0x026C        (9578     ) */
};

static const cexcept exc2ibm437Array[] =
{
  { 0x0192 , 0x9F } , { 0x0393 , 0xE2 } , { 0x0398 , 0xE9 } ,
  { 0x03A0 , 0xE3 } , { 0x03A3 , 0xE4 } , { 0x03A6 , 0xE8 } ,
  { 0x03A9 , 0xEA } , { 0x03B1 , 0xE0 } , { 0x03B4 , 0xEB } ,
  { 0x03B7 , 0xFC } , { 0x03C3 , 0xE5 } , { 0x03D2 , 0xE7 } ,
  { 0x20C3 , 0x13 } , { 0x2191 , 0x18 } , { 0x2192 , 0x1A } ,
  { 0x2193 , 0x19 } , { 0x2194 , 0x1D } , { 0x2195 , 0x12 } ,
  { 0x21A8 , 0x17 } , { 0x2205 , 0xED } , { 0x2208 , 0xEE } ,
  { 0x220E , 0xFE } , { 0x2219 , 0xFA } , { 0x221A , 0xFB } ,
  { 0x221E , 0xEC } , { 0x2229 , 0xEF } , { 0x2248 , 0xF7 } ,
  { 0x2261 , 0xF0 } , { 0x2264 , 0xF3 } , { 0x2265 , 0xF2 } ,
  { 0x2310 , 0xA9 } , { 0x2319 , 0x1C } , { 0x2320 , 0xF4 } ,
  { 0x2321 , 0xF5 } , { 0x2500 , 0xC4 } , { 0x2502 , 0xB3 } ,
  { 0x250C , 0xDA } , { 0x2510 , 0xBF } , { 0x2514 , 0xC0 } ,
  { 0x2518 , 0xD9 } , { 0x251C , 0xC3 } , { 0x2524 , 0xB4 } ,
  { 0x252C , 0xC2 } , { 0x2534 , 0xC1 } , { 0x253C , 0xC5 } ,
  { 0x2580 , 0xDF } , { 0x2584 , 0xDC } , { 0x2588 , 0xDB } ,
  { 0x258C , 0xDD } , { 0x2590 , 0xDE } , { 0x2591 , 0xB0 } ,
  { 0x2592 , 0xB1 } , { 0x2593 , 0xB2 } , { 0x25B2 , 0x1E } ,
  { 0x25B6 , 0x10 } , { 0x25BC , 0x1F } , { 0x25C0 , 0x11 } ,
  { 0x263A , 0x01 } , { 0x263B , 0x02 } , { 0x2660 , 0x06 } ,
  { 0x2663 , 0x05 } , { 0x2665 , 0x03 } , { 0x2666 , 0x04 }
};

static const cexcept exc2ibm850Array[] =
{
  { 0x0192 , 0x9F } , { 0x20C3 , 0x13 } , { 0x2191 , 0x18 } ,
  { 0x2192 , 0x1A } , { 0x2193 , 0x19 } , { 0x2194 , 0x1D } ,
  { 0x2195 , 0x12 } , { 0x21A8 , 0x17 } , { 0x220E , 0xFE } ,
  { 0x2219 , 0xFA } , { 0x2319 , 0x1C } , { 0x2500 , 0xC4 } ,
  { 0x2502 , 0xB3 } , { 0x250C , 0xDA } , { 0x2510 , 0xBF } ,
  { 0x2514 , 0xC0 } , { 0x2518 , 0xD9 } , { 0x251C , 0xC3 } ,
  { 0x252C , 0xC2 } , { 0x2534 , 0xC1 } , { 0x253C , 0xC5 } ,
  { 0x2580 , 0xDF } , { 0x2584 , 0xDC } , { 0x2588 , 0xDB } ,
  { 0x2591 , 0xB0 } , { 0x2592 , 0xB1 } , { 0x2593 , 0xB2 } ,
  { 0x25B2 , 0x1E } , { 0x25B6 , 0x10 } , { 0x25BC , 0x1F } ,
  { 0x25C0 , 0x11 } , { 0x263A , 0x01 } , { 0x263B , 0x02 } ,
  { 0x2660 , 0x06 } , { 0x2663 , 0x05 } , { 0x2665 , 0x03 } ,
  { 0x2666 , 0x04 }
};

static const cexcept exc2ibm852Array[] =
{
  { 0x02C7 , 0xF3 } , { 0x02D8 , 0xF4 } , { 0x02DB , 0xF2 } ,
  { 0x02DD , 0xF1 } , { 0x20C3 , 0x13 } , { 0x2191 , 0x18 } ,
  { 0x2192 , 0x1A } , { 0x2193 , 0x19 } , { 0x2194 , 0x1D } ,
  { 0x2195 , 0x12 } , { 0x21A8 , 0x17 } , { 0x220E , 0xFE } ,
  { 0x2219 , 0xFA } , { 0x2319 , 0x1C } , { 0x2500 , 0xC4 } ,
  { 0x2502 , 0xB3 } , { 0x250C , 0xDA } , { 0x2510 , 0xBF } ,
  { 0x2514 , 0xC0 } , { 0x2518 , 0xD9 } , { 0x251C , 0xC3 } ,
  { 0x252C , 0xC2 } , { 0x2534 , 0xC1 } , { 0x253C , 0xC5 } ,
  { 0x2580 , 0xDF } , { 0x2584 , 0xDC } , { 0x2588 , 0xDB } ,
  { 0x2591 , 0xB0 } , { 0x2592 , 0xB1 } , { 0x2593 , 0xB2 } ,
  { 0x25B2 , 0x1E } , { 0x25B6 , 0x10 } , { 0x25BC , 0x1F } ,
  { 0x25C0 , 0x11 } , { 0x263A , 0x01 } , { 0x263B , 0x02 } ,
  { 0x2660 , 0x06 } , { 0x2663 , 0x05 } , { 0x2665 , 0x03 } ,
  { 0x2666 , 0x04 }
};

static const cexcept exc2ibm860Array[] =
{
  { 0xC0 , 0x91 } , { 0xC1 , 0x86 } , { 0xC2 , 0x8F }, { 0xC3 , 0x8E } ,
  { 0xC8 , 0x92 } , { 0xC9 , 0x86 } , { 0xCA , 0x89 }, { 0xCC , 0x98 } ,
  { 0xCD , 0x8B } , { 0xD2 , 0xA9 } , { 0xD3 , 0x9F }, { 0xD4 , 0x8C } ,
  { 0xD5 , 0x99 } , { 0xD9 , 0x9D } , { 0xDA , 0x96 }, { 0xE3 , 0x84 } ,
  { 0xF5 , 0x94 }
};

static const cexcept exc2ibm863Array[] =
{
  { 0xA4 , 0x98 } , { 0xA6 , 0xA0 } , { 0xA8 , 0xA4 }, { 0xAF , 0xA7 } ,
  { 0xB3 , 0xA6 } , { 0xB4 , 0xA1 } , { 0xB8 , 0xA5 }, { 0xBE , 0xAD } ,
  { 0xC0 , 0x8E } , { 0xC2 , 0x84 } , { 0xC8 , 0x91 }, { 0xCA , 0x92 } ,
  { 0xCB , 0x94 } , { 0xCE , 0xA8 } , { 0xCF , 0x95 }, { 0xD4 , 0x99 } ,
  { 0xD9 , 0x9D } , { 0xDB , 0x9E } , { 0xFA , 0x97 }
};

static const cexcept exc2ibm865Array[] =
{
  { 0xA4 , 0xAF } , { 0xFA , 0x97 }
};

static const cexcept exc2winArray[] =
{
  { 0x0118 , 0x9F } , { 0x0152 , 0x8C } , { 0x0153 , 0x9C } ,
  { 0x0160 , 0x8A } , { 0x0161 , 0x9A } , { 0x0192 , 0x83 } ,
  { 0x02C6 , 0x88 } , { 0x02DC , 0x98 } , { 0x2013 , 0x96 } ,
  { 0x2014 , 0x97 } , { 0x2018 , 0x91 } , { 0x2019 , 0x92 } ,
  { 0x201A , 0x82 } , { 0x201C , 0x93 } , { 0x201D , 0x94 } ,
  { 0x201E , 0x84 } , { 0x2020 , 0x86 } , { 0x2021 , 0x87 } ,
  { 0x2026 , 0x85 } , { 0x2031 , 0x89 } , { 0x2039 , 0x8B } ,
  { 0x20A0 , 0x9B } , { 0x2122 , 0x99 } , { 0x220F , 0x95 }
};


static const cfromunitable uni2ebcTable =
  { uni2ebcArray, 0x0020 /*   32 */, sizeof(uni2ebcArray),
    0x00000000 };

static const cfromunitable uni2macTable =
  { uni2macArray, 0x00A0 /*  160 */, sizeof(uni2macArray),
    0xF0000000 };

static const cfromunitable uni2koiTable1 =
  { uni2koiArray1, 0x0410 /* 1040 */, sizeof(uni2koiArray1),
    0x00000000 };

static const cfromunitable uni2koiTable2 =
  { uni2koiArray2, 0x2550 /* 9552 */, sizeof(uni2koiArray2),
    0x00000000 };

static const cfromunitable uni2isoTable =
  { uni2isoArray, 0x0100 /*  256 */, sizeof(uni2isoArray),
    0x00000000 };

static const cfromunitable uni2ibmTable1 =
  { uni2ibmArray1, 0x00A0 /*  160 */, sizeof(uni2ibmArray1), 0xF7FF007E };

static const cfromunitable uni2ibmTable2 =
  { uni2ibmArray2, 0x2550 /* 9552 */, sizeof(uni2ibmArray2), 0xF7FF007E };


static const cexcepttable exc2ebcTable =
  { exc2ebcArray, 3 };

static const cexcepttable exc2macTable =
  { exc2macArray, 50 };

static const cexcepttable exc2koiTable =
  { exc2koiArray, 35 };

static const cexcepttable exc2iso2Table =
  { exc2iso2Array, 5 };

static const cexcepttable exc2iso3Table =
  { exc2iso3Array, 3 };

static const cexcepttable exc2iso4Table =
  { exc2iso4Array, 4 };

static const cexcepttable exc2iso7Table =
  { exc2iso7Array, 10 };

static const cexcepttable exc2iso8Table =
  { exc2iso8Array, 3 };

static const cexcepttable exc2iso9Table =
  { exc2iso9Array, 6 };

static const cexcepttable exc2iso10Table =
  { exc2iso10Array, 28 };

static const cexcepttable exc2ibm437Table =
  { exc2ibm437Array, 63 };

static const cexcepttable exc2ibm850Table =
  { exc2ibm850Array, 37 };

static const cexcepttable exc2ibm852Table =
  { exc2ibm852Array, 37 };

static const cexcepttable exc2ibm860Table1 =
  { &exc2ibm437Array[1], 62 };

static const cexcepttable exc2ibm860Table2 =
  { exc2ibm860Array, 17 };

static const cexcepttable exc2ibm863Table1 =
  { &exc2ibm437Array[1], 62 };

static const cexcepttable exc2ibm863Table2 =
  { exc2ibm863Array, 19 };

static const cexcepttable exc2ibm865Table1 =
  { &exc2ibm437Array[1], 62 };

static const cexcepttable exc2ibm865Table2 =
  { exc2ibm865Array, 2 };

static const cexcepttable exc2winTable =
  { exc2winArray, 24 };


static const uni_ushort uni2htmlOffset   = 0x00A0; /* ( 160) */
static const uni_ubyte uni2htmlSize   = sizeof(uni2htmlArray);

static const bits32 iso7Mask = 0x289FBBC9;
static const bits32 iso8Mask = 0x7BFFFBFD;
       /* for uni=>iso8859_x translation; for region 0xA0-0xB0;
       ** if bit+1 is set, 0xA0+i will be translated to 0xA0+i;
       ** otherwise 0xA0+i cannot be translated (bit 0 is the 
       ** lowest one)  */ 

static char FindException(const cexcept *array, uni_ubyte arrlen,
                          register uni_ushort unicode)
{
  register uni_ubyte min, max, mid;
  if(array==NULL) return('\0');

  min = 0;
  max = arrlen-1;
  if(unicode <  array[min].unicode) return(0l);
  if(unicode == array[min].unicode) return(array[min].code);

  if(unicode >  array[max].unicode) return(0l);
  if(unicode == array[max].unicode) return(array[max].code);

  while(min+1 < max)
  {
    mid = (min+max)/2;
    if( unicode < array[mid].unicode )
      max = mid;
    else if( unicode > array[mid].unicode )
      min = mid;
    else /*  unicode == array[mid].unicode  */
      return(array[mid].code);
  }

  return('\0');
}


static uni_ulong
fromCRLF(const char *utf8, uni_uword *si, uni_uword chars, uni_ubyte line_type)
{
  switch(utf8[*si])
  {
    case '\r' :
     if((*si)+1 < chars)
     {
       if( (utf8[(*si)+1] == '\n') && (line_type == C_LINE_LF) )
       { (*si)++; return((uni_ulong)'\n'); }

       if( (utf8[(*si)+1] == '\n') && (line_type == C_LINE_CR) )
       { (*si)++; return((uni_ulong)'\r'); }
     }
     return((uni_ulong)'\r');

    case '\n' :
     if((*si)+1 < chars)
     {
       if( (utf8[(*si)+1] == '\r') && (line_type == C_LINE_LF) )
       { (*si)++; return((uni_ulong)'\n'); }

       if( (utf8[(*si)+1] == '\r') && (line_type == C_LINE_CR) )
       { (*si)++; return((uni_ulong)'\r'); }
     }
     return((uni_ulong)'\n');
  }

  return(utf8[*si]);
}

uni_slong uni_fromUTF8(char *dest, const char *utf8, uni_uword *chars, uni_uword *utf_read,
		   uni_ulong string_type, uni_ubyte line_type,
		   uni_uword *written)
{
  // const int somechars = (chars!=0) ? 1 : 0;  
  uni_ulong   utf7array[C_BASE64_DATA+1];
  uni_ubyte   pos=0;
  uni_ushort *utf16;
  uni_ulong  *ucs4, character;
  uni_slong    RC;
  uni_uword   ci, si, di;
  char    buffer[20], *html;
  int    iscommand, isquot, isunderline, trans;

  const cfromunitable *table1, *table2;
  const ctounitable   *check, *ibmcheck;
  const cexcepttable  *except, *ibmexcept;
  uni_ulong unknown;

  if( (string_type==C_UTF8) || (string_type==(uni_ulong)C_ASCII7) ||
      (string_type==C_ISO646) )
  {
    for(ci=si=di=0; ci < (*chars); si++)
      switch(utf8[si])
      {
        case '\0' :
          dest[di] = '\0';
          *chars = ci;
          *utf_read = si+1;
	  *written = di+1;
        return(C_OK);

        case '\r': case '\n' :
          dest[di++] = (char)fromCRLF(utf8,&si,*chars,line_type);
        break;

        default:
          dest[di++] = utf8[si];
          if( ((utf8[si] & 0x80) == 0) || ((utf8[si] & 0xC0) == 0x80) )
            ci++;

          if(string_type==(uni_ulong)C_ASCII7 ||
	     string_type==C_ISO646)
            if((utf8[si] & 0x80) != 0)
              if((utf8[si] & 0x40) != 0)
                di--;
              else
                dest[di-1] = C_ASCII7_UNKNOWN;
      }

    dest[di] = '\0';
    *utf_read = si;
    *written = di+1;
    return(C_OK);
  }

  if(string_type==(uni_ulong)C_UTF7)
  {
    dest[0] = '\0';

    for(ci=si=di=0; ci < *(chars); ci++)
      switch(utf8[si])
      {
        case '\0' :
          if(di!=0)
          {
            RC = uni_ucs4arraytoutf7
            (
              &dest[strlen(dest)],
              utf7array,
              di
            );
            if(RC!=C_OK) return(RC);
          }
          *chars = ci;
          *utf_read = si+1;
	  *written = strlen (dest) + 1;
        return(C_OK);

        case '\r': case '\n' :
          utf7array[di++] = fromCRLF(utf8,&si,*chars,line_type);
        break;

        default:
          if( (utf8[si] & 0x80) == 0 )
            utf7array[di] = (uni_ulong)utf8[si];
          else
          {
            RC = uni_utf8toucs4(&utf7array[di], &utf8[si], &pos);
            if(RC != C_OK) return(RC);
            si += pos;
          }
  
          di++;
          if(di == C_BASE64_DATA)
          {
            RC = uni_ucs4arraytoutf7
            (
              &dest[strlen(dest)],
              utf7array,
              di
            );

            if(RC!=C_OK) return(RC);
            di=0;
          }
      }

    *utf_read = si;
    *written = strlen (dest) + 1;
    return(C_OK);
  }

  if(string_type==C_UTF16 || string_type==C_UCS2)
  {
    utf16 = (uni_ushort*)dest;
    for(ci=si=di=0; si < (*chars); si++, ci++, di++)
    {
      // XXX added cast
      if((uni_uchar)utf8[si] < 0x80)
        switch(utf8[si])
        {
          case '\0' :
            *chars = ci;
            *utf_read = si+1;
          goto END_UTF16;

          case '\r': case '\n' :
            utf16[di] = (uni_ushort)fromCRLF(utf8,&si,*chars,line_type);
          break;

          default:
            utf16[di] = utf8[si];
        }
      else
      {
        RC = uni_utf8toutf16(&utf16[di], &utf8[si], &pos);
        if(RC != C_OK) return(RC);
        si += pos-1;

        if (utf16[di+1] != 0l) di++;
      }
    }

    *utf_read = si;

END_UTF16:
    *written = di;
    if(di>0)
    {
      if(utf16[di-1] != 0l) {
	utf16[di] = 0l;
	*written += 1;
      }
    }
    else
      utf16[0] = 0l;

    return(C_OK);
  }
  
  if(string_type==C_UCS4)
  {
    ucs4 = (uni_ulong*)dest;
    for(si=di=0; si < (*chars); si++, di++)
    {
      // XXX added cast
      if((uni_uchar)utf8[si] < 0x80)
        switch(utf8[si])
        {
          case '\0' :
            *chars = di;
            *utf_read = si+1;
          goto END_UCS4;

          case '\r': case '\n' :
            ucs4[di] = fromCRLF(utf8,&si,*chars,line_type);
          break;

          default:
            ucs4[di] = utf8[si];
        }
      else
      {
        RC = uni_utf8toucs4(ucs4, utf8, &pos);
        if(RC != C_OK) return(RC);
        si += pos-1;
      }
    }

    *utf_read = si;

END_UCS4:
    *written = di;
    if(di>0)
    {
      if(ucs4[di-1] != 0l)
      {
	ucs4[di] = 0l;
	*written += 1;
      }
    }
    else
      ucs4[0] = 0l;

    return(C_OK);
  }

  if(string_type==(uni_ulong)C_HTML3)
  {
    iscommand=isquot=isunderline=false;

    for(ci=si=di=0; si < (*chars); ci++)
    {
      if( (utf8[si] & 0x80) == 0 )
      {
        switch(utf8[si])
        {
          case '\0' :
            dest[di] = '\0';
            *chars = ci;
            *utf_read = si+1;
	    *written = di+1;
          return(C_OK);

          case '\n' : case '\r' :
            dest[di++] = (char)fromCRLF(utf8,&si,*chars,line_type);
          break;

          case '"' :
            if(iscommand)
            {
              dest[di++] = '"';
              isquot = !isquot;
            }
            else
            {
              strcpy(&dest[di], "&quot;");
              di += 6;
            }
          break;

          case '&' :
            if(iscommand)
              dest[di++] = '&';
            else
            {
              strcpy(&dest[di], "&amp;");
              di += 5;
            }
          break;

          case '<' :
            if(iscommand)
              dest[di++] = '<';
            else
            {
              strcpy(&dest[di], "&lt;");
              di += 4;
            }
          break;

          case '>' :
            if(iscommand)
            {
              dest[di++] = '>';
              if(!isquot) iscommand=false;
            }
            else
            {
              strcpy(&dest[di], "&gt;");
              di += 4;
            }
          break;

          case '\033' /* ESC */ :
            if(iscommand)
              dest[di++] = '\033';
            else
            {
              if(utf8[si+1] == '<')
              {
                iscommand=true;
                if( (utf8[si+1] == '_') && (utf8[si+2] != '\033') )
                {
                  isunderline=true;
                  strcpy(&dest[di],"<U>");
                  di+=3;
                  si++;
                }
              }
            }
          break;

          default :
            dest[di++] = utf8[si];
        }

        si++;
      }
      else if(iscommand)
      {
        dest[di] = utf8[si];
        di++; si++;
      }
      else
      {
        RC = uni_utf8toucs4(&character, &utf8[si], &pos);
        if(RC != C_OK) return(RC);
        si+=pos;

        switch(character)
        {
          case 0x2122 :
            strcpy(&dest[di], "&trade;");
            di += 7;
          break;

          case 0x2013 :
            strcpy(&dest[di], "&ndash;");
            di += 7;
          break;

          case 0x2014 :
            strcpy(&dest[di], "&mdash;");
            di += 7;
          break;

          default :
            if( (character >= uni2htmlOffset) &&
                (character <  uni2htmlOffset+uni2htmlSize) )
            {
              pos = uni2htmlArray[ character-uni2htmlOffset ];
              dest[di++] = '&';
              html = (char*)&uni_html2uniArray[pos-1].upper;
#ifdef C_LITTLE_ENDIAN
              if(html[3] != ' ') dest[di++] = html[3]; else goto cont;
              if(html[2] != ' ') dest[di++] = html[2]; else goto cont;
              if(html[1] != ' ') dest[di++] = html[1]; else goto cont;
              if(html[0] != ' ') dest[di++] = html[0]; else goto cont;
              html = (char*)&uni_html2uniArray[pos-1].lower;
              if(html[3] != ' ') dest[di++] = html[3]; else goto cont;
              if(html[2] != ' ') dest[di++] = html[2]; else goto cont;
              if(html[1] != ' ') dest[di++] = html[1]; else goto cont;
              if(html[0] != ' ') dest[di++] = html[0]; else goto cont;
#else
              if(html[0] != ' ') dest[di++] = html[0]; else goto cont;
              if(html[1] != ' ') dest[di++] = html[1]; else goto cont;
              if(html[2] != ' ') dest[di++] = html[2]; else goto cont;
              if(html[3] != ' ') dest[di++] = html[3]; else goto cont;
              html = (char*)&uni_html2uniArray[pos-1].lower;
              if(html[0] != ' ') dest[di++] = html[0]; else goto cont;
              if(html[1] != ' ') dest[di++] = html[1]; else goto cont;
              if(html[2] != ' ') dest[di++] = html[2]; else goto cont;
              if(html[3] != ' ') dest[di++] = html[3]; else goto cont;
#endif
cont:         dest[di++] = ';';
            }
            else
            {
              sprintf(buffer, "&#%lu;", character);
              strcpy(&dest[di], buffer);
              di += strlen(buffer);
            }
          break;
        }
      }

      if(isunderline && (utf8[si-1] != '_'))
      {
        strcpy(&dest[di],"</U>");
        di += 4;
        isunderline=false;
      }
    }

    dest[di] = '\0';
    *utf_read = si;
    *written = di+1;
    return(C_OK);
  }

  if( (string_type==C_ISO8859_1) || (string_type==C_ISO8859_5) ||
      (string_type==C_ISO8859_6) || (string_type==C_ISO8859_7) ||
      (string_type==C_ISO8859_8) || (string_type==C_ISO8859_9) ||
      (string_type==(uni_ulong)C_WIN31_LATIN1) )
  {
    for(ci=si=di=0; si < (*chars); ci++, di++)
    {
      if( (utf8[si] & 0x80) == 0)
      {
        switch(utf8[si])
        {
          case '\0' :
            dest[di] = '\0';
            *chars = ci;
            *utf_read = si+1;
	    *written = di+1;
          return(C_OK);

          case '\n' : case '\r' :
            dest[di] = (char)fromCRLF(utf8,&si,*chars,line_type);
          break;

          default:
            dest[di] = utf8[si];
        }

        si++;
      }
      else
      {
        RC = uni_utf8toucs4(&character, &utf8[si], &pos);
        if(RC != C_OK) return(RC);
        si+=pos;

        switch(string_type)
        {
          case C_ISO8859_1 :
            if(character <= 0xFF)
              dest[di] = (char)character;
            else
              dest[di] = C_ISO8859_1_UNKNOWN;
          break;

          case C_ISO8859_5 :
            if((character >= 0x0400) && (character <= 0x045F))
              if( (character != 0x040D) && (character != 0x045E) )
                dest[di] = (char)(character - 0x0400 + 0xA0);
              else dest[di] = C_ISO8859_6_UNKNOWN;
            else switch(character)
            {
              case 0xAD : dest[di] = 0xAD;
              case 0xA7 : dest[di] = 0xFE;
              default   : dest[di] = C_ISO8859_5_UNKNOWN;
            }
          break;

          case C_ISO8859_6 :
            if((character >= 0x0600) && (character <= 0x065F))
              if( (character != 0x0604) && (character != 0x060D) )
                dest[di] = (char)(character - 0x0600 + 0xA0);
              else dest[di] = C_ISO8859_6_UNKNOWN;
            else switch(character)
            {
              case 0xA4 : dest[di] = 0xA4;
              case 0xAD : dest[di] = 0xAD;
              default   : dest[di] = C_ISO8859_6_UNKNOWN;
            }
          break;

          case C_ISO8859_7 :
            if((character >= 0x0390) && (character <= 0x03CF))
              dest[di] = (char)(character - 0x0390 + 0xC0);
            else
            {
              if( (character >= 0x00A0) && (character <= 0x00BF) )
                if( (( 1 << (character - 0x00A0) ) & iso7Mask) != 0 )
                  dest[di] = (char)character;
                else
                  dest[di] = C_ISO8859_7_UNKNOWN;
              else
              {
                dest[di] = FindException(exc2iso7Table.array,
                  exc2iso7Table.size, character);
                if(dest[di] == '\0') dest[di] = C_ISO8859_7_UNKNOWN;
              }
            }
          break;

          case C_ISO8859_8 :
            if((character >= 0x05D0) && (character <= 0x05EF))
              dest[di] = (char)(character - 0x05D0 + 0xE0);
            else
            {
              if( (character >= 0x00A0) && (character <= 0x00BF) )
                if( (( 1 << (character - 0x00A0) ) & iso8Mask) != 0 )
                  dest[di] = (char)character;
                else
                  dest[di] = C_ISO8859_8_UNKNOWN;
              else
              {
                dest[di] = FindException(exc2iso8Table.array,
                  exc2iso8Table.size, character);
                if(dest[di] == '\0') dest[di] = C_ISO8859_8_UNKNOWN;
              }
            }
          break;

          case C_ISO8859_9 :
            if(character <= 0xFF)
              switch(character)
              {
                case 0xD0: case 0xF0: case 0xDD: case 0xFD: case 0xDE:
                case 0xFE: dest[di] = C_ISO8859_9_UNKNOWN; break;
                default : dest[di] = (char)character;
              }
            else
            {
              dest[di] = FindException(exc2iso9Table.array,
                exc2iso9Table.size, character);
              if(dest[di] == '\0') dest[di] = C_ISO8859_9_UNKNOWN;
            }
          break;

          case (uni_ulong)C_WIN31_LATIN1 :
            trans=false;

            if(character <= 0x81)
              dest[di] = (char)character;
            else if(character <= 0x9F)
              if( ( (character >= 0x8D) && (character <= 0x90) ) ||
                    (character == 0x9D) || (character == 0x9E) )
                dest[di] = C_WIN31_LATIN1_UNKNOWN;
              else trans=true;
            else if(character <= 0xFF)
              dest[di] = (char)character;
            else trans=true;

            if(trans)
            {
              dest[di] = FindException(exc2winTable.array,
                exc2winTable.size, character);
              if(dest[di] == '\0') dest[di] = C_WIN31_LATIN1_UNKNOWN;
            }
          break;

        }
      }
    }

    dest[di] = '\0';
    *utf_read = si;
    *written = di+1;
    return(C_OK);
  }


  table1=table2=NULL;
  check=ibmcheck=NULL;
  except=ibmexcept=NULL;

  switch(string_type)
  {
    case (uni_ulong)C_EBCDIC:
      table1      = &uni2ebcTable;
      unknown     = C_EBCDIC_UNKNOWN;
    break;

    case (uni_ulong)C_MACINTOSH:
      table1      = &uni2macTable;
      unknown     = C_MACINTOSH_UNKNOWN;
      except      = &exc2macTable;
    break;

    case (uni_ulong)C_KOI8_R:
      table1      = &uni2koiTable1;
      table2      = &uni2koiTable2;
      unknown     = C_KOI8_R_UNKNOWN;
      except      = &exc2koiTable;
    break;

    case C_ISO8859_2:
      table1      = &uni2isoTable;
      unknown     = C_ISO8859_2_UNKNOWN;
      except      = &exc2iso2Table;
      check       = &uni_iso22uniTable;
    break;

    case C_ISO8859_3:
      table1      = &uni2isoTable;
      unknown     = C_ISO8859_3_UNKNOWN;
      except      = &exc2iso3Table;
      check       = &uni_iso32uniTable;
    break;

    case C_ISO8859_4:
      table1      = &uni2isoTable;
      unknown     = C_ISO8859_4_UNKNOWN;
      except      = &exc2iso4Table;
      check       = &uni_iso42uniTable;
    break;

    case C_ISO8859_10:
      table1      = &uni2isoTable;
      unknown     = C_ISO8859_10_UNKNOWN;
      except      = &exc2iso10Table;
      check       = &uni_iso102uniTable;
    break;

    case C_IBM_437:
      table1      = &uni2ibmTable1;
      table2      = &uni2ibmTable2;
      unknown     = C_IBM_437_UNKNOWN;
      except      = &exc2ibm437Table;
      check       = &uni_ibm4372uniTable;
    break;

    case C_IBM_850:
      table1      = &uni2ibmTable1;
      table2      = &uni2ibmTable2;
      unknown     = C_IBM_850_UNKNOWN;
      except      = &exc2ibm850Table;
      check       = &uni_ibm8502uniTable;
    break;

    case C_IBM_852:
      table1      = &uni2ibmTable1;
      table2      = &uni2ibmTable2;
      unknown     = C_IBM_852_UNKNOWN;
      except      = &exc2ibm852Table;
      check       = &uni_ibm8522uniTable;
    break;

    case C_IBM_860:
      table1      = &uni2ibmTable1;
      table2      = &uni2ibmTable2;
      unknown     = C_IBM_860_UNKNOWN;
      except      = &exc2ibm860Table1;
      ibmexcept   = &exc2ibm860Table2;
      check       = &uni_ibm8602uniTable;
      ibmcheck    = &uni_ibm4372uniTable;
    break;

    case C_IBM_863:
      table1      = &uni2ibmTable1;
      table2      = &uni2ibmTable2;
      unknown     = C_IBM_863_UNKNOWN;
      except      = &exc2ibm863Table1;
      ibmexcept   = &exc2ibm863Table2;
      check       = &uni_ibm8632uniTable;
      ibmcheck    = &uni_ibm4372uniTable;
    break;

    case C_IBM_865:
      table1      = &uni2ibmTable1;
      table2      = &uni2ibmTable2;
      unknown     = C_IBM_865_UNKNOWN;
      except      = &exc2ibm865Table1;
      ibmexcept   = &exc2ibm865Table2;
      check       = &uni_ibm8652uniTable;
      ibmcheck    = &uni_ibm4372uniTable;
    break;

    default: return(C_UNKNOWN_FORMAT);
  }


  for(ci=si=di=0; si < (*chars); ci++, di++)
  {
    if( (utf8[si] & 0x80) == 0 )
    {
      character = (uni_ubyte)utf8[si];
      if( character < 32)
      {
        trans = ( (table1->transMask & (1 << character)) != 0 );
        switch(utf8[si])
        {
          case '\0' :
            dest[di] = '\0';
            *chars = ci;
            *utf_read = si+1;
	    *written = di+1;
          return(C_OK);

          case '\n' : case '\r' :
            character = fromCRLF(utf8,&si,*chars,line_type);
          break;
        }
      }
      else
        trans = false;

      si++;
    }
    else
    {
      RC = uni_utf8toucs4(&character, &utf8[si], &pos);
      if(RC != C_OK) return(RC);
      si+=pos;
      trans=true;
    }

    if(trans)
    {
      if( (check!=NULL) && (character <= 0xFF) )
        if( (character >= check->offset) &&
            (character <  check->offset + check->size) )
          if( check->array[ character - check->offset ] == character )
          {
            dest[di] = (char)character;
            trans=false;
          }

      if( trans && (character >= table1->offset) && 
                   (character <  table1->offset + table1->size) )
      {
        dest[di] = table1->array[character - table1->offset];
        if(check!=NULL)
          if( ((uni_ubyte)dest[di] >= check->offset) &&
              ((uni_ubyte)dest[di] <  check->offset + check->size) )
            if(check->array[ (uni_ubyte)dest[di] - check->offset ] == character)
              trans=false;
            else dest[di]='\0';
          else if(ibmcheck!=NULL)
            if( ((uni_ubyte)dest[di] >= ibmcheck->offset) &&
                ((uni_ubyte)dest[di] <  ibmcheck->offset + ibmcheck->size) )
              if(ibmcheck->array[ (uni_ubyte)dest[di] - ibmcheck->offset ]
                              == character)
                trans=false;
              else dest[di]='\0';
            else trans=false;
          else trans=false;
        else trans=false;
      }

      if( trans && (table2!=NULL) )
        if( (character >= table2->offset) && 
            (character <  table2->offset + table2->size) )
        {
          dest[di] = table2->array[character - table2->offset];
          if(check!=NULL)
            if( ((uni_ubyte)dest[di] >= check->offset) &&
                ((uni_ubyte)dest[di] <  check->offset + check->size) )
              if(check->array[ (uni_ubyte)dest[di] - check->offset ] == character)
                trans=false;
              else dest[di]='\0';
            else trans=false;
          else trans=false;
        }

      if(trans)
      {
        dest[di] = FindException(except->array, except->size, character);
        if( (ibmexcept!=NULL) && (dest[di] == '\0') &&
            (character <= 0xFF) )
          dest[di] = FindException(ibmexcept->array, ibmexcept->size,
                                   character);
      }

      if(dest[di] == '\0') dest[di] = unknown;
    }
    else dest[di] = (char)character;
  }

  dest[di] = '\0';
  *utf_read = si;
  *written = di+1;
  return(C_OK);
}
