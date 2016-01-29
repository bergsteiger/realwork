unit kwObjectCreate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwObjectCreate.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::object_Create
//
// Поддержка автоматического создания формы-обвязки для тестов.
// *Формат:* aClass .Create
// aClass - класс формы.
// 
// ПОКА создаёт только VCM-формы но предполагается научить создавать и ДРУГИЕ объекты.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include ..\Scripting\VCMWord.imp.pas}
 TkwObjectCreate = {scriptword} class(_VCMWord_)
  {* Поддержка автоматического создания формы-обвязки для тестов.
*Формат:* aClass .Create
aClass - класс формы.

ПОКА создаёт только VCM-формы но предполагается научить создавать и ДРУГИЕ объекты. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwObjectCreate
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmEntityForm
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vcmBase,
  vcmForm
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  StdRes,
  afwAnswer
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

{$Include ..\Scripting\VCMWord.imp.pas}

// start class TkwObjectCreate

procedure TkwObjectCreate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E29311F0055_var*
var
 l_Class: TClass;
//#UC END# *4DAEEDE10285_4E29311F0055_var*
begin
//#UC START# *4DAEEDE10285_4E29311F0055_impl*
{$If defined(NoVCM)}
 RunnerAssert(False, 'VCM не поддерживается в Арчи.', aCtx);
{$ELSE}
 if aCtx.rEngine.IsTopClass then
 begin
  l_Class := aCtx.rEngine.PopClass;
  RunnerAssert(l_Class.InheritsFrom(TvcmEntityForm), 'Неправильный класс формы', aCtx);
  aCtx.rEngine.PushObj(RvcmEntityForm(l_Class).Make(vcmMakeParams).VCLWinControl As TCustomForm);
 end//aCtx.rEngine.IsTopString
 else
  RunnerAssert(False, 'Не задан класс формы.', aCtx);
{$IfEnd} //not NoVCM
//#UC END# *4DAEEDE10285_4E29311F0055_impl*
end;//TkwObjectCreate.DoDoIt

class function TkwObjectCreate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Create';
end;//TkwObjectCreate.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация object_Create
 TkwObjectCreate.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.