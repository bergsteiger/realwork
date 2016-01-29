unit ddCustomAutolinkDataLoader;

{ $Id: ddCustomAutolinkDataLoader.pas,v 1.2 2014/06/20 12:50:47 fireton Exp $ }

interface

uses
  l3InterfaceList, l3LongintList, l3String, l3StringList, l3ProtoObject,
  m4DictScanner,
  dt_Types,
  ddCSV, ddBaseAutoLinkDataSource;

type
 TddCustomAutolinkDataLoader = class(TddSectionedCSVLoader)
 protected
  f_CodexData: Tl3InterfaceList;
  f_LoneTypesList: Tl3LongintList;
  procedure DispatchSection; override;
  procedure LoadCodexes; virtual; abstract;
  procedure LoadFedLaws; virtual; abstract;
  procedure LoadLoneTypes; virtual; abstract;
  procedure LoadTypeSyns; virtual; abstract;
 public
  constructor Create(const aFileName: string; aCodexData: Tl3InterfaceList; aLoneTypeList: Tl3LongintList);
 end;

type
 ICodexDataHolder = interface
  function pm_GetAbbreviations: Tl3StringList;
  function pm_GetActualEdition: TddALDocRec;
  property Abbreviations: Tl3StringList read pm_GetAbbreviations;
  property ActualEdition: TddALDocRec read pm_GetActualEdition; // актуальная редакция кодекса
 end;

type
 TCodexDataHolder = class(Tl3ProtoObject, ICodexDataHolder)
 private
  f_ActualEdition: TddALDocRec;
  f_Abbreviations: Tl3StringList;
  {---}
  function pm_GetAbbreviations: Tl3StringList;
  function pm_GetActualEdition: TddALDocRec;
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aActualEdition: TDocID);

  class function Make(const aActualEdition: TDocID): ICodexDataHolder;
 end;

const
 cShortNameDictID      = -154;
 cSkippiesDictID       = -155;
 cCodexDictID          = -156;
 cCodexAbbrDictID      = -157;
 cCodexSpecials        = -158;
 cCodexKeywordsDictID  = -159;
 cStopWordsDictID      = -160;

 cDummyID = 1234567;

 ctc_CodexName    = 0;
 ctc_Abbreviation = 1;
 ctc_DocumentID   = 2;
 ctc_Keywords     = 3;

 cs_Further = 1; // "далее"

implementation

uses
  SysUtils,

  l3Types,
  l3Interfaces,
  l3Base,

  DT_Const;

constructor TddCustomAutolinkDataLoader.Create(const aFileName: string; aCodexData: Tl3InterfaceList;
    aLoneTypeList: Tl3LongintList);
begin
 inherited Create(aFileName, True);
 f_CodexData := aCodexData;
 f_LoneTypesList := aLoneTypeList;
end;

procedure TddCustomAutolinkDataLoader.DispatchSection;
begin
 if l3Same(SectName, 'codex', True) then
  LoadCodexes
 else
 if l3Same(SectName, 'fedlaws', True) then
  LoadFedLaws
 else
 if l3Same(SectName, 'lonetypes', True) then
  LoadLoneTypes
 else
 if l3Same(SectName, 'typesynonyms', True) then
  LoadTypeSyns
 else
  SkipSection;
end;

constructor TCodexDataHolder.Create(const aActualEdition: TDocID);
begin
 inherited Create;
 f_Abbreviations := Tl3StringList.MakeSorted;
 f_Abbreviations.SortIndex := l3_siCaseUnsensitive;
 f_ActualEdition := ddFillALDocRecFromExtDocID(aActualEdition);
end;

procedure TCodexDataHolder.Cleanup;
begin
 FreeAndNil(f_Abbreviations);
 inherited;
end;

function TCodexDataHolder.pm_GetAbbreviations: Tl3StringList;
begin
 Result := f_Abbreviations;
end;

class function TCodexDataHolder.Make(const aActualEdition: TDocID): ICodexDataHolder;
var
 l_Holder : TCodexDataHolder;
begin
 l_Holder := TCodexDataHolder.Create(aActualEdition);
 try
  Result := l_Holder;
 finally
  FreeAndNil(l_Holder);
 end;
end;

function TCodexDataHolder.pm_GetActualEdition: TddALDocRec;
begin
 Result := f_ActualEdition;
end;

end.
