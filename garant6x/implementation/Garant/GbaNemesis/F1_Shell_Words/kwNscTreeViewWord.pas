unit kwNscTreeViewWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwNscTreeViewWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Поддержка тестов::F1 Shell Words::TreeViewWords::TkwNscTreeViewWord
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
  {$If defined(Nemesis)}
  ,
  nscTreeView
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  kwComponentFromStackWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwNscTreeViewWord = {abstract} class(_kwControlFromStackWord_)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoWithNscTreeView(aTreeView: TnscTreeView;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwNscTreeViewWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}

// start class TkwNscTreeViewWord

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwNscTreeViewWord.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_512FA1800269_var*
//#UC END# *4F212C3A015A_512FA1800269_var*
begin
//#UC START# *4F212C3A015A_512FA1800269_impl*
 RunnerAssert(aControl is TnscTreeView, 'Это не TnscTreeView.', aCtx);
 DoWithNscTreeView(aControl as TnscTreeView, aCtx);
//#UC END# *4F212C3A015A_512FA1800269_impl*
end;//TkwNscTreeViewWord.DoControl
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwNscTreeViewWord
 TkwNscTreeViewWord.RegisterClass;
{$IfEnd} //not NoScripts

end.