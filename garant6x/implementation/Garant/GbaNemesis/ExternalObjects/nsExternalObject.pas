unit nsExternalObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsExternalObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsExternalObject" MUID: (52D669BA02CC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsExternalObjectPrim
;

type
 TnsExternalObject = class(TnsExternalObjectPrim)
  public
   class function Instance: TnsExternalObject;
    {* Метод получения экземпляра синглетона TnsExternalObject }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsExternalObject

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *52D669BA02CCimpl_uses*
 //#UC END# *52D669BA02CCimpl_uses*
;

var g_TnsExternalObject: TnsExternalObject = nil;
 {* Экземпляр синглетона TnsExternalObject }

procedure TnsExternalObjectFree;
 {* Метод освобождения экземпляра синглетона TnsExternalObject }
begin
 l3Free(g_TnsExternalObject);
end;//TnsExternalObjectFree

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

class function TnsExternalObject.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsExternalObject <> nil;
end;//TnsExternalObject.Exists

end.
