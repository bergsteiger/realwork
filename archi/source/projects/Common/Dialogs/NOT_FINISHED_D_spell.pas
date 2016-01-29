unit NOT_FINISHED_D_spell;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Dialogs"
// Модуль: "w:/archi/source/projects/Common/Dialogs/NOT_FINISHED_D_spell.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$common::Dialogs::CommonDialogs::D_spell
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

type
 TSpellCheckDlg = class
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TSpellCheckDlg;
    {- возвращает экземпляр синглетона. }
 end;//TSpellCheckDlg

implementation

uses
  l3Base {a}
  {$If not defined(NoScripts)}
  ,
  TSpellCheckDlgWordsPack
  {$IfEnd} //not NoScripts
  
  ;


// start class TSpellCheckDlg

var g_TSpellCheckDlg : TSpellCheckDlg = nil;

procedure TSpellCheckDlgFree;
begin
 l3Free(g_TSpellCheckDlg);
end;

class function TSpellCheckDlg.Instance: TSpellCheckDlg;
begin
 if (g_TSpellCheckDlg = nil) then
 begin
  l3System.AddExitProc(TSpellCheckDlgFree);
  g_TSpellCheckDlg := Create;
 end;
 Result := g_TSpellCheckDlg;
end;


class function TSpellCheckDlg.Exists: Boolean;
 {-}
begin
 Result := g_TSpellCheckDlg <> nil;
end;//TSpellCheckDlg.Exists

end.