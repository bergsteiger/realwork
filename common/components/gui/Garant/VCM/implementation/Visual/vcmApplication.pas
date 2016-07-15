unit vcmApplication;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmApplication.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmApplication" MUID: (4AB22E140136)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmBaseOperationState
 , vcmModule
 , l3StringIDEx
 //#UC START# *4AB22E140136intf_uses*
 //#UC END# *4AB22E140136intf_uses*
;

type
 //#UC START# *4AB22E140136ci*
 //#UC END# *4AB22E140136ci*
 //#UC START# *4AB22E140136cit*
 //#UC END# *4AB22E140136cit*
 TvcmApplication = class
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class procedure PublishModule(aModule: RvcmModule;
    const aCap: AnsiString);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   class function PublishModuleOperation(aModule: RvcmModule;
    const aName: AnsiString;
    const aCap: AnsiString;
    aNoPrefix: Boolean = False): TvcmMOPID;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   class procedure MakeResources; virtual;
   class procedure Runner(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString); virtual;
   class procedure BeforeApplicationRun; virtual;
   class procedure RegisterOperations;
  public
   {$If NOT Defined(DesignTimeLibrary)}
   class function PublishOperation(const anEn: AnsiString;
    const anOp: AnsiString;
    const anEnCap: AnsiString;
    const anOpCap: AnsiString;
    aNoPrefix: Boolean = False): TvcmOPID;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   class function PublishInternalOperation(const anEn: AnsiString;
    const anOp: AnsiString;
    const anEnCap: AnsiString;
    const anOpCap: AnsiString;
    aNoPrefix: Boolean = False): TvcmOPID;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   class function PublishOperationState(const anEn: AnsiString;
    const anOp: AnsiString;
    const aState: AnsiString;
    aNoPrefix: Boolean = False): TvcmBaseOperationState;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   class procedure SetOperationImageIndex(const anEn: AnsiString;
    const anOp: AnsiString;
    anImageIndex: Integer;
    aNoPrefix: Boolean = False);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   class procedure Run(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString);
 //#UC START# *4AB22E140136publ*
 //#UC END# *4AB22E140136publ*
 end;//TvcmApplication
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBaseMenuManager
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
 , vcmModulesForRegister
 , vcmModuleOperationsForRegister
 , vcmModulesCollection
 , vcmRepEntitiesCollection
 , l3ConstStrings
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFacade
 //#UC START# *4AB22E140136impl_uses*
 //#UC END# *4AB22E140136impl_uses*
;

{$If NOT Defined(DesignTimeLibrary)}
class procedure TvcmApplication.PublishModule(aModule: RvcmModule;
 const aCap: AnsiString);
//#UC START# *4AB33E56019A_4AB22E140136_var*
//#UC END# *4AB33E56019A_4AB22E140136_var*
begin
//#UC START# *4AB33E56019A_4AB22E140136_impl*
 TvcmModulesCollection(g_MenuManager.Modules).PublishModule(aModule, aCap);
//#UC END# *4AB33E56019A_4AB22E140136_impl*
end;//TvcmApplication.PublishModule
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmApplication.PublishModuleOperation(aModule: RvcmModule;
 const aName: AnsiString;
 const aCap: AnsiString;
 aNoPrefix: Boolean = False): TvcmMOPID;
//#UC START# *4AB33E8201D8_4AB22E140136_var*
//#UC END# *4AB33E8201D8_4AB22E140136_var*
begin
//#UC START# *4AB33E8201D8_4AB22E140136_impl*
 Result := TvcmModulesCollection(g_MenuManager.Modules)
            .PublishModuleOperation(aModule, aName, aCap, aNoPrefix);
//#UC END# *4AB33E8201D8_4AB22E140136_impl*
end;//TvcmApplication.PublishModuleOperation
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmApplication.PublishOperation(const anEn: AnsiString;
 const anOp: AnsiString;
 const anEnCap: AnsiString;
 const anOpCap: AnsiString;
 aNoPrefix: Boolean = False): TvcmOPID;
//#UC START# *4AB33EF900E2_4AB22E140136_var*
//#UC END# *4AB33EF900E2_4AB22E140136_var*
begin
//#UC START# *4AB33EF900E2_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishOperation(anEn, anOp, anEnCap, anOpCap, aNoPrefix);
//#UC END# *4AB33EF900E2_4AB22E140136_impl*
end;//TvcmApplication.PublishOperation
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmApplication.PublishInternalOperation(const anEn: AnsiString;
 const anOp: AnsiString;
 const anEnCap: AnsiString;
 const anOpCap: AnsiString;
 aNoPrefix: Boolean = False): TvcmOPID;
//#UC START# *4AB33F44024A_4AB22E140136_var*
//#UC END# *4AB33F44024A_4AB22E140136_var*
begin
//#UC START# *4AB33F44024A_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishInternalOperation(anEn, anOp, anEnCap, anOpCap, aNoPrefix);
//#UC END# *4AB33F44024A_4AB22E140136_impl*
end;//TvcmApplication.PublishInternalOperation
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmApplication.PublishOperationState(const anEn: AnsiString;
 const anOp: AnsiString;
 const aState: AnsiString;
 aNoPrefix: Boolean = False): TvcmBaseOperationState;
//#UC START# *4C77C9C402B7_4AB22E140136_var*
//#UC END# *4C77C9C402B7_4AB22E140136_var*
begin
//#UC START# *4C77C9C402B7_4AB22E140136_impl*
 Result := TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .PublishOperationState(anEn, anOp, aState, aNoPrefix);
//#UC END# *4C77C9C402B7_4AB22E140136_impl*
end;//TvcmApplication.PublishOperationState
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
class procedure TvcmApplication.SetOperationImageIndex(const anEn: AnsiString;
 const anOp: AnsiString;
 anImageIndex: Integer;
 aNoPrefix: Boolean = False);
//#UC START# *4EC4C83F01B4_4AB22E140136_var*
//#UC END# *4EC4C83F01B4_4AB22E140136_var*
begin
//#UC START# *4EC4C83F01B4_4AB22E140136_impl*
 TvcmRepEntitiesCollection(g_MenuManager.Entities)
            .SetOperationImageIndex(anEn, anOp, anImageIndex, aNoPrefix);
//#UC END# *4EC4C83F01B4_4AB22E140136_impl*
end;//TvcmApplication.SetOperationImageIndex
{$IfEnd} // NOT Defined(DesignTimeLibrary)

class procedure TvcmApplication.MakeResources;
//#UC START# *4F6AF5F00058_4AB22E140136_var*
//#UC END# *4F6AF5F00058_4AB22E140136_var*
begin
//#UC START# *4F6AF5F00058_4AB22E140136_impl*
 assert(false);
//#UC END# *4F6AF5F00058_4AB22E140136_impl*
end;//TvcmApplication.MakeResources

class procedure TvcmApplication.Run(const aTitle: Tl3StringIDEx;
 const aHelpFile: AnsiString);
//#UC START# *4F79A8E60206_4AB22E140136_var*
//#UC END# *4F79A8E60206_4AB22E140136_var*
begin
//#UC START# *4F79A8E60206_4AB22E140136_impl*
 afw.Application.ApplyActiveLanguage(Tl3ConstStrings.Instance);
 Runner(aTitle, aHelpFile);
//#UC END# *4F79A8E60206_4AB22E140136_impl*
end;//TvcmApplication.Run

class procedure TvcmApplication.Runner(const aTitle: Tl3StringIDEx;
 const aHelpFile: AnsiString);
//#UC START# *4F6AF5860291_4AB22E140136_var*
//#UC END# *4F6AF5860291_4AB22E140136_var*
begin
//#UC START# *4F6AF5860291_4AB22E140136_impl*
 assert(false);
//#UC END# *4F6AF5860291_4AB22E140136_impl*
end;//TvcmApplication.Runner

class procedure TvcmApplication.BeforeApplicationRun;
//#UC START# *52F2269B0373_4AB22E140136_var*
//#UC END# *52F2269B0373_4AB22E140136_var*
begin
//#UC START# *52F2269B0373_4AB22E140136_impl*
 // - ничего не делаем
//#UC END# *52F2269B0373_4AB22E140136_impl*
end;//TvcmApplication.BeforeApplicationRun

class procedure TvcmApplication.RegisterOperations;
//#UC START# *5788BA13039A_4AB22E140136_var*
{$IfNDef DesignTimeLibrary}
var
 l_Index : Integer;
 l_StateIndex : Integer;
{$EndIf} 
//#UC END# *5788BA13039A_4AB22E140136_var*
begin
//#UC START# *5788BA13039A_4AB22E140136_impl*
{$IfNDef DesignTimeLibrary}
 if TvcmModulesForRegister.Exists then
 begin
  with TvcmModulesForRegister.Instance do
  begin
   for l_Index := 0 to Pred(Count) do
   begin
    with ItemSlot(l_Index)^ do
     Self.PublishModule(rModule, rModuleCaption);
   end;//for l_Index
  end;//with TvcmModulesForRegister.Instance
 end;//TvcmModulesForRegister.Exists
 
 if TvcmModuleOperationsForRegister.Exists then
 begin
  with TvcmModuleOperationsForRegister.Instance do
  begin
   for l_Index := 0 to Pred(Count) do
   begin
    with ItemSlot(l_Index)^ do
     rVar^ := Self.PublishModuleOperation(rModule, rOperationName, rOperationCaption, rNoPrefix);
   end;//for l_Index
  end;//with TvcmModuleOperationsForRegister.Instance
 end;//TvcmModuleOperationsForRegister.Exists

 if TvcmOperationsForRegister.Exists then
 begin
  with TvcmOperationsForRegister.Instance do
  begin
   for l_Index := 0 to Pred(Count) do
   begin
    with Items[l_Index] do
    begin
     with Descr do
     begin
      if rInternal then
       rVar^ := Self.PublishInternalOperation(rEntityName, rOperationName, rEntityCaption, rOperationCaption, rNoPrefix)
      else
       rVar^ := Self.PublishOperation(rEntityName, rOperationName, rEntityCaption, rOperationCaption, rNoPrefix);
      if (rImageIndex >= 0) then
       SetOperationImageIndex(rEntityName, rOperationName, rImageIndex, rNoPrefix);
     end;//with Descr
     if (States <> nil) then
     begin
      for l_StateIndex := 0 to Pred(States.Count) do
      begin
       with States.ItemSlot(l_StateIndex)^ do
        with PublishOperationState(Descr.rEntityName, Descr.rOperationName, rStateName, Descr.rNoPrefix) do
        begin
         rVar^ := StateIndex;
         if (rCaption <> '') then
          Caption := rCaption;
         if (rHint <> '') then
          Hint := rHint;
         if (rImageIndex >= 0) then
          ImageIndex := rImageIndex;
         if (rEnabled <> vcm_osfUndefined) then
          Enabled := rEnabled = vcm_osfTrue;
         if (rVisible <> vcm_osfUndefined) then
          Visible := rVisible = vcm_osfTrue;
         if (rChecked <> vcm_osfUndefined) then
          Checked := rChecked = vcm_osfTrue;
        end;//with PublishOperationState
      end;//for l_StateIndex
     end;//States <> nil
    end;//with Items[l_Index]
   end;//for l_Index 
  end;//with TvcmOperationsForRegister.Instance
 end;//TvcmOperationsForRegister.Exists
 g_MenuManager.RegisterKeywords;
{$EndIf}
//#UC END# *5788BA13039A_4AB22E140136_impl*
end;//TvcmApplication.RegisterOperations

//#UC START# *4AB22E140136impl*
//#UC END# *4AB22E140136impl*
{$IfEnd} // NOT Defined(NoVCM)

end.
