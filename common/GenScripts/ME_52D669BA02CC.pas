unit nsExternalObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsExternalObject.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsExternalObjectPrim
;

type
 TnsExternalObject = class(TnsExternalObjectPrim)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsExternalObject;
    {* Метод получения экземпляра синглетона TnsExternalObject }
 end;//TnsExternalObject

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsExternalObject: TnsExternalObject = nil;
 {* Экземпляр синглетона TnsExternalObject }

procedure TnsExternalObjectFree;
 {* Метод освобождения экземпляра синглетона TnsExternalObject }
begin
 l3Free(g_TnsExternalObject);
end;//TnsExternalObjectFree

class function TnsExternalObject.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsExternalObject <> nil;
end;//TnsExternalObject.Exists

class function TnsExternalObject.Instance: TnsExternalObject;
 {* Метод получения экземпляра синглетона TnsExternalObject }
begin
 if (g_TnsExternalObject = nil) then
 begin
  l3System.AddExitProc(TnsExternalObjectFree);
  g_TnsExternalObject := Create;
 end;
 Result := g_TnsExternalObject;
end;//TnsExternalObject.Instance

end.
