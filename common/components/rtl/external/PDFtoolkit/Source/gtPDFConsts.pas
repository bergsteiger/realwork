{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
unit gtPDFConsts;

interface

uses
 graphics;

const
  SProductName = 'Gnostice PDFtoolkit (www.gnostice.com)';
  CVersion = '3.4';
  CTrialLimit: Integer = 5;

  //Place Holder Constants
  CphPageNo = '<%PageNo%>';
  CphTotalPages = '<%TotPage%>';
  CphShortDate = '<%ShortDate%>';
  CphShortTime = '<%ShortTime%>';
  CphLongDate = '<%LongDate%>';
  CphLongTime = '<%LongTime%>';
  CphAuthor = '<%Author%>';
  CphCreator = '<%Creator%>';
  CphSubject = '<%Subject%>';
  CphTitle = '<%Title%>';

  NUL = #0; // Null
  TAB = #9; // Tab
  BS = #8; // Backspace
  LF = #10; // Line Feed
  FF = #12; // Form Feed (PageBreak)
  CR = #13; // Carriage Return
  SP = #32; // Space
  CRLF = CR + LF; // End-of-line (EOL)
  NBSP = #160; // No-Break Space

 {-------------  unit conversion constants -------------------------------------}
  CInchesToPoints = 72;
  CMMToPoints = 2.83464;
  CMMToInches = 0.03937;
  CTwipsToPoints = 1 / 20;
 {------------- XML Constants---------------------------------------------------}
  CXMPPacketHeader = '<?xpacket begin='''' id=''W5M0MpCehiHzreSzNTczkc9d''?>' + CR + LF;
  CXMPPacketTrailer = '<?xpacket end=''w''?>' + CR + LF;
  CXmpMetaHeader = '<x:xmpmeta xmlns:x=''adobe:ns:meta/''>' + CR + LF;
  CXMPMetaTrailer = '</x:xmpmeta>' + CR + LF;
  CRDFHeader1 = '<rdf:RDF xmlns:rdf=''http://www.w3.org/1999/02/22-rdf-syntax-ns#''' + CR + LF;
  CRDFHeader2 = 'xmlns:iX=''http://ns.adobe.com/iX/1.0/''>';
  CRDFTrailer = '</rdf:RDF>' + CR + LF;
  CRDFDesHeader = '<rdf:Description about=''''';
  CRDFDesTrailor = '</rdf:Description>' + CR + LF;

  CAdobePDFSchemaURI = 'http://ns.adobe.com/pdf/1.3/';
  CBasicSchemaURI = 'http://ns.adobe.com/xap/1.0/';
  CDublinCoreSchemaURI = 'http://purl.org/dc/elements/1.1/';
  CJobTicketSchemaURI = 'http://ns.adobe.com/xap/1.0/bj/';
  CRightsManageSchemaURI = 'http://ns.adobe.com/xap/1.0/rights/';
  CPagedTextSchemaURI = 'http://ns.adobe.com/xap/1.0/t/pg/';

  CAdobePDFNamePrefix = 'pdf';
  CBasicNamePrefix = 'xmp';
  CDublinCoreNamePrefix = 'dc';
  CJobTicketNamePrefix = 'xmpBJ';
  CRightsManageNamePrefix = 'xmpRights';
  CPagedTextNamePrefix = 'xmpTPg';

  BlankDoc = '%PDF-1.4' + CRLF +
    '1 0 obj' + CRLF +
    '<</Type /Catalog/Pages 2 0 R>>' + CRLF +
    'endobj' + CRLF +
    '2 0 obj' + CRLF +
    '<</Type /Pages/Kids [3 0 R]/MediaBox [0 0 595 842]/Count 1>>' + CRLF +
    'endobj' + CRLF +
    '3 0 obj' + CRLF +
    '<</Type /Page/Parent 2 0 R>>' + CRLF +
    'endobj' + CRLF +
    'xref' + CRLF +
    '0 4' + CRLF +
    '0000000000 65535 f' + CRLF +
    '0000000010 00000 n' + CRLF +
    '0000000059 00000 n' + CRLF +
    '0000000138 00000 n' + CRLF +
    'trailer' + CRLF +
    '<</Size 4/Root 1 0 R>>' + CRLF +
    'startxref' + CRLF +
    '185' + CRLF +
    '%%EOF';
  clSkyBlue = TColor($F0CAA6);

implementation

end.
