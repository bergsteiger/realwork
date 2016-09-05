unit msmWaitCursor;

// Модуль: "w:\common\components\gui\Garant\msm\msmWaitCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWaitCursor" MUID: (57B6CFEE0159)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , msmViewUtilsInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmWaitCursor = class(Tl3CProtoObject, ImsmWaitCursor)
  private
   f_PrevCursor: TCursor;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Make: ImsmWaitCursor; reintroduce;
 end;//TmsmWaitCursor

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *57B6CFEE0159impl_uses*
 //#UC END# *57B6CFEE0159impl_uses*
;

class function TmsmWaitCursor.Make: ImsmWaitCursor;
var
 l_Inst : TmsmWaitCursor;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmWaitCursor.Make

procedure TmsmWaitCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B6CFEE0159_var*
//#UC END# *479731C50290_57B6CFEE0159_var*
begin
//#UC START# *479731C50290_57B6CFEE0159_impl*
 if (Screen <> nil) then
  Screen.Cursor := f_PrevCursor;
 inherited;
//#UC END# *479731C50290_57B6CFEE0159_impl*
end;//TmsmWaitCursor.Cleanup

procedure TmsmWaitCursor.InitFields;
//#UC START# *47A042E100E2_57B6CFEE0159_var*
//#UC END# *47A042E100E2_57B6CFEE0159_var*
begin
//#UC START# *47A042E100E2_57B6CFEE0159_impl*
 inherited;
 if (Screen <> nil) then
 begin
  f_PrevCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
 end//Screen <> nil
 else
  Screen.Cursor := crDefault;
//#UC END# *47A042E100E2_57B6CFEE0159_impl*
end;//TmsmWaitCursor.InitFields

end.
