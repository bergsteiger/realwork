unit nsBaseSearchFormGUIDFactory;
 {* Фабрика GUID'ов для форм БП }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\nsBaseSearchFormGUIDFactory.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormGUIDFromMainFormList
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsBaseSearchFormGUIDFactory = class(TvcmFormGUIDFromMainFormList)
  {* Фабрика GUID'ов для форм БП }
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsBaseSearchFormGUIDFactory;
    {* Метод получения экземпляра синглетона TnsBaseSearchFormGUIDFactory }
 end;//TnsBaseSearchFormGUIDFactory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsBaseSearchFormGUIDFactory: TnsBaseSearchFormGUIDFactory = nil;
 {* Экземпляр синглетона TnsBaseSearchFormGUIDFactory }

procedure TnsBaseSearchFormGUIDFactoryFree;
 {* Метод освобождения экземпляра синглетона TnsBaseSearchFormGUIDFactory }
begin
 l3Free(g_TnsBaseSearchFormGUIDFactory);
end;//TnsBaseSearchFormGUIDFactoryFree

class function TnsBaseSearchFormGUIDFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsBaseSearchFormGUIDFactory <> nil;
end;//TnsBaseSearchFormGUIDFactory.Exists

class function TnsBaseSearchFormGUIDFactory.Instance: TnsBaseSearchFormGUIDFactory;
 {* Метод получения экземпляра синглетона TnsBaseSearchFormGUIDFactory }
begin
 if (g_TnsBaseSearchFormGUIDFactory = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchFormGUIDFactoryFree);
  g_TnsBaseSearchFormGUIDFactory := Create;
 end;
 Result := g_TnsBaseSearchFormGUIDFactory;
end;//TnsBaseSearchFormGUIDFactory.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
