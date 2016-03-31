unit nsWindowsList;
 {* класс управляющий списком окон }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\nsWindowsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsWindowsList" MUID: (4ADC5175035B)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , nsWindowsListPrim
;

type
 TnsWindowsList = class(TnsWindowsListPrim)
  {* класс управляющий списком окон }
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsWindowsList;
    {* Метод получения экземпляра синглетона TnsWindowsList }
 end;//TnsWindowsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsWindowsList: TnsWindowsList = nil;
 {* Экземпляр синглетона TnsWindowsList }

procedure TnsWindowsListFree;
 {* Метод освобождения экземпляра синглетона TnsWindowsList }
begin
 l3Free(g_TnsWindowsList);
end;//TnsWindowsListFree

class function TnsWindowsList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsWindowsList <> nil;
end;//TnsWindowsList.Exists

class function TnsWindowsList.Instance: TnsWindowsList;
 {* Метод получения экземпляра синглетона TnsWindowsList }
begin
 if (g_TnsWindowsList = nil) then
 begin
  l3System.AddExitProc(TnsWindowsListFree);
  g_TnsWindowsList := Create;
 end;
 Result := g_TnsWindowsList;
end;//TnsWindowsList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
