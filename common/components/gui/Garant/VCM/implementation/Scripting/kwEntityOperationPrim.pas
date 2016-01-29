unit kwEntityOperationPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwEntityOperationPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Scripting::Operations::TkwEntityOperationPrim
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
  vcmExternalInterfaces,
  vcmBaseOperationsCollectionItem,
  tfwScriptingInterfaces,
  vcmBaseEntitiesCollectionItem,
  tfwRegisterableWordPrim
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 TkwEntityOperationPrim = class(TtfwRegisterableWordPrim)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected fields
   f_Op : TvcmBaseOperationsCollectionItem;
   f_En : TvcmBaseEntitiesCollectionItem;
 protected
 // protected methods
   procedure DoOp(const aCtx: TtfwContext;
     const anOp: TvcmOPID); virtual; abstract;
 public
 // public methods
   constructor Create(anEn: TvcmBaseEntitiesCollectionItem;
     anOp: TvcmBaseOperationsCollectionItem); reintroduce;
 end;//TkwEntityOperationPrim
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class TkwEntityOperationPrim

constructor TkwEntityOperationPrim.Create(anEn: TvcmBaseEntitiesCollectionItem;
  anOp: TvcmBaseOperationsCollectionItem);
//#UC START# *4DDBBDEB00DE_523006F7004A_var*
//#UC END# *4DDBBDEB00DE_523006F7004A_var*
begin
//#UC START# *4DDBBDEB00DE_523006F7004A_impl*
 inherited Create;
 f_En := anEn;
 f_Op := anOp;
//#UC END# *4DDBBDEB00DE_523006F7004A_impl*
end;//TkwEntityOperationPrim.Create

procedure TkwEntityOperationPrim.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_523006F7004A_var*
var
 l_Op  : TvcmOPID;
//#UC END# *4DAEEDE10285_523006F7004A_var*
begin
//#UC START# *4DAEEDE10285_523006F7004A_impl*
 l_Op.rEnID := f_En.Index + 1;
 l_Op.rOpID := f_Op.Index + 1;
 DoOp(aCtx, l_Op);
//#UC END# *4DAEEDE10285_523006F7004A_impl*
end;//TkwEntityOperationPrim.DoDoIt

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TkwEntityOperationPrim
 TkwEntityOperationPrim.RegisterClass;
{$IfEnd} //not NoScripts AND not NoVCM

end.