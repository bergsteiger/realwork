unit kwEntityOperation;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwEntityOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwEntityOperation" MUID: (4DDBBDB00019)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwEntityOperationPrim
 , vcmBaseEntitiesCollectionItem
 , vcmBaseOperationsCollectionItem
 , tfwScriptingInterfaces
 , vcmExternalInterfaces
;

type
 TkwEntityOperation = class(TkwEntityOperationPrim)
  protected
   procedure DoOp(const aCtx: TtfwContext;
    const anOp: TvcmOPID); override;
  public
   class procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
    anOp: TvcmBaseOperationsCollectionItem);
 end;//TkwEntityOperation
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 , vcmRepOperationsCollectionItem
 , vcmInterfaces
 , kwEntityOperationTest
 , kwString
 , kwOperationsRegistrar
 , SysUtils
 , StrUtils
 , l3Except
;

class procedure TkwEntityOperation.Register(anEn: TvcmBaseEntitiesCollectionItem;
 anOp: TvcmBaseOperationsCollectionItem);
//#UC START# *4DDBBF790154_4DDBBDB00019_var*
var
 l_Op : TkwEntityOperation;
 l_TOp : TkwEntityOperationTest;
 l_EC : String;
 l_OC : String;
 l_ToolbarControl : TkwString;
 l_ToolbarControlName : String;
//#UC END# *4DDBBF790154_4DDBBDB00019_var*
begin
//#UC START# *4DDBBF790154_4DDBBDB00019_impl*
 if (anOp.OperationType = vcm_otInternal) then
(*  if ((anOp As TvcmRepOperationsCollectionItem).FormActivate = nil) OR
     ((anOp As TvcmRepOperationsCollectionItem).FormActivate.Name = '') then*)
  Exit;
 l_Op := Create(anEn, anOp);
 try
  l_EC := anEn.Caption;
  if (l_EC = '') then
   l_EC := anEn.Name;
  l_OC := anOp.Caption;
  if (l_OC = '') then
   l_OC := anOp.Name;
  l_EC := ANSIReplaceStr(l_EC, #32, '_');
  l_OC := ANSIReplaceStr(l_OC, #32, '_');
  try
   l_Op.RegisterInstance('оп::' + l_EC + '_' + l_OC);
  except
   on El3DuplicateItem do
    try
     l_Op.RegisterInstance('оп::' + anEn.Name + '::' + l_EC + '_' + l_OC);
    except
     on El3DuplicateItem do
      ;
    end;//try..except
  end;//try..except
  l_TOp := TkwEntityOperationTest.Create(anEn, anOp);
  try
   try
    l_TOp.RegisterInstance('оп::тест::' + l_EC + '_' + l_OC);
   except
    on El3DuplicateItem do
     try
      l_TOp.RegisterInstance('оп::тест::' + anEn.Name + '::' + l_EC + '_' + l_OC);
     except
      on El3DuplicateItem do
       ;
     end;//try..except
   end;//try..except
  finally
   FreeAndNil(l_TOp);
  end;//try..finally
 finally
  FreeAndNil(l_Op);
 end;//try..finally
 l_ToolbarControlName := 'bt_' + anEn.Name + '_' + anOp.Name;
 l_ToolbarControl := TkwString.Create(TtfwCStringFactory.C(l_ToolbarControlName));
 try
  try
   l_ToolbarControl.RegisterInstance('контрол::' + l_ToolbarControlName);
  except
   on El3DuplicateItem do
    ;
  end;//try..except
 finally
  FreeAndNil(l_ToolbarControl);
 end;//try..finally
//#UC END# *4DDBBF790154_4DDBBDB00019_impl*
end;//TkwEntityOperation.Register

procedure TkwEntityOperation.DoOp(const aCtx: TtfwContext;
 const anOp: TvcmOPID);
//#UC START# *523008BC0096_4DDBBDB00019_var*
var
 l_Res : Boolean;
 l_E   : IvcmEntity;
 l_S   : String;
//#UC END# *523008BC0096_4DDBBDB00019_var*
begin
//#UC START# *523008BC0096_4DDBBDB00019_impl*
 l_Res := vcmDispatcher.EntityOperation(anOp, vcmParams);
 if not l_Res then
 begin
  l_E := vcmDispatcher.ActiveEntity;
  l_S := '<no active form>';
  if (l_E <> nil) then
   l_S := l_E.AsForm.VCLWinControl.ClassName;
  aCtx.rCaller.Check(false,
                     Format('Операция %s.%s - %s.%s не выполнилась. Активная форма %s',
                            [f_En.Name, f_Op.Name,
                             f_En.Caption, f_Op.Caption,
                             l_S]));
 end;//not l_Res
//#UC END# *523008BC0096_4DDBBDB00019_impl*
end;//TkwEntityOperation.DoOp

initialization
 TkwEntityOperation.RegisterClass;
 {* Регистрация TkwEntityOperation }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
