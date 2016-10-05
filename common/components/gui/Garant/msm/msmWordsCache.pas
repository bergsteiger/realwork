unit msmWordsCache;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordsCache.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWordsCache" MUID: (57B2D8C90390)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmWordByNameList
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
 , SyncObjs
;

type
 _seCriticalSectionHolder_Parent_ = TmsmWordByNameList;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmWordsCache = class(_seCriticalSectionHolder_)
  public
   procedure Add(anItem: TtfwWord);
   procedure Insert(anIndex: Integer;
    anItem: TtfwWord);
   function FindData(anItem: TtfwWord;
    var theIndex: Integer): Boolean; overload;
   function FindData(const anItem: Il3CString;
    var theIndex: Integer): Boolean; overload;
   function AsArray: ItfwArray;
   class function Instance: TmsmWordsCache;
    {* Метод получения экземпляра синглетона TmsmWordsCache }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmWordsCache

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57B2D8C90390impl_uses*
 , l3String
 , tfwWordRefList
 , tfwWordsIterator
 //#UC END# *57B2D8C90390impl_uses*
;

var g_TmsmWordsCache: TmsmWordsCache = nil;
 {* Экземпляр синглетона TmsmWordsCache }

procedure TmsmWordsCacheFree;
 {* Метод освобождения экземпляра синглетона TmsmWordsCache }
begin
 l3Free(g_TmsmWordsCache);
end;//TmsmWordsCacheFree

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmWordsCache.Add(anItem: TtfwWord);
//#UC START# *57C4878D02D3_57B2D8C90390_var*
//#UC END# *57C4878D02D3_57B2D8C90390_var*
begin
//#UC START# *57C4878D02D3_57B2D8C90390_impl*
 Lock;
 try
  inherited Add(anItem.GetRefForCompare);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57C4878D02D3_57B2D8C90390_impl*
end;//TmsmWordsCache.Add

procedure TmsmWordsCache.Insert(anIndex: Integer;
 anItem: TtfwWord);
//#UC START# *57C487A801B7_57B2D8C90390_var*
//#UC END# *57C487A801B7_57B2D8C90390_var*
begin
//#UC START# *57C487A801B7_57B2D8C90390_impl*
 Lock;
 try
  inherited Insert(anIndex, anItem.GetRefForCompare);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57C487A801B7_57B2D8C90390_impl*
end;//TmsmWordsCache.Insert

function TmsmWordsCache.FindData(anItem: TtfwWord;
 var theIndex: Integer): Boolean;
//#UC START# *57C487D4037A_57B2D8C90390_var*
//#UC END# *57C487D4037A_57B2D8C90390_var*
begin
//#UC START# *57C487D4037A_57B2D8C90390_impl*
 Lock;
 try
  Result := inherited FindData(anItem.GetRefForCompare, theIndex);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57C487D4037A_57B2D8C90390_impl*
end;//TmsmWordsCache.FindData

function TmsmWordsCache.FindData(const anItem: Il3CString;
 var theIndex: Integer): Boolean;
//#UC START# *57C48BE901A3_57B2D8C90390_var*
//#UC END# *57C48BE901A3_57B2D8C90390_var*
begin
//#UC START# *57C48BE901A3_57B2D8C90390_impl*
 Lock;
 try
  Result := inherited FindData(anItem, theIndex);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57C48BE901A3_57B2D8C90390_impl*
end;//TmsmWordsCache.FindData

function TmsmWordsCache.AsArray: ItfwArray;
//#UC START# *57E45AE800E4_57B2D8C90390_var*
var
 l_Index : Integer;
 l_List : TtfwWordRefList;
//#UC END# *57E45AE800E4_57B2D8C90390_var*
begin
//#UC START# *57E45AE800E4_57B2D8C90390_impl*
 Result := nil;
 Lock;
 try
  l_List := TtfwWordRefList.Create;
  try
   for l_Index := 0 to Pred(Self.Count) do
    l_List.Add(Self.Items[l_Index]);
   Result := TtfwWordsIterator.Make(l_List); 
  finally
   FreeAndNil(l_List);
  end;//try..finally
 finally
  Unlock;
 end;//try..finally
//#UC END# *57E45AE800E4_57B2D8C90390_impl*
end;//TmsmWordsCache.AsArray

class function TmsmWordsCache.Instance: TmsmWordsCache;
 {* Метод получения экземпляра синглетона TmsmWordsCache }
begin
 if (g_TmsmWordsCache = nil) then
 begin
  l3System.AddExitProc(TmsmWordsCacheFree);
  g_TmsmWordsCache := Create;
 end;
 Result := g_TmsmWordsCache;
end;//TmsmWordsCache.Instance

class function TmsmWordsCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmWordsCache <> nil;
end;//TmsmWordsCache.Exists

end.
