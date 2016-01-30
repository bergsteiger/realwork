unit ExcludedTestsFolders;
 {* Папки тестов исключаемые из запуска }

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\ExcludedTestsFolders.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTestsFolders = class(Tl3StringList)
  {* Папки тестов исключаемые из запуска }
  public
   class function Exists: Boolean;
   class function Instance: TExcludedTestsFolders;
    {* Метод получения экземпляра синглетона TExcludedTestsFolders }
 end;//TExcludedTestsFolders
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TExcludedTestsFolders: TExcludedTestsFolders = nil;
 {* Экземпляр синглетона TExcludedTestsFolders }

procedure TExcludedTestsFoldersFree;
 {* Метод освобождения экземпляра синглетона TExcludedTestsFolders }
begin
 l3Free(g_TExcludedTestsFolders);
end;//TExcludedTestsFoldersFree

class function TExcludedTestsFolders.Exists: Boolean;
//#UC START# *4C938674023A_4C9386230151_var*
//#UC END# *4C938674023A_4C9386230151_var*
begin
//#UC START# *4C938674023A_4C9386230151_impl*
 Result := (g_TExcludedTestsFolders <> nil);
//#UC END# *4C938674023A_4C9386230151_impl*
end;//TExcludedTestsFolders.Exists

class function TExcludedTestsFolders.Instance: TExcludedTestsFolders;
 {* Метод получения экземпляра синглетона TExcludedTestsFolders }
begin
 if (g_TExcludedTestsFolders = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFoldersFree);
  g_TExcludedTestsFolders := Create;
 end;
 Result := g_TExcludedTestsFolders;
end;//TExcludedTestsFolders.Instance
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
