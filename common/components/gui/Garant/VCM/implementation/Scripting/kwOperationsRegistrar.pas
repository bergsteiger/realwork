unit kwOperationsRegistrar;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwOperationsRegistrar.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Scripting::Operations::TkwOperationsRegistrar
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  l3ProtoObject,
  vcmOperationsManager,
  vcmBaseOperationsCollectionItem,
  vcmBaseEntitiesCollectionItem
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwOperationsRegistrar = class(Tl3ProtoObject, IvcmOperationsRegistrar)
 protected
 // realized methods
   procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
      anOp: TvcmBaseOperationsCollectionItem);
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TkwOperationsRegistrar;
    {- возвращает экземпляр синглетона. }
 end;//TkwOperationsRegistrar
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  l3Base {a},
  kwEntityOperation
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}


// start class TkwOperationsRegistrar

var g_TkwOperationsRegistrar : TkwOperationsRegistrar = nil;

procedure TkwOperationsRegistrarFree;
begin
 l3Free(g_TkwOperationsRegistrar);
end;

class function TkwOperationsRegistrar.Instance: TkwOperationsRegistrar;
begin
 if (g_TkwOperationsRegistrar = nil) then
 begin
  l3System.AddExitProc(TkwOperationsRegistrarFree);
  g_TkwOperationsRegistrar := Create;
 end;
 Result := g_TkwOperationsRegistrar;
end;


class function TkwOperationsRegistrar.Exists: Boolean;
 {-}
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

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
//#UC START# *52A73D57020D*
 TvcmOperationsManager.Instance.Registrar := TkwOperationsRegistrar.Instance;
//#UC END# *52A73D57020D*
{$IfEnd} //not NoScripts AND not NoVCM

end.