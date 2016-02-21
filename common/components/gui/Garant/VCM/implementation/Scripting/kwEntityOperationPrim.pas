unit kwEntityOperationPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperationPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , vcmBaseOperationsCollectionItem
 , vcmBaseEntitiesCollectionItem
 , tfwScriptingInterfaces
 , vcmExternalInterfaces
;

type
 TkwEntityOperationPrim = class(TtfwRegisterableWordPrim)
  protected
   f_Op: TvcmBaseOperationsCollectionItem;
   f_En: TvcmBaseEntitiesCollectionItem;
  protected
   procedure DoOp(const aCtx: TtfwContext;
    const anOp: TvcmOPID); virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   constructor Create(anEn: TvcmBaseEntitiesCollectionItem;
    anOp: TvcmBaseOperationsCollectionItem); reintroduce;
 end;//TkwEntityOperationPrim
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

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

initialization
 TkwEntityOperationPrim.RegisterClass;
 {* Регистрация TkwEntityOperationPrim }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
