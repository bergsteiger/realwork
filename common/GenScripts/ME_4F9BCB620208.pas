unit Pl3MessageIDList;

// Модуль: "w:\common\components\rtl\Garant\L3\Pl3MessageIDList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TPl3MessageIDList" MUID: (4F9BCB620208)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , Pl3MessageIDListPrim
;

type
 TPl3MessageIDList = class(TPl3MessageIDListPrim)
  private
   procedure CleanupItems;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Release; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TPl3MessageIDList;
    {* Метод получения экземпляра синглетона TPl3MessageIDList }
 end;//TPl3MessageIDList

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TPl3MessageIDList: TPl3MessageIDList = nil;
 {* Экземпляр синглетона TPl3MessageIDList }

procedure TPl3MessageIDListFree;
 {* Метод освобождения экземпляра синглетона TPl3MessageIDList }
begin
 l3Free(g_TPl3MessageIDList);
end;//TPl3MessageIDListFree

procedure TPl3MessageIDList.CleanupItems;
//#UC START# *4F9BCF5401F8_4F9BCB620208_var*
var
 l_Index : Integer;
//#UC END# *4F9BCF5401F8_4F9BCB620208_var*
begin
//#UC START# *4F9BCF5401F8_4F9BCB620208_impl*
 for l_Index := 0 to Pred(Count) do
  Items[l_Index]^.Cleanup;
//#UC END# *4F9BCF5401F8_4F9BCB620208_impl*
end;//TPl3MessageIDList.CleanupItems

class function TPl3MessageIDList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TPl3MessageIDList <> nil;
end;//TPl3MessageIDList.Exists

class function TPl3MessageIDList.Instance: TPl3MessageIDList;
 {* Метод получения экземпляра синглетона TPl3MessageIDList }
begin
 if (g_TPl3MessageIDList = nil) then
 begin
  l3System.AddExitProc(TPl3MessageIDListFree);
  g_TPl3MessageIDList := Create;
 end;
 Result := g_TPl3MessageIDList;
end;//TPl3MessageIDList.Instance

procedure TPl3MessageIDList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F9BCB620208_var*
//#UC END# *479731C50290_4F9BCB620208_var*
begin
//#UC START# *479731C50290_4F9BCB620208_impl*
 CleanupItems;
 inherited;
//#UC END# *479731C50290_4F9BCB620208_impl*
end;//TPl3MessageIDList.Cleanup

procedure TPl3MessageIDList.Release;
//#UC START# *479F2AFB0397_4F9BCB620208_var*
//#UC END# *479F2AFB0397_4F9BCB620208_var*
begin
//#UC START# *479F2AFB0397_4F9BCB620208_impl*
 CleanupItems;
 inherited;
//#UC END# *479F2AFB0397_4F9BCB620208_impl*
end;//TPl3MessageIDList.Release

end.
