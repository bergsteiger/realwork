unit PrimTextLoad_Form;

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\PrimTextLoad_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , evCustomTextSource
 , evCustomEditor
 , evLoadDocumentManager
;

type
 TPrimTextLoadForm = class(TvcmEntityForm)
  private
   f_LoadManager: TevLoadDocumentManager;
    {* Поле для свойства LoadManager }
  protected
   function pm_GetTextSource: TevCustomTextSource; virtual; abstract;
   function pm_GetText: TevCustomEditor; virtual; abstract;
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
  public
   procedure AfterLoad; virtual;
  public
   property LoadManager: TevLoadDocumentManager
    read f_LoadManager;
   property TextSource: TevCustomTextSource
    read pm_GetTextSource;
   property Text: TevCustomEditor
    read pm_GetText;
 end;//TPrimTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimTextLoadForm.AfterLoad;
//#UC START# *4F15435202B5_4C9B20790302_var*
//#UC END# *4F15435202B5_4C9B20790302_var*
begin
//#UC START# *4F15435202B5_4C9B20790302_impl*
 
//#UC END# *4F15435202B5_4C9B20790302_impl*
end;//TPrimTextLoadForm.AfterLoad

procedure TPrimTextLoadForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4C9B20790302_var*
//#UC END# *4A8E8F2E0195_4C9B20790302_var*
begin
//#UC START# *4A8E8F2E0195_4C9B20790302_impl*
 inherited;
 WindowState := wsMaximized;
 Text.Align := alClient;
 Text.WebStyle := true;
 Text.TextSource := Self.TextSource;
//#UC END# *4A8E8F2E0195_4C9B20790302_impl*
end;//TPrimTextLoadForm.InitControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTextLoadForm);
 {* Регистрация PrimTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
