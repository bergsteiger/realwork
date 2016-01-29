{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CoPDDocument;

interface

uses
  PDDocumentIntf, PDDocument, PDPageTree, PDBaseObjectIntf, PDPageIntf,
  CoPDBaseObject, PDPage, Contnrs, gtMethods, Classes, PDBaseDocIntf, CoPDBaseDoc,
  PDBaseDoc, PDDocInfoIntf, PDDocInfo, CoPDDocInfo, PDViewerPreferenceIntf,
  PDViewerPreference, CoPDViewerPreference;

type
  TgtCoPDDocument = class(IgtPDDocument)
  private
    FPDDoc: TgtPDDocument;
    FObjectList: TObjectList;
  public
    procedure LoadDocument(const FileName: WideString; DoRepair: WordBool);
      overload; override;
    procedure LoadDocument(Stream: TStream; DoRepair: Boolean); overload;
      override;
    procedure SaveDocument(const FileName: WideString; SaveFlags: TPDSaveFlags);
      overload; override;
    procedure SaveDocument(Stream: TStream; SaveFlags: TPDSaveFlags);
      overload; override;

    procedure DeletePages(FirstPage: Integer; LastPage: Integer);
      override;
    procedure DeletePage(PageNumber: Integer); override;
    procedure CloseDocument; override;

    function GetFileName: Widestring; override;

    procedure InsertPages(AfterPage: Integer; var SourceDoc: IgtPDDocument;
      SourceStartPage, NumOfPages: Integer; InsertFlags: Integer);
      override;

    procedure MovePage(MoveToAfterPage: Integer; PageToMove: Integer);
       override;

    procedure ReplacePages(StartPage: Integer; SourceDoc: IgtPDDocument;
      SourceStartPage, NumOfPages: Integer; MergeTextAnnots: WordBool);
      override;

    procedure MergeDocs(SourceDoc: IgtPDDocument; InsertFlags: Integer);
       override;

    procedure AppendPages(SourceDoc: IgtPDDocument; SourceStartPage,
      NumOfPages: Integer; InsertFlags: Integer); override;

//    function GetPage(APageNo: Integer): IgtPDPage; override;
    function GetPageCount: Integer; override;

    procedure GetInfo(const InfoKey: WideString; var Value: WideString);
     overload; override;
//    function GetInfo: IgtPDDocInfo; overload; override;

//    function GetViewerPref: IgtPDViewerPreference; override;

    constructor Create;
    Destructor Destroy; override;
  protected
    function GetDocument: TgtPDDocument;
  end;

  TgtHackCoPDBaseObject = class(TgtCoPDBaseObject)

  end;

//  TgtHackCoPDPage = class(TgtCoPDPage)

//  end;

  function NewPDDocument: IgtPDDocument; export; stdcall;
  procedure FreePDDocument(ADoc: IgtPDDocument); export; stdcall;

implementation

uses
  CoPDPage;

function NewPDDocument: IgtPDDocument; export; stdcall;
begin
  Result := TgtCoPDDocument.Create;
end;

procedure FreePDDocument(ADoc: IgtPDDocument); export; stdcall;
begin
  TgtCoPDDocument(ADoc).Free;
end;

procedure TgtCoPDDocument.AppendPages(SourceDoc: IgtPDDocument; SourceStartPage,
  NumOfPages, InsertFlags: Integer);
var
  LFlag: TgtPageInsertFlages;
begin
  if Ord(InsertFlags) = $00000000 then
    LFlag := InsertBookmarks
  else if Ord(InsertFlags) = $00000001 then
    LFlag := InsertThreads
  else
    LFlag := InsertAll;
  FPDDoc.AppendPages(TgtCoPDDocument(SourceDoc).FPDDoc, SourceStartPage,
    NumOfPages, LFlag);
end;

procedure TgtCoPDDocument.CloseDocument;
begin
  if Assigned(FPDDoc) then
    FPDDoc.CloseDocument;
end;

constructor TgtCoPDDocument.Create;
begin
  FObjectList := TObjectList.Create(False);
end;

procedure TgtCoPDDocument.DeletePage(PageNumber: Integer);
begin
  FPDDoc.DeletePage(PageNumber);
end;

procedure TgtCoPDDocument.DeletePages(FirstPage, LastPage: Integer);
begin
  FPDDoc.DeletePages(FirstPage, LastPage);
end;

destructor TgtCoPDDocument.Destroy;
var
  I: Integer;
begin
  if Assigned(FObjectList) then FreeObject(FObjectList);
  if Assigned(FPDDoc) then FreeObject(FPDDoc);
end;

function TgtCoPDDocument.GetBaseDoc: IgtPDBaseDoc;
var
  LCoBaseDoc: TgtCoPDBaseDoc;
  LBaseDoc: TgtPDBaseDoc;
begin
  LBaseDoc := FPDDoc.BaseDoc;
  LCoBaseDoc := TgtCoPDBaseDoc.Create(LBaseDoc);        // not complete
  FObjectList.Add(LCoBaseDoc);
  Result := LCoBaseDoc;
end;

function TgtCoPDDocument.GetDocument: TgtPDDocument;
begin
  Result := FPDDoc;
end;

function TgtCoPDDocument.GetFileName: Widestring;
begin
  Result := FPDDoc.GetFileName;
end;

procedure TgtCoPDDocument.GetInfo(const InfoKey: WideString;
  var Value: WideString);
var
  LValue: string;
begin
  LValue := Value;
  FPDDoc.GetInfo(InfoKey, LValue);
  Value := LValue;
end;

function TgtCoPDDocument.GetInfo: IgtPDDocInfo;
var
  LPDDocInfo: TgtPDDocInfo;
  LCoPDDocInfo: TgtCoPDDocInfo;
begin
  LPDDocInfo := FPDDoc.GetInfo;
  LCoPDDocInfo := TgtCoPDDocInfo.Create(LPDDocInfo);
  Result := LCoPDDocInfo;
  FObjectList.Add(LCoPDDocInfo);
end;

function TgtCoPDDocument.GetPage(APageNo: Integer): IgtPDPage;
var
  LCoPage: TgtCoPDPage;
  LPage: TgtPDPage;
begin
  LPage := FPDDoc.Pages[APageNo];
  LCoPage := TgtCoPDPage.Create(LPage);
  Result := LCoPage;
  FObjectList.Add(LCoPage);
end;

function TgtCoPDDocument.GetPageByIndRef(APageRef: IgtPDBaseObject): IgtPDPage;
var
  LPage: TgtPDPage;
  LCoPage: TgtCoPDPage;
begin
  LPage := FPDDoc.GetPageByIndRef(TgtHackCoPDBaseObject(APageRef).BaseObject);
  LCoPage := TgtCoPDPage.Create(LPage);
  FObjectList.Add(LCoPage);
  Result := LCoPage;
end;

function TgtCoPDDocument.GetPageCount: Integer;
begin
  Result := FPDDoc.PageCount;
end;

function TgtCoPDDocument.GetViewerPref: IgtPDViewerPreference;
var
  LPDViewerPref: TgtPDViewerPref;
  LCoPDViewerPref: TgtCoPDViewerPreference;
begin
  LPDViewerPref := FPDDoc.GetViewerPref;
  LCoPDViewerPref := TgtCoPDViewerPreference.Create(LPDViewerPref);
  Result := LCoPDViewerPref;
  FObjectList.Add(LCoPDViewerPref);
end;

procedure TgtCoPDDocument.InsertPages(AfterPage: Integer;
  var SourceDoc: IgtPDDocument; SourceStartPage, NumOfPages, InsertFlags: Integer);
var
  LFlag: TgtPageInsertFlages;
begin
  if Ord(InsertFlags) = $00000000 then
    LFlag := InsertBookmarks
  else if Ord(InsertFlags) = $00000001 then
    LFlag := InsertThreads
  else
    LFlag := InsertAll;
  FPDDoc.InsertPages(AfterPage, TgtCoPDDocument(SourceDoc).FPDDoc,
    SourceStartPage, NumOfPages, LFlag);
end;

procedure TgtCoPDDocument.LoadDocument(Stream: TStream; DoRepair: Boolean);
begin
  if Assigned(FPDDoc) then FPDDoc.Free;

  FPDDoc := TgtPDDocument.Create;
  FPDDoc.LoadDocument(Stream, DoRepair);
end;

procedure TgtCoPDDocument.LoadDocument(const FileName: WideString; DoRepair: WordBool);
begin
  if Assigned(FPDDoc) then
    FPDDoc.Free;

  FPDDoc := TgtPDDocument.Create;
  FPDDoc.LoadDocument(FileName, DoRepair);
end;

procedure TgtCoPDDocument.MergeDocs(SourceDoc: IgtPDDocument;
  InsertFlags: Integer);
var
  LFlag: TgtPageInsertFlages;
begin
  if Ord(InsertFlags) = $00000000 then
    LFlag := InsertBookmarks
  else if Ord(InsertFlags) = $00000001 then
    LFlag := InsertThreads
  else
    LFlag := InsertAll;
  FPDDoc.MergeDocs(TgtCoPDDocument(SourceDoc).FPDDoc, LFlag);
end;

procedure TgtCoPDDocument.MovePage(MoveToAfterPage, PageToMove: Integer);
begin
  FPDDoc.MovePage(MoveToAfterPage, PageToMove);
end;

procedure TgtCoPDDocument.ReplacePages(StartPage: Integer;
  SourceDoc: IgtPDDocument; SourceStartPage, NumOfPages: Integer;
  MergeTextAnnots: WordBool);
begin
  FPDDoc.ReplacePages(StartPage, TgtCoPDDocument(SourceDoc).FPDDoc,
    SourceStartPage, NumOfPages, MergeTextAnnots);
end;

procedure TgtCoPDDocument.SaveDocument(Stream: TStream;
  SaveFlags: TPDSaveFlags);
var
  LPDSaveFlags: TgtPDSaveFlags;
begin
  if Assigned(FPDDoc) then
  begin
    with LPDSaveFlags do
    begin
      Incremental := SaveFlags.Incremental;
      Full := SaveFlags.Full;
      Copy := SaveFlags.Copy;
      Linearize := SaveFlags.Linearize;
      UniDirectional := SaveFlags.UniDirectional;
      KeepModDate := SaveFlags.KeepModDate;
      UnCompressed := SaveFlags.UnCompressed;
      Compressed := SaveFlags.Compressed;
      CompressStructureOnly := SaveFlags.CompressStructureOnly;
      RemoveASCIIFilters := SaveFlags.RemoveASCIIFilters;
      AddFlate := SaveFlags.AddFlate;
      ReplaceLZW := SaveFlags.ReplaceLZW;
      OptimizeXObjects := SaveFlags.OptimizeXObjects;
      OptimizeContentStreams := SaveFlags.OptimizeContentStreams;
      OptimizeFonts := SaveFlags.OptimizeFonts;
      OptimizeMarkedJBIG2Dictionaries := SaveFlags.OptimizeMarkedJBIG2Dictionaries;
    end;
    FPDDoc.SaveDocument(Stream, LPDSaveFlags);
  end;
end;

procedure TgtCoPDDocument.SaveDocument(const FileName: WideString;
  SaveFlags: TPDSaveFlags);
var
  LPDSaveFlags: TgtPDSaveFlags;
begin
  if Assigned(FPDDoc) then
  begin
    with LPDSaveFlags do
    begin
      Incremental := SaveFlags.Incremental;
      Full := SaveFlags.Full;
      Copy := SaveFlags.Copy;
      Linearize := SaveFlags.Linearize;
      UniDirectional := SaveFlags.UniDirectional;
      KeepModDate := SaveFlags.KeepModDate;
      UnCompressed := SaveFlags.UnCompressed;
      Compressed := SaveFlags.Compressed;
      CompressStructureOnly := SaveFlags.CompressStructureOnly;
      RemoveASCIIFilters := SaveFlags.RemoveASCIIFilters;
      AddFlate := SaveFlags.AddFlate;
      ReplaceLZW := SaveFlags.ReplaceLZW;
      OptimizeXObjects := SaveFlags.OptimizeXObjects;
      OptimizeContentStreams := SaveFlags.OptimizeContentStreams;
      OptimizeFonts := SaveFlags.OptimizeFonts;
      OptimizeMarkedJBIG2Dictionaries := SaveFlags.OptimizeMarkedJBIG2Dictionaries;
    end;
    FPDDoc.SaveDocument(FileName, LPDSaveFlags);
  end;
end;

end.
