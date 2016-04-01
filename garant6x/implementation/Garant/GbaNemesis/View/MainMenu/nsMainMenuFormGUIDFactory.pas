unit nsMainMenuFormGUIDFactory;
 {* Фабрика GUID'ов для ОМ
http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\nsMainMenuFormGUIDFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMainMenuFormGUIDFactory" MUID: (4F2012220355)

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
 TnsMainMenuFormGUIDFactory = class(TvcmFormGUIDFromMainFormList)
  {* Фабрика GUID'ов для ОМ
http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414 }
  public
   class function Instance: TnsMainMenuFormGUIDFactory;
    {* Метод получения экземпляра синглетона TnsMainMenuFormGUIDFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsMainMenuFormGUIDFactory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_TnsMainMenuFormGUIDFactory: TnsMainMenuFormGUIDFactory = nil;
 {* Экземпляр синглетона TnsMainMenuFormGUIDFactory }

procedure TnsMainMenuFormGUIDFactoryFree;
 {* Метод освобождения экземпляра синглетона TnsMainMenuFormGUIDFactory }
begin
 l3Free(g_TnsMainMenuFormGUIDFactory);
end;//TnsMainMenuFormGUIDFactoryFree

class function TnsMainMenuFormGUIDFactory.Instance: TnsMainMenuFormGUIDFactory;
 {* Метод получения экземпляра синглетона TnsMainMenuFormGUIDFactory }
begin
 if (g_TnsMainMenuFormGUIDFactory = nil) then
 begin
  l3System.AddExitProc(TnsMainMenuFormGUIDFactoryFree);
  g_TnsMainMenuFormGUIDFactory := Create;
 end;
 Result := g_TnsMainMenuFormGUIDFactory;
end;//TnsMainMenuFormGUIDFactory.Instance

class function TnsMainMenuFormGUIDFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsMainMenuFormGUIDFactory <> nil;
end;//TnsMainMenuFormGUIDFactory.Exists
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
