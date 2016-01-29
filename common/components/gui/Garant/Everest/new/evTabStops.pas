unit evTabStops;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/evTabStops.pas"
// Начат: 15.05.2003 19:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TevTabStops
//
// Позиции табуляции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  l3Interfaces,
  l3CacheableBase,
  l3StringList,
  l3Const,
  l3LongintList,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevTabStops = class(Tl3CacheableBase, Il3TabStops)
  {* Позиции табуляции }
 private
 // private fields
   f_TabStop : Tl3TabStop;
   f_TabStops : Tl3Variant;
   f_Index : Integer;
   f_Fillers : Tl3StringList;
   f_FillerIndex : Integer;
   f_Styles : Tl3LongintList;
   f_StyleIndex : Integer;
 protected
 // realized methods
   function Clone: Il3TabStops;
     {* клонирует позиции табуляции. }
   function Next: Tl3TabStop;
     {* следующая позиция табуляции. }
   function Filler: Tl3WString;
     {* следующий символ-заполнитель. }
   function Style: Tl3TabStopStyle;
     {* следующий стиль. }
   function NeedCutByTab: Boolean;
   procedure Reset;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aTabStops: Tl3Variant); reintroduce;
   class function Make(aTabStopsHolder: Tl3Variant): Il3TabStops;
 end;//TevTabStops
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  l3Base,
  l3String,
  k2Tags,
  k2Base,
  SysUtils
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

const
   { Constants }
  cTabWidth = l3Const.l3Inch  div 2;

// start class TevTabStops

constructor TevTabStops.Create(aTabStops: Tl3Variant);
//#UC START# *48D10637008F_48D1055203B8_var*
//#UC END# *48D10637008F_48D1055203B8_var*
begin
//#UC START# *48D10637008F_48D1055203B8_impl*
 inherited Create;
 Assert(aTabStops <> nil);
 aTabStops.SetRef(f_TabStops);
 f_Index := 0;
 f_FillerIndex := 0;
 f_StyleIndex := 0;
 l3FillChar(f_TabStop, SizeOf(f_TabStop));
//#UC END# *48D10637008F_48D1055203B8_impl*
end;//TevTabStops.Create

class function TevTabStops.Make(aTabStopsHolder: Tl3Variant): Il3TabStops;
//#UC START# *48D1067302B6_48D1055203B8_var*
var
 l_TabStops  : TevTabStops;
 l_ATabStops : Tl3Variant;
//#UC END# *48D1067302B6_48D1055203B8_var*
begin
//#UC START# *48D1067302B6_48D1055203B8_impl*
 l_ATabStops := aTabStopsHolder.Attr[k2_tiTabStops];
 if l_ATabStops.IsValid then
 begin
  l_TabStops := Create(l_ATabStops);
  try
   Result := l_TabStops;
  finally
   l3Free(l_TabStops);
  end;//try..finally
 end//l_ATabStops.IsValid
 else
  Result := nil;
//#UC END# *48D1067302B6_48D1055203B8_impl*
end;//TevTabStops.Make

function TevTabStops.Clone: Il3TabStops;
//#UC START# *4728A3E40136_48D1055203B8_var*
var
 l_TabStops : TevTabStops;
//#UC END# *4728A3E40136_48D1055203B8_var*
begin
//#UC START# *4728A3E40136_48D1055203B8_impl*
 l_TabStops := TevTabStops.Create(f_TabStops);
 try
  l_TabStops.f_Index := f_Index;
  l_TabStops.f_TabStop := f_TabStop;
  if (f_Fillers <> nil) then
   l_TabStops.f_Fillers := f_Fillers.Clone;
  l_TabStops.f_FillerIndex := f_FillerIndex;
  if (f_Styles <> nil) then
   l_TabStops.f_Styles := f_Styles.Clone;
  l_TabStops.f_StyleIndex := f_StyleIndex;
  Result := l_TabStops;
 finally
  l3Free(l_TabStops);
 end;//try..finally
//#UC END# *4728A3E40136_48D1055203B8_impl*
end;//TevTabStops.Clone

function TevTabStops.Next: Tl3TabStop;
//#UC START# *4728A3F5019F_48D1055203B8_var*
var
 l_TabStop : Tl3Variant;
//#UC END# *4728A3F5019F_48D1055203B8_var*
begin
//#UC START# *4728A3F5019F_48D1055203B8_impl*
 if (f_Index < 0) then begin
  Inc(f_TabStop.rPosition, cTabWidth);
 end else begin
  if (f_Index < f_TabStops.ChildrenCount) then
  begin
   l_TabStop := f_TabStops.Child[f_Index];
   Inc(f_Index);
  end else begin
   l_TabStop := k2NullTag;
   f_Index := -1;
  end;//f_Index < f_TabStops.ChildrenCount
  if l_TabStop.IsValid then begin
   f_TabStop.rPosition := l_TabStop.IntA[k2_tiStart];
   f_TabStop.rStyle := Tl3TabStopStyle(l_TabStop.IntA[k2_tiType]);
   with l_TabStop.Attr[k2_tiText] do
    if IsValid then
     f_TabStop.rFiller := (AsObject As Tl3CustomString).AsPCharLen
    else
     l3AssignNil(f_TabStop.rFiller);
   if (f_Fillers = nil) then
    f_Fillers := Tl3StringList.Make;
   f_Fillers.Add(f_TabStop.rFiller);  
   if (f_Styles = nil) then
    f_Styles := Tl3LongintList.Make;
   f_Styles.Add(Integer(f_TabStop.rStyle));  
   //l_TabStop.IsValid
  end else begin
   f_TabStop.rPosition := ((f_TabStop.rPosition + cTabWidth) div cTabWidth) * cTabWidth;
   f_TabStop.rStyle := l3_tssLeft;
   l3AssignNil(f_TabStop.rFiller);
  end;//l_TabStop.IsValid
 end;//f_Index < 0
 Result := f_TabStop;
//#UC END# *4728A3F5019F_48D1055203B8_impl*
end;//TevTabStops.Next

function TevTabStops.Filler: Tl3WString;
//#UC START# *4728A43101E1_48D1055203B8_var*
//#UC END# *4728A43101E1_48D1055203B8_var*
begin
//#UC START# *4728A43101E1_48D1055203B8_impl*
 l3AssignNil(Result);
 if not f_Fillers.Empty then
  if (f_FillerIndex < f_Fillers.Count) then begin
   Result := Tl3CustomString(f_Fillers.Items[f_FillerIndex]).AsPCharLen;
   Inc(f_FillerIndex);
  end else begin
   f_Fillers.Clear;
   f_FillerIndex := 0;
  end;//f_FillerIndex < f_Fillers.Count
//#UC END# *4728A43101E1_48D1055203B8_impl*
end;//TevTabStops.Filler

function TevTabStops.Style: Tl3TabStopStyle;
//#UC START# *4728A44801A8_48D1055203B8_var*
//#UC END# *4728A44801A8_48D1055203B8_var*
begin
//#UC START# *4728A44801A8_48D1055203B8_impl*
 Result := l3_tssLeft;
 if not f_Styles.Empty then
  if (f_StyleIndex < f_Styles.Count) then begin
   Result := Tl3TabStopStyle(f_Styles.Items[f_StyleIndex]);
   Inc(f_StyleIndex);
  end else begin
   f_Styles.Clear;
   f_StyleIndex := 0;
  end;//f_StyleIndex < f_Styles.Count
//#UC END# *4728A44801A8_48D1055203B8_impl*
end;//TevTabStops.Style

function TevTabStops.NeedCutByTab: Boolean;
//#UC START# *4728A45A001E_48D1055203B8_var*
//#UC END# *4728A45A001E_48D1055203B8_var*
begin
//#UC START# *4728A45A001E_48D1055203B8_impl*
 Result := False; 
//#UC END# *4728A45A001E_48D1055203B8_impl*
end;//TevTabStops.NeedCutByTab

procedure TevTabStops.Reset;
//#UC START# *4728A46800A0_48D1055203B8_var*
//#UC END# *4728A46800A0_48D1055203B8_var*
begin
//#UC START# *4728A46800A0_48D1055203B8_impl*
 f_Index := 0;
//#UC END# *4728A46800A0_48D1055203B8_impl*
end;//TevTabStops.Reset

procedure TevTabStops.Cleanup;
//#UC START# *479731C50290_48D1055203B8_var*
//#UC END# *479731C50290_48D1055203B8_var*
begin
//#UC START# *479731C50290_48D1055203B8_impl*
 FreeAndNil(f_TabStops);
 l3Free(f_Fillers);
 l3Free(f_Styles);
 inherited;
//#UC END# *479731C50290_48D1055203B8_impl*
end;//TevTabStops.Cleanup

{$IfEnd} //k2ForEditor

end.