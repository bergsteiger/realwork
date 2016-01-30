unit kwTextFormSetNeedShowIntranetWarning;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwTextFormSetNeedShowIntranetWarning.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwExTextFormWord
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , ExText_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , tfwScriptingInterfaces
;

type
 TkwTextFormSetNeedShowIntranetWarning = class(TkwExTextFormWord)
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTextFormSetNeedShowIntranetWarning
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwTextFormSetNeedShowIntranetWarning.DoTextForm(aForm: TExTextForm;
 const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_4F183D860083_var*
//#UC END# *4DCA5B340360_4F183D860083_var*
begin
//#UC START# *4DCA5B340360_4F183D860083_impl*
 aForm.NeedShowIntranetWarningHack := aCtx.rEngine.PopBool;
//#UC END# *4DCA5B340360_4F183D860083_impl*
end;//TkwTextFormSetNeedShowIntranetWarning.DoTextForm

class function TkwTextFormSetNeedShowIntranetWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'textform:SetNeedShowIntranetWarning';
end;//TkwTextFormSetNeedShowIntranetWarning.GetWordNameForRegister

initialization
 TkwTextFormSetNeedShowIntranetWarning.RegisterInEngine;
 {* Регистрация TkwTextFormSetNeedShowIntranetWarning }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
