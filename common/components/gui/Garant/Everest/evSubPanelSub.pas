unit evSubPanelSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evSubPanelSub.pas"
// Начат: 26.02.2010 17:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::SubPanel::TevSubPanelSub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Types,
  l3Units,
  nevTools,
  l3ProtoObject
  ;

type
 TevSubPanelSub = class(Tl3ProtoObject)
 private
 // private fields
   f_R : Tl3Rect;
    {* Поле для свойства R}
   f_DrawRect : Tl3Rect;
    {* Поле для свойства DrawRect}
   f_RealSub : IevSub;
    {* Поле для свойства RealSub}
 protected
 // property methods
   function pm_GetHandle: Tl3Handle;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aRealSub: IevSub); reintroduce;
 public
 // public properties
   property R: Tl3Rect
     read f_R
     write f_R;
   property DrawRect: Tl3Rect
     read f_DrawRect
     write f_DrawRect;
   property RealSub: IevSub
     read f_RealSub;
   property Handle: Tl3Handle
     read pm_GetHandle;
 end;//TevSubPanelSub

implementation

// start class TevSubPanelSub

constructor TevSubPanelSub.Create(const aRealSub: IevSub);
//#UC START# *4B87DD060037_4B87DC6C02F7_var*
//#UC END# *4B87DD060037_4B87DC6C02F7_var*
begin
//#UC START# *4B87DD060037_4B87DC6C02F7_impl*
 inherited Create;
 f_RealSub := aRealSub;
//#UC END# *4B87DD060037_4B87DC6C02F7_impl*
end;//TevSubPanelSub.Create

function TevSubPanelSub.pm_GetHandle: Tl3Handle;
//#UC START# *4B87E3ED0100_4B87DC6C02F7get_var*
//#UC END# *4B87E3ED0100_4B87DC6C02F7get_var*
begin
//#UC START# *4B87E3ED0100_4B87DC6C02F7get_impl*
 Result := RealSub.ID;
//#UC END# *4B87E3ED0100_4B87DC6C02F7get_impl*
end;//TevSubPanelSub.pm_GetHandle

procedure TevSubPanelSub.Cleanup;
//#UC START# *479731C50290_4B87DC6C02F7_var*
//#UC END# *479731C50290_4B87DC6C02F7_var*
begin
//#UC START# *479731C50290_4B87DC6C02F7_impl*
 f_RealSub := nil;
 inherited;
//#UC END# *479731C50290_4B87DC6C02F7_impl*
end;//TevSubPanelSub.Cleanup

procedure TevSubPanelSub.ClearFields;
 {-}
begin
 Finalize(f_R);
 Finalize(f_DrawRect);
 f_RealSub := nil;
 inherited;
end;//TevSubPanelSub.ClearFields

end.