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

#ifdef _UNIX
#include <stdlib.h>
#include <string.h>
#else
#include <windows.h>
#endif

#pragma hdrstop

#include "bdetypes.h"
#include "srvbcd.h"
#include "ossrv.h"

struct   ld_s
{
   BYTE        b0, b1, b2, b3, b4, b5, b6, b7;
   UINT16    signExp;
};

const  int  MAXDIGITS =    64;
const  int  MAXSIGDIGITS = 18;

static   void  SetZero (TDecimal* result)
{
//Review once we have a bcc64
#if defined(__BORLANDC__) && defined(_WIN32) && !defined(__clang__)
   asm   {
   mov   edi, result
   and   byte ptr [edi].(TDecimal) signSpecialPlaces, 0x3F
   xor   ecx,ecx
   mov   cl, [edi].(TDecimal) precision
   inc   ecx
   shr   ecx, 1
   mov   al, 0
   inc   edi
   inc   edi
   rep   stosb
   }
#else 
   result->signSpecialPlaces &= 0x3F;
//   memset( &result->fraction, (result->precision+1)/2, 0);
   memset( &result->fraction, 0, (result->precision+1)/2 );
#endif
}

static  long double pow10l(INT16 power)
{
   // Reasonably fast (for 0 <= |power| <= 64) computation of 10**power
   long double x, z;
   INT16         y;

   // Invariant: y >= 0 && z*10**y == 10**power
   x = 10.0;
   y = power > 0 ? power : -power;
   z = 1.0;
   while (y > 0)
   {
      while ((y & 1) == 0)
      {
          y = y >> 1;
          x = x * x;
      }
      y--;
      z = z * x;
   }
   if (power < 0) z = 1.0 / z;
   return (z);
}

static  INT16     qdiv10(pUINT16 quadint)
{
#if defined(__BORLANDC__) && defined(_WIN32) && !defined(__clang__)
   // Replace quadint (> 0) by quadint / 10, return quadint % 10
   asm   {
   mov   esi,quadint
   mov   ecx,10
   mov   eax,[esi+4]
   xor   edx,edx
   or    eax,eax
   jz    low32
   div   ecx
   mov   [esi+4],eax
   }
low32:
   asm   {
   mov   eax,[esi]
   div   ecx
   mov   [esi],eax
   mov   eax,edx
   }
   return (_EAX);
#else
   // Replace quadint (> 0) by quadint / 10, return quadint % 10
   UINT32 q = *quadint;
   *quadint = q/10;
   return q % 10;
#endif
}
   
static  void    pack(BYTE *to, char *from, INT16 count)
{
#if defined(__BORLANDC__) && defined(_WIN32) && !defined(__clang__)
   // From bytes to nibbles, both left aligned
   asm   {
   mov   esi,from
   mov   edi,to
   xor   ecx,ecx
   mov   cx,word ptr count // CHNOTE: should this be dword?
   mov   dx,cx
   cld
   }
nextPair:
   asm   {
   lodsb
   mov   ah,al
   shl   ah,4
   dec   cx
   jnz   nextNibble
   mov   al,ah
   stosb
   jmp   done
nextNibble:
   lodsb
   and   al,15
   or    al,ah
   stosb
   loop  nextPair
   }
done:
#else
// #error Not implemented for this compiler
   // 
   int i;
   TwoNibbles twoNibbles;
   for( i = 0; i < (INT16) (count/2); i++ )
   {
      if (from[ i * 2 ] == '-')
        twoNibbles.value1 = -48;
      else
        twoNibbles.value1 = (from[ i * 2 ] - 48);
      if (from[ (i * 2) + 1] == '-')
        twoNibbles.value2 = -48;
      else
        twoNibbles.value2 = (from[ (i * 2) + 1]-48);
      *to = *((BYTE *)(&twoNibbles));
      to++;
   }
   if( (count % 2) == 1 )
   {
      twoNibbles.value1 = (from[ i * 2 ] - 48);
      twoNibbles.value2 = 0;
      *to = *((BYTE *)(&twoNibbles));
   }
#endif
}

static  void    unpack(char *to, BYTE *from, INT16 count)
{
#if defined(__BORLANDC__) && defined(_WIN32) && !defined(__clang__)
   // From to nibbles to bytes, both left aligned
   asm   {
   mov   esi,from
   mov   edi,to
   xor   ecx,ecx
   mov   cx,word ptr count
   mov   dx,cx
   cmp   cx,1              // Skip shift if # of digits == 1 (otherwise loop
   je    skipShift         // will make CX go negative). -cjo
   shr   cx,1
   }
skipShift:
   asm   {
   cld
   }
nextPair:
   asm   {
   lodsb
   mov   ah,al
   shr   al,4
   stosb
   mov   al,ah
   and   al,15
   stosb
   loop  nextPair
   and   dx,1
   jz    done
   lodsb
   shr   al,4
   stosb
   }
done:
#else
   // From to nibbles to bytes, both left aligned
   int i, iStart = 0, iToPos = 0;
   TwoNibbles * pTwoNibbles;
   for( i = iStart; i < count/2; i++ )
   {  
      pTwoNibbles = (TwoNibbles *) from;  // cast each byte as pointer to 2 Nibbles
      // convert both to char value for digit (0-9 +48)
      to[ iToPos ] = (CHAR) (pTwoNibbles->value1+48);      
      to[ iToPos + 1] = (CHAR) (pTwoNibbles->value2+48);
      from++;
      iToPos += 2;
   }
   // if there are odd # of digits, get the last one
   if( (count % 2) == 1 )
   {
      pTwoNibbles = (TwoNibbles *) from;
      to[ iToPos ] = (CHAR) (pTwoNibbles->value1+48);
      iToPos++;
   }                       
   // zero terminate string
   if( count < 64 )  // only 64 bytes allocated.
      to[ iToPos ] = (CHAR) 0;
#endif
}

void FormatBcdString(pCHAR pszBuffer, int Precision, int Scale)
{
   int i;
   int IntDigits;
   pCHAR pDecDigits, pTemp;
   pCHAR pIntDigits = (pCHAR ) malloc( 64 + 1 );
   pTemp = pIntDigits;
   strcpy( pIntDigits, pszBuffer );    // point to Integer portion digits
   pDecDigits = strstr( pIntDigits, "." );
   if( pDecDigits )
   {
      *pDecDigits = 0;  // point to decimal separator
      pDecDigits ++;
   }
   IntDigits = strlen( pIntDigits );
   for( i = 0; i < Precision; i++ )
   {
      if( ( (Precision-Scale) - i ) > IntDigits )
         pszBuffer[i] = '0';         // add leading '0's
      else if( *pIntDigits )
      {
         pszBuffer[i] = *pIntDigits;   // add Integer digits
         pIntDigits++;
      }
      else if( pDecDigits && *pDecDigits )
      {
         pszBuffer[i] = *pDecDigits;   // add Decimal digits
         pDecDigits++;
      }
      else
         pszBuffer[i] = '0';           // add Trailing '0's
   }
   pszBuffer[Precision] = 0;
   free(pTemp);
}

extern "C" DBIResult DBIFN bcdFromLongDouble (
   TDecimal* result,
   long double* val,
   UINT16 precision,
   UINT16 places
)
{
#if defined(_UNIX) || defined(_WIN64)
   double DVal;
   pCHAR pszDigits = (pCHAR ) malloc( 64 + 1 );
   memset(pszDigits, 0, 64 );
   SetZero( result );
   result->precision = (BYTE) precision;
   result->signSpecialPlaces = (BYTE) places;
   if( (*val) != 0 )
   {
     DVal = *val;
#if defined(__ANDROID__)
     sprintf(pszDigits, "%f", DVal);
#else
     gcvt( DVal, 64, pszDigits );
#endif
     FormatBcdString( pszDigits, precision, places );
     pack( result->fraction, pszDigits, precision );
     if (*val < 0)
       result->signSpecialPlaces |= (BYTE)(0x8000 >> 8);
   }
   return DBIERR_NONE;
#else
   // Based on xcvt.c from BC4 386 RTL
   long double frac, power10;
   struct ld_s *ldp = (struct ld_s *)&frac;
   char        *p, *pstop;
   UINT16    exponent, sign;
   INT16         decimals, myprec, prec, power, abspower, roundup, trailingZeros;
   DBIResult   retval = 0;
   char        ch, str[96];

   ZeroMem(str, 96);

   // if precision and places are both zero, probably from an oracle number
   // set to maximum...
   if ((precision == 0) && (places == 0)) {
      precision = 32;
      places = 15;
   }
   if (precision > 64) precision = 64;
   if (places > precision) places = precision;
   result->precision = (BYTE)precision;
   result->signSpecialPlaces = (BYTE)places;
   SetZero(result);
   frac = *val;                                  // Make local copy
   exponent = ldp->signExp;
   sign = exponent & 0x8000;
   ldp->signExp = exponent & 0x7FFF;
   if (ldp->signExp == 0x7FFF)
   {
      result->signSpecialPlaces |= 0x40;
      retval = 1;
   }
   else if (frac != 0.0)
   {
      // Estimate decimal integer digits in number by log10(2)*log2(val)
      // (Taken from xcvt.cas)
#if defined(__BORLANDC__) && defined(_WIN32) && !defined(__clang__)
      asm   {
      xor   ebx,ebx
      mov   bx,word ptr sign  // CHNOTE: should this be dword?
      rol   bx,1
      mov   ax,word ptr exponent
      and   ax,0x7FFF
      sub   ax,0x3FFF
      mov   dx,0x4D10
      imul  dx
      xchg  ax,bx
      mov   ah,0x4D
      mov   edi,ldp
      mov   al,[edi+7]
      shl   al,1
      mul   ah
      add   ax,bx
      adc   dx,0
      neg   ax
      adc   dx,0
      mov   word ptr decimals,dx
      }
#else
      // code to work around no assembly implementation for UNIX
      // Estimate decimal integer digits in number by log10(2)*log2(val)
      {
         pCHAR pTemp;
		 pCHAR pszDigits;
		 pszDigits = (pCHAR) malloc ( 65 * sizeof( CHAR ) );  // max size supported by BCD struct.
#if defined(__clang__)
		 gcvt( frac, 64, pszDigits );
#else
		 sprintf( pszDigits, "%f", frac);
#endif
		 pTemp = strchr( pszDigits, '.' );
         if( pTemp == NULL )
            decimals = 0;
         else
            decimals = pTemp - pszDigits;
         free( pszDigits );
      }
#endif

      // Scale and round
      if ((prec = decimals + places) < 0)
         return (retval);                       // Rounds to zero
      trailingZeros = 0;
      myprec = 0;
      if (prec > MAXSIGDIGITS) {
         myprec = prec;
         trailingZeros = prec - MAXSIGDIGITS;
         prec = MAXSIGDIGITS;
      }
      power = prec - decimals;
      while (power)
      {
         abspower = power >= 0 ? power : -power;
         if (abspower > 4932) abspower = 4932;
         power10 = pow10l(abspower);
         if (power < 0)
         {
            frac /= power10;
            power += abspower;
         }
         else
         {
            frac *= power10;
            power -= abspower;
         }
      }
      // Correct estimate if necessary
      if (frac >= pow10l(prec))                 // Estimate low by 1
         prec++;
      else if (frac < pow10l(prec - 1))         // Estimate high by 1
         prec--;
      if (prec < 0)
         return (retval);

      // Convert in place to 64-bit integer
#if defined(__BORLANDC__) && defined(_WIN32) && !defined(__clang__)
      asm   {
         fld   tbyte ptr frac
         fistp qword ptr frac
         fwait
      }
#else
      *(INT64*)&frac = (INT64)frac;
#endif
      p = &str[63];
      roundup = 0;
      if (prec == 0)
      {
         if ((roundup = (ldp->b0 & 0xFF) ^ 1) != 0)
            return (retval);
      }
      else
      {
         for (;;)
         {
            ch = (char)qdiv10((pUINT16)ldp);
            roundup |= ch;
            *p-- = ch;
            if (--prec == 0)
               break;
         }
      }
      // Do roundup 999... to 1000...
      if (roundup == 0)
         *p-- = '\1';

      // Pad with leading zeros as necessary, pack to result, insert sign
      if (&str[63] - p + trailingZeros > precision)
      {
         result->signSpecialPlaces |= 0x40;   // Number of digits too large
         retval = 1;
      }
      else
      {
         pstop = &str[63 - precision + trailingZeros];
         while (p > pstop)
            *p-- = '\0';
         if (myprec != 0)
                precision = myprec;
         pack(result->fraction, p + 1, precision);
         result->signSpecialPlaces |= (BYTE)(sign >> 8);
      }
   }
   return (retval);
#endif   // #ifdef _UNIX
}

extern "C" UINT16 DBIFN bcdToLongDouble(
  long double* result,
  TDecimal* val
)
{
#if defined(_UNIX) || defined(_WIN64)
   char        str[64];
   char        strP[64];
#else
   char        str[64], *strP;
#endif
   long double frac;
   long        fracl;
   INT16         digits, places, digitsDone;

   digits = val->precision;
   places = val->signSpecialPlaces & 0x3F;

   // If special bit set or bad arguments, return a "quiet" NaN
   if (val->signSpecialPlaces & 0x40 ||
       digits > 64 || places > 64 || places > digits )
   {
#if defined(__BORLANDC__) && !defined(_UNIX) && !defined(__clang__)
      asm   {
         lea   edi,result
         xor   eax,eax
         dec   eax
         stosd
         stosd
         and   ah,0x3F
         stosw
      }
#else
      *result = 0;
#endif
      return (1);
   }

   if( !digits && !places )   // Blank field, return 0 value.
   {
      *result = 0.0;
      return 0;
   }

   unpack(str, val->fraction, digits);
#if defined(_UNIX) || defined(_WIN64)
   {
      INT16 iDecPos = digits - places;
      int i;
      if( places == 0 )
        strcpy( strP, str );
      else
      {
        if( iDecPos > 0 )
           strncpy( strP, str, iDecPos );
        strP[ iDecPos ] = 0;
        strcat( strP, "." );
        strcat( strP, str + iDecPos );      
        strP[ digits + 1] = 0;
      }
      *result = atof( strP );
      if (val->signSpecialPlaces & 0x80)
         *result = -*result;
   }
#else
   strP = str;
   while (digits && *strP == '\0')
   {
      digits--;
      strP++;
   }
   if (digits == 0)
      *result = 0.0;
   else
   {
      digitsDone = 0;
      fracl = 0L;
      while (digits)
      {
         if (digitsDone < 9)
            fracl = fracl * 10L + (long)*strP++;
         else if (digitsDone <= 18)
         {
            if (digitsDone == 9)
               frac = (long double)fracl;
            frac = frac * 10.0 + (long double)*strP++;
         }
         else
         {
            frac = frac * 10.0;
         }
         digits--;
         digitsDone++;
      }
      if (digitsDone <= 9)
         frac = (long double)fracl;
      if (val->signSpecialPlaces & 0x80)
         frac = -frac;
      *result = frac / pow10l(places);
   }
#endif
   return 0;
}
