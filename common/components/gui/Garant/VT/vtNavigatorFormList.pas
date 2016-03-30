unit vtNavigatorFormList;

// Модуль: "w:\common\components\gui\Garant\VT\vtNavigatorFormList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtNavigatorFormList" MUID: (4F61A51602F4)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vtNavigatorFormListPrim
;

type
 TvtNavigatorFormList = class(TvtNavigatorFormListPrim)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TvtNavigatorFormList;
    {* Метод получения экземпляра синглетона TvtNavigatorFormList }
 end;//TvtNavigatorFormList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvtNavigatorFormList: TvtNavigatorFormList = nil;
 {* Экземпляр синглетона TvtNavigatorFormList }

procedure TvtNavigatorFormListFree;
 {* Метод освобождения экземпляра синглетона TvtNavigatorFormList }
begin
 l3Free(g_TvtNavigatorFormList);
end;//TvtNavigatorFormListFree

class function TvtNavigatorFormList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvtNavigatorFormList <> nil;
end;//TvtNavigatorFormList.Exists

class function TvtNavigatorFormList.Instance: TvtNavigatorFormList;
 {* Метод получения экземпляра синглетона TvtNavigatorFormList }
begin
 if (g_TvtNavigatorFormList = nil) then
 begin
  l3System.AddExitProc(TvtNavigatorFormListFree);
  g_TvtNavigatorFormList := Create;
 end;
 Result := g_TvtNavigatorFormList;
end;//TvtNavigatorFormList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
