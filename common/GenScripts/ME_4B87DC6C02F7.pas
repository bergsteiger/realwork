unit evSubPanelSub;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanelSub.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Units
 , nevTools
 , l3Types
;

type
 TevSubPanelSub = class(Tl3ProtoObject)
  private
   f_R: Tl3Rect;
    {* Поле для свойства R }
   f_DrawRect: Tl3Rect;
    {* Поле для свойства DrawRect }
   f_RealSub: IevSub;
    {* Поле для свойства RealSub }
  protected
   function pm_GetHandle: Tl3Handle;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aRealSub: IevSub); reintroduce;
  public
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

uses
 l3ImplUses
;

function TevSubPanelSub.pm_GetHandle: Tl3Handle;
//#UC START# *4B87E3ED0100_4B87DC6C02F7get_var*
//#UC END# *4B87E3ED0100_4B87DC6C02F7get_var*
begin
//#UC START# *4B87E3ED0100_4B87DC6C02F7get_impl*
 Result := RealSub.ID;
//#UC END# *4B87E3ED0100_4B87DC6C02F7get_impl*
end;//TevSubPanelSub.pm_GetHandle

constructor TevSubPanelSub.Create(const aRealSub: IevSub);
//#UC START# *4B87DD060037_4B87DC6C02F7_var*
//#UC END# *4B87DD060037_4B87DC6C02F7_var*
begin
//#UC START# *4B87DD060037_4B87DC6C02F7_impl*
 inherited Create;
 f_RealSub := aRealSub;
//#UC END# *4B87DD060037_4B87DC6C02F7_impl*
end;//TevSubPanelSub.Create

procedure TevSubPanelSub.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B87DC6C02F7_var*
//#UC END# *479731C50290_4B87DC6C02F7_var*
begin
//#UC START# *479731C50290_4B87DC6C02F7_impl*
 f_RealSub := nil;
 inherited;
//#UC END# *479731C50290_4B87DC6C02F7_impl*
end;//TevSubPanelSub.Cleanup

procedure TevSubPanelSub.ClearFields;
begin
 Finalize(R);
 Finalize(DrawRect);
 f_RealSub := nil;
 inherited;
end;//TevSubPanelSub.ClearFields

end.
