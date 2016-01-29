unit NOT_FINISHED_VMailWin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Dlg"
// Модуль: "w:/archi/source/projects/Archi/Dlg/NOT_FINISHED_VMailWin.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Dlg::ChildWindow::VMailWin
//
// Почтовое окно.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  vtForm
  ;

type
 TViewMailWin = class(TvtForm)
  {* Почтовое окно. }
 public
 // public methods
   procedure SetMessage(Value: LongInt;
     Mode: Byte = 0);
     {* 0 - This, 1 - Prev, 2 - Next }
 end;//TViewMailWin
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  evExtFormat
  {$If not defined(NoScripts)}
  ,
  tfwClassRef
  {$IfEnd} //not NoScripts
  
  ;

// start class TViewMailWin

procedure TViewMailWin.SetMessage(Value: LongInt;
  Mode: Byte = 0);
//#UC START# *4F0C225A02DD_4F0C222F0080_var*
//#UC END# *4F0C225A02DD_4F0C222F0080_var*
begin
//#UC START# *4F0C225A02DD_4F0C222F0080_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F0C225A02DD_4F0C222F0080_impl*
end;//TViewMailWin.SetMessage
{$IfEnd} //AppClientSide

initialization
{$If defined(AppClientSide) AND not defined(NoScripts)}
// Регистрация TViewMailWin
 TtfwClassRef.Register(TViewMailWin);
{$IfEnd} //AppClientSide AND not NoScripts

end.