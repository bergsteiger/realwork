unit kwDocumentLikeState;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwDocumentLikeState.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "document_LikeState" MUID: (500E876A0208)
// Имя типа: "TkwDocumentLikeState"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwExTextFormWord
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , ExText_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , tfwScriptingInterfaces
;

type
 TkwDocumentLikeState = {final} class(TkwExTextFormWord)
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocumentLikeState
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TExTextFormHack = class(TExTextForm)
 end;//TExTextFormHack

procedure TkwDocumentLikeState.DoTextForm(aForm: TExTextForm;
 const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_500E876A0208_var*
//#UC END# *4DCA5B340360_500E876A0208_var*
begin
//#UC START# *4DCA5B340360_500E876A0208_impl*
 aCtx.rEngine.PushInt(Ord(TExTextFormHack(aForm).dsDocument.LikeState));
//#UC END# *4DCA5B340360_500E876A0208_impl*
end;//TkwDocumentLikeState.DoTextForm

class function TkwDocumentLikeState.GetWordNameForRegister: AnsiString;
begin
 Result := 'document:LikeState';
end;//TkwDocumentLikeState.GetWordNameForRegister

initialization
 TkwDocumentLikeState.RegisterInEngine;
 {* Регистрация document_LikeState }
{$IfEnd} // NOT Defined(NoScripts)

end.
