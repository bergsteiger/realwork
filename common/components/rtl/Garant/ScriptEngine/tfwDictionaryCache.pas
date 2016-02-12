unit tfwDictionaryCache;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryCache.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryCachePrim
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = TtfwDictionaryCachePrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TtfwDictionaryCache = class(_l3Searcher_)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TtfwDictionaryCache;
    {* Метод получения экземпляра синглетона TtfwDictionaryCache }
   function FindDictionary(const aFileName: Il3CString): _ItemType_; override;
   procedure Remove(const anItem: _ItemType_); override;
 end;//TtfwDictionaryCache
{$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)

implementation

{$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwMainDictionaryCache
 , l3String
 , SysUtils
 , l3Base
;

var g_TtfwDictionaryCache: TtfwDictionaryCache = nil;
 {* Экземпляр синглетона TtfwDictionaryCache }

procedure TtfwDictionaryCacheFree;
 {* Метод освобождения экземпляра синглетона TtfwDictionaryCache }
begin
 l3Free(g_TtfwDictionaryCache);
end;//TtfwDictionaryCacheFree

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_55A3DF0603C6_var*
//#UC END# *47B9BAFD01F4_55A3DF0603C6_var*
begin
//#UC START# *47B9BAFD01F4_55A3DF0603C6_impl*
 Result := l3Compare(l3PCharLen(anItem.FileName), aData, l3_siCaseUnsensitive);
//#UC END# *47B9BAFD01F4_55A3DF0603C6_impl*
end;//CompareItemWithData

type _Instance_R_ = TtfwDictionaryCache;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

class function TtfwDictionaryCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwDictionaryCache <> nil;
end;//TtfwDictionaryCache.Exists

class function TtfwDictionaryCache.Instance: TtfwDictionaryCache;
 {* Метод получения экземпляра синглетона TtfwDictionaryCache }
begin
 if (g_TtfwDictionaryCache = nil) then
 begin
  l3System.AddExitProc(TtfwDictionaryCacheFree);
  g_TtfwDictionaryCache := Create;
 end;
 Result := g_TtfwDictionaryCache;
end;//TtfwDictionaryCache.Instance

function TtfwDictionaryCache.FindDictionary(const aFileName: Il3CString): _ItemType_;
//#UC START# *559E857A037A_55A3DF0603C6_var*
var
 l_Index : Integer;
//#UC END# *559E857A037A_55A3DF0603C6_var*
begin
//#UC START# *559E857A037A_55A3DF0603C6_impl*
 if FindData(l3PCharLen(aFileName), l_Index) then
  Result := Items[l_Index]
 else
  Result := nil;
//#UC END# *559E857A037A_55A3DF0603C6_impl*
end;//TtfwDictionaryCache.FindDictionary

procedure TtfwDictionaryCache.Remove(const anItem: _ItemType_);
//#UC START# *55A663000019_55A3DF0603C6_var*
//#UC END# *55A663000019_55A3DF0603C6_var*
begin
//#UC START# *55A663000019_55A3DF0603C6_impl*
 TtfwMainDictionaryCache.Instance.RemoveUsersOf(anItem);
 inherited;
//#UC END# *55A663000019_55A3DF0603C6_impl*
end;//TtfwDictionaryCache.Remove
{$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)

end.
