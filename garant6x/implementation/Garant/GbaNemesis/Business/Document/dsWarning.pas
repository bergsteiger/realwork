unit dsWarning;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsWarning.pas"
// Начат: 21.09.2005 11.30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::Document::TdsWarning
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nevBase,
  DocumentAndListInterfaces,
  nsTypes,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsWarning;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsWarning = {final vac} class(_vcmFormDataSourcePrim_, IdsWarning)
 private
 // private fields
   f_WarningContent : TWarningTypeSet;
   WarningGenerator : InsWarningGenerator;
   ucc_BaseDocument : IsdsBaseDocument;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   procedure GenerateWarning(const aGenerator: InevTagGenerator;
    aUserType: Integer);
     {* генерация текста предупреждения }
   function pm_GetWarningContent: TWarningTypeSet;
   function pm_GetDocInfo: IdeDocInfo;
   function Get_ForSynchroView: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function DoGetDocInfo: IdeDocInfo; virtual;
   function DoGenerateWarning(const aGenerator: InevTagGenerator;
     aUserType: Integer): TWarningTypeSet; virtual;
   function GetIsForSynchroView: Boolean; virtual;
 end;//TdsWarning
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsWarning;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsWarning

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
//#UC START# *479731C50290_492189D90209_var*
//#UC END# *479731C50290_492189D90209_var*
begin
//#UC START# *479731C50290_492189D90209_impl*
 f_WarningContent := cEmptyWarning;
 inherited;
//#UC END# *479731C50290_492189D90209_impl*
end;//TdsWarning.Cleanup

procedure TdsWarning.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, InsWarningGenerator, WarningGenerator);
 Supports(aDS, IsdsBaseDocument, ucc_BaseDocument);
end;

procedure TdsWarning.ClearRefs;
begin
 inherited;
 WarningGenerator := nil;
 ucc_BaseDocument := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.