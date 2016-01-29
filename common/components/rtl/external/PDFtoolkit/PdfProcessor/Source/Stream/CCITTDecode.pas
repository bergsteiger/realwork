{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit CCITTDecode;

interface

uses
  Classes, gtObject, DecodeIntf, Stream;

//{$IFDEF CCITTDECODE}
type


  TgtCCITTCode = record
    Bits: Smallint;
    N: Smallint;
  end;

const
  INT_MAX = 2147483647;
  ccittEOL = -2;
  twoDimPass = 0;
  twoDimHoriz = 1;
  twoDimVert0 = 2;
  twoDimVertR1 = 3;
  twoDimVertL1 = 4;
  twoDimVertR2 = 5;
  twoDimVertL2 = 6;
  twoDimVertR3 = 7;
  twoDimVertL3 = 8;

  TgtTwoDimTab1: array[0..127] of TgtCCITTCode = (// 1-7 bit codes
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 000000x
    (Bits: 7; N: twoDimVertL3), // 0000010
    (Bits: 7; N: twoDimVertR3), // 0000011
    (Bits: 6; N: twoDimVertL2), (Bits: 6; N: twoDimVertL2), // 000010x
    (Bits: 6; N: twoDimVertR2), (Bits: 6; N: twoDimVertR2), // 000011x
    (Bits: 4; N: twoDimPass), (Bits: 4; N: twoDimPass), // 0001xxx
    (Bits: 4; N: twoDimPass), (Bits: 4; N: twoDimPass),
    (Bits: 4; N: twoDimPass), (Bits: 4; N: twoDimPass),
    (Bits: 4; N: twoDimPass), (Bits: 4; N: twoDimPass),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz), // 001xxxx
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimHoriz), (Bits: 3; N: twoDimHoriz),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1), // 010xxxx
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertL1), (Bits: 3; N: twoDimVertL1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1), // 011xxxx
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 3; N: twoDimVertR1), (Bits: 3; N: twoDimVertR1),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0), // 1xxxxxx
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0),
    (Bits: 1; N: twoDimVert0), (Bits: 1; N: twoDimVert0));

    { White runlegths}

   // 11-12 bit codes (upper 7 bits are 0)
  TgtWhiteTab1: array[0..31] of TgtCCITTCode = (
    (Bits: - 1; N: - 1), // 00000
    (Bits: 12; N: ccittEOL), // 00001
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 0001x
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 001xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 010xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 011xx
    (Bits: 11; N: 1792), (Bits: 11; N: 1792), // 1000x
    (Bits: 12; N: 1984), // 10010
    (Bits: 12; N: 2048), // 10011
    (Bits: 12; N: 2112), // 10100
    (Bits: 12; N: 2176), // 10101
    (Bits: 12; N: 2240), // 10110
    (Bits: 12; N: 2304), // 10111
    (Bits: 11; N: 1856), (Bits: 11; N: 1856), // 1100x
    (Bits: 11; N: 1920), (Bits: 11; N: 1920), // 1101x
    (Bits: 12; N: 2368), // 11100
    (Bits: 12; N: 2432), // 11101
    (Bits: 12; N: 2496), // 11110
    (Bits: 12; N: 2560)); // 11111

  // 1-9 bit codes
  TgtWhiteTab2: array[0..511] of TgtCCITTCode = (
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 0000000xx
    (Bits: 8; N: 29), (Bits: 8; N: 29), // 00000010x
    (Bits: 8; N: 30), (Bits: 8; N: 30), // 00000011x
    (Bits: 8; N: 45), (Bits: 8; N: 45), // 00000100x
    (Bits: 8; N: 46), (Bits: 8; N: 46), // 00000101x
    (Bits: 7; N: 22), (Bits: 7; N: 22), (Bits: 7; N: 22), (Bits: 7; N: 22), // 0000011xx
    (Bits: 7; N: 23), (Bits: 7; N: 23), (Bits: 7; N: 23), (Bits: 7; N: 23), // 0000100xx
    (Bits: 8; N: 47), (Bits: 8; N: 47), // 00001010x
    (Bits: 8; N: 48), (Bits: 8; N: 48), // 00001011x
    (Bits: 6; N: 13), (Bits: 6; N: 13), (Bits: 6; N: 13), (Bits: 6; N: 13), // 000011xxx
    (Bits: 6; N: 13), (Bits: 6; N: 13), (Bits: 6; N: 13), (Bits: 6; N: 13),
    (Bits: 7; N: 20), (Bits: 7; N: 20), (Bits: 7; N: 20), (Bits: 7; N: 20), // 0001000xx
    (Bits: 8; N: 33), (Bits: 8; N: 33), // 00010010x
    (Bits: 8; N: 34), (Bits: 8; N: 34), // 00010011x
    (Bits: 8; N: 35), (Bits: 8; N: 35), // 00010100x
    (Bits: 8; N: 36), (Bits: 8; N: 36), // 00010101x
    (Bits: 8; N: 37), (Bits: 8; N: 37), // 00010110x
    (Bits: 8; N: 38), (Bits: 8; N: 38), // 00010111x
    (Bits: 7; N: 19), (Bits: 7; N: 19), (Bits: 7; N: 19), (Bits: 7; N: 19), // 0001100xx
    (Bits: 8; N: 31), (Bits: 8; N: 31), // 00011010x
    (Bits: 8; N: 32), (Bits: 8; N: 32), // 00011011x
    (Bits: 6; N: 1), (Bits: 6; N: 1), (Bits: 6; N: 1), (Bits: 6; N: 1), // 000111xxx
    (Bits: 6; N: 1), (Bits: 6; N: 1), (Bits: 6; N: 1), (Bits: 6; N: 1),
    (Bits: 6; N: 12), (Bits: 6; N: 12), (Bits: 6; N: 12), (Bits: 6; N: 12), // 001000xxx
    (Bits: 6; N: 12), (Bits: 6; N: 12), (Bits: 6; N: 12), (Bits: 6; N: 12),
    (Bits: 8; N: 53), (Bits: 8; N: 53), // 00100100x
    (Bits: 8; N: 54), (Bits: 8; N: 54), // 00100101x
    (Bits: 7; N: 26), (Bits: 7; N: 26), (Bits: 7; N: 26), (Bits: 7; N: 26), // 0010011xx
    (Bits: 8; N: 39), (Bits: 8; N: 39), // 00101000x
    (Bits: 8; N: 40), (Bits: 8; N: 40), // 00101001x
    (Bits: 8; N: 41), (Bits: 8; N: 41), // 00101010x
    (Bits: 8; N: 42), (Bits: 8; N: 42), // 00101011x
    (Bits: 8; N: 43), (Bits: 8; N: 43), // 00101100x
    (Bits: 8; N: 44), (Bits: 8; N: 44), // 00101101x
    (Bits: 7; N: 21), (Bits: 7; N: 21), (Bits: 7; N: 21), (Bits: 7; N: 21), // 0010111xx
    (Bits: 7; N: 28), (Bits: 7; N: 28), (Bits: 7; N: 28), (Bits: 7; N: 28), // 0011000xx
    (Bits: 8; N: 61), (Bits: 8; N: 61), // 00110010x
    (Bits: 8; N: 62), (Bits: 8; N: 62), // 00110011x
    (Bits: 8; N: 63), (Bits: 8; N: 63), // 00110100x
    (Bits: 8; N: 0), (Bits: 8; N: 0), // 00110101x
    (Bits: 8; N: 320), (Bits: 8; N: 320), // 00110110x
    (Bits: 8; N: 384), (Bits: 8; N: 384), // 00110111x
    (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10), // 00111xxxx
    (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10),
    (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10),
    (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10), (Bits: 5; N: 10),
    (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11), // 01000xxxx
    (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11),
    (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11),
    (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11), (Bits: 5; N: 11),
    (Bits: 7; N: 27), (Bits: 7; N: 27), (Bits: 7; N: 27), (Bits: 7; N: 27), // 0100100xx
    (Bits: 8; N: 59), (Bits: 8; N: 59), // 01001010x
    (Bits: 8; N: 60), (Bits: 8; N: 60), // 01001011x
    (Bits: 9; N: 1472), // 010011000
    (Bits: 9; N: 1536), // 010011001
    (Bits: 9; N: 1600), // 010011010
    (Bits: 9; N: 1728), // 010011011
    (Bits: 7; N: 18), (Bits: 7; N: 18), (Bits: 7; N: 18), (Bits: 7; N: 18), // 0100111xx
    (Bits: 7; N: 24), (Bits: 7; N: 24), (Bits: 7; N: 24), (Bits: 7; N: 24), // 0101000xx
    (Bits: 8; N: 49), (Bits: 8; N: 49), // 01010010x
    (Bits: 8; N: 50), (Bits: 8; N: 50), // 01010011x
    (Bits: 8; N: 51), (Bits: 8; N: 51), // 01010100x
    (Bits: 8; N: 52), (Bits: 8; N: 52), // 01010101x
    (Bits: 7; N: 25), (Bits: 7; N: 25), (Bits: 7; N: 25), (Bits: 7; N: 25), // 0101011xx
    (Bits: 8; N: 55), (Bits: 8; N: 55), // 01011000x
    (Bits: 8; N: 56), (Bits: 8; N: 56), // 01011001x
    (Bits: 8; N: 57), (Bits: 8; N: 57), // 01011010x
    (Bits: 8; N: 58), (Bits: 8; N: 58), // 01011011x
    (Bits: 6; N: 192), (Bits: 6; N: 192), (Bits: 6; N: 192), (Bits: 6; N: 192), // 010111xxx
    (Bits: 6; N: 192), (Bits: 6; N: 192), (Bits: 6; N: 192), (Bits: 6; N: 192),
    (Bits: 6; N: 1664), (Bits: 6; N: 1664), (Bits: 6; N: 1664), (Bits: 6; N: 1664), // 011000xxx
    (Bits: 6; N: 1664), (Bits: 6; N: 1664), (Bits: 6; N: 1664), (Bits: 6; N: 1664),
    (Bits: 8; N: 448), (Bits: 8; N: 448), // 01100100x
    (Bits: 8; N: 512), (Bits: 8; N: 512), // 01100101x
    (Bits: 9; N: 704), // 011001100
    (Bits: 9; N: 768), // 011001101
    (Bits: 8; N: 640), (Bits: 8; N: 640), // 01100111x
    (Bits: 8; N: 576), (Bits: 8; N: 576), // 01101000x
    (Bits: 9; N: 832), // 011010010
    (Bits: 9; N: 896), // 011010011
    (Bits: 9; N: 960), // 011010100
    (Bits: 9; N: 1024), // 011010101
    (Bits: 9; N: 1088), // 011010110
    (Bits: 9; N: 1152), // 011010111
    (Bits: 9; N: 1216), // 011011000
    (Bits: 9; N: 1280), // 011011001
    (Bits: 9; N: 1344), // 011011010
    (Bits: 9; N: 1408), // 011011011
    (Bits: 7; N: 256), (Bits: 7; N: 256), (Bits: 7; N: 256), (Bits: 7; N: 256), // 0110111xx
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), // 0111xxxxx
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2), (Bits: 4; N: 2),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), // 1000xxxxx
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3), (Bits: 4; N: 3),
    (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128), // 10010xxxx
    (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128),
    (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128),
    (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128), (Bits: 5; N: 128),
    (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8), // 10011xxxx
    (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8),
    (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8),
    (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8), (Bits: 5; N: 8),
    (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9), // 10100xxxx
    (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9),
    (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9),
    (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9), (Bits: 5; N: 9),
    (Bits: 6; N: 16), (Bits: 6; N: 16), (Bits: 6; N: 16), (Bits: 6; N: 16), // 101010xxx
    (Bits: 6; N: 16), (Bits: 6; N: 16), (Bits: 6; N: 16), (Bits: 6; N: 16),
    (Bits: 6; N: 17), (Bits: 6; N: 17), (Bits: 6; N: 17), (Bits: 6; N: 17), // 101011xxx
    (Bits: 6; N: 17), (Bits: 6; N: 17), (Bits: 6; N: 17), (Bits: 6; N: 17),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), // 1011xxxxx
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4), (Bits: 4; N: 4),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), // 1100xxxxx
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5),
    (Bits: 6; N: 14), (Bits: 6; N: 14), (Bits: 6; N: 14), (Bits: 6; N: 14), // 110100xxx
    (Bits: 6; N: 14), (Bits: 6; N: 14), (Bits: 6; N: 14), (Bits: 6; N: 14),
    (Bits: 6; N: 15), (Bits: 6; N: 15), (Bits: 6; N: 15), (Bits: 6; N: 15), // 110101xxx
    (Bits: 6; N: 15), (Bits: 6; N: 15), (Bits: 6; N: 15), (Bits: 6; N: 15),
    (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64), // 11011xxxx
    (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64),
    (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64),
    (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64), (Bits: 5; N: 64),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), // 1110xxxxx
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), // 1111xxxxx
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7),
    (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7), (Bits: 4; N: 7));

    {Black runlengths}

  // 10-13 bit codes (upper 6 bits are 0)
  TgtBlackTab1: array[0..127] of TgtCCITTCode = (
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 000000000000x
    (Bits: 12; N: ccittEOL), (Bits: 12; N: ccittEOL), // 000000000001x
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000001xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000010xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000011xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000100xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000101xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000110xx
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 00000000111xx
    (Bits: 11; N: 1792), (Bits: 11; N: 1792), (Bits: 11; N: 1792), (Bits: 11; N: 1792), // 00000001000xx
    (Bits: 12; N: 1984), (Bits: 12; N: 1984), // 000000010010x
    (Bits: 12; N: 2048), (Bits: 12; N: 2048), // 000000010011x
    (Bits: 12; N: 2112), (Bits: 12; N: 2112), // 000000010100x
    (Bits: 12; N: 2176), (Bits: 12; N: 2176), // 000000010101x
    (Bits: 12; N: 2240), (Bits: 12; N: 2240), // 000000010110x
    (Bits: 12; N: 2304), (Bits: 12; N: 2304), // 000000010111x
    (Bits: 11; N: 1856), (Bits: 11; N: 1856), (Bits: 11; N: 1856), (Bits: 11; N: 1856), // 00000001100xx
    (Bits: 11; N: 1920), (Bits: 11; N: 1920), (Bits: 11; N: 1920), (Bits: 11; N: 1920), // 00000001101xx
    (Bits: 12; N: 2368), (Bits: 12; N: 2368), // 000000011100x
    (Bits: 12; N: 2432), (Bits: 12; N: 2432), // 000000011101x
    (Bits: 12; N: 2496), (Bits: 12; N: 2496), // 000000011110x
    (Bits: 12; N: 2560), (Bits: 12; N: 2560), // 000000011111x
    (Bits: 10; N: 18), (Bits: 10; N: 18), (Bits: 10; N: 18), (Bits: 10; N: 18), // 0000001000xxx
    (Bits: 10; N: 18), (Bits: 10; N: 18), (Bits: 10; N: 18), (Bits: 10; N: 18),
    (Bits: 12; N: 52), (Bits: 12; N: 52), // 000000100100x
    (Bits: 13; N: 640), // 0000001001010
    (Bits: 13; N: 704), // 0000001001011
    (Bits: 13; N: 768), // 0000001001100
    (Bits: 13; N: 832), // 0000001001101
    (Bits: 12; N: 55), (Bits: 12; N: 55), // 000000100111x
    (Bits: 12; N: 56), (Bits: 12; N: 56), // 000000101000x
    (Bits: 13; N: 1280), // 0000001010010
    (Bits: 13; N: 1344), // 0000001010011
    (Bits: 13; N: 1408), // 0000001010100
    (Bits: 13; N: 1472), // 0000001010101
    (Bits: 12; N: 59), (Bits: 12; N: 59), // 000000101011x
    (Bits: 12; N: 60), (Bits: 12; N: 60), // 000000101100x
    (Bits: 13; N: 1536), // 0000001011010
    (Bits: 13; N: 1600), // 0000001011011
    (Bits: 11; N: 24), (Bits: 11; N: 24), (Bits: 11; N: 24), (Bits: 11; N: 24), // 00000010111xx
    (Bits: 11; N: 25), (Bits: 11; N: 25), (Bits: 11; N: 25), (Bits: 11; N: 25), // 00000011000xx
    (Bits: 13; N: 1664), // 0000001100100
    (Bits: 13; N: 1728), // 0000001100101
    (Bits: 12; N: 320), (Bits: 12; N: 320), // 000000110011x
    (Bits: 12; N: 384), (Bits: 12; N: 384), // 000000110100x
    (Bits: 12; N: 448), (Bits: 12; N: 448), // 000000110101x
    (Bits: 13; N: 512), // 0000001101100
    (Bits: 13; N: 576), // 0000001101101
    (Bits: 12; N: 53), (Bits: 12; N: 53), // 000000110111x
    (Bits: 12; N: 54), (Bits: 12; N: 54), // 000000111000x
    (Bits: 13; N: 896), // 0000001110010
    (Bits: 13; N: 960), // 0000001110011
    (Bits: 13; N: 1024), // 0000001110100
    (Bits: 13; N: 1088), // 0000001110101
    (Bits: 13; N: 1152), // 0000001110110
    (Bits: 13; N: 1216), // 0000001110111
    (Bits: 10; N: 64), (Bits: 10; N: 64), (Bits: 10; N: 64), (Bits: 10; N: 64), // 0000001111xxx
    (Bits: 10; N: 64), (Bits: 10; N: 64), (Bits: 10; N: 64), (Bits: 10; N: 64));

// 7-12 bit codes (upper 4 bits are 0)
  TgtBlackTab2: array[0..191] of TgtCCITTCode = (
    (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13), // 00000100xxxx
    (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13),
    (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13),
    (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13), (Bits: 8; N: 13),
    (Bits: 11; N: 23), (Bits: 11; N: 23), // 00000101000x
    (Bits: 12; N: 50), // 000001010010
    (Bits: 12; N: 51), // 000001010011
    (Bits: 12; N: 44), // 000001010100
    (Bits: 12; N: 45), // 000001010101
    (Bits: 12; N: 46), // 000001010110
    (Bits: 12; N: 47), // 000001010111
    (Bits: 12; N: 57), // 000001011000
    (Bits: 12; N: 58), // 000001011001
    (Bits: 12; N: 61), // 000001011010
    (Bits: 12; N: 256), // 000001011011
    (Bits: 10; N: 16), (Bits: 10; N: 16), (Bits: 10; N: 16), (Bits: 10; N: 16), // 0000010111xx
    (Bits: 10; N: 17), (Bits: 10; N: 17), (Bits: 10; N: 17), (Bits: 10; N: 17), // 0000011000xx
    (Bits: 12; N: 48), // 000001100100
    (Bits: 12; N: 49), // 000001100101
    (Bits: 12; N: 62), // 000001100110
    (Bits: 12; N: 63), // 000001100111
    (Bits: 12; N: 30), // 000001101000
    (Bits: 12; N: 31), // 000001101001
    (Bits: 12; N: 32), // 000001101010
    (Bits: 12; N: 33), // 000001101011
    (Bits: 12; N: 40), // 000001101100
    (Bits: 12; N: 41), // 000001101101
    (Bits: 11; N: 22), (Bits: 11; N: 22), // 00000110111x
    (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14), // 00000111xxxx
    (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14),
    (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14),
    (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14), (Bits: 8; N: 14),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), // 0000100xxxxx
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10), (Bits: 7; N: 10),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), // 0000101xxxxx
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11), (Bits: 7; N: 11),
    (Bits: 9; N: 15), (Bits: 9; N: 15), (Bits: 9; N: 15), (Bits: 9; N: 15), // 000011000xxx
    (Bits: 9; N: 15), (Bits: 9; N: 15), (Bits: 9; N: 15), (Bits: 9; N: 15),
    (Bits: 12; N: 128), // 000011001000
    (Bits: 12; N: 192), // 000011001001
    (Bits: 12; N: 26), // 000011001010
    (Bits: 12; N: 27), // 000011001011
    (Bits: 12; N: 28), // 000011001100
    (Bits: 12; N: 29), // 000011001101
    (Bits: 11; N: 19), (Bits: 11; N: 19), // 00001100111x
    (Bits: 11; N: 20), (Bits: 11; N: 20), // 00001101000x
    (Bits: 12; N: 34), // 000011010010
    (Bits: 12; N: 35), // 000011010011
    (Bits: 12; N: 36), // 000011010100
    (Bits: 12; N: 37), // 000011010101
    (Bits: 12; N: 38), // 000011010110
    (Bits: 12; N: 39), // 000011010111
    (Bits: 11; N: 21), (Bits: 11; N: 21), // 00001101100x
    (Bits: 12; N: 42), // 000011011010
    (Bits: 12; N: 43), // 000011011011
    (Bits: 10; N: 0), (Bits: 10; N: 0), (Bits: 10; N: 0), (Bits: 10; N: 0), // 0000110111xx
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), // 0000111xxxxx
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12),
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12),
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12),
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12),
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12),
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12),
    (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12), (Bits: 7; N: 12));

  // 2-6 bit codes
  TgtBlackTab3: array[0..63] of TgtCCITTCode = (
    (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), (Bits: - 1; N: - 1), // 0000xx
    (Bits: 6; N: 9), // 000100
    (Bits: 6; N: 8), // 000101
    (Bits: 5; N: 7), (Bits: 5; N: 7), // 00011x
    (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), (Bits: 4; N: 6), // 0010xx
    (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), (Bits: 4; N: 5), // 0011xx
    (Bits: 3; N: 1), (Bits: 3; N: 1), (Bits: 3; N: 1), (Bits: 3; N: 1), // 010xxx
    (Bits: 3; N: 1), (Bits: 3; N: 1), (Bits: 3; N: 1), (Bits: 3; N: 1),
    (Bits: 3; N: 4), (Bits: 3; N: 4), (Bits: 3; N: 4), (Bits: 3; N: 4), // 011xxx
    (Bits: 3; N: 4), (Bits: 3; N: 4), (Bits: 3; N: 4), (Bits: 3; N: 4),
    (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3), // 10xxxx
    (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3),
    (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3),
    (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3), (Bits: 2; N: 3),
    (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2), // 11xxxx
    (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2),
    (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2),
    (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2), (Bits: 2; N: 2));


type

(**
 * This class is responsible for decoding of Streams in CCITTFax
 *)

  TgtCCITTDecode = class(TgtDecode)
  private
    { private declarations }
    FStream: TgtStream;
    FEncoding: Integer; // 'K' Parameter
    FEndOfLine: Boolean; // 'EndOfLine' Parameter
    FByteAlign: Boolean; // 'ByteAlign' Parameter
    FColumns: Integer; // 'Columns' Parameter
    FRows: Integer; // 'Rows' Parameter;
    FEndOfBlock: Boolean; // 'EndOfBlock' Parameter
    FBlack: Boolean; // 'BlackIs1' Parameter
    FEof: Boolean; // 'Ture if Eof
    FNextLine2D: Boolean; // 'True if next line uses 2D Encoding
    FRow: Integer; // Current Row
    FInputBuf: Integer; // Input buffer
    FInputBits: Integer; // No: of bits in Input buffer
    FRefLine: array of Smallint; // reference line changing elements
    FIndextoRef: Integer; // index into refLine
    FCodingLine: array of Smallint; // coding line changing elements
    FIndextoCoding: Smallint; // index into codingLine
    FOutputBits: Integer; // remaining ouput bits
    FBuffer: Integer; // character buffer

    function GetTwoDimCode: Smallint;
    function GetWhiteCode: Smallint;
    function GetBlackCode: Smallint;
    function LookBits(AIndex: Integer): Smallint;
    procedure EatBits(ACount: Integer);

  public
    constructor Create(AStream: TgtStream; AEncoding: Integer;
      AEndOfLine: Boolean; AByteAlign: Boolean; AColumns: Integer;
      ARows: Integer; AEndOfBlock: Boolean; ABlack: Boolean);
    destructor Destroy; override;
    procedure Reset; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;

  end;
//{$ENDIF}

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  StreamConsts, StreamExceptions, SysUtils;

{ TgtCCITTDecode }

(**
 * Constructor
 * @param AStream that need to be decoded
 * @param AEncoding a code identifying the encoding scheme used
 * @param AEndOfLine A flag indicating whether end-of-line bit patterns are
          required to be present in the encoding.
 * @param AByteAlign A flag indicating whether the filter expects extra 0 bits
          before each encoded line so that the line begins on a byte boundary.
 * @param AColumns The width of the image in pixels.
 * @param ARows The height of the image in scan lines.
 * @param ABlack a flag indicating whether 1 bits are to be interpreted as black
          pixels and 0 bits as white pixels.
 *
 * @exception ExOutofMemory will be raised on allocation out of memory
 *)

constructor TgtCCITTDecode.Create(AStream: TgtStream; AEncoding: Integer;
  AEndOfLine, AByteAlign: Boolean; AColumns, ARows: Integer; AEndOfBlock,
  ABlack: Boolean);
begin
  FStream := AStream;
  FEncoding := AEncoding;
  FEndOfLine := AEndOfLine;
  FByteAlign := AByteAlign;
  FColumns := AColumns;

  if (FColumns < 1) then
  begin
    FColumns := 1;
  end;
  if (FColumns + 4) <= 0 then
  begin
    FColumns := MaxInt - 4;
  end;

  FRows := ARows;
  FEndOfBlock := AEndOfBlock;
  FBlack := ABlack;
  try
    SetLength(FRefLine, (FColumns + 3));
    SetLength(FCodingLine, (FColumns + 2));
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;

  FEof := False;
  FRow := 0;
  FNextLine2D := (FEncoding < 0);
  FInputBits := 0;
  FCodingLine[0] := 0;
  FCodingLine[1] := FColumns;
  FRefLine[2] := FColumns;
  FIndextoCoding := 1;
  FBuffer := EndofFile;
  FInputBuf := 0;
end;

(**
 * Destructor
 *)

destructor TgtCCITTDecode.Destroy;
begin
  SetLength(FRefLine, 0);
  SetLength(FCodingLine, 0);
  inherited;
end;

procedure TgtCCITTDecode.EatBits(ACount: Integer);
begin
  FInputBits := (FInputBits - ACount);
  if (FInputBits < 0) then
  begin
    FInputBits := 0;
  end;
end;

function TgtCCITTDecode.GetBlackCode: Smallint;
var
  LCode: Smallint;
  LP: TgtCCITTCode;
  LN: Integer;
begin
  if FEndOfBlock then
  begin
    LCode := LookBits(13);
    if ((LCode shr 7) = 0) then
    begin
      LP := TgtBlackTab1[LCode];
    end
    else if ((LCode shr 9) = 0) then
    begin
      LP := TgtBlackTab2[(LCode shr 1) - 64];
    end
    else
    begin
      if LCode < 0 then
      begin
        EatBits(1);
        Result := 1;
        Exit;
      end
      else
        LP := TgtBlackTab3[LCode shr 7];
    end;
    if (LP.Bits > 0) then
    begin
      EatBits(LP.Bits);
      Result := LP.N;
      Exit;
    end;
  end
  else
  begin
    for LN := 2 to 6 do
    begin
      LCode := LookBits(LN);
      if (LN < 6) then
      begin
        LCode := LCode shl (6 - LN);
      end;
      LP := TgtBlackTab3[LCode];
      if (LP.Bits = LN) then
      begin
        EatBits(LN);
        Result := LP.N;
        Exit;
      end;
    end;
    for LN := 7 to 12 do
    begin
      LCode := LookBits(LN);
      if (LN < 12) then
      begin
        LCode := LCode shl (12 - LN);
      end;
      if (LCode >= 64) then
      begin
        LP := TgtBlackTab2[LCode - 64];
        if (LP.Bits = LN) then
        begin
          EatBits(LN);
          Result := LP.N;
          Exit;
        end;
      end;
    end;
    for LN := 10 to 13 do
    begin
      LCode := LookBits(LN);
      if (LN < 13) then
      begin
        LCode := LCode shl (13 - LN);
      end;
      LP := TgtBlackTab1[LCode];
      if (LP.Bits = LN) then
      begin
        EatBits(LN);
        Result := LP.N;
        Exit;
      end;
    end;
  end;
{$IFDEF DEBUG}
  Logger.LogError('Bad Black code %d in CCITTFax stream', [LCode]);
{$ENDIF}
  EatBits(1);
  Result := 1;
end;

function TgtCCITTDecode.GetTwoDimCode: Smallint;
var
  LCode: Smallint;
  LP: TgtCCITTCode;
  LN: Integer;
begin
  if FEndOfBlock then
  begin
    LCode := LookBits(7);
    LP := TgtTwoDimTab1[LCode];
    if (LP.Bits > 0) then
    begin
      EatBits(LP.Bits);
      Result := LP.N;
      Exit;
    end;
  end
  else
  begin
    for LN := 1 to 7 do
    begin
      LCode := LookBits(LN);
      if (LN < 7) then
      begin
        LCode := LCode shl (7 - LN);
      end;
      LP := TgtTwoDimTab1[LCode];
      if LP.Bits = LN then
      begin
        EatBits(LN);
        Result := LP.N;
        Exit;
      end;
    end;
  end;
{$IFDEF DEBUG}
  Logger.LogError('Bad TwoDim code %d in CCITTFax stream', [LCode]);
{$ENDIF}
  Result := EndofFile;
end;

function TgtCCITTDecode.GetWhiteCode: Smallint;
var
  LCode: Smallint;
  LP: TgtCCITTCode;
  LN: Integer;
begin
  if FEndOfBlock then
  begin
    LCode := LookBits(12);
    if ((LCode shr 5) = 0) then
    begin
      LP := TgtWhiteTab1[LCode];
    end
    else
    begin
      if LCode < 0 then
      begin
        EatBits(1);
        Result := 1;
        Exit;
      end
      else
        LP := TgtWhiteTab2[LCode shr 3];
    end;
    if (LP.Bits > 0) then
    begin
      EatBits(LP.Bits);
      Result := LP.N;
      Exit;
    end;
  end
  else
  begin
    for LN := 1 to 9 do
    begin
      LCode := LookBits(LN);
      if (LN < 9) then
      begin
        LCode := LCode shl (9 - LN);
      end;
      LP := TgtWhiteTab2[LCode];
      if (LP.Bits = LN) then
      begin
        EatBits(LN);
        Result := LP.N;
        Exit;
      end;
    end;
    for LN := 11 to 12 do
    begin
      LCode := LookBits(LN);
      if (LN < 12) then
      begin
        LCode := LCode shl (12 - LN);
      end;
      LP := TgtWhiteTab1[LCode];
      if (LP.Bits = LN) then
      begin
        EatBits(LN);
        Result := LP.N;
        Exit;
      end;
    end;
  end;
{$IFDEF DEBUG}
  Logger.LogError('Bad White code %d in CCITTFax stream', [LCode]);
{$ENDIF}
  EatBits(1);
  Result := 1;
end;

function TgtCCITTDecode.LookBits(AIndex: Integer): Smallint;
var
  LChar: Integer;
begin
  if FStream = nil then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  while (FInputBits < AIndex) do
  begin
    LChar := FStream.GetChar;
    if (LChar = EndofFile) then
    begin
      if (FInputBits = 0) then
      begin
        Result := EndofFile;
        Exit;
      end;
      Result := ((FInputBuf shl (AIndex - FInputBits)) and ($FFFF shr (16 - AIndex)));
      Exit;
    end;
    FInputBuf := (FInputBuf shl 8) + LChar;
    FInputBits := FInputBits + 8;
  end;
  Result := ((FInputBuf shr (FInputBits - AIndex)) and ($FFFF shr (16 - AIndex)));
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtCCITTDecode.LookChar: Integer;
var
  LError, LGotEOL: Boolean;
  LCode1, LCode2, LCode3: Smallint;
  LCodeIndex, LRet, LI, LBits: Integer;
begin
  LCode1 := 0;
  // if at eof just return EOF
  if FEof and (FCodingLine[FIndextoCoding] >= FColumns) then
  begin
    Result := EndofFile;
    Exit;
  end;

  // read the next row
  LError := False;
  if (FCodingLine[FIndextoCoding] >= FColumns) then
  begin
    if FNextLine2D then // 2-D encoding
    begin
      LI := 0;
      while (FCodingLine[LI] < FColumns) do
      begin
        FRefLine[LI] := FCodingLine[LI];
        Inc(LI);
      end;
      FRefLine[LI] := FColumns;
      FRefLine[LI + 1] := FColumns;
      FIndextoRef := 1;

      FIndextoCoding := 0;
      FCodingLine[FIndextoCoding] := 0;
      LCodeIndex := FCodingLine[FIndextoCoding];

      repeat
        begin
          LCode1 := GetTwoDimCode;
          case LCode1 of
            twoDimPass:
              begin
                if (FRefLine[FIndextoRef] < FColumns) then
                begin
                  LCodeIndex := FRefLine[FIndextoRef + 1];
                  FIndextoRef := FIndextoRef + 2;
                end;
              end;

            twoDimHoriz:
              begin
                if (FIndextoCoding and 1) = 0 then
                begin
                  LCode1 := 0;
                  LCode2 := 0;
                  repeat
                    LCode3 := GetWhiteCode;
                    LCode1 := LCode1 + LCode3;
                  until not (LCode3 >= 64);

                  repeat
                    LCode3 := GetBlackCode;
                    LCode2 := LCode2 + LCode3;
                  until not (LCode3 >= 64);
                end
                else
                begin
                  LCode1 := 0;
                  LCode2 := 0;
                  repeat
                    LCode3 := GetBlackCode;
                    LCode1 := LCode1 + LCode3;
                  until not (LCode3 >= 64);

                  repeat
                    LCode3 := GetWhiteCode;
                    LCode2 := LCode2 + LCode3;
                  until not (LCode3 >= 64);
                end;
                if (LCode1 > 0) or (LCode2 > 0) then
                begin
                  if ((LCodeIndex + LCode1) <= FColumns) then
                  begin
                    FCodingLine[FIndextoCoding + 1] := LCodeIndex + LCode1;
                  end
                  else
                  begin
                    FCodingLine[FIndextoCoding + 1] := FColumns;
                  end;
                  Inc(FIndextoCoding);
                  if ((FCodingLine[FIndextoCoding] + LCode2) <= FColumns) then
                  begin
                    FCodingLine[FIndextoCoding + 1] := FCodingLine[FIndextoCoding]
                      + LCode2;
                  end
                  else
                  begin
                    FCodingLine[FIndextoCoding + 1] := FColumns;
                  end;
                  Inc(FIndextoCoding);
                  LCodeIndex := FCodingLine[FIndextoCoding];

                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end;
              end;

            twoDimVert0:
              begin
                if FRefLine[FIndextoRef] < FColumns then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef];
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef];
                  Inc(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end
                else
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FColumns;
                  FCodingLine[FIndextoCoding] := FColumns;
                end;
              end;

            twoDimVertR1:
              begin
                if (FRefLine[FIndextoRef] + 1) < FColumns then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef] + 1;
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef] + 1;
                  Inc(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end
                else
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FColumns;
                  FCodingLine[FIndextoCoding] := FColumns;
                end;
              end;

            twoDimVertL1:
              begin
                if (((FRefLine[FIndextoRef] - 1) > LCodeIndex) or
                  ((FIndextoCoding = 0) and (FRefLine[FIndextoRef] = 1))) then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef] - 1;
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef] - 1;
                  Dec(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end;
              end;

            twoDimVertR2:
              begin
                if (FRefLine[FIndextoRef] + 2) < FColumns then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef] + 2;
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef] + 2;
                  Inc(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end
                else
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FColumns;
                  FCodingLine[FIndextoCoding] := FColumns;
                end;
              end;

            twoDimVertL2:
              begin
                if (((FRefLine[FIndextoRef] - 2) > LCodeIndex) or
                  ((FIndextoCoding = 0) and (FRefLine[FIndextoRef] = 2))) then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef] - 2;
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef] - 2;
                  Dec(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end;
              end;

            twoDimVertR3:
              begin
                if ((FRefLine[FIndextoRef] + 3) < FColumns) then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef] + 3;
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef] + 3;
                  Inc(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end
                else
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FColumns;
                  FCodingLine[FIndextoCoding] := FColumns;
                end;
              end;

            twoDimVertL3:
              begin
                if ((FRefLine[FIndextoRef] - 3) > LCodeIndex) or
                  ((FIndextoCoding = 0) and (FRefLine[FIndextoRef] = 3)) then
                begin
                  Inc(FIndextoCoding);
                  LCodeIndex := FRefLine[FIndextoRef] - 3;
                  FCodingLine[FIndextoCoding] := FRefLine[FIndextoRef] - 3;
                  Dec(FIndextoRef);
                  while ((FRefLine[FIndextoRef] <= LCodeIndex) and
                    (FRefLine[FIndextoRef] < FColumns)) do
                  begin
                    FIndextoRef := FIndextoRef + 2;
                  end;
                end;
              end;

            EndofFile:
              begin
                FEof := True;
                FIndextoCoding := 0;
                FCodingLine[FIndextoCoding] := 0;
                Result := EndofFile;
                Exit;
              end;
          else
            begin
{$IFDEF DEBUG}
              Logger.LogError('Bad 2D code %d in CCITTFax stream', [LCode1]);
{$ENDIF}
              LError := True;
            end;
          end;
        end;
      until not (FCodingLine[FIndextoCoding] < FColumns);
    end
    else // 1-D encoding
    begin
      FIndextoCoding := 0;
      FCodingLine[FIndextoCoding] := 0;
      while True do
      begin
        LCode1 := 0;
        repeat
          LCode3 := GetWhiteCode;
          if LCode3 = 1 then
          begin
            LCode1 := 1;
            Break;
          end;
          LCode1 := LCode1 + LCode3;
        until not (LCode3 >= 64);
        FCodingLine[FIndextoCoding + 1] := FCodingLine[FIndextoCoding] + LCode1;
        Inc(FIndextoCoding);
        if (FCodingLine[FIndextoCoding] >= FColumns) then
        begin
          Break;
        end;
        LCode2 := 0;
        repeat
          LCode3 := GetBlackCode;
          if LCode3 = 1 then
          begin
            LCode2 := 1;
            Break;
          end;
          LCode2 := LCode2 + LCode3;
        until not (LCode3 >= 64);
        FCodingLine[FIndextoCoding + 1] := FCodingLine[FIndextoCoding] + LCode2;
        Inc(FIndextoCoding);
        if (FCodingLine[FIndextoCoding] >= FColumns) then
        begin
          Break;
        end;
      end;
    end;

    if not (FCodingLine[FIndextoCoding] = FColumns) then
    begin
{$IFDEF DEBUG}
   //    Logger.LogError('CCITTFax row is wrong length %d' [FCodingLine[FIndextoCoding]]);
{$ENDIF}

    // force the row to be the correct length
      while (FCodingLine[FIndextoCoding] > FColumns) do
      begin
        Dec(FIndextoCoding);
      end;
      Inc(FIndextoCoding);
      FCodingLine[FIndextoCoding] := FColumns;
      LError := True
    end;

    // byte-align the row
    if FByteAlign then
    begin
      FInputBits := FInputBits and (not 7);
    end;

    // check for end-of-line marker, skipping over any extra zero bits
    LGotEOL := False;
    if (not FEndOfBlock) and (FRow = (FRows - 1)) then
    begin
      FEof := True;
    end
    else
    begin
      LCode1 := LookBits(12);
      while (LCode1 = 0) do
      begin
        EatBits(1);
        LCode1 := LookBits(12);
      end;
      if (LCode1 = $001) then
      begin
        EatBits(12);
        LGotEOL := True;
      end
      else if (LCode1 = EndofFile) then
      begin
        FEof := True;
      end;
    end;

    // get 2D encoding tag
    if (not FEof) and (FEncoding > 0) then
    begin
      if LookBits(1) = 0 then
        FNextLine2D := True
      else
        FNextLine2D := False;
      EatBits(1);
    end;

    // check for end-of-block marker
    if (FEndOfBlock and LGotEOL) then
    begin
      LCode1 := LookBits(12);
      if LCode1 = $001 then
      begin
        EatBits(12);
        if (FEncoding > 0) then
        begin
          LookBits(1);
          EatBits(1);
        end;
        if (FEncoding >= 0) then
        begin
          for LI := 0 to 3 do
          begin
            LCode1 := LookBits(12);
            if (LCode1 <> $001) then
            begin
{$IFDEF DEBUG}
              Logger.LogError('Bad RTC code in CCITTFax stream');
{$ENDIF}
            end;
            EatBits(12);
            if (FEncoding > 0) then
            begin
              LookBits(1);
              EatBits(1);
            end;
          end;
        end;
        FEof := True;
      end;
    end
    else if (LError and FEndOfLine) then
    begin
      repeat
        if (LCode1 = EndofFile) then
        begin
          FEof := True;
          Result := EndofFile;
          Exit;
        end;
        EatBits(1);
        LCode1 := LookBits(13);
      until ((LCode1 shr 1) <> $001);
      EatBits(12);
      if FEncoding > 0 then
      begin
        EatBits(1);
        if ((LCode1 and 1) = 0) then
          FNextLine2D := True
        else
          FNextLine2D := False;
      end;
    end;
    FIndextoCoding := 0;
    FOutputBits := FCodingLine[1] - FCodingLine[0];
    if (FOutputBits = 0) then
    begin
      FIndextoCoding := 1;
      FOutputBits := FCodingLine[2] - FCodingLine[1];
    end;
    Inc(FRow);
  end;

  // get a byte
  if (FOutputBits >= 8) then
  begin
    if ((FIndextoCoding and 1) = 0) then
      LRet := $FF
    else
      LRet := $00;

    FOutputBits := FOutputBits - 8;
    if (FOutputBits = 0) then
    begin
      Inc(FIndextoCoding);
      if FCodingLine[FIndextoCoding] < FColumns then
      begin
        FOutputBits := FCodingLine[FIndextoCoding + 1] -
          FCodingLine[FIndextoCoding];
      end;
    end;
  end
  else
  begin
    LBits := 8;
    LRet := 0;
    repeat
      if (FOutputBits > LBits) then
      begin
        LI := LBits;
        LBits := 0;
        if ((FIndextoCoding and 1) = 0) then
        begin
          LRet := LRet or $FF shr (8 - LI);
        end;
        FOutputBits := FOutputBits - LI;
      end
      else
      begin
        LI := FOutputBits;
        LBits := LBits - FOutputBits;
        if ((FIndextoCoding and 1) = 0) then
        begin
          LRet := LRet or ($FF shr (8 - LI)) shl LBits;
        end;
        FOutputBits := 0;
        Inc(FIndextoCoding);
        if (FCodingLine[FIndextoCoding] < FColumns) then
        begin
          FOutputBits := FCodingLine[FIndextoCoding + 1] -
            FCodingLine[FIndextoCoding];
        end;
      end;
    until not ((LBits > 0) and (FCodingLine[FIndextoCoding] < FColumns));
  end;
  if FBlack then
    FBuffer := (LRet xor $FF)
  else
    FBuffer := LRet;

  Result := FBuffer;
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtCCITTDecode.GetChar: Integer;
var
  LChar: Integer;
begin
  LChar := LookChar;
  FBuffer := EndofFile;
  Result := LChar;
end;

(**
 * Resets the Stream to its defaults
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

procedure TgtCCITTDecode.Reset;
var
  LCode1: Integer;
begin
  inherited;
  FStream.Reset;

  FEof := False;
  FRow := 0;
  FNextLine2D := (FEncoding < 0);
  FInputBits := 0;
  FCodingLine[0] := 0;
  FCodingLine[1] := FColumns;
  FIndextoCoding := 1;
  FBuffer := EndofFile;

  { skip any initial zero bits and end-of-line marker, and get the 2D
   encoding tag }
  LCode1 := LookBits(12);
  while (LCode1 = 0) do
  begin
    EatBits(1);
    LCode1 := LookBits(12);
  end;

  if (LCode1 = $001) then
  begin
    EatBits(12);
  end;
  if (FEncoding > 0) then
  begin
    if LookBits(1) = 0 then
      FNextLine2D := True
    else
      FNextLine2D := False;

    EatBits(1); ;
  end;
end;

end.
