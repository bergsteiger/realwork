unit nevReqRowFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevReqRowFormatInfo.pas"
// Начат: 14.09.2011 13:21
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevReqRowFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevSBSRowFormatInfo
  ;

type
 TnevReqRowFormatInfo = class(TnevSBSRowFormatInfo)
 private
 // private fields
   f_EditorControlIndex : Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function IsCellChildSpacingEqual(anIndex: Integer): Boolean; override;
 end;//TnevReqRowFormatInfo

implementation

uses
  evControlParaConst,
  k2Tags,
  evdTypes,
  l3Variant
  ;

// start class TnevReqRowFormatInfo

procedure TnevReqRowFormatInfo.Cleanup;
//#UC START# *479731C50290_4E7071FD01E9_var*
//#UC END# *479731C50290_4E7071FD01E9_var*
begin
//#UC START# *479731C50290_4E7071FD01E9_impl*
 f_EditorControlIndex := -1;
 inherited;
//#UC END# *479731C50290_4E7071FD01E9_impl*
end;//TnevReqRowFormatInfo.Cleanup

procedure TnevReqRowFormatInfo.InitFields;
//#UC START# *47A042E100E2_4E7071FD01E9_var*
//#UC END# *47A042E100E2_4E7071FD01E9_var*
begin
//#UC START# *47A042E100E2_4E7071FD01E9_impl*
 f_EditorControlIndex := -1;
 inherited;
//#UC END# *47A042E100E2_4E7071FD01E9_impl*
end;//TnevReqRowFormatInfo.InitFields

function TnevReqRowFormatInfo.IsCellChildSpacingEqual(anIndex: Integer): Boolean;
//#UC START# *50A37A030343_4E7071FD01E9_var*

 function lp_CheckChild(aChild: Tl3Variant; anIndex: Integer): Boolean;
 begin
  Result := not (TevControlType(aChild.Child[0].IntA[k2_tiType]) in evEditControls);
  if not Result then
   f_EditorControlIndex := anIndex;
 end;

//#UC END# *50A37A030343_4E7071FD01E9_var*
begin
//#UC START# *50A37A030343_4E7071FD01E9_impl*
 if f_EditorControlIndex < 0 then
 begin
  f_EditorControlIndex := 0;
  Obj.AsObject.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckChild))
 end; // if f_EditorControlIndex < 0 then
 Result := anIndex = f_EditorControlIndex;
//#UC END# *50A37A030343_4E7071FD01E9_impl*
end;//TnevReqRowFormatInfo.IsCellChildSpacingEqual

end.