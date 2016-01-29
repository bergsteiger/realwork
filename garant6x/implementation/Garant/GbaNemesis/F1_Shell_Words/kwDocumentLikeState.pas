unit kwDocumentLikeState;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDocumentLikeState.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::document_LikeState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  ExText_Form
  {$IfEnd} //not Admin AND not Monitorings
  ,
  kwExTextFormWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDocumentLikeState = {final scriptword} class(TkwExTextFormWord)
 protected
 // realized methods
   procedure DoTextForm(aForm: TExTextForm;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocumentLikeState
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

type
  TExTextFormHack = class(TExTextForm)
  end;//TExTextFormHack

// start class TkwDocumentLikeState

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
 {-}
begin
 Result := 'document:LikeState';
end;//TkwDocumentLikeState.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация document_LikeState
 TkwDocumentLikeState.RegisterInEngine;
{$IfEnd} //not NoScripts

end.