unit alcuCourtDecisionListMaker;
{ Формирование списка документов для расстановки меток 20005-30005 }

{ $Id: alcuCourtDecisionListMaker.pas,v 1.3 2014/04/07 10:02:23 lulin Exp $ }
// $Log: alcuCourtDecisionListMaker.pas,v $
// Revision 1.3  2014/04/07 10:02:23  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2011/10/17 10:09:26  narry
// Формирование списка документов для расстановки (293276752)
//
// Revision 1.1  2011/10/14 10:27:48  narry
// При расстановке меток в процессе заливки ФАСов портится текст (293277407)
//

interface

uses
  k2Interfaces, k2TagGen, dd_lcBaseFilter, ddTypes, IniFiles;

type
 TalcuCourtDecisionListMaker = class(Tdd_lcBaseHeaderFilter)
 private
  f_DocList: TiniFile;
  f_FileName: string;
  procedure pm_SetFileName(const Value: string);
  property FileName: string read f_FileName write pm_SetFileName;
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
  procedure Cleanup; override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; const aFileName:
      String; aCategory: Integer; aOnError: TddErrorEvent): Pointer; overload;
 end;

implementation

uses
  l3Base, SysUtils, k2tags;

procedure TalcuCourtDecisionListMaker.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Tag: Tl3Variant;
 l_Section: ShortString;
 l_Count: Integer;
begin
 // Нужно найти источник и номер документа
 l_Tag:= aHeaderRoot.Attr[k2_tiSources];
 if l_Tag.IsValid then
 begin
  if l_Tag.ChildrenCount > 0 then
  begin
   l_Section:= l_Tag.Child[0].StrA[k2_tiName];
   l_Count:= Succ(f_DocList.ReadInteger(l_Section, 'Count', 0));
   f_DocList.WriteInteger(l_Section, 'Count', l_Count);
   f_DocList.WriteInteger(l_Section, 'Doc'+IntToStr(l_Count), aHeaderRoot.IntA[k2_tiExternalhandle]);
  end;
 end;
end;

procedure TalcuCourtDecisionListMaker.Cleanup;
begin
 inherited;
 FreeAndNil(f_DocList);
end;

procedure TalcuCourtDecisionListMaker.pm_SetFileName(const Value: string);
begin
 FreeAndNil(f_DocList);
 f_FileName := Value;
 f_DocList:= TIniFile.Create(Value);
end;

class function TalcuCourtDecisionListMaker.SetTo(var theGenerator:
    Tk2TagGenerator; const aFileName: String; aCategory: Integer; aOnError:
    TddErrorEvent): Pointer;
var
 l_Filter : TalcuCourtDecisionListMaker;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l_Filter.FileName:= aFileName;
  l3Set(theGenerator, l_Filter);
 finally
  FreeAndNil(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
