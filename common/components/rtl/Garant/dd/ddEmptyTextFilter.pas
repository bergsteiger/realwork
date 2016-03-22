unit ddEmptyTextFilter;

{ $Id: ddEmptyTextFilter.pas,v 1.3 2015/11/17 10:57:09 fireton Exp $ }

interface

uses
 Classes,
 evdBufferedFilter,
 ddTypes, l3Variant, k2Interfaces, dt_Types;

type
 TddEmptyTextFilter = class(TevdBufferedFilter)
 private
  f_DocType: TDocType;
  f_HasText: Boolean;
  f_NonText: Boolean;
  f_OnError: TddErrorEvent;
  f_IntDocID: TDocID;
  f_ExtDocID: TDocID;
  f_OnFoundEmpty: TNotifyEvent;
 protected
        {* - Функция, определяющая тип Тегов, для которых будет выполняться буферизация.}
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
    // internal methods
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
  procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
  procedure StartChild(TypeID: Tl3VariantDef); override;
  property OnFoundEmpty: TNotifyEvent read f_OnFoundEmpty write f_OnFoundEmpty;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

implementation
uses
 l3Interfaces,
 l3String,
 l3Base,
 k2Base,
 k2Tags,
 LeafPara_Const,
 Document_Const,
 SysUtils,
 StrUtils;

{TddEmptyTextFilter}
procedure TddEmptyTextFilter.AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
var
 l_Text : Tl3WString;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 case AtomIndex of
  k2_tiType:
   begin
    f_DocType := TDocType(Value.AsInteger);
    if not (f_DocType in [dtText, dtRelText, dtAnnotation]) then
     f_NonText := True;
   end;
  k2_tiInternalHandle: f_IntDocID := Value.AsInteger;
  k2_tiExternalHandle: f_ExtDocID := Value.AsInteger;
 end; //case

 if CurrentType.IsKindOf(k2_typLeafPara) and (AtomIndex = k2_tiText) then
 begin
  l_Text := Value.AsString.AsWStr;
  if not l3IsNil(l3Trim(l_Text)) then
   f_HasText := True;
 end;
 inherited;
end;

function TddEmptyTextFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
var
 l_Msg: AnsiString;
begin
 Result := True;
 if not (f_HasText or f_NonText) then
 begin
  if Assigned(f_OnFoundEmpty) then
   f_OnFoundEmpty(Self);
  case f_DocType of
   dtText       : l_Msg := 'документе';
   dtRelText    : l_Msg := 'справке';
   dtAnnotation : l_Msg := 'аннотации';
  else
   l_Msg := 'непонятно чём'; // такого не должно быть в принципе
  end;
  l_Msg := Format('В %s (%s) отсутствует текст!', [
     l_Msg,
     IfThen(f_ExtDocID > 0, IntToStr(f_ExtDocID), '#'+IntToStr(f_IntDocID))]);
  if Assigned(f_OnError) then
   f_OnError(l_Msg)
  else
   l3System.Msg2Log(l_Msg);
 end;
end;

// start class TddEmptyTextFilter

function TddEmptyTextFilter.NeedStartBuffering(aID : Integer): Boolean;
var
 l_Type: Tk2Type;
begin
 Result:= False;
 if aID < 0 then
 begin
  l_Type := TypeTable.TypeByHandle[-aID];
  Result := l_Type.IsKindOf(k2_typDocument);
 end;
end;

procedure TddEmptyTextFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if (SkipLevel = 2) and (f_HasText or f_NonText) then
  StopBufferingAndFlush(False, TopObject[0], False); // не наполняем буфер, если уже выяснили, что это нормальный документ
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  f_HasText := False;
  f_NonText := False;
  f_DocType := dtNone;
  f_ExtDocID := 0;
  f_IntDocID := 0;
 end;
end;

end.