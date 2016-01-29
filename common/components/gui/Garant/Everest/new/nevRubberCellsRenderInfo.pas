unit nevRubberCellsRenderInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevRubberCellsRenderInfo.pas"
// Начат: 06.05.2008 21:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevRubberCellsRenderInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3LongintList,
  nevTableRowRenderInfo,
  nevFormatInfo
  ;

type
 TnevRubberCellsRenderInfo = class(TnevTableRowRenderInfo)
 private
 // private fields
   f_LimitWidth : Integer;
   f_Widthes : Tl3LongintList;
    {* Поле для свойства Widthes}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function ChildWidth(aChild: TnevFormatInfo): Integer; override;
   procedure ChildrenChanged; override;
     {* Нотификация о смене состава детей. }
 protected
 // protected methods
   function WasChanged: Boolean; virtual;
   procedure ClearChangedFlag; virtual;
   procedure ValidateNewChildWidth(anOldWidth: Integer;
    var theNewWidth: Integer); virtual;
 protected
 // protected properties
   property Widthes: Tl3LongintList
     read f_Widthes;
 end;//TnevRubberCellsRenderInfo

implementation

uses
  SysUtils,
  k2Tags,
  l3Math,
  l3MinMax,
  evConst
  ;

// start class TnevRubberCellsRenderInfo

function TnevRubberCellsRenderInfo.WasChanged: Boolean;
//#UC START# *4ED719EE01C1_482098D2015E_var*
//#UC END# *4ED719EE01C1_482098D2015E_var*
begin
//#UC START# *4ED719EE01C1_482098D2015E_impl*
 Result := Abs(f_LimitWidth - LimitWidth) > evEpsilon;
//#UC END# *4ED719EE01C1_482098D2015E_impl*
end;//TnevRubberCellsRenderInfo.WasChanged

procedure TnevRubberCellsRenderInfo.ClearChangedFlag;
//#UC START# *4ED71A110169_482098D2015E_var*
//#UC END# *4ED71A110169_482098D2015E_var*
begin
//#UC START# *4ED71A110169_482098D2015E_impl*
 f_LimitWidth := LimitWidth;
//#UC END# *4ED71A110169_482098D2015E_impl*
end;//TnevRubberCellsRenderInfo.ClearChangedFlag

procedure TnevRubberCellsRenderInfo.ValidateNewChildWidth(anOldWidth: Integer;
  var theNewWidth: Integer);
//#UC START# *4BFD6763012A_482098D2015E_var*
//#UC END# *4BFD6763012A_482098D2015E_var*
begin
//#UC START# *4BFD6763012A_482098D2015E_impl*
 // - нас всегда всё устраивает
//#UC END# *4BFD6763012A_482098D2015E_impl*
end;//TnevRubberCellsRenderInfo.ValidateNewChildWidth

procedure TnevRubberCellsRenderInfo.Cleanup;
//#UC START# *479731C50290_482098D2015E_var*
//#UC END# *479731C50290_482098D2015E_var*
begin
//#UC START# *479731C50290_482098D2015E_impl*
 FreeAndNil(f_Widthes);
 f_LimitWidth := 0;
 inherited;
//#UC END# *479731C50290_482098D2015E_impl*
end;//TnevRubberCellsRenderInfo.Cleanup

function TnevRubberCellsRenderInfo.ChildWidth(aChild: TnevFormatInfo): Integer;
//#UC START# *4820985D0238_482098D2015E_var*
var
 l_Width         : Integer;
 l_Index         : Integer;
 l_NewChildWidth : Integer;
 l_ChildWidth    : Integer;
 l_NewWidth      : Integer;
//#UC END# *4820985D0238_482098D2015E_var*
begin
//#UC START# *4820985D0238_482098D2015E_impl*
 if (f_Widthes = nil) or WasChanged then
 begin
  if (f_Widthes = nil) then
   f_Widthes := Tl3LongintList.Make
  else
   f_Widthes.Clear;
  l_Width := 0;
  with Obj do
  begin
   for l_Index := 0 to Pred(AsObject.ChildrenCount) do
   begin
    l_ChildWidth := Abs(AsObject.Child[l_Index].IntA[k2_tiWidth]);
    // - в Архивариусе падаем, т.к. ижёт загрузка и ширина ещё не определена
    Inc(l_Width, l_ChildWidth);
    f_Widthes.Add(l_ChildWidth);
   end;//for l_Index
  end;//with Obj
  l_NewWidth := LimitWidth;
  if (l_Width > 0) AND (Abs(l_Width - l_NewWidth) > evEpsilon) then
  begin
   for l_Index := 0 to f_Widthes.Hi do
   begin
    l_ChildWidth := f_Widthes[l_Index];
    l_NewChildWidth := l3MulDiv(l_ChildWidth, l_NewWidth, l_Width);
    ValidateNewChildWidth(l_ChildWidth, l_NewChildWidth);
    f_Widthes[l_Index] := l_NewChildWidth;
    Dec(l_Width, l_ChildWidth);
    Dec(l_NewWidth, l_NewChildWidth);
    if (l_Width <= 0) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=93259494
     break;
   end;//for l_Index
  end;//l_Width > 0..
  ClearChangedFlag;
 end;//f_Widthes = nil
 Result := f_Widthes[aChild.Obj.PID];
//#UC END# *4820985D0238_482098D2015E_impl*
end;//TnevRubberCellsRenderInfo.ChildWidth

procedure TnevRubberCellsRenderInfo.ChildrenChanged;
//#UC START# *482161BE001C_482098D2015E_var*
//#UC END# *482161BE001C_482098D2015E_var*
begin
//#UC START# *482161BE001C_482098D2015E_impl*
 inherited;
 FreeAndNil(f_Widthes);
//#UC END# *482161BE001C_482098D2015E_impl*
end;//TnevRubberCellsRenderInfo.ChildrenChanged

end.