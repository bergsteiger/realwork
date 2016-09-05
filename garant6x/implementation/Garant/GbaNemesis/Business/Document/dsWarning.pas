unit dsWarning;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsWarning.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsWarning" MUID: (492189D90209)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nsTypes
 , DocumentInterfaces
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _FormDataSourceType_ = IdsWarning;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsWarning = {final} class(_vcmFormDataSourcePrim_, IdsWarning)
  private
   f_WarningContent: TWarningTypeSet;
   WarningGenerator: InsWarningGenerator;
   ucc_BaseDocument: IsdsBaseDocument;
  protected
   function DoGetDocInfo: IdeDocInfo; virtual;
   function DoGenerateWarning(const aGenerator: InevTagGenerator;
    aUserType: Integer): TWarningTypeSet; virtual;
   function GetIsForSynchroView: Boolean; virtual;
   procedure GenerateWarning(const aGenerator: InevTagGenerator;
    aUserType: Integer);
    {* генерация текста предупреждения }
   function pm_GetWarningContent: TWarningTypeSet;
   function pm_GetDocInfo: IdeDocInfo;
   function Get_ForSynchroView: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsWarning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
 //#UC START# *492189D90209impl_uses*
 //#UC END# *492189D90209impl_uses*
;

type _Instance_R_ = TdsWarning;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

function TdsWarning.DoGetDocInfo: IdeDocInfo;
//#UC START# *4EDCF99301CA_492189D90209_var*
//#UC END# *4EDCF99301CA_492189D90209_var*
begin
//#UC START# *4EDCF99301CA_492189D90209_impl*
 if Assigned(ucc_BaseDocument) then
  Result := ucc_BaseDocument.DocInfo
 else
  Result := nil;
//#UC END# *4EDCF99301CA_492189D90209_impl*
end;//TdsWarning.DoGetDocInfo

function TdsWarning.DoGenerateWarning(const aGenerator: InevTagGenerator;
 aUserType: Integer): TWarningTypeSet;
//#UC START# *4EF4849D01C9_492189D90209_var*
//#UC END# *4EF4849D01C9_492189D90209_var*
begin
//#UC START# *4EF4849D01C9_492189D90209_impl*
 if (WarningGenerator <> nil) then
  Result := WarningGenerator.Generate(Self, aGenerator, aUserType)
 else
  Result := []; 
//#UC END# *4EF4849D01C9_492189D90209_impl*
end;//TdsWarning.DoGenerateWarning

function TdsWarning.GetIsForSynchroView: Boolean;
//#UC START# *4EFC5A6501C9_492189D90209_var*
//#UC END# *4EFC5A6501C9_492189D90209_var*
begin
//#UC START# *4EFC5A6501C9_492189D90209_impl*
 Result := false;
//#UC END# *4EFC5A6501C9_492189D90209_impl*
end;//TdsWarning.GetIsForSynchroView

procedure TdsWarning.GenerateWarning(const aGenerator: InevTagGenerator;
 aUserType: Integer);
 {* генерация текста предупреждения }
//#UC START# *492186B0008F_492189D90209_var*
//#UC END# *492186B0008F_492189D90209_var*
begin
//#UC START# *492186B0008F_492189D90209_impl*
 f_WarningContent := DoGenerateWarning(aGenerator, aUserType);
//#UC END# *492186B0008F_492189D90209_impl*
end;//TdsWarning.GenerateWarning

function TdsWarning.pm_GetWarningContent: TWarningTypeSet;
//#UC START# *492186D101E0_492189D90209get_var*
//#UC END# *492186D101E0_492189D90209get_var*
begin
//#UC START# *492186D101E0_492189D90209get_impl*
 Result := f_WarningContent;
//#UC END# *492186D101E0_492189D90209get_impl*
end;//TdsWarning.pm_GetWarningContent

function TdsWarning.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_492189D90209get_var*
//#UC END# *4DF9D63B0360_492189D90209get_var*
begin
//#UC START# *4DF9D63B0360_492189D90209get_impl*
 Result := DoGetDocInfo;
//#UC END# *4DF9D63B0360_492189D90209get_impl*
end;//TdsWarning.pm_GetDocInfo

function TdsWarning.Get_ForSynchroView: Boolean;
//#UC START# *4EFC5A31016E_492189D90209get_var*
//#UC END# *4EFC5A31016E_492189D90209get_var*
begin
//#UC START# *4EFC5A31016E_492189D90209get_impl*
 Result := GetIsForSynchroView;
//#UC END# *4EFC5A31016E_492189D90209get_impl*
end;//TdsWarning.Get_ForSynchroView

procedure TdsWarning.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_492189D90209_var*
//#UC END# *479731C50290_492189D90209_var*
begin
//#UC START# *479731C50290_492189D90209_impl*
 f_WarningContent := cEmptyWarning;
 inherited;
//#UC END# *479731C50290_492189D90209_impl*
end;//TdsWarning.Cleanup

{$If NOT Defined(NoVCM)}
procedure TdsWarning.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 Supports(aDS, InsWarningGenerator, WarningGenerator);
 Supports(aDS, IsdsBaseDocument, ucc_BaseDocument);
end;//TdsWarning.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsWarning.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 WarningGenerator := nil;
 ucc_BaseDocument := nil;
end;//TdsWarning.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
