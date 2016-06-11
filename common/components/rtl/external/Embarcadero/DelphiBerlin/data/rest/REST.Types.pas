{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
/// <summary>
/// Declares various common types and constants that are used throughout the REST library.
/// </summary>
unit REST.Types;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Math;

type
  TMethod = Procedure of Object;
  TMethod<T> = Procedure(Arg1: T) of Object;

  /// <summary>
  ///   A TCompletionHandler is an anonymous method, that gets called after a asynchronous operation successfully
  ///   completes.
  /// </summary>
  TCompletionHandler = TProc;
  TCompletionHandlerWithError = TProc<TObject>;

type
  /// <summary>
  /// Flags that control the utilization of request-parameters
  /// </summary>
  TRESTRequestParameterOption = (
    /// <summary>
    /// Indicates that the value of this parameter should be used as-is
    /// and not encoded by the component
    /// </summary>
    poDoNotEncode,
    /// <summary>
    ///  A transient parameter is typically created and managed by
    ///  attached components (like an authenticator) at runtime
    /// </summary>
    poTransient,
    /// <summary>
    /// Indicates that a parameter was created by the component
    /// while parsing the base-url or resource
    /// </summary>
    poAutoCreated
  );

  TRESTRequestParameterOptions = set of TRESTRequestParameterOption;

  /// <summary>
  /// Types of parameters that can be added to requests
  /// </summary>
  TRESTRequestParameterKind = (
    /// <summary>
    /// Parameter is put into a cookie
    /// </summary>
    pkCOOKIE,
    /// <summary>
    /// Parameter will sent as URL parameter (for GET requests) or as body
    /// parameter (for POST/PUT requests)
    /// </summary>
    pkGETorPOST,
    /// <summary>
    /// <para>
    /// Parameter will used as value for a URL segment. A URL segment can be
    /// defined in a request's resource path: customer/{ID}
    /// </para>
    /// <para>
    /// If a URL Segment parameter with a name of "ID", then its value will be
    /// replaced for {ID} in the example above
    /// </para>
    /// </summary>
    pkURLSEGMENT,
    /// <summary>
    /// Parameter will be put in the request's HTTP header
    /// </summary>
    pkHTTPHEADER,
    /// <summary>
    /// The parameter's value will be used as request body. If more than one
    /// RequestBody parameter exists, the request will use a multi-part body.
    /// </summary>
    pkREQUESTBODY

    /// File-Params not yet implemented
    /// pkFILE
    );

var
  DefaultRESTRequestParameterKind: TRESTRequestParameterKind = TRESTRequestParameterKind.pkGETorPOST;

function RESTRequestParameterKindToString(const AKind: TRESTRequestParameterKind): string;
function RESTRequestParameterKindFromString(const AKindString: string): TRESTRequestParameterKind;

type
  /// <summary>
  /// Content
  /// </summary>
  TRESTContentType = (ctNone, ctAPPLICATION_ATOM_XML, ctAPPLICATION_ECMASCRIPT, ctAPPLICATION_EDI_X12,
    ctAPPLICATION_EDIFACT, ctAPPLICATION_JSON, ctAPPLICATION_JAVASCRIPT, ctAPPLICATION_OCTET_STREAM, ctAPPLICATION_OGG,
    ctAPPLICATION_PDF, ctAPPLICATION_POSTSCRIPT, ctAPPLICATION_RDF_XML, ctAPPLICATION_RSS_XML, ctAPPLICATION_SOAP_XML,
    ctAPPLICATION_FONT_WOFF, ctAPPLICATION_XHTML_XML, ctAPPLICATION_XML, ctAPPLICATION_XML_DTD, ctAPPLICATION_XOP_XML,
    ctAPPLICATION_ZIP, ctAPPLICATION_GZIP, ctTEXT_CMD, ctTEXT_CSS, ctTEXT_CSV, ctTEXT_HTML, ctTEXT_JAVASCRIPT,
    ctTEXT_PLAIN, ctTEXT_VCARD, ctTEXT_XML, ctAUDIO_BASIC, ctAUDIO_L24, ctAUDIO_MP4, ctAUDIO_MPEG, ctAUDIO_OGG,
    ctAUDIO_VORBIS, ctAUDIO_VND_RN_REALAUDIO, ctAUDIO_VND_WAVE, ctAUDIO_WEBM, ctIMAGE_GIF, ctIMAGE_JPEG, ctIMAGE_PJPEG,
    ctIMAGE_PNG, ctIMAGE_SVG_XML, ctIMAGE_TIFF, ctMESSAGE_HTTP, ctMESSAGE_IMDN_XML, ctMESSAGE_PARTIAL, ctMESSAGE_RFC822,
    ctMODEL_EXAMPLE, ctMODEL_IGES, ctMODEL_MESH, ctMODEL_VRML, ctMODEL_X3D_BINARY, ctMODEL_X3D_VRML, ctMODEL_X3D_XML,
    ctMULTIPART_MIXED, ctMULTIPART_ALTERNATIVE, ctMULTIPART_RELATED, ctMULTIPART_FORM_DATA, ctMULTIPART_SIGNED,
    ctMULTIPART_ENCRYPTED, ctVIDEO_MPEG, ctVIDEO_MP4, ctVIDEO_OGG, ctVIDEO_QUICKTIME, ctVIDEO_WEBM, ctVIDEO_X_MATROSKA,
    ctVIDEO_X_MS_WMV, ctVIDEO_X_FLV, ctAPPLICATION_VND_OASIS_OPENDOCUMENT_TEXT,
    ctAPPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET, ctAPPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION,
    ctAPPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS, ctAPPLICATION_VND_MS_EXCEL,
    ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET, ctAPPLICATION_VND_MS_POWERPOINT,
    ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION,
    ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT, ctAPPLICATION_VND_MOZILLA_XUL_XML,
    ctAPPLICATION_VND_GOOGLE_EARTH_KML_XML, ctAPPLICATION_VND_GOOGLE_EARTH_KMZ, ctAPPLICATION_VND_DART,
    ctAPPLICATION_VND_ANDROID_PACKAGE_ARCHIVE, ctAPPLICATION_X_DEB, ctAPPLICATION_X_DVI, ctAPPLICATION_X_FONT_TTF,
    ctAPPLICATION_X_JAVASCRIPT, ctAPPLICATION_X_LATEX, ctAPPLICATION_X_MPEGURL, ctAPPLICATION_X_RAR_COMPRESSED,
    ctAPPLICATION_X_SHOCKWAVE_FLASH, ctAPPLICATION_X_STUFFIT, ctAPPLICATION_X_TAR, ctAPPLICATION_X_WWW_FORM_URLENCODED,
    ctAPPLICATION_X_XPINSTALL, ctAUDIO_X_AAC, ctAUDIO_X_CAF, ctIMAGE_X_XCF, ctTEXT_X_GWT_RPC, ctTEXT_X_JQUERY_TMPL,
    ctTEXT_X_MARKDOWN, ctAPPLICATION_X_PKCS12, ctAPPLICATION_X_PKCS7_CERTIFICATES, ctAPPLICATION_X_PKCS7_CERTREQRESP,
    ctAPPLICATION_X_PKCS7_MIME, ctAPPLICATION_X_PKCS7_SIGNATURE);

var
  DefaultRESTContentType: TRESTContentType = TRESTContentType.ctNone;

const
  /// <summary>
  /// HTTP Content-Type (or MIME Types as per RFC 2046) header definitions.
  /// </summary>
  /// <remarks>
  /// <para>
  /// See: http://tools.ietf.org/html/rfc2046
  /// </para>
  /// <para>
  /// Values collected from https://en.wikipedia.org/wiki/MIME_type
  /// </para>
  /// </remarks>

  CONTENTTYPE_NONE = ''; // do not localize
  // Type Application
  CONTENTTYPE_APPLICATION_ATOM_XML = 'application/atom+xml'; // do not localize
  CONTENTTYPE_APPLICATION_ECMASCRIPT = 'application/ecmascript'; // do not localize
  CONTENTTYPE_APPLICATION_EDI_X12 = 'application/EDI-X12'; // do not localize
  CONTENTTYPE_APPLICATION_EDIFACT = 'application/EDIFACT'; // do not localize
  CONTENTTYPE_APPLICATION_JSON = 'application/json'; // do not localize
  CONTENTTYPE_APPLICATION_JAVASCRIPT = 'application/javascript'; // do not localize
  CONTENTTYPE_APPLICATION_OCTET_STREAM = 'application/octet-stream'; // do not localize
  CONTENTTYPE_APPLICATION_OGG = 'application/ogg'; // do not localize
  CONTENTTYPE_APPLICATION_PDF = 'application/pdf'; // do not localize
  CONTENTTYPE_APPLICATION_POSTSCRIPT = 'application/postscript'; // do not localize
  CONTENTTYPE_APPLICATION_RDF_XML = 'application/rdf+xml'; // do not localize
  CONTENTTYPE_APPLICATION_RSS_XML = 'application/rss+xml'; // do not localize
  CONTENTTYPE_APPLICATION_SOAP_XML = 'application/soap+xml'; // do not localize
  CONTENTTYPE_APPLICATION_FONT_WOFF = 'application/font-woff'; // do not localize
  CONTENTTYPE_APPLICATION_XHTML_XML = 'application/xhtml+xml'; // do not localize
  CONTENTTYPE_APPLICATION_XML = 'application/xml'; // do not localize
  CONTENTTYPE_APPLICATION_XML_DTD = 'application/xml-dtd'; // do not localize
  CONTENTTYPE_APPLICATION_XOP_XML = 'application/xop+xml'; // do not localize
  CONTENTTYPE_APPLICATION_ZIP = 'application/zip'; // do not localize
  CONTENTTYPE_APPLICATION_GZIP = 'application/gzip'; // do not localize
  // Type Text
  CONTENTTYPE_TEXT_CMD = 'text/cmd'; // do not localize
  CONTENTTYPE_TEXT_CSS = 'text/css'; // do not localize
  CONTENTTYPE_TEXT_CSV = 'text/csv'; // do not localize
  CONTENTTYPE_TEXT_HTML = 'text/html'; // do not localize
  CONTENTTYPE_TEXT_JAVASCRIPT = 'text/javascript'; // do not localize
  CONTENTTYPE_TEXT_PLAIN = 'text/plain'; // do not localize
  CONTENTTYPE_TEXT_VCARD = 'text/vcard'; // do not localize
  CONTENTTYPE_TEXT_XML = 'text/xml'; // do not localize
  // Type Audio
  CONTENTTYPE_AUDIO_BASIC = 'audio/basic'; // do not localize
  CONTENTTYPE_AUDIO_L24 = 'audio/L24'; // do not localize
  CONTENTTYPE_AUDIO_MP4 = 'audio/mp4'; // do not localize
  CONTENTTYPE_AUDIO_MPEG = 'audio/mpeg'; // do not localize
  CONTENTTYPE_AUDIO_OGG = 'audio/ogg'; // do not localize
  CONTENTTYPE_AUDIO_VORBIS = 'audio/vorbis'; // do not localize
  CONTENTTYPE_AUDIO_VND_RN_REALAUDIO = 'audio/vnd.rn-realaudio'; // do not localize
  CONTENTTYPE_AUDIO_VND_WAVE = 'audio/vnd.wave'; // do not localize
  CONTENTTYPE_AUDIO_WEBM = 'audio/webm'; // do not localize
  // Type Image
  CONTENTTYPE_IMAGE_GIF = 'image/gif'; // do not localize
  CONTENTTYPE_IMAGE_JPEG = 'image/jpeg'; // do not localize
  CONTENTTYPE_IMAGE_PJPEG = 'image/pjpeg'; // do not localize
  CONTENTTYPE_IMAGE_PNG = 'image/png'; // do not localize
  CONTENTTYPE_IMAGE_SVG_XML = 'image/svg+xml'; // do not localize
  CONTENTTYPE_IMAGE_TIFF = 'image/tiff'; // do not localize
  // Type Message
  CONTENTTYPE_MESSAGE_HTTP = 'message/http'; // do not localize
  CONTENTTYPE_MESSAGE_IMDN_XML = 'message/imdn+xml'; // do not localize
  CONTENTTYPE_MESSAGE_PARTIAL = 'message/partial'; // do not localize
  CONTENTTYPE_MESSAGE_RFC822 = 'message/rfc822'; // do not localize
  // Type Model (3D Models)
  CONTENTTYPE_MODEL_EXAMPLE = 'model/example'; // do not localize
  CONTENTTYPE_MODEL_IGES = 'model/iges'; // do not localize
  CONTENTTYPE_MODEL_MESH = 'model/mesh'; // do not localize
  CONTENTTYPE_MODEL_VRML = 'model/vrml'; // do not localize
  CONTENTTYPE_MODEL_X3D_BINARY = 'model/x3d+binary'; // do not localize
  CONTENTTYPE_MODEL_X3D_VRML = 'model/x3d+vrml'; // do not localize
  CONTENTTYPE_MODEL_X3D_XML = 'model/x3d+xml'; // do not localize
  // Type Multipart
  CONTENTTYPE_MULTIPART_MIXED = 'multipart/mixed'; // do not localize
  CONTENTTYPE_MULTIPART_ALTERNATIVE = 'multipart/alternative'; // do not localize
  CONTENTTYPE_MULTIPART_RELATED = 'multipart/related'; // do not localize
  CONTENTTYPE_MULTIPART_FORM_DATA = 'multipart/form-data'; // do not localize
  CONTENTTYPE_MULTIPART_SIGNED = 'multipart/signed'; // do not localize
  CONTENTTYPE_MULTIPART_ENCRYPTED = 'multipart/encrypted'; // do not localize
  // Type Video
  CONTENTTYPE_VIDEO_MPEG = 'video/mpeg'; // do not localize
  CONTENTTYPE_VIDEO_MP4 = 'video/mp4'; // do not localize
  CONTENTTYPE_VIDEO_OGG = 'video/ogg'; // do not localize
  CONTENTTYPE_VIDEO_QUICKTIME = 'video/quicktime'; // do not localize
  CONTENTTYPE_VIDEO_WEBM = 'video/webm'; // do not localize
  CONTENTTYPE_VIDEO_X_MATROSKA = 'video/x-matroska'; // do not localize
  CONTENTTYPE_VIDEO_X_MS_WMV = 'video/x-ms-wmv'; // do not localize
  CONTENTTYPE_VIDEO_X_FLV = 'video/x-flv'; // do not localize
  // Type Application - Vendor Specific
  CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT = 'application/vnd.oasis.opendocument.text'; // do not localize
  CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET = 'application/vnd.oasis.opendocument.spreadsheet';
  // do not localize
  CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION = 'application/vnd.oasis.opendocument.presentation';
  // do not localize
  CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS = 'application/vnd.oasis.opendocument.graphics';
  // do not localize
  CONTENTTYPE_APPLICATION_VND_MS_EXCEL = 'application/vnd.ms-excel'; // do not localize
  CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET =
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'; // do not localize
  CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT = 'application/vnd.ms-powerpoint'; // do not localize
  CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION =
    'application/vnd.openxmlformats-officedocument.presentationml.presentation'; // do not localize
  CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT =
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'; // do not localize
  CONTENTTYPE_APPLICATION_VND_MOZILLA_XUL_XML = 'application/vnd.mozilla.xul+xml'; // do not localize
  CONTENTTYPE_APPLICATION_VND_GOOGLE_EARTH_KML_XML = 'application/vnd.google-earth.kml+xml'; // do not localize
  CONTENTTYPE_APPLICATION_VND_GOOGLE_EARTH_KMZ = 'application/vnd.google-earth.kmz'; // do not localize
  CONTENTTYPE_APPLICATION_VND_DART = 'application/vnd.dart'; // do not localize
  CONTENTTYPE_APPLICATION_VND_ANDROID_PACKAGE_ARCHIVE = 'application/vnd.android.package-archive'; // do not localize
  // Type X (RFC 6648)
  CONTENTTYPE_APPLICATION_X_DEB = 'application/x-deb'; // do not localize
  CONTENTTYPE_APPLICATION_X_DVI = 'application/x-dvi'; // do not localize
  CONTENTTYPE_APPLICATION_X_FONT_TTF = 'application/x-font-ttf'; // do not localize
  CONTENTTYPE_APPLICATION_X_JAVASCRIPT = 'application/x-javascript'; // do not localize
  CONTENTTYPE_APPLICATION_X_LATEX = 'application/x-latex'; // do not localize
  CONTENTTYPE_APPLICATION_X_MPEGURL = 'application/x-mpegURL'; // do not localize
  CONTENTTYPE_APPLICATION_X_RAR_COMPRESSED = 'application/x-rar-compressed'; // do not localize
  CONTENTTYPE_APPLICATION_X_SHOCKWAVE_FLASH = 'application/x-shockwave-flash'; // do not localize
  CONTENTTYPE_APPLICATION_X_STUFFIT = 'application/x-stuffit'; // do not localize
  CONTENTTYPE_APPLICATION_X_TAR = 'application/x-tar'; // do not localize
  CONTENTTYPE_APPLICATION_X_WWW_FORM_URLENCODED = 'application/x-www-form-urlencoded'; // do not localize
  CONTENTTYPE_APPLICATION_X_XPINSTALL = 'application/x-xpinstall'; // do not localize
  CONTENTTYPE_AUDIO_X_AAC = 'audio/x-aac'; // do not localize
  CONTENTTYPE_AUDIO_X_CAF = 'audio/x-caf'; // do not localize
  CONTENTTYPE_IMAGE_X_XCF = 'image/x-xcf'; // do not localize
  CONTENTTYPE_TEXT_X_GWT_RPC = 'text/x-gwt-rpc'; // do not localize
  CONTENTTYPE_TEXT_X_JQUERY_TMPL = 'text/x-jquery-tmpl'; // do not localize
  CONTENTTYPE_TEXT_X_MARKDOWN = 'text/x-markdown'; // do not localize
  // Type PKCS (Cryptography)
  CONTENTTYPE_APPLICATION_X_PKCS12 = 'application/x-pkcs12'; // do not localize
  CONTENTTYPE_APPLICATION_X_PKCS7_CERTIFICATES = 'application/x-pkcs7-certificates'; // do not localize
  CONTENTTYPE_APPLICATION_X_PKCS7_CERTREQRESP = 'application/x-pkcs7-certreqresp'; // do not localize
  CONTENTTYPE_APPLICATION_X_PKCS7_MIME = 'application/x-pkcs7-mime'; // do not localize
  CONTENTTYPE_APPLICATION_X_PKCS7_SIGNATURE = 'application/x-pkcs7-signature'; // do not localize

function ContentTypeToString(AContentType: TRESTContentType): string;
function ContentTypeFromString(const AContentType: string): TRESTContentType;

function IsTextualContentType(AContentType: TRESTContentType) : boolean; overload;
function IsTextualContentType(const AContentType: string) : boolean; overload;

type
  /// <summary>
  /// Structure that holds performance related information that is gathered while executing a request.<br />All
  /// values are in milliseconds.
  /// </summary>
  TExecutionPerformance = record
    FStartTime: Cardinal;
    procedure Start;
    procedure Clear;
    procedure PreProcessingDone;
    procedure ExecutionDone;
    procedure PostProcessingDone;
  public
    /// <summary>
    /// Time from starting the execution until the request is handed over to the the actual http client and sent to
    /// the server. This includes time which is needed to prepare parameter, encode a body and other things.
    /// </summary>
    PreProcessingTime: integer;

    /// <summary>
    /// The time that the request took to be sent to the server and until the response has been received. This does
    /// <i>not</i> include any JSON parsing etc.
    /// </summary>
    ExecutionTime: integer;

    /// <summary>
    /// The time from when the server response has been received until all post processing (including JSON parsing).
    /// Events, observer notification or completion handlers are <i>not</i> taken into account here.
    /// </summary>
    PostProcessingTime: integer;

    /// <summary>
    /// The total execution time, which is the sum of PreProcessingTime, ExecutionTime and PostProcessingTime
    /// </summary>
    function TotalExecutionTime: integer;
  end;

  /// <summary>
  /// Designates standard HTTP/REST Methods. All methods may affect single or
  /// multiple objects/entities.
  /// </summary>
  /// <remarks>
  /// See http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html
  /// </remarks>
  TRESTRequestMethod = (
    /// <summary>
    /// Sends a NEW object/entity to the server.
    /// </summary>
    rmPOST,

    /// <summary>
    /// Updates an already existing object/entity on the server. PUT may also
    /// allow for sending a new entity (depends on the actual server/API
    /// implementation).
    /// </summary>
    rmPUT,

    /// <summary>
    /// Retrieves an object/entity from the server.
    /// </summary>
    rmGET,

    /// <summary>
    /// Deletes an object/entity from the server.
    /// </summary>
    rmDELETE,
      /// <summary>
    /// Patches an object/entity on the server, by only updating the pairs that are sent within that PATCH body.
    /// </summary>
    rmPATCH
    );

  /// <summary>
  /// Exceptions coming from the REST Library have this common ancestor
  /// </summary>
  ERESTException = class(Exception)
  end;

  ERequestError = class(ERESTException)
  private
    FResponseContent: string;
    FStatusCode: Integer;
    FStatusText: string;
  public
    constructor Create(AStatusCode: Integer; const AStatusText: string; const AResponseContent: string); reintroduce;
    property ResponseContent: string read FResponseContent write FResponseContent;
    property StatusCode: Integer read FStatusCode write FStatusCode;
    property StatusText: string read FStatusText write FStatusText;
  end;

var
  DefaultRESTRequestMethod: TRESTRequestMethod = TRESTRequestMethod.rmGET;

function RESTRequestMethodToString(const AMethod: TRESTRequestMethod): string;

implementation

uses REST.Consts;

function IsTextualContentType(const AContentType: string) : boolean;
begin
  result:= IsTextualContentType( ContentTypeFromString(AContentType) );
end;

function IsTextualContentType(AContentType: TRESTContentType) : boolean;
begin
  if (AContentType IN [
    ctTEXT_CMD, ctTEXT_CSS, ctTEXT_CSV, ctTEXT_HTML, ctTEXT_JAVASCRIPT,
    ctTEXT_PLAIN, ctTEXT_XML,
    ctAPPLICATION_ATOM_XML, ctAPPLICATION_JSON, ctAPPLICATION_JAVASCRIPT,
    ctAPPLICATION_RDF_XML, ctAPPLICATION_RSS_XML, ctAPPLICATION_SOAP_XML,
    ctAPPLICATION_XHTML_XML, ctAPPLICATION_XML, ctAPPLICATION_XML_DTD
  ]) then
    result:= TRUE
  else
    result:= FALSE;
end;

function RESTRequestParameterKindToString(const AKind: TRESTRequestParameterKind): string;
begin
  case AKind of
    TRESTRequestParameterKind.pkCOOKIE:
      result := 'COOKIE';
    TRESTRequestParameterKind.pkGETorPOST:
      result := 'GET/POST';
    TRESTRequestParameterKind.pkURLSEGMENT:
      result := 'URL-SEGMENT';
    TRESTRequestParameterKind.pkHTTPHEADER:
      result := 'HEADER';
    TRESTRequestParameterKind.pkREQUESTBODY:
      result := 'BODY';
  else
    result := Format('RESTRequestParameterKindToString - unknown Kind: %d', [integer(AKind)]);
  end;
end;

function RESTRequestParameterKindFromString(const AKindString: string): TRESTRequestParameterKind;
var
  LKind: TRESTRequestParameterKind;
begin
  result := DefaultRESTRequestParameterKind;

  for LKind in [low(TRESTRequestParameterKind) .. high(TRESTRequestParameterKind)] do
    if (SameText(AKindString, RESTRequestParameterKindToString(LKind))) then
    begin
      result := LKind;
      BREAK;
    end;
end;

function RESTRequestMethodToString(const AMethod: TRESTRequestMethod): string;
begin
  case AMethod of
    TRESTRequestMethod.rmPOST:
      result := 'POST';
    TRESTRequestMethod.rmPUT:
      result := 'PUT';
    TRESTRequestMethod.rmGET:
      result := 'GET';
    TRESTRequestMethod.rmDELETE:
      result := 'DELETE';
    TRESTRequestMethod.rmPATCH:
      result := 'PATCH'
  else
    result := Format('RESTRequestMethod2String - unknown Method: %d', [integer(AMethod)]);
  end;
end;

function ContentTypeFromString(const AContentType: string): TRESTContentType;
var
  LContentType: string;
begin
  LContentType := AContentType.ToLower.Trim;

  if LContentType = CONTENTTYPE_APPLICATION_ATOM_XML then
    result := ctAPPLICATION_ATOM_XML
  else if LContentType = CONTENTTYPE_APPLICATION_ECMASCRIPT then
    result := ctAPPLICATION_ECMASCRIPT
  else if LContentType = CONTENTTYPE_APPLICATION_EDI_X12 then
    result := ctAPPLICATION_EDI_X12
  else if LContentType = CONTENTTYPE_APPLICATION_EDIFACT then
    result := ctAPPLICATION_EDIFACT
  else if LContentType = CONTENTTYPE_APPLICATION_JSON then
    result := ctAPPLICATION_JSON
  else if LContentType = CONTENTTYPE_APPLICATION_JAVASCRIPT then
    result := ctAPPLICATION_JAVASCRIPT
  else if LContentType = CONTENTTYPE_APPLICATION_OCTET_STREAM then
    result := ctAPPLICATION_OCTET_STREAM
  else if LContentType = CONTENTTYPE_APPLICATION_OGG then
    result := ctAPPLICATION_OGG
  else if LContentType = CONTENTTYPE_APPLICATION_PDF then
    result := ctAPPLICATION_PDF
  else if LContentType = CONTENTTYPE_APPLICATION_POSTSCRIPT then
    result := ctAPPLICATION_POSTSCRIPT
  else if LContentType = CONTENTTYPE_APPLICATION_RDF_XML then
    result := ctAPPLICATION_RDF_XML
  else if LContentType = CONTENTTYPE_APPLICATION_RSS_XML then
    result := ctAPPLICATION_RSS_XML
  else if LContentType = CONTENTTYPE_APPLICATION_SOAP_XML then
    result := ctAPPLICATION_SOAP_XML
  else if LContentType = CONTENTTYPE_APPLICATION_FONT_WOFF then
    result := ctAPPLICATION_FONT_WOFF
  else if LContentType = CONTENTTYPE_APPLICATION_XHTML_XML then
    result := ctAPPLICATION_XHTML_XML
  else if LContentType = CONTENTTYPE_APPLICATION_XML then
    result := ctAPPLICATION_XML
  else if LContentType = CONTENTTYPE_APPLICATION_XML_DTD then
    result := ctAPPLICATION_XML_DTD
  else if LContentType = CONTENTTYPE_APPLICATION_XOP_XML then
    result := ctAPPLICATION_XOP_XML
  else if LContentType = CONTENTTYPE_APPLICATION_ZIP then
    result := ctAPPLICATION_ZIP
  else if LContentType = CONTENTTYPE_APPLICATION_GZIP then
    result := ctAPPLICATION_GZIP
  else if LContentType = CONTENTTYPE_TEXT_CMD then
    result := ctTEXT_CMD
  else if LContentType = CONTENTTYPE_TEXT_CSS then
    result := ctTEXT_CSS
  else if LContentType = CONTENTTYPE_TEXT_CSV then
    result := ctTEXT_CSV
  else if LContentType = CONTENTTYPE_TEXT_HTML then
    result := ctTEXT_HTML
  else if LContentType = CONTENTTYPE_TEXT_JAVASCRIPT then
    result := ctTEXT_JAVASCRIPT
  else if LContentType = CONTENTTYPE_TEXT_PLAIN then
    result := ctTEXT_PLAIN
  else if LContentType = CONTENTTYPE_TEXT_VCARD then
    result := ctTEXT_VCARD
  else if LContentType = CONTENTTYPE_TEXT_XML then
    result := ctTEXT_XML
  else if LContentType = CONTENTTYPE_AUDIO_BASIC then
    result := ctAUDIO_BASIC
  else if LContentType = CONTENTTYPE_AUDIO_L24 then
    result := ctAUDIO_L24
  else if LContentType = CONTENTTYPE_AUDIO_MP4 then
    result := ctAUDIO_MP4
  else if LContentType = CONTENTTYPE_AUDIO_MPEG then
    result := ctAUDIO_MPEG
  else if LContentType = CONTENTTYPE_AUDIO_OGG then
    result := ctAUDIO_OGG
  else if LContentType = CONTENTTYPE_AUDIO_VORBIS then
    result := ctAUDIO_VORBIS
  else if LContentType = CONTENTTYPE_AUDIO_VND_RN_REALAUDIO then
    result := ctAUDIO_VND_RN_REALAUDIO
  else if LContentType = CONTENTTYPE_AUDIO_VND_WAVE then
    result := ctAUDIO_VND_WAVE
  else if LContentType = CONTENTTYPE_AUDIO_WEBM then
    result := ctAUDIO_WEBM
  else if LContentType = CONTENTTYPE_IMAGE_GIF then
    result := ctIMAGE_GIF
  else if LContentType = CONTENTTYPE_IMAGE_JPEG then
    result := ctIMAGE_JPEG
  else if LContentType = CONTENTTYPE_IMAGE_PJPEG then
    result := ctIMAGE_PJPEG
  else if LContentType = CONTENTTYPE_IMAGE_PNG then
    result := ctIMAGE_PNG
  else if LContentType = CONTENTTYPE_IMAGE_SVG_XML then
    result := ctIMAGE_SVG_XML
  else if LContentType = CONTENTTYPE_IMAGE_TIFF then
    result := ctIMAGE_TIFF
  else if LContentType = CONTENTTYPE_MESSAGE_HTTP then
    result := ctMESSAGE_HTTP
  else if LContentType = CONTENTTYPE_MESSAGE_IMDN_XML then
    result := ctMESSAGE_IMDN_XML
  else if LContentType = CONTENTTYPE_MESSAGE_PARTIAL then
    result := ctMESSAGE_PARTIAL
  else if LContentType = CONTENTTYPE_MESSAGE_RFC822 then
    result := ctMESSAGE_RFC822
  else if LContentType = CONTENTTYPE_MODEL_EXAMPLE then
    result := ctMODEL_EXAMPLE
  else if LContentType = CONTENTTYPE_MODEL_IGES then
    result := ctMODEL_IGES
  else if LContentType = CONTENTTYPE_MODEL_MESH then
    result := ctMODEL_MESH
  else if LContentType = CONTENTTYPE_MODEL_VRML then
    result := ctMODEL_VRML
  else if LContentType = CONTENTTYPE_MODEL_X3D_BINARY then
    result := ctMODEL_X3D_BINARY
  else if LContentType = CONTENTTYPE_MODEL_X3D_VRML then
    result := ctMODEL_X3D_VRML
  else if LContentType = CONTENTTYPE_MODEL_X3D_XML then
    result := ctMODEL_X3D_XML
  else if LContentType = CONTENTTYPE_MULTIPART_MIXED then
    result := ctMULTIPART_MIXED
  else if LContentType = CONTENTTYPE_MULTIPART_ALTERNATIVE then
    result := ctMULTIPART_ALTERNATIVE
  else if LContentType = CONTENTTYPE_MULTIPART_RELATED then
    result := ctMULTIPART_RELATED
  else if LContentType = CONTENTTYPE_MULTIPART_FORM_DATA then
    result := ctMULTIPART_FORM_DATA
  else if LContentType = CONTENTTYPE_MULTIPART_SIGNED then
    result := ctMULTIPART_SIGNED
  else if LContentType = CONTENTTYPE_MULTIPART_ENCRYPTED then
    result := ctMULTIPART_ENCRYPTED
  else if LContentType = CONTENTTYPE_VIDEO_MPEG then
    result := ctVIDEO_MPEG
  else if LContentType = CONTENTTYPE_VIDEO_MP4 then
    result := ctVIDEO_MP4
  else if LContentType = CONTENTTYPE_VIDEO_OGG then
    result := ctVIDEO_OGG
  else if LContentType = CONTENTTYPE_VIDEO_QUICKTIME then
    result := ctVIDEO_QUICKTIME
  else if LContentType = CONTENTTYPE_VIDEO_WEBM then
    result := ctVIDEO_WEBM
  else if LContentType = CONTENTTYPE_VIDEO_X_MATROSKA then
    result := ctVIDEO_X_MATROSKA
  else if LContentType = CONTENTTYPE_VIDEO_X_MS_WMV then
    result := ctVIDEO_X_MS_WMV
  else if LContentType = CONTENTTYPE_VIDEO_X_FLV then
    result := ctVIDEO_X_FLV
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT then
    result := ctAPPLICATION_VND_OASIS_OPENDOCUMENT_TEXT
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET then
    result := ctAPPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION then
    result := ctAPPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS then
    result := ctAPPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS
  else if LContentType = CONTENTTYPE_APPLICATION_VND_MS_EXCEL then
    result := ctAPPLICATION_VND_MS_EXCEL
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET then
    result := ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET
  else if LContentType = CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT then
    result := ctAPPLICATION_VND_MS_POWERPOINT
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION then
    result := ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION
  else if LContentType = CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT then
    result := ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT
  else if LContentType = CONTENTTYPE_APPLICATION_VND_MOZILLA_XUL_XML then
    result := ctAPPLICATION_VND_MOZILLA_XUL_XML
  else if LContentType = CONTENTTYPE_APPLICATION_VND_GOOGLE_EARTH_KML_XML then
    result := ctAPPLICATION_VND_GOOGLE_EARTH_KML_XML
  else if LContentType = CONTENTTYPE_APPLICATION_VND_GOOGLE_EARTH_KMZ then
    result := ctAPPLICATION_VND_GOOGLE_EARTH_KMZ
  else if LContentType = CONTENTTYPE_APPLICATION_VND_DART then
    result := ctAPPLICATION_VND_DART
  else if LContentType = CONTENTTYPE_APPLICATION_VND_ANDROID_PACKAGE_ARCHIVE then
    result := ctAPPLICATION_VND_ANDROID_PACKAGE_ARCHIVE
  else if LContentType = CONTENTTYPE_APPLICATION_X_DEB then
    result := ctAPPLICATION_X_DEB
  else if LContentType = CONTENTTYPE_APPLICATION_X_DVI then
    result := ctAPPLICATION_X_DVI
  else if LContentType = CONTENTTYPE_APPLICATION_X_FONT_TTF then
    result := ctAPPLICATION_X_FONT_TTF
  else if LContentType = CONTENTTYPE_APPLICATION_X_JAVASCRIPT then
    result := ctAPPLICATION_X_JAVASCRIPT
  else if LContentType = CONTENTTYPE_APPLICATION_X_LATEX then
    result := ctAPPLICATION_X_LATEX
  else if LContentType = CONTENTTYPE_APPLICATION_X_MPEGURL then
    result := ctAPPLICATION_X_MPEGURL
  else if LContentType = CONTENTTYPE_APPLICATION_X_RAR_COMPRESSED then
    result := ctAPPLICATION_X_RAR_COMPRESSED
  else if LContentType = CONTENTTYPE_APPLICATION_X_SHOCKWAVE_FLASH then
    result := ctAPPLICATION_X_SHOCKWAVE_FLASH
  else if LContentType = CONTENTTYPE_APPLICATION_X_STUFFIT then
    result := ctAPPLICATION_X_STUFFIT
  else if LContentType = CONTENTTYPE_APPLICATION_X_TAR then
    result := ctAPPLICATION_X_TAR
  else if LContentType = CONTENTTYPE_APPLICATION_X_WWW_FORM_URLENCODED then
    result := ctAPPLICATION_X_WWW_FORM_URLENCODED
  else if LContentType = CONTENTTYPE_APPLICATION_X_XPINSTALL then
    result := ctAPPLICATION_X_XPINSTALL
  else if LContentType = CONTENTTYPE_AUDIO_X_AAC then
    result := ctAUDIO_X_AAC
  else if LContentType = CONTENTTYPE_AUDIO_X_CAF then
    result := ctAUDIO_X_CAF
  else if LContentType = CONTENTTYPE_IMAGE_X_XCF then
    result := ctIMAGE_X_XCF
  else if LContentType = CONTENTTYPE_TEXT_X_GWT_RPC then
    result := ctTEXT_X_GWT_RPC
  else if LContentType = CONTENTTYPE_TEXT_X_JQUERY_TMPL then
    result := ctTEXT_X_JQUERY_TMPL
  else if LContentType = CONTENTTYPE_TEXT_X_MARKDOWN then
    result := ctTEXT_X_MARKDOWN
  else if LContentType = CONTENTTYPE_APPLICATION_X_PKCS12 then
    result := ctAPPLICATION_X_PKCS12
  else if LContentType = CONTENTTYPE_APPLICATION_X_PKCS7_CERTIFICATES then
    result := ctAPPLICATION_X_PKCS7_CERTIFICATES
  else if LContentType = CONTENTTYPE_APPLICATION_X_PKCS7_CERTREQRESP then
    result := ctAPPLICATION_X_PKCS7_CERTREQRESP
  else if LContentType = CONTENTTYPE_APPLICATION_X_PKCS7_MIME then
    result := ctAPPLICATION_X_PKCS7_MIME
  else if LContentType = CONTENTTYPE_APPLICATION_X_PKCS7_SIGNATURE then
    result := ctAPPLICATION_X_PKCS7_SIGNATURE
  else
    raise Exception.CreateFmt(sUnknownContentType, [LContentType]);

end;

function ContentTypeToString(AContentType: TRESTContentType): string;
begin
  case AContentType of
    ctAPPLICATION_ATOM_XML:
      result := CONTENTTYPE_APPLICATION_ATOM_XML;
    ctAPPLICATION_ECMASCRIPT:
      result := CONTENTTYPE_APPLICATION_ECMASCRIPT;
    ctAPPLICATION_EDI_X12:
      result := CONTENTTYPE_APPLICATION_EDI_X12;
    ctAPPLICATION_EDIFACT:
      result := CONTENTTYPE_APPLICATION_EDIFACT;
    ctAPPLICATION_JSON:
      result := CONTENTTYPE_APPLICATION_JSON;
    ctAPPLICATION_JAVASCRIPT:
      result := CONTENTTYPE_APPLICATION_JAVASCRIPT;
    ctAPPLICATION_OCTET_STREAM:
      result := CONTENTTYPE_APPLICATION_OCTET_STREAM;
    ctAPPLICATION_OGG:
      result := CONTENTTYPE_APPLICATION_OGG;
    ctAPPLICATION_PDF:
      result := CONTENTTYPE_APPLICATION_PDF;
    ctAPPLICATION_POSTSCRIPT:
      result := CONTENTTYPE_APPLICATION_POSTSCRIPT;
    ctAPPLICATION_RDF_XML:
      result := CONTENTTYPE_APPLICATION_RDF_XML;
    ctAPPLICATION_RSS_XML:
      result := CONTENTTYPE_APPLICATION_RSS_XML;
    ctAPPLICATION_SOAP_XML:
      result := CONTENTTYPE_APPLICATION_SOAP_XML;
    ctAPPLICATION_FONT_WOFF:
      result := CONTENTTYPE_APPLICATION_FONT_WOFF;
    ctAPPLICATION_XHTML_XML:
      result := CONTENTTYPE_APPLICATION_XHTML_XML;
    ctAPPLICATION_XML:
      result := CONTENTTYPE_APPLICATION_XML;
    ctAPPLICATION_XML_DTD:
      result := CONTENTTYPE_APPLICATION_XML_DTD;
    ctAPPLICATION_XOP_XML:
      result := CONTENTTYPE_APPLICATION_XOP_XML;
    ctAPPLICATION_ZIP:
      result := CONTENTTYPE_APPLICATION_ZIP;
    ctAPPLICATION_GZIP:
      result := CONTENTTYPE_APPLICATION_GZIP;
    ctTEXT_CMD:
      result := CONTENTTYPE_TEXT_CMD;
    ctTEXT_CSS:
      result := CONTENTTYPE_TEXT_CSS;
    ctTEXT_CSV:
      result := CONTENTTYPE_TEXT_CSV;
    ctTEXT_HTML:
      result := CONTENTTYPE_TEXT_HTML;
    ctTEXT_JAVASCRIPT:
      result := CONTENTTYPE_TEXT_JAVASCRIPT;
    ctTEXT_PLAIN:
      result := CONTENTTYPE_TEXT_PLAIN;
    ctTEXT_VCARD:
      result := CONTENTTYPE_TEXT_VCARD;
    ctTEXT_XML:
      result := CONTENTTYPE_TEXT_XML;
    ctAUDIO_BASIC:
      result := CONTENTTYPE_AUDIO_BASIC;
    ctAUDIO_L24:
      result := CONTENTTYPE_AUDIO_L24;
    ctAUDIO_MP4:
      result := CONTENTTYPE_AUDIO_MP4;
    ctAUDIO_MPEG:
      result := CONTENTTYPE_AUDIO_MPEG;
    ctAUDIO_OGG:
      result := CONTENTTYPE_AUDIO_OGG;
    ctAUDIO_VORBIS:
      result := CONTENTTYPE_AUDIO_VORBIS;
    ctAUDIO_VND_RN_REALAUDIO:
      result := CONTENTTYPE_AUDIO_VND_RN_REALAUDIO;
    ctAUDIO_VND_WAVE:
      result := CONTENTTYPE_AUDIO_VND_WAVE;
    ctAUDIO_WEBM:
      result := CONTENTTYPE_AUDIO_WEBM;
    ctIMAGE_GIF:
      result := CONTENTTYPE_IMAGE_GIF;
    ctIMAGE_JPEG:
      result := CONTENTTYPE_IMAGE_JPEG;
    ctIMAGE_PJPEG:
      result := CONTENTTYPE_IMAGE_PJPEG;
    ctIMAGE_PNG:
      result := CONTENTTYPE_IMAGE_PNG;
    ctIMAGE_SVG_XML:
      result := CONTENTTYPE_IMAGE_SVG_XML;
    ctIMAGE_TIFF:
      result := CONTENTTYPE_IMAGE_TIFF;
    ctMESSAGE_HTTP:
      result := CONTENTTYPE_MESSAGE_HTTP;
    ctMESSAGE_IMDN_XML:
      result := CONTENTTYPE_MESSAGE_IMDN_XML;
    ctMESSAGE_PARTIAL:
      result := CONTENTTYPE_MESSAGE_PARTIAL;
    ctMESSAGE_RFC822:
      result := CONTENTTYPE_MESSAGE_RFC822;
    ctMODEL_EXAMPLE:
      result := CONTENTTYPE_MODEL_EXAMPLE;
    ctMODEL_IGES:
      result := CONTENTTYPE_MODEL_IGES;
    ctMODEL_MESH:
      result := CONTENTTYPE_MODEL_MESH;
    ctMODEL_VRML:
      result := CONTENTTYPE_MODEL_VRML;
    ctMODEL_X3D_BINARY:
      result := CONTENTTYPE_MODEL_X3D_BINARY;
    ctMODEL_X3D_VRML:
      result := CONTENTTYPE_MODEL_X3D_VRML;
    ctMODEL_X3D_XML:
      result := CONTENTTYPE_MODEL_X3D_XML;
    ctMULTIPART_MIXED:
      result := CONTENTTYPE_MULTIPART_MIXED;
    ctMULTIPART_ALTERNATIVE:
      result := CONTENTTYPE_MULTIPART_ALTERNATIVE;
    ctMULTIPART_RELATED:
      result := CONTENTTYPE_MULTIPART_RELATED;
    ctMULTIPART_FORM_DATA:
      result := CONTENTTYPE_MULTIPART_FORM_DATA;
    ctMULTIPART_SIGNED:
      result := CONTENTTYPE_MULTIPART_SIGNED;
    ctMULTIPART_ENCRYPTED:
      result := CONTENTTYPE_MULTIPART_ENCRYPTED;
    ctVIDEO_MPEG:
      result := CONTENTTYPE_VIDEO_MPEG;
    ctVIDEO_MP4:
      result := CONTENTTYPE_VIDEO_MP4;
    ctVIDEO_OGG:
      result := CONTENTTYPE_VIDEO_OGG;
    ctVIDEO_QUICKTIME:
      result := CONTENTTYPE_VIDEO_QUICKTIME;
    ctVIDEO_WEBM:
      result := CONTENTTYPE_VIDEO_WEBM;
    ctVIDEO_X_MATROSKA:
      result := CONTENTTYPE_VIDEO_X_MATROSKA;
    ctVIDEO_X_MS_WMV:
      result := CONTENTTYPE_VIDEO_X_MS_WMV;
    ctVIDEO_X_FLV:
      result := CONTENTTYPE_VIDEO_X_FLV;
    ctAPPLICATION_VND_OASIS_OPENDOCUMENT_TEXT:
      result := CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT;
    ctAPPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET:
      result := CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET;
    ctAPPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION:
      result := CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION;
    ctAPPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS:
      result := CONTENTTYPE_APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS;
    ctAPPLICATION_VND_MS_EXCEL:
      result := CONTENTTYPE_APPLICATION_VND_MS_EXCEL;
    ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET:
      result := CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET;
    ctAPPLICATION_VND_MS_POWERPOINT:
      result := CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT;
    ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION:
      result := CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION;
    ctAPPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT:
      result := CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT;
    ctAPPLICATION_VND_MOZILLA_XUL_XML:
      result := CONTENTTYPE_APPLICATION_VND_MOZILLA_XUL_XML;
    ctAPPLICATION_VND_GOOGLE_EARTH_KML_XML:
      result := CONTENTTYPE_APPLICATION_VND_GOOGLE_EARTH_KML_XML;
    ctAPPLICATION_VND_GOOGLE_EARTH_KMZ:
      result := CONTENTTYPE_APPLICATION_VND_GOOGLE_EARTH_KMZ;
    ctAPPLICATION_VND_DART:
      result := CONTENTTYPE_APPLICATION_VND_DART;
    ctAPPLICATION_VND_ANDROID_PACKAGE_ARCHIVE:
      result := CONTENTTYPE_APPLICATION_VND_ANDROID_PACKAGE_ARCHIVE;
    ctAPPLICATION_X_DEB:
      result := CONTENTTYPE_APPLICATION_X_DEB;
    ctAPPLICATION_X_DVI:
      result := CONTENTTYPE_APPLICATION_X_DVI;
    ctAPPLICATION_X_FONT_TTF:
      result := CONTENTTYPE_APPLICATION_X_FONT_TTF;
    ctAPPLICATION_X_JAVASCRIPT:
      result := CONTENTTYPE_APPLICATION_X_JAVASCRIPT;
    ctAPPLICATION_X_LATEX:
      result := CONTENTTYPE_APPLICATION_X_LATEX;
    ctAPPLICATION_X_MPEGURL:
      result := CONTENTTYPE_APPLICATION_X_MPEGURL;
    ctAPPLICATION_X_RAR_COMPRESSED:
      result := CONTENTTYPE_APPLICATION_X_RAR_COMPRESSED;
    ctAPPLICATION_X_SHOCKWAVE_FLASH:
      result := CONTENTTYPE_APPLICATION_X_SHOCKWAVE_FLASH;
    ctAPPLICATION_X_STUFFIT:
      result := CONTENTTYPE_APPLICATION_X_STUFFIT;
    ctAPPLICATION_X_TAR:
      result := CONTENTTYPE_APPLICATION_X_TAR;
    ctAPPLICATION_X_WWW_FORM_URLENCODED:
      result := CONTENTTYPE_APPLICATION_X_WWW_FORM_URLENCODED;
    ctAPPLICATION_X_XPINSTALL:
      result := CONTENTTYPE_APPLICATION_X_XPINSTALL;
    ctAUDIO_X_AAC:
      result := CONTENTTYPE_AUDIO_X_AAC;
    ctAUDIO_X_CAF:
      result := CONTENTTYPE_AUDIO_X_CAF;
    ctIMAGE_X_XCF:
      result := CONTENTTYPE_IMAGE_X_XCF;
    ctTEXT_X_GWT_RPC:
      result := CONTENTTYPE_TEXT_X_GWT_RPC;
    ctTEXT_X_JQUERY_TMPL:
      result := CONTENTTYPE_TEXT_X_JQUERY_TMPL;
    ctTEXT_X_MARKDOWN:
      result := CONTENTTYPE_TEXT_X_MARKDOWN;
    ctAPPLICATION_X_PKCS12:
      result := CONTENTTYPE_APPLICATION_X_PKCS12;
    ctAPPLICATION_X_PKCS7_CERTIFICATES:
      result := CONTENTTYPE_APPLICATION_X_PKCS7_CERTIFICATES;
    ctAPPLICATION_X_PKCS7_CERTREQRESP:
      result := CONTENTTYPE_APPLICATION_X_PKCS7_CERTREQRESP;
    ctAPPLICATION_X_PKCS7_MIME:
      result := CONTENTTYPE_APPLICATION_X_PKCS7_MIME;
    ctAPPLICATION_X_PKCS7_SIGNATURE:
      result := CONTENTTYPE_APPLICATION_X_PKCS7_SIGNATURE;
  end;
end;

{ TExecutionPerformance }

procedure TExecutionPerformance.Clear;
begin
  PreProcessingTime := -1;
  ExecutionTime := -1;
  PostProcessingTime := -1;
end;

procedure TExecutionPerformance.ExecutionDone;
begin
  // if Post or Pre are never set, they are at -1
  ExecutionTime := TThread.GetTickCount - FStartTime - Cardinal(max(PreProcessingTime, 0));
  // Cardinal typecast to avoid compiler warnings

end;

procedure TExecutionPerformance.PostProcessingDone;
begin
  PostProcessingTime := TThread.GetTickCount - FStartTime - Cardinal(max(ExecutionTime, 0)) -
    Cardinal(max(PreProcessingTime, 0)); // Cardinal typecast to avoid compiler warnings
end;

procedure TExecutionPerformance.PreProcessingDone;
begin
  PreProcessingTime := TThread.GetTickCount - FStartTime;
end;

procedure TExecutionPerformance.Start;
begin
  Clear;
  FStartTime := TThread.GetTickCount;
end;

function TExecutionPerformance.TotalExecutionTime: integer;
begin
  result := max(PreProcessingTime, 0) + max(ExecutionTime, 0) + max(PostProcessingTime, 0);
end;

{ ERequestError }

constructor ERequestError.Create(AStatusCode: Integer; const
    AStatusText: string; const AResponseContent: string);
begin
  if AResponseContent <> '' then
    inherited Create(AResponseContent)
  else
    inherited Create(AStatusText);

  FResponseContent := AResponseContent;
  FStatusCode := AStatusCode;
  FStatusText := AStatusText;
end;

end.
