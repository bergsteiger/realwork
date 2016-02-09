unit tfwStandardDictionaries;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaries.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwStandardDictionaryList
 , tfwStandardDictionary
 , l3Interfaces
;

type
 TtfwStandardDictionaries = class(TtfwStandardDictionaryList)
  public
   function CheckDictionary(const aName: Il3CString): TtfwStandardDictionary;
   function FindDictionary(const aName: Il3CString): TtfwStandardDictionary;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TtfwStandardDictionaries;
    {* Метод получения экземпляра синглетона TtfwStandardDictionaries }
 end;//TtfwStandardDictionaries
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3Base
;

var g_TtfwStandardDictionaries: TtfwStandardDictionaries = nil;
 {* Экземпляр синглетона TtfwStandardDictionaries }

procedure TtfwStandardDictionariesFree;
 {* Метод освобождения экземпляра синглетона TtfwStandardDictionaries }
begin
 l3Free(g_TtfwStandardDictionaries);
end;//TtfwStandardDictionariesFree

function TtfwStandardDictionaries.CheckDictionary(const aName: Il3CString): TtfwStandardDictionary;
//#UC START# *55B0FEC503CE_55B0E7AD026B_var*
var
 l_Index : Integer;
 l_D : TtfwStandardDictionary;
//#UC END# *55B0FEC503CE_55B0E7AD026B_var*
begin
//#UC START# *55B0FEC503CE_55B0E7AD026B_impl*
 if FindData(l3PCharLen(aName), l_Index) then
  Result := Items[l_Index]
 else
 begin
  l_D := TtfwStandardDictionary.Create(aName, []);
  try
   DirectInsert(l_Index, l_D);
   Result := l_D;
  finally
   FreeAndNil(l_D);
  end;//try..finally
 end;//FindData(l3PCharLen(aName), l_Index)
//#UC END# *55B0FEC503CE_55B0E7AD026B_impl*
end;//TtfwStandardDictionaries.CheckDictionary

function TtfwStandardDictionaries.FindDictionary(const aName: Il3CString): TtfwStandardDictionary;
//#UC START# *55B1E6EC0088_55B0E7AD026B_var*
var
 l_Index : Integer;
//#UC END# *55B1E6EC0088_55B0E7AD026B_var*
begin
//#UC START# *55B1E6EC0088_55B0E7AD026B_impl*
 if FindData(l3PCharLen(aName), l_Index) then
  Result := Items[l_Index]
 else
  Result := nil;
//#UC END# *55B1E6EC0088_55B0E7AD026B_impl*
end;//TtfwStandardDictionaries.FindDictionary

class function TtfwStandardDictionaries.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwStandardDictionaries <> nil;
end;//TtfwStandardDictionaries.Exists

class function TtfwStandardDictionaries.Instance: TtfwStandardDictionaries;
 {* Метод получения экземпляра синглетона TtfwStandardDictionaries }
begin
 if (g_TtfwStandardDictionaries = nil) then
 begin
  l3System.AddExitProc(TtfwStandardDictionariesFree);
  g_TtfwStandardDictionaries := Create;
 end;
 Result := g_TtfwStandardDictionaries;
end;//TtfwStandardDictionaries.Instance
{$IfEnd} // NOT Defined(NoScripts)

end.
