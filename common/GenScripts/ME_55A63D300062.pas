unit tfwMainDictionaryCache;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryCache.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwMainDictionaryList
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = TtfwMainDictionaryList;
 {$Include l3Searcher.imp.pas}
 TtfwMainDictionaryCache = class(_l3Searcher_)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TtfwMainDictionaryCache;
    {* Метод получения экземпляра синглетона TtfwMainDictionaryCache }
   function FindDictionary(const aFileName: Il3CString): _ItemType_; override;
 end;//TtfwMainDictionaryCache
{$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)

implementation

{$If Defined(seCacheDict) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3Base
;

var g_TtfwMainDictionaryCache: TtfwMainDictionaryCache = nil;
 {* Экземпляр синглетона TtfwMainDictionaryCache }

procedure TtfwMainDictionaryCacheFree;
 {* Метод освобождения экземпляра синглетона TtfwMainDictionaryCache }
begin
 l3Free(g_TtfwMainDictionaryCache);
end;//TtfwMainDictionaryCacheFree

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer; override;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_55A63D300062_var*
//#UC END# *47B9BAFD01F4_55A63D300062_var*
begin
//#UC START# *47B9BAFD01F4_55A63D300062_impl*
 Result := l3Compare(l3PCharLen(anItem.FileName), aData, l3_siCaseUnsensitive);
//#UC END# *47B9BAFD01F4_55A63D300062_impl*
end;//CompareItemWithData

type _Instance_R_ = TtfwMainDictionaryCache;

{$Include l3Searcher.imp.pas}

class function TtfwMainDictionaryCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwMainDictionaryCache <> nil;
end;//TtfwMainDictionaryCache.Exists

class function TtfwMainDictionaryCache.Instance: TtfwMainDictionaryCache;
 {* Метод получения экземпляра синглетона TtfwMainDictionaryCache }
begin
 if (g_TtfwMainDictionaryCache = nil) then
 begin
  l3System.AddExitProc(TtfwMainDictionaryCacheFree);
  g_TtfwMainDictionaryCache := Create;
 end;
 Result := g_TtfwMainDictionaryCache;
end;//TtfwMainDictionaryCache.Instance

function TtfwMainDictionaryCache.FindDictionary(const aFileName: Il3CString): _ItemType_;
//#UC START# *559E857A037A_55A63D300062_var*
var
 l_Index : Integer;
//#UC END# *559E857A037A_55A63D300062_var*
begin
//#UC START# *559E857A037A_55A63D300062_impl*
 if FindData(l3PCharLen(aFileName), l_Index) then
  Result := Items[l_Index]
 else
  Result := nil;
//#UC END# *559E857A037A_55A63D300062_impl*
end;//TtfwMainDictionaryCache.FindDictionary
{$IfEnd} // Defined(seCacheDict) AND NOT Defined(NoScripts)

end.
