unit seModalWorkerList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\seModalWorkerList.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , seModalWorkerListPrim
;

type
 TseModalWorkerList = class(TseModalWorkerListPrim)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TseModalWorkerList;
    {* Метод получения экземпляра синглетона TseModalWorkerList }
 end;//TseModalWorkerList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TseModalWorkerList: TseModalWorkerList = nil;
 {* Экземпляр синглетона TseModalWorkerList }

procedure TseModalWorkerListFree;
 {* Метод освобождения экземпляра синглетона TseModalWorkerList }
begin
 l3Free(g_TseModalWorkerList);
end;//TseModalWorkerListFree

class function TseModalWorkerList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TseModalWorkerList <> nil;
end;//TseModalWorkerList.Exists

class function TseModalWorkerList.Instance: TseModalWorkerList;
 {* Метод получения экземпляра синглетона TseModalWorkerList }
begin
 if (g_TseModalWorkerList = nil) then
 begin
  l3System.AddExitProc(TseModalWorkerListFree);
  g_TseModalWorkerList := Create;
 end;
 Result := g_TseModalWorkerList;
end;//TseModalWorkerList.Instance
{$IfEnd} // NOT Defined(NoScripts)

end.
