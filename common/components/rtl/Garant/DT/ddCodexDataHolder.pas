unit ddCodexDataHolder;

{ $Id: ddCodexDataHolder.pas,v 1.2 2016/07/18 10:49:49 fireton Exp $ }

interface

uses
  l3Types,
  l3ProtoObject,
  l3StringList,
  dt_Types,
  ddAutolinkInterfaces;

type
 TCodexDataHolder = class(Tl3ProtoObject, ICodexDataHolder)
 private
  f_ActualEdition: TddALDocRec;
  f_Abbreviations: Tl3StringList;
  {---}
  function Get_Abbreviations: Tl3StringList;
  function Get_ActualEdition: TddALDocRec;
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aActualEdition: TDocID);

  class function Make(const aActualEdition: TDocID): ICodexDataHolder;
 end;

implementation
uses
 SysUtils,
 ddAutolinkUtils;

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

function TCodexDataHolder.Get_Abbreviations: Tl3StringList;
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

function TCodexDataHolder.Get_ActualEdition: TddALDocRec;
begin
 Result := f_ActualEdition;
end;

end.