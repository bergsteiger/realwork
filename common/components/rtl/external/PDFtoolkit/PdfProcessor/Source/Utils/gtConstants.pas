{ ********************************************************************* }
{                                                                       }
{                       Gnostice Utilities                              }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit gtConstants;

interface

const

  SpecialChars: array[0..255] of Integer = (
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, // 0x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 1x
    1, 0, 0, 0, 0, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, // 2x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, // 3x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 4x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, // 5x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 6x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, // 7x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 8x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 9x
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // ax
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // bx
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // cx
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // dx
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // ex
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 // fx
    );

  PDFPRODUCER = 'Gnostice PDFProcessor v 4.0';

  ENDOFFILE = -1; // End of File (EOF)
  NUL = 00; // Null
  BACKSPACE = 08; // Backspace
  TABSPACE = 09; // Tab
  LINEFEED = 10; // Line Feed
  FORMFEED = 12; // Form Feed (PageBreak)
  CARRIAGERETURN = 13; // Carriage Return
  SPACE = 32; // Space
  PERCENTSIGN = 37; // '%'
  LEFTPARENTHESIS = 40; // '('
  RIGHTPARENTHESIS = 41; // ')'
  HYPHENMINUS = 45; // '-'
  FULLSTOP = 46; // '.'
  SOLIDUS = 47; // '/'
  DIGITZERO = 48; // '0'
  DIGITNINE = 57; // '9'
  LETTERCAPSA = 65; // 'A'
  LETTERCAPSF = 70; // 'F'
  LESSTHANSIGN = 60; // '<'
  GREATERTHANSIGN = 62; // '>'
  LEFTSQUAREBRACKET = 91; // '['
  ESCAPE = 92; // '\'
  RIGHTSQUAREBRACKET = 93; // ']'
  LETTERSMALLa = 97; // 'a'
  LETTERSMALLf = 102; // 'f'
  LEFTCURLYBRACKET = 123; // '{'
  RIGHTCURLYBRACKET = 125; // '}'

  //FDF version
  FDF_VERSION = 1.2;
  FDF = 'FDF';
  PDF_VERSION = 'Version';

  //Boolean
  PDF_TRUE = 'true';
  PDF_FALSE = 'false';

  //Indirect Reference
  PDF_R = 'R';

  //Dictionary
  PDF_OBJ = 'obj';
  PDF_ENDOBJ = 'endobj';
  PDF_DICTSTART = '<<';
  PDF_DICTEND = '>>';

  //XRef
  PDF_XREF = 'xref';

  //Stream
  PDF_STREAM = 'stream';
  PDF_ENDSTREAM = 'endstream';

  //General
  PDF_TYPE = 'Type';
  PDF_PARENT = 'Parent';
  PDF_ROOT = 'Root';
  PDF_INFO = 'Info';
  PDF_SIZE = 'Size';
  PDF_PREV = 'Prev';
  PDF_STARTXREF = 'startxref';
  PDF_EOF = '%%EOF';
  PDF_TRAILER = 'trailer';
  PDF_NUMS = 'Nums';
  PDF_LIMITS = 'Limits';
  PDF_NAMES = 'Names';
  PDF_COUNT = 'Count';
  PDF_LINEARIZED = 'Linearized';

  //Encryption
  PDF_ENCRYPT = 'Encrypt';
  PDF_OWNER = 'O'; // Owner password the document
  PDF_USER = 'U'; // User password of the Document
  PDF_PER = 'P'; // Permissions set for the document
  PDF_V = 'V';
  PDF_REVISION = 'R'; // A number specifying which revision of the standard security handler
  PDF_STANDARD = 'Standard';

  //Catalog
  PDF_CATALOG = 'Catalog';
  PDF_PAGES = 'Pages';
  PDF_LABELS = 'PageLabels';
  PDF_OUTLINES = 'Outlines';
  PDF_PAGELAYOUT = 'PageLayout';
  PDF_PAGEMODE = 'PageMode';
  PDF_VIEWERPREFERENCE = 'ViewerPreferences';
  PDF_ACROFORM = 'AcroForm';
  PDF_XFA = 'XFA';
  PDF_FIELDS = 'Fields';
  PDF_WC = 'WC';
  PDF_WS = 'WS';
  PDF_DS = 'DS';
  PDF_WP = 'WP';
  PDF_DP = 'DP';
  PDF_NEEDAPPEARANCES = 'NeedAppearances';

  //PageLayout
  PDF_SINGLEPAGE = 'SinglePage';
  PDF_ONECOLUMN = 'OneColumn';
  PDF_TWOCOLOMNLEFT = 'TwoColumnLeft';
  PDF_TWOCOLOMNRIGHT = 'TwoColumnRight';
  PDF_TWOPAGELEFT = 'TwoPageLeft';
  PDF_TWOPAGERIGHT = 'TwoPageRight';

  //PageMode
  PDF_USENONE = 'UseNone';
  PDF_USEOUTLINES = 'UseOutlines';
  PDF_USETHUMB = 'UseThumb';
  PDF_FULLSCREEN = 'FullScreen';
  PDF_USEOC = 'UseOC';
  PDF_USEATTACHMENTS = 'UseAttachments';

  //PageLabels
  PDF_PAGELABEL = 'PageLabel';
  PDF_LABELPREFIX = 'P';
  PDF_NUMERICPORTION = 'St';
  PDF_LABELSTYLE = 'S';

  //Pages
  PDF_PAGE = 'Page';
  PDF_LASTMODIFIED = 'LastModified';
  PDF_RESOURCES = 'Resources';
  PDF_MEDIABOX = 'MediaBox';
  PDF_CROPBOX = 'CropBox';
  PDF_BLEEDBOX = 'BleedBox';
  PDF_TRIMBOX = 'TrimBox';
  PDF_ARTBOX = 'ArtBox';
  PDF_BOXCOLORINFO = 'BoxColorInfo';
  PDF_CONTENTS = 'Contents';
  PDF_ROTATE = 'Rotate';
  PDF_GROUP = 'Group';
  PDF_THUMB = 'Thumb';
  PDF_B = 'B';
  PDF_DUR = 'Dur';
  PDF_TRANS = 'Trans';
  PDF_ANNOTS = 'Annots';
  PDF_AA = 'AA';
  PDF_METADATA = 'Metadata';
  PDF_PIECEINFO = 'PieceInfo';
  PDF_STRUCTPARENTS = 'StructParents';
  PDF_ID = 'ID';
  PDF_PZ = 'PZ';
  PDF_SEPRATIONINFO = 'SeparationInfo';
  PDF_TABS = 'Tabs';
  PDF_TEMPLATEINSTANTIATED = 'TemplateInstantiated';
  PDF_PRESSSTEPS = 'PresSteps';
  PDF_USERUNIT = 'UserUnit';
  PDF_VP = 'VP';

  //Page
  PDF_KIDS = 'Kids';

  //Resources
  PDF_FONT = 'Font';
  PDF_PROCSET = 'ProcSet';
  PDF_EXTGSTATE = 'ExtGState';
  PDF_XOBJECT = 'XObject';
  PDF_COLORSPACE = 'ColorSpace';
  PDF_CS = 'CS';

  //Font
  PDF_NAME = 'Name';
  PDF_CIDTYPE0 = 'CIDFontType0';
  PDF_CIDTYPE2 = 'CIDFontType2';
  PDF_CIDTYPE0C = 'CIDFontType0C';
  PDF_OPENTYPE = 'OpenType';
  PDF_TYPE1 = 'Type1';
  PDF_MMTYPE1 = 'MMType1';
  PDF_TYPE1C = 'Type1C';
  PDF_TYPE1COT = 'Type1COT';
  PDF_TYPE3 = 'Type3';
  PDF_TRUETYPE = 'TrueType';
  PDF_TYPE0 = 'Type0';
  PDF_TRUETYPEOT = 'TrueTypeOT';
  PDF_FONTMATRIX = 'FontMatrix';
  PDF_FLAGS = 'Flags';
  PDF_FONTBBOX = 'FontBBox';
  PDF_FONTDESCRIPTOR = 'FontDescriptor';
  PDF_FONTFILE = 'FontFile';
  PDF_FONTFILE2 = 'FontFile2';
  PDF_FONTFILE3 = 'FontFile3';
  PDF_FONTNAME = 'FontName';
  PDF_BASEFONT = 'BaseFont';
  PDF_MISSINGWIDTH = 'MissingWidth';
  PDF_ASCENT = 'Ascent';
  PDF_DESCENT = 'Descent';
  PDF_TOUNICODE = 'ToUnicode';
  PDF_CHARPROCS = 'CharProcs';
  PDF_ENCODING = 'Encoding';
  PDF_BASEENCODING = 'BaseEncoding';
  PDF_MACROMANENCODING = 'MacRomanEncoding';
  PDF_MACEXPERTENCODING = 'MacExpertEncoding';
  PDF_WINANSIENCODING = 'WinAnsiEncoding';
  PDF_STANDARDENCODING = 'StandardEncoding';
  PDF_PDFDOCENCODING = 'PDFDocEncoding';
  PDF_DIFFERENCES = 'Differences';
  PDF_FIRSTCHAR = 'FirstChar';
  PDF_LASTCHAR = 'LastChar';
  PDF_WIDTHS = 'Widths';
  PDF_CAPHEIGHT = 'CapHeight';
  PDF_MAXWIDTH = 'MaxWidth';
  PDF_STEMV = 'StemV';
  PDF_AVGWIDTH = 'AvgWidth';
  PDF_ITALICANGLE = 'ItalicAngle';
  PDF_DESCENDANTFNT = 'DescendantFonts';
  PDF_CIDSYSTEMINFO = 'CIDSystemInfo';
  PDF_REGISTRY = 'Registry';
  PDF_ORDERING = 'Ordering';
  PDF_SUPPLEMENT = 'Supplement';
  PDF_CIDTOGIDMAP = 'CIDToGIDMap';
  PDF_DW = 'DW';
  PDF_DW2 = 'DW2';
  PDF_W2 = 'W2';

//  PDF_W             = 'W';
  PDF_ADOBEIDENTITY = 'Adobe-Identity';
  PDF_ADOBEUCS = 'Adobe-UCS';


  //Doc Info
  PDF_AUTHOR = 'Author';
  PDF_TITLE = 'Title';
  PDF_SUBJECT = 'Subject';
  PDF_KEYWORDS = 'Keywords';
  PDF_CREATOR = 'Creator';
  PDF_PRODUCER = 'Producer';
  PDF_CREATIONDATE = 'CreationDate';
  PDF_MODDATE = 'ModDate';
  PDF_TRAPPED = 'Trapped';

  //Viewer preference
  PDF_VIEWAREA = 'ViewArea';
  PDF_DIRECTION = 'Direction';
  PDF_DUPLEX = 'Duplex';
  PDF_DISPLAYDOCTITLE = 'DisplayDocTitle';
  PDF_CENTERWINDOW = 'CenterWindow';
  PDF_PRINTAREA = 'PrintArea';
  PDF_HIDEWINDOWUI = 'HideWindowUI';
  PDF_VIEWCLIP = 'ViewClip';
  PDF_HIDETOOLBAR = 'HideToolbar';
  PDF_PRINTSCALING = 'PrintScaling';
  PDF_NUMCOPIES = 'NumCopies';
  PDF_PICKTRAYBYPDFSIZE = 'PickTrayByPDFSize';
  PDF_NONFULLSCREENPAGEMODE = 'NonFullScreenPageMode';
  PDF_FITWINDOW = 'FitWindow';
  PDF_PRINTCLIP = 'PrintClip';
  PDF_HIDEMENUBAR = 'HideMenubar';
  PDF_ACPRINTPAGERANGE = 'AcPrintPageRange';

  PDF_LENGTH = 'Length';
  PDF_LENGTH1 = 'Length1';
  PDF_DECODEPARMS = 'DecodeParms';

  CRLF = #13 + #10; // End-of-line (EOL)
  CR = #13; // Carriage Return
  LF = #10; //Line feed
  SP = #32; // Space
  //Annot
  PDF_ANNOT = 'Annot';
  PDF_C = 'C'; // Color
  PDF_SUBTYPE = 'Subtype';
  PDF_TEXT = 'Text';
  PDF_PDF = 'PDF';
  PDF_P = 'P'; // Page
  PDF_M = 'M'; // ModDate
  PDF_F = 'F'; // Flags
  PDF_FILTER = 'Filter';
  PDF_OC = 'OC'; // Optional content membership dictionary
  PDF_RECT = 'Rect'; // Annotation rectangle
  PDF_NM = 'NM'; // The annotation name
  PDF_A = 'A'; // Actions
  PDF_TEXTANNOT = 'Text';
  PDF_LINK = 'Link';
  PDF_FREETEXT = 'FreeText';
  PDF_LINE = 'Line';
  PDF_SQUARE = 'Square';
  PDF_CIRCLE = 'Circle';
  PDF_POLYGON = 'Polygon';
  PDF_POLYlINE = 'PolyLine';
  PDF_HIGHLIGHT = 'Highlight';
  PDF_UNDERLINE = 'Underline';
  PDF_SQUIGGLY = 'Squiggly';
  PDF_STRIKEOUT = 'StrikeOut';
  PDF_STAMP = 'Stamp';
  PDF_CARET = 'Caret';
  PDF_INK = 'Ink';
  PDF_POPUP = 'Popup';
  PDF_FILEATTACHMENT = 'FileAttachment';
  PDF_SOUND = 'Sound';
  PDF_MOVIE = 'Movie';
  PDF_WIDGET = 'Widget';
  PDF_SCREEN = 'Screen';
  PDF_PRINTERMARK = 'PrinterMark';
  PDF_TRAPNET = 'TrapNet';
  PDF_WATERMARK = 'Watermark';
  PDF_3D = '3D';
  PDF_IMAGE = 'Image';
  PDF_FORM = 'Form';
  PDF_PS = 'Ps';
  PDF_LEVEL1 = 'Level1';
  PDF_BE = 'BE';
  PDF_LINEANNOT = 'Line';
  PDF_BORDER = 'Border';
  PDF_AS = 'AS';
  // LineAnnot
  PDF_L = 'L'; // Array of Coordinates
  PDF_LL = 'LL'; // LeaderLines
  PDF_LE = 'LE'; // Line Ending Style
  PDF_DIAMOND = 'Diamond';
  PDF_OPENARROW = 'OpenArrow';
  PDF_CLOSEDARROW = 'ClosedArrow';
  PDF_NONE = 'None';
  PDF_BUTT = 'Butt';
  PDF_ROPENARROW = 'ROpenArrow';
  PDF_RCLOSEDARROW = 'RClosedArrow';
  PDF_SLASH = 'Slash';
  PDF_IC = 'IC'; // Interior Color
  PDF_FS = 'FS';
  PDF_URL = 'URL';

  // Caret Annotation
  PDF_SY = 'Sy';

  //Polygon Annotation
  PDF_VERTICES = 'Vertices';

  // Link Annotation
  PDF_PA = 'PA';

  //Markup Annotation

  PDF_QUADPOINTS = 'QuadPoints';

  // Ink Annotation
  PDF_INKLIST = 'InkList';

  //File Attachment Annot

  PDF_GRAPH = 'Graph';
  PDF_PUSHPIN = 'PushPin';
  PDF_PAPERCLIP = 'PaperClip';
  PDF_TAG = 'Tag';
  PDF_SUBJ = 'Subj';
  PDF_FILESPEC = 'Filespec';
  PDF_UF = 'UF';
  PDF_PARAMS = 'Params';

  //Action
  PDF_ACTION = 'Action';
  PDF_S = 'S'; // Type of action
  PDF_NEXT = 'Next'; // Next action in the dictionary
  PDF_D = 'D'; // Destination
  PDF_GOTO = 'GoTo';
  PDF_GOTOR = 'GoToR';
  PDF_GOTOE = 'GoToE';
  PDF_LAUNCH = 'Launch';
  PDF_THREAD = 'Thread';
  PDF_URI = 'URI';
  PDF_SOUNDACTION = 'Sound';
  PDF_MOVIEACTION = 'Movie';
  PDF_HIDE = 'Hide';
  PDF_NAMED = 'Named';
  PDF_SUBMITFORM = 'SubmitForm';
  PDF_RESETFORM = 'ResetForm';
  PDF_IMPORTDATA = 'ImportData';
  PDF_JAVASCRIPT = 'JavaScript';
  PDF_SETOCGSTATE = 'SetOCGState';
  PDF_RENDITION = 'Rendition';
  PDF_TRANSACTION = 'Trans';
  PDF_GOTO3DVIEW = 'GoTo3DView';
  PDF_NEWWINDOW = 'NewWindow';
  PDF_WIN = 'Win';
  PDF_O = 'O';
  PDF_ISMAP = 'IsMap';
  PDF_JS = 'JS';
  PDF_OPENACTION = 'OpenAction';
  PDF_PRINT     = 'print';

  //Mouse-related trigger events
  PDF_E = 'E'; //OnEnter
  PDF_X = 'X'; //OnExit
//  PDF_U           = 'U';//Mouse Up
//  PDF_D           = 'D';//Mouse Down
  PDF_FO = 'Fo'; //Got Focus
  PDF_BL = 'Bl'; //Lost Focus

  PDF_K = 'K'; //on Key Press
  //PDF_F           = 'F';//Before formatting
  //PDF_V           = 'V';//validate
  //PDF_C           = 'C';//Calculate

  //ColorSpace
  PDF_ICCBASED = 'ICCBased';
  PDF_ALTERNATE = 'Alternate';
  PDF_DEVICERGB = 'DeviceRGB';
  PDF_RGB = 'RGB';
  PDF_SEPARATION = 'Separation';
  PDF_DEVICECMYK = 'DeviceCMYK';
  PDF_CMYK = 'CMYK';
  PDF_DEVICEGRAY = 'DeviceGray';
  PDF_G = 'G';
  PDF_CALGRAY = 'CalGray';
  PDF_CALRGB = 'CalRGB';
  PDF_N = 'N';
  PDF_RANGE = 'Range';
  PDF_WHITEPOINT = 'WhitePoint';
  PDF_BLACKPOINT = 'BlackPoint';
  PDF_GAMMA = 'Gamma';
  PDF_MATRIX = 'Matrix';

  PDF_PATTERN = 'Pattern';
  PDF_LAB = 'Lab';
  PDF_INDEXED = 'Indexed';
  PDF_DEVICEN = 'DeviceN';
  PDF_BLACK = 'Black';
  PDF_CYAN = 'Cyan';
  PDF_MAGENTA = 'Magenta';
  PDF_YELLOW = 'Yellow';



  //Outline
  PDF_FIRST = 'First';
  PDF_LAST = 'Last';
  PDF_DEST = 'Dest';
  PDF_XYZ = 'XYZ';
  PDF_FIT = 'Fit';
  PDF_FITH = 'FitH';
  PDF_FITV = 'FitV';
  PDF_FITR = 'FitR';
  PDF_FITB = 'FitB';
  PDF_FITBH = 'FitBH';
  PDF_FITBV = 'FitBV';

  //GraphicState
  PDF_BM = 'BM';
  PDF_SMALLCA = 'ca';
  PDF_CA = 'CA';
  PDF_SMALLOP = 'op';
  PDF_OP = 'OP';
  PDF_SA = 'SA';
  PDF_TR = 'TR';
  PDF_TR2 = 'TR2';
  PDF_SMASK = 'SMask';
  PDF_GSTATES = 'S';

  PDF_RG = 'rg';
  PDF_TF = 'Tf';

  //annotText
  PDF_OPEN = 'Open';
  PDF_STATE = 'State';
  PDF_STATEMODEL = 'StateModel';

  // annot Free Text
  PDF_FREETEXTCALLOUT = 'FreeTextCallout';
  PDF_FREETEXTTYPEWRITER = 'FreeTextTypeWriter';
  PDF_IT = 'IT';
  PDF_LEFT = 'left';
  PDF_RIGHT = 'right';
  PDF_CENTER = 'center';

  //Image
  PDF_WIDTH = 'Width';
  PDF_W = 'W';
  PDF_HEIGHT = 'Height';
  PDF_H = 'H';
  PDF_BITSPERCOMP = 'BitsPerComponent';
  PDF_BPC = 'BPC';
  PDF_IMAGEMASK = 'ImageMask';
  PDF_IM = 'IM';
  PDF_DECODE = 'Decode';
  PDF_MASK = 'Mask';

  //Function
  PDF_IDENTITY = 'Identity';
  PDF_FUNCTIONTYPE = 'FunctionType';
  PDF_DOMAIN = 'Domain';
  PDF_BITSPERSAMPLE = 'BitsPerSample';
  PDF_ENCODE = 'Encode';
  PDF_C0 = 'C0';
  PDF_C1 = 'C1';
  PDF_FUNCTIONS = 'Functions';
  PDF_BOUNDS = 'Bounds';

  //FormField
  PDF_FT = 'FT';
  PDF_BTN = 'Btn';
  PDF_TX = 'Tx';
  PDF_CH = 'Ch';
  PDF_SIG = 'Sig';
  PDF_FF = 'Ff';
  PDF_DV = 'DV';
  PDF_AP = 'AP';
  PDF_T = 'T';
  PDF_BS = 'BS';
  PDF_BC = 'BC';
  PDF_BG = 'BG';
  PDF_Q = 'Q';
  PDF_TU = 'TU';
  PDF_MK = 'MK';
  PDF_MAXLEN = 'MaxLen';
  PDF_AC = 'AC';
  PDF_RC = 'RC';
  PDF_OPT = 'Opt';
  PDF_DA = 'DA';
  PDF_DR = 'DR';
  PDF_OFF = 'Off';
  PDF_BBOX = 'BBox';

  //CheckBox FormField
  PDF_YES = 'Yes';

  //Signature

  PDF_REASON = 'Reason';
  PDF_LOCATION = 'Location';
  PDF_CONTACT = 'ContactInfo';
  PDF_SUBFILTER = 'SubFilter';
  PDF_RSASHA1 = 'adbe.x509.rsa_sha1';
  PDF_DETACHED = 'adbe.pkcs7.detached';
  PDF_SHA1 = 'adbe.pkcs7.sha1';
  PDF_ADOBEHANDLER = 'Adobe.PPKLite';
  PDF_BYTERANGE = 'ByteRange';
  PDF_GNOSTICETAG = 'Gnostice';
  PDF_ENVELOPELENGTH = 3001;
  PDF_SIGVALUELENGTH = 3500;

  // Border Style
  PDF_U = 'U';
  PDF_I = 'I';

  //File Specifications
  PDF_EF = 'EF';
  PDF_RF = 'RF';
  PDF_DESC = 'Desc';
  PDF_CI = 'CI';

  // Page Transition Effects

  PDF_DISSOLVE = 'Dissolve';
  PDF_GLITTER = 'Glitter';
  PDF_BLINDS = 'Blinds';
  PDF_SPLIT = 'Split';
  PDF_WIPE = 'Wipe';
  PDF_BOX = 'Box';
  PDF_DM = 'Dm';
  PDF_DI = 'Di';

  //Filters
  PDF_DCTDecode = 'DCTDecode';

  //Form XObject
  PDF_FORMTYPE = 'FormType';

  MAXOBJNUM = $FFFFFFFF;
  MAXGENNUM = $FFFFFFFF;

  PDBlankDocTemplate =  '%PDF-1.4' + CRLF +
                        '%‚„œ”' + CRLF +
                        CRLF +
                        '1 0 obj' + CRLF +
                        '<<' + CRLF +
                        '/Type /Catalog' + CRLF +
                        '/Pages 3 0 R' + CRLF +
                        '>>' + CRLF +
                        'endobj' + CRLF +
                        CRLF +
                        '2 0 obj' + CRLF +
                        '<<' + CRLF +
                        '/Producer (                                                  )' + CRLF +
                        '>>' + CRLF +
                        'endobj' + CRLF +
                        CRLF +
                        '3 0 obj' + CRLF +
                        '<<' + CRLF +
                        '/Type /Pages' + CRLF +
                        '/Count 1' + CRLF +
                        '/Kids [ 4 0 R ]' + CRLF +
                        '>>' + CRLF +
                        'endobj' + CRLF +
                        CRLF +
                        '4 0 obj' + CRLF +
                        '<<' + CRLF +
                        '/Contents [ 5 0 R ]' + CRLF +
                        '                         ' + CRLF +
                        '/Type /Page' + CRLF +
                        '/Parent 3 0 R' + CRLF +
                        '>>' + CRLF +
                        'endobj' + CRLF +
                        CRLF +
                        '5 0 obj' + CRLF +
                        '<<' + CRLF +
                        '/Length 3' + CRLF +
                        '>>' + CRLF +
                        'stream' + CRLF +
                        CRLF +
                        CRLF +
                        'endstream' + CRLF +
                        'endobj' + CRLF +
                        'xref' + CRLF +
                        '0 6' + CRLF +
                        '0000000000 65535 f' + CRLF +
                        '0000000017 00000 n' + CRLF +
                        '0000000074 00000 n' + CRLF +
                        '0000000165 00000 n' + CRLF +
                        '0000000233 00000 n' + CRLF +
                        '0000000336 00000 n' + CRLF +
                        'trailer' + CRLF +
                        '<<' + CRLF +
                        '/Size 6' + CRLF +
                        '/Root 1 0 R' + CRLF +
                        '/Info 2 0 R' + CRLF +
                        '>>' + CRLF +
                        'startxref' + CRLF +
                        '398' + CRLF +
                        '%%EOF';

implementation

end.
