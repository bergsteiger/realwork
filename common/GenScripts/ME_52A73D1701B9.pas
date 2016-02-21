unit kwOperationsRegistrar;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwOperationsRegistrar.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmOperationsManager
 , vcmBaseEntitiesCollectionItem
 , vcmBaseOperationsCollectionItem
;

type
 TkwOperationsRegistrar = class(Tl3ProtoObject, IvcmOperationsRegistrar)
  protected
   procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
    anOp: TvcmBaseOperationsCollectionItem);
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TkwOperationsRegistrar;
    {* Метод получения экземпляра синглетона TkwOperationsRegistrar }
 end;//TkwOperationsRegistrar
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , kwEntityOperation
 , SysUtils
 , l3Base
;

var g_TkwOperationsRegistrar: TkwOperationsRegistrar = nil;
 {* Экземпляр синглетона TkwOperationsRegistrar }

procedure TkwOperationsRegistrarFree;
 {* Метод освобождения экземпляра синглетона TkwOperationsRegistrar }
begin
 l3Free(g_TkwOperationsRegistrar);
end;//TkwOperationsRegistrarFree

class function TkwOperationsRegistrar.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TkwOperationsRegistrar <> nil;
end;//TkwOperationsRegistrar.Exists

procedure TkwOperationsRegistrar.Register(anEn: TvcmBaseEntitiesCollectionItem;
 anOp: TvcmBaseOperationsCollectionItem);
//#UC START# *52A73C7103C7_52A73D1701B9_var*
//#UC END# *52A73C7103C7_52A73D1701B9_var*
begin
//#UC START# *52A73C7103C7_52A73D1701B9_impl*
 TkwEntityOperation.Register(anEn, anOp);
//#UC END# *52A73C7103C7_52A73D1701B9_impl*
end;//TkwOperationsRegistrar.Register

class function TkwOperationsRegistrar.Instance: TkwOperationsRegistrar;
 {* Метод получения экземпляра синглетона TkwOperationsRegistrar }
begin
 if (g_TkwOperationsRegistrar = nil) then
 begin
  l3System.AddExitProc(TkwOperationsRegistrarFree);
  g_TkwOperationsRegistrar := Create;
 end;
 Result := g_TkwOperationsRegistrar;
end;//TkwOperationsRegistrar.Instance

initialization
//#UC START# *52A73D57020D*
 TvcmOperationsManager.Instance.Registrar := TkwOperationsRegistrar.Instance;
//#UC END# *52A73D57020D*
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
