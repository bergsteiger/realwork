unit npControlsList;
 {* список навигаторов на форме, от которых были отстыкованы компоненты. }

// Модуль: "w:\common\components\gui\Garant\VT\npControlsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnpControlsList" MUID: (4F61DE580121)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , npControlsListPrim
;

type
 TnpControlsList = class(TnpControlsListPrim)
  {* список навигаторов на форме, от которых были отстыкованы компоненты. }
  public
   class function Instance: TnpControlsList;
    {* Метод получения экземпляра синглетона TnpControlsList }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnpControlsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnpControlsList: TnpControlsList = nil;
 {* Экземпляр синглетона TnpControlsList }

procedure TnpControlsListFree;
 {* Метод освобождения экземпляра синглетона TnpControlsList }
begin
 l3Free(g_TnpControlsList);
end;//TnpControlsListFree

class function TnpControlsList.Instance: TnpControlsList;
 {* Метод получения экземпляра синглетона TnpControlsList }
begin
 if (g_TnpControlsList = nil) then
 begin
  l3System.AddExitProc(TnpControlsListFree);
  g_TnpControlsList := Create;
 end;
 Result := g_TnpControlsList;
end;//TnpControlsList.Instance

class function TnpControlsList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnpControlsList <> nil;
end;//TnpControlsList.Exists
{$IfEnd} // NOT Defined(NoVCM)

end.
