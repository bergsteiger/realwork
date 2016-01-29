{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDDocumentIntf;

interface

uses
  PDBaseObjectIntf, PDPageIntf, PDDocInfoIntf, PDViewerPreferenceIntf, Classes;

  type
    TPDSaveFlags = packed record
    Incremental: WordBool;
    Full: WordBool;
    Copy: WordBool;
    Linearize: WordBool;
    UniDirectional: WordBool;
    KeepModDate: WordBool;
    UnCompressed: WordBool;
    Compressed: WordBool;
    CompressStructureOnly: WordBool;
    RemoveASCIIFilters: WordBool;
    AddFlate: WordBool;
    ReplaceLZW: WordBool;
    OptimizeXObjects: WordBool;
    OptimizeContentStreams: WordBool;
    OptimizeFonts: WordBool;
    OptimizeMarkedJBIG2Dictionaries: WordBool;
  end;

  IgtPDDocument = class
    procedure LoadDocument(const FileName: WideString; DoRepair: WordBool);
      overload; virtual; abstract;
    procedure LoadDocument(Stream: TStream; DoRepair: Boolean); overload;
      virtual; abstract;
    procedure SaveDocument(const FileName: WideString; SaveFlags: TPDSaveFlags);
      overload; virtual; abstract;
    procedure SaveDocument(Stream: TStream; SaveFlags: TPDSaveFlags);
      overload; virtual; abstract;

    procedure DeletePages(FirstPage: Integer; LastPage: Integer);
      virtual; abstract;
    procedure DeletePage(PageNumber: Integer); virtual; abstract;
    procedure CloseDocument; virtual; abstract;

    function GetFileName: Widestring; virtual; abstract;

    procedure InsertPages(AfterPage: Integer; var SourceDoc: IgtPDDocument;
      SourceStartPage, NumOfPages: Integer; InsertFlags: Integer);
      virtual; abstract;

    procedure MovePage(MoveToAfterPage: Integer; PageToMove: Integer);
       virtual; abstract;

    procedure ReplacePages(StartPage: Integer; SourceDoc: IgtPDDocument;
      SourceStartPage, NumOfPages: Integer; MergeTextAnnots: WordBool);
      virtual; abstract;

    procedure MergeDocs(SourceDoc: IgtPDDocument; InsertFlags: Integer);
       virtual; abstract;

    procedure AppendPages(SourceDoc: IgtPDDocument; SourceStartPage,
      NumOfPages: Integer; InsertFlags: Integer); virtual; abstract;

//    function GetPage(APageNo: Integer): IgtPDPage;  virtual; abstract;
    function GetPageCount: Integer; virtual; abstract;

    procedure GetInfo(const InfoKey: WideString; var Value: WideString);
     overload; virtual; abstract;
//    function GetInfo: IgtPDDocInfo; overload;  virtual; abstract;

//    function GetViewerPref: IgtPDViewerPreference; virtual; abstract;
  end;

  // constants for enum TgtPageInsertFlages
  const
    InsertBookmarks = $00000000;
    InsertThreads = $00000001;
    InsertAll = $00000002;

  {$IFDEF DLLIMPORT}
    function NewPDDocument: IgtPDDocument; stdcall;
    procedure FreePDDocument(ADoc: IgtPDDocument); stdcall;
  {$ENDIF}

implementation

  {$IFDEF DLLIMPORT}
    function NewPDDocument; external 'PDFProcessor.dll';
    procedure FreePDDocument(ADoc: IgtPDDocument); external 'PDFProcessor.dll';
  {$ENDIF}

end.
