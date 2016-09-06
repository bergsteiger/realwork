unit msmNullOperationsList;

// Модуль: "w:\common\components\gui\Garant\msm\msmNullOperationsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmNullOperationsList" MUID: (57CEBF6B0343)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmOperationsList
;

type
 TmsmNullOperationsList = class(TmsmOperationsList)
  public
   class function Instance: TmsmNullOperationsList;
    {* Метод получения экземпляра синглетона TmsmNullOperationsList }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmNullOperationsList

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57CEBF6B0343impl_uses*
 //#UC END# *57CEBF6B0343impl_uses*
;

var g_TmsmNullOperationsList: TmsmNullOperationsList = nil;
 {* Экземпляр синглетона TmsmNullOperationsList }

procedure TmsmNullOperationsListFree;
 {* Метод освобождения экземпляра синглетона TmsmNullOperationsList }
begin
 l3Free(g_TmsmNullOperationsList);
end;//TmsmNullOperationsListFree

class function TmsmNullOperationsList.Instance: TmsmNullOperationsList;
 {* Метод получения экземпляра синглетона TmsmNullOperationsList }
begin
 if (g_TmsmNullOperationsList = nil) then
 begin
  l3System.AddExitProc(TmsmNullOperationsListFree);
  g_TmsmNullOperationsList := Create;
 end;
 Result := g_TmsmNullOperationsList;
end;//TmsmNullOperationsList.Instance

class function TmsmNullOperationsList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmNullOperationsList <> nil;
end;//TmsmNullOperationsList.Exists

end.
