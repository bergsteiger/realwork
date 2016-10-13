unit msmEdit;

// Модуль: "w:\common\components\gui\Garant\msm\msmEdit.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmEdit" MUID: (57FBA730025D)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , evEdit
 , Classes
 , evCustomEdit
;

type
 TmsmCustomEdit = TevCustomEdit;

 TmsmEdit = class(TevEdit)
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
 end;//TmsmEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57FBA730025Dimpl_uses*
 , StdCtrls
 , Forms
 //#UC END# *57FBA730025Dimpl_uses*
;

constructor TmsmEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57FBA730025D_var*
//#UC END# *47D1602000C6_57FBA730025D_var*
begin
//#UC START# *47D1602000C6_57FBA730025D_impl*
 inherited;
 Self.BorderStyle := bsNone;
 Self.Ctl3D := false;
//#UC END# *47D1602000C6_57FBA730025D_impl*
end;//TmsmEdit.Create

procedure TmsmEdit.TextChange;
 {* вызывается при смене текста. }
//#UC START# *482C26D6006A_57FBA730025D_var*
//#UC END# *482C26D6006A_57FBA730025D_var*
begin
//#UC START# *482C26D6006A_57FBA730025D_impl*
 inherited;
 if Assigned(f_OnTextChange) then
  f_OnTextChange(Self);
//#UC END# *482C26D6006A_57FBA730025D_impl*
end;//TmsmEdit.TextChange

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TmsmCustomEdit));
 {* Регистрация типа TmsmCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmEdit);
 {* Регистрация TmsmEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
