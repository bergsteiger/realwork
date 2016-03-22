unit NOT_FINISHED_D_spell;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_D_spell.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "D_spell" MUID: (55C8D80A0304)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TSpellCheckDlg = class
  public
   class function Instance: TSpellCheckDlg;
    {* Метод получения экземпляра синглетона TSpellCheckDlg }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TSpellCheckDlg

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TSpellCheckDlgWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
;

var g_TSpellCheckDlg: TSpellCheckDlg = nil;
 {* Экземпляр синглетона TSpellCheckDlg }

procedure TSpellCheckDlgFree;
 {* Метод освобождения экземпляра синглетона TSpellCheckDlg }
begin
 l3Free(g_TSpellCheckDlg);
end;//TSpellCheckDlgFree

class function TSpellCheckDlg.Instance: TSpellCheckDlg;
 {* Метод получения экземпляра синглетона TSpellCheckDlg }
begin
 if (g_TSpellCheckDlg = nil) then
 begin
  l3System.AddExitProc(TSpellCheckDlgFree);
  g_TSpellCheckDlg := Create;
 end;
 Result := g_TSpellCheckDlg;
end;//TSpellCheckDlg.Instance

class function TSpellCheckDlg.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TSpellCheckDlg <> nil;
end;//TSpellCheckDlg.Exists

end.
