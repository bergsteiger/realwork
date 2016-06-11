{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework WebKit
//

unit Macapi.WebKit;

interface

uses
  Macapi.AppKit,
  Macapi.CocoaTypes,
  Macapi.Foundation,
  Macapi.JavaScriptCore,
  Macapi.ObjectiveC;

const
  DOM_INDEX_SIZE_ERR = 1;
  DOM_DOMSTRING_SIZE_ERR = 2;
  DOM_HIERARCHY_REQUEST_ERR = 3;
  DOM_WRONG_DOCUMENT_ERR = 4;
  DOM_INVALID_CHARACTER_ERR = 5;
  DOM_NO_DATA_ALLOWED_ERR = 6;
  DOM_NO_MODIFICATION_ALLOWED_ERR = 7;
  DOM_NOT_FOUND_ERR = 8;
  DOM_NOT_SUPPORTED_ERR = 9;
  DOM_INUSE_ATTRIBUTE_ERR = 10;
  DOM_INVALID_STATE_ERR = 11;
  DOM_SYNTAX_ERR = 12;
  DOM_INVALID_MODIFICATION_ERR = 13;
  DOM_NAMESPACE_ERR = 14;
  DOM_INVALID_ACCESS_ERR = 15;
  DOM_ELEMENT_NODE = 1;
  DOM_ATTRIBUTE_NODE = 2;
  DOM_TEXT_NODE = 3;
  DOM_CDATA_SECTION_NODE = 4;
  DOM_ENTITY_REFERENCE_NODE = 5;
  DOM_ENTITY_NODE = 6;
  DOM_PROCESSING_INSTRUCTION_NODE = 7;
  DOM_COMMENT_NODE = 8;
  DOM_DOCUMENT_NODE = 9;
  DOM_DOCUMENT_TYPE_NODE = 10;
  DOM_DOCUMENT_FRAGMENT_NODE = 11;
  DOM_NOTATION_NODE = 12;
  DOM_DOCUMENT_POSITION_DISCONNECTED = 1;
  DOM_DOCUMENT_POSITION_PRECEDING = 2;
  DOM_DOCUMENT_POSITION_FOLLOWING = 4;
  DOM_DOCUMENT_POSITION_CONTAINS = 8;
  DOM_DOCUMENT_POSITION_CONTAINED_BY = 16;
  DOM_DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 32;
  DOM_ALLOW_KEYBOARD_INPUT = 1;
  DOM_UNKNOWN_RULE = 0;
  DOM_STYLE_RULE = 1;
  DOM_CHARSET_RULE = 2;
  DOM_IMPORT_RULE = 3;
  DOM_MEDIA_RULE = 4;
  DOM_FONT_FACE_RULE = 5;
  DOM_PAGE_RULE = 6;
  DOM_WEBKIT_KEYFRAMES_RULE = 7;
  DOM_WEBKIT_KEYFRAME_RULE = 8;
  DOM_WEBKIT_REGION_RULE = 16;
  DOM_CSS_INHERIT = 0;
  DOM_CSS_PRIMITIVE_VALUE = 1;
  DOM_CSS_VALUE_LIST = 2;
  DOM_CSS_CUSTOM = 3;
  DOM_CSS_UNKNOWN = 0;
  DOM_CSS_NUMBER = 1;
  DOM_CSS_PERCENTAGE = 2;
  DOM_CSS_EMS = 3;
  DOM_CSS_EXS = 4;
  DOM_CSS_PX = 5;
  DOM_CSS_CM = 6;
  DOM_CSS_MM = 7;
  DOM_CSS_IN = 8;
  DOM_CSS_PT = 9;
  DOM_CSS_PC = 10;
  DOM_CSS_DEG = 11;
  DOM_CSS_RAD = 12;
  DOM_CSS_GRAD = 13;
  DOM_CSS_MS = 14;
  DOM_CSS_S = 15;
  DOM_CSS_HZ = 16;
  DOM_CSS_KHZ = 17;
  DOM_CSS_DIMENSION = 18;
  DOM_CSS_STRING = 19;
  DOM_CSS_URI = 20;
  DOM_CSS_IDENT = 21;
  DOM_CSS_ATTR = 22;
  DOM_CSS_COUNTER = 23;
  DOM_CSS_RECT = 24;
  DOM_CSS_RGBCOLOR = 25;
  DOM_CSS_VW = 26;
  DOM_CSS_VH = 27;
  DOM_CSS_VMIN = 28;
  DOM_CSS_VMAX = 29;
  DOM_BAD_BOUNDARYPOINTS_ERR = 1;
  DOM_INVALID_NODE_TYPE_ERR = 2;
  DOM_START_TO_START = 0;
  DOM_START_TO_END = 1;
  DOM_END_TO_END = 2;
  DOM_END_TO_START = 3;
  DOM_NODE_BEFORE = 0;
  DOM_NODE_AFTER = 1;
  DOM_NODE_BEFORE_AND_AFTER = 2;
  DOM_NODE_INSIDE = 3;
  DOM_NONE = 0;
  DOM_CAPTURING_PHASE = 1;
  DOM_AT_TARGET = 2;
  DOM_BUBBLING_PHASE = 3;
  DOM_UNSPECIFIED_EVENT_TYPE_ERR = 0;
  DOM_KEY_LOCATION_STANDARD = 0;
  DOM_KEY_LOCATION_LEFT = 1;
  DOM_KEY_LOCATION_RIGHT = 2;
  DOM_KEY_LOCATION_NUMPAD = 3;
  DOM_MODIFICATION = 1;
  DOM_ADDITION = 2;
  DOM_REMOVAL = 3;
  DOM_HORIZONTAL = 0;
  DOM_VERTICAL = 1;
  DOM_BOTH = 2;
  DOM_DOM_DELTA_PIXEL = 0;
  DOM_DOM_DELTA_LINE = 1;
  DOM_DOM_DELTA_PAGE = 2;
  DOM_FILTER_ACCEPT = 1;
  DOM_FILTER_REJECT = 2;
  DOM_FILTER_SKIP = 3;
  DOM_SHOW_ALL = 4294967295;
  DOM_SHOW_ELEMENT = 1;
  DOM_SHOW_ATTRIBUTE = 2;
  DOM_SHOW_TEXT = 4;
  DOM_SHOW_CDATA_SECTION = 8;
  DOM_SHOW_ENTITY_REFERENCE = 16;
  DOM_SHOW_ENTITY = 32;
  DOM_SHOW_PROCESSING_INSTRUCTION = 64;
  DOM_SHOW_COMMENT = 128;
  DOM_SHOW_DOCUMENT = 256;
  DOM_SHOW_DOCUMENT_TYPE = 512;
  DOM_SHOW_DOCUMENT_FRAGMENT = 1024;
  DOM_SHOW_NOTATION = 2048;
  DOM_INVALID_EXPRESSION_ERR = 51;
  DOM_TYPE_ERR = 52;
  DOM_ANY_TYPE = 0;
  DOM_NUMBER_TYPE = 1;
  DOM_STRING_TYPE = 2;
  DOM_BOOLEAN_TYPE = 3;
  DOM_UNORDERED_NODE_ITERATOR_TYPE = 4;
  DOM_ORDERED_NODE_ITERATOR_TYPE = 5;
  DOM_UNORDERED_NODE_SNAPSHOT_TYPE = 6;
  DOM_ORDERED_NODE_SNAPSHOT_TYPE = 7;
  DOM_ANY_UNORDERED_NODE_TYPE = 8;
  DOM_FIRST_ORDERED_NODE_TYPE = 9;
  WebViewInsertActionTyped = 0;
  WebViewInsertActionPasted = 1;
  WebViewInsertActionDropped = 2;
  WKErrorUnknown = 1;
  WKErrorWebContentProcessTerminated = 2;
  WKErrorWebViewInvalidated = 3;
  WKErrorJavaScriptExceptionOccurred = 4;
  WKNavigationTypeLinkActivated = 0;
  WKNavigationTypeFormSubmitted = 1;
  WKNavigationTypeBackForward = 2;
  WKNavigationTypeReload = 3;
  WKNavigationTypeFormResubmitted = 4;
  WKNavigationTypeOther = -1;
  WKNavigationActionPolicyCancel = 0;
  WKNavigationActionPolicyAllow = 1;
  WKNavigationResponsePolicyCancel = 0;
  WKNavigationResponsePolicyAllow = 1;
  WKUserScriptInjectionTimeAtDocumentStart = 0;
  WKUserScriptInjectionTimeAtDocumentEnd = 1;
  WebKitErrorCannotShowMIMEType = 100;
  WebKitErrorCannotShowURL = 101;
  WebKitErrorFrameLoadInterruptedByPolicyChange = 102;
  WebKitErrorCannotFindPlugIn = 200;
  WebKitErrorCannotLoadPlugIn = 201;
  WebKitErrorJavaUnavailable = 202;
  WebKitErrorBlockedPlugInVersion = 203;
  WebNavigationTypeLinkClicked = 0;
  WebNavigationTypeFormSubmitted = 1;
  WebNavigationTypeBackForward = 2;
  WebNavigationTypeReload = 3;
  WebNavigationTypeFormResubmitted = 4;
  WebNavigationTypeOther = 5;
  WebCacheModelDocumentViewer = 0;
  WebCacheModelDocumentBrowser = 1;
  WebCacheModelPrimaryWebBrowser = 2;
  WebMenuItemTagOpenLinkInNewWindow = 1;
  WebMenuItemTagDownloadLinkToDisk = 2;
  WebMenuItemTagCopyLinkToClipboard = 3;
  WebMenuItemTagOpenImageInNewWindow = 4;
  WebMenuItemTagDownloadImageToDisk = 5;
  WebMenuItemTagCopyImageToClipboard = 6;
  WebMenuItemTagOpenFrameInNewWindow = 7;
  WebMenuItemTagCopy = 8;
  WebMenuItemTagGoBack = 9;
  WebMenuItemTagGoForward = 10;
  WebMenuItemTagStop = 11;
  WebMenuItemTagReload = 12;
  WebMenuItemTagCut = 13;
  WebMenuItemTagPaste = 14;
  WebMenuItemTagSpellingGuess = 15;
  WebMenuItemTagNoGuessesFound = 16;
  WebMenuItemTagIgnoreSpelling = 17;
  WebMenuItemTagLearnSpelling = 18;
  WebMenuItemTagOther = 19;
  WebMenuItemTagSearchInSpotlight = 20;
  WebMenuItemTagSearchWeb = 21;
  WebMenuItemTagLookUpInDictionary = 22;
  WebMenuItemTagOpenWithDefaultApplication = 23;
  WebMenuItemPDFActualSize = 24;
  WebMenuItemPDFZoomIn = 25;
  WebMenuItemPDFZoomOut = 26;
  WebMenuItemPDFAutoSize = 27;
  WebMenuItemPDFSinglePage = 28;
  WebMenuItemPDFFacingPages = 29;
  WebMenuItemPDFContinuous = 30;
  WebMenuItemPDFNextPage = 31;
  WebMenuItemPDFPreviousPage = 32;
  WebDragDestinationActionNone = 0;
  WebDragDestinationActionDHTML = 1;
  WebDragDestinationActionEdit = 2;
  WebDragDestinationActionLoad = 4;
  WebDragDestinationActionAny = 4294967295;
  WebDragSourceActionNone = 0;
  WebDragSourceActionDHTML = 1;
  WebDragSourceActionImage = 2;
  WebDragSourceActionLink = 4;
  WebDragSourceActionSelection = 8;
  WebDragSourceActionAny = 4294967295;

type

  // ===== Forward declarations =====
  {$M+}
  WebScripting = interface;
  WebFrame = interface;
  WebScriptObject = interface;
  WebUndefined = interface;
  DOMStyleSheet = interface;
  DOMObject = interface;
  DOMEvent = interface;
  DOMEventListener = interface;
  DOMEventTarget = interface;
  DOMDocument = interface;
  DOMElement = interface;
  DOMNamedNodeMap = interface;
  DOMNode = interface;
  DOMNodeList = interface;
  DOMCSSStyleDeclaration = interface;
  DOMAttr = interface;
  DOMCharacterData = interface;
  DOMText = interface;
  DOMCDATASection = interface;
  DOMComment = interface;
  DOMAbstractView = interface;
  DOMCSSRuleList = interface;
  DOMDocumentFragment = interface;
  DOMDocumentType = interface;
  DOMEntityReference = interface;
  DOMHTMLCollection = interface;
  DOMHTMLElement = interface;
  DOMImplementation = interface;
  DOMNodeIterator = interface;
  DOMProcessingInstruction = interface;
  DOMRange = interface;
  DOMStyleSheetList = interface;
  DOMTreeWalker = interface;
  DOMXPathExpression = interface;
  DOMXPathResult = interface;
  DOMNodeFilter = interface;
  DOMXPathNSResolver = interface;
  DOMEntity = interface;
  DOMCSSStyleSheet = interface;
  DOMHTMLDocument = interface;
  DOMNotation = interface;
  DOMMediaList = interface;
  DOMCSSRule = interface;
  DOMCSSCharsetRule = interface;
  DOMCSSFontFaceRule = interface;
  DOMCSSImportRule = interface;
  DOMCSSMediaRule = interface;
  DOMCSSPageRule = interface;
  DOMCSSValue = interface;
  DOMCounter = interface;
  DOMRGBColor = interface;
  DOMRect = interface;
  DOMCSSPrimitiveValue = interface;
  DOMCSSStyleRule = interface;
  DOMCSSUnknownRule = interface;
  DOMCSSValueList = interface;
  DOMBlob = interface;
  DOMFile = interface;
  DOMFileList = interface;
  DOMHTMLAnchorElement = interface;
  DOMHTMLAppletElement = interface;
  DOMHTMLAreaElement = interface;
  DOMHTMLBRElement = interface;
  DOMHTMLBaseElement = interface;
  DOMHTMLBaseFontElement = interface;
  DOMHTMLBodyElement = interface;
  DOMHTMLFormElement = interface;
  DOMHTMLButtonElement = interface;
  DOMHTMLDListElement = interface;
  DOMHTMLDirectoryElement = interface;
  DOMHTMLDivElement = interface;
  DOMHTMLEmbedElement = interface;
  DOMHTMLFieldSetElement = interface;
  DOMHTMLFontElement = interface;
  DOMHTMLFrameElement = interface;
  DOMHTMLFrameSetElement = interface;
  DOMHTMLHRElement = interface;
  DOMHTMLHeadElement = interface;
  DOMHTMLHeadingElement = interface;
  DOMHTMLHtmlElement = interface;
  DOMHTMLIFrameElement = interface;
  DOMHTMLImageElement = interface;
  DOMHTMLInputElement = interface;
  DOMHTMLLIElement = interface;
  DOMHTMLLabelElement = interface;
  DOMHTMLLegendElement = interface;
  DOMHTMLLinkElement = interface;
  DOMHTMLMapElement = interface;
  DOMHTMLMarqueeElement = interface;
  DOMHTMLMenuElement = interface;
  DOMHTMLMetaElement = interface;
  DOMHTMLModElement = interface;
  DOMHTMLOListElement = interface;
  DOMHTMLObjectElement = interface;
  DOMHTMLOptGroupElement = interface;
  DOMHTMLOptionElement = interface;
  DOMHTMLOptionsCollection = interface;
  DOMHTMLParagraphElement = interface;
  DOMHTMLParamElement = interface;
  DOMHTMLPreElement = interface;
  DOMHTMLQuoteElement = interface;
  DOMHTMLScriptElement = interface;
  DOMHTMLSelectElement = interface;
  DOMHTMLStyleElement = interface;
  DOMHTMLTableCaptionElement = interface;
  DOMHTMLTableCellElement = interface;
  DOMHTMLTableColElement = interface;
  DOMHTMLTableSectionElement = interface;
  DOMHTMLTableElement = interface;
  DOMHTMLTableRowElement = interface;
  DOMHTMLTextAreaElement = interface;
  DOMHTMLTitleElement = interface;
  DOMHTMLUListElement = interface;
  DOMUIEvent = interface;
  DOMKeyboardEvent = interface;
  DOMMouseEvent = interface;
  DOMMutationEvent = interface;
  DOMOverflowEvent = interface;
  DOMProgressEvent = interface;
  DOMWheelEvent = interface;
  WebResource = interface;
  WebArchive = interface;
  WebHistoryItem = interface;
  WebBackForwardList = interface;
  WebDataSource = interface;
  WebDocumentView = interface;
  WebDocumentSearching = interface;
  WebDocumentText = interface;
  WebDocumentRepresentation = interface;
  WebDownload = interface;
  WebDownloadDelegate = interface;
  WebView = interface;
  WebViewEditingDelegate = interface;
  WebFrameView = interface;
  WebFrameLoadDelegate = interface;
  WebHistory = interface;
  WKBackForwardListItem = interface;
  WKBackForwardList = interface;
  WKFrameInfo = interface;
  WKNavigation = interface;
  WKNavigationAction = interface;
  WKNavigationResponse = interface;
  WKWebView = interface;
  WKNavigationDelegate = interface;
  WKPreferences = interface;
  WKProcessPool = interface;
  WKScriptMessage = interface;
  WKUserContentController = interface;
  WKScriptMessageHandler = interface;
  WKWebViewConfiguration = interface;
  WKWindowFeatures = interface;
  WKUIDelegate = interface;
  WKUserScript = interface;
  WebPlugIn = interface;
  WebPlugInContainer = interface;
  WebPlugInViewFactory = interface;
  WebPolicyDecisionListener = interface;
  WebPolicyDelegate = interface;
  WebPreferences = interface;
  WebResourceLoadDelegate = interface;
  WebOpenPanelResultListener = interface;
  WebUIDelegate = interface;

  // ===== Framework typedefs =====
  {$M+}
  DOMTimeStamp = UInt64;

  DOMObjectInternal = record
  end;
  PDOMObjectInternal = ^DOMObjectInternal;

  WebViewInsertAction = NSInteger;
  WKErrorCode = NSInteger;
  WKNavigationType = NSInteger;
  WKNavigationActionPolicy = NSInteger;
  WKNavigationResponsePolicy = NSInteger;
  TWebKitDecisionHandler = procedure(param1: WKNavigationActionPolicy) of object;
  TWebKitDecisionHandler1 = procedure(param1: WKNavigationResponsePolicy) of object;
  TWebKitCompletionHandler = procedure(param1: NSURLSessionAuthChallengeDisposition; param2: NSURLCredential) of object;
  TWebKitCompletionHandler1 = procedure() of object;
  TWebKitCompletionHandler2 = procedure(param1: Boolean) of object;
  TWebKitCompletionHandler3 = procedure(param1: NSString) of object;
  WKUserScriptInjectionTime = NSInteger;
  TWebKitCompletionHandler4 = procedure(param1: Pointer; param2: NSError) of object;
  WebNavigationType = NSInteger;
  WebCacheModel = NSUInteger;

  WebPreferencesPrivate = record
  end;
  PWebPreferencesPrivate = ^WebPreferencesPrivate;

  WebDragDestinationAction = NSUInteger;
  WebDragSourceAction = NSUInteger;
  // ===== Interface declarations =====

  WebScripting = interface(IObjectiveC)
    ['{011608B2-9619-453F-809C-1EBD57984ED5}']
    function webScriptNameForSelector(selector: SEL): NSString; cdecl;
    function isSelectorExcludedFromWebScript(selector: SEL): Boolean; cdecl;
    function webScriptNameForKey(name: MarshaledAString): NSString; cdecl;
    function isKeyExcludedFromWebScript(name: MarshaledAString): Boolean; cdecl;
    function invokeUndefinedMethodFromWebScript(name: NSString; withArguments: NSArray): Pointer; cdecl;
    function invokeDefaultMethodWithArguments(arguments: NSArray): Pointer; cdecl;
    procedure finalizeForWebScript; cdecl;
  end;

  WebFrameClass = interface(NSObjectClass)
    ['{F3F62E1B-9CE1-4AF9-936B-5D3B1B26E372}']
  end;
  WebFrame = interface(NSObject)
    ['{B254A8BF-8B6A-4476-B2E9-B76B07ADCC6D}']
    function initWithName(name: NSString; WebFrameView: WebFrameView; WebView: WebView): Pointer {instancetype}; cdecl;
    function name: NSString; cdecl;
    function WebView: WebView; cdecl;
    function frameView: WebFrameView; cdecl;
    function DOMDocument: DOMDocument; cdecl;
    function frameElement: DOMHTMLElement; cdecl;
    procedure loadRequest(request: NSURLRequest); cdecl;
    procedure loadData(data: NSData; MIMEType: NSString; textEncodingName: NSString; baseURL: NSURL); cdecl;
    procedure loadHTMLString(&string: NSString; baseURL: NSURL); cdecl;
    procedure loadAlternateHTMLString(&string: NSString; baseURL: NSURL; forUnreachableURL: NSURL); cdecl;
    procedure loadArchive(archive: WebArchive); cdecl;
    function dataSource: WebDataSource; cdecl;
    function provisionalDataSource: WebDataSource; cdecl;
    procedure stopLoading; cdecl;
    procedure reload; cdecl;
    procedure reloadFromOrigin; cdecl;
    function findFrameNamed(name: NSString): WebFrame; cdecl;
    function parentFrame: WebFrame; cdecl;
    function childFrames: NSArray; cdecl;
    function windowObject: WebScriptObject; cdecl;
    function globalContext: JSGlobalContextRef; cdecl;
  end;

  TWebFrame = class(TOCGenericImport<WebFrameClass, WebFrame>)
  end;
  PWebFrame = Pointer;

  WebScriptObjectClass = interface(NSObjectClass)
    ['{99DA0961-DA9D-432A-92FB-1204C00C289D}']
    {class} function throwException(exceptionMessage: NSString): Boolean; cdecl;
  end;
  WebScriptObject = interface(NSObject)
    ['{774DBDBF-B164-4227-AB7E-9EB3EF9B10BD}']
    function JSObject: JSObjectRef; cdecl;
    function callWebScriptMethod(name: NSString; withArguments: NSArray): Pointer; cdecl;
    function evaluateWebScript(script: NSString): Pointer; cdecl;
    procedure removeWebScriptKey(name: NSString); cdecl;
    function stringRepresentation: NSString; cdecl;
    function webScriptValueAtIndex(index: Cardinal): Pointer; cdecl;
    procedure setWebScriptValueAtIndex(index: Cardinal; value: Pointer); cdecl;
    procedure setException(description: NSString); cdecl;
  end;

  TWebScriptObject = class(TOCGenericImport<WebScriptObjectClass, WebScriptObject>)
  end;
  PWebScriptObject = Pointer;

  WebUndefinedClass = interface(NSObjectClass)
    ['{95BFEE24-0BF1-47C0-AE02-5122C3F25725}']
    {class} function undefined: WebUndefined; cdecl;
  end;
  WebUndefined = interface(NSObject)
    ['{BE471A1A-4DB9-40A6-B55A-FBBA67C7ABAF}']
  end;

  TWebUndefined = class(TOCGenericImport<WebUndefinedClass, WebUndefined>)
  end;
  PWebUndefined = Pointer;

  DOMObjectClass = interface(WebScriptObjectClass)
    ['{82550E02-A22E-4C73-A3AE-0B3CF8833586}']
  end;
  DOMObject = interface(WebScriptObject)
    ['{BA18A1B1-6481-4802-B13F-28402C9E4733}']
    function sheet: DOMStyleSheet; cdecl;
  end;

  TDOMObject = class(TOCGenericImport<DOMObjectClass, DOMObject>)
  end;
  PDOMObject = Pointer;

  DOMStyleSheetClass = interface(DOMObjectClass)
    ['{A02E75C9-1E85-4594-9973-062C673151A1}']
  end;
  DOMStyleSheet = interface(DOMObject)
    ['{0879C87B-ADF1-495C-B5AC-8891ED612640}']
    function &type: NSString; cdecl;
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    function ownerNode: DOMNode; cdecl;
    function parentStyleSheet: DOMStyleSheet; cdecl;
    function href: NSString; cdecl;
    function title: NSString; cdecl;
    function media: DOMMediaList; cdecl;
  end;

  TDOMStyleSheet = class(TOCGenericImport<DOMStyleSheetClass, DOMStyleSheet>)
  end;
  PDOMStyleSheet = Pointer;

  DOMEventClass = interface(DOMObjectClass)
    ['{8BD6EBD0-5991-43FF-B7A5-107FAE440C5E}']
  end;
  DOMEvent = interface(DOMObject)
    ['{600CFC95-35CA-426A-8E70-12E592B284B4}']
    function &type: NSString; cdecl;
    function target: Pointer; cdecl;
    function currentTarget: Pointer; cdecl;
    function eventPhase: Word; cdecl;
    function bubbles: Boolean; cdecl;
    function cancelable: Boolean; cdecl;
    function timeStamp: DOMTimeStamp; cdecl;
    function srcElement: Pointer; cdecl;
    procedure setReturnValue(returnValue: Boolean); cdecl;
    function returnValue: Boolean; cdecl;
    procedure setCancelBubble(cancelBubble: Boolean); cdecl;
    function cancelBubble: Boolean; cdecl;
    procedure stopPropagation; cdecl;
    procedure preventDefault; cdecl;
    [MethodName('initEvent:canBubbleArg:cancelableArg:')]
    procedure initEventCanBubbleArgCancelableArg(eventTypeArg: NSString; canBubbleArg: Boolean;
      cancelableArg: Boolean); cdecl;
    [MethodName('initEvent:::')]
    procedure initEvent(eventTypeArg: NSString; canBubbleArg: Boolean; cancelableArg: Boolean); cdecl;
  end;

  TDOMEvent = class(TOCGenericImport<DOMEventClass, DOMEvent>)
  end;
  PDOMEvent = Pointer;

  DOMNodeClass = interface(DOMObjectClass)
    ['{41A7BC5C-678F-45D2-887E-79EF34CC3975}']
  end;
  DOMNode = interface(DOMObject)
    ['{A75FAF2A-85DF-4B53-B944-9F09E9696C89}']
    function nodeName: NSString; cdecl;
    procedure setNodeValue(nodeValue: NSString); cdecl;
    function nodeValue: NSString; cdecl;
    function nodeType: Word; cdecl;
    function parentNode: DOMNode; cdecl;
    function childNodes: DOMNodeList; cdecl;
    function firstChild: DOMNode; cdecl;
    function lastChild: DOMNode; cdecl;
    function previousSibling: DOMNode; cdecl;
    function nextSibling: DOMNode; cdecl;
    function ownerDocument: DOMDocument; cdecl;
    function namespaceURI: NSString; cdecl;
    procedure setPrefix(prefix: NSString); cdecl;
    function prefix: NSString; cdecl;
    function localName: NSString; cdecl;
    function attributes: DOMNamedNodeMap; cdecl;
    function baseURI: NSString; cdecl;
    procedure setTextContent(textContent: NSString); cdecl;
    function textContent: NSString; cdecl;
    function parentElement: DOMElement; cdecl;
    function isContentEditable: Boolean; cdecl;
    [MethodName('insertBefore:refChild:')]
    function insertBeforeRefChild(newChild: DOMNode; refChild: DOMNode): DOMNode; cdecl;
    [MethodName('replaceChild:oldChild:')]
    function replaceChildOldChild(newChild: DOMNode; oldChild: DOMNode): DOMNode; cdecl;
    function removeChild(oldChild: DOMNode): DOMNode; cdecl;
    function appendChild(newChild: DOMNode): DOMNode; cdecl;
    function hasChildNodes: Boolean; cdecl;
    function cloneNode(deep: Boolean): DOMNode; cdecl;
    procedure normalize; cdecl;
    [MethodName('isSupported:version:')]
    function isSupportedVersion(feature: NSString; version: NSString): Boolean; cdecl;
    function hasAttributes: Boolean; cdecl;
    function isSameNode(other: DOMNode): Boolean; cdecl;
    function isEqualNode(other: DOMNode): Boolean; cdecl;
    function lookupPrefix(namespaceURI: NSString): NSString; cdecl;
    function isDefaultNamespace(namespaceURI: NSString): Boolean; cdecl;
    function lookupNamespaceURI(prefix: NSString): NSString; cdecl;
    function compareDocumentPosition(other: DOMNode): Word; cdecl;
    function contains(other: DOMNode): Boolean; cdecl;
    [MethodName('insertBefore::')]
    function insertBefore(newChild: DOMNode; refChild: DOMNode): DOMNode; cdecl;
    [MethodName('replaceChild::')]
    function replaceChild(newChild: DOMNode; oldChild: DOMNode): DOMNode; cdecl;
    [MethodName('isSupported::')]
    function isSupported(feature: NSString; version: NSString): Boolean; cdecl;
    function boundingBox: NSRect; cdecl;
    function lineBoxRects: NSArray; cdecl;
    function WebArchive: WebArchive; cdecl;
  end;

  TDOMNode = class(TOCGenericImport<DOMNodeClass, DOMNode>)
  end;
  PDOMNode = Pointer;

  DOMDocumentClass = interface(DOMNodeClass)
    ['{847AA4BF-72FF-4EF7-9482-B6B77CF8CA12}']
  end;
  DOMDocument = interface(DOMNode)
    ['{6D00AD54-9494-4C91-91E1-A165F9FD2AE1}']
    function doctype: DOMDocumentType; cdecl;
    function &implementation: DOMImplementation; cdecl;
    function documentElement: DOMElement; cdecl;
    function inputEncoding: NSString; cdecl;
    function xmlEncoding: NSString; cdecl;
    procedure setXmlVersion(xmlVersion: NSString); cdecl;
    function xmlVersion: NSString; cdecl;
    procedure setXmlStandalone(xmlStandalone: Boolean); cdecl;
    function xmlStandalone: Boolean; cdecl;
    procedure setDocumentURI(documentURI: NSString); cdecl;
    function documentURI: NSString; cdecl;
    function defaultView: DOMAbstractView; cdecl;
    function styleSheets: DOMStyleSheetList; cdecl;
    procedure setTitle(title: NSString); cdecl;
    function title: NSString; cdecl;
    function referrer: NSString; cdecl;
    function domain: NSString; cdecl;
    function URL: NSString; cdecl;
    procedure setCookie(cookie: NSString); cdecl;
    function cookie: NSString; cdecl;
    procedure setBody(body: DOMHTMLElement); cdecl;
    function body: DOMHTMLElement; cdecl;
    function images: DOMHTMLCollection; cdecl;
    function applets: DOMHTMLCollection; cdecl;
    function links: DOMHTMLCollection; cdecl;
    function forms: DOMHTMLCollection; cdecl;
    function anchors: DOMHTMLCollection; cdecl;
    function lastModified: NSString; cdecl;
    procedure setCharset(charset: NSString); cdecl;
    function charset: NSString; cdecl;
    function defaultCharset: NSString; cdecl;
    function readyState: NSString; cdecl;
    function characterSet: NSString; cdecl;
    function preferredStylesheetSet: NSString; cdecl;
    procedure setSelectedStylesheetSet(selectedStylesheetSet: NSString); cdecl;
    function selectedStylesheetSet: NSString; cdecl;
    function activeElement: DOMElement; cdecl;
    function createElement(tagName: NSString): DOMElement; cdecl;
    function createDocumentFragment: DOMDocumentFragment; cdecl;
    function createTextNode(data: NSString): DOMText; cdecl;
    function createComment(data: NSString): DOMComment; cdecl;
    function createCDATASection(data: NSString): DOMCDATASection; cdecl;
    [MethodName('createProcessingInstruction:data:')]
    function createProcessingInstructionData(target: NSString; data: NSString): DOMProcessingInstruction; cdecl;
    function createAttribute(name: NSString): DOMAttr; cdecl;
    function createEntityReference(name: NSString): DOMEntityReference; cdecl;
    function getElementsByTagName(tagName: NSString): DOMNodeList; cdecl;
    [MethodName('importNode:deep:')]
    function importNodeDeep(importedNode: DOMNode; deep: Boolean): DOMNode; cdecl;
    [MethodName('createElementNS:qualifiedName:')]
    function createElementNSQualifiedName(namespaceURI: NSString; qualifiedName: NSString): DOMElement; cdecl;
    [MethodName('createAttributeNS:qualifiedName:')]
    function createAttributeNSQualifiedName(namespaceURI: NSString; qualifiedName: NSString): DOMAttr; cdecl;
    [MethodName('getElementsByTagNameNS:localName:')]
    function getElementsByTagNameNSLocalName(namespaceURI: NSString; localName: NSString): DOMNodeList; cdecl;
    function getElementById(elementId: NSString): DOMElement; cdecl;
    function adoptNode(source: DOMNode): DOMNode; cdecl;
    function createEvent(eventType: NSString): DOMEvent; cdecl;
    function createRange: DOMRange; cdecl;
    [MethodName('createNodeIterator:whatToShow:filter:expandEntityReferences:')]
    function createNodeIteratorWhatToShowFilterExpandEntityReferences(root: DOMNode; whatToShow: Cardinal;
      filter: Pointer; expandEntityReferences: Boolean): DOMNodeIterator; cdecl;
    [MethodName('createTreeWalker:whatToShow:filter:expandEntityReferences:')]
    function createTreeWalkerWhatToShowFilterExpandEntityReferences(root: DOMNode; whatToShow: Cardinal;
      filter: Pointer; expandEntityReferences: Boolean): DOMTreeWalker; cdecl;
    [MethodName('getOverrideStyle:pseudoElement:')]
    function getOverrideStylePseudoElement(element: DOMElement; pseudoElement: NSString): DOMCSSStyleDeclaration; cdecl;
    [MethodName('createExpression:resolver:')]
    function createExpressionResolver(expression: NSString; resolver: Pointer): DOMXPathExpression; cdecl;
    function createNSResolver(nodeResolver: DOMNode): Pointer; cdecl;
    [MethodName('evaluate:contextNode:resolver:type:inResult:')]
    function evaluateContextNodeResolverTypeInResult(expression: NSString; contextNode: DOMNode; resolver: Pointer;
      &type: Word; inResult: DOMXPathResult): DOMXPathResult; cdecl;
    [MethodName('execCommand:userInterface:value:')]
    function execCommandUserInterfaceValue(command: NSString; userInterface: Boolean; value: NSString): Boolean; cdecl;
    [MethodName('execCommand:userInterface:')]
    function execCommandUserInterface(command: NSString; userInterface: Boolean): Boolean; cdecl;
    [MethodName('execCommand:')]
    function execCommand(command: NSString): Boolean; cdecl;
    function queryCommandEnabled(command: NSString): Boolean; cdecl;
    function queryCommandIndeterm(command: NSString): Boolean; cdecl;
    function queryCommandState(command: NSString): Boolean; cdecl;
    function queryCommandSupported(command: NSString): Boolean; cdecl;
    function queryCommandValue(command: NSString): NSString; cdecl;
    function getElementsByName(elementName: NSString): DOMNodeList; cdecl;
    function elementFromPoint(x: Integer; y: Integer): DOMElement; cdecl;
    function createCSSStyleDeclaration: DOMCSSStyleDeclaration; cdecl;
    [MethodName('getComputedStyle:pseudoElement:')]
    function getComputedStylePseudoElement(element: DOMElement; pseudoElement: NSString): DOMCSSStyleDeclaration; cdecl;
    [MethodName('getMatchedCSSRules:pseudoElement:')]
    function getMatchedCSSRulesPseudoElement(element: DOMElement; pseudoElement: NSString): DOMCSSRuleList; cdecl;
    [MethodName('getMatchedCSSRules:pseudoElement:authorOnly:')]
    function getMatchedCSSRulesPseudoElementAuthorOnly(element: DOMElement; pseudoElement: NSString;
      authorOnly: Boolean): DOMCSSRuleList; cdecl;
    function getElementsByClassName(tagName: NSString): DOMNodeList; cdecl;
    function hasFocus: Boolean; cdecl;
    function querySelector(selectors: NSString): DOMElement; cdecl;
    function querySelectorAll(selectors: NSString): DOMNodeList; cdecl;
    procedure webkitCancelFullScreen; cdecl;
    [MethodName('createProcessingInstruction::')]
    function createProcessingInstruction(target: NSString; data: NSString): DOMProcessingInstruction; cdecl;
    [MethodName('importNode::')]
    function importNode(importedNode: DOMNode; deep: Boolean): DOMNode; cdecl;
    [MethodName('createElementNS::')]
    function createElementNS(namespaceURI: NSString; qualifiedName: NSString): DOMElement; cdecl;
    [MethodName('createAttributeNS::')]
    function createAttributeNS(namespaceURI: NSString; qualifiedName: NSString): DOMAttr; cdecl;
    [MethodName('getElementsByTagNameNS::')]
    function getElementsByTagNameNS(namespaceURI: NSString; localName: NSString): DOMNodeList; cdecl;
    [MethodName('createNodeIterator::::')]
    function createNodeIterator(root: DOMNode; whatToShow: Cardinal; filter: Pointer; expandEntityReferences: Boolean)
      : DOMNodeIterator; cdecl;
    [MethodName('createTreeWalker::::')]
    function createTreeWalker(root: DOMNode; whatToShow: Cardinal; filter: Pointer; expandEntityReferences: Boolean)
      : DOMTreeWalker; cdecl;
    [MethodName('getOverrideStyle::')]
    function getOverrideStyle(element: DOMElement; pseudoElement: NSString): DOMCSSStyleDeclaration; cdecl;
    [MethodName('createExpression::')]
    function createExpression(expression: NSString; resolver: Pointer): DOMXPathExpression; cdecl;
    [MethodName('evaluate:::::')]
    function evaluate(expression: NSString; contextNode: DOMNode; resolver: Pointer; &type: Word;
      inResult: DOMXPathResult): DOMXPathResult; cdecl;
    [MethodName('getComputedStyle::')]
    function getComputedStyle(element: DOMElement; pseudoElement: NSString): DOMCSSStyleDeclaration; cdecl;
    function WebFrame: WebFrame; cdecl;
    function URLWithAttributeString(&string: NSString): NSURL; cdecl;
  end;

  TDOMDocument = class(TOCGenericImport<DOMDocumentClass, DOMDocument>)
  end;
  PDOMDocument = Pointer;

  DOMElementClass = interface(DOMNodeClass)
    ['{11E22BB6-EBE8-445F-85F9-A2397AFE7799}']
  end;
  DOMElement = interface(DOMNode)
    ['{3E05B949-2280-40B3-AF12-B057FE75944C}']
    function tagName: NSString; cdecl;
    function style: DOMCSSStyleDeclaration; cdecl;
    function offsetLeft: Integer; cdecl;
    function offsetTop: Integer; cdecl;
    function offsetWidth: Integer; cdecl;
    function offsetHeight: Integer; cdecl;
    function clientLeft: Integer; cdecl;
    function clientTop: Integer; cdecl;
    function clientWidth: Integer; cdecl;
    function clientHeight: Integer; cdecl;
    procedure setScrollLeft(scrollLeft: Integer); cdecl;
    function scrollLeft: Integer; cdecl;
    procedure setScrollTop(scrollTop: Integer); cdecl;
    function scrollTop: Integer; cdecl;
    function scrollWidth: Integer; cdecl;
    function scrollHeight: Integer; cdecl;
    function offsetParent: DOMElement; cdecl;
    procedure setClassName(className: NSString); cdecl;
    function className: NSString; cdecl;
    function firstElementChild: DOMElement; cdecl;
    function lastElementChild: DOMElement; cdecl;
    function previousElementSibling: DOMElement; cdecl;
    function nextElementSibling: DOMElement; cdecl;
    function childElementCount: Cardinal; cdecl;
    function innerText: NSString; cdecl;
    function getAttribute(name: NSString): NSString; cdecl;
    [MethodName('setAttribute:value:')]
    procedure setAttributeValue(name: NSString; value: NSString); cdecl;
    procedure removeAttribute(name: NSString); cdecl;
    function getAttributeNode(name: NSString): DOMAttr; cdecl;
    function setAttributeNode(newAttr: DOMAttr): DOMAttr; cdecl;
    function removeAttributeNode(oldAttr: DOMAttr): DOMAttr; cdecl;
    function getElementsByTagName(name: NSString): DOMNodeList; cdecl;
    [MethodName('getAttributeNS:localName:')]
    function getAttributeNSLocalName(namespaceURI: NSString; localName: NSString): NSString; cdecl;
    [MethodName('setAttributeNS:qualifiedName:value:')]
    procedure setAttributeNSQualifiedNameValue(namespaceURI: NSString; qualifiedName: NSString; value: NSString); cdecl;
    [MethodName('removeAttributeNS:localName:')]
    procedure removeAttributeNSLocalName(namespaceURI: NSString; localName: NSString); cdecl;
    [MethodName('getElementsByTagNameNS:localName:')]
    function getElementsByTagNameNSLocalName(namespaceURI: NSString; localName: NSString): DOMNodeList; cdecl;
    [MethodName('getAttributeNodeNS:localName:')]
    function getAttributeNodeNSLocalName(namespaceURI: NSString; localName: NSString): DOMAttr; cdecl;
    function setAttributeNodeNS(newAttr: DOMAttr): DOMAttr; cdecl;
    function hasAttribute(name: NSString): Boolean; cdecl;
    [MethodName('hasAttributeNS:localName:')]
    function hasAttributeNSLocalName(namespaceURI: NSString; localName: NSString): Boolean; cdecl;
    procedure focus; cdecl;
    procedure blur; cdecl;
    procedure scrollIntoView(alignWithTop: Boolean); cdecl;
    procedure scrollIntoViewIfNeeded(centerIfNeeded: Boolean); cdecl;
    procedure scrollByLines(lines: Integer); cdecl;
    procedure scrollByPages(pages: Integer); cdecl;
    function getElementsByClassName(name: NSString): DOMNodeList; cdecl;
    function querySelector(selectors: NSString): DOMElement; cdecl;
    function querySelectorAll(selectors: NSString): DOMNodeList; cdecl;
    procedure webkitRequestFullScreen(flags: Word); cdecl;
    [MethodName('setAttribute::')]
    procedure setAttribute(name: NSString; value: NSString); cdecl;
    [MethodName('getAttributeNS::')]
    function getAttributeNS(namespaceURI: NSString; localName: NSString): NSString; cdecl;
    [MethodName('setAttributeNS:::')]
    procedure setAttributeNS(namespaceURI: NSString; qualifiedName: NSString; value: NSString); cdecl;
    [MethodName('removeAttributeNS::')]
    procedure removeAttributeNS(namespaceURI: NSString; localName: NSString); cdecl;
    [MethodName('getElementsByTagNameNS::')]
    function getElementsByTagNameNS(namespaceURI: NSString; localName: NSString): DOMNodeList; cdecl;
    [MethodName('getAttributeNodeNS::')]
    function getAttributeNodeNS(namespaceURI: NSString; localName: NSString): DOMAttr; cdecl;
    [MethodName('hasAttributeNS::')]
    function hasAttributeNS(namespaceURI: NSString; localName: NSString): Boolean; cdecl;
    function image: NSImage; cdecl;
  end;

  TDOMElement = class(TOCGenericImport<DOMElementClass, DOMElement>)
  end;
  PDOMElement = Pointer;

  DOMNamedNodeMapClass = interface(DOMObjectClass)
    ['{9902D3F8-13AC-4491-94D2-4EF49C2BBFFB}']
  end;
  DOMNamedNodeMap = interface(DOMObject)
    ['{F62DC7E6-568E-48C5-8C46-64AF4EEE43FC}']
    function length: Cardinal; cdecl;
    function getNamedItem(name: NSString): DOMNode; cdecl;
    function setNamedItem(node: DOMNode): DOMNode; cdecl;
    function removeNamedItem(name: NSString): DOMNode; cdecl;
    function item(index: Cardinal): DOMNode; cdecl;
    [MethodName('getNamedItemNS:localName:')]
    function getNamedItemNSLocalName(namespaceURI: NSString; localName: NSString): DOMNode; cdecl;
    function setNamedItemNS(node: DOMNode): DOMNode; cdecl;
    [MethodName('removeNamedItemNS:localName:')]
    function removeNamedItemNSLocalName(namespaceURI: NSString; localName: NSString): DOMNode; cdecl;
    [MethodName('getNamedItemNS::')]
    function getNamedItemNS(namespaceURI: NSString; localName: NSString): DOMNode; cdecl;
    [MethodName('removeNamedItemNS::')]
    function removeNamedItemNS(namespaceURI: NSString; localName: NSString): DOMNode; cdecl;
  end;

  TDOMNamedNodeMap = class(TOCGenericImport<DOMNamedNodeMapClass, DOMNamedNodeMap>)
  end;
  PDOMNamedNodeMap = Pointer;

  DOMNodeListClass = interface(DOMObjectClass)
    ['{20088ED7-F22D-4B64-8987-8410C4E2F090}']
  end;
  DOMNodeList = interface(DOMObject)
    ['{71612B28-992F-4B33-9F5D-9F99C2B41CC8}']
    function length: Cardinal; cdecl;
    function item(index: Cardinal): DOMNode; cdecl;
  end;

  TDOMNodeList = class(TOCGenericImport<DOMNodeListClass, DOMNodeList>)
  end;
  PDOMNodeList = Pointer;

  DOMCSSStyleDeclarationClass = interface(DOMObjectClass)
    ['{B301E3D0-CBBB-4B73-8A7D-C4D95FAC84F1}']
  end;
  DOMCSSStyleDeclaration = interface(DOMObject)
    ['{F7A1F3B2-6EEB-4B87-B01B-5F5CB48259C0}']
    procedure setCssText(cssText: NSString); cdecl;
    function cssText: NSString; cdecl;
    function length: Cardinal; cdecl;
    function parentRule: DOMCSSRule; cdecl;
    function getPropertyValue(propertyName: NSString): NSString; cdecl;
    function getPropertyCSSValue(propertyName: NSString): DOMCSSValue; cdecl;
    function removeProperty(propertyName: NSString): NSString; cdecl;
    function getPropertyPriority(propertyName: NSString): NSString; cdecl;
    [MethodName('setProperty:value:priority:')]
    procedure setPropertyValuePriority(propertyName: NSString; value: NSString; priority: NSString); cdecl;
    function item(index: Cardinal): NSString; cdecl;
    function getPropertyShorthand(propertyName: NSString): NSString; cdecl;
    function isPropertyImplicit(propertyName: NSString): Boolean; cdecl;
    [MethodName('setProperty:::')]
    procedure setProperty(propertyName: NSString; value: NSString; priority: NSString); cdecl;
    function azimuth: NSString; cdecl;
    procedure setAzimuth(azimuth: NSString); cdecl;
    function background: NSString; cdecl;
    procedure setBackground(background: NSString); cdecl;
    function backgroundAttachment: NSString; cdecl;
    procedure setBackgroundAttachment(backgroundAttachment: NSString); cdecl;
    function backgroundColor: NSString; cdecl;
    procedure setBackgroundColor(backgroundColor: NSString); cdecl;
    function backgroundImage: NSString; cdecl;
    procedure setBackgroundImage(backgroundImage: NSString); cdecl;
    function backgroundPosition: NSString; cdecl;
    procedure setBackgroundPosition(backgroundPosition: NSString); cdecl;
    function backgroundRepeat: NSString; cdecl;
    procedure setBackgroundRepeat(backgroundRepeat: NSString); cdecl;
    function border: NSString; cdecl;
    procedure setBorder(border: NSString); cdecl;
    function borderCollapse: NSString; cdecl;
    procedure setBorderCollapse(borderCollapse: NSString); cdecl;
    function borderColor: NSString; cdecl;
    procedure setBorderColor(borderColor: NSString); cdecl;
    function borderSpacing: NSString; cdecl;
    procedure setBorderSpacing(borderSpacing: NSString); cdecl;
    function borderStyle: NSString; cdecl;
    procedure setBorderStyle(borderStyle: NSString); cdecl;
    function borderTop: NSString; cdecl;
    procedure setBorderTop(borderTop: NSString); cdecl;
    function borderRight: NSString; cdecl;
    procedure setBorderRight(borderRight: NSString); cdecl;
    function borderBottom: NSString; cdecl;
    procedure setBorderBottom(borderBottom: NSString); cdecl;
    function borderLeft: NSString; cdecl;
    procedure setBorderLeft(borderLeft: NSString); cdecl;
    function borderTopColor: NSString; cdecl;
    procedure setBorderTopColor(borderTopColor: NSString); cdecl;
    function borderRightColor: NSString; cdecl;
    procedure setBorderRightColor(borderRightColor: NSString); cdecl;
    function borderBottomColor: NSString; cdecl;
    procedure setBorderBottomColor(borderBottomColor: NSString); cdecl;
    function borderLeftColor: NSString; cdecl;
    procedure setBorderLeftColor(borderLeftColor: NSString); cdecl;
    function borderTopStyle: NSString; cdecl;
    procedure setBorderTopStyle(borderTopStyle: NSString); cdecl;
    function borderRightStyle: NSString; cdecl;
    procedure setBorderRightStyle(borderRightStyle: NSString); cdecl;
    function borderBottomStyle: NSString; cdecl;
    procedure setBorderBottomStyle(borderBottomStyle: NSString); cdecl;
    function borderLeftStyle: NSString; cdecl;
    procedure setBorderLeftStyle(borderLeftStyle: NSString); cdecl;
    function borderTopWidth: NSString; cdecl;
    procedure setBorderTopWidth(borderTopWidth: NSString); cdecl;
    function borderRightWidth: NSString; cdecl;
    procedure setBorderRightWidth(borderRightWidth: NSString); cdecl;
    function borderBottomWidth: NSString; cdecl;
    procedure setBorderBottomWidth(borderBottomWidth: NSString); cdecl;
    function borderLeftWidth: NSString; cdecl;
    procedure setBorderLeftWidth(borderLeftWidth: NSString); cdecl;
    function borderWidth: NSString; cdecl;
    procedure setBorderWidth(borderWidth: NSString); cdecl;
    function bottom: NSString; cdecl;
    procedure setBottom(bottom: NSString); cdecl;
    function captionSide: NSString; cdecl;
    procedure setCaptionSide(captionSide: NSString); cdecl;
    function clear: NSString; cdecl;
    procedure setClear(clear: NSString); cdecl;
    function clip: NSString; cdecl;
    procedure setClip(clip: NSString); cdecl;
    function color: NSString; cdecl;
    procedure setColor(color: NSString); cdecl;
    function content: NSString; cdecl;
    procedure setContent(content: NSString); cdecl;
    function counterIncrement: NSString; cdecl;
    procedure setCounterIncrement(counterIncrement: NSString); cdecl;
    function counterReset: NSString; cdecl;
    procedure setCounterReset(counterReset: NSString); cdecl;
    function cue: NSString; cdecl;
    procedure setCue(cue: NSString); cdecl;
    function cueAfter: NSString; cdecl;
    procedure setCueAfter(cueAfter: NSString); cdecl;
    function cueBefore: NSString; cdecl;
    procedure setCueBefore(cueBefore: NSString); cdecl;
    function cursor: NSString; cdecl;
    procedure setCursor(cursor: NSString); cdecl;
    function direction: NSString; cdecl;
    procedure setDirection(direction: NSString); cdecl;
    function display: NSString; cdecl;
    procedure setDisplay(display: NSString); cdecl;
    function elevation: NSString; cdecl;
    procedure setElevation(elevation: NSString); cdecl;
    function emptyCells: NSString; cdecl;
    procedure setEmptyCells(emptyCells: NSString); cdecl;
    function cssFloat: NSString; cdecl;
    procedure setCssFloat(cssFloat: NSString); cdecl;
    function font: NSString; cdecl;
    procedure setFont(font: NSString); cdecl;
    function fontFamily: NSString; cdecl;
    procedure setFontFamily(fontFamily: NSString); cdecl;
    function fontSize: NSString; cdecl;
    procedure setFontSize(fontSize: NSString); cdecl;
    function fontSizeAdjust: NSString; cdecl;
    procedure setFontSizeAdjust(fontSizeAdjust: NSString); cdecl;
    function fontStretch: NSString; cdecl;
    procedure setFontStretch(fontStretch: NSString); cdecl;
    function fontStyle: NSString; cdecl;
    procedure setFontStyle(fontStyle: NSString); cdecl;
    function fontVariant: NSString; cdecl;
    procedure setFontVariant(fontVariant: NSString); cdecl;
    function fontWeight: NSString; cdecl;
    procedure setFontWeight(fontWeight: NSString); cdecl;
    function height: NSString; cdecl;
    procedure setHeight(height: NSString); cdecl;
    function left: NSString; cdecl;
    procedure setLeft(left: NSString); cdecl;
    function letterSpacing: NSString; cdecl;
    procedure setLetterSpacing(letterSpacing: NSString); cdecl;
    function lineHeight: NSString; cdecl;
    procedure setLineHeight(lineHeight: NSString); cdecl;
    function listStyle: NSString; cdecl;
    procedure setListStyle(listStyle: NSString); cdecl;
    function listStyleImage: NSString; cdecl;
    procedure setListStyleImage(listStyleImage: NSString); cdecl;
    function listStylePosition: NSString; cdecl;
    procedure setListStylePosition(listStylePosition: NSString); cdecl;
    function listStyleType: NSString; cdecl;
    procedure setListStyleType(listStyleType: NSString); cdecl;
    function margin: NSString; cdecl;
    procedure setMargin(margin: NSString); cdecl;
    function marginTop: NSString; cdecl;
    procedure setMarginTop(marginTop: NSString); cdecl;
    function marginRight: NSString; cdecl;
    procedure setMarginRight(marginRight: NSString); cdecl;
    function marginBottom: NSString; cdecl;
    procedure setMarginBottom(marginBottom: NSString); cdecl;
    function marginLeft: NSString; cdecl;
    procedure setMarginLeft(marginLeft: NSString); cdecl;
    function markerOffset: NSString; cdecl;
    procedure setMarkerOffset(markerOffset: NSString); cdecl;
    function marks: NSString; cdecl;
    procedure setMarks(marks: NSString); cdecl;
    function maxHeight: NSString; cdecl;
    procedure setMaxHeight(maxHeight: NSString); cdecl;
    function maxWidth: NSString; cdecl;
    procedure setMaxWidth(maxWidth: NSString); cdecl;
    function minHeight: NSString; cdecl;
    procedure setMinHeight(minHeight: NSString); cdecl;
    function minWidth: NSString; cdecl;
    procedure setMinWidth(minWidth: NSString); cdecl;
    function orphans: NSString; cdecl;
    procedure setOrphans(orphans: NSString); cdecl;
    function outline: NSString; cdecl;
    procedure setOutline(outline: NSString); cdecl;
    function outlineColor: NSString; cdecl;
    procedure setOutlineColor(outlineColor: NSString); cdecl;
    function outlineStyle: NSString; cdecl;
    procedure setOutlineStyle(outlineStyle: NSString); cdecl;
    function outlineWidth: NSString; cdecl;
    procedure setOutlineWidth(outlineWidth: NSString); cdecl;
    function overflow: NSString; cdecl;
    procedure setOverflow(overflow: NSString); cdecl;
    function padding: NSString; cdecl;
    procedure setPadding(padding: NSString); cdecl;
    function paddingTop: NSString; cdecl;
    procedure setPaddingTop(paddingTop: NSString); cdecl;
    function paddingRight: NSString; cdecl;
    procedure setPaddingRight(paddingRight: NSString); cdecl;
    function paddingBottom: NSString; cdecl;
    procedure setPaddingBottom(paddingBottom: NSString); cdecl;
    function paddingLeft: NSString; cdecl;
    procedure setPaddingLeft(paddingLeft: NSString); cdecl;
    function page: NSString; cdecl;
    procedure setPage(page: NSString); cdecl;
    function pageBreakAfter: NSString; cdecl;
    procedure setPageBreakAfter(pageBreakAfter: NSString); cdecl;
    function pageBreakBefore: NSString; cdecl;
    procedure setPageBreakBefore(pageBreakBefore: NSString); cdecl;
    function pageBreakInside: NSString; cdecl;
    procedure setPageBreakInside(pageBreakInside: NSString); cdecl;
    function pause: NSString; cdecl;
    procedure setPause(pause: NSString); cdecl;
    function pauseAfter: NSString; cdecl;
    procedure setPauseAfter(pauseAfter: NSString); cdecl;
    function pauseBefore: NSString; cdecl;
    procedure setPauseBefore(pauseBefore: NSString); cdecl;
    function pitch: NSString; cdecl;
    procedure setPitch(pitch: NSString); cdecl;
    function pitchRange: NSString; cdecl;
    procedure setPitchRange(pitchRange: NSString); cdecl;
    function playDuring: NSString; cdecl;
    procedure setPlayDuring(playDuring: NSString); cdecl;
    function position: NSString; cdecl;
    procedure setPosition(position: NSString); cdecl;
    function quotes: NSString; cdecl;
    procedure setQuotes(quotes: NSString); cdecl;
    function richness: NSString; cdecl;
    procedure setRichness(richness: NSString); cdecl;
    function right: NSString; cdecl;
    procedure setRight(right: NSString); cdecl;
    function size: NSString; cdecl;
    procedure setSize(size: NSString); cdecl;
    function speak: NSString; cdecl;
    procedure setSpeak(speak: NSString); cdecl;
    function speakHeader: NSString; cdecl;
    procedure setSpeakHeader(speakHeader: NSString); cdecl;
    function speakNumeral: NSString; cdecl;
    procedure setSpeakNumeral(speakNumeral: NSString); cdecl;
    function speakPunctuation: NSString; cdecl;
    procedure setSpeakPunctuation(speakPunctuation: NSString); cdecl;
    function speechRate: NSString; cdecl;
    procedure setSpeechRate(speechRate: NSString); cdecl;
    function stress: NSString; cdecl;
    procedure setStress(stress: NSString); cdecl;
    function tableLayout: NSString; cdecl;
    procedure setTableLayout(tableLayout: NSString); cdecl;
    function textAlign: NSString; cdecl;
    procedure setTextAlign(textAlign: NSString); cdecl;
    function textDecoration: NSString; cdecl;
    procedure setTextDecoration(textDecoration: NSString); cdecl;
    function textIndent: NSString; cdecl;
    procedure setTextIndent(textIndent: NSString); cdecl;
    function textShadow: NSString; cdecl;
    procedure setTextShadow(textShadow: NSString); cdecl;
    function textTransform: NSString; cdecl;
    procedure setTextTransform(textTransform: NSString); cdecl;
    function top: NSString; cdecl;
    procedure setTop(top: NSString); cdecl;
    function unicodeBidi: NSString; cdecl;
    procedure setUnicodeBidi(unicodeBidi: NSString); cdecl;
    function verticalAlign: NSString; cdecl;
    procedure setVerticalAlign(verticalAlign: NSString); cdecl;
    function visibility: NSString; cdecl;
    procedure setVisibility(visibility: NSString); cdecl;
    function voiceFamily: NSString; cdecl;
    procedure setVoiceFamily(voiceFamily: NSString); cdecl;
    function volume: NSString; cdecl;
    procedure setVolume(volume: NSString); cdecl;
    function whiteSpace: NSString; cdecl;
    procedure setWhiteSpace(whiteSpace: NSString); cdecl;
    function widows: NSString; cdecl;
    procedure setWidows(widows: NSString); cdecl;
    function width: NSString; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function wordSpacing: NSString; cdecl;
    procedure setWordSpacing(wordSpacing: NSString); cdecl;
    function zIndex: NSString; cdecl;
    procedure setZIndex(zIndex: NSString); cdecl;
  end;

  TDOMCSSStyleDeclaration = class(TOCGenericImport<DOMCSSStyleDeclarationClass, DOMCSSStyleDeclaration>)
  end;
  PDOMCSSStyleDeclaration = Pointer;

  DOMAttrClass = interface(DOMNodeClass)
    ['{F130F7A1-39C4-4916-A3F5-B7DB613B9386}']
  end;
  DOMAttr = interface(DOMNode)
    ['{E32355E6-BC7F-4E8B-BC7D-5B24074AF06B}']
    function name: NSString; cdecl;
    function specified: Boolean; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    function ownerElement: DOMElement; cdecl;
    function style: DOMCSSStyleDeclaration; cdecl;
  end;

  TDOMAttr = class(TOCGenericImport<DOMAttrClass, DOMAttr>)
  end;
  PDOMAttr = Pointer;

  DOMCharacterDataClass = interface(DOMNodeClass)
    ['{3F001838-D79F-49FD-807E-0568219D6D0D}']
  end;
  DOMCharacterData = interface(DOMNode)
    ['{858650CF-2447-4D36-B3E1-A43B24230A1D}']
    procedure setData(data: NSString); cdecl;
    function data: NSString; cdecl;
    function length: Cardinal; cdecl;
    [MethodName('substringData:length:')]
    function substringDataLength(offset: Cardinal; length: Cardinal): NSString; cdecl;
    procedure appendData(data: NSString); cdecl;
    [MethodName('insertData:data:')]
    procedure insertDataData(offset: Cardinal; data: NSString); cdecl;
    [MethodName('deleteData:length:')]
    procedure deleteDataLength(offset: Cardinal; length: Cardinal); cdecl;
    [MethodName('replaceData:length:data:')]
    procedure replaceDataLengthData(offset: Cardinal; length: Cardinal; data: NSString); cdecl;
    [MethodName('substringData::')]
    function substringData(offset: Cardinal; length: Cardinal): NSString; cdecl;
    [MethodName('insertData::')]
    procedure insertData(offset: Cardinal; data: NSString); cdecl;
    [MethodName('deleteData::')]
    procedure deleteData(offset: Cardinal; length: Cardinal); cdecl;
    [MethodName('replaceData:::')]
    procedure replaceData(offset: Cardinal; length: Cardinal; data: NSString); cdecl;
  end;

  TDOMCharacterData = class(TOCGenericImport<DOMCharacterDataClass, DOMCharacterData>)
  end;
  PDOMCharacterData = Pointer;

  DOMTextClass = interface(DOMCharacterDataClass)
    ['{8F782A6E-4E5F-49D3-9F43-ED4A4CE8276F}']
  end;
  DOMText = interface(DOMCharacterData)
    ['{48E45D76-78E2-4146-A90A-1CD9831AD4C4}']
    function wholeText: NSString; cdecl;
    function splitText(offset: Cardinal): DOMText; cdecl;
    function replaceWholeText(content: NSString): DOMText; cdecl;
  end;

  TDOMText = class(TOCGenericImport<DOMTextClass, DOMText>)
  end;
  PDOMText = Pointer;

  DOMCDATASectionClass = interface(DOMTextClass)
    ['{9EEA0BFA-1384-48DF-BB9E-6632FE28E448}']
  end;
  DOMCDATASection = interface(DOMText)
    ['{8A7C9410-862E-4F97-9EB7-46EFBAF6392B}']
  end;

  TDOMCDATASection = class(TOCGenericImport<DOMCDATASectionClass, DOMCDATASection>)
  end;
  PDOMCDATASection = Pointer;

  DOMCommentClass = interface(DOMCharacterDataClass)
    ['{8B8A7AE9-205F-400D-864E-103237C23F36}']
  end;
  DOMComment = interface(DOMCharacterData)
    ['{8FF1FABB-F48F-4C5E-A368-51B812557C46}']
  end;

  TDOMComment = class(TOCGenericImport<DOMCommentClass, DOMComment>)
  end;
  PDOMComment = Pointer;

  DOMAbstractViewClass = interface(DOMObjectClass)
    ['{A6D6EF95-6D4A-4755-A87F-D2118196B8D4}']
  end;
  DOMAbstractView = interface(DOMObject)
    ['{754C004B-91D9-49B7-8716-F19AD42332D2}']
    function document: DOMDocument; cdecl;
  end;

  TDOMAbstractView = class(TOCGenericImport<DOMAbstractViewClass, DOMAbstractView>)
  end;
  PDOMAbstractView = Pointer;

  DOMCSSRuleListClass = interface(DOMObjectClass)
    ['{41EAC823-4F9A-41B6-9A75-C2BFCEDFCB47}']
  end;
  DOMCSSRuleList = interface(DOMObject)
    ['{92AE8DE2-D02E-453A-8CAD-B5C8E6200061}']
    function length: Cardinal; cdecl;
    function item(index: Cardinal): DOMCSSRule; cdecl;
  end;

  TDOMCSSRuleList = class(TOCGenericImport<DOMCSSRuleListClass, DOMCSSRuleList>)
  end;
  PDOMCSSRuleList = Pointer;

  DOMDocumentFragmentClass = interface(DOMNodeClass)
    ['{4BF12613-DDB8-48BF-970F-39DA3DDD58A8}']
  end;
  DOMDocumentFragment = interface(DOMNode)
    ['{7AC712DB-B6EF-4F51-B4A7-01B93736CD39}']
  end;

  TDOMDocumentFragment = class(TOCGenericImport<DOMDocumentFragmentClass, DOMDocumentFragment>)
  end;
  PDOMDocumentFragment = Pointer;

  DOMDocumentTypeClass = interface(DOMNodeClass)
    ['{74F74EA8-216F-405A-95AB-2668D3CE9ED4}']
  end;
  DOMDocumentType = interface(DOMNode)
    ['{2535F1DF-FAE7-4492-8F27-8014A5F76B89}']
    function name: NSString; cdecl;
    function entities: DOMNamedNodeMap; cdecl;
    function notations: DOMNamedNodeMap; cdecl;
    function publicId: NSString; cdecl;
    function systemId: NSString; cdecl;
    function internalSubset: NSString; cdecl;
  end;

  TDOMDocumentType = class(TOCGenericImport<DOMDocumentTypeClass, DOMDocumentType>)
  end;
  PDOMDocumentType = Pointer;

  DOMEntityReferenceClass = interface(DOMNodeClass)
    ['{570F0562-DCB3-4551-A5BC-311696BB8DFF}']
  end;
  DOMEntityReference = interface(DOMNode)
    ['{4EAB9681-69DE-406E-8465-37B17CC9C991}']
  end;

  TDOMEntityReference = class(TOCGenericImport<DOMEntityReferenceClass, DOMEntityReference>)
  end;
  PDOMEntityReference = Pointer;

  DOMHTMLCollectionClass = interface(DOMObjectClass)
    ['{6A20ADCC-5F36-4E20-8FD6-517115091B6A}']
  end;
  DOMHTMLCollection = interface(DOMObject)
    ['{3CBE993D-D050-49D7-8484-C4B7CDDA0BA5}']
    function length: Cardinal; cdecl;
    function item(index: Cardinal): DOMNode; cdecl;
    function namedItem(name: NSString): DOMNode; cdecl;
    function tags(name: NSString): DOMNodeList; cdecl;
  end;

  TDOMHTMLCollection = class(TOCGenericImport<DOMHTMLCollectionClass, DOMHTMLCollection>)
  end;
  PDOMHTMLCollection = Pointer;

  DOMHTMLElementClass = interface(DOMElementClass)
    ['{14F18E7C-192E-459B-BE98-47D1A059653D}']
  end;
  DOMHTMLElement = interface(DOMElement)
    ['{857EB6E9-FB3C-44EF-A556-1D1204E7C068}']
    procedure setIdName(idName: NSString); cdecl;
    function idName: NSString; cdecl;
    procedure setTitle(title: NSString); cdecl;
    function title: NSString; cdecl;
    procedure setLang(lang: NSString); cdecl;
    function lang: NSString; cdecl;
    procedure setDir(dir: NSString); cdecl;
    function dir: NSString; cdecl;
    procedure setTabIndex(tabIndex: Integer); cdecl;
    function tabIndex: Integer; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
    procedure setInnerHTML(innerHTML: NSString); cdecl;
    function innerHTML: NSString; cdecl;
    procedure setInnerText(innerText: NSString); cdecl;
    function innerText: NSString; cdecl;
    procedure setOuterHTML(outerHTML: NSString); cdecl;
    function outerHTML: NSString; cdecl;
    procedure setOuterText(outerText: NSString); cdecl;
    function outerText: NSString; cdecl;
    function children: DOMHTMLCollection; cdecl;
    procedure setContentEditable(contentEditable: NSString); cdecl;
    function contentEditable: NSString; cdecl;
    function isContentEditable: Boolean; cdecl;
    function titleDisplayString: NSString; cdecl;
    procedure click; cdecl;
  end;

  TDOMHTMLElement = class(TOCGenericImport<DOMHTMLElementClass, DOMHTMLElement>)
  end;
  PDOMHTMLElement = Pointer;

  DOMImplementationClass = interface(DOMObjectClass)
    ['{F612E462-40E9-487B-91B9-B698846ED0CF}']
  end;
  DOMImplementation = interface(DOMObject)
    ['{20372673-72DC-4B0E-8457-E5A9D2B3D065}']
    [MethodName('hasFeature:version:')]
    function hasFeatureVersion(feature: NSString; version: NSString): Boolean; cdecl;
    [MethodName('createDocumentType:publicId:systemId:')]
    function createDocumentTypePublicIdSystemId(qualifiedName: NSString; publicId: NSString; systemId: NSString)
      : DOMDocumentType; cdecl;
    [MethodName('createDocument:qualifiedName:doctype:')]
    function createDocumentQualifiedNameDoctype(namespaceURI: NSString; qualifiedName: NSString;
      doctype: DOMDocumentType): DOMDocument; cdecl;
    [MethodName('createCSSStyleSheet:media:')]
    function createCSSStyleSheetMedia(title: NSString; media: NSString): DOMCSSStyleSheet; cdecl;
    function createHTMLDocument(title: NSString): DOMHTMLDocument; cdecl;
    [MethodName('hasFeature::')]
    function hasFeature(feature: NSString; version: NSString): Boolean; cdecl;
    [MethodName('createDocumentType:::')]
    function createDocumentType(qualifiedName: NSString; publicId: NSString; systemId: NSString)
      : DOMDocumentType; cdecl;
    [MethodName('createDocument:::')]
    function createDocument(namespaceURI: NSString; qualifiedName: NSString; doctype: DOMDocumentType)
      : DOMDocument; cdecl;
    [MethodName('createCSSStyleSheet::')]
    function createCSSStyleSheet(title: NSString; media: NSString): DOMCSSStyleSheet; cdecl;
  end;

  TDOMImplementation = class(TOCGenericImport<DOMImplementationClass, DOMImplementation>)
  end;
  PDOMImplementation = Pointer;

  DOMNodeIteratorClass = interface(DOMObjectClass)
    ['{DE47A780-49D9-4B40-A242-695471C3B4B9}']
  end;
  DOMNodeIterator = interface(DOMObject)
    ['{7FD68579-56D1-4F9C-83C1-F1BF6FBA06D0}']
    function root: DOMNode; cdecl;
    function whatToShow: Cardinal; cdecl;
    function filter: Pointer; cdecl;
    function expandEntityReferences: Boolean; cdecl;
    function referenceNode: DOMNode; cdecl;
    function pointerBeforeReferenceNode: Boolean; cdecl;
    function nextNode: DOMNode; cdecl;
    function previousNode: DOMNode; cdecl;
    procedure detach; cdecl;
  end;

  TDOMNodeIterator = class(TOCGenericImport<DOMNodeIteratorClass, DOMNodeIterator>)
  end;
  PDOMNodeIterator = Pointer;

  DOMProcessingInstructionClass = interface(DOMCharacterDataClass)
    ['{8B0B9F7E-93C1-4B40-A3AA-2BE09B96BA6E}']
  end;
  DOMProcessingInstruction = interface(DOMCharacterData)
    ['{8A06C523-A0C4-4A6A-906E-EF6E9520BF7F}']
    function target: NSString; cdecl;
    function sheet: DOMStyleSheet; cdecl;
  end;

  TDOMProcessingInstruction = class(TOCGenericImport<DOMProcessingInstructionClass, DOMProcessingInstruction>)
  end;
  PDOMProcessingInstruction = Pointer;

  DOMRangeClass = interface(DOMObjectClass)
    ['{88DEAA32-88BD-47C9-B260-7DD743B52C61}']
  end;
  DOMRange = interface(DOMObject)
    ['{63693047-2573-4D69-B9CB-02D075B59ECD}']
    function startContainer: DOMNode; cdecl;
    function startOffset: Integer; cdecl;
    function endContainer: DOMNode; cdecl;
    function endOffset: Integer; cdecl;
    function collapsed: Boolean; cdecl;
    function commonAncestorContainer: DOMNode; cdecl;
    function text: NSString; cdecl;
    [MethodName('setStart:offset:')]
    procedure setStartOffset(refNode: DOMNode; offset: Integer); cdecl;
    [MethodName('setEnd:offset:')]
    procedure setEndOffset(refNode: DOMNode; offset: Integer); cdecl;
    procedure setStartBefore(refNode: DOMNode); cdecl;
    procedure setStartAfter(refNode: DOMNode); cdecl;
    procedure setEndBefore(refNode: DOMNode); cdecl;
    procedure setEndAfter(refNode: DOMNode); cdecl;
    procedure collapse(toStart: Boolean); cdecl;
    procedure selectNode(refNode: DOMNode); cdecl;
    procedure selectNodeContents(refNode: DOMNode); cdecl;
    [MethodName('compareBoundaryPoints:sourceRange:')]
    function compareBoundaryPointsSourceRange(how: Word; sourceRange: DOMRange): SmallInt; cdecl;
    procedure deleteContents; cdecl;
    function extractContents: DOMDocumentFragment; cdecl;
    function cloneContents: DOMDocumentFragment; cdecl;
    procedure insertNode(newNode: DOMNode); cdecl;
    procedure surroundContents(newParent: DOMNode); cdecl;
    function cloneRange: DOMRange; cdecl;
    function toString: NSString; cdecl;
    procedure detach; cdecl;
    function createContextualFragment(html: NSString): DOMDocumentFragment; cdecl;
    function intersectsNode(refNode: DOMNode): Boolean; cdecl;
    function compareNode(refNode: DOMNode): SmallInt; cdecl;
    function comparePoint(refNode: DOMNode; offset: Integer): SmallInt; cdecl;
    function isPointInRange(refNode: DOMNode; offset: Integer): Boolean; cdecl;
    [MethodName('setStart::')]
    procedure setStart(refNode: DOMNode; offset: Integer); cdecl;
    [MethodName('setEnd::')]
    procedure setEnd(refNode: DOMNode; offset: Integer); cdecl;
    [MethodName('compareBoundaryPoints::')]
    function compareBoundaryPoints(how: Word; sourceRange: DOMRange): SmallInt; cdecl;
    function WebArchive: WebArchive; cdecl;
    function markupString: NSString; cdecl;
  end;

  TDOMRange = class(TOCGenericImport<DOMRangeClass, DOMRange>)
  end;
  PDOMRange = Pointer;

  DOMStyleSheetListClass = interface(DOMObjectClass)
    ['{D250BDF4-BA6C-4765-BC95-5FDDB5CE1EB1}']
  end;
  DOMStyleSheetList = interface(DOMObject)
    ['{BA940534-CB61-4736-A92A-AB8E5A263701}']
    function length: Cardinal; cdecl;
    function item(index: Cardinal): DOMStyleSheet; cdecl;
  end;

  TDOMStyleSheetList = class(TOCGenericImport<DOMStyleSheetListClass, DOMStyleSheetList>)
  end;
  PDOMStyleSheetList = Pointer;

  DOMTreeWalkerClass = interface(DOMObjectClass)
    ['{47F28365-6E98-4B45-9F58-20F830C4161F}']
  end;
  DOMTreeWalker = interface(DOMObject)
    ['{BE122A04-9FD8-4BD2-B5E3-094C5347F9F5}']
    function root: DOMNode; cdecl;
    function whatToShow: Cardinal; cdecl;
    function filter: Pointer; cdecl;
    function expandEntityReferences: Boolean; cdecl;
    procedure setCurrentNode(currentNode: DOMNode); cdecl;
    function currentNode: DOMNode; cdecl;
    function parentNode: DOMNode; cdecl;
    function firstChild: DOMNode; cdecl;
    function lastChild: DOMNode; cdecl;
    function previousSibling: DOMNode; cdecl;
    function nextSibling: DOMNode; cdecl;
    function previousNode: DOMNode; cdecl;
    function nextNode: DOMNode; cdecl;
  end;

  TDOMTreeWalker = class(TOCGenericImport<DOMTreeWalkerClass, DOMTreeWalker>)
  end;
  PDOMTreeWalker = Pointer;

  DOMXPathExpressionClass = interface(DOMObjectClass)
    ['{A9F45D06-C132-4CBC-AB93-812A80FAA33D}']
  end;
  DOMXPathExpression = interface(DOMObject)
    ['{111B79DE-1390-40A4-BBFA-0EE82A2687A0}']
    [MethodName('evaluate:type:inResult:')]
    function evaluateTypeInResult(contextNode: DOMNode; &type: Word; inResult: DOMXPathResult): DOMXPathResult; cdecl;
    [MethodName('evaluate:::')]
    function evaluate(contextNode: DOMNode; &type: Word; inResult: DOMXPathResult): DOMXPathResult; cdecl;
  end;

  TDOMXPathExpression = class(TOCGenericImport<DOMXPathExpressionClass, DOMXPathExpression>)
  end;
  PDOMXPathExpression = Pointer;

  DOMXPathResultClass = interface(DOMObjectClass)
    ['{B5FC4CA3-4848-48FF-A745-F07C1613B75E}']
  end;
  DOMXPathResult = interface(DOMObject)
    ['{F6207328-6D9E-4F0A-8DB6-4E2B39011A11}']
    function resultType: Word; cdecl;
    function numberValue: Double; cdecl;
    function stringValue: NSString; cdecl;
    function booleanValue: Boolean; cdecl;
    function singleNodeValue: DOMNode; cdecl;
    function invalidIteratorState: Boolean; cdecl;
    function snapshotLength: Cardinal; cdecl;
    function iterateNext: DOMNode; cdecl;
    function snapshotItem(index: Cardinal): DOMNode; cdecl;
  end;

  TDOMXPathResult = class(TOCGenericImport<DOMXPathResultClass, DOMXPathResult>)
  end;
  PDOMXPathResult = Pointer;

  DOMEntityClass = interface(DOMNodeClass)
    ['{73999CF7-39C1-4F63-AD80-42AA3DF9ADA4}']
  end;
  DOMEntity = interface(DOMNode)
    ['{810FD809-6467-4C36-AE2D-A6AA31CE92C7}']
    function publicId: NSString; cdecl;
    function systemId: NSString; cdecl;
    function notationName: NSString; cdecl;
  end;

  TDOMEntity = class(TOCGenericImport<DOMEntityClass, DOMEntity>)
  end;
  PDOMEntity = Pointer;

  DOMCSSStyleSheetClass = interface(DOMStyleSheetClass)
    ['{0640E19B-7BEA-4A59-B685-3A834EE313DA}']
  end;
  DOMCSSStyleSheet = interface(DOMStyleSheet)
    ['{985B8610-439E-451D-ADEB-7FFB7ACD6065}']
    function ownerRule: DOMCSSRule; cdecl;
    function cssRules: DOMCSSRuleList; cdecl;
    function rules: DOMCSSRuleList; cdecl;
    [MethodName('insertRule:index:')]
    function insertRuleIndex(rule: NSString; index: Cardinal): Cardinal; cdecl;
    procedure deleteRule(index: Cardinal); cdecl;
    function addRule(selector: NSString; style: NSString; index: Cardinal): Integer; cdecl;
    procedure removeRule(index: Cardinal); cdecl;
    [MethodName('insertRule::')]
    function insertRule(rule: NSString; index: Cardinal): Cardinal; cdecl;
  end;

  TDOMCSSStyleSheet = class(TOCGenericImport<DOMCSSStyleSheetClass, DOMCSSStyleSheet>)
  end;
  PDOMCSSStyleSheet = Pointer;

  DOMHTMLDocumentClass = interface(DOMDocumentClass)
    ['{0DF6130E-BC06-4D22-9C38-B5E6901D193E}']
  end;
  DOMHTMLDocument = interface(DOMDocument)
    ['{9A1645F4-51D5-42BB-93A1-8C9B68B5C3D0}']
    function embeds: DOMHTMLCollection; cdecl;
    function plugins: DOMHTMLCollection; cdecl;
    function scripts: DOMHTMLCollection; cdecl;
    function width: Integer; cdecl;
    function height: Integer; cdecl;
    procedure setDir(dir: NSString); cdecl;
    function dir: NSString; cdecl;
    procedure setDesignMode(designMode: NSString); cdecl;
    function designMode: NSString; cdecl;
    function compatMode: NSString; cdecl;
    procedure setBgColor(bgColor: NSString); cdecl;
    function bgColor: NSString; cdecl;
    procedure setFgColor(fgColor: NSString); cdecl;
    function fgColor: NSString; cdecl;
    procedure setAlinkColor(alinkColor: NSString); cdecl;
    function alinkColor: NSString; cdecl;
    procedure setLinkColor(linkColor: NSString); cdecl;
    function linkColor: NSString; cdecl;
    procedure setVlinkColor(vlinkColor: NSString); cdecl;
    function vlinkColor: NSString; cdecl;
    procedure open; cdecl;
    procedure close; cdecl;
    procedure write(text: NSString); cdecl;
    procedure writeln(text: NSString); cdecl;
    procedure clear; cdecl;
    procedure captureEvents; cdecl;
    procedure releaseEvents; cdecl;
    function createDocumentFragmentWithMarkupString(markupString: NSString; baseURL: NSURL): DOMDocumentFragment; cdecl;
    function createDocumentFragmentWithText(text: NSString): DOMDocumentFragment; cdecl;
  end;

  TDOMHTMLDocument = class(TOCGenericImport<DOMHTMLDocumentClass, DOMHTMLDocument>)
  end;
  PDOMHTMLDocument = Pointer;

  DOMNotationClass = interface(DOMNodeClass)
    ['{44BDA618-4832-4E39-A7CC-278F4DC89EC9}']
  end;
  DOMNotation = interface(DOMNode)
    ['{2FA84125-6B22-4092-BA60-5EF0FCE2A1FF}']
    function publicId: NSString; cdecl;
    function systemId: NSString; cdecl;
  end;

  TDOMNotation = class(TOCGenericImport<DOMNotationClass, DOMNotation>)
  end;
  PDOMNotation = Pointer;

  DOMMediaListClass = interface(DOMObjectClass)
    ['{6B9DEE42-E792-403D-8DEC-5441D4BBF690}']
  end;
  DOMMediaList = interface(DOMObject)
    ['{00FD1695-A9CD-4852-82EA-45A4EBFA352E}']
    procedure setMediaText(mediaText: NSString); cdecl;
    function mediaText: NSString; cdecl;
    function length: Cardinal; cdecl;
    function item(index: Cardinal): NSString; cdecl;
    procedure deleteMedium(oldMedium: NSString); cdecl;
    procedure appendMedium(newMedium: NSString); cdecl;
  end;

  TDOMMediaList = class(TOCGenericImport<DOMMediaListClass, DOMMediaList>)
  end;
  PDOMMediaList = Pointer;

  DOMCSSRuleClass = interface(DOMObjectClass)
    ['{B20A04EA-8B21-4CD3-BF18-4EA2CA2F9F3C}']
  end;
  DOMCSSRule = interface(DOMObject)
    ['{417FC1B9-115D-4854-9467-2BEC8B7ADFA5}']
    function &type: Word; cdecl;
    procedure setCssText(cssText: NSString); cdecl;
    function cssText: NSString; cdecl;
    function parentStyleSheet: DOMCSSStyleSheet; cdecl;
    function parentRule: DOMCSSRule; cdecl;
  end;

  TDOMCSSRule = class(TOCGenericImport<DOMCSSRuleClass, DOMCSSRule>)
  end;
  PDOMCSSRule = Pointer;

  DOMCSSCharsetRuleClass = interface(DOMCSSRuleClass)
    ['{F04AE0CE-D03B-4607-8F79-6A967A698625}']
  end;
  DOMCSSCharsetRule = interface(DOMCSSRule)
    ['{C959FCC7-58D8-446F-9900-13D54B86E8E1}']
    function encoding: NSString; cdecl;
  end;

  TDOMCSSCharsetRule = class(TOCGenericImport<DOMCSSCharsetRuleClass, DOMCSSCharsetRule>)
  end;
  PDOMCSSCharsetRule = Pointer;

  DOMCSSFontFaceRuleClass = interface(DOMCSSRuleClass)
    ['{2BF289A0-FB30-46A8-B742-F081BE8A3870}']
  end;
  DOMCSSFontFaceRule = interface(DOMCSSRule)
    ['{7B689098-81F5-48A7-BD80-B65E41DFCD70}']
    function style: DOMCSSStyleDeclaration; cdecl;
  end;

  TDOMCSSFontFaceRule = class(TOCGenericImport<DOMCSSFontFaceRuleClass, DOMCSSFontFaceRule>)
  end;
  PDOMCSSFontFaceRule = Pointer;

  DOMCSSImportRuleClass = interface(DOMCSSRuleClass)
    ['{CCE91404-3819-4AA0-ADA9-C85613A4862C}']
  end;
  DOMCSSImportRule = interface(DOMCSSRule)
    ['{C29BD307-5D60-4263-B9DA-5765FD3279F5}']
    function href: NSString; cdecl;
    function media: DOMMediaList; cdecl;
    function styleSheet: DOMCSSStyleSheet; cdecl;
  end;

  TDOMCSSImportRule = class(TOCGenericImport<DOMCSSImportRuleClass, DOMCSSImportRule>)
  end;
  PDOMCSSImportRule = Pointer;

  DOMCSSMediaRuleClass = interface(DOMCSSRuleClass)
    ['{4F9C3003-96FD-401E-803C-5160F161A684}']
  end;
  DOMCSSMediaRule = interface(DOMCSSRule)
    ['{67ED4854-B512-4C61-A03B-4FBDC69E042C}']
    function media: DOMMediaList; cdecl;
    function cssRules: DOMCSSRuleList; cdecl;
    [MethodName('insertRule:index:')]
    function insertRuleIndex(rule: NSString; index: Cardinal): Cardinal; cdecl;
    procedure deleteRule(index: Cardinal); cdecl;
    [MethodName('insertRule::')]
    function insertRule(rule: NSString; index: Cardinal): Cardinal; cdecl;
  end;

  TDOMCSSMediaRule = class(TOCGenericImport<DOMCSSMediaRuleClass, DOMCSSMediaRule>)
  end;
  PDOMCSSMediaRule = Pointer;

  DOMCSSPageRuleClass = interface(DOMCSSRuleClass)
    ['{66BDC048-FB4B-40CF-A26E-E92FA1644AF5}']
  end;
  DOMCSSPageRule = interface(DOMCSSRule)
    ['{42A778A5-31DD-4348-86AD-7262DEE2F556}']
    procedure setSelectorText(selectorText: NSString); cdecl;
    function selectorText: NSString; cdecl;
    function style: DOMCSSStyleDeclaration; cdecl;
  end;

  TDOMCSSPageRule = class(TOCGenericImport<DOMCSSPageRuleClass, DOMCSSPageRule>)
  end;
  PDOMCSSPageRule = Pointer;

  DOMCSSValueClass = interface(DOMObjectClass)
    ['{B2E252F8-9BE7-4DA5-9844-3394F05BB531}']
  end;
  DOMCSSValue = interface(DOMObject)
    ['{0779D845-4D9E-4D9F-BA43-BC29A11D5FC6}']
    procedure setCssText(cssText: NSString); cdecl;
    function cssText: NSString; cdecl;
    function cssValueType: Word; cdecl;
  end;

  TDOMCSSValue = class(TOCGenericImport<DOMCSSValueClass, DOMCSSValue>)
  end;
  PDOMCSSValue = Pointer;

  DOMCounterClass = interface(DOMObjectClass)
    ['{BD1C2934-2C1A-4BE4-86F3-F02A8C936AB9}']
  end;
  DOMCounter = interface(DOMObject)
    ['{5074F2B3-5800-4F90-A028-861B676DABF4}']
    function identifier: NSString; cdecl;
    function listStyle: NSString; cdecl;
    function separator: NSString; cdecl;
  end;

  TDOMCounter = class(TOCGenericImport<DOMCounterClass, DOMCounter>)
  end;
  PDOMCounter = Pointer;

  DOMRGBColorClass = interface(DOMObjectClass)
    ['{24441C12-F755-4B02-8196-72043226F55F}']
  end;
  DOMRGBColor = interface(DOMObject)
    ['{157E92D7-0EDB-4F93-BAE5-CCE4E4AE0BDF}']
    function red: DOMCSSPrimitiveValue; cdecl;
    function green: DOMCSSPrimitiveValue; cdecl;
    function blue: DOMCSSPrimitiveValue; cdecl;
    function alpha: DOMCSSPrimitiveValue; cdecl;
    function color: NSColor; cdecl;
  end;

  TDOMRGBColor = class(TOCGenericImport<DOMRGBColorClass, DOMRGBColor>)
  end;
  PDOMRGBColor = Pointer;

  DOMRectClass = interface(DOMObjectClass)
    ['{385A4EED-476D-4F31-9F51-9629CB5387BC}']
  end;
  DOMRect = interface(DOMObject)
    ['{9E19CDDA-0828-444F-8C0A-4BCA5B51DC18}']
    function top: DOMCSSPrimitiveValue; cdecl;
    function right: DOMCSSPrimitiveValue; cdecl;
    function bottom: DOMCSSPrimitiveValue; cdecl;
    function left: DOMCSSPrimitiveValue; cdecl;
  end;

  TDOMRect = class(TOCGenericImport<DOMRectClass, DOMRect>)
  end;
  PDOMRect = Pointer;

  DOMCSSPrimitiveValueClass = interface(DOMCSSValueClass)
    ['{EF30E322-CBC8-4275-B1C0-423AEBCED5FC}']
  end;
  DOMCSSPrimitiveValue = interface(DOMCSSValue)
    ['{60BCB574-1F77-4F0C-AD80-38D16392BBBF}']
    function primitiveType: Word; cdecl;
    [MethodName('setFloatValue:floatValue:')]
    procedure setFloatValueFloatValue(unitType: Word; floatValue: Single); cdecl;
    function getFloatValue(unitType: Word): Single; cdecl;
    [MethodName('setStringValue:stringValue:')]
    procedure setStringValueStringValue(stringType: Word; stringValue: NSString); cdecl;
    function getStringValue: NSString; cdecl;
    function getCounterValue: DOMCounter; cdecl;
    function getRectValue: DOMRect; cdecl;
    function getRGBColorValue: DOMRGBColor; cdecl;
    [MethodName('setFloatValue::')]
    procedure setFloatValue(unitType: Word; floatValue: Single); cdecl;
    [MethodName('setStringValue::')]
    procedure setStringValue(stringType: Word; stringValue: NSString); cdecl;
  end;

  TDOMCSSPrimitiveValue = class(TOCGenericImport<DOMCSSPrimitiveValueClass, DOMCSSPrimitiveValue>)
  end;
  PDOMCSSPrimitiveValue = Pointer;

  DOMCSSStyleRuleClass = interface(DOMCSSRuleClass)
    ['{F73F7BF9-B880-44CD-AA1F-4907BEC1BE18}']
  end;
  DOMCSSStyleRule = interface(DOMCSSRule)
    ['{53E5F33B-4475-45E7-ADFB-1EDE44B5305E}']
    procedure setSelectorText(selectorText: NSString); cdecl;
    function selectorText: NSString; cdecl;
    function style: DOMCSSStyleDeclaration; cdecl;
  end;

  TDOMCSSStyleRule = class(TOCGenericImport<DOMCSSStyleRuleClass, DOMCSSStyleRule>)
  end;
  PDOMCSSStyleRule = Pointer;

  DOMCSSUnknownRuleClass = interface(DOMCSSRuleClass)
    ['{30EA1412-DB1D-4229-8E76-C4E570B7146A}']
  end;
  DOMCSSUnknownRule = interface(DOMCSSRule)
    ['{B4FF6CAB-F6E1-4421-B772-C1F9E3529F5B}']
  end;

  TDOMCSSUnknownRule = class(TOCGenericImport<DOMCSSUnknownRuleClass, DOMCSSUnknownRule>)
  end;
  PDOMCSSUnknownRule = Pointer;

  DOMCSSValueListClass = interface(DOMCSSValueClass)
    ['{1AF4A5E6-F68C-447C-874B-B857A061BBA8}']
  end;
  DOMCSSValueList = interface(DOMCSSValue)
    ['{AAB3E5BA-376C-4828-B4DD-D0DA8A84CDB2}']
    function length: Cardinal; cdecl;
    function item(index: Cardinal): DOMCSSValue; cdecl;
  end;

  TDOMCSSValueList = class(TOCGenericImport<DOMCSSValueListClass, DOMCSSValueList>)
  end;
  PDOMCSSValueList = Pointer;

  DOMBlobClass = interface(DOMObjectClass)
    ['{49C6B80E-E16A-4499-8706-926D670BB5F1}']
  end;
  DOMBlob = interface(DOMObject)
    ['{582559BD-8CA3-418A-ACC9-D8F0BA190161}']
    function size: UInt64; cdecl;
  end;

  TDOMBlob = class(TOCGenericImport<DOMBlobClass, DOMBlob>)
  end;
  PDOMBlob = Pointer;

  DOMFileClass = interface(DOMBlobClass)
    ['{839E7FD6-9953-4692-B1C9-75BA1B4D52AE}']
  end;
  DOMFile = interface(DOMBlob)
    ['{DBDADC92-A143-41AE-B2A7-71832F65CFE5}']
    function name: NSString; cdecl;
  end;

  TDOMFile = class(TOCGenericImport<DOMFileClass, DOMFile>)
  end;
  PDOMFile = Pointer;

  DOMFileListClass = interface(DOMObjectClass)
    ['{546CF211-999D-4E67-A871-2EC4AA8CAF9A}']
  end;
  DOMFileList = interface(DOMObject)
    ['{852DC474-F086-4F2B-858B-186B37ECCDC2}']
    function length: Cardinal; cdecl;
    function item(index: Cardinal): DOMFile; cdecl;
  end;

  TDOMFileList = class(TOCGenericImport<DOMFileListClass, DOMFileList>)
  end;
  PDOMFileList = Pointer;

  DOMHTMLAnchorElementClass = interface(DOMHTMLElementClass)
    ['{3E792BFE-ED62-4550-A914-E6F99026FD69}']
  end;
  DOMHTMLAnchorElement = interface(DOMHTMLElement)
    ['{9351BB9A-CC2E-4980-B30E-0A3B9D7DC4DE}']
    procedure setCharset(charset: NSString); cdecl;
    function charset: NSString; cdecl;
    procedure setCoords(coords: NSString); cdecl;
    function coords: NSString; cdecl;
    procedure setHref(href: NSString); cdecl;
    function href: NSString; cdecl;
    procedure setHreflang(hreflang: NSString); cdecl;
    function hreflang: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setRel(rel: NSString); cdecl;
    function rel: NSString; cdecl;
    procedure setRev(rev: NSString); cdecl;
    function rev: NSString; cdecl;
    procedure setShape(shape: NSString); cdecl;
    function shape: NSString; cdecl;
    procedure setTarget(target: NSString); cdecl;
    function target: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
    function hashName: NSString; cdecl;
    function host: NSString; cdecl;
    function hostname: NSString; cdecl;
    function pathname: NSString; cdecl;
    function port: NSString; cdecl;
    function protocol: NSString; cdecl;
    function search: NSString; cdecl;
    function text: NSString; cdecl;
    function absoluteLinkURL: NSURL; cdecl;
  end;

  TDOMHTMLAnchorElement = class(TOCGenericImport<DOMHTMLAnchorElementClass, DOMHTMLAnchorElement>)
  end;
  PDOMHTMLAnchorElement = Pointer;

  DOMHTMLAppletElementClass = interface(DOMHTMLElementClass)
    ['{4648DB36-5D1C-4415-842A-3EE6CFC583D6}']
  end;
  DOMHTMLAppletElement = interface(DOMHTMLElement)
    ['{39A64EBB-BF31-4B62-8D3D-ECF299C2CB3C}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setAlt(alt: NSString); cdecl;
    function alt: NSString; cdecl;
    procedure setArchive(archive: NSString); cdecl;
    function archive: NSString; cdecl;
    procedure setCode(code: NSString); cdecl;
    function code: NSString; cdecl;
    procedure setCodeBase(codeBase: NSString); cdecl;
    function codeBase: NSString; cdecl;
    procedure setHeight(height: NSString); cdecl;
    function height: NSString; cdecl;
    procedure setHspace(hspace: Integer); cdecl;
    function hspace: Integer; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setObject(&object: NSString); cdecl;
    function &object: NSString; cdecl;
    procedure setVspace(vspace: Integer); cdecl;
    function vspace: Integer; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
  end;

  TDOMHTMLAppletElement = class(TOCGenericImport<DOMHTMLAppletElementClass, DOMHTMLAppletElement>)
  end;
  PDOMHTMLAppletElement = Pointer;

  DOMHTMLAreaElementClass = interface(DOMHTMLElementClass)
    ['{42C05681-5B4B-4943-BDB3-F25BEA224C1F}']
  end;
  DOMHTMLAreaElement = interface(DOMHTMLElement)
    ['{69179C11-D7F3-4997-8B16-1399A4E851FF}']
    procedure setAlt(alt: NSString); cdecl;
    function alt: NSString; cdecl;
    procedure setCoords(coords: NSString); cdecl;
    function coords: NSString; cdecl;
    procedure setHref(href: NSString); cdecl;
    function href: NSString; cdecl;
    procedure setNoHref(noHref: Boolean); cdecl;
    function noHref: Boolean; cdecl;
    procedure setShape(shape: NSString); cdecl;
    function shape: NSString; cdecl;
    procedure setTarget(target: NSString); cdecl;
    function target: NSString; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
    function hashName: NSString; cdecl;
    function host: NSString; cdecl;
    function hostname: NSString; cdecl;
    function pathname: NSString; cdecl;
    function port: NSString; cdecl;
    function protocol: NSString; cdecl;
    function search: NSString; cdecl;
    function absoluteLinkURL: NSURL; cdecl;
  end;

  TDOMHTMLAreaElement = class(TOCGenericImport<DOMHTMLAreaElementClass, DOMHTMLAreaElement>)
  end;
  PDOMHTMLAreaElement = Pointer;

  DOMHTMLBRElementClass = interface(DOMHTMLElementClass)
    ['{9E9112BA-C14F-4AA1-9140-181A86159785}']
  end;
  DOMHTMLBRElement = interface(DOMHTMLElement)
    ['{3CE97C8B-4D9D-46B0-82FF-9DC2390664E2}']
    procedure setClear(clear: NSString); cdecl;
    function clear: NSString; cdecl;
  end;

  TDOMHTMLBRElement = class(TOCGenericImport<DOMHTMLBRElementClass, DOMHTMLBRElement>)
  end;
  PDOMHTMLBRElement = Pointer;

  DOMHTMLBaseElementClass = interface(DOMHTMLElementClass)
    ['{C03DF9B1-3577-4AE5-9A33-55722A431BB6}']
  end;
  DOMHTMLBaseElement = interface(DOMHTMLElement)
    ['{A8436D7A-2A16-4499-A976-C2E1C2F47C7D}']
    procedure setHref(href: NSString); cdecl;
    function href: NSString; cdecl;
    procedure setTarget(target: NSString); cdecl;
    function target: NSString; cdecl;
  end;

  TDOMHTMLBaseElement = class(TOCGenericImport<DOMHTMLBaseElementClass, DOMHTMLBaseElement>)
  end;
  PDOMHTMLBaseElement = Pointer;

  DOMHTMLBaseFontElementClass = interface(DOMHTMLElementClass)
    ['{0F10A938-DF2D-4765-A5BD-62585008B17D}']
  end;
  DOMHTMLBaseFontElement = interface(DOMHTMLElement)
    ['{C7E45FDC-84DA-4EC1-B916-A4FE943A0CD0}']
    procedure setColor(color: NSString); cdecl;
    function color: NSString; cdecl;
    procedure setFace(face: NSString); cdecl;
    function face: NSString; cdecl;
    procedure setSize(size: NSString); cdecl;
    function size: NSString; cdecl;
  end;

  TDOMHTMLBaseFontElement = class(TOCGenericImport<DOMHTMLBaseFontElementClass, DOMHTMLBaseFontElement>)
  end;
  PDOMHTMLBaseFontElement = Pointer;

  DOMHTMLBodyElementClass = interface(DOMHTMLElementClass)
    ['{8D356BD2-D379-454B-9821-03CAA82F9F47}']
  end;
  DOMHTMLBodyElement = interface(DOMHTMLElement)
    ['{7C783441-C079-4812-94EE-7FEF45328AD0}']
    procedure setALink(aLink: NSString); cdecl;
    function aLink: NSString; cdecl;
    procedure setBackground(background: NSString); cdecl;
    function background: NSString; cdecl;
    procedure setBgColor(bgColor: NSString); cdecl;
    function bgColor: NSString; cdecl;
    procedure setLink(link: NSString); cdecl;
    function link: NSString; cdecl;
    procedure setText(text: NSString); cdecl;
    function text: NSString; cdecl;
    procedure setVLink(vLink: NSString); cdecl;
    function vLink: NSString; cdecl;
  end;

  TDOMHTMLBodyElement = class(TOCGenericImport<DOMHTMLBodyElementClass, DOMHTMLBodyElement>)
  end;
  PDOMHTMLBodyElement = Pointer;

  DOMHTMLFormElementClass = interface(DOMHTMLElementClass)
    ['{B2F4CE75-C6F4-4570-B424-374F73FCE166}']
  end;
  DOMHTMLFormElement = interface(DOMHTMLElement)
    ['{0E4D511F-116E-4F84-AFFF-C44E51D15594}']
    procedure setAcceptCharset(acceptCharset: NSString); cdecl;
    function acceptCharset: NSString; cdecl;
    procedure setAction(action: NSString); cdecl;
    function action: NSString; cdecl;
    procedure setEnctype(enctype: NSString); cdecl;
    function enctype: NSString; cdecl;
    procedure setEncoding(encoding: NSString); cdecl;
    function encoding: NSString; cdecl;
    procedure setMethod(method: NSString); cdecl;
    function method: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setTarget(target: NSString); cdecl;
    function target: NSString; cdecl;
    function elements: DOMHTMLCollection; cdecl;
    function length: Integer; cdecl;
    procedure submit; cdecl;
    procedure reset; cdecl;
  end;

  TDOMHTMLFormElement = class(TOCGenericImport<DOMHTMLFormElementClass, DOMHTMLFormElement>)
  end;
  PDOMHTMLFormElement = Pointer;

  DOMHTMLButtonElementClass = interface(DOMHTMLElementClass)
    ['{1D1F12F6-6B43-4021-921A-01249EACA849}']
  end;
  DOMHTMLButtonElement = interface(DOMHTMLElement)
    ['{EC8E4ABC-02AB-43CC-B36D-CDC632A454F4}']
    procedure setAutofocus(autofocus: Boolean); cdecl;
    function autofocus: Boolean; cdecl;
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    function form: DOMHTMLFormElement; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    function willValidate: Boolean; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
    procedure click; cdecl;
  end;

  TDOMHTMLButtonElement = class(TOCGenericImport<DOMHTMLButtonElementClass, DOMHTMLButtonElement>)
  end;
  PDOMHTMLButtonElement = Pointer;

  DOMHTMLDListElementClass = interface(DOMHTMLElementClass)
    ['{82F9A24B-3695-49EA-80E9-126A1FACD165}']
  end;
  DOMHTMLDListElement = interface(DOMHTMLElement)
    ['{6C7D45E2-0A30-40CC-A6CB-298ED121B0CA}']
    procedure setCompact(compact: Boolean); cdecl;
    function compact: Boolean; cdecl;
  end;

  TDOMHTMLDListElement = class(TOCGenericImport<DOMHTMLDListElementClass, DOMHTMLDListElement>)
  end;
  PDOMHTMLDListElement = Pointer;

  DOMHTMLDirectoryElementClass = interface(DOMHTMLElementClass)
    ['{B0D20C4A-B717-42AE-B54C-97D0DB8CFD98}']
  end;
  DOMHTMLDirectoryElement = interface(DOMHTMLElement)
    ['{06AC063C-DE2B-47ED-A008-ECA18D4DCDAF}']
    procedure setCompact(compact: Boolean); cdecl;
    function compact: Boolean; cdecl;
  end;

  TDOMHTMLDirectoryElement = class(TOCGenericImport<DOMHTMLDirectoryElementClass, DOMHTMLDirectoryElement>)
  end;
  PDOMHTMLDirectoryElement = Pointer;

  DOMHTMLDivElementClass = interface(DOMHTMLElementClass)
    ['{94BF8C5F-2D40-4277-9F7B-CE64B4460C62}']
  end;
  DOMHTMLDivElement = interface(DOMHTMLElement)
    ['{F14CD94E-67B1-4592-82DF-B0122B21B3EB}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
  end;

  TDOMHTMLDivElement = class(TOCGenericImport<DOMHTMLDivElementClass, DOMHTMLDivElement>)
  end;
  PDOMHTMLDivElement = Pointer;

  DOMHTMLEmbedElementClass = interface(DOMHTMLElementClass)
    ['{6DB40BD6-7219-4F17-8AAA-0D853B37B500}']
  end;
  DOMHTMLEmbedElement = interface(DOMHTMLElement)
    ['{CB14DC3F-D3AF-40B9-88C6-20608A730350}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setHeight(height: Integer); cdecl;
    function height: Integer; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setSrc(src: NSString); cdecl;
    function src: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setWidth(width: Integer); cdecl;
    function width: Integer; cdecl;
  end;

  TDOMHTMLEmbedElement = class(TOCGenericImport<DOMHTMLEmbedElementClass, DOMHTMLEmbedElement>)
  end;
  PDOMHTMLEmbedElement = Pointer;

  DOMHTMLFieldSetElementClass = interface(DOMHTMLElementClass)
    ['{71DB9E96-BE07-4E70-A55B-D0C824B95C49}']
  end;
  DOMHTMLFieldSetElement = interface(DOMHTMLElement)
    ['{CC1CE151-1AD6-494A-82AB-6883207FD632}']
    function form: DOMHTMLFormElement; cdecl;
  end;

  TDOMHTMLFieldSetElement = class(TOCGenericImport<DOMHTMLFieldSetElementClass, DOMHTMLFieldSetElement>)
  end;
  PDOMHTMLFieldSetElement = Pointer;

  DOMHTMLFontElementClass = interface(DOMHTMLElementClass)
    ['{62EBAFF2-293A-4478-B68B-8F1936A111DA}']
  end;
  DOMHTMLFontElement = interface(DOMHTMLElement)
    ['{C9BB1519-3840-4965-8979-F0416129160B}']
    procedure setColor(color: NSString); cdecl;
    function color: NSString; cdecl;
    procedure setFace(face: NSString); cdecl;
    function face: NSString; cdecl;
    procedure setSize(size: NSString); cdecl;
    function size: NSString; cdecl;
  end;

  TDOMHTMLFontElement = class(TOCGenericImport<DOMHTMLFontElementClass, DOMHTMLFontElement>)
  end;
  PDOMHTMLFontElement = Pointer;

  DOMHTMLFrameElementClass = interface(DOMHTMLElementClass)
    ['{9008C82E-1AE5-4000-8A27-8C22A94C3923}']
  end;
  DOMHTMLFrameElement = interface(DOMHTMLElement)
    ['{895630EC-0BB3-4E4B-A25F-0C7C2403CEC2}']
    procedure setFrameBorder(frameBorder: NSString); cdecl;
    function frameBorder: NSString; cdecl;
    procedure setLongDesc(longDesc: NSString); cdecl;
    function longDesc: NSString; cdecl;
    procedure setMarginHeight(marginHeight: NSString); cdecl;
    function marginHeight: NSString; cdecl;
    procedure setMarginWidth(marginWidth: NSString); cdecl;
    function marginWidth: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setNoResize(noResize: Boolean); cdecl;
    function noResize: Boolean; cdecl;
    procedure setScrolling(scrolling: NSString); cdecl;
    function scrolling: NSString; cdecl;
    procedure setSrc(src: NSString); cdecl;
    function src: NSString; cdecl;
    function contentDocument: DOMDocument; cdecl;
    function contentWindow: DOMAbstractView; cdecl;
    procedure setLocation(location: NSString); cdecl;
    function location: NSString; cdecl;
    function width: Integer; cdecl;
    function height: Integer; cdecl;
    function contentFrame: WebFrame; cdecl;
  end;

  TDOMHTMLFrameElement = class(TOCGenericImport<DOMHTMLFrameElementClass, DOMHTMLFrameElement>)
  end;
  PDOMHTMLFrameElement = Pointer;

  DOMHTMLFrameSetElementClass = interface(DOMHTMLElementClass)
    ['{931F4D51-C477-4AD8-922B-336202760BFB}']
  end;
  DOMHTMLFrameSetElement = interface(DOMHTMLElement)
    ['{CF920861-BB3E-440D-A635-7536460194C5}']
    procedure setCols(cols: NSString); cdecl;
    function cols: NSString; cdecl;
    procedure setRows(rows: NSString); cdecl;
    function rows: NSString; cdecl;
  end;

  TDOMHTMLFrameSetElement = class(TOCGenericImport<DOMHTMLFrameSetElementClass, DOMHTMLFrameSetElement>)
  end;
  PDOMHTMLFrameSetElement = Pointer;

  DOMHTMLHRElementClass = interface(DOMHTMLElementClass)
    ['{F777ECAA-B8D5-4008-83D3-4CE165E54C47}']
  end;
  DOMHTMLHRElement = interface(DOMHTMLElement)
    ['{922F4A71-D319-4200-BF94-E6D5F88F3480}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setNoShade(noShade: Boolean); cdecl;
    function noShade: Boolean; cdecl;
    procedure setSize(size: NSString); cdecl;
    function size: NSString; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
  end;

  TDOMHTMLHRElement = class(TOCGenericImport<DOMHTMLHRElementClass, DOMHTMLHRElement>)
  end;
  PDOMHTMLHRElement = Pointer;

  DOMHTMLHeadElementClass = interface(DOMHTMLElementClass)
    ['{61EBA29B-64BF-4F0C-BF92-F8F17C0AC7BC}']
  end;
  DOMHTMLHeadElement = interface(DOMHTMLElement)
    ['{77BDBD57-9481-4589-BB0A-08AC9339072C}']
    procedure setProfile(profile: NSString); cdecl;
    function profile: NSString; cdecl;
  end;

  TDOMHTMLHeadElement = class(TOCGenericImport<DOMHTMLHeadElementClass, DOMHTMLHeadElement>)
  end;
  PDOMHTMLHeadElement = Pointer;

  DOMHTMLHeadingElementClass = interface(DOMHTMLElementClass)
    ['{CC0AE358-7180-444E-900E-B3F4DB3A4E8E}']
  end;
  DOMHTMLHeadingElement = interface(DOMHTMLElement)
    ['{CD05C2B2-3027-4638-858A-8606C5336754}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
  end;

  TDOMHTMLHeadingElement = class(TOCGenericImport<DOMHTMLHeadingElementClass, DOMHTMLHeadingElement>)
  end;
  PDOMHTMLHeadingElement = Pointer;

  DOMHTMLHtmlElementClass = interface(DOMHTMLElementClass)
    ['{E61DB7F3-760A-4B41-860F-BE4DDE71776A}']
  end;
  DOMHTMLHtmlElement = interface(DOMHTMLElement)
    ['{11C34BF9-D36F-440D-B404-7F9ABB490140}']
    procedure setVersion(version: NSString); cdecl;
    function version: NSString; cdecl;
  end;

  TDOMHTMLHtmlElement = class(TOCGenericImport<DOMHTMLHtmlElementClass, DOMHTMLHtmlElement>)
  end;
  PDOMHTMLHtmlElement = Pointer;

  DOMHTMLIFrameElementClass = interface(DOMHTMLElementClass)
    ['{AE62F146-9F83-40F3-B1BC-FDAE0C74F4B0}']
  end;
  DOMHTMLIFrameElement = interface(DOMHTMLElement)
    ['{AEBC5DF4-D2D1-4B5D-9B82-B51B00FE8081}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setFrameBorder(frameBorder: NSString); cdecl;
    function frameBorder: NSString; cdecl;
    procedure setHeight(height: NSString); cdecl;
    function height: NSString; cdecl;
    procedure setLongDesc(longDesc: NSString); cdecl;
    function longDesc: NSString; cdecl;
    procedure setMarginHeight(marginHeight: NSString); cdecl;
    function marginHeight: NSString; cdecl;
    procedure setMarginWidth(marginWidth: NSString); cdecl;
    function marginWidth: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setScrolling(scrolling: NSString); cdecl;
    function scrolling: NSString; cdecl;
    procedure setSrc(src: NSString); cdecl;
    function src: NSString; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
    function contentDocument: DOMDocument; cdecl;
    function contentWindow: DOMAbstractView; cdecl;
    function contentFrame: WebFrame; cdecl;
  end;

  TDOMHTMLIFrameElement = class(TOCGenericImport<DOMHTMLIFrameElementClass, DOMHTMLIFrameElement>)
  end;
  PDOMHTMLIFrameElement = Pointer;

  DOMHTMLImageElementClass = interface(DOMHTMLElementClass)
    ['{BD637C1C-1A2F-4FC8-9C7A-38F86B06EE02}']
  end;
  DOMHTMLImageElement = interface(DOMHTMLElement)
    ['{0EB3981D-64EE-424D-A13A-506D8AE849C4}']
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setAlt(alt: NSString); cdecl;
    function alt: NSString; cdecl;
    procedure setBorder(border: NSString); cdecl;
    function border: NSString; cdecl;
    procedure setHeight(height: Integer); cdecl;
    function height: Integer; cdecl;
    procedure setHspace(hspace: Integer); cdecl;
    function hspace: Integer; cdecl;
    procedure setIsMap(isMap: Boolean); cdecl;
    function isMap: Boolean; cdecl;
    procedure setLongDesc(longDesc: NSString); cdecl;
    function longDesc: NSString; cdecl;
    procedure setSrc(src: NSString); cdecl;
    function src: NSString; cdecl;
    procedure setUseMap(useMap: NSString); cdecl;
    function useMap: NSString; cdecl;
    procedure setVspace(vspace: Integer); cdecl;
    function vspace: Integer; cdecl;
    procedure setWidth(width: Integer); cdecl;
    function width: Integer; cdecl;
    function complete: Boolean; cdecl;
    procedure setLowsrc(lowsrc: NSString); cdecl;
    function lowsrc: NSString; cdecl;
    function naturalHeight: Integer; cdecl;
    function naturalWidth: Integer; cdecl;
    function x: Integer; cdecl;
    function y: Integer; cdecl;
    function altDisplayString: NSString; cdecl;
    function absoluteImageURL: NSURL; cdecl;
  end;

  TDOMHTMLImageElement = class(TOCGenericImport<DOMHTMLImageElementClass, DOMHTMLImageElement>)
  end;
  PDOMHTMLImageElement = Pointer;

  DOMHTMLInputElementClass = interface(DOMHTMLElementClass)
    ['{9F6637A3-3AA7-487B-AF7F-2FF256AE2602}']
  end;
  DOMHTMLInputElement = interface(DOMHTMLElement)
    ['{21047F6D-F222-4F71-A6DB-A2F196AC5D9A}']
    procedure setAccept(accept: NSString); cdecl;
    function accept: NSString; cdecl;
    procedure setAlt(alt: NSString); cdecl;
    function alt: NSString; cdecl;
    procedure setAutofocus(autofocus: Boolean); cdecl;
    function autofocus: Boolean; cdecl;
    procedure setDefaultChecked(defaultChecked: Boolean); cdecl;
    function defaultChecked: Boolean; cdecl;
    procedure setChecked(checked: Boolean); cdecl;
    function checked: Boolean; cdecl;
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    function form: DOMHTMLFormElement; cdecl;
    procedure setFiles(files: DOMFileList); cdecl;
    function files: DOMFileList; cdecl;
    procedure setIndeterminate(indeterminate: Boolean); cdecl;
    function indeterminate: Boolean; cdecl;
    procedure setMaxLength(maxLength: Integer); cdecl;
    function maxLength: Integer; cdecl;
    procedure setMultiple(multiple: Boolean); cdecl;
    function multiple: Boolean; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setReadOnly(readOnly: Boolean); cdecl;
    function readOnly: Boolean; cdecl;
    procedure setSize(size: NSString); cdecl;
    function size: NSString; cdecl;
    procedure setSrc(src: NSString); cdecl;
    function src: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setDefaultValue(defaultValue: NSString); cdecl;
    function defaultValue: NSString; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    function willValidate: Boolean; cdecl;
    procedure setSelectionStart(selectionStart: Integer); cdecl;
    function selectionStart: Integer; cdecl;
    procedure setSelectionEnd(selectionEnd: Integer); cdecl;
    function selectionEnd: Integer; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setUseMap(useMap: NSString); cdecl;
    function useMap: NSString; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
    function altDisplayString: NSString; cdecl;
    function absoluteImageURL: NSURL; cdecl;
    procedure select; cdecl;
    procedure setSelectionRange(start: Integer; &end: Integer); cdecl;
    procedure click; cdecl;
  end;

  TDOMHTMLInputElement = class(TOCGenericImport<DOMHTMLInputElementClass, DOMHTMLInputElement>)
  end;
  PDOMHTMLInputElement = Pointer;

  DOMHTMLLIElementClass = interface(DOMHTMLElementClass)
    ['{434F1BAA-0FB8-4A3B-8E8C-7BDF34FE8B0A}']
  end;
  DOMHTMLLIElement = interface(DOMHTMLElement)
    ['{4FFAFEB2-EAFB-42EA-98A4-39AF87EA3589}']
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setValue(value: Integer); cdecl;
    function value: Integer; cdecl;
  end;

  TDOMHTMLLIElement = class(TOCGenericImport<DOMHTMLLIElementClass, DOMHTMLLIElement>)
  end;
  PDOMHTMLLIElement = Pointer;

  DOMHTMLLabelElementClass = interface(DOMHTMLElementClass)
    ['{A948EB62-B0A8-4805-9B16-800EF14683D8}']
  end;
  DOMHTMLLabelElement = interface(DOMHTMLElement)
    ['{DB5E4181-7BA7-4E92-A60E-56D946B0E47B}']
    function form: DOMHTMLFormElement; cdecl;
    procedure setHtmlFor(htmlFor: NSString); cdecl;
    function htmlFor: NSString; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
  end;

  TDOMHTMLLabelElement = class(TOCGenericImport<DOMHTMLLabelElementClass, DOMHTMLLabelElement>)
  end;
  PDOMHTMLLabelElement = Pointer;

  DOMHTMLLegendElementClass = interface(DOMHTMLElementClass)
    ['{0D9A4C11-901F-4963-8AAB-F5F81E3A0404}']
  end;
  DOMHTMLLegendElement = interface(DOMHTMLElement)
    ['{7BB6548E-1C3F-4D43-BEEF-B62C0C83F088}']
    function form: DOMHTMLFormElement; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
  end;

  TDOMHTMLLegendElement = class(TOCGenericImport<DOMHTMLLegendElementClass, DOMHTMLLegendElement>)
  end;
  PDOMHTMLLegendElement = Pointer;

  DOMHTMLLinkElementClass = interface(DOMHTMLElementClass)
    ['{E5DEEC50-7177-46FF-AD48-E7B971B174A7}']
  end;
  DOMHTMLLinkElement = interface(DOMHTMLElement)
    ['{4ADB6288-40E9-42B4-ADA3-94C5589D62BA}']
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    procedure setCharset(charset: NSString); cdecl;
    function charset: NSString; cdecl;
    procedure setHref(href: NSString); cdecl;
    function href: NSString; cdecl;
    procedure setHreflang(hreflang: NSString); cdecl;
    function hreflang: NSString; cdecl;
    procedure setMedia(media: NSString); cdecl;
    function media: NSString; cdecl;
    procedure setRel(rel: NSString); cdecl;
    function rel: NSString; cdecl;
    procedure setRev(rev: NSString); cdecl;
    function rev: NSString; cdecl;
    procedure setTarget(target: NSString); cdecl;
    function target: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    function sheet: DOMStyleSheet; cdecl;
    function absoluteLinkURL: NSURL; cdecl;
  end;

  TDOMHTMLLinkElement = class(TOCGenericImport<DOMHTMLLinkElementClass, DOMHTMLLinkElement>)
  end;
  PDOMHTMLLinkElement = Pointer;

  DOMHTMLMapElementClass = interface(DOMHTMLElementClass)
    ['{96204DFD-C503-4D0F-983B-2BE10BB37C9D}']
  end;
  DOMHTMLMapElement = interface(DOMHTMLElement)
    ['{2A15E716-6C0A-4036-835C-EE8AF9C72D5D}']
    function areas: DOMHTMLCollection; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
  end;

  TDOMHTMLMapElement = class(TOCGenericImport<DOMHTMLMapElementClass, DOMHTMLMapElement>)
  end;
  PDOMHTMLMapElement = Pointer;

  DOMHTMLMarqueeElementClass = interface(DOMHTMLElementClass)
    ['{A7693DDC-F3AA-4A1F-9BE2-95BEF075C596}']
  end;
  DOMHTMLMarqueeElement = interface(DOMHTMLElement)
    ['{A1BB1143-A538-418F-B67C-335BD9191701}']
    procedure start; cdecl;
    procedure stop; cdecl;
  end;

  TDOMHTMLMarqueeElement = class(TOCGenericImport<DOMHTMLMarqueeElementClass, DOMHTMLMarqueeElement>)
  end;
  PDOMHTMLMarqueeElement = Pointer;

  DOMHTMLMenuElementClass = interface(DOMHTMLElementClass)
    ['{F4191F02-D73C-43CD-89E7-BD2B80C64732}']
  end;
  DOMHTMLMenuElement = interface(DOMHTMLElement)
    ['{40862FC1-A50A-45A1-A662-BC0F0EC0D390}']
    procedure setCompact(compact: Boolean); cdecl;
    function compact: Boolean; cdecl;
  end;

  TDOMHTMLMenuElement = class(TOCGenericImport<DOMHTMLMenuElementClass, DOMHTMLMenuElement>)
  end;
  PDOMHTMLMenuElement = Pointer;

  DOMHTMLMetaElementClass = interface(DOMHTMLElementClass)
    ['{497F45C4-4321-45BF-9F91-3A2FF467C6F2}']
  end;
  DOMHTMLMetaElement = interface(DOMHTMLElement)
    ['{F69FE1B5-EA54-49CE-ADC7-FF44084AAC09}']
    procedure setContent(content: NSString); cdecl;
    function content: NSString; cdecl;
    procedure setHttpEquiv(httpEquiv: NSString); cdecl;
    function httpEquiv: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setScheme(scheme: NSString); cdecl;
    function scheme: NSString; cdecl;
  end;

  TDOMHTMLMetaElement = class(TOCGenericImport<DOMHTMLMetaElementClass, DOMHTMLMetaElement>)
  end;
  PDOMHTMLMetaElement = Pointer;

  DOMHTMLModElementClass = interface(DOMHTMLElementClass)
    ['{71F183D8-F3F2-40B3-8A6A-AB69CC9F7F15}']
  end;
  DOMHTMLModElement = interface(DOMHTMLElement)
    ['{8CA09159-EC08-4EC7-8D0F-7EB0C1C29AA4}']
    procedure setCite(cite: NSString); cdecl;
    function cite: NSString; cdecl;
    procedure setDateTime(dateTime: NSString); cdecl;
    function dateTime: NSString; cdecl;
  end;

  TDOMHTMLModElement = class(TOCGenericImport<DOMHTMLModElementClass, DOMHTMLModElement>)
  end;
  PDOMHTMLModElement = Pointer;

  DOMHTMLOListElementClass = interface(DOMHTMLElementClass)
    ['{7E56DC57-E2DA-4BA0-9D0B-5CE8D7F2805A}']
  end;
  DOMHTMLOListElement = interface(DOMHTMLElement)
    ['{7DAAB384-16EC-4A3C-AFE0-6D17D8CEDADB}']
    procedure setCompact(compact: Boolean); cdecl;
    function compact: Boolean; cdecl;
    procedure setStart(start: Integer); cdecl;
    function start: Integer; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
  end;

  TDOMHTMLOListElement = class(TOCGenericImport<DOMHTMLOListElementClass, DOMHTMLOListElement>)
  end;
  PDOMHTMLOListElement = Pointer;

  DOMHTMLObjectElementClass = interface(DOMHTMLElementClass)
    ['{F996B940-DF33-455B-AC14-DB563CF62F83}']
  end;
  DOMHTMLObjectElement = interface(DOMHTMLElement)
    ['{AAB983C7-102C-4B87-8ED3-6D35983C43DD}']
    function form: DOMHTMLFormElement; cdecl;
    procedure setCode(code: NSString); cdecl;
    function code: NSString; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setArchive(archive: NSString); cdecl;
    function archive: NSString; cdecl;
    procedure setBorder(border: NSString); cdecl;
    function border: NSString; cdecl;
    procedure setCodeBase(codeBase: NSString); cdecl;
    function codeBase: NSString; cdecl;
    procedure setCodeType(codeType: NSString); cdecl;
    function codeType: NSString; cdecl;
    procedure setData(data: NSString); cdecl;
    function data: NSString; cdecl;
    procedure setDeclare(declare: Boolean); cdecl;
    function declare: Boolean; cdecl;
    procedure setHeight(height: NSString); cdecl;
    function height: NSString; cdecl;
    procedure setHspace(hspace: Integer); cdecl;
    function hspace: Integer; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setStandby(standby: NSString); cdecl;
    function standby: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setUseMap(useMap: NSString); cdecl;
    function useMap: NSString; cdecl;
    procedure setVspace(vspace: Integer); cdecl;
    function vspace: Integer; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
    function contentDocument: DOMDocument; cdecl;
    function absoluteImageURL: NSURL; cdecl;
    function contentFrame: WebFrame; cdecl;
  end;

  TDOMHTMLObjectElement = class(TOCGenericImport<DOMHTMLObjectElementClass, DOMHTMLObjectElement>)
  end;
  PDOMHTMLObjectElement = Pointer;

  DOMHTMLOptGroupElementClass = interface(DOMHTMLElementClass)
    ['{665CC346-DD65-46E8-8B9E-8E08E9A7D789}']
  end;
  DOMHTMLOptGroupElement = interface(DOMHTMLElement)
    ['{7609F31E-7F3C-4F33-BA94-786A39840346}']
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    procedure setLabel(&label: NSString); cdecl;
    function &label: NSString; cdecl;
  end;

  TDOMHTMLOptGroupElement = class(TOCGenericImport<DOMHTMLOptGroupElementClass, DOMHTMLOptGroupElement>)
  end;
  PDOMHTMLOptGroupElement = Pointer;

  DOMHTMLOptionElementClass = interface(DOMHTMLElementClass)
    ['{15DEBC88-FA45-478D-8F47-2F8834CBBB5B}']
  end;
  DOMHTMLOptionElement = interface(DOMHTMLElement)
    ['{C9C62C9C-AEFC-4A81-8ED7-C44331C9041B}']
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    function form: DOMHTMLFormElement; cdecl;
    procedure setLabel(&label: NSString); cdecl;
    function &label: NSString; cdecl;
    procedure setDefaultSelected(defaultSelected: Boolean); cdecl;
    function defaultSelected: Boolean; cdecl;
    procedure setSelected(selected: Boolean); cdecl;
    function selected: Boolean; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    function text: NSString; cdecl;
    function index: Integer; cdecl;
  end;

  TDOMHTMLOptionElement = class(TOCGenericImport<DOMHTMLOptionElementClass, DOMHTMLOptionElement>)
  end;
  PDOMHTMLOptionElement = Pointer;

  DOMHTMLOptionsCollectionClass = interface(DOMObjectClass)
    ['{FEBA47ED-46A5-4112-9D1F-F430F51D3931}']
  end;
  DOMHTMLOptionsCollection = interface(DOMObject)
    ['{00143DD0-5B87-4F4C-97B5-BC0A32253E11}']
    procedure setSelectedIndex(selectedIndex: Integer); cdecl;
    function selectedIndex: Integer; cdecl;
    procedure setLength(length: Cardinal); cdecl;
    function length: Cardinal; cdecl;
    function namedItem(name: NSString): DOMNode; cdecl;
    procedure add(option: DOMHTMLOptionElement; index: Cardinal); cdecl;
    procedure remove(index: Cardinal); cdecl;
    function item(index: Cardinal): DOMNode; cdecl;
  end;

  TDOMHTMLOptionsCollection = class(TOCGenericImport<DOMHTMLOptionsCollectionClass, DOMHTMLOptionsCollection>)
  end;
  PDOMHTMLOptionsCollection = Pointer;

  DOMHTMLParagraphElementClass = interface(DOMHTMLElementClass)
    ['{7073E3B4-6927-4C68-805E-05FCD97FF2B5}']
  end;
  DOMHTMLParagraphElement = interface(DOMHTMLElement)
    ['{434AF90A-8610-465A-B4E2-18E72A42F904}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
  end;

  TDOMHTMLParagraphElement = class(TOCGenericImport<DOMHTMLParagraphElementClass, DOMHTMLParagraphElement>)
  end;
  PDOMHTMLParagraphElement = Pointer;

  DOMHTMLParamElementClass = interface(DOMHTMLElementClass)
    ['{32202047-B42E-4E0B-B5E1-49CDB0472650}']
  end;
  DOMHTMLParamElement = interface(DOMHTMLElement)
    ['{A8C7EEC2-4F30-451E-B961-F5D8DB27777F}']
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    procedure setValueType(valueType: NSString); cdecl;
    function valueType: NSString; cdecl;
  end;

  TDOMHTMLParamElement = class(TOCGenericImport<DOMHTMLParamElementClass, DOMHTMLParamElement>)
  end;
  PDOMHTMLParamElement = Pointer;

  DOMHTMLPreElementClass = interface(DOMHTMLElementClass)
    ['{264128DE-417B-49E8-89B4-317448DC31BD}']
  end;
  DOMHTMLPreElement = interface(DOMHTMLElement)
    ['{BB6BD406-CEA3-4045-9D99-7565380259F0}']
    procedure setWidth(width: Integer); cdecl;
    function width: Integer; cdecl;
    procedure setWrap(wrap: Boolean); cdecl;
    function wrap: Boolean; cdecl;
  end;

  TDOMHTMLPreElement = class(TOCGenericImport<DOMHTMLPreElementClass, DOMHTMLPreElement>)
  end;
  PDOMHTMLPreElement = Pointer;

  DOMHTMLQuoteElementClass = interface(DOMHTMLElementClass)
    ['{9BA04CFC-CC18-43FD-8937-5DBF99CDEC13}']
  end;
  DOMHTMLQuoteElement = interface(DOMHTMLElement)
    ['{F311BACE-4BE7-444C-8488-674B49A88A2B}']
    procedure setCite(cite: NSString); cdecl;
    function cite: NSString; cdecl;
  end;

  TDOMHTMLQuoteElement = class(TOCGenericImport<DOMHTMLQuoteElementClass, DOMHTMLQuoteElement>)
  end;
  PDOMHTMLQuoteElement = Pointer;

  DOMHTMLScriptElementClass = interface(DOMHTMLElementClass)
    ['{320DA064-E085-4331-81EB-B14563E00966}']
  end;
  DOMHTMLScriptElement = interface(DOMHTMLElement)
    ['{62EC2D9A-02CA-416D-8E4B-2DA6691BB3F7}']
    procedure setText(text: NSString); cdecl;
    function text: NSString; cdecl;
    procedure setHtmlFor(htmlFor: NSString); cdecl;
    function htmlFor: NSString; cdecl;
    procedure setEvent(event: NSString); cdecl;
    function event: NSString; cdecl;
    procedure setCharset(charset: NSString); cdecl;
    function charset: NSString; cdecl;
    procedure setDefer(defer: Boolean); cdecl;
    function defer: Boolean; cdecl;
    procedure setSrc(src: NSString); cdecl;
    function src: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
  end;

  TDOMHTMLScriptElement = class(TOCGenericImport<DOMHTMLScriptElementClass, DOMHTMLScriptElement>)
  end;
  PDOMHTMLScriptElement = Pointer;

  DOMHTMLSelectElementClass = interface(DOMHTMLElementClass)
    ['{6C4D7B5B-3BD6-49A3-B990-3C60E99535B9}']
  end;
  DOMHTMLSelectElement = interface(DOMHTMLElement)
    ['{F1EAAD72-FC8C-4465-B6BF-5B13AF373F6F}']
    procedure setAutofocus(autofocus: Boolean); cdecl;
    function autofocus: Boolean; cdecl;
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    function form: DOMHTMLFormElement; cdecl;
    procedure setMultiple(multiple: Boolean); cdecl;
    function multiple: Boolean; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setSize(size: Integer); cdecl;
    function size: Integer; cdecl;
    function &type: NSString; cdecl;
    function options: DOMHTMLOptionsCollection; cdecl;
    function length: Integer; cdecl;
    procedure setSelectedIndex(selectedIndex: Integer); cdecl;
    function selectedIndex: Integer; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    function willValidate: Boolean; cdecl;
    function item(index: Cardinal): DOMNode; cdecl;
    function namedItem(name: NSString): DOMNode; cdecl;
    [MethodName('add:before:')]
    procedure addBefore(element: DOMHTMLElement; before: DOMHTMLElement); cdecl;
    procedure remove(index: Integer); cdecl;
    [MethodName('add::')]
    procedure add(element: DOMHTMLElement; before: DOMHTMLElement); cdecl;
  end;

  TDOMHTMLSelectElement = class(TOCGenericImport<DOMHTMLSelectElementClass, DOMHTMLSelectElement>)
  end;
  PDOMHTMLSelectElement = Pointer;

  DOMHTMLStyleElementClass = interface(DOMHTMLElementClass)
    ['{50458F82-03B8-4005-94A6-5C0F8BA5FB29}']
  end;
  DOMHTMLStyleElement = interface(DOMHTMLElement)
    ['{A85D1D13-917C-471D-BA4C-613EC527C1E3}']
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    procedure setMedia(media: NSString); cdecl;
    function media: NSString; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
    function sheet: DOMStyleSheet; cdecl;
  end;

  TDOMHTMLStyleElement = class(TOCGenericImport<DOMHTMLStyleElementClass, DOMHTMLStyleElement>)
  end;
  PDOMHTMLStyleElement = Pointer;

  DOMHTMLTableCaptionElementClass = interface(DOMHTMLElementClass)
    ['{32DD0D12-9547-4E97-93EB-1D273E259AF5}']
  end;
  DOMHTMLTableCaptionElement = interface(DOMHTMLElement)
    ['{00B0CF6B-2B9D-4147-9E53-A08D27B9E446}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
  end;

  TDOMHTMLTableCaptionElement = class(TOCGenericImport<DOMHTMLTableCaptionElementClass, DOMHTMLTableCaptionElement>)
  end;
  PDOMHTMLTableCaptionElement = Pointer;

  DOMHTMLTableCellElementClass = interface(DOMHTMLElementClass)
    ['{D7E162D5-A686-4620-AFFC-495AB77639D5}']
  end;
  DOMHTMLTableCellElement = interface(DOMHTMLElement)
    ['{6F9CB607-762E-4807-9E27-996D1D63C8A1}']
    function cellIndex: Integer; cdecl;
    procedure setAbbr(abbr: NSString); cdecl;
    function abbr: NSString; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setAxis(axis: NSString); cdecl;
    function axis: NSString; cdecl;
    procedure setBgColor(bgColor: NSString); cdecl;
    function bgColor: NSString; cdecl;
    procedure setCh(ch: NSString); cdecl;
    function ch: NSString; cdecl;
    procedure setChOff(chOff: NSString); cdecl;
    function chOff: NSString; cdecl;
    procedure setColSpan(colSpan: Integer); cdecl;
    function colSpan: Integer; cdecl;
    procedure setHeaders(headers: NSString); cdecl;
    function headers: NSString; cdecl;
    procedure setHeight(height: NSString); cdecl;
    function height: NSString; cdecl;
    procedure setNoWrap(noWrap: Boolean); cdecl;
    function noWrap: Boolean; cdecl;
    procedure setRowSpan(rowSpan: Integer); cdecl;
    function rowSpan: Integer; cdecl;
    procedure setScope(scope: NSString); cdecl;
    function scope: NSString; cdecl;
    procedure setVAlign(vAlign: NSString); cdecl;
    function vAlign: NSString; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
  end;

  TDOMHTMLTableCellElement = class(TOCGenericImport<DOMHTMLTableCellElementClass, DOMHTMLTableCellElement>)
  end;
  PDOMHTMLTableCellElement = Pointer;

  DOMHTMLTableColElementClass = interface(DOMHTMLElementClass)
    ['{B1316F3F-C012-4F76-A7D7-BECB884D5D30}']
  end;
  DOMHTMLTableColElement = interface(DOMHTMLElement)
    ['{B94D0765-BDBA-4F43-BA90-9B41BDC19BD1}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setCh(ch: NSString); cdecl;
    function ch: NSString; cdecl;
    procedure setChOff(chOff: NSString); cdecl;
    function chOff: NSString; cdecl;
    procedure setSpan(span: Integer); cdecl;
    function span: Integer; cdecl;
    procedure setVAlign(vAlign: NSString); cdecl;
    function vAlign: NSString; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
  end;

  TDOMHTMLTableColElement = class(TOCGenericImport<DOMHTMLTableColElementClass, DOMHTMLTableColElement>)
  end;
  PDOMHTMLTableColElement = Pointer;

  DOMHTMLTableSectionElementClass = interface(DOMHTMLElementClass)
    ['{C753885D-6F56-4427-B2FC-618FB19B7B05}']
  end;
  DOMHTMLTableSectionElement = interface(DOMHTMLElement)
    ['{0FE10E66-68DA-4924-9336-1E94F3401F1A}']
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setCh(ch: NSString); cdecl;
    function ch: NSString; cdecl;
    procedure setChOff(chOff: NSString); cdecl;
    function chOff: NSString; cdecl;
    procedure setVAlign(vAlign: NSString); cdecl;
    function vAlign: NSString; cdecl;
    function rows: DOMHTMLCollection; cdecl;
    function insertRow(index: Integer): DOMHTMLElement; cdecl;
    procedure deleteRow(index: Integer); cdecl;
  end;

  TDOMHTMLTableSectionElement = class(TOCGenericImport<DOMHTMLTableSectionElementClass, DOMHTMLTableSectionElement>)
  end;
  PDOMHTMLTableSectionElement = Pointer;

  DOMHTMLTableElementClass = interface(DOMHTMLElementClass)
    ['{BF594318-33CD-46AE-A84B-CC8C6B33AE8B}']
  end;
  DOMHTMLTableElement = interface(DOMHTMLElement)
    ['{A5D8E3B9-2463-4DB5-B356-F29364CEB62C}']
    procedure setCaption(caption: DOMHTMLTableCaptionElement); cdecl;
    function caption: DOMHTMLTableCaptionElement; cdecl;
    procedure setTHead(tHead: DOMHTMLTableSectionElement); cdecl;
    function tHead: DOMHTMLTableSectionElement; cdecl;
    procedure setTFoot(tFoot: DOMHTMLTableSectionElement); cdecl;
    function tFoot: DOMHTMLTableSectionElement; cdecl;
    function rows: DOMHTMLCollection; cdecl;
    function tBodies: DOMHTMLCollection; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setBgColor(bgColor: NSString); cdecl;
    function bgColor: NSString; cdecl;
    procedure setBorder(border: NSString); cdecl;
    function border: NSString; cdecl;
    procedure setCellPadding(cellPadding: NSString); cdecl;
    function cellPadding: NSString; cdecl;
    procedure setCellSpacing(cellSpacing: NSString); cdecl;
    function cellSpacing: NSString; cdecl;
    procedure setFrameBorders(frameBorders: NSString); cdecl;
    function frameBorders: NSString; cdecl;
    procedure setRules(rules: NSString); cdecl;
    function rules: NSString; cdecl;
    procedure setSummary(summary: NSString); cdecl;
    function summary: NSString; cdecl;
    procedure setWidth(width: NSString); cdecl;
    function width: NSString; cdecl;
    function createTHead: DOMHTMLElement; cdecl;
    procedure deleteTHead; cdecl;
    function createTFoot: DOMHTMLElement; cdecl;
    procedure deleteTFoot; cdecl;
    function createCaption: DOMHTMLElement; cdecl;
    procedure deleteCaption; cdecl;
    function insertRow(index: Integer): DOMHTMLElement; cdecl;
    procedure deleteRow(index: Integer); cdecl;
  end;

  TDOMHTMLTableElement = class(TOCGenericImport<DOMHTMLTableElementClass, DOMHTMLTableElement>)
  end;
  PDOMHTMLTableElement = Pointer;

  DOMHTMLTableRowElementClass = interface(DOMHTMLElementClass)
    ['{DBC61AD2-C98D-4A27-8444-4324417C7841}']
  end;
  DOMHTMLTableRowElement = interface(DOMHTMLElement)
    ['{16096B60-417E-4D79-8214-1C874B87760D}']
    function rowIndex: Integer; cdecl;
    function sectionRowIndex: Integer; cdecl;
    function cells: DOMHTMLCollection; cdecl;
    procedure setAlign(align: NSString); cdecl;
    function align: NSString; cdecl;
    procedure setBgColor(bgColor: NSString); cdecl;
    function bgColor: NSString; cdecl;
    procedure setCh(ch: NSString); cdecl;
    function ch: NSString; cdecl;
    procedure setChOff(chOff: NSString); cdecl;
    function chOff: NSString; cdecl;
    procedure setVAlign(vAlign: NSString); cdecl;
    function vAlign: NSString; cdecl;
    function insertCell(index: Integer): DOMHTMLElement; cdecl;
    procedure deleteCell(index: Integer); cdecl;
  end;

  TDOMHTMLTableRowElement = class(TOCGenericImport<DOMHTMLTableRowElementClass, DOMHTMLTableRowElement>)
  end;
  PDOMHTMLTableRowElement = Pointer;

  DOMHTMLTextAreaElementClass = interface(DOMHTMLElementClass)
    ['{DA59881C-7C9D-4166-BD01-B577054BFC0F}']
  end;
  DOMHTMLTextAreaElement = interface(DOMHTMLElement)
    ['{62279298-5C0F-4E70-976A-501763ADE772}']
    procedure setAutofocus(autofocus: Boolean); cdecl;
    function autofocus: Boolean; cdecl;
    procedure setCols(cols: Integer); cdecl;
    function cols: Integer; cdecl;
    procedure setDisabled(disabled: Boolean); cdecl;
    function disabled: Boolean; cdecl;
    function form: DOMHTMLFormElement; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setReadOnly(readOnly: Boolean); cdecl;
    function readOnly: Boolean; cdecl;
    procedure setRows(rows: Integer); cdecl;
    function rows: Integer; cdecl;
    function &type: NSString; cdecl;
    procedure setDefaultValue(defaultValue: NSString); cdecl;
    function defaultValue: NSString; cdecl;
    procedure setValue(value: NSString); cdecl;
    function value: NSString; cdecl;
    function willValidate: Boolean; cdecl;
    procedure setSelectionStart(selectionStart: Integer); cdecl;
    function selectionStart: Integer; cdecl;
    procedure setSelectionEnd(selectionEnd: Integer); cdecl;
    function selectionEnd: Integer; cdecl;
    procedure setAccessKey(accessKey: NSString); cdecl;
    function accessKey: NSString; cdecl;
    procedure select; cdecl;
    procedure setSelectionRange(start: Integer; &end: Integer); cdecl;
  end;

  TDOMHTMLTextAreaElement = class(TOCGenericImport<DOMHTMLTextAreaElementClass, DOMHTMLTextAreaElement>)
  end;
  PDOMHTMLTextAreaElement = Pointer;

  DOMHTMLTitleElementClass = interface(DOMHTMLElementClass)
    ['{FF489215-8E8E-4923-A4DC-5643A95439D3}']
  end;
  DOMHTMLTitleElement = interface(DOMHTMLElement)
    ['{C69B9D8C-4E16-4181-AFCE-0BDA9956FD1F}']
    procedure setText(text: NSString); cdecl;
    function text: NSString; cdecl;
  end;

  TDOMHTMLTitleElement = class(TOCGenericImport<DOMHTMLTitleElementClass, DOMHTMLTitleElement>)
  end;
  PDOMHTMLTitleElement = Pointer;

  DOMHTMLUListElementClass = interface(DOMHTMLElementClass)
    ['{B46FF13B-68AF-4F42-AFB2-6748FD312774}']
  end;
  DOMHTMLUListElement = interface(DOMHTMLElement)
    ['{4BFBB5DA-70EC-4FC2-BCC3-8163293AC2A0}']
    procedure setCompact(compact: Boolean); cdecl;
    function compact: Boolean; cdecl;
    procedure setType(&type: NSString); cdecl;
    function &type: NSString; cdecl;
  end;

  TDOMHTMLUListElement = class(TOCGenericImport<DOMHTMLUListElementClass, DOMHTMLUListElement>)
  end;
  PDOMHTMLUListElement = Pointer;

  DOMUIEventClass = interface(DOMEventClass)
    ['{C51BE23E-09B5-4731-83B9-B6DA442A0F80}']
  end;
  DOMUIEvent = interface(DOMEvent)
    ['{901764AA-3A7E-4EEE-AC4A-739BC86735C5}']
    function view: DOMAbstractView; cdecl;
    function detail: Integer; cdecl;
    function keyCode: Integer; cdecl;
    function charCode: Integer; cdecl;
    function layerX: Integer; cdecl;
    function layerY: Integer; cdecl;
    function pageX: Integer; cdecl;
    function pageY: Integer; cdecl;
    function which: Integer; cdecl;
    [MethodName('initUIEvent:canBubble:cancelable:view:detail:')]
    procedure initUIEventCanBubbleCancelableViewDetail(&type: NSString; canBubble: Boolean; cancelable: Boolean;
      view: DOMAbstractView; detail: Integer); cdecl;
    [MethodName('initUIEvent:::::')]
    procedure initUIEvent(&type: NSString; canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView;
      detail: Integer); cdecl;
  end;

  TDOMUIEvent = class(TOCGenericImport<DOMUIEventClass, DOMUIEvent>)
  end;
  PDOMUIEvent = Pointer;

  DOMKeyboardEventClass = interface(DOMUIEventClass)
    ['{BFF42D97-CF59-435E-8296-D68164BB34FD}']
  end;
  DOMKeyboardEvent = interface(DOMUIEvent)
    ['{297B43F1-2661-46CA-B8F3-09BB1A521D1A}']
    function keyIdentifier: NSString; cdecl;
    function location: Cardinal; cdecl;
    function keyLocation: Cardinal; cdecl;
    function ctrlKey: Boolean; cdecl;
    function shiftKey: Boolean; cdecl;
    function altKey: Boolean; cdecl;
    function metaKey: Boolean; cdecl;
    function altGraphKey: Boolean; cdecl;
    function keyCode: Integer; cdecl;
    function charCode: Integer; cdecl;
    function getModifierState(keyIdentifierArg: NSString): Boolean; cdecl;
    [MethodName
      ('initKeyboardEvent:canBubble:cancelable:view:keyIdentifier:location:ctrlKey:altKey:shiftKey:metaKey:altGraphKey:')
      ]
    procedure initKeyboardEventCanBubbleCancelableViewKeyIdentifierLocationCtrlKeyAltKeyShiftKeyMetaKeyAltGraphKey
      (&type: NSString; canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView; keyIdentifier: NSString;
      location: Cardinal; ctrlKey: Boolean; altKey: Boolean; shiftKey: Boolean; metaKey: Boolean;
      altGraphKey: Boolean); cdecl;
    [MethodName('initKeyboardEvent:canBubble:cancelable:view:keyIdentifier:location:ctrlKey:altKey:shiftKey:metaKey:')]
    procedure initKeyboardEventCanBubbleCancelableViewKeyIdentifierLocationCtrlKeyAltKeyShiftKeyMetaKey(&type: NSString;
      canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView; keyIdentifier: NSString; location: Cardinal;
      ctrlKey: Boolean; altKey: Boolean; shiftKey: Boolean; metaKey: Boolean); cdecl;
    [MethodName
      ('initKeyboardEvent:canBubble:cancelable:view:keyIdentifier:keyLocation:ctrlKey:altKey:shiftKey:metaKey:altGraphKey:')
      ]
    procedure initKeyboardEventCanBubbleCancelableViewKeyIdentifierKeyLocationCtrlKeyAltKeyShiftKeyMetaKeyAltGraphKey
      (&type: NSString; canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView; keyIdentifier: NSString;
      keyLocation: Cardinal; ctrlKey: Boolean; altKey: Boolean; shiftKey: Boolean; metaKey: Boolean;
      altGraphKey: Boolean); cdecl;
    [MethodName
      ('initKeyboardEvent:canBubble:cancelable:view:keyIdentifier:keyLocation:ctrlKey:altKey:shiftKey:metaKey:')]
    procedure initKeyboardEventCanBubbleCancelableViewKeyIdentifierKeyLocationCtrlKeyAltKeyShiftKeyMetaKey
      (&type: NSString; canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView; keyIdentifier: NSString;
      keyLocation: Cardinal; ctrlKey: Boolean; altKey: Boolean; shiftKey: Boolean; metaKey: Boolean); cdecl;
  end;

  TDOMKeyboardEvent = class(TOCGenericImport<DOMKeyboardEventClass, DOMKeyboardEvent>)
  end;
  PDOMKeyboardEvent = Pointer;

  DOMMouseEventClass = interface(DOMUIEventClass)
    ['{FF61937F-0012-482D-A119-A90A5A4D6DF8}']
  end;
  DOMMouseEvent = interface(DOMUIEvent)
    ['{9CBC6EE9-6716-4849-9EB5-0FF35C5838B2}']
    function screenX: Integer; cdecl;
    function screenY: Integer; cdecl;
    function clientX: Integer; cdecl;
    function clientY: Integer; cdecl;
    function ctrlKey: Boolean; cdecl;
    function shiftKey: Boolean; cdecl;
    function altKey: Boolean; cdecl;
    function metaKey: Boolean; cdecl;
    function button: Word; cdecl;
    function relatedTarget: Pointer; cdecl;
    function offsetX: Integer; cdecl;
    function offsetY: Integer; cdecl;
    function x: Integer; cdecl;
    function y: Integer; cdecl;
    function fromElement: DOMNode; cdecl;
    function toElement: DOMNode; cdecl;
    [MethodName
      ('initMouseEvent:canBubble:cancelable:view:detail:screenX:screenY:clientX:clientY:ctrlKey:altKey:shiftKey:metaKey:button:relatedTarget:')
      ]
    procedure initMouseEventCanBubbleCancelableViewDetailScreenXScreenYClientXClientYCtrlKeyAltKeyShiftKeyMetaKeyButtonRelatedTarget
      (&type: NSString; canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView; detail: Integer;
      screenX: Integer; screenY: Integer; clientX: Integer; clientY: Integer; ctrlKey: Boolean; altKey: Boolean;
      shiftKey: Boolean; metaKey: Boolean; button: Word; relatedTarget: Pointer); cdecl;
    [MethodName('initMouseEvent:::::::::::::::')]
    procedure initMouseEvent(&type: NSString; canBubble: Boolean; cancelable: Boolean; view: DOMAbstractView;
      detail: Integer; screenX: Integer; screenY: Integer; clientX: Integer; clientY: Integer; ctrlKey: Boolean;
      altKey: Boolean; shiftKey: Boolean; metaKey: Boolean; button: Word; relatedTarget: Pointer); cdecl;
  end;

  TDOMMouseEvent = class(TOCGenericImport<DOMMouseEventClass, DOMMouseEvent>)
  end;
  PDOMMouseEvent = Pointer;

  DOMMutationEventClass = interface(DOMEventClass)
    ['{3488604C-1B95-459D-9A6F-01FA60419088}']
  end;
  DOMMutationEvent = interface(DOMEvent)
    ['{B0F986CD-2D02-4450-BCA8-5EF7603C638C}']
    function relatedNode: DOMNode; cdecl;
    function prevValue: NSString; cdecl;
    function newValue: NSString; cdecl;
    function attrName: NSString; cdecl;
    function attrChange: Word; cdecl;
    [MethodName('initMutationEvent:canBubble:cancelable:relatedNode:prevValue:newValue:attrName:attrChange:')]
    procedure initMutationEventCanBubbleCancelableRelatedNodePrevValueNewValueAttrNameAttrChange(&type: NSString;
      canBubble: Boolean; cancelable: Boolean; relatedNode: DOMNode; prevValue: NSString; newValue: NSString;
      attrName: NSString; attrChange: Word); cdecl;
    [MethodName('initMutationEvent::::::::')]
    procedure initMutationEvent(&type: NSString; canBubble: Boolean; cancelable: Boolean; relatedNode: DOMNode;
      prevValue: NSString; newValue: NSString; attrName: NSString; attrChange: Word); cdecl;
  end;

  TDOMMutationEvent = class(TOCGenericImport<DOMMutationEventClass, DOMMutationEvent>)
  end;
  PDOMMutationEvent = Pointer;

  DOMOverflowEventClass = interface(DOMEventClass)
    ['{B40FD2C0-4699-4D37-B007-11579627EF4F}']
  end;
  DOMOverflowEvent = interface(DOMEvent)
    ['{F41032F6-F8D2-4014-8137-F53CEEFE5FAA}']
    function orient: Word; cdecl;
    function horizontalOverflow: Boolean; cdecl;
    function verticalOverflow: Boolean; cdecl;
    procedure initOverflowEvent(orient: Word; horizontalOverflow: Boolean; verticalOverflow: Boolean); cdecl;
  end;

  TDOMOverflowEvent = class(TOCGenericImport<DOMOverflowEventClass, DOMOverflowEvent>)
  end;
  PDOMOverflowEvent = Pointer;

  DOMProgressEventClass = interface(DOMEventClass)
    ['{0C4A0970-51FB-4E8A-9CD9-6F0D9C8D887E}']
  end;
  DOMProgressEvent = interface(DOMEvent)
    ['{61747C94-FF9A-4A52-AC37-391DE475B365}']
    function lengthComputable: Boolean; cdecl;
    function loaded: UInt64; cdecl;
    function total: UInt64; cdecl;
  end;

  TDOMProgressEvent = class(TOCGenericImport<DOMProgressEventClass, DOMProgressEvent>)
  end;
  PDOMProgressEvent = Pointer;

  DOMWheelEventClass = interface(DOMMouseEventClass)
    ['{FAD77A55-472C-44F7-8D2A-A237C263FCD3}']
  end;
  DOMWheelEvent = interface(DOMMouseEvent)
    ['{1361CCD2-5EA3-4165-9977-126C19B6FE4A}']
    function wheelDeltaX: Integer; cdecl;
    function wheelDeltaY: Integer; cdecl;
    function wheelDelta: Integer; cdecl;
    function isHorizontal: Boolean; cdecl;
    procedure initWheelEvent(wheelDeltaX: Integer; wheelDeltaY: Integer; view: DOMAbstractView; screenX: Integer;
      screenY: Integer; clientX: Integer; clientY: Integer; ctrlKey: Boolean; altKey: Boolean; shiftKey: Boolean;
      metaKey: Boolean); cdecl;
  end;

  TDOMWheelEvent = class(TOCGenericImport<DOMWheelEventClass, DOMWheelEvent>)
  end;
  PDOMWheelEvent = Pointer;

  WebResourceClass = interface(NSObjectClass)
    ['{7A31EA15-24F9-4CC1-9D12-1AB2AE57EF9B}']
  end;
  WebResource = interface(NSObject)
    ['{08A1FCFF-9CDA-4B3E-9F4C-0BC24F79182E}']
    function initWithData(data: NSData; URL: NSURL; MIMEType: NSString; textEncodingName: NSString; frameName: NSString)
      : Pointer {instancetype}; cdecl;
    function data: NSData; cdecl;
    function URL: NSURL; cdecl;
    function MIMEType: NSString; cdecl;
    function textEncodingName: NSString; cdecl;
    function frameName: NSString; cdecl;
  end;

  TWebResource = class(TOCGenericImport<WebResourceClass, WebResource>)
  end;
  PWebResource = Pointer;

  WebArchiveClass = interface(NSObjectClass)
    ['{07B7C67E-4E15-4042-8481-1940B8618433}']
  end;
  WebArchive = interface(NSObject)
    ['{2F1073AD-3AAE-474B-9D33-52D42FA94A50}']
    function initWithMainResource(mainResource: WebResource; subresources: NSArray; subframeArchives: NSArray)
      : Pointer {instancetype}; cdecl;
    function initWithData(data: NSData): Pointer {instancetype}; cdecl;
    function mainResource: WebResource; cdecl;
    function subresources: NSArray; cdecl;
    function subframeArchives: NSArray; cdecl;
    function data: NSData; cdecl;
  end;

  TWebArchive = class(TOCGenericImport<WebArchiveClass, WebArchive>)
  end;
  PWebArchive = Pointer;

  WebHistoryItemClass = interface(NSObjectClass)
    ['{914B6D22-B37A-4131-A48A-0D433A94C982}']
  end;
  WebHistoryItem = interface(NSObject)
    ['{9177B5B3-0833-4306-996F-A6B675656565}']
    function initWithURLString(URLString: NSString; title: NSString; lastVisitedTimeInterval: NSTimeInterval)
      : Pointer {instancetype}; cdecl;
    function originalURLString: NSString; cdecl;
    function URLString: NSString; cdecl;
    function title: NSString; cdecl;
    function lastVisitedTimeInterval: NSTimeInterval; cdecl;
    procedure setAlternateTitle(alternateTitle: NSString); cdecl;
    function alternateTitle: NSString; cdecl;
    function icon: NSImage; cdecl;
  end;

  TWebHistoryItem = class(TOCGenericImport<WebHistoryItemClass, WebHistoryItem>)
  end;
  PWebHistoryItem = Pointer;

  WebBackForwardListClass = interface(NSObjectClass)
    ['{5CD2073A-9A38-4905-ABCF-BBDFFE0E7FF4}']
  end;
  WebBackForwardList = interface(NSObject)
    ['{E7CEA76E-7C68-49B8-ABD2-FAA8A284604B}']
    procedure addItem(item: WebHistoryItem); cdecl;
    procedure goBack; cdecl;
    procedure goForward; cdecl;
    procedure goToItem(item: WebHistoryItem); cdecl;
    function backItem: WebHistoryItem; cdecl;
    function currentItem: WebHistoryItem; cdecl;
    function forwardItem: WebHistoryItem; cdecl;
    function backListWithLimit(limit: Integer): NSArray; cdecl;
    function forwardListWithLimit(limit: Integer): NSArray; cdecl;
    procedure setCapacity(capacity: Integer); cdecl;
    function capacity: Integer; cdecl;
    function backListCount: Integer; cdecl;
    function forwardListCount: Integer; cdecl;
    function containsItem(item: WebHistoryItem): Boolean; cdecl;
    function itemAtIndex(index: Integer): WebHistoryItem; cdecl;
    procedure setPageCacheSize(size: NSUInteger); cdecl;
    function pageCacheSize: NSUInteger; cdecl;
  end;

  TWebBackForwardList = class(TOCGenericImport<WebBackForwardListClass, WebBackForwardList>)
  end;
  PWebBackForwardList = Pointer;

  WebDataSourceClass = interface(NSObjectClass)
    ['{6C8CBBE8-2433-4C09-8EAD-6EEED8F97162}']
  end;
  WebDataSource = interface(NSObject)
    ['{453D2170-D9DE-495C-910A-C055B8207279}']
    function initWithRequest(request: NSURLRequest): Pointer {instancetype}; cdecl;
    function data: NSData; cdecl;
    function representation: Pointer; cdecl;
    function WebFrame: WebFrame; cdecl;
    function initialRequest: NSURLRequest; cdecl;
    function request: NSMutableURLRequest; cdecl;
    function response: NSURLResponse; cdecl;
    function textEncodingName: NSString; cdecl;
    function isLoading: Boolean; cdecl;
    function pageTitle: NSString; cdecl;
    function unreachableURL: NSURL; cdecl;
    function WebArchive: WebArchive; cdecl;
    function mainResource: WebResource; cdecl;
    function subresources: NSArray; cdecl;
    function subresourceForURL(URL: NSURL): WebResource; cdecl;
    procedure addSubresource(subresource: WebResource); cdecl;
  end;

  TWebDataSource = class(TOCGenericImport<WebDataSourceClass, WebDataSource>)
  end;
  PWebDataSource = Pointer;

  WebDownloadClass = interface(NSURLDownloadClass)
    ['{E9710246-5A00-4455-964B-0248119BA540}']
  end;
  WebDownload = interface(NSURLDownload)
    ['{B83A8511-2A8D-478E-9431-2C99EE08A309}']
  end;

  TWebDownload = class(TOCGenericImport<WebDownloadClass, WebDownload>)
  end;
  PWebDownload = Pointer;

  WebDownloadDelegate = interface(IObjectiveC)
    ['{7D9B798E-600E-41A3-8606-97BECC00312F}']
    function downloadWindowForAuthenticationSheet(download: WebDownload): NSWindow; cdecl;
  end;

  WebViewClass = interface(NSViewClass)
    ['{F3B15A49-8BE1-4B96-AD9F-4B7A3FF38E33}']
    {class} function canShowMIMEType(MIMEType: NSString): Boolean; cdecl;
    {class} function canShowMIMETypeAsHTML(MIMEType: NSString): Boolean; cdecl;
    {class} function MIMETypesShownAsHTML: NSArray; cdecl;
    {class} procedure setMIMETypesShownAsHTML(MIMETypes: NSArray); cdecl;
    {class} function URLFromPasteboard(pasteboard: NSPasteboard): NSURL; cdecl;
    {class} function URLTitleFromPasteboard(pasteboard: NSPasteboard): NSString; cdecl;
    {class} procedure registerURLSchemeAsLocal(scheme: NSString); cdecl;
    {class} procedure registerViewClass(viewClass: Pointer; representationClass: Pointer; forMIMEType: NSString); cdecl;
  end;
  WebView = interface(NSView)
    ['{7E6F592D-7257-4073-B615-16976412ECDE}']
    function initWithFrame(frame: NSRect; frameName: NSString; groupName: NSString): Pointer {instancetype}; cdecl;
    procedure close; cdecl;
    procedure setShouldCloseWithWindow(shouldCloseWithWindow: Boolean); cdecl;
    function shouldCloseWithWindow: Boolean; cdecl;
    procedure setUIDelegate(UIDelegate: Pointer); cdecl;
    function UIDelegate: Pointer; cdecl;
    procedure setResourceLoadDelegate(resourceLoadDelegate: Pointer); cdecl;
    function resourceLoadDelegate: Pointer; cdecl;
    procedure setDownloadDelegate(downloadDelegate: Pointer); cdecl;
    function downloadDelegate: Pointer; cdecl;
    procedure setFrameLoadDelegate(frameLoadDelegate: Pointer); cdecl;
    function frameLoadDelegate: Pointer; cdecl;
    procedure setPolicyDelegate(policyDelegate: Pointer); cdecl;
    function policyDelegate: Pointer; cdecl;
    function mainFrame: WebFrame; cdecl;
    function selectedFrame: WebFrame; cdecl;
    function backForwardList: WebBackForwardList; cdecl;
    procedure setMaintainsBackForwardList(flag: Boolean); cdecl;
    [MethodName('goBack')]
    function goBack: Boolean; cdecl; overload;
    [MethodName('goForward')]
    function goForward: Boolean; cdecl; overload;
    function goToBackForwardItem(item: WebHistoryItem): Boolean; cdecl;
    procedure setTextSizeMultiplier(textSizeMultiplier: Single); cdecl;
    function textSizeMultiplier: Single; cdecl;
    procedure setApplicationNameForUserAgent(applicationNameForUserAgent: NSString); cdecl;
    function applicationNameForUserAgent: NSString; cdecl;
    procedure setCustomUserAgent(customUserAgent: NSString); cdecl;
    function customUserAgent: NSString; cdecl;
    function userAgentForURL(URL: NSURL): NSString; cdecl;
    function supportsTextEncoding: Boolean; cdecl;
    procedure setCustomTextEncodingName(customTextEncodingName: NSString); cdecl;
    function customTextEncodingName: NSString; cdecl;
    procedure setMediaStyle(mediaStyle: NSString); cdecl;
    function mediaStyle: NSString; cdecl;
    function stringByEvaluatingJavaScriptFromString(script: NSString): NSString; cdecl;
    function windowScriptObject: WebScriptObject; cdecl;
    procedure setPreferences(preferences: WebPreferences); cdecl;
    function preferences: WebPreferences; cdecl;
    procedure setPreferencesIdentifier(preferencesIdentifier: NSString); cdecl;
    function preferencesIdentifier: NSString; cdecl;
    procedure setHostWindow(hostWindow: NSWindow); cdecl;
    function hostWindow: NSWindow; cdecl;
    function searchFor(&string: NSString; direction: Boolean; caseSensitive: Boolean; wrap: Boolean): Boolean; cdecl;
    procedure setGroupName(groupName: NSString); cdecl;
    function groupName: NSString; cdecl;
    function estimatedProgress: Double; cdecl;
    function isLoading: Boolean; cdecl;
    function elementAtPoint(point: NSPoint): NSDictionary; cdecl;
    function pasteboardTypesForSelection: NSArray; cdecl;
    procedure writeSelectionWithPasteboardTypes(types: NSArray; toPasteboard: NSPasteboard); cdecl;
    function pasteboardTypesForElement(element: NSDictionary): NSArray; cdecl;
    procedure writeElement(element: NSDictionary; withPasteboardTypes: NSArray; toPasteboard: NSPasteboard); cdecl;
    procedure moveDragCaretToPoint(point: NSPoint); cdecl;
    procedure removeDragCaret; cdecl;
    procedure setDrawsBackground(drawsBackground: Boolean); cdecl;
    function drawsBackground: Boolean; cdecl;
    procedure setShouldUpdateWhileOffscreen(shouldUpdateWhileOffscreen: Boolean); cdecl;
    function shouldUpdateWhileOffscreen: Boolean; cdecl;
    procedure setMainFrameURL(mainFrameURL: NSString); cdecl;
    function mainFrameURL: NSString; cdecl;
    function mainFrameDocument: DOMDocument; cdecl;
    function mainFrameTitle: NSString; cdecl;
    function mainFrameIcon: NSImage; cdecl;
    procedure takeStringURLFrom(sender: Pointer); cdecl;
    procedure stopLoading(sender: Pointer); cdecl;
    procedure reload(sender: Pointer); cdecl;
    procedure reloadFromOrigin(sender: Pointer); cdecl;
    function canGoBack: Boolean; cdecl;
    [MethodName('goBack:')]
    procedure goBack(sender: Pointer); cdecl; overload;
    function canGoForward: Boolean; cdecl;
    [MethodName('goForward:')]
    procedure goForward(sender: Pointer); cdecl; overload;
    function canMakeTextLarger: Boolean; cdecl;
    procedure makeTextLarger(sender: Pointer); cdecl;
    function canMakeTextSmaller: Boolean; cdecl;
    procedure makeTextSmaller(sender: Pointer); cdecl;
    function canMakeTextStandardSize: Boolean; cdecl;
    procedure makeTextStandardSize(sender: Pointer); cdecl;
    procedure toggleContinuousSpellChecking(sender: Pointer); cdecl;
    procedure toggleSmartInsertDelete(sender: Pointer); cdecl;
    function computedStyleForElement(element: DOMElement; pseudoElement: NSString): DOMCSSStyleDeclaration; cdecl;
    function editableDOMRangeForPoint(point: NSPoint): DOMRange; cdecl;
    procedure setSelectedDOMRange(range: DOMRange; affinity: NSSelectionAffinity); cdecl;
    function selectedDOMRange: DOMRange; cdecl;
    function selectionAffinity: NSSelectionAffinity; cdecl;
    function maintainsInactiveSelection: Boolean; cdecl;
    procedure setEditable(editable: Boolean); cdecl;
    function isEditable: Boolean; cdecl;
    procedure setTypingStyle(typingStyle: DOMCSSStyleDeclaration); cdecl;
    function typingStyle: DOMCSSStyleDeclaration; cdecl;
    procedure setSmartInsertDeleteEnabled(smartInsertDeleteEnabled: Boolean); cdecl;
    function smartInsertDeleteEnabled: Boolean; cdecl;
    procedure setContinuousSpellCheckingEnabled(continuousSpellCheckingEnabled: Boolean); cdecl;
    function isContinuousSpellCheckingEnabled: Boolean; cdecl;
    function spellCheckerDocumentTag: NSInteger; cdecl;
    function undoManager: NSUndoManager; cdecl;
    procedure setEditingDelegate(editingDelegate: Pointer); cdecl;
    function editingDelegate: Pointer; cdecl;
    function styleDeclarationWithText(text: NSString): DOMCSSStyleDeclaration; cdecl;
    procedure replaceSelectionWithNode(node: DOMNode); cdecl;
    procedure replaceSelectionWithText(text: NSString); cdecl;
    procedure replaceSelectionWithMarkupString(markupString: NSString); cdecl;
    procedure replaceSelectionWithArchive(archive: WebArchive); cdecl;
    procedure deleteSelection; cdecl;
    procedure applyStyle(style: DOMCSSStyleDeclaration); cdecl;
    procedure copy(sender: Pointer); cdecl;
    procedure cut(sender: Pointer); cdecl;
    procedure paste(sender: Pointer); cdecl;
    procedure copyFont(sender: Pointer); cdecl;
    procedure pasteFont(sender: Pointer); cdecl;
    procedure delete(sender: Pointer); cdecl;
    procedure pasteAsPlainText(sender: Pointer); cdecl;
    procedure pasteAsRichText(sender: Pointer); cdecl;
    procedure changeFont(sender: Pointer); cdecl;
    procedure changeAttributes(sender: Pointer); cdecl;
    procedure changeDocumentBackgroundColor(sender: Pointer); cdecl;
    procedure changeColor(sender: Pointer); cdecl;
    procedure alignCenter(sender: Pointer); cdecl;
    procedure alignJustified(sender: Pointer); cdecl;
    procedure alignLeft(sender: Pointer); cdecl;
    procedure alignRight(sender: Pointer); cdecl;
    procedure checkSpelling(sender: Pointer); cdecl;
    procedure showGuessPanel(sender: Pointer); cdecl;
    procedure performFindPanelAction(sender: Pointer); cdecl;
    procedure startSpeaking(sender: Pointer); cdecl;
    procedure stopSpeaking(sender: Pointer); cdecl;
    procedure moveToBeginningOfSentence(sender: Pointer); cdecl;
    procedure moveToBeginningOfSentenceAndModifySelection(sender: Pointer); cdecl;
    procedure moveToEndOfSentence(sender: Pointer); cdecl;
    procedure moveToEndOfSentenceAndModifySelection(sender: Pointer); cdecl;
    procedure selectSentence(sender: Pointer); cdecl;
    procedure overWrite(sender: Pointer); cdecl;
  end;

  TWebView = class(TOCGenericImport<WebViewClass, WebView>)
  end;
  PWebView = Pointer;

  WebViewEditingDelegate = interface(IObjectiveC)
    ['{F3078E03-6542-4A3E-9CE7-B1911E39FC63}']
    [MethodName('webView:shouldBeginEditingInDOMRange:')]
    function webViewShouldBeginEditingInDOMRange(WebView: WebView; shouldBeginEditingInDOMRange: DOMRange)
      : Boolean; cdecl;
    [MethodName('webView:shouldEndEditingInDOMRange:')]
    function webViewShouldEndEditingInDOMRange(WebView: WebView; shouldEndEditingInDOMRange: DOMRange): Boolean; cdecl;
    [MethodName('webView:shouldInsertNode:replacingDOMRange:givenAction:')]
    function webViewShouldInsertNodeReplacingDOMRangeGivenAction(WebView: WebView; shouldInsertNode: DOMNode;
      replacingDOMRange: DOMRange; givenAction: WebViewInsertAction): Boolean; cdecl;
    [MethodName('webView:shouldInsertText:replacingDOMRange:givenAction:')]
    function webViewShouldInsertTextReplacingDOMRangeGivenAction(WebView: WebView; shouldInsertText: NSString;
      replacingDOMRange: DOMRange; givenAction: WebViewInsertAction): Boolean; cdecl;
    [MethodName('webView:shouldDeleteDOMRange:')]
    function webViewShouldDeleteDOMRange(WebView: WebView; shouldDeleteDOMRange: DOMRange): Boolean; cdecl;
    [MethodName('webView:shouldChangeSelectedDOMRange:toDOMRange:affinity:stillSelecting:')]
    function webViewShouldChangeSelectedDOMRangeToDOMRangeAffinityStillSelecting(WebView: WebView;
      shouldChangeSelectedDOMRange: DOMRange; toDOMRange: DOMRange; affinity: NSSelectionAffinity;
      stillSelecting: Boolean): Boolean; cdecl;
    [MethodName('webView:shouldApplyStyle:toElementsInDOMRange:')]
    function webViewShouldApplyStyleToElementsInDOMRange(WebView: WebView; shouldApplyStyle: DOMCSSStyleDeclaration;
      toElementsInDOMRange: DOMRange): Boolean; cdecl;
    [MethodName('webView:shouldChangeTypingStyle:toStyle:')]
    function webViewShouldChangeTypingStyleToStyle(WebView: WebView; shouldChangeTypingStyle: DOMCSSStyleDeclaration;
      toStyle: DOMCSSStyleDeclaration): Boolean; cdecl;
    [MethodName('webView:doCommandBySelector:')]
    function webViewDoCommandBySelector(WebView: WebView; doCommandBySelector: SEL): Boolean; cdecl;
    procedure webViewDidBeginEditing(notification: NSNotification); cdecl;
    procedure webViewDidChange(notification: NSNotification); cdecl;
    procedure webViewDidEndEditing(notification: NSNotification); cdecl;
    procedure webViewDidChangeTypingStyle(notification: NSNotification); cdecl;
    procedure webViewDidChangeSelection(notification: NSNotification); cdecl;
    function undoManagerForWebView(WebView: WebView): NSUndoManager; cdecl;
  end;

  WebFrameViewClass = interface(NSViewClass)
    ['{CC69D457-749D-4578-AEB8-684D1E242322}']
  end;
  WebFrameView = interface(NSView)
    ['{83A9F86E-49FC-4913-A0F8-5825925CD670}']
    function WebFrame: WebFrame; cdecl;
    function documentView: NSView; cdecl;
    procedure setAllowsScrolling(allowsScrolling: Boolean); cdecl;
    function allowsScrolling: Boolean; cdecl;
    function canPrintHeadersAndFooters: Boolean; cdecl;
    function printOperationWithPrintInfo(printInfo: NSPrintInfo): NSPrintOperation; cdecl;
    function documentViewShouldHandlePrint: Boolean; cdecl;
    procedure printDocumentView; cdecl;
  end;

  TWebFrameView = class(TOCGenericImport<WebFrameViewClass, WebFrameView>)
  end;
  PWebFrameView = Pointer;

  WebFrameLoadDelegate = interface(IObjectiveC)
    ['{50FBA900-6373-4D55-89A0-21BC30D8B033}']
    [MethodName('webView:didStartProvisionalLoadForFrame:')]
    procedure webViewDidStartProvisionalLoadForFrame(sender: WebView; didStartProvisionalLoadForFrame: WebFrame); cdecl;
    [MethodName('webView:didReceiveServerRedirectForProvisionalLoadForFrame:')]
    procedure webViewDidReceiveServerRedirectForProvisionalLoadForFrame(sender: WebView;
      didReceiveServerRedirectForProvisionalLoadForFrame: WebFrame); cdecl;
    [MethodName('webView:didFailProvisionalLoadWithError:forFrame:')]
    procedure webViewDidFailProvisionalLoadWithErrorForFrame(sender: WebView; didFailProvisionalLoadWithError: NSError;
      forFrame: WebFrame); cdecl;
    [MethodName('webView:didCommitLoadForFrame:')]
    procedure webViewDidCommitLoadForFrame(sender: WebView; didCommitLoadForFrame: WebFrame); cdecl;
    [MethodName('webView:didReceiveTitle:forFrame:')]
    procedure webViewDidReceiveTitleForFrame(sender: WebView; didReceiveTitle: NSString; forFrame: WebFrame); cdecl;
    [MethodName('webView:didReceiveIcon:forFrame:')]
    procedure webViewDidReceiveIconForFrame(sender: WebView; didReceiveIcon: NSImage; forFrame: WebFrame); cdecl;
    [MethodName('webView:didFinishLoadForFrame:')]
    procedure webViewDidFinishLoadForFrame(sender: WebView; didFinishLoadForFrame: WebFrame); cdecl;
    [MethodName('webView:didFailLoadWithError:forFrame:')]
    procedure webViewDidFailLoadWithErrorForFrame(sender: WebView; didFailLoadWithError: NSError;
      forFrame: WebFrame); cdecl;
    [MethodName('webView:didChangeLocationWithinPageForFrame:')]
    procedure webViewDidChangeLocationWithinPageForFrame(sender: WebView;
      didChangeLocationWithinPageForFrame: WebFrame); cdecl;
    [MethodName('webView:willPerformClientRedirectToURL:delay:fireDate:forFrame:')]
    procedure webViewWillPerformClientRedirectToURLDelayFireDateForFrame(sender: WebView;
      willPerformClientRedirectToURL: NSURL; delay: NSTimeInterval; fireDate: NSDate; forFrame: WebFrame); cdecl;
    [MethodName('webView:didCancelClientRedirectForFrame:')]
    procedure webViewDidCancelClientRedirectForFrame(sender: WebView; didCancelClientRedirectForFrame: WebFrame); cdecl;
    [MethodName('webView:willCloseFrame:')]
    procedure webViewWillCloseFrame(sender: WebView; willCloseFrame: WebFrame); cdecl;
    [MethodName('webView:didClearWindowObject:forFrame:')]
    procedure webViewDidClearWindowObjectForFrame(WebView: WebView; didClearWindowObject: WebScriptObject;
      forFrame: WebFrame); cdecl;
    [MethodName('webView:windowScriptObjectAvailable:')]
    procedure webViewWindowScriptObjectAvailable(WebView: WebView; windowScriptObjectAvailable: WebScriptObject); cdecl;
  end;

  WebHistoryClass = interface(NSObjectClass)
    ['{EC73729A-04A1-4985-A32E-0826757B328D}']
    {class} function optionalSharedHistory: WebHistory; cdecl;
    {class} procedure setOptionalSharedHistory(history: WebHistory); cdecl;
  end;
  WebHistory = interface(NSObject)
    ['{5BCED763-B76A-49FA-ACB5-FABDBDFEEAF6}']
    function loadFromURL(URL: NSURL; error: NSError): Boolean; cdecl;
    function saveToURL(URL: NSURL; error: NSError): Boolean; cdecl;
    procedure addItems(newItems: NSArray); cdecl;
    procedure removeItems(items: NSArray); cdecl;
    procedure removeAllItems; cdecl;
    function orderedLastVisitedDays: NSArray; cdecl;
    function orderedItemsLastVisitedOnDay(calendarDate: NSCalendarDate): NSArray; cdecl;
    function itemForURL(URL: NSURL): WebHistoryItem; cdecl;
    procedure setHistoryItemLimit(historyItemLimit: Integer); cdecl;
    function historyItemLimit: Integer; cdecl;
    procedure setHistoryAgeInDaysLimit(historyAgeInDaysLimit: Integer); cdecl;
    function historyAgeInDaysLimit: Integer; cdecl;
  end;

  TWebHistory = class(TOCGenericImport<WebHistoryClass, WebHistory>)
  end;
  PWebHistory = Pointer;

  WKBackForwardListItemClass = interface(NSObjectClass)
    ['{96708A6E-4D2E-4920-B84C-39B010345011}']
  end;
  WKBackForwardListItem = interface(NSObject)
    ['{69054291-E417-4EB0-88C7-FA753579D37B}']
    function URL: NSURL; cdecl;
    function title: NSString; cdecl;
    function initialURL: NSURL; cdecl;
  end;

  TWKBackForwardListItem = class(TOCGenericImport<WKBackForwardListItemClass, WKBackForwardListItem>)
  end;
  PWKBackForwardListItem = Pointer;

  WKBackForwardListClass = interface(NSObjectClass)
    ['{A6901838-5735-4DBA-A3B0-7ACB588666E2}']
  end;
  WKBackForwardList = interface(NSObject)
    ['{BB720EBC-9856-4BAF-953F-E3FB6D69592C}']
    function currentItem: WKBackForwardListItem; cdecl;
    function backItem: WKBackForwardListItem; cdecl;
    function forwardItem: WKBackForwardListItem; cdecl;
    function itemAtIndex(index: NSInteger): WKBackForwardListItem; cdecl;
    function backList: NSArray; cdecl;
    function forwardList: NSArray; cdecl;
  end;

  TWKBackForwardList = class(TOCGenericImport<WKBackForwardListClass, WKBackForwardList>)
  end;
  PWKBackForwardList = Pointer;

  WKFrameInfoClass = interface(NSObjectClass)
    ['{50098AD6-58E8-4481-A8E8-7C84928ECB45}']
  end;
  WKFrameInfo = interface(NSObject)
    ['{47C1C21B-704E-43A9-834D-5805B8562CEA}']
    function isMainFrame: Boolean; cdecl;
    function request: NSURLRequest; cdecl;
  end;

  TWKFrameInfo = class(TOCGenericImport<WKFrameInfoClass, WKFrameInfo>)
  end;
  PWKFrameInfo = Pointer;

  WKNavigationClass = interface(NSObjectClass)
    ['{B8E8AFB6-81FC-4F34-B222-29F6B3EDFB62}']
  end;
  WKNavigation = interface(NSObject)
    ['{A81F2681-FB94-4AA0-8099-818D3800C859}']
  end;

  TWKNavigation = class(TOCGenericImport<WKNavigationClass, WKNavigation>)
  end;
  PWKNavigation = Pointer;

  WKNavigationActionClass = interface(NSObjectClass)
    ['{5562C106-8A7F-456C-B9B5-A5EA355D52EB}']
  end;
  WKNavigationAction = interface(NSObject)
    ['{974C4990-ABE5-4341-A574-14DF05988806}']
    function sourceFrame: WKFrameInfo; cdecl;
    function targetFrame: WKFrameInfo; cdecl;
    function navigationType: WKNavigationType; cdecl;
    function request: NSURLRequest; cdecl;
    function modifierFlags: NSEventModifierFlags; cdecl;
    function buttonNumber: NSInteger; cdecl;
  end;

  TWKNavigationAction = class(TOCGenericImport<WKNavigationActionClass, WKNavigationAction>)
  end;
  PWKNavigationAction = Pointer;

  WKNavigationResponseClass = interface(NSObjectClass)
    ['{FB6FC302-EF16-4DE2-9590-CDD5F6982042}']
  end;
  WKNavigationResponse = interface(NSObject)
    ['{186F7F79-BF76-4211-B889-AEBE01232E91}']
    function isForMainFrame: Boolean; cdecl;
    function response: NSURLResponse; cdecl;
    function canShowMIMEType: Boolean; cdecl;
  end;

  TWKNavigationResponse = class(TOCGenericImport<WKNavigationResponseClass, WKNavigationResponse>)
  end;
  PWKNavigationResponse = Pointer;

  WKWebViewClass = interface(NSViewClass)
    ['{975E5DD2-26EF-4824-9199-6768A1C93D05}']
  end;
  WKWebView = interface(NSView)
    ['{08116015-0A1C-4020-9E89-B2B98ACFC01A}']
    function configuration: WKWebViewConfiguration; cdecl;
    procedure setNavigationDelegate(navigationDelegate: Pointer); cdecl;
    function navigationDelegate: Pointer; cdecl;
    procedure setUIDelegate(UIDelegate: Pointer); cdecl;
    function UIDelegate: Pointer; cdecl;
    function backForwardList: WKBackForwardList; cdecl;
    function initWithFrame(frame: CGRect; configuration: WKWebViewConfiguration): Pointer {instancetype}; cdecl;
    function loadRequest(request: NSURLRequest): WKNavigation; cdecl;
    function loadHTMLString(&string: NSString; baseURL: NSURL): WKNavigation; cdecl;
    function goToBackForwardListItem(item: WKBackForwardListItem): WKNavigation; cdecl;
    function title: NSString; cdecl;
    function URL: NSURL; cdecl;
    function isLoading: Boolean; cdecl;
    function estimatedProgress: Double; cdecl;
    function hasOnlySecureContent: Boolean; cdecl;
    function canGoBack: Boolean; cdecl;
    function canGoForward: Boolean; cdecl;
    [MethodName('goBack')]
    function goBack: WKNavigation; cdecl; overload;
    [MethodName('goForward')]
    function goForward: WKNavigation; cdecl; overload;
    [MethodName('reload')]
    function reload: WKNavigation; cdecl; overload;
    [MethodName('reloadFromOrigin')]
    function reloadFromOrigin: WKNavigation; cdecl; overload;
    [MethodName('stopLoading')]
    procedure stopLoading; cdecl; overload;
    procedure evaluateJavaScript(javaScriptString: NSString; completionHandler: TWebKitCompletionHandler4); cdecl;
    procedure setAllowsBackForwardNavigationGestures(allowsBackForwardNavigationGestures: Boolean); cdecl;
    function allowsBackForwardNavigationGestures: Boolean; cdecl;
    procedure setAllowsMagnification(allowsMagnification: Boolean); cdecl;
    function allowsMagnification: Boolean; cdecl;
    [MethodName('setMagnification:')]
    procedure setMagnification(magnification: CGFloat); cdecl;
    function magnification: CGFloat; cdecl;
    [MethodName('setMagnification:centeredAtPoint:')]
    procedure setMagnificationCenteredAtPoint(magnification: CGFloat; centeredAtPoint: CGPoint); cdecl;
    [MethodName('goBack:')]
    procedure goBack(sender: Pointer); cdecl; overload;
    [MethodName('goForward:')]
    procedure goForward(sender: Pointer); cdecl; overload;
    [MethodName('reload:')]
    procedure reload(sender: Pointer); cdecl; overload;
    [MethodName('reloadFromOrigin:')]
    procedure reloadFromOrigin(sender: Pointer); cdecl; overload;
    [MethodName('stopLoading:')]
    procedure stopLoading(sender: Pointer); cdecl; overload;
  end;

  TWKWebView = class(TOCGenericImport<WKWebViewClass, WKWebView>)
  end;
  PWKWebView = Pointer;

  WKPreferencesClass = interface(NSObjectClass)
    ['{8F3152CA-4911-46FA-B496-993DB3CE55CF}']
  end;
  WKPreferences = interface(NSObject)
    ['{43BBC734-247B-45F5-A178-5AAF9CC85DFD}']
    procedure setMinimumFontSize(minimumFontSize: CGFloat); cdecl;
    function minimumFontSize: CGFloat; cdecl;
    procedure setJavaScriptEnabled(javaScriptEnabled: Boolean); cdecl;
    function javaScriptEnabled: Boolean; cdecl;
    procedure setJavaScriptCanOpenWindowsAutomatically(javaScriptCanOpenWindowsAutomatically: Boolean); cdecl;
    function javaScriptCanOpenWindowsAutomatically: Boolean; cdecl;
    procedure setJavaEnabled(javaEnabled: Boolean); cdecl;
    function javaEnabled: Boolean; cdecl;
    procedure setPlugInsEnabled(plugInsEnabled: Boolean); cdecl;
    function plugInsEnabled: Boolean; cdecl;
  end;

  TWKPreferences = class(TOCGenericImport<WKPreferencesClass, WKPreferences>)
  end;
  PWKPreferences = Pointer;

  WKProcessPoolClass = interface(NSObjectClass)
    ['{82C96CC6-2173-4008-BC55-A1AEE36AED33}']
  end;
  WKProcessPool = interface(NSObject)
    ['{8C2D9FDC-AC19-4C74-BC48-65931A72CC3B}']
  end;

  TWKProcessPool = class(TOCGenericImport<WKProcessPoolClass, WKProcessPool>)
  end;
  PWKProcessPool = Pointer;

  WKScriptMessageClass = interface(NSObjectClass)
    ['{EDA6B7F4-B997-48D1-8751-9330B7096934}']
  end;
  WKScriptMessage = interface(NSObject)
    ['{AC4D1420-C910-4EB8-8E31-0DBFB578FE4F}']
    function body: Pointer; cdecl;
    function WebView: WKWebView; cdecl;
    function frameInfo: WKFrameInfo; cdecl;
    function name: NSString; cdecl;
  end;

  TWKScriptMessage = class(TOCGenericImport<WKScriptMessageClass, WKScriptMessage>)
  end;
  PWKScriptMessage = Pointer;

  WKUserContentControllerClass = interface(NSObjectClass)
    ['{CDA61E74-F460-4AAF-AE06-38FF6C778D68}']
  end;
  WKUserContentController = interface(NSObject)
    ['{FB139B38-7559-4BFF-B373-FEB60ECFEEC0}']
    function userScripts: NSArray; cdecl;
    procedure addUserScript(userScript: WKUserScript); cdecl;
    procedure removeAllUserScripts; cdecl;
    procedure addScriptMessageHandler(scriptMessageHandler: Pointer; name: NSString); cdecl;
    procedure removeScriptMessageHandlerForName(name: NSString); cdecl;
  end;

  TWKUserContentController = class(TOCGenericImport<WKUserContentControllerClass, WKUserContentController>)
  end;
  PWKUserContentController = Pointer;

  WKWebViewConfigurationClass = interface(NSObjectClass)
    ['{6F371C26-DE2B-4C1F-BEFC-E342B689DA61}']
  end;
  WKWebViewConfiguration = interface(NSObject)
    ['{02422458-3164-4634-9659-FD69D028D977}']
    procedure setProcessPool(processPool: WKProcessPool); cdecl;
    function processPool: WKProcessPool; cdecl;
    procedure setPreferences(preferences: WKPreferences); cdecl;
    function preferences: WKPreferences; cdecl;
    procedure setUserContentController(userContentController: WKUserContentController); cdecl;
    function userContentController: WKUserContentController; cdecl;
    procedure setSuppressesIncrementalRendering(suppressesIncrementalRendering: Boolean); cdecl;
    function suppressesIncrementalRendering: Boolean; cdecl;
  end;

  TWKWebViewConfiguration = class(TOCGenericImport<WKWebViewConfigurationClass, WKWebViewConfiguration>)
  end;
  PWKWebViewConfiguration = Pointer;

  WKWindowFeaturesClass = interface(NSObjectClass)
    ['{05DE3DEA-498D-439C-9ED9-9ACBA0C5D0CF}']
  end;
  WKWindowFeatures = interface(NSObject)
    ['{52557B85-78BE-47B5-87AC-6B01CD05D6E1}']
    function menuBarVisibility: NSNumber; cdecl;
    function statusBarVisibility: NSNumber; cdecl;
    function toolbarsVisibility: NSNumber; cdecl;
    function allowsResizing: NSNumber; cdecl;
    function x: NSNumber; cdecl;
    function y: NSNumber; cdecl;
    function width: NSNumber; cdecl;
    function height: NSNumber; cdecl;
  end;

  TWKWindowFeatures = class(TOCGenericImport<WKWindowFeaturesClass, WKWindowFeatures>)
  end;
  PWKWindowFeatures = Pointer;

  WKUserScriptClass = interface(NSObjectClass)
    ['{4441FA54-AD61-48EE-86F7-5CABB5C31166}']
  end;
  WKUserScript = interface(NSObject)
    ['{EBD76C63-637E-4887-AC99-4722B87A28C0}']
    function source: NSString; cdecl;
    function injectionTime: WKUserScriptInjectionTime; cdecl;
    function isForMainFrameOnly: Boolean; cdecl;
    function initWithSource(source: NSString; injectionTime: WKUserScriptInjectionTime; forMainFrameOnly: Boolean)
      : Pointer {instancetype}; cdecl;
  end;

  TWKUserScript = class(TOCGenericImport<WKUserScriptClass, WKUserScript>)
  end;
  PWKUserScript = Pointer;

  WebPlugIn = interface(IObjectiveC)
    ['{EB6F8E7C-0B85-4D84-A917-27193B673CC0}']
    procedure webPlugInInitialize; cdecl;
    procedure webPlugInStart; cdecl;
    procedure webPlugInStop; cdecl;
    procedure webPlugInDestroy; cdecl;
    procedure webPlugInSetIsSelected(isSelected: Boolean); cdecl;
    function objectForWebScript: Pointer; cdecl;
    procedure webPlugInMainResourceDidReceiveResponse(response: NSURLResponse); cdecl;
    procedure webPlugInMainResourceDidReceiveData(data: NSData); cdecl;
    procedure webPlugInMainResourceDidFailWithError(error: NSError); cdecl;
    procedure webPlugInMainResourceDidFinishLoading; cdecl;
  end;

  WebPlugInContainer = interface(IObjectiveC)
    ['{18649851-E3EA-437C-9F06-445CDA208551}']
    procedure webPlugInContainerLoadRequest(request: NSURLRequest; inFrame: NSString); cdecl;
    procedure webPlugInContainerShowStatus(message: NSString); cdecl;
    function webPlugInContainerSelectionColor: NSColor; cdecl;
    function WebFrame: WebFrame; cdecl;
  end;

  WebPolicyDelegate = interface(IObjectiveC)
    ['{0BE9E848-E8DF-4736-B10B-63B565D3EA6D}']
    [MethodName('webView:decidePolicyForNavigationAction:request:frame:decisionListener:')]
    procedure webViewDecidePolicyForNavigationActionRequestFrameDecisionListener(WebView: WebView;
      decidePolicyForNavigationAction: NSDictionary; request: NSURLRequest; frame: WebFrame;
      decisionListener: Pointer); cdecl;
    [MethodName('webView:decidePolicyForNewWindowAction:request:newFrameName:decisionListener:')]
    procedure webViewDecidePolicyForNewWindowActionRequestNewFrameNameDecisionListener(WebView: WebView;
      decidePolicyForNewWindowAction: NSDictionary; request: NSURLRequest; newFrameName: NSString;
      decisionListener: Pointer); cdecl;
    [MethodName('webView:decidePolicyForMIMEType:request:frame:decisionListener:')]
    procedure webViewDecidePolicyForMIMETypeRequestFrameDecisionListener(WebView: WebView;
      decidePolicyForMIMEType: NSString; request: NSURLRequest; frame: WebFrame; decisionListener: Pointer); cdecl;
    [MethodName('webView:unableToImplementPolicyWithError:frame:')]
    procedure webViewUnableToImplementPolicyWithErrorFrame(WebView: WebView; unableToImplementPolicyWithError: NSError;
      frame: WebFrame); cdecl;
  end;

  WebPreferencesClass = interface(NSObjectClass)
    ['{16346192-EC6D-4A4A-BC8D-1B51E3809CE9}']
    {class} function standardPreferences: WebPreferences; cdecl;
  end;
  WebPreferences = interface(NSObject)
    ['{AC8C4DD1-29CA-4A92-B91F-5A7CDED30985}']
    function initWithIdentifier(anIdentifier: NSString): Pointer {instancetype}; cdecl;
    function identifier: NSString; cdecl;
    procedure setStandardFontFamily(standardFontFamily: NSString); cdecl;
    function standardFontFamily: NSString; cdecl;
    procedure setFixedFontFamily(fixedFontFamily: NSString); cdecl;
    function fixedFontFamily: NSString; cdecl;
    procedure setSerifFontFamily(serifFontFamily: NSString); cdecl;
    function serifFontFamily: NSString; cdecl;
    procedure setSansSerifFontFamily(sansSerifFontFamily: NSString); cdecl;
    function sansSerifFontFamily: NSString; cdecl;
    procedure setCursiveFontFamily(cursiveFontFamily: NSString); cdecl;
    function cursiveFontFamily: NSString; cdecl;
    procedure setFantasyFontFamily(fantasyFontFamily: NSString); cdecl;
    function fantasyFontFamily: NSString; cdecl;
    procedure setDefaultFontSize(defaultFontSize: Integer); cdecl;
    function defaultFontSize: Integer; cdecl;
    procedure setDefaultFixedFontSize(defaultFixedFontSize: Integer); cdecl;
    function defaultFixedFontSize: Integer; cdecl;
    procedure setMinimumFontSize(minimumFontSize: Integer); cdecl;
    function minimumFontSize: Integer; cdecl;
    procedure setMinimumLogicalFontSize(minimumLogicalFontSize: Integer); cdecl;
    function minimumLogicalFontSize: Integer; cdecl;
    procedure setDefaultTextEncodingName(defaultTextEncodingName: NSString); cdecl;
    function defaultTextEncodingName: NSString; cdecl;
    procedure setUserStyleSheetEnabled(userStyleSheetEnabled: Boolean); cdecl;
    function userStyleSheetEnabled: Boolean; cdecl;
    procedure setUserStyleSheetLocation(userStyleSheetLocation: NSURL); cdecl;
    function userStyleSheetLocation: NSURL; cdecl;
    procedure setJavaEnabled(javaEnabled: Boolean); cdecl;
    function isJavaEnabled: Boolean; cdecl;
    procedure setJavaScriptEnabled(javaScriptEnabled: Boolean); cdecl;
    function isJavaScriptEnabled: Boolean; cdecl;
    procedure setJavaScriptCanOpenWindowsAutomatically(javaScriptCanOpenWindowsAutomatically: Boolean); cdecl;
    function javaScriptCanOpenWindowsAutomatically: Boolean; cdecl;
    procedure setPlugInsEnabled(plugInsEnabled: Boolean); cdecl;
    function arePlugInsEnabled: Boolean; cdecl;
    procedure setAllowsAnimatedImages(allowsAnimatedImages: Boolean); cdecl;
    function allowsAnimatedImages: Boolean; cdecl;
    procedure setAllowsAnimatedImageLooping(allowsAnimatedImageLooping: Boolean); cdecl;
    function allowsAnimatedImageLooping: Boolean; cdecl;
    procedure setLoadsImagesAutomatically(loadsImagesAutomatically: Boolean); cdecl;
    function loadsImagesAutomatically: Boolean; cdecl;
    procedure setAutosaves(autosaves: Boolean); cdecl;
    function autosaves: Boolean; cdecl;
    procedure setShouldPrintBackgrounds(shouldPrintBackgrounds: Boolean); cdecl;
    function shouldPrintBackgrounds: Boolean; cdecl;
    procedure setPrivateBrowsingEnabled(privateBrowsingEnabled: Boolean); cdecl;
    function privateBrowsingEnabled: Boolean; cdecl;
    procedure setTabsToLinks(tabsToLinks: Boolean); cdecl;
    function tabsToLinks: Boolean; cdecl;
    procedure setUsesPageCache(usesPageCache: Boolean); cdecl;
    function usesPageCache: Boolean; cdecl;
    procedure setCacheModel(cacheModel: WebCacheModel); cdecl;
    function cacheModel: WebCacheModel; cdecl;
    procedure setSuppressesIncrementalRendering(suppressesIncrementalRendering: Boolean); cdecl;
    function suppressesIncrementalRendering: Boolean; cdecl;
  end;

  TWebPreferences = class(TOCGenericImport<WebPreferencesClass, WebPreferences>)
  end;
  PWebPreferences = Pointer;

  WebResourceLoadDelegate = interface(IObjectiveC)
    ['{E1FBB2EC-EF7F-4630-9AD5-16306A1859CB}']
    [MethodName('webView:identifierForInitialRequest:fromDataSource:')]
    function webViewIdentifierForInitialRequestFromDataSource(sender: WebView;
      identifierForInitialRequest: NSURLRequest; fromDataSource: WebDataSource): Pointer; cdecl;
    [MethodName('webView:resource:willSendRequest:redirectResponse:fromDataSource:')]
    function webViewResourceWillSendRequestRedirectResponseFromDataSource(sender: WebView; resource: Pointer;
      willSendRequest: NSURLRequest; redirectResponse: NSURLResponse; fromDataSource: WebDataSource)
      : NSURLRequest; cdecl;
    [MethodName('webView:resource:didReceiveAuthenticationChallenge:fromDataSource:')]
    procedure webViewResourceDidReceiveAuthenticationChallengeFromDataSource(sender: WebView; resource: Pointer;
      didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge; fromDataSource: WebDataSource); cdecl;
    [MethodName('webView:resource:didCancelAuthenticationChallenge:fromDataSource:')]
    procedure webViewResourceDidCancelAuthenticationChallengeFromDataSource(sender: WebView; resource: Pointer;
      didCancelAuthenticationChallenge: NSURLAuthenticationChallenge; fromDataSource: WebDataSource); cdecl;
    [MethodName('webView:resource:didReceiveResponse:fromDataSource:')]
    procedure webViewResourceDidReceiveResponseFromDataSource(sender: WebView; resource: Pointer;
      didReceiveResponse: NSURLResponse; fromDataSource: WebDataSource); cdecl;
    [MethodName('webView:resource:didReceiveContentLength:fromDataSource:')]
    procedure webViewResourceDidReceiveContentLengthFromDataSource(sender: WebView; resource: Pointer;
      didReceiveContentLength: NSInteger; fromDataSource: WebDataSource); cdecl;
    [MethodName('webView:resource:didFinishLoadingFromDataSource:')]
    procedure webViewResourceDidFinishLoadingFromDataSource(sender: WebView; resource: Pointer;
      didFinishLoadingFromDataSource: WebDataSource); cdecl;
    [MethodName('webView:resource:didFailLoadingWithError:fromDataSource:')]
    procedure webViewResourceDidFailLoadingWithErrorFromDataSource(sender: WebView; resource: Pointer;
      didFailLoadingWithError: NSError; fromDataSource: WebDataSource); cdecl;
    [MethodName('webView:plugInFailedWithError:dataSource:')]
    procedure webViewPlugInFailedWithErrorDataSource(sender: WebView; plugInFailedWithError: NSError;
      dataSource: WebDataSource); cdecl;
  end;

  WebUIDelegate = interface(IObjectiveC)
    ['{41E6B5F4-1D42-47B8-A86B-A97E53794059}']
    [MethodName('webView:createWebViewWithRequest:')]
    function webViewCreateWebViewWithRequest(sender: WebView; createWebViewWithRequest: NSURLRequest): WebView; cdecl;
    procedure webViewShow(sender: WebView); cdecl;
    [MethodName('webView:createWebViewModalDialogWithRequest:')]
    function webViewCreateWebViewModalDialogWithRequest(sender: WebView;
      createWebViewModalDialogWithRequest: NSURLRequest): WebView; cdecl;
    procedure webViewRunModal(sender: WebView); cdecl;
    procedure webViewClose(sender: WebView); cdecl;
    procedure webViewFocus(sender: WebView); cdecl;
    procedure webViewUnfocus(sender: WebView); cdecl;
    function webViewFirstResponder(sender: WebView): NSResponder; cdecl;
    [MethodName('webView:makeFirstResponder:')]
    procedure webViewMakeFirstResponder(sender: WebView; makeFirstResponder: NSResponder); cdecl;
    [MethodName('webView:setStatusText:')]
    procedure webViewSetStatusText(sender: WebView; setStatusText: NSString); cdecl;
    function webViewStatusText(sender: WebView): NSString; cdecl;
    function webViewAreToolbarsVisible(sender: WebView): Boolean; cdecl;
    [MethodName('webView:setToolbarsVisible:')]
    procedure webViewSetToolbarsVisible(sender: WebView; setToolbarsVisible: Boolean); cdecl;
    function webViewIsStatusBarVisible(sender: WebView): Boolean; cdecl;
    [MethodName('webView:setStatusBarVisible:')]
    procedure webViewSetStatusBarVisible(sender: WebView; setStatusBarVisible: Boolean); cdecl;
    function webViewIsResizable(sender: WebView): Boolean; cdecl;
    [MethodName('webView:setResizable:')]
    procedure webViewSetResizable(sender: WebView; setResizable: Boolean); cdecl;
    [MethodName('webView:setFrame:')]
    procedure webViewSetFrame(sender: WebView; setFrame: NSRect); cdecl;
    function webViewFrame(sender: WebView): NSRect; cdecl;
    [MethodName('webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:')]
    procedure webViewRunJavaScriptAlertPanelWithMessageInitiatedByFrame(sender: WebView;
      runJavaScriptAlertPanelWithMessage: NSString; initiatedByFrame: WebFrame); cdecl;
    [MethodName('webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:')]
    function webViewRunJavaScriptConfirmPanelWithMessageInitiatedByFrame(sender: WebView;
      runJavaScriptConfirmPanelWithMessage: NSString; initiatedByFrame: WebFrame): Boolean; cdecl;
    [MethodName('webView:runJavaScriptTextInputPanelWithPrompt:defaultText:initiatedByFrame:')]
    function webViewRunJavaScriptTextInputPanelWithPromptDefaultTextInitiatedByFrame(sender: WebView;
      runJavaScriptTextInputPanelWithPrompt: NSString; defaultText: NSString; initiatedByFrame: WebFrame)
      : NSString; cdecl;
    [MethodName('webView:runBeforeUnloadConfirmPanelWithMessage:initiatedByFrame:')]
    function webViewRunBeforeUnloadConfirmPanelWithMessageInitiatedByFrame(sender: WebView;
      runBeforeUnloadConfirmPanelWithMessage: NSString; initiatedByFrame: WebFrame): Boolean; cdecl;
    [MethodName('webView:runOpenPanelForFileButtonWithResultListener:')]
    procedure webViewRunOpenPanelForFileButtonWithResultListener(sender: WebView;
      runOpenPanelForFileButtonWithResultListener: Pointer); cdecl;
    [MethodName('webView:runOpenPanelForFileButtonWithResultListener:allowMultipleFiles:')]
    procedure webViewRunOpenPanelForFileButtonWithResultListenerAllowMultipleFiles(sender: WebView;
      runOpenPanelForFileButtonWithResultListener: Pointer; allowMultipleFiles: Boolean); cdecl;
    [MethodName('webView:mouseDidMoveOverElement:modifierFlags:')]
    procedure webViewMouseDidMoveOverElementModifierFlags(sender: WebView; mouseDidMoveOverElement: NSDictionary;
      modifierFlags: NSUInteger); cdecl;
    [MethodName('webView:contextMenuItemsForElement:defaultMenuItems:')]
    function webViewContextMenuItemsForElementDefaultMenuItems(sender: WebView;
      contextMenuItemsForElement: NSDictionary; defaultMenuItems: NSArray): NSArray; cdecl;
    [MethodName('webView:validateUserInterfaceItem:defaultValidation:')]
    function webViewValidateUserInterfaceItemDefaultValidation(WebView: WebView; validateUserInterfaceItem: Pointer;
      defaultValidation: Boolean): Boolean; cdecl;
    [MethodName('webView:shouldPerformAction:fromSender:')]
    function webViewShouldPerformActionFromSender(WebView: WebView; shouldPerformAction: SEL; fromSender: Pointer)
      : Boolean; cdecl;
    [MethodName('webView:dragDestinationActionMaskForDraggingInfo:')]
    function webViewDragDestinationActionMaskForDraggingInfo(WebView: WebView;
      dragDestinationActionMaskForDraggingInfo: Pointer): NSUInteger; cdecl;
    [MethodName('webView:willPerformDragDestinationAction:forDraggingInfo:')]
    procedure webViewWillPerformDragDestinationActionForDraggingInfo(WebView: WebView;
      willPerformDragDestinationAction: WebDragDestinationAction; forDraggingInfo: Pointer); cdecl;
    [MethodName('webView:dragSourceActionMaskForPoint:')]
    function webViewDragSourceActionMaskForPoint(WebView: WebView; dragSourceActionMaskForPoint: NSPoint)
      : NSUInteger; cdecl;
    [MethodName('webView:willPerformDragSourceAction:fromPoint:withPasteboard:')]
    procedure webViewWillPerformDragSourceActionFromPointWithPasteboard(WebView: WebView;
      willPerformDragSourceAction: WebDragSourceAction; fromPoint: NSPoint; withPasteboard: NSPasteboard); cdecl;
    [MethodName('webView:printFrameView:')]
    procedure webViewPrintFrameView(sender: WebView; printFrameView: WebFrameView); cdecl;
    function webViewHeaderHeight(sender: WebView): Single; cdecl;
    function webViewFooterHeight(sender: WebView): Single; cdecl;
    [MethodName('webView:drawHeaderInRect:')]
    procedure webViewDrawHeaderInRect(sender: WebView; drawHeaderInRect: NSRect); cdecl;
    [MethodName('webView:drawFooterInRect:')]
    procedure webViewDrawFooterInRect(sender: WebView; drawFooterInRect: NSRect); cdecl;
    [MethodName('webView:runJavaScriptAlertPanelWithMessage:')]
    procedure webViewRunJavaScriptAlertPanelWithMessage(sender: WebView;
      runJavaScriptAlertPanelWithMessage: NSString); cdecl;
    [MethodName('webView:runJavaScriptConfirmPanelWithMessage:')]
    function webViewRunJavaScriptConfirmPanelWithMessage(sender: WebView;
      runJavaScriptConfirmPanelWithMessage: NSString): Boolean; cdecl;
    [MethodName('webView:runJavaScriptTextInputPanelWithPrompt:defaultText:')]
    function webViewRunJavaScriptTextInputPanelWithPromptDefaultText(sender: WebView;
      runJavaScriptTextInputPanelWithPrompt: NSString; defaultText: NSString): NSString; cdecl;
    [MethodName('webView:setContentRect:')]
    procedure webViewSetContentRect(sender: WebView; setContentRect: NSRect); cdecl;
    function webViewContentRect(sender: WebView): NSRect; cdecl;
  end;

  // ===== Protocol declarations =====

  DOMEventListener = interface(IObjectiveC)
    ['{25E37B80-C1CC-4909-B282-0FDD1A259F3A}']
    procedure handleEvent(evt: DOMEvent); cdecl;
  end;

  DOMEventTarget = interface(IObjectiveC)
    ['{6B65F556-F800-4C6F-A4A4-C7F0A000E6D5}']
    [MethodName('addEventListener:listener:useCapture:')]
    procedure addEventListenerListenerUseCapture(&type: NSString; listener: Pointer; useCapture: Boolean); cdecl;
    [MethodName('removeEventListener:listener:useCapture:')]
    procedure removeEventListenerListenerUseCapture(&type: NSString; listener: Pointer; useCapture: Boolean); cdecl;
    function dispatchEvent(event: DOMEvent): Boolean; cdecl;
    [MethodName('addEventListener:::')]
    procedure addEventListener(&type: NSString; listener: Pointer; useCapture: Boolean); cdecl;
    [MethodName('removeEventListener:::')]
    procedure removeEventListener(&type: NSString; listener: Pointer; useCapture: Boolean); cdecl;
  end;

  DOMNodeFilter = interface(IObjectiveC)
    ['{9D4AA8EB-08B9-4F6E-8031-2D2B4824D489}']
    function acceptNode(n: DOMNode): SmallInt; cdecl;
  end;

  DOMXPathNSResolver = interface(IObjectiveC)
    ['{DD535E98-FDA2-4420-BEF6-A500CE9C3805}']
    function lookupNamespaceURI(prefix: NSString): NSString; cdecl;
  end;

  WebDocumentView = interface(IObjectiveC)
    ['{435AB9C2-182C-40B9-BB3F-C842F4D9EED5}']
    procedure setDataSource(dataSource: WebDataSource); cdecl;
    procedure dataSourceUpdated(dataSource: WebDataSource); cdecl;
    procedure setNeedsLayout(flag: Boolean); cdecl;
    procedure layout; cdecl;
    procedure viewWillMoveToHostWindow(hostWindow: NSWindow); cdecl;
    procedure viewDidMoveToHostWindow; cdecl;
  end;

  WebDocumentSearching = interface(IObjectiveC)
    ['{DA562630-AA40-44ED-97A7-9D1E766C6970}']
    function searchFor(&string: NSString; direction: Boolean; caseSensitive: Boolean; wrap: Boolean): Boolean; cdecl;
  end;

  WebDocumentText = interface(IObjectiveC)
    ['{B295EA64-3EB0-483E-9D06-7A546F4B31A8}']
    function supportsTextEncoding: Boolean; cdecl;
    function &string: NSString; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function selectedString: NSString; cdecl;
    function selectedAttributedString: NSAttributedString; cdecl;
    procedure selectAll; cdecl;
    procedure deselectAll; cdecl;
  end;

  WebDocumentRepresentation = interface(IObjectiveC)
    ['{5E95A61D-B2AF-4D17-ADFD-0B531EF7B8B5}']
    procedure setDataSource(dataSource: WebDataSource); cdecl;
    procedure receivedData(data: NSData; withDataSource: WebDataSource); cdecl;
    procedure receivedError(error: NSError; withDataSource: WebDataSource); cdecl;
    procedure finishedLoadingWithDataSource(dataSource: WebDataSource); cdecl;
    function canProvideDocumentSource: Boolean; cdecl;
    function documentSource: NSString; cdecl;
    function title: NSString; cdecl;
  end;

  WKNavigationDelegate = interface(IObjectiveC)
    ['{AEA8B799-006C-4CA4-A053-4674434B8628}']
    [MethodName('webView:decidePolicyForNavigationAction:decisionHandler:')]
    procedure webViewDecidePolicyForNavigationActionDecisionHandler(WebView: WKWebView;
      decidePolicyForNavigationAction: WKNavigationAction; decisionHandler: TWebKitDecisionHandler); cdecl;
    [MethodName('webView:decidePolicyForNavigationResponse:decisionHandler:')]
    procedure webViewDecidePolicyForNavigationResponseDecisionHandler(WebView: WKWebView;
      decidePolicyForNavigationResponse: WKNavigationResponse; decisionHandler: TWebKitDecisionHandler1); cdecl;
    [MethodName('webView:didStartProvisionalNavigation:')]
    procedure webViewDidStartProvisionalNavigation(WebView: WKWebView;
      didStartProvisionalNavigation: WKNavigation); cdecl;
    [MethodName('webView:didReceiveServerRedirectForProvisionalNavigation:')]
    procedure webViewDidReceiveServerRedirectForProvisionalNavigation(WebView: WKWebView;
      didReceiveServerRedirectForProvisionalNavigation: WKNavigation); cdecl;
    [MethodName('webView:didFailProvisionalNavigation:withError:')]
    procedure webViewDidFailProvisionalNavigationWithError(WebView: WKWebView;
      didFailProvisionalNavigation: WKNavigation; withError: NSError); cdecl;
    [MethodName('webView:didCommitNavigation:')]
    procedure webViewDidCommitNavigation(WebView: WKWebView; didCommitNavigation: WKNavigation); cdecl;
    [MethodName('webView:didFinishNavigation:')]
    procedure webViewDidFinishNavigation(WebView: WKWebView; didFinishNavigation: WKNavigation); cdecl;
    [MethodName('webView:didFailNavigation:withError:')]
    procedure webViewDidFailNavigationWithError(WebView: WKWebView; didFailNavigation: WKNavigation;
      withError: NSError); cdecl;
    [MethodName('webView:didReceiveAuthenticationChallenge:completionHandler:')]
    procedure webViewDidReceiveAuthenticationChallengeCompletionHandler(WebView: WKWebView;
      didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge;
      completionHandler: TWebKitCompletionHandler); cdecl;
  end;

  WKScriptMessageHandler = interface(IObjectiveC)
    ['{74DD2F59-9247-48E2-8AE9-E068216B53EC}']
    procedure userContentController(userContentController: WKUserContentController;
      didReceiveScriptMessage: WKScriptMessage); cdecl;
  end;

  WKUIDelegate = interface(IObjectiveC)
    ['{802EAEEC-5DD2-493E-B6A2-58447AA9F72C}']
    [MethodName('webView:createWebViewWithConfiguration:forNavigationAction:windowFeatures:')]
    function webViewCreateWebViewWithConfigurationForNavigationActionWindowFeatures(WebView: WKWebView;
      createWebViewWithConfiguration: WKWebViewConfiguration; forNavigationAction: WKNavigationAction;
      windowFeatures: WKWindowFeatures): WKWebView; cdecl;
    [MethodName('webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:')]
    procedure webViewRunJavaScriptAlertPanelWithMessageInitiatedByFrameCompletionHandler(WebView: WKWebView;
      runJavaScriptAlertPanelWithMessage: NSString; initiatedByFrame: WKFrameInfo;
      completionHandler: TWebKitCompletionHandler1); cdecl;
    [MethodName('webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:')]
    procedure webViewRunJavaScriptConfirmPanelWithMessageInitiatedByFrameCompletionHandler(WebView: WKWebView;
      runJavaScriptConfirmPanelWithMessage: NSString; initiatedByFrame: WKFrameInfo;
      completionHandler: TWebKitCompletionHandler2); cdecl;
    [MethodName('webView:runJavaScriptTextInputPanelWithPrompt:defaultText:initiatedByFrame:completionHandler:')]
    procedure webViewRunJavaScriptTextInputPanelWithPromptDefaultTextInitiatedByFrameCompletionHandler
      (WebView: WKWebView; runJavaScriptTextInputPanelWithPrompt: NSString; defaultText: NSString;
      initiatedByFrame: WKFrameInfo; completionHandler: TWebKitCompletionHandler3); cdecl;
  end;

  WebPlugInViewFactory = interface(IObjectiveC)
    ['{A0027169-D00D-42B6-B3E5-0F1DAA6A5CDA}']
    function plugInViewWithArguments(arguments: NSDictionary): NSView; cdecl;
  end;

  WebPolicyDecisionListener = interface(IObjectiveC)
    ['{3D5D132B-B8C7-4227-A414-F590E93477F2}']
    procedure use; cdecl;
    procedure download; cdecl;
    procedure ignore; cdecl;
  end;

  WebOpenPanelResultListener = interface(IObjectiveC)
    ['{648E3E5D-A4A2-4E5C-88C9-B9025AB43098}']
    procedure chooseFilename(fileName: NSString); cdecl;
    procedure chooseFilenames(fileNames: NSArray); cdecl;
    procedure cancel; cdecl;
  end;

  // ===== Exported string consts =====

function DOMException: NSString;
function DOMRangeException: NSString;
function DOMEventException: NSString;
function DOMXPathException: NSString;
function WebArchivePboardType: NSString;
function WebHistoryItemsAddedNotification: NSString;
function WebHistoryItemsRemovedNotification: NSString;
function WebHistoryAllItemsRemovedNotification: NSString;
function WebHistoryLoadedNotification: NSString;
function WebHistorySavedNotification: NSString;
function WebHistoryItemsKey: NSString;
function WebHistoryItemChangedNotification: NSString;
function WKErrorDomain: NSString;
function WebKitErrorDomain: NSString;
function WebKitErrorMIMETypeKey: NSString;
function WebKitErrorPlugInNameKey: NSString;
function WebKitErrorPlugInPageURLStringKey: NSString;
function WebPlugInBaseURLKey: NSString;
function WebPlugInAttributesKey: NSString;
function WebPlugInContainerKey: NSString;
function WebPlugInContainingElementKey: NSString;
function WebPlugInShouldLoadMainResourceKey: NSString;
function WebActionNavigationTypeKey: NSString;
function WebActionElementKey: NSString;
function WebActionButtonKey: NSString;
function WebActionModifierFlagsKey: NSString;
function WebActionOriginalURLKey: NSString;
function WebPreferencesChangedNotification: NSString;
function WebElementDOMNodeKey: NSString;
function WebElementFrameKey: NSString;
function WebElementImageAltStringKey: NSString;
function WebElementImageKey: NSString;
function WebElementImageRectKey: NSString;
function WebElementImageURLKey: NSString;
function WebElementIsSelectedKey: NSString;
function WebElementLinkURLKey: NSString;
function WebElementLinkTargetFrameKey: NSString;
function WebElementLinkTitleKey: NSString;
function WebElementLinkLabelKey: NSString;
function WebViewProgressStartedNotification: NSString;
function WebViewProgressEstimateChangedNotification: NSString;
function WebViewProgressFinishedNotification: NSString;
function WebViewDidBeginEditingNotification: NSString;
function WebViewDidChangeNotification: NSString;
function WebViewDidEndEditingNotification: NSString;
function WebViewDidChangeTypingStyleNotification: NSString;
function WebViewDidChangeSelectionNotification: NSString;


// ===== External functions =====

const
  libWebKit = '/System/Library/Frameworks/WebKit.framework/WebKit';

implementation

uses
  System.SysUtils;

var
  WebKitModule: HMODULE;

function DOMException: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'DOMException');
end;

function DOMRangeException: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'DOMRangeException');
end;

function DOMEventException: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'DOMEventException');
end;

function DOMXPathException: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'DOMXPathException');
end;

function WebArchivePboardType: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebArchivePboardType');
end;

function WebHistoryItemsAddedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistoryItemsAddedNotification');
end;

function WebHistoryItemsRemovedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistoryItemsRemovedNotification');
end;

function WebHistoryAllItemsRemovedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistoryAllItemsRemovedNotification');
end;

function WebHistoryLoadedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistoryLoadedNotification');
end;

function WebHistorySavedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistorySavedNotification');
end;

function WebHistoryItemsKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistoryItemsKey');
end;

function WebHistoryItemChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebHistoryItemChangedNotification');
end;

function WKErrorDomain: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WKErrorDomain');
end;

function WebKitErrorDomain: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebKitErrorDomain');
end;

function WebKitErrorMIMETypeKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebKitErrorMIMETypeKey');
end;

function WebKitErrorPlugInNameKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebKitErrorPlugInNameKey');
end;

function WebKitErrorPlugInPageURLStringKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebKitErrorPlugInPageURLStringKey');
end;

function WebPlugInBaseURLKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebPlugInBaseURLKey');
end;

function WebPlugInAttributesKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebPlugInAttributesKey');
end;

function WebPlugInContainerKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebPlugInContainerKey');
end;

function WebPlugInContainingElementKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebPlugInContainingElementKey');
end;

function WebPlugInShouldLoadMainResourceKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebPlugInShouldLoadMainResourceKey');
end;

function WebActionNavigationTypeKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebActionNavigationTypeKey');
end;

function WebActionElementKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebActionElementKey');
end;

function WebActionButtonKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebActionButtonKey');
end;

function WebActionModifierFlagsKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebActionModifierFlagsKey');
end;

function WebActionOriginalURLKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebActionOriginalURLKey');
end;

function WebPreferencesChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebPreferencesChangedNotification');
end;

function WebElementDOMNodeKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementDOMNodeKey');
end;

function WebElementFrameKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementFrameKey');
end;

function WebElementImageAltStringKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementImageAltStringKey');
end;

function WebElementImageKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementImageKey');
end;

function WebElementImageRectKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementImageRectKey');
end;

function WebElementImageURLKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementImageURLKey');
end;

function WebElementIsSelectedKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementIsSelectedKey');
end;

function WebElementLinkURLKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementLinkURLKey');
end;

function WebElementLinkTargetFrameKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementLinkTargetFrameKey');
end;

function WebElementLinkTitleKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementLinkTitleKey');
end;

function WebElementLinkLabelKey: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebElementLinkLabelKey');
end;

function WebViewProgressStartedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewProgressStartedNotification');
end;

function WebViewProgressEstimateChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewProgressEstimateChangedNotification');
end;

function WebViewProgressFinishedNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewProgressFinishedNotification');
end;

function WebViewDidBeginEditingNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewDidBeginEditingNotification');
end;

function WebViewDidChangeNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewDidChangeNotification');
end;

function WebViewDidEndEditingNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewDidEndEditingNotification');
end;

function WebViewDidChangeTypingStyleNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewDidChangeTypingStyleNotification');
end;

function WebViewDidChangeSelectionNotification: NSString;
begin
  Result := CocoaNSStringConst(libWebKit, 'WebViewDidChangeSelectionNotification');
end;

initialization
  WebKitModule := LoadLibrary(libWebKit);

finalization
  if WebKitModule <> 0 then
    FreeLibrary(WebKitModule);

end.
