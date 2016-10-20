unit tfwModuleOperationWordEx;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\tfwModuleOperationWordEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwModuleOperationWordEx" MUID: (5770F145022B)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwModuleOperationWord
 , vcmExternalInterfaces
 , vcmModulesCollectionItem
 , vcmBaseCollectionItem
 //#UC START# *5770F145022Bintf_uses*
 //#UC END# *5770F145022Bintf_uses*
;

type
 //#UC START# *5770F145022Bci*
 //#UC END# *5770F145022Bci*
 //#UC START# *5770F145022Bcit*
 //#UC END# *5770F145022Bcit*
 TtfwModuleOperationWordEx = class(TtfwModuleOperationWord)
  private
   f_ModuleOperationCode: TvcmMOPID;
  protected
   function GetModuleOperationCode: TvcmMOPID; override;
   class function ReallyNeedRegister: Boolean; override;
  public
   class procedure Register(const aCode: TvcmMOPID;
    aModule: TvcmModulesCollectionItem;
    anOp: TvcmBaseCollectionItem);
 //#UC START# *5770F145022Bpubl*
 //#UC END# *5770F145022Bpubl*
 end;//TtfwModuleOperationWordEx
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 , kwString
 , vcmBaseOperationsCollectionItem
 , vcmBaseMenuManager
 , l3Except
 , SysUtils
 //#UC START# *5770F145022Bimpl_uses*
 , StrUtils
 , tfwCStringFactory
 //#UC END# *5770F145022Bimpl_uses*
;

class procedure TtfwModuleOperationWordEx.Register(const aCode: TvcmMOPID;
 aModule: TvcmModulesCollectionItem;
 anOp: TvcmBaseCollectionItem);
//#UC START# *5770F2320299_5770F145022B_var*
var
 l_W : TtfwModuleOperationWordEx;
 l_MN : AnsiString;
 l_ON : AnsiString;
 l_ToolbarControl : TkwString;
 l_ToolbarControlName : String;
//#UC END# *5770F2320299_5770F145022B_var*
begin
//#UC START# *5770F2320299_5770F145022B_impl*
 l_W := Create;
 try
  l_W.f_ModuleOperationCode := aCode;
  l_MN := aModule.Caption;
  l_ON := anOp.Caption;
  l_W.RegisterInstance(AnsiReplaceStr('моп::' + l_MN + '_' + l_ON, #32, '_'));
 finally
  FreeAndNil(l_W);
 end;//try..finally
 l_W := Create;
 try
  l_W.f_ModuleOperationCode := aCode;
  l_MN := aModule.Name;
  l_ON := anOp.Name;
  l_W.RegisterInstance(AnsiReplaceStr('mop::' + l_MN + '_' + l_ON, #32, '_'));
 finally
  FreeAndNil(l_W);
 end;//try..finally
 l_ToolbarControlName := 'bt_' + {'mo_' +} aModule.Name + '_' + anOp.Name;
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
//#UC END# *5770F2320299_5770F145022B_impl*
end;//TtfwModuleOperationWordEx.Register

function TtfwModuleOperationWordEx.GetModuleOperationCode: TvcmMOPID;
//#UC START# *4DB079E00084_5770F145022B_var*
//#UC END# *4DB079E00084_5770F145022B_var*
begin
//#UC START# *4DB079E00084_5770F145022B_impl*
 Result := f_ModuleOperationCode;
//#UC END# *4DB079E00084_5770F145022B_impl*
end;//TtfwModuleOperationWordEx.GetModuleOperationCode

class function TtfwModuleOperationWordEx.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_5770F145022B_var*
//#UC END# *4DC2E05B03DD_5770F145022B_var*
begin
//#UC START# *4DC2E05B03DD_5770F145022B_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_5770F145022B_impl*
end;//TtfwModuleOperationWordEx.ReallyNeedRegister

//#UC START# *5770F145022Bimpl*
//#UC END# *5770F145022Bimpl*

initialization
 TtfwModuleOperationWordEx.RegisterClass;
 {* Регистрация TtfwModuleOperationWordEx }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
