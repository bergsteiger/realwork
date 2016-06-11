{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Print;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JPageRange = interface;//android.print.PageRange
  JPrintAttributes = interface;//android.print.PrintAttributes
  JPrintAttributes_Margins = interface;//android.print.PrintAttributes$Margins
  JPrintAttributes_MediaSize = interface;//android.print.PrintAttributes$MediaSize
  JPrintAttributes_Resolution = interface;//android.print.PrintAttributes$Resolution
  JPrintDocumentAdapter = interface;//android.print.PrintDocumentAdapter
  JPrintDocumentAdapter_LayoutResultCallback = interface;//android.print.PrintDocumentAdapter$LayoutResultCallback
  JPrintDocumentAdapter_WriteResultCallback = interface;//android.print.PrintDocumentAdapter$WriteResultCallback
  JPrintDocumentInfo = interface;//android.print.PrintDocumentInfo

// ===== Interface declarations =====

  JPageRangeClass = interface(JObjectClass)
    ['{A76D3EDD-96D1-45C5-A5C0-96617C8A2BA0}']
    {class} function _GetALL_PAGES: JPageRange; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(start: Integer; end_: Integer): JPageRange; cdecl;
    {class} property ALL_PAGES: JPageRange read _GetALL_PAGES;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/print/PageRange')]
  JPageRange = interface(JObject)
    ['{993626DC-F39D-4294-8A1D-7A99F074010D}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getEnd: Integer; cdecl;
    function getStart: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJPageRange = class(TJavaGenericImport<JPageRangeClass, JPageRange>) end;

  JPrintAttributesClass = interface(JObjectClass)
    ['{D9B40228-CC37-4573-896E-10D7800670CE}']
    {class} function _GetCOLOR_MODE_COLOR: Integer; cdecl;
    {class} function _GetCOLOR_MODE_MONOCHROME: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDUPLEX_MODE_LONG_EDGE: Integer; cdecl;
    {class} function _GetDUPLEX_MODE_NONE: Integer; cdecl;
    {class} function _GetDUPLEX_MODE_SHORT_EDGE: Integer; cdecl;
    {class} property COLOR_MODE_COLOR: Integer read _GetCOLOR_MODE_COLOR;
    {class} property COLOR_MODE_MONOCHROME: Integer read _GetCOLOR_MODE_MONOCHROME;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DUPLEX_MODE_LONG_EDGE: Integer read _GetDUPLEX_MODE_LONG_EDGE;
    {class} property DUPLEX_MODE_NONE: Integer read _GetDUPLEX_MODE_NONE;
    {class} property DUPLEX_MODE_SHORT_EDGE: Integer read _GetDUPLEX_MODE_SHORT_EDGE;
  end;

  [JavaSignature('android/print/PrintAttributes')]
  JPrintAttributes = interface(JObject)
    ['{312C7538-43CD-4607-B8E2-04CF431C9B5B}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getColorMode: Integer; cdecl;
    function getDuplexMode: Integer; cdecl;
    function getMediaSize: JPrintAttributes_MediaSize; cdecl;
    function getMinMargins: JPrintAttributes_Margins; cdecl;
    function getResolution: JPrintAttributes_Resolution; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJPrintAttributes = class(TJavaGenericImport<JPrintAttributesClass, JPrintAttributes>) end;

  JPrintAttributes_MarginsClass = interface(JObjectClass)
    ['{34F23121-C582-4C7E-B04A-A8A5C782EA32}']
    {class} function _GetNO_MARGINS: JPrintAttributes_Margins; cdecl;
    {class} function init(leftMils: Integer; topMils: Integer; rightMils: Integer; bottomMils: Integer): JPrintAttributes_Margins; cdecl;
    {class} property NO_MARGINS: JPrintAttributes_Margins read _GetNO_MARGINS;
  end;

  [JavaSignature('android/print/PrintAttributes$Margins')]
  JPrintAttributes_Margins = interface(JObject)
    ['{BC9FAC43-0090-4CBE-A09E-17A23A093223}']
    function equals(obj: JObject): Boolean; cdecl;
    function getBottomMils: Integer; cdecl;
    function getLeftMils: Integer; cdecl;
    function getRightMils: Integer; cdecl;
    function getTopMils: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJPrintAttributes_Margins = class(TJavaGenericImport<JPrintAttributes_MarginsClass, JPrintAttributes_Margins>) end;

  JPrintAttributes_MediaSizeClass = interface(JObjectClass)
    ['{0A2D852F-16AE-49A1-BCFE-E1E3E12A15C4}']
    {class} function _GetISO_A0: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A1: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A10: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A3: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A5: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A6: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A7: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A8: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_A9: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B0: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B1: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B10: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B3: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B5: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B6: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B7: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B8: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_B9: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C0: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C1: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C10: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C3: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C5: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C6: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C7: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C8: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetISO_C9: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B0: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B1: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B10: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B3: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B5: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B6: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B7: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B8: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_B9: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJIS_EXEC: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_CHOU2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_CHOU3: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_CHOU4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_HAGAKI: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_KAHU: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_KAKU2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_OUFUKU: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetJPN_YOU4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_FOOLSCAP: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_GOVT_LETTER: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_INDEX_3X5: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_INDEX_4X6: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_INDEX_5X8: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_JUNIOR_LEGAL: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_LEDGER: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_LEGAL: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_LETTER: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_MONARCH: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_QUARTO: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetNA_TABLOID: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetOM_DAI_PA_KAI: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetOM_JUURO_KU_KAI: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetOM_PA_KAI: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_1: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_10: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_16K: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_2: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_3: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_4: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_5: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_6: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_7: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_8: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetPRC_9: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetROC_16K: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetROC_8K: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetUNKNOWN_LANDSCAPE: JPrintAttributes_MediaSize; cdecl;
    {class} function _GetUNKNOWN_PORTRAIT: JPrintAttributes_MediaSize; cdecl;
    {class} function init(id: JString; label_: JString; widthMils: Integer; heightMils: Integer): JPrintAttributes_MediaSize; cdecl;
    {class} property ISO_A0: JPrintAttributes_MediaSize read _GetISO_A0;
    {class} property ISO_A1: JPrintAttributes_MediaSize read _GetISO_A1;
    {class} property ISO_A10: JPrintAttributes_MediaSize read _GetISO_A10;
    {class} property ISO_A2: JPrintAttributes_MediaSize read _GetISO_A2;
    {class} property ISO_A3: JPrintAttributes_MediaSize read _GetISO_A3;
    {class} property ISO_A4: JPrintAttributes_MediaSize read _GetISO_A4;
    {class} property ISO_A5: JPrintAttributes_MediaSize read _GetISO_A5;
    {class} property ISO_A6: JPrintAttributes_MediaSize read _GetISO_A6;
    {class} property ISO_A7: JPrintAttributes_MediaSize read _GetISO_A7;
    {class} property ISO_A8: JPrintAttributes_MediaSize read _GetISO_A8;
    {class} property ISO_A9: JPrintAttributes_MediaSize read _GetISO_A9;
    {class} property ISO_B0: JPrintAttributes_MediaSize read _GetISO_B0;
    {class} property ISO_B1: JPrintAttributes_MediaSize read _GetISO_B1;
    {class} property ISO_B10: JPrintAttributes_MediaSize read _GetISO_B10;
    {class} property ISO_B2: JPrintAttributes_MediaSize read _GetISO_B2;
    {class} property ISO_B3: JPrintAttributes_MediaSize read _GetISO_B3;
    {class} property ISO_B4: JPrintAttributes_MediaSize read _GetISO_B4;
    {class} property ISO_B5: JPrintAttributes_MediaSize read _GetISO_B5;
    {class} property ISO_B6: JPrintAttributes_MediaSize read _GetISO_B6;
    {class} property ISO_B7: JPrintAttributes_MediaSize read _GetISO_B7;
    {class} property ISO_B8: JPrintAttributes_MediaSize read _GetISO_B8;
    {class} property ISO_B9: JPrintAttributes_MediaSize read _GetISO_B9;
    {class} property ISO_C0: JPrintAttributes_MediaSize read _GetISO_C0;
    {class} property ISO_C1: JPrintAttributes_MediaSize read _GetISO_C1;
    {class} property ISO_C10: JPrintAttributes_MediaSize read _GetISO_C10;
    {class} property ISO_C2: JPrintAttributes_MediaSize read _GetISO_C2;
    {class} property ISO_C3: JPrintAttributes_MediaSize read _GetISO_C3;
    {class} property ISO_C4: JPrintAttributes_MediaSize read _GetISO_C4;
    {class} property ISO_C5: JPrintAttributes_MediaSize read _GetISO_C5;
    {class} property ISO_C6: JPrintAttributes_MediaSize read _GetISO_C6;
    {class} property ISO_C7: JPrintAttributes_MediaSize read _GetISO_C7;
    {class} property ISO_C8: JPrintAttributes_MediaSize read _GetISO_C8;
    {class} property ISO_C9: JPrintAttributes_MediaSize read _GetISO_C9;
    {class} property JIS_B0: JPrintAttributes_MediaSize read _GetJIS_B0;
    {class} property JIS_B1: JPrintAttributes_MediaSize read _GetJIS_B1;
    {class} property JIS_B10: JPrintAttributes_MediaSize read _GetJIS_B10;
    {class} property JIS_B2: JPrintAttributes_MediaSize read _GetJIS_B2;
    {class} property JIS_B3: JPrintAttributes_MediaSize read _GetJIS_B3;
    {class} property JIS_B4: JPrintAttributes_MediaSize read _GetJIS_B4;
    {class} property JIS_B5: JPrintAttributes_MediaSize read _GetJIS_B5;
    {class} property JIS_B6: JPrintAttributes_MediaSize read _GetJIS_B6;
    {class} property JIS_B7: JPrintAttributes_MediaSize read _GetJIS_B7;
    {class} property JIS_B8: JPrintAttributes_MediaSize read _GetJIS_B8;
    {class} property JIS_B9: JPrintAttributes_MediaSize read _GetJIS_B9;
    {class} property JIS_EXEC: JPrintAttributes_MediaSize read _GetJIS_EXEC;
    {class} property JPN_CHOU2: JPrintAttributes_MediaSize read _GetJPN_CHOU2;
    {class} property JPN_CHOU3: JPrintAttributes_MediaSize read _GetJPN_CHOU3;
    {class} property JPN_CHOU4: JPrintAttributes_MediaSize read _GetJPN_CHOU4;
    {class} property JPN_HAGAKI: JPrintAttributes_MediaSize read _GetJPN_HAGAKI;
    {class} property JPN_KAHU: JPrintAttributes_MediaSize read _GetJPN_KAHU;
    {class} property JPN_KAKU2: JPrintAttributes_MediaSize read _GetJPN_KAKU2;
    {class} property JPN_OUFUKU: JPrintAttributes_MediaSize read _GetJPN_OUFUKU;
    {class} property JPN_YOU4: JPrintAttributes_MediaSize read _GetJPN_YOU4;
    {class} property NA_FOOLSCAP: JPrintAttributes_MediaSize read _GetNA_FOOLSCAP;
    {class} property NA_GOVT_LETTER: JPrintAttributes_MediaSize read _GetNA_GOVT_LETTER;
    {class} property NA_INDEX_3X5: JPrintAttributes_MediaSize read _GetNA_INDEX_3X5;
    {class} property NA_INDEX_4X6: JPrintAttributes_MediaSize read _GetNA_INDEX_4X6;
    {class} property NA_INDEX_5X8: JPrintAttributes_MediaSize read _GetNA_INDEX_5X8;
    {class} property NA_JUNIOR_LEGAL: JPrintAttributes_MediaSize read _GetNA_JUNIOR_LEGAL;
    {class} property NA_LEDGER: JPrintAttributes_MediaSize read _GetNA_LEDGER;
    {class} property NA_LEGAL: JPrintAttributes_MediaSize read _GetNA_LEGAL;
    {class} property NA_LETTER: JPrintAttributes_MediaSize read _GetNA_LETTER;
    {class} property NA_MONARCH: JPrintAttributes_MediaSize read _GetNA_MONARCH;
    {class} property NA_QUARTO: JPrintAttributes_MediaSize read _GetNA_QUARTO;
    {class} property NA_TABLOID: JPrintAttributes_MediaSize read _GetNA_TABLOID;
    {class} property OM_DAI_PA_KAI: JPrintAttributes_MediaSize read _GetOM_DAI_PA_KAI;
    {class} property OM_JUURO_KU_KAI: JPrintAttributes_MediaSize read _GetOM_JUURO_KU_KAI;
    {class} property OM_PA_KAI: JPrintAttributes_MediaSize read _GetOM_PA_KAI;
    {class} property PRC_1: JPrintAttributes_MediaSize read _GetPRC_1;
    {class} property PRC_10: JPrintAttributes_MediaSize read _GetPRC_10;
    {class} property PRC_16K: JPrintAttributes_MediaSize read _GetPRC_16K;
    {class} property PRC_2: JPrintAttributes_MediaSize read _GetPRC_2;
    {class} property PRC_3: JPrintAttributes_MediaSize read _GetPRC_3;
    {class} property PRC_4: JPrintAttributes_MediaSize read _GetPRC_4;
    {class} property PRC_5: JPrintAttributes_MediaSize read _GetPRC_5;
    {class} property PRC_6: JPrintAttributes_MediaSize read _GetPRC_6;
    {class} property PRC_7: JPrintAttributes_MediaSize read _GetPRC_7;
    {class} property PRC_8: JPrintAttributes_MediaSize read _GetPRC_8;
    {class} property PRC_9: JPrintAttributes_MediaSize read _GetPRC_9;
    {class} property ROC_16K: JPrintAttributes_MediaSize read _GetROC_16K;
    {class} property ROC_8K: JPrintAttributes_MediaSize read _GetROC_8K;
    {class} property UNKNOWN_LANDSCAPE: JPrintAttributes_MediaSize read _GetUNKNOWN_LANDSCAPE;
    {class} property UNKNOWN_PORTRAIT: JPrintAttributes_MediaSize read _GetUNKNOWN_PORTRAIT;
  end;

  [JavaSignature('android/print/PrintAttributes$MediaSize')]
  JPrintAttributes_MediaSize = interface(JObject)
    ['{1F95EC3E-8188-4438-8575-C44CABB52DE5}']
    function asLandscape: JPrintAttributes_MediaSize; cdecl;
    function asPortrait: JPrintAttributes_MediaSize; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getHeightMils: Integer; cdecl;
    function getId: JString; cdecl;
    function getLabel(packageManager: JPackageManager): JString; cdecl;
    function getWidthMils: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isPortrait: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJPrintAttributes_MediaSize = class(TJavaGenericImport<JPrintAttributes_MediaSizeClass, JPrintAttributes_MediaSize>) end;

  JPrintAttributes_ResolutionClass = interface(JObjectClass)
    ['{146C3EA6-7D12-4BAE-9EBE-48DC56B9527A}']
    {class} function init(id: JString; label_: JString; horizontalDpi: Integer; verticalDpi: Integer): JPrintAttributes_Resolution; cdecl;
  end;

  [JavaSignature('android/print/PrintAttributes$Resolution')]
  JPrintAttributes_Resolution = interface(JObject)
    ['{9794DA8E-7288-47F0-9D7E-EEEBFD6DE459}']
    function equals(obj: JObject): Boolean; cdecl;
    function getHorizontalDpi: Integer; cdecl;
    function getId: JString; cdecl;
    function getLabel: JString; cdecl;
    function getVerticalDpi: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJPrintAttributes_Resolution = class(TJavaGenericImport<JPrintAttributes_ResolutionClass, JPrintAttributes_Resolution>) end;

  JPrintDocumentAdapterClass = interface(JObjectClass)
    ['{9E14C8BC-810E-4BEA-9635-AA79DA6D3476}']
    {class} function _GetEXTRA_PRINT_PREVIEW: JString; cdecl;
    {class} function init: JPrintDocumentAdapter; cdecl;
    {class} property EXTRA_PRINT_PREVIEW: JString read _GetEXTRA_PRINT_PREVIEW;
  end;

  [JavaSignature('android/print/PrintDocumentAdapter')]
  JPrintDocumentAdapter = interface(JObject)
    ['{CE4783E1-D54F-46FA-B2DC-DB65A20DC786}']
    procedure onFinish; cdecl;
    procedure onLayout(oldAttributes: JPrintAttributes; newAttributes: JPrintAttributes; cancellationSignal: JCancellationSignal; callback: JPrintDocumentAdapter_LayoutResultCallback; extras: JBundle); cdecl;
    procedure onStart; cdecl;
    procedure onWrite(pages: TJavaObjectArray<JPageRange>; destination: JParcelFileDescriptor; cancellationSignal: JCancellationSignal; callback: JPrintDocumentAdapter_WriteResultCallback); cdecl;
  end;
  TJPrintDocumentAdapter = class(TJavaGenericImport<JPrintDocumentAdapterClass, JPrintDocumentAdapter>) end;

  JPrintDocumentAdapter_LayoutResultCallbackClass = interface(JObjectClass)
    ['{C44B2E02-5437-43D0-9F54-8F506EE5660B}']
  end;

  [JavaSignature('android/print/PrintDocumentAdapter$LayoutResultCallback')]
  JPrintDocumentAdapter_LayoutResultCallback = interface(JObject)
    ['{D9ABC6EE-5D92-4E8A-9CA2-E850A27A3BB4}']
    procedure onLayoutCancelled; cdecl;
    procedure onLayoutFailed(error: JCharSequence); cdecl;
    procedure onLayoutFinished(info: JPrintDocumentInfo; changed: Boolean); cdecl;
  end;
  TJPrintDocumentAdapter_LayoutResultCallback = class(TJavaGenericImport<JPrintDocumentAdapter_LayoutResultCallbackClass, JPrintDocumentAdapter_LayoutResultCallback>) end;

  JPrintDocumentAdapter_WriteResultCallbackClass = interface(JObjectClass)
    ['{8B73ACF7-C9BE-4AE0-B4B4-E2270D42E96D}']
  end;

  [JavaSignature('android/print/PrintDocumentAdapter$WriteResultCallback')]
  JPrintDocumentAdapter_WriteResultCallback = interface(JObject)
    ['{03B2AB6A-49E7-4131-AFB7-AB8ABC85075F}']
    procedure onWriteCancelled; cdecl;
    procedure onWriteFailed(error: JCharSequence); cdecl;
    procedure onWriteFinished(pages: TJavaObjectArray<JPageRange>); cdecl;
  end;
  TJPrintDocumentAdapter_WriteResultCallback = class(TJavaGenericImport<JPrintDocumentAdapter_WriteResultCallbackClass, JPrintDocumentAdapter_WriteResultCallback>) end;

  JPrintDocumentInfoClass = interface(JObjectClass)
    ['{F28BED16-94C8-421E-B074-52BA163A27FD}']
    {class} function _GetCONTENT_TYPE_DOCUMENT: Integer; cdecl;
    {class} function _GetCONTENT_TYPE_PHOTO: Integer; cdecl;
    {class} function _GetCONTENT_TYPE_UNKNOWN: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetPAGE_COUNT_UNKNOWN: Integer; cdecl;
    {class} property CONTENT_TYPE_DOCUMENT: Integer read _GetCONTENT_TYPE_DOCUMENT;
    {class} property CONTENT_TYPE_PHOTO: Integer read _GetCONTENT_TYPE_PHOTO;
    {class} property CONTENT_TYPE_UNKNOWN: Integer read _GetCONTENT_TYPE_UNKNOWN;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property PAGE_COUNT_UNKNOWN: Integer read _GetPAGE_COUNT_UNKNOWN;
  end;

  [JavaSignature('android/print/PrintDocumentInfo')]
  JPrintDocumentInfo = interface(JObject)
    ['{B4C4BC34-EC66-414B-AA0C-8193C7A5C592}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getContentType: Integer; cdecl;
    function getDataSize: Int64; cdecl;
    function getName: JString; cdecl;
    function getPageCount: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJPrintDocumentInfo = class(TJavaGenericImport<JPrintDocumentInfoClass, JPrintDocumentInfo>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPageRange', TypeInfo(Androidapi.JNI.Print.JPageRange));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintAttributes', TypeInfo(Androidapi.JNI.Print.JPrintAttributes));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintAttributes_Margins', TypeInfo(Androidapi.JNI.Print.JPrintAttributes_Margins));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintAttributes_MediaSize', TypeInfo(Androidapi.JNI.Print.JPrintAttributes_MediaSize));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintAttributes_Resolution', TypeInfo(Androidapi.JNI.Print.JPrintAttributes_Resolution));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintDocumentAdapter', TypeInfo(Androidapi.JNI.Print.JPrintDocumentAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintDocumentAdapter_LayoutResultCallback', TypeInfo(Androidapi.JNI.Print.JPrintDocumentAdapter_LayoutResultCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintDocumentAdapter_WriteResultCallback', TypeInfo(Androidapi.JNI.Print.JPrintDocumentAdapter_WriteResultCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Print.JPrintDocumentInfo', TypeInfo(Androidapi.JNI.Print.JPrintDocumentInfo));
end;

initialization
  RegisterTypes;
end.


