unit kwDocumentSpravka;

// Модуль: "w:\archi\source\projects\Archi\Archi_Script_Engine\kwDocumentSpravka.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwDocumentSpravka" MUID: (4E5C937F00B2)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , tfwRegisterableWord
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TkwDocumentSpravka = class({$If NOT Defined(NoScripts)}
 TtfwRegisterableWord
 {$IfEnd} // NOT Defined(NoScripts)
 )
  protected
   {$If NOT Defined(NoScripts)}
   procedure DoDoIt(const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} // NOT Defined(NoScripts)
 end;//TkwDocumentSpravka

implementation

uses
 l3ImplUses
 {$If Defined(AppClientSide)}
 , Main
 {$IfEnd} // Defined(AppClientSide)
 {$If Defined(AppClientSide)}
 , Editwin
 {$IfEnd} // Defined(AppClientSide)
;

{$If NOT Defined(NoScripts)}
procedure TkwDocumentSpravka.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E5C937F00B2_var*
//#UC END# *4DAEEDE10285_4E5C937F00B2_var*
begin
//#UC START# *4DAEEDE10285_4E5C937F00B2_impl*
 if (MainForm.ActiveMDIChild is TDocEditorWindow) then
  (MainForm.ActiveMDIChild as TDocEditorWindow).acPageSprv.Execute;
//#UC END# *4DAEEDE10285_4E5C937F00B2_impl*
end;//TkwDocumentSpravka.DoDoIt

class function TkwDocumentSpravka.GetWordNameForRegister: AnsiString;
begin
 Result := 'оп::Документ_Справка_к_документу';
end;//TkwDocumentSpravka.GetWordNameForRegister

initialization
 TkwDocumentSpravka.RegisterInEngine;
 {* Регистрация TkwDocumentSpravka }
{$IfEnd} // NOT Defined(NoScripts)

end.
