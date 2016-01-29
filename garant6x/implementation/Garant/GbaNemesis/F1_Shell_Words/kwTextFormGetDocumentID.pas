unit kwTextFormGetDocumentID;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwTextFormGetDocumentID.pas"
// Начат: 20.01.2012 14:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwTextFormGetDocumentID
//
// Возвращает идентификатор текущего открытого документа
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
 TkwTextFormGetDocumentID = {scriptword} class(TkwExTextFormWord)
  {* Возвращает идентификатор текущего открытого документа }
 protected
 // realized methods
   procedure DoTextForm(aForm: TExTextForm;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTextFormGetDocumentID
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  nsConst,
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

// start class TkwTextFormGetDocumentID

procedure TkwTextFormGetDocumentID.DoTextForm(aForm: TExTextForm;
  const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_4F1942440116_var*
var
 l_ID : Integer;
//#UC END# *4DCA5B340360_4F1942440116_var*
begin
//#UC START# *4DCA5B340360_4F1942440116_impl*
 l_ID := 0;
 try
  if (TExTextFormHack(aForm).Document <> nil) then
   l_ID := TExTextFormHack(aForm).Document.GetInternalId{ + c_InternalDocShift};
 finally
  aCtx.rEngine.PushInt(l_ID);
 end;//try..finally
//#UC END# *4DCA5B340360_4F1942440116_impl*
end;//TkwTextFormGetDocumentID.DoTextForm

class function TkwTextFormGetDocumentID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'textform:GetDocumentID';
end;//TkwTextFormGetDocumentID.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwTextFormGetDocumentID
 TkwTextFormGetDocumentID.RegisterInEngine;
{$IfEnd} //not NoScripts

end.