unit kwEndAddSubByMouse;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEndAddSubByMouse.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwEndAddSubByMouse
//
// Закончить простановку ссылки на саб с помощью мыши (Drag&Drop):
// окно_редактора:постановить_ссылку_мышью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwControlWord,
  Controls,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwEndAddSubByMouse = {scriptword} class(TkwControlWord)
  {* Закончить простановку ссылки на саб с помощью мыши (Drag&Drop):
окно_редактора:постановить_ссылку_мышью }
 protected
 // realized methods
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEndAddSubByMouse
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Messages,
  DragData,
  arArchiTestAdapter2,
  Windows,
  Forms
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwEndAddSubByMouse

procedure TkwEndAddSubByMouse.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4F0C009200D7_var*
//#UC END# *4DB98B990054_4F0C009200D7_var*
begin
//#UC START# *4DB98B990054_4F0C009200D7_impl*
 AcEndDragAndDrop(aControl);
//#UC END# *4DB98B990054_4F0C009200D7_impl*
end;//TkwEndAddSubByMouse.DoControl

class function TkwEndAddSubByMouse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'окно_редактора:постановить_ссылку_мышью';
end;//TkwEndAddSubByMouse.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwEndAddSubByMouse
 TkwEndAddSubByMouse.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.