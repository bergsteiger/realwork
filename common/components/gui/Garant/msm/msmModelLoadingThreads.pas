unit msmModelLoadingThreads;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelLoadingThreads.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelLoadingThreads" MUID: (57C68795032A)

{$Include w:\common\components\msm.inc}

interface

{$If Defined(seThreadSafe)}
uses
 l3IntfUses
 , msmModelLoadingThreadPrimList
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Types
;

type
 _FindDataType_ = TtfwWord;
 _l3Searcher_Parent_ = TmsmModelLoadingThreadPrimList;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TmsmModelLoadingThreads = class(_l3Searcher_)
  public
   class function Instance: TmsmModelLoadingThreads;
    {* Метод получения экземпляра синглетона TmsmModelLoadingThreads }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmModelLoadingThreads
{$IfEnd} // Defined(seThreadSafe)

implementation

{$If Defined(seThreadSafe)}
uses
 l3ImplUses
 , msmModelLoadingThreadPrim
 , SysUtils
 , l3Base
 //#UC START# *57C68795032Aimpl_uses*
 //#UC END# *57C68795032Aimpl_uses*
;

var g_TmsmModelLoadingThreads: TmsmModelLoadingThreads = nil;
 {* Экземпляр синглетона TmsmModelLoadingThreads }

procedure TmsmModelLoadingThreadsFree;
 {* Метод освобождения экземпляра синглетона TmsmModelLoadingThreads }
begin
 l3Free(g_TmsmModelLoadingThreads);
end;//TmsmModelLoadingThreadsFree

{$If not Declared(_ItemType_)}type _ItemType_ = TmsmModelLoadingThreadPrim;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_57C68795032A_var*
//#UC END# *47B9BAFD01F4_57C68795032A_var*
begin
//#UC START# *47B9BAFD01F4_57C68795032A_impl*
 Assert(anItem <> nil);
 Result := PChar(anItem.WordToLoad) - PChar(aData);
//#UC END# *47B9BAFD01F4_57C68795032A_impl*
end;//CompareItemWithData

type _Instance_R_ = TmsmModelLoadingThreads;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

class function TmsmModelLoadingThreads.Instance: TmsmModelLoadingThreads;
 {* Метод получения экземпляра синглетона TmsmModelLoadingThreads }
begin
 if (g_TmsmModelLoadingThreads = nil) then
 begin
  l3System.AddExitProc(TmsmModelLoadingThreadsFree);
  g_TmsmModelLoadingThreads := Create;
 end;
 Result := g_TmsmModelLoadingThreads;
end;//TmsmModelLoadingThreads.Instance

class function TmsmModelLoadingThreads.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmModelLoadingThreads <> nil;
end;//TmsmModelLoadingThreads.Exists
{$IfEnd} // Defined(seThreadSafe)

end.
