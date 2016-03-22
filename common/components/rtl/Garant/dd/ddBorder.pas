unit ddBorder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddBorder.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddBorder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddPropertyObject,
  RTFtypes,
  ddBorderPart,
  ddTypes,
  k2Interfaces
  ;

type
 TddBorderPartArray = array [TddBorderParts] of TddBorderPart;

 TddBorder = class(TddPropertyObject)
 private
 // private fields
   f_BorderParts : TddBorderPartArray;
   f_BorderOwner : TddBorderOwner;
    {* Поле для свойства BorderOwner}
 private
 // private methods
   function HasAllFramePart: Boolean;
 protected
 // property methods
   function pm_GetFrameColor(anIndex: TddBorderParts): LongInt;
   procedure pm_SetFrameColor(anIndex: TddBorderParts; aValue: LongInt);
   function pm_GetFrameSpace(anIndex: TddBorderParts): LongInt;
   procedure pm_SetFrameSpace(anIndex: TddBorderParts; aValue: LongInt);
   function pm_GetFrameWidth(anIndex: TddBorderParts): LongInt;
   procedure pm_SetFrameWidth(anIndex: TddBorderParts; aValue: LongInt);
   function pm_GetFrames(anIndex: TddBorderParts): TddBorderPart;
   procedure pm_SetFrames(anIndex: TddBorderParts; aValue: TddBorderPart);
   function pm_GetIsFramed: Boolean;
   procedure pm_SetIsFramed(aValue: Boolean);
   function pm_GetFrameType(anIndex: TddBorderParts): TddBorderType;
   procedure pm_SetFrameType(anIndex: TddBorderParts; aValue: TddBorderType);
 protected
 // realized methods
   procedure MergeWith(P: TddPropertyObject); override;
   procedure InheriteFrom(P: TddPropertyObject); override;
   procedure Write2Generator(const Generator: Ik2TagGenerator); override;
   procedure Reset; override;
   function Diff(P: TddPropertyObject;
     aForReader: Boolean): TddPropertyObject; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create; override;
     {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
   procedure Clear; override;
   function JoinWith(P: TObject): LongInt; override;
   procedure AssignFrom(anOther: TddPropertyObject); override;
 public
 // public properties
   property BorderOwner: TddBorderOwner
     read f_BorderOwner
     write f_BorderOwner;
   property FrameColor[anIndex: TddBorderParts]: LongInt
     read pm_GetFrameColor
     write pm_SetFrameColor;
   property FrameSpace[anIndex: TddBorderParts]: LongInt
     read pm_GetFrameSpace
     write pm_SetFrameSpace;
   property FrameWidth[anIndex: TddBorderParts]: LongInt
     read pm_GetFrameWidth
     write pm_SetFrameWidth;
   property Frames[anIndex: TddBorderParts]: TddBorderPart
     read pm_GetFrames
     write pm_SetFrames;
   property IsFramed: Boolean
     read pm_GetIsFramed
     write pm_SetIsFramed;
   property FrameType[anIndex: TddBorderParts]: TddBorderType
     read pm_GetFrameType
     write pm_SetFrameType;
 end;//TddBorder

implementation

uses
  k2Tags,
  l3Base,
  evdFrame_Const
  ;

// start class TddBorder

function TddBorder.HasAllFramePart: Boolean;
//#UC START# *525E37C80295_4F6843EE00B1_var*
//#UC END# *525E37C80295_4F6843EE00B1_var*
begin
//#UC START# *525E37C80295_4F6843EE00B1_impl*
 Result := (Frames[bpTop].Enable) and
           (Frames[bpLeft].Enable) and
           (Frames[bpBottom].Enable) and
           (Frames[bpRight].Enable);
//#UC END# *525E37C80295_4F6843EE00B1_impl*
end;//TddBorder.HasAllFramePart

function TddBorder.pm_GetFrameColor(anIndex: TddBorderParts): LongInt;
//#UC START# *525E3AC602FD_4F6843EE00B1get_var*
//#UC END# *525E3AC602FD_4F6843EE00B1get_var*
begin
//#UC START# *525E3AC602FD_4F6843EE00B1get_impl*
 if Frames[anIndex].Color > 0 then
  Result := Frames[anIndex].Color
 else
  Result := 0;
//#UC END# *525E3AC602FD_4F6843EE00B1get_impl*
end;//TddBorder.pm_GetFrameColor

procedure TddBorder.pm_SetFrameColor(anIndex: TddBorderParts; aValue: LongInt);
//#UC START# *525E3AC602FD_4F6843EE00B1set_var*
//#UC END# *525E3AC602FD_4F6843EE00B1set_var*
begin
//#UC START# *525E3AC602FD_4F6843EE00B1set_impl*
 if anIndex = bpBox then
 begin
  FrameColor[bpTop] := aValue;
  FrameColor[bpLeft] := aValue;
  FrameColor[bpRight] := aValue;
  FrameColor[bpBottom] := aValue;
 end // if Index = bpBox then
 else
 if Frames[anIndex].Color <> aValue then
   Frames[anIndex].Color := aValue;
//#UC END# *525E3AC602FD_4F6843EE00B1set_impl*
end;//TddBorder.pm_SetFrameColor

function TddBorder.pm_GetFrameSpace(anIndex: TddBorderParts): LongInt;
//#UC START# *525E3B770074_4F6843EE00B1get_var*
//#UC END# *525E3B770074_4F6843EE00B1get_var*
begin
//#UC START# *525E3B770074_4F6843EE00B1get_impl*
 Result := Frames[anIndex].Space;
//#UC END# *525E3B770074_4F6843EE00B1get_impl*
end;//TddBorder.pm_GetFrameSpace

procedure TddBorder.pm_SetFrameSpace(anIndex: TddBorderParts; aValue: LongInt);
//#UC START# *525E3B770074_4F6843EE00B1set_var*
//#UC END# *525E3B770074_4F6843EE00B1set_var*
begin
//#UC START# *525E3B770074_4F6843EE00B1set_impl*
  Frames[anIndex].Space := aValue;
//#UC END# *525E3B770074_4F6843EE00B1set_impl*
end;//TddBorder.pm_SetFrameSpace

function TddBorder.pm_GetFrameWidth(anIndex: TddBorderParts): LongInt;
//#UC START# *525E3BE60384_4F6843EE00B1get_var*
//#UC END# *525E3BE60384_4F6843EE00B1get_var*
begin
//#UC START# *525E3BE60384_4F6843EE00B1get_impl*
 if Frames[anIndex].Width > 0 then
  Result := Frames[anIndex].Width
 else
  Result := 0;
//#UC END# *525E3BE60384_4F6843EE00B1get_impl*
end;//TddBorder.pm_GetFrameWidth

procedure TddBorder.pm_SetFrameWidth(anIndex: TddBorderParts; aValue: LongInt);
//#UC START# *525E3BE60384_4F6843EE00B1set_var*
//#UC END# *525E3BE60384_4F6843EE00B1set_var*
begin
//#UC START# *525E3BE60384_4F6843EE00B1set_impl*
 if anIndex = bpBox then
 begin
  FrameWidth[bpTop] := aValue;
  FrameWidth[bpLeft] := aValue;
  FrameWidth[bpRight] := aValue;
  FrameWidth[bpBottom] := aValue;
 end
 else
  if Frames[anIndex].Width <> aValue then
   Frames[anIndex].Width := aValue;
 IsDefault := False;
//#UC END# *525E3BE60384_4F6843EE00B1set_impl*
end;//TddBorder.pm_SetFrameWidth

function TddBorder.pm_GetFrames(anIndex: TddBorderParts): TddBorderPart;
//#UC START# *525E3C2200C4_4F6843EE00B1get_var*
//#UC END# *525E3C2200C4_4F6843EE00B1get_var*
begin
//#UC START# *525E3C2200C4_4F6843EE00B1get_impl*
 Result := f_BorderParts[anIndex];
//#UC END# *525E3C2200C4_4F6843EE00B1get_impl*
end;//TddBorder.pm_GetFrames

procedure TddBorder.pm_SetFrames(anIndex: TddBorderParts; aValue: TddBorderPart);
//#UC START# *525E3C2200C4_4F6843EE00B1set_var*
//#UC END# *525E3C2200C4_4F6843EE00B1set_var*
begin
//#UC START# *525E3C2200C4_4F6843EE00B1set_impl*
 Frames[anIndex].Assign(aValue);
//#UC END# *525E3C2200C4_4F6843EE00B1set_impl*
end;//TddBorder.pm_SetFrames

function TddBorder.pm_GetIsFramed: Boolean;
//#UC START# *525E3C830125_4F6843EE00B1get_var*
//#UC END# *525E3C830125_4F6843EE00B1get_var*
begin
//#UC START# *525E3C830125_4F6843EE00B1get_impl*
 Result := (Frames[bpTop].Enable) or
           (Frames[bpLeft].Enable) or
           (Frames[bpBottom].Enable) or
           (Frames[bpRight].Enable);
//#UC END# *525E3C830125_4F6843EE00B1get_impl*
end;//TddBorder.pm_GetIsFramed

procedure TddBorder.pm_SetIsFramed(aValue: Boolean);
//#UC START# *525E3C830125_4F6843EE00B1set_var*
//#UC END# *525E3C830125_4F6843EE00B1set_var*
begin
//#UC START# *525E3C830125_4F6843EE00B1set_impl*
 if aValue <> IsFramed then
 begin
  Frames[bpTop].Enable := aValue;
  Frames[bpLeft].Enable := aValue;
  Frames[bpBottom].Enable := aValue;
  Frames[bpRight].Enable := aValue;
 end
//#UC END# *525E3C830125_4F6843EE00B1set_impl*
end;//TddBorder.pm_SetIsFramed

function TddBorder.pm_GetFrameType(anIndex: TddBorderParts): TddBorderType;
//#UC START# *525E3CE90105_4F6843EE00B1get_var*
//#UC END# *525E3CE90105_4F6843EE00B1get_var*
begin
//#UC START# *525E3CE90105_4F6843EE00B1get_impl*
 Result := Frames[anIndex].FrameType
//#UC END# *525E3CE90105_4F6843EE00B1get_impl*
end;//TddBorder.pm_GetFrameType

procedure TddBorder.pm_SetFrameType(anIndex: TddBorderParts; aValue: TddBorderType);
//#UC START# *525E3CE90105_4F6843EE00B1set_var*
//#UC END# *525E3CE90105_4F6843EE00B1set_var*
begin
//#UC START# *525E3CE90105_4F6843EE00B1set_impl*
 if anIndex = bpBox then
 begin
  FrameType[bpTop] := aValue;
  FrameType[bpLeft] := aValue;
  FrameType[bpRight] := aValue;
  FrameType[bpBottom] := aValue;
  Frames[bpTop].Enable := aValue <> btNone;
  Frames[bpLeft].Enable := aValue <> btNone;
  Frames[bpBottom].Enable := aValue <> btNone;
  Frames[bpRight].Enable := aValue <> btNone;
 end
 else
 if Frames[anIndex].FrameType <> aValue then
 begin
  Frames[anIndex].FrameType := aValue;
  Frames[anIndex].Enable := aValue <> btNone;
 end;
//#UC END# *525E3CE90105_4F6843EE00B1set_impl*
end;//TddBorder.pm_SetFrameType

procedure TddBorder.MergeWith(P: TddPropertyObject);
//#UC START# *525E369F0158_4F6843EE00B1_var*
var
 aBorder: TddBorder absolute P;
 index: TddBorderParts;
//#UC END# *525E369F0158_4F6843EE00B1_var*
begin
//#UC START# *525E369F0158_4F6843EE00B1_impl*
 if (P Is TddBorder) then
 begin
  IsDefault := False;
  for index := Low(TddBorderParts) to High(TddBorderParts) do
   if (aBorder.FrameType[Index] <> btNone) and (aBorder.FrameType[index] <> FrameType[index]) then
     Frames[index] := aBorder.Frames[Index];
 end // if (P Is TddBorder) then
 else
  inherited AssignFrom(P);
//#UC END# *525E369F0158_4F6843EE00B1_impl*
end;//TddBorder.MergeWith

procedure TddBorder.InheriteFrom(P: TddPropertyObject);
//#UC START# *525E37430345_4F6843EE00B1_var*
var
 aBorder: TddBorder absolute P;
 index: TddBorderParts;
//#UC END# *525E37430345_4F6843EE00B1_var*
begin
//#UC START# *525E37430345_4F6843EE00B1_impl*
 if (P Is TddBorder) then
 begin
  IsDefault := False;
  for index := Low(TddBorderParts) to High(TddBorderParts) do
   if (aBorder.FrameType[Index] <> btNone) and (FrameType[index] <> btNone) then
     Frames[index] := aBorder.Frames[Index];
 end
 else
  inherited AssignFrom(P);
//#UC END# *525E37430345_4F6843EE00B1_impl*
end;//TddBorder.InheriteFrom

procedure TddBorder.Write2Generator(const Generator: Ik2TagGenerator);
//#UC START# *525E377B007E_4F6843EE00B1_var*
const
  k2: Array[TddBorderParts] of Longint = (k2Tags.k2_tiFrameUp, k2Tags.k2_tiFrameLeft, k2Tags.k2_tiFrameDown, k2Tags.k2_tiFrameRight, 0, 0, 0);
var
  i: TddBorderParts;
//#UC END# *525E377B007E_4F6843EE00B1_var*
begin
//#UC START# *525E377B007E_4F6843EE00B1_impl*
 if IsFramed then
 begin
  if HasAllFramePart then Exit; 
  Generator.StartTag(k2_tiFrame);  { рамка }
  try
   for i := bpTop to bpRight do
    if (FrameType[i] <> btNone) then
    begin
     Generator.StartTag(k2[i]);
     try
      Generator.AddIntegerAtom(k2_tiLineType, Ord(FrameType[i]) - 1);
      Generator.AddIntegerAtom(k2_tiWidth, FrameWidth[i]);
     finally
      Generator.Finish;
     end;
    end;{FrameType[i] <> btNone}
  finally
   Generator.Finish;
  end;{try..finally}
 end {IsFramed}
 else
  if f_BorderOwner = boCell then
   Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
//#UC END# *525E377B007E_4F6843EE00B1_impl*
end;//TddBorder.Write2Generator

procedure TddBorder.Reset;
//#UC START# *525E478A0232_4F6843EE00B1_var*
//#UC END# *525E478A0232_4F6843EE00B1_var*
begin
//#UC START# *525E478A0232_4F6843EE00B1_impl*
//#UC END# *525E478A0232_4F6843EE00B1_impl*
end;//TddBorder.Reset

function TddBorder.Diff(P: TddPropertyObject;
  aForReader: Boolean): TddPropertyObject;
//#UC START# *525E47E10065_4F6843EE00B1_var*
//#UC END# *525E47E10065_4F6843EE00B1_var*
begin
//#UC START# *525E47E10065_4F6843EE00B1_impl*
 Result := nil;
//#UC END# *525E47E10065_4F6843EE00B1_impl*
end;//TddBorder.Diff

constructor TddBorder.Create;
//#UC START# *47914F960008_4F6843EE00B1_var*
var
 i: TddBorderParts;
//#UC END# *47914F960008_4F6843EE00B1_var*
begin
//#UC START# *47914F960008_4F6843EE00B1_impl*
 inherited;
 for i:= Low(TddBorderParts) to High(TddBorderParts) do
  f_BorderParts[i] := TddBorderPart.Create;
 IsFramed := False;
//#UC END# *47914F960008_4F6843EE00B1_impl*
end;//TddBorder.Create

procedure TddBorder.Cleanup;
//#UC START# *479731C50290_4F6843EE00B1_var*
var
 i: TddBorderParts;
//#UC END# *479731C50290_4F6843EE00B1_var*
begin
//#UC START# *479731C50290_4F6843EE00B1_impl*
 for i:= Low(TddBorderParts) to High(TddBorderParts) do
  l3Free(f_BorderParts[i]);
 inherited;
//#UC END# *479731C50290_4F6843EE00B1_impl*
end;//TddBorder.Cleanup

procedure TddBorder.Clear;
//#UC START# *518A13330058_4F6843EE00B1_var*
var
 i: TddBorderParts;
//#UC END# *518A13330058_4F6843EE00B1_var*
begin
//#UC START# *518A13330058_4F6843EE00B1_impl*
 inherited Clear;
 for i := Low(TddBorderParts) to High(TddBorderParts) do
  f_BorderParts[i].Clear;
 f_BorderOwner := boPara;
//#UC END# *518A13330058_4F6843EE00B1_impl*
end;//TddBorder.Clear

function TddBorder.JoinWith(P: TObject): LongInt;
//#UC START# *525E47BE030D_4F6843EE00B1_var*
var
 l_Index : TddBorderParts;
 l_Border: TddBorder;
//#UC END# *525E47BE030D_4F6843EE00B1_var*
begin
//#UC START# *525E47BE030D_4F6843EE00B1_impl*
 if (P Is TddBorder) then
 begin
  Result := 0;
  IsDefault := False;
  l_Border := P as TddBorder;
  for l_Index := Low(TddBorderParts) to High(TddBorderParts) do
   if (FrameType[l_Index] = btNone) then
    Frames[l_Index] := l_Border.Frames[l_Index];
 end // if (P Is TddBorder) then
 else
  Result := JoinWith(P as TddPropertyObject);
//#UC END# *525E47BE030D_4F6843EE00B1_impl*
end;//TddBorder.JoinWith

procedure TddBorder.AssignFrom(anOther: TddPropertyObject);
//#UC START# *5301DFE6002C_4F6843EE00B1_var*
var
 i: TddBorderParts;
//#UC END# *5301DFE6002C_4F6843EE00B1_var*
begin
//#UC START# *5301DFE6002C_4F6843EE00B1_impl*
 if (anOther Is TddBorder) then
 begin
  for i := Low(TddBorderParts) to High(TddBorderParts) do
    f_BorderParts[i].Assign(TddBorder(anOther).F_BorderParts[i]);
  f_BorderOwner := TddBorder(anOther).BorderOwner;
 end // if (aBorder Is TddBorder) then
 else
  inherited AssignFrom(anOther);
//#UC END# *5301DFE6002C_4F6843EE00B1_impl*
end;//TddBorder.AssignFrom

end.