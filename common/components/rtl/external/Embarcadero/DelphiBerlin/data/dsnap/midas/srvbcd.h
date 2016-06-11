/********************************************************
*                                                       *
*                Delphi Runtime Library                 *
*                                                       *
* Copyright(c) 2016 Embarcadero Technologies, Inc.      *
*               All rights reserved                     *
*                                                       *
*   Copyright and license exceptions noted in source    *
*                                                       *
********************************************************/

#ifndef SRVBCD_H
#define SRVBCD_H
// 1.1
extern "C" {

/*
    The length is arbitrary.  All values will be passed by reference, and
    the Decimal package will never read or write bytes not implied by the
    precision, so you are free to use more or less precision and trim your
    actual data structure to match, if you wish.  The maximum length supported
    for arithmetic will be 64 digits, due to internal buffer limits.
*/
const int OPENLEN = 32;

struct  TDecimal
{
    BYTE    precision;          // 1..64 considered valid
    BYTE    signSpecialPlaces;  // sign:1, special:1, places:6
    BYTE    fraction [OPENLEN]; // bcd nibbles, 00..99 per byte, high nibble 1st
};

struct TwoNibbles
{
    unsigned int value2 : 4;
    unsigned int value1 : 4;
};

struct  TDecimalStr
{
    BOOL    sign;
    BOOL    special;
    char    places;
    BYTE    precision;
    BYTE    szFraction [2 * OPENLEN + 1];
};

DBIResult DBIFN bcdFromLongDouble (TDecimal* result, long double* val,
                         UINT16 precision, UINT16 places);
DBIResult DBIFN bcdToLongDouble   (long double* result, TDecimal* val);

}       // extern "C"

#endif
