
{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2013 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtDocConsts;

interface
uses
  Graphics, gtConsts3;

const
{---- EditColor constant ------------------------------------------------------}
	EditColor: array[Boolean] of TColor = (clInactiveBorder, clWindow);

{---- RTF conversion constants ------------------------------------------------}
  CInchesToEMU = 914400;

{ ---- Common constants -------------------------------------------------------}
  {$IFDEF gtActiveX}
    CVersion = '4.0.0.467';
  {$ELSE}
    CVersion = '4.0.0.467';
  {$ENDIF}

  CCopyright =
  	'Copyright © 2002-2013 Gnostice Information Technologies Private Limited';
  CMaxPages = 5;
	CBackgroundColor = clWhite;

{------------------- Constants required in MetafileProcessor ------------------}
	// Font Flag bit values
	CFontFixedPitch: array[Boolean] of integer = (0, 1);
	CFontSerif: array[Boolean] of integer = (0, 2);
	CFontSymbolic: array[Boolean] of integer = (0, 4);
	CFontScript: array[Boolean] of integer = (0, 8);
	CFontNonSymbolic: array[Boolean] of integer = (0, 32);
	CFontItalic: array[Boolean] of integer = (0, 64);

{----------------------------- PDF Engine -------------------------------------}
	CRootObjNo = 1;
	CPagesTreeObjNo = 2;
	CInfoObjNo = 3;
	CProcSetObjNo = 4;
	CResourcesObjNo = 5;
  CLastReservedObjNo = 5;

  //TgtCustomPDFInfo XMP support

  CAdobePDFSchemaURI = 'http://ns.adobe.com/pdf/1.3/';
  CBasicSchemaURI = 'http://ns.adobe.com/xap/1.0/';
  CDublinCoreSchemaURI = 'http://purl.org/dc/elements/1.1/';
  CJobTicketSchemaURI = 'http://ns.adobe.com/xap/1.0/bj/';
  CRightsManageSchemaURI = 'http://ns.adobe.com/xap/1.0/rights/';
  CPagedTextSchemaURI = 'http://ns.adobe.com/xap/1.0/t/pg/';

  CXMPPacketHeader = '<?xpacket begin='''' id=''W5M0MpCehiHzreSzNTczkc9d''?>' + CR + LF;
  CXMPPacketTrailer = '<?xpacket end=''w''?>' + CR + LF;
  CXmpMetaHeader = '<x:xmpmeta xmlns:x=''adobe:ns:meta/''>' + CR + LF;
  CXMPMetaTrailer = '</x:xmpmeta>' + CR + LF;
  CRDFHeader1 = '<rdf:RDF xmlns:rdf=''http://www.w3.org/1999/02/22-rdf-syntax-ns#''' + CR + LF;
  CRDFHeader2 = 'xmlns:iX=''http://ns.adobe.com/iX/1.0/''>';
  CRDFTrailer = '</rdf:RDF>' + CR + LF;
  CRDFDesHeader = '<rdf:Description about=''''';
  CRDFDesTrailor = '</rdf:Description>' + CR + LF;

  CAdobePDFNamePrefix = 'pdf';
  CBasicNamePrefix = 'xmp';
  CDublinCoreNamePrefix = 'dc';
  CJobTicketNamePrefix = 'xmpBJ';
  CRightsManageNamePrefix = 'xmpRights';
  CPagedTextNamePrefix = 'xmpTPg';

{----------------------------- HTML/XHTML Engine ------------------------------}
  CLinkForeColor = $00FF0000;								// BGR
	CLinkBackColor = $00FFFFFF;								// BGR
	CLinkHoverForeColor = $00FFFFFF;					// BGR
	CLinkHoverBackColor = $00FF0000;					// BGR
	CNavNormalColor = '#0000FF';
	CNavNormalBackground = '#FFFFFF';
	CNavHoverColor = '#FFFFFF';
	CNavHoverBackground = '#0000FF';

	CPageEndLineWidth = 2;
	CmmToInch = 25.4;
    {$IFDEF gtBDS2006}
	CLineStyle: array[TPenStyle] of String = ('solid', 'dashed', 'dotted',
  	'dashed', 'dashed' , 'dashed', 'dashed', '', '');
     {$ELSE}
	CLineStyle: array[TPenStyle] of String = ('solid', 'dashed', 'dotted',
  	'dashed', 'dashed' , 'dashed', 'dashed');
    {$ENDIF}


	// HTML: Text prepended with CHTMLNoTranslate does not get translated.
	// For example: space characters do not get replaced with '&nbps;'.
	// Use when specifying URLs that need to be active in the generated HMTL.
	CHTMLNoTranslateText = #1#1#1;
  CANSICodePageIDs: array[0..13] of record
		ISOCode: String;
		WinCode: Integer;
	end = (
		(ISOCode: 'ISO-8859-11'; WinCode: 874), // 874  Thai
		(ISOCode: 'Windows-932'; WinCode: 932), // 932  Japanese
		(ISOCode: 'gb2312-80'; WinCode: 936),   // 936  Chinese (PRC, Singapore)
		(ISOCode: 'Windows-949'; WinCode: 949), // 949  Korean
		(ISOCode: 'csbig5'; WinCode: 950),      // 950  Chinese (Taiwan, Hong Kong)
		(ISOCode: 'ISO-10646'; WinCode: 1200),  // 1200 Unicode (BMP of ISO 10646)
		(ISOCode: 'ISO-8859-2'; WinCode: 1250), // 1250 Windows 3.1 Eastern European 
		(ISOCode: 'ISO-8859-5'; WinCode: 1251), // 1251 Windows 3.1 Latin/Cyrillic 
		(ISOCode: 'ISO-8859-1'; WinCode: 1252), // 1252 Windows 3.1 Latin 1 (US, Western Europe) 
		(ISOCode: 'ISO-8859-7'; WinCode: 1253), // 1253 Windows 3.1 Greek 
		(ISOCode: 'ISO-8859-9'; WinCode: 1254), // 1254 Windows 3.1 Turkish 
		(ISOCode: 'ISO-8859-8'; WinCode: 1255), // 1255 Hebrew 
		(ISOCode: 'ISO-8859-6'; WinCode: 1256), // 1256 Latin/Arabic 
		(ISOCode: 'ISO-8859-13'; WinCode: 1257) // 1257 Baltic
		);

{----------------------------- TIFF Engine ------------------------------------}
  CDirCountSize = 2;
  CIFDOffsetSize = 4;
  CBitsPerSample = Word(8);
  CByteOrder = Word($4949);
  CTIFFId = Word($2A);
  CDirSize = Word(12);
  CTagWidth = Word($100);
  CTagLength = Word($101);
  CTagBitsPerSample = Word($102);
  CTagCompression = Word($103);
  CTagPhotometricInterpretation = Word($106);
  CTagImageDesc = Word($10E);
  CTagStripOffsets = Word($111);
  CTagSamplesPerPixel = Word($115);
  CTagRowsPerStrip = Word($116);
  CTagStripByteCounts = Word($117);
  CTagXRes = Word($11A);
  CTagYRes = Word($11B);
  CTagSoftware = Word($131);
  CTagArtist = Word($13B);
  CTagCopyright = Word($8298);

  CTypeAscii = Word(2);
  CTypeShort = Word(3);
  CTypeLong = Word(4);
  CTypeRational = Word(5);

{----------------------------- Excel Engine -----------------------------------}
	CExcel_BOF = $0009;
	CExcel_BIFF7 = $809;
	CExcel_BIFF7_BOF = cExcel_BOF or cExcel_BIFF7;
	CExcel_DocType = $0010;
	CExcel_Rec_Size_BOF = $08;
	CExcel_EOF = $000A;
	CExcel_Rec_Size_EOF = 0;
	CExcel_DIM = $0200;
	CExcel_Rec_Size_DIM = 10;
	CExcel_Cell_Int = 2;
	CExcel_Rec_Size_Cell_Int = 11;
	CExcel_Cell_Double = $203;
	CExcel_Rec_Size_Cell_Double = 14;
	CExcel_Cell_Label = $204;
	CExcel_Rec_Size_Cell_Label = 8;
  CExcel_Cell_Column = 36;
  CExcel_Rec_Size_Cell_Column =4;
  CExcel_Column_Width = 256;
  CExcel_ColInfo = $7D;
  CExcel_RightMargin = $27;
  CExcel_LeftMargin = $26;
  CExcel_TopMargin = $28;
  CExcel_BottomMargin = $29;
  CExcel_Setup = $A1;

  CSheet_StdCharsPerCell = 8.43;

  COLEPadBytes = '52006f006f007400200045006e007400'
    + '72007900000000000000000000000000'
    + '00000000000000000000000000000000'
    + '00000000000000000000000000000000'
    + '16000501ffffffffffffffff02000000'
    + '1008020000000000C000000000000046'
    + '00000000000000000000000000000000'
    + '00000000feffffff0000000000000000'
    + '42006f006f006b000000000000000000'
    + '00000000000000000000000000000000'
    + '00000000000000000000000000000000'
    + '00000000000000000000000000000000'
    + '0a000201ffffffffffffffffffffffff'
    + '00000000000000000000000000000000'
    + '00000000000000000000000000000000'
    + '00000000000000000010000000000000'
    + '0500530075006d006d00610072007900'
    + '49006e0066006f0072006d0061007400'
    + '69006f006e0000000000000000000000'
    + '00000000000000000000000000000000'
    + '280002010100000003000000ffffffff'
    + '00000000000000000000000000000000'
    + '00000000000000000000000000000000'
    + '00000000000000000010000000000000'
    + '050044006f00630075006d0065006e00'
    + '7400530075006d006d00610072007900'
    + '49006e0066006F0072006d0061007400'
    + '69006f006e0000000000000000000000'
    + '38000201ffffffffffffffffffffffff'
    + '00000000000000000000000000000000'
    + '00000000000000000000000000000000'
    + '00000000100000000010000000000000';

  CSummaryInfoSize = 4096;
	CDocumentSummaryInfoSize = 4096;
  CStandardHeight : Extended = 12.7;
  CMaxRowHeight = 409;
  CMaxColWidth =  256;
  
{----------------------------- QuattroPro Engine -----------------------------------}
  CQpro_BOF = 0;
  CQpro_BOF_LEN = 2;
  CQPro_EOF = 1;
  CQPro_EOF_LEN = 0;
  CQpro_REVISION = $1001;
//  CQpro_REVISION = $5120;
  CQPro_BOP = 202;
  CQPro_BOP_LEN = 1;
  CQPro_EOP = 203;
  CQPro_EOP_LEN = 1;
  CQPro_DIMENSION = 7;
  CQPro_DIMENSION_LEN = 8;
  CQPro_STRING = 15;
  CQPro_STRING_LEN = 7;
  CQPro_NUMBER = 14;
  CQPro_NUMBER_LENGTH = 14;
  CQPro_MARGIN = 40;
  CQPro_MARGIN_LENGTH = 12;
  CQPro_Orientation = 247;
  CQPro_Orientation_LENGTH = 1;
  CQPro_PrintBegin = 265;
  CQPro_PrintEnd = 251;
  CQPro_Font = 207;
  CQPro_Font_LENGTH = 36;
  CQPro_Color = 232;
  CQPro_CellAttrib = 206;

{----------------------------- Lotus Engine -----------------------------------}
  CLOTUS_REVISION = $0404;
  CLOTUS_BOF = 0;
  CLOTUS_BOF_LEN = 2;
  CLOTUS_EOF = 1;
  CLOTUS_EOF_LEN = 0;
  CLOTUS_RANGE =6;
  CLOTUS_RANGE_LEN = 8;
  CLOTUS_STRING = 15;
  CLOTUS_STRING_LEN = 6;
  CLOTUS_NUMBER = 14;
  CLOTUS_PAGE = $28;
  CLOTUS_PAGE_LENGTH = 10;


implementation

end.
