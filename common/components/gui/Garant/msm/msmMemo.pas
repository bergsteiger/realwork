unit msmMemo;

// Модуль: "w:\common\components\gui\Garant\msm\msmMemo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMemo" MUID: (57FCCF280377)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , evMemo
 , Classes
 , evCustomEdit
;

type
 TmsmCustomEdit = TevCustomEdit;

 TmsmMemo = class(TevMemo)
  private
   f_OnTextChange: TNotifyEvent;
  protected
   procedure TextChange; override;
    {* вызывается при смене текста. }
  public
   constructor Create(AOwner: TComponent); override;
  public
   property OnTextChange: TNotifyEvent
    read f_OnTextChange
    write f_OnTextChange;
 end;//TmsmMemo

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57FCCF280377impl_uses*
 , StdCtrls
 , Forms
 //#UC END# *57FCCF280377impl_uses*
;

constructor TmsmMemo.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57FCCF280377_var*
//#UC END# *47D1602000C6_57FCCF280377_var*
begin
//#UC START# *47D1602000C6_57FCCF280377_impl*
 inherited;
 Self.BorderStyle := bsNone;
 Self.Ctl3D := false;
//#UC END# *47D1602000C6_57FCCF280377_impl*
end;//TmsmMemo.Create

procedure TmsmMemo.TextChange;
 {* вызывается при смене текста. }
//#UC START# *482C26D6006A_57FCCF280377_var*
//#UC END# *482C26D6006A_57FCCF280377_var*
begin
//#UC START# *482C26D6006A_57FCCF280377_impl*
 inherited;
 if Assigned(f_OnTextChange) then
  f_OnTextChange(Self);
//#UC END# *482C26D6006A_57FCCF280377_impl*
end;//TmsmMemo.TextChange

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmCustomEdit));
 {* Регистрация типа TmsmCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmMemo);
 {* Регистрация TmsmMemo }
{$IfEnd} // NOT Defined(NoScripts)

end.
