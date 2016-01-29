{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDConsts;

interface

const
  //Maximum size within which the XRef can be found
  XRefSearchSize = 1024;

  PD_XREF = 'xref';
  PD_STARTXREF = 'startxref';
  PD_TRAILER = 'trailer';
  PD_PREV = 'Prev';
  PD_XREFSTM = 'XRefStm';
  PD_SIZE = 'Size';
  PD_W = 'W';
  PD_INDEX = 'Index';
  PD_N = 'N';
  PD_FIRST = 'First';

  PD_TYPE = 'Type';

  PD_FILTER = 'Filter';
  PD_F = 'F';
  PD_DECODEPARAMS = 'DecodeParms';
  PD_DP = 'DP';

  PD_FLATEDECODE = 'FlateDecode';
  PD_Fl = 'Fl';
  PD_PREDICTOR = 'Predictor';
  PD_COLUMNS = 'Columns';
  PD_COLORS = 'Colors';
  PD_BITSPERCOMP = 'BitsPerComponent';

  PD_ASCIIHEXDECODE = 'ASCIIHexDecode';
  PD_AHx = 'AHx';

  PD_ASCII85DECODE = 'ASCII85Decode';
  PD_A85 = 'A85';

  PD_LZWDECODE = 'LZWDecode';
  PD_LZW = 'LZW';
  PD_EARLYCHANGE = 'EarlyChange';

  PD_RUNLENGTHDECODE = 'RunLengthDecode';
  PD_RL = 'RL';

  PD_CCITTFAXDECODE = 'CCITTFaxDecode';
  PD_CCF = 'CCF';
  PD_K = 'K';
  PD_ENDOFLINE = 'EndOfLine';
  PD_ENCODEDBYTEALIG = 'EncodedByteAlign';
  PD_ROWS = 'Rows';
  PD_ENDOFBLOCK = 'EndOfBlock';
  PD_BLACKIS1 = 'BlackIs1';
  PD_IMAGEMASK = 'ImageMask';

  PD_DCTDECODE = 'DCTDecode';
  PD_DCT = 'DCT';
  PD_COLORTRANSFORM = 'ColorTransform';

  PD_JBIG2DECODE = 'JBIG2Decode';
  PD_JBIG2GLOBALS = 'JBIG2Globals';

  PD_JPXDECODE = 'JPXDecode';

  PD_PATHSEPARATOR = '/';
  PD_ARRAYSTART = '[';
  PD_ARRAYEND = ']';

  PD_CATALOG = 'Catalog';
  PD_ROOT = 'Root';
  PD_PAGES = 'Pages';

  PD_ENCRYPT = 'Encrypt';
  PD_DOCINFO = 'Info';

  PDF_FILE = 'File';


implementation

end.
