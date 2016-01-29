{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit FlateDecode;

interface

uses
  Classes, Stream, Predictor, FilterStream, gtObject, DecodeIntf, gtTypes;

type
  // Decoding info for length and distance code words
  TgtFlateDecodeRec = record
    bits: Integer; // number of extra bits
    first: Integer; // first length/distance
  end;

 // Huffman code table entry
  TgtFlateCode = record
    length: Word; // code length, in bits
    value: Word; // value represented by this code
  end;

const
  FlateWindow = 32768;
  FlateMask = (FlateWindow - 1);

  FlateMaxLitCodes = 288;
  FlateMaxDistCodes = 30;
  FlateMaxCodeLenCodes = 19;
  // code length code reordering
  CodeLenCodeMap: array[0..FlateMaxCodeLenCodes - 1] of Integer = (16, 17, 18, 0,
    8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15);
  // length decoding info
  LengthDecode: array[0..FlateMaxLitCodes - 257 - 1] of TgtFlateDecodeRec = (
    (bits: 0; first: 3),
    (bits: 0; first: 4),
    (bits: 0; first: 5),
    (bits: 0; first: 6),
    (bits: 0; first: 7),
    (bits: 0; first: 8),
    (bits: 0; first: 9),
    (bits: 0; first: 10),
    (bits: 1; first: 11),
    (bits: 1; first: 13),
    (bits: 1; first: 15),
    (bits: 1; first: 17),
    (bits: 2; first: 19),
    (bits: 2; first: 23),
    (bits: 2; first: 27),
    (bits: 2; first: 31),
    (bits: 3; first: 35),
    (bits: 3; first: 43),
    (bits: 3; first: 51),
    (bits: 3; first: 59),
    (bits: 4; first: 67),
    (bits: 4; first: 83),
    (bits: 4; first: 99),
    (bits: 4; first: 115),
    (bits: 5; first: 131),
    (bits: 5; first: 163),
    (bits: 5; first: 195),
    (bits: 5; first: 227),
    (bits: 0; first: 258),
    (bits: 0; first: 258),
    (bits: 0; first: 258));

  // distance decoding info
  DistDecode: array[0..FlateMaxDistCodes - 1] of TgtFlateDecodeRec = (
    (bits: 0; first: 1),
    (bits: 0; first: 2),
    (bits: 0; first: 3),
    (bits: 0; first: 4),
    (bits: 1; first: 5),
    (bits: 1; first: 7),
    (bits: 2; first: 9),
    (bits: 2; first: 13),
    (bits: 3; first: 17),
    (bits: 3; first: 25),
    (bits: 4; first: 33),
    (bits: 4; first: 49),
    (bits: 5; first: 65),
    (bits: 5; first: 97),
    (bits: 6; first: 129),
    (bits: 6; first: 193),
    (bits: 7; first: 257),
    (bits: 7; first: 385),
    (bits: 8; first: 513),
    (bits: 8; first: 769),
    (bits: 9; first: 1025),
    (bits: 9; first: 1537),
    (bits: 10; first: 2049),
    (bits: 10; first: 3073),
    (bits: 11; first: 4097),
    (bits: 11; first: 6145),
    (bits: 12; first: 8193),
    (bits: 12; first: 12289),
    (bits: 13; first: 16385),
    (bits: 13; first: 24577));

  FlateFixedLitCodeTabCodes: array[0..511] of TgtFlateCode = (
    (length: 7; value: $0100), (length: 8; value: $0050), (length: 8; value: $0010),
    (length: 8; value: $0118), (length: 7; value: $0110), (length: 8; value: $0070),
    (length: 8; value: $0030), (length: 9; value: $00C0), (length: 7; value: $0108),
    (length: 8; value: $0060), (length: 8; value: $0020), (length: 9; value: $00A0),
    (length: 8; value: $0000), (length: 8; value: $0080), (length: 8; value: $0040),
    (length: 9; value: $00E0), (length: 7; value: $0104), (length: 8; value: $0058),
    (length: 8; value: $0018), (length: 9; value: $0090), (length: 7; value: $0114),
    (length: 8; value: $0078), (length: 8; value: $0038), (length: 9; value: $00D0),
    (length: 7; value: $010C), (length: 8; value: $0068), (length: 8; value: $0028),
    (length: 9; value: $00B0), (length: 8; value: $0008), (length: 8; value: $0088),
    (length: 8; value: $0048), (length: 9; value: $00F0), (length: 7; value: $0102),
    (length: 8; value: $0054), (length: 8; value: $0014), (length: 8; value: $011C),
    (length: 7; value: $0112), (length: 8; value: $0074), (length: 8; value: $0034),
    (length: 9; value: $00C8), (length: 7; value: $010A), (length: 8; value: $0064),
    (length: 8; value: $0024), (length: 9; value: $00A8), (length: 8; value: $0004),
    (length: 8; value: $0084), (length: 8; value: $0044), (length: 9; value: $00E8),
    (length: 7; value: $0106), (length: 8; value: $005C), (length: 8; value: $001C),
    (length: 9; value: $0098), (length: 7; value: $0116), (length: 8; value: $007C),
    (length: 8; value: $003C), (length: 9; value: $00D8), (length: 7; value: $010E),
    (length: 8; value: $006C), (length: 8; value: $002C), (length: 9; value: $00B8),
    (length: 8; value: $000C), (length: 8; value: $008C), (length: 8; value: $004C),
    (length: 9; value: $00F8), (length: 7; value: $0101), (length: 8; value: $0052),
    (length: 8; value: $0012), (length: 8; value: $011A), (length: 7; value: $0111),
    (length: 8; value: $0072), (length: 8; value: $0032), (length: 9; value: $00C4),
    (length: 7; value: $0109), (length: 8; value: $0062), (length: 8; value: $0022),
    (length: 9; value: $00A4), (length: 8; value: $0002), (length: 8; value: $0082),
    (length: 8; value: $0042), (length: 9; value: $00E4), (length: 7; value: $0105),
    (length: 8; value: $005A), (length: 8; value: $001A), (length: 9; value: $0094),
    (length: 7; value: $0115), (length: 8; value: $007A), (length: 8; value: $003A),
    (length: 9; value: $00D4), (length: 7; value: $010D), (length: 8; value: $006A),
    (length: 8; value: $002A), (length: 9; value: $00B4), (length: 8; value: $000A),
    (length: 8; value: $008A), (length: 8; value: $004A), (length: 9; value: $00F4),
    (length: 7; value: $0103), (length: 8; value: $0056), (length: 8; value: $0016),
    (length: 8; value: $011E), (length: 7; value: $0113), (length: 8; value: $0076),
    (length: 8; value: $0036), (length: 9; value: $00CC), (length: 7; value: $010B),
    (length: 8; value: $0066), (length: 8; value: $0026), (length: 9; value: $00AC),
    (length: 8; value: $0006), (length: 8; value: $0086), (length: 8; value: $0046),
    (length: 9; value: $00EC), (length: 7; value: $0107), (length: 8; value: $005E),
    (length: 8; value: $001E), (length: 9; value: $009C), (length: 7; value: $0117),
    (length: 8; value: $007E), (length: 8; value: $003E), (length: 9; value: $00DC),
    (length: 7; value: $010F), (length: 8; value: $006E), (length: 8; value: $002E),
    (length: 9; value: $00BC), (length: 8; value: $000E), (length: 8; value: $008E),
    (length: 8; value: $004E), (length: 9; value: $00FC), (length: 7; value: $0100),
    (length: 8; value: $0051), (length: 8; value: $0011), (length: 8; value: $0119),
    (length: 7; value: $0110), (length: 8; value: $0071), (length: 8; value: $0031),
    (length: 9; value: $00C2), (length: 7; value: $0108), (length: 8; value: $0061),
    (length: 8; value: $0021), (length: 9; value: $00A2), (length: 8; value: $0001),
    (length: 8; value: $0081), (length: 8; value: $0041), (length: 9; value: $00E2),
    (length: 7; value: $0104), (length: 8; value: $0059), (length: 8; value: $0019),
    (length: 9; value: $0092), (length: 7; value: $0114), (length: 8; value: $0079),
    (length: 8; value: $0039), (length: 9; value: $00D2), (length: 7; value: $010C),
    (length: 8; value: $0069), (length: 8; value: $0029), (length: 9; value: $00B2),
    (length: 8; value: $0009), (length: 8; value: $0089), (length: 8; value: $0049),
    (length: 9; value: $00F2), (length: 7; value: $0102), (length: 8; value: $0055),
    (length: 8; value: $0015), (length: 8; value: $011D), (length: 7; value: $0112),
    (length: 8; value: $0075), (length: 8; value: $0035), (length: 9; value: $00CA),
    (length: 7; value: $010A), (length: 8; value: $0065), (length: 8; value: $0025),
    (length: 9; value: $00AA), (length: 8; value: $0005), (length: 8; value: $0085),
    (length: 8; value: $0045), (length: 9; value: $00EA), (length: 7; value: $0106),
    (length: 8; value: $005D), (length: 8; value: $001D), (length: 9; value: $009A),
    (length: 7; value: $0116), (length: 8; value: $007D), (length: 8; value: $003D),
    (length: 9; value: $00DA), (length: 7; value: $010E), (length: 8; value: $006D),
    (length: 8; value: $002D), (length: 9; value: $00BA), (length: 8; value: $000D),
    (length: 8; value: $008D), (length: 8; value: $004D), (length: 9; value: $00FA),
    (length: 7; value: $0101), (length: 8; value: $0053), (length: 8; value: $0013),
    (length: 8; value: $011B), (length: 7; value: $0111), (length: 8; value: $0073),
    (length: 8; value: $0033), (length: 9; value: $00C6), (length: 7; value: $0109),
    (length: 8; value: $0063), (length: 8; value: $0023), (length: 9; value: $00A6),
    (length: 8; value: $0003), (length: 8; value: $0083), (length: 8; value: $0043),
    (length: 9; value: $00E6), (length: 7; value: $0105), (length: 8; value: $005B),
    (length: 8; value: $001B), (length: 9; value: $0096), (length: 7; value: $0115),
    (length: 8; value: $007B), (length: 8; value: $003B), (length: 9; value: $00D6),
    (length: 7; value: $010D), (length: 8; value: $006B), (length: 8; value: $002B),
    (length: 9; value: $00B6), (length: 8; value: $000B), (length: 8; value: $008B),
    (length: 8; value: $004B), (length: 9; value: $00F6), (length: 7; value: $0103),
    (length: 8; value: $0057), (length: 8; value: $0017), (length: 8; value: $011F),
    (length: 7; value: $0113), (length: 8; value: $0077), (length: 8; value: $0037),
    (length: 9; value: $00CE), (length: 7; value: $010B), (length: 8; value: $0067),
    (length: 8; value: $0027), (length: 9; value: $00AE), (length: 8; value: $0007),
    (length: 8; value: $0087), (length: 8; value: $0047), (length: 9; value: $00EE),
    (length: 7; value: $0107), (length: 8; value: $005F), (length: 8; value: $001F),
    (length: 9; value: $009E), (length: 7; value: $0117), (length: 8; value: $007F),
    (length: 8; value: $003F), (length: 9; value: $00DE), (length: 7; value: $010F),
    (length: 8; value: $006F), (length: 8; value: $002F), (length: 9; value: $00BE),
    (length: 8; value: $000F), (length: 8; value: $008F), (length: 8; value: $004F),
    (length: 9; value: $00FE), (length: 7; value: $0100), (length: 8; value: $0050),
    (length: 8; value: $0010), (length: 8; value: $0118), (length: 7; value: $0110),
    (length: 8; value: $0070), (length: 8; value: $0030), (length: 9; value: $00C1),
    (length: 7; value: $0108), (length: 8; value: $0060), (length: 8; value: $0020),
    (length: 9; value: $00A1), (length: 8; value: $0000), (length: 8; value: $0080),
    (length: 8; value: $0040), (length: 9; value: $00E1), (length: 7; value: $0104),
    (length: 8; value: $0058), (length: 8; value: $0018), (length: 9; value: $0091),
    (length: 7; value: $0114), (length: 8; value: $0078), (length: 8; value: $0038),
    (length: 9; value: $00D1), (length: 7; value: $010C), (length: 8; value: $0068),
    (length: 8; value: $0028), (length: 9; value: $00B1), (length: 8; value: $0008),
    (length: 8; value: $0088), (length: 8; value: $0048), (length: 9; value: $00F1),
    (length: 7; value: $0102), (length: 8; value: $0054), (length: 8; value: $0014),
    (length: 8; value: $011C), (length: 7; value: $0112), (length: 8; value: $0074),
    (length: 8; value: $0034), (length: 9; value: $00C9), (length: 7; value: $010A),
    (length: 8; value: $0064), (length: 8; value: $0024), (length: 9; value: $00A9),
    (length: 8; value: $0004), (length: 8; value: $0084), (length: 8; value: $0044),
    (length: 9; value: $00E9), (length: 7; value: $0106), (length: 8; value: $005C),
    (length: 8; value: $001C), (length: 9; value: $0099), (length: 7; value: $0116),
    (length: 8; value: $007C), (length: 8; value: $003C), (length: 9; value: $00D9),
    (length: 7; value: $010E), (length: 8; value: $006C), (length: 8; value: $002C),
    (length: 9; value: $00B9), (length: 8; value: $000C), (length: 8; value: $008C),
    (length: 8; value: $004C), (length: 9; value: $00F9), (length: 7; value: $0101),
    (length: 8; value: $0052), (length: 8; value: $0012), (length: 8; value: $011A),
    (length: 7; value: $0111), (length: 8; value: $0072), (length: 8; value: $0032),
    (length: 9; value: $00C5), (length: 7; value: $0109), (length: 8; value: $0062),
    (length: 8; value: $0022), (length: 9; value: $00A5), (length: 8; value: $0002),
    (length: 8; value: $0082), (length: 8; value: $0042), (length: 9; value: $00E5),
    (length: 7; value: $0105), (length: 8; value: $005A), (length: 8; value: $001A),
    (length: 9; value: $0095), (length: 7; value: $0115), (length: 8; value: $007A),
    (length: 8; value: $003A), (length: 9; value: $00D5), (length: 7; value: $010D),
    (length: 8; value: $006A), (length: 8; value: $002A), (length: 9; value: $00B5),
    (length: 8; value: $000A), (length: 8; value: $008A), (length: 8; value: $004A),
    (length: 9; value: $00F5), (length: 7; value: $0103), (length: 8; value: $0056),
    (length: 8; value: $0016), (length: 8; value: $011E), (length: 7; value: $0113),
    (length: 8; value: $0076), (length: 8; value: $0036), (length: 9; value: $00CD),
    (length: 7; value: $010B), (length: 8; value: $0066), (length: 8; value: $0026),
    (length: 9; value: $00AD), (length: 8; value: $0006), (length: 8; value: $0086),
    (length: 8; value: $0046), (length: 9; value: $00ED), (length: 7; value: $0107),
    (length: 8; value: $005E), (length: 8; value: $001E), (length: 9; value: $009D),
    (length: 7; value: $0117), (length: 8; value: $007E), (length: 8; value: $003E),
    (length: 9; value: $00DD), (length: 7; value: $010F), (length: 8; value: $006E),
    (length: 8; value: $002E), (length: 9; value: $00BD), (length: 8; value: $000E),
    (length: 8; value: $008E), (length: 8; value: $004E), (length: 9; value: $00FD),
    (length: 7; value: $0100), (length: 8; value: $0051), (length: 8; value: $0011),
    (length: 8; value: $0119), (length: 7; value: $0110), (length: 8; value: $0071),
    (length: 8; value: $0031), (length: 9; value: $00C3), (length: 7; value: $0108),
    (length: 8; value: $0061), (length: 8; value: $0021), (length: 9; value: $00A3),
    (length: 8; value: $0001), (length: 8; value: $0081), (length: 8; value: $0041),
    (length: 9; value: $00E3), (length: 7; value: $0104), (length: 8; value: $0059),
    (length: 8; value: $0019), (length: 9; value: $0093), (length: 7; value: $0114),
    (length: 8; value: $0079), (length: 8; value: $0039), (length: 9; value: $00D3),
    (length: 7; value: $010C), (length: 8; value: $0069), (length: 8; value: $0029),
    (length: 9; value: $00B3), (length: 8; value: $0009), (length: 8; value: $0089),
    (length: 8; value: $0049), (length: 9; value: $00F3), (length: 7; value: $0102),
    (length: 8; value: $0055), (length: 8; value: $0015), (length: 8; value: $011D),
    (length: 7; value: $0112), (length: 8; value: $0075), (length: 8; value: $0035),
    (length: 9; value: $00CB), (length: 7; value: $010A), (length: 8; value: $0065),
    (length: 8; value: $0025), (length: 9; value: $00AB), (length: 8; value: $0005),
    (length: 8; value: $0085), (length: 8; value: $0045), (length: 9; value: $00EB),
    (length: 7; value: $0106), (length: 8; value: $005D), (length: 8; value: $001D),
    (length: 9; value: $009B), (length: 7; value: $0116), (length: 8; value: $007D),
    (length: 8; value: $003D), (length: 9; value: $00DB), (length: 7; value: $010E),
    (length: 8; value: $006D), (length: 8; value: $002D), (length: 9; value: $00BB),
    (length: 8; value: $000D), (length: 8; value: $008D), (length: 8; value: $004D),
    (length: 9; value: $00FB), (length: 7; value: $0101), (length: 8; value: $0053),
    (length: 8; value: $0013), (length: 8; value: $011B), (length: 7; value: $0111),
    (length: 8; value: $0073), (length: 8; value: $0033), (length: 9; value: $00C7),
    (length: 7; value: $0109), (length: 8; value: $0063), (length: 8; value: $0023),
    (length: 9; value: $00A7), (length: 8; value: $0003), (length: 8; value: $0083),
    (length: 8; value: $0043), (length: 9; value: $00E7), (length: 7; value: $0105),
    (length: 8; value: $005B), (length: 8; value: $001B), (length: 9; value: $0097),
    (length: 7; value: $0115), (length: 8; value: $007B), (length: 8; value: $003B),
    (length: 9; value: $00D7), (length: 7; value: $010D), (length: 8; value: $006B),
    (length: 8; value: $002B), (length: 9; value: $00B7), (length: 8; value: $000B),
    (length: 8; value: $008B), (length: 8; value: $004B), (length: 9; value: $00F7),
    (length: 7; value: $0103), (length: 8; value: $0057), (length: 8; value: $0017),
    (length: 8; value: $011F), (length: 7; value: $0113), (length: 8; value: $0077),
    (length: 8; value: $0037), (length: 9; value: $00CF), (length: 7; value: $010B),
    (length: 8; value: $0067), (length: 8; value: $0027), (length: 9; value: $00AF),
    (length: 8; value: $0007), (length: 8; value: $0087), (length: 8; value: $0047),
    (length: 9; value: $00EF), (length: 7; value: $0107), (length: 8; value: $005F),
    (length: 8; value: $001F), (length: 9; value: $009F), (length: 7; value: $0117),
    (length: 8; value: $007F), (length: 8; value: $003F), (length: 9; value: $00DF),
    (length: 7; value: $010F), (length: 8; value: $006F), (length: 8; value: $002F),
    (length: 9; value: $00BF), (length: 8; value: $000F), (length: 8; value: $008F),
    (length: 8; value: $004F), (length: 9; value: $00FF));

  FlateFixedDistCodeTabCodes: array[0..31] of TgtFlateCode = (
    (length: 5; value: $0000), (length: 5; value: $0010), (length: 5; value: $0008),
    (length: 5; value: $0018), (length: 5; value: $0004), (length: 5; value: $0014),
    (length: 5; value: $000C), (length: 5; value: $001C), (length: 5; value: $0002),
    (length: 5; value: $0012), (length: 5; value: $000A), (length: 5; value: $001A),
    (length: 5; value: $0006), (length: 5; value: $0016), (length: 5; value: $000E),
    (length: 0; value: $0000), (length: 5; value: $0001), (length: 5; value: $0011),
    (length: 5; value: $0009), (length: 5; value: $0019), (length: 5; value: $0005),
    (length: 5; value: $0015), (length: 5; value: $000D), (length: 5; value: $001D),
    (length: 5; value: $0003), (length: 5; value: $0013), (length: 5; value: $000B),
    (length: 5; value: $001B), (length: 5; value: $0007), (length: 5; value: $0017),
    (length: 5; value: $000F), (length: 0; value: $0000));

type

  TgtFlateHuffManTab = record
    codes: array of TgtFlateCode;
    maxLen: Integer;
  end;

type
 (**
  * This class is used for decoding a stream from Flate encoded stream
  *)

  TgtFlateDecode = class(TgtDecode)
  private
    { private declarations }
    FStream: TgtStream;
    FBuffer: array[0..FlateWindow - 1] of Byte; // output data buffer
    FIndex: Integer; // current index into output buffer
    FRemaining: Integer; // number valid bytes in output buffer
    FCodeBuffer: Integer; // input buffer
    FCodeSize: Integer; // number of bits in input buffer
    FCodeLengths: array[0..FlateMaxLitCodes + FlateMaxDistCodes - 1] of Integer;
                                            // literal and distance code lengths
    FLitCodeTable: TgtFlateHuffManTab; // literal code table
    FDistCodeTable: TgtFlateHuffManTab; // distance code table
    FCompressedBlock: Boolean; // set if reading a compressed block
    FBlockLength: Integer; // remaining length of uncompressed block
    FEndOfBlock: Boolean; // set when end of block is reached
    FEof: Boolean; // set when end of stream is reached
    FCodeLenCodeMap: array[0..FlateMaxCodeLenCodes - 1] of Integer;
                                            // code length code reordering
    FLengthDecode: array[0..FlateMaxLitCodes - 257 - 1] of TgtFlateDecodeRec;
                                            // length decoding info
    FDistDecode: array[0..FlateMaxDistCodes - 1] of TgtFlateDecodeRec;
                                            // distance decoding info
    FFixedLitCodeTab: TgtFlateHuffManTab; // fixed literal code table
    FFixedDistCodeTab: TgtFlateHuffManTab; // fixed distance code table
    FStreamPred: TgtStreamPredictor; //predictor

    procedure ReadSome;
    function StartBlock: Boolean;
    procedure LoadFixedCodes;
    function ReadDynamicCodes: Boolean;
    procedure CompHuffManCodes(ALengths: array of Integer; NLength: Integer;
      var ATable: TgtFlateHuffManTab);
    function GetHuffManCodeWord(var ATable: TgtFlateHuffManTab): Integer;
    function GetCodeWord(ABits: Integer): Integer;

    procedure InitCodeLenCodeMap;
    procedure InitLengthDecode;
    procedure InitDistCode;
    procedure InitFixedLitCodeTab;
    procedure InitFixedDistCodeTab;

  public
    constructor Create(FlateStream: TgtFilterStream; AStream: TgtStream; APredictor, AColumns,
      AColors, ABits: Integer);
    destructor Destroy; override;
    //function Read(var Buffer: Bytes; Count: Cardinal): Cardinal; override;
    function LookChar: Integer; override;
    function GetChar: Integer; override;
    function ReadRawChar: Integer; override;
    procedure Reset; override;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  StreamConsts, StreamExceptions;
  
{ TgtFlateDecode }

procedure TgtFlateDecode.CompHuffManCodes(ALengths: array of Integer;
  NLength: Integer; var ATable: TgtFlateHuffManTab);
var
  LVal, LTableSize, LI, LLen, LCode, LCode2, LSkip, LT: Integer;
begin
  ATable.maxLen := 0;
  // find max code length
  for LVal := 0 to NLength - 1 do
  begin
    if ALengths[LVal] > ATable.maxLen then
    begin
      ATable.maxLen := ALengths[LVal];
    end;
  end;
  LTableSize := 1 shl ATable.maxLen;
  SetLength(ATable.codes, LTableSize);

  for LI := 0 to LTableSize - 1 do
  begin
    ATable.codes[LI].length := 0;
    ATable.codes[LI].value := 0;
  end;
  // build the table
  LLen := 1;
  LCode := 0;
  LSkip := 2;
  while (LLen <= ATable.maxLen) do
  begin
    for LVal := 0 to NLength - 1 do
    begin
      if ALengths[LVal] = LLen then
      begin
        // bit-reverse the code
        LCode2 := 0;
        LT := LCode;
        for LI := 0 to LLen - 1 do
        begin
          LCode2 := (LCode2 shl 1) or (LT and 1);
          LT := LT shr 1;
        end;

        // fill in the table entries
        LI := LCode2;
        while (LI < LTableSize) do
        begin
          ATable.codes[LI].length := LLen;
          ATable.codes[LI].value := LVal;
          LI := LI + LSkip;
        end;
        Inc(LCode);
      end;
    end;
    Inc(LLen);
    LCode := LCode shl 1;
    LSkip := LSkip shl 1;
  end;
end;

(**
 * Constructor
 * @param FlateStream sream that will used by the predictor algorithm
 * @param AStream the stream that need to be decoded
 * @param APredictor a code that selects the predictor algorithm
 * @param AColumns The number of samples in each row.
 * @param AColors The number of interleaved color components per sample.
 * @param ABits The number of bits used to represent each color component in a
          sample. Valid values are 1, 2, 4, 8, 16
 *)

constructor TgtFlateDecode.Create(FlateStream: TgtFilterStream; AStream: TgtStream; APredictor, AColumns,
  AColors, ABits: Integer);
begin
  FStream := AStream;
  InitCodeLenCodeMap;
  InitLengthDecode;
  InitDistCode;
  InitFixedLitCodeTab;
  InitFixedDistCodeTab;

  FLitCodeTable.codes := nil;
  FDistCodeTable.codes := nil;

  if APredictor <> 1 then
  begin
    FStreamPred := TgtStreamPredictor.Create(FlateStream, APredictor, AColors,
      AColumns, ABits);
    if not FStreamPred.IsOk then
    begin
      FStreamPred.Free;
      FStreamPred := nil;
    end;
  end
  else
    FStreamPred := nil;
end;

(**
 * Destructor
 *)

destructor TgtFlateDecode.Destroy;
begin
  if Assigned(FStreamPred) then
    FStreamPred.Destroy;
  inherited;
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raise if the stream is nil
 *)

function TgtFlateDecode.GetChar: Integer;
begin
  if (FStreamPred <> nil) then
  begin
    Result := FStreamPred.ReadChar;
    Exit;
  end;
  while (FRemaining = 0) do
  begin
    if ((FEndOfBlock) and (FEof)) then
    begin
      Result := EndofFile;
      Exit;
    end;
    ReadSome;
  end;
  Result := FBuffer[FIndex];
  FIndex := (FIndex + 1) and FlateMask;
  Dec(FRemaining);
end;

function TgtFlateDecode.GetCodeWord(ABits: Integer): Integer;
var
  LChar: Integer;
begin
  Result := EndofFile;
  while (FCodeSize < ABits) do
  begin
    LChar := FStream.GetChar;
    if (LChar = EndofFile) then Exit;
    FCodeBuffer := ((FCodeBuffer) or ((LChar and $FF) shl FCodeSize));
    FCodeSize := FCodeSize + 8;
  end;
  LChar := ((FCodeBuffer) and ((1 shl ABits) - 1));
  FCodeBuffer := FCodeBuffer shr ABits;
  FCodeSize := FCodeSize - ABits;
  Result := LChar;
end;

function TgtFlateDecode.GetHuffManCodeWord(
  var ATable: TgtFlateHuffManTab): Integer;
var
  LCode: TgtFlateCode;
  LChar: Integer;
begin
  Result := EndofFile;
  while (FCodeSize < ATable.maxLen) do
  begin
    LChar := FStream.GetChar;
    if (LChar = EndofFile) then Exit;
    FCodeBuffer := FCodeBuffer or ((LChar and $FF) shl FCodeSize);
    FCodeSize := FCodeSize + 8;
  end;
  LCode := ATable.codes[FcodeBuffer and ((1 shl ATable.maxLen) - 1)];
  if ((FCodeSize = 0) or (FCodeSize < LCode.length) or (LCode.length = 0)) then
    Exit;
  FCodeBuffer := FCodeBuffer shr LCode.length;
  FCodeSize := FCodeSize - LCode.length;
  Result := Integer(LCode.value);
end;

procedure TgtFlateDecode.InitCodeLenCodeMap;
var
  I: Integer;
begin
  for I := 0 to Length(FCodeLenCodeMap) - 1 do
    FCodeLenCodeMap[I] := CodeLenCodeMap[I];
end;

procedure TgtFlateDecode.InitDistCode;
var
  I: Integer;
begin
  for I := 0 to Length(FDistDecode) - 1 do
    FDistDecode[I] := DistDecode[I];
end;

procedure TgtFlateDecode.InitFixedDistCodeTab;
var
  I: Integer;
begin
  SetLength(FFixedDistCodeTab.codes, Length(FlateFixedDistCodeTabCodes));
  for I := 0 to Length(FlateFixedDistCodeTabCodes) - 1 do
  begin
    FFixedDistCodeTab.codes[I].length := FlateFixedDistCodeTabCodes[I].length;
    FFixedDistCodeTab.codes[I].value := FlateFixedDistCodeTabCodes[I].value;
  end;
  FFixedDistCodeTab.maxLen := 5;
end;

procedure TgtFlateDecode.InitFixedLitCodeTab;
var
  I: Integer;
begin
  SetLength(FFixedLitCodeTab.codes, Length(FlateFixedLitCodeTabCodes));
  for I := 0 to Length(FlateFixedLitCodeTabCodes) - 1 do
  begin
    FFixedLitCodeTab.codes[I].length := FlateFixedLitCodeTabCodes[I].length;
    FFixedLitCodeTab.codes[I].value := FlateFixedLitCodeTabCodes[I].value;
  end;
  FFixedLitCodeTab.maxLen := 9;
end;

procedure TgtFlateDecode.InitLengthDecode;
var
  I: Integer;
begin
  for I := 0 to Length(FLengthDecode) - 1 do
  begin
    FLengthDecode[I].bits := LengthDecode[I].bits;
    FLengthDecode[I].first := LengthDecode[I].first;
  end;
end;

procedure TgtFlateDecode.LoadFixedCodes;
begin
  FLitCodeTable.codes := FFixedLitCodeTab.codes;
  FLitCodeTable.maxLen := FFixedLitCodeTab.maxLen;
  FDistCodeTable.codes := FFixedDistCodeTab.codes;
  FDistCodeTable.maxLen := FFixedDistCodeTab.maxLen;
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raise if the stream is nil
 *)

function TgtFlateDecode.LookChar: Integer;
begin
  if (FStreamPred <> nil) then
  begin
    Result := FStreamPred.LookChar;
    Exit;
  end;
  while (FRemaining = 0) do
  begin
    if ((FEndOfBlock) and (FEof)) then
    begin
      Result := EndofFile;
      Exit;
    end;
    ReadSome;
  end;
  Result := FBuffer[FIndex];
end;

//function TgtFlateDecode.Read(var Buffer: Bytes; Count: Cardinal): Cardinal;
//begin
//  Result := 0;
//end;

function TgtFlateDecode.ReadDynamicCodes: Boolean;
var
  LNumCodeLenCodes, LNumLitCodes, LNumDistCodes,
    LLength, LRepeat, LCode, LI: Integer;
  LCodeLenCodeLengths: array[0..FlateMaxCodeLenCodes - 1] of Integer;
  LCodeLenCodeTab: TgtFlateHuffManTab;
  LError: Boolean;
  I: Integer;
  LCodeLengths: array of Integer;
begin
  LError := False;

  // read lengths
  LNumLitCodes := GetCodeWord(5);
  if (LNumLitCodes = EndofFile) then
    LError := True;
  LNumLitCodes := LNumLitCodes + 257;

  LNumDistCodes := GetCodeWord(5);
  if (LNumDistCodes = EndofFile) then
    LError := True;
  Inc(LNumDistCodes);

  LNumCodeLenCodes := getCodeWord(4);
  if (LNumCodeLenCodes = EndofFile) then
    LError := True;
  LNumCodeLenCodes := LNumCodeLenCodes + 4;

  if ((LNumLitCodes > FlateMaxLitCodes) or (LNumDistCodes > flateMaxDistCodes)
    or (LNumCodeLenCodes > FlateMaxCodeLenCodes)) then
    LError := True;

  // build the code length code table
  for LI := 0 to FlateMaxCodeLenCodes - 1 do
    LCodeLenCodeLengths[LI] := 0;

  for LI := 0 to LNumCodeLenCodes - 1 do
  begin
    LCodeLenCodeLengths[FCodeLenCodeMap[LI]] := getCodeWord(3);
    if (LCodeLenCodeLengths[FCodeLenCodeMap[LI]] = -1) then
      LError := True;
  end;
  CompHuffManCodes(LCodeLenCodeLengths, FlateMaxCodeLenCodes, LCodeLenCodeTab);

  // build the literal and distance code tables
  LLength := 0;
  LI := 0;
  while (LI < LNumLitCodes + LNumDistCodes) do
  begin
    LCode := GetHuffManCodeWord(LCodeLenCodeTab);
    if (LCode = EndofFile) then
      LError := True;
    if (LCode = 16) then
    begin
      LRepeat := GetCodeWord(2);
      if (LRepeat = EndofFile) then
        LError := True;
      LRepeat := LRepeat + 3;
      if ((LI + LRepeat) > LNumLitCodes + LNumDistCodes) then
        LError := True;
      while (LRepeat > 0) do
      begin
        FCodeLengths[LI] := LLength;
        Inc(LI);
        Dec(LRepeat);
      end;
    end
    else if (LCode = 17) then
    begin
      LRepeat := GetCodeWord(3);
      if (LRepeat = EndofFile) then
        LError := True;
      LRepeat := LRepeat + 3;
      if ((LI + LRepeat) > LNumLitCodes + LNumDistCodes) then
        LError := True;
      LLength := 0;
      while (LRepeat > 0) do
      begin
        FCodeLengths[LI] := 0;
        Inc(LI);
        Dec(LRepeat);
      end;
    end
    else if (LCode = 18) then
    begin
      LRepeat := GetCodeWord(7);
      if (LRepeat = EndofFile) then
        LError := True;
      LRepeat := LRepeat + 11;
      if ((LI + LRepeat) > LNumLitCodes + LNumDistCodes) then
        LError := True;
      LLength := 0;
      while (LRepeat > 0) do
      begin
        FCodeLengths[LI] := 0;
        Inc(LI);
        Dec(LRepeat);
      end;
    end
    else
    begin
      LLength := LCode;
      FCodeLengths[LI] := LLength;
      Inc(LI);
    end;
  end;
  compHuffmanCodes(FCodeLengths, LNumLitCodes, FLitCodeTable);
  SetLength(LCodeLengths, FlateMaxLitCodes + FlateMaxDistCodes);
  for I := LNumLitCodes to Length(FCodeLengths) - 1 do
    LCodeLengths[I - LNumLitCodes] := FCodeLengths[I];
  compHuffmanCodes(LCodeLengths, LNumDistCodes, FDistCodeTable);
  SetLength(LCodeLengths, 0);
  Result := True;
  if LError then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Bad dynamic code table in flate stream');
{$ENDIF}
    Result := False;
  end;
end;

(**
 * Gets each raw charecter on request without decoding
 * @return The charecter(integer value) without decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtFlateDecode.ReadRawChar: Integer;
begin
  while (FRemaining = 0) do
  begin
    if ((FEndOfBlock) and (FEof)) then
    begin
      Result := EndofFile;
      Exit;
    end;
    ReadSome;
  end;
  Result := FBuffer[FIndex];
  FIndex := (FIndex + 1) and (FlateWindow - 1);
  Dec(FRemaining);
end;

procedure TgtFlateDecode.ReadSome;
var
  LCode1, LCode2, LLength, LDist, LI, LJ, LK, LC: Integer;
  LError: Boolean;
  LStream: TgtStream;
begin
  if (FStream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  LError := False;
  if FEndOfBlock then
    if not startBlock then
      exit;
  if FCompressedBlock then
  begin
    LCode1 := GetHuffManCodeWord(FLitCodeTable);
    if LCode1 = EndofFile then
      LError := True;
    if LCode1 < 256 then
    begin
      FBuffer[FIndex] := LCode1;
      FRemaining := 1;
    end
    else if LCode1 = 256 then
    begin
      FEndOfBlock := True;
      FRemaining := 0;
    end
    else
    begin
      LCode1 := LCode1 - 257;
      LCode2 := FLengthDecode[LCode1].bits;
      LCode2 := GetCodeWord(LCode2);
      if ((LCode2 = EndofFile) and (LCode2 > 0)) then
        LError := True;
      LLength := FLengthDecode[LCode1].first + LCode2;
      LCode1 := getHuffmanCodeWord(FDistCodeTable);
      if LCode1 = -1 then
        LError := True;
      LCode2 := FDistDecode[LCode1].bits;
      LCode2 := GetCodeWord(LCode2);
      if LCode2 = -1 then
        LError := True;
      LDist := FDistDecode[LCode1].first + LCode2;
      LI := FIndex;
      LJ := (FIndex - LDist) and FlateMask;
      for LK := 0 to LLength - 1 do
      begin
        FBuffer[LI] := FBuffer[LJ];
        LI := (LI + 1) and FlateMask;
        LJ := (LJ + 1) and FlateMask;
      end;
      FRemaining := LLength;
    end;
  end
  else
  begin
    if FBlockLength < FlateWindow then
      LLength := FBlockLength
    else
      LLength := FlateWindow;
    LJ := FIndex;
    LI := 0;
    while LI < LLength do
    begin
      LStream := FStream;
      LC := LStream.GetChar;
      if (LC = -1) then
      begin
        FEof := True;
        FendOfBlock := FEof;
        Break;
      end;
      FBuffer[LJ] := (LC and $FF);
      LJ := (LJ + 1) and FlateMask;
      Inc(LI);
    end;
    FRemaining := LI;
    FBlockLength := FBlockLength - LLength;
    if (FBlockLength = 0) then
      FEndOfBlock := True;
  end;
  if LError then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Unexpected end of file in flate stream');
{$ENDIF}
    FEof := True;
    FEndOfBlock := FEof;
    FRemaining := 0;
  end;
end;

(**
 * Resets the Stream to its defaults
 *
 * @exception ExInvalidStream will be raised if Fstream is nil
 *)

procedure TgtFlateDecode.Reset;
var
  LCmf, LFlag: Integer;
begin
  if (FStream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  FIndex := 0;
  FRemaining := 0;
  FCodeBuffer := 0;
  FCodeSize := 0;
  FCompressedBlock := False;
  FEndOfBlock := True;
  FEof := True;
  FStream.Reset;

  // read header
  //~ need to look at window size?
  FEndOfBlock := True;
  FEof := True;
  LCmf := FStream.GetChar;
  LFlag := FStream.GetChar;

  if (LCmf = EndofFile) or (LFlag = EndofFile) then
  begin
    Exit;
  end;

  if ((LCmf and $0F) <> $08) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('%d Unknown compression method in flate stream',
      [FStream.GetPosition]);
{$ENDIF}
    Exit;
  end;
  if ((((LCmf shl 8) + LFlag) mod 31) <> 0) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('%d Bad FCHECK in flate stream', [FStream.GetPosition]);
{$ENDIF}
    Exit;
  end;
  if (LFlag and $20) > 0 then
  begin
{$IFDEF DEBUG}
    Logger.LogError('%d FDICT bit set in flate stream', [FStream.GetPosition]);
{$ENDIF}
    Exit;
  end;
  FEof := False;
end;

function TgtFlateDecode.StartBlock: Boolean;
var
  LBlockHdr, LC, LCheck: Integer;
  LStream: TgtStream;

  procedure GotoError;
  begin
    FEndOfBlock := True;
    FEof := True;
    Result := False;
  end;

begin
  if FLitCodeTable.codes <> FFixedLitCodeTab.codes then
  begin
    SetLength(FLitCodeTable.codes, 0);
  end;
  if FDistCodeTable.codes <> FFixedDistCodeTab.codes then
  begin
    SetLength(FDistCodeTable.codes, 0);
  end;

  // Read block header
  LBlockHdr := GetCodeWord(3);
  if ((LBlockHdr and 1) > 0) then
  begin
    FEof := True;
  end;
  LBlockHdr := LBlockHdr shr 1;
  LStream := FStream;
  //uncompressed block
  if LBlockHdr = 0 then
  begin
    FCompressedBlock := False;
    LC := LStream.GetChar;
    if (LC = EndofFile) then
    begin
      GotoError;
      Exit;
    end;
    FBlockLength := LC and $FF;
    LC := LStream.GetChar;
    if LC = EndofFile then
    begin
      GotoError;
      Exit;
    end;
    FBlockLength := FBlockLength or (LC and $FF) shl 8;
    LC := LStream.GetChar;
    if (LC = EndofFile) then
    begin
      GotoError;
      Exit;
    end;
    LCheck := LC and $FF;
    LC := LStream.GetChar;
    if (LC = EndofFile) then
    begin
      GotoError;
      Exit;
    end;
    LCheck := LCheck or (LC and $FF) shl 8;
    if (LCheck <> (not FBlockLength and $FFFF)) then
    begin
{$IFDEF DEBUG}
      Logger.LogError('%d Bad uncompressed block length in flate stream',
        [LStream.GetPosition]);
{$ENDIF}
    end;
    FCodeBuffer := 0;
    FCodeSize := 0;
  end
  else if LBlockHdr = 1 then // compressed block with fixed codes
  begin
    FCompressedBlock := True;
    LoadFixedCodes;
  end
  else if LBlockHdr = 2 then // compressed block with dynamic codes
  begin
    FCompressedBlock := True;
    if (not ReadDynamicCodes) then
    begin
      GotoError;
      Exit;
    end;
  end
  else // unknown block type
  begin
    GotoError;
    Exit;
  end;
  FEndOfBlock := False;
  Result := True;
end;

end.
