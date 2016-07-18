unit sdsChangesBetweenEditions;
 {* ��������� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\sdsChangesBetweenEditions.pas"
// ���������: "UseCaseControllerImp"
// ������� ������: "TsdsChangesBetweenEditions" MUID: (4DDCD7D0002E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChangesBetweenEditionsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = InsChangesBetweenEditionsInfo;
 _SetDataType_ = IsdsChangesBetweenEditionsData;
 _SetType_ = IsdsChangesBetweenEditions;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
 TsdsChangesBetweenEditions = {final} class(_vcmFormSetDataSource_, IsdsChangesBetweenEditions, IsdsPrimDocument, IsdsEditionsHolder)
  {* ��������� ��� }
  private
   f_Changes: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ Changes }
   f_EditionsList: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ EditionsList }
  protected
   function As_IsdsPrimDocument: IsdsPrimDocument;
    {* ����� ���������� ������ ���������� � IsdsPrimDocument }
   function As_IsdsEditionsHolder: IsdsEditionsHolder;
    {* ����� ���������� ������ ���������� � IsdsEditionsHolder }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* ������ ������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function pm_GetChanges: IdsChangesBetweenEditions;
   function DoGet_Changes: IdsChangesBetweenEditions;
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetEditionsList: IdsEditions;
   function DoGet_EditionsList: IdsEditions;
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsChangesBetweenEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsChangesBetweenEditions
 , sdsChangesBetweenEditionsData
 , deDocInfo
 , dsEditions
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

type _Instance_R_ = TsdsChangesBetweenEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

function TsdsChangesBetweenEditions.As_IsdsPrimDocument: IsdsPrimDocument;
 {* ����� ���������� ������ ���������� � IsdsPrimDocument }
begin
 Result := Self;
end;//TsdsChangesBetweenEditions.As_IsdsPrimDocument

function TsdsChangesBetweenEditions.As_IsdsEditionsHolder: IsdsEditionsHolder;
 {* ����� ���������� ������ ���������� � IsdsEditionsHolder }
begin
 Result := Self;
end;//TsdsChangesBetweenEditions.As_IsdsEditionsHolder

{$If NOT Defined(NoVCM)}
function TsdsChangesBetweenEditions.MakeData: _SetDataType_;
 {* ������ ������. }
//#UC START# *47F3778403D9_4DDCD7D0002E_var*
//#UC END# *47F3778403D9_4DDCD7D0002E_var*
begin
//#UC START# *47F3778403D9_4DDCD7D0002E_impl*
 Result := TsdsChangesBetweenEditionsData.Make(InitialUseCaseData);
//#UC END# *47F3778403D9_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.MakeData
{$IfEnd} // NOT Defined(NoVCM)

function TsdsChangesBetweenEditions.pm_GetChanges: IdsChangesBetweenEditions;
//#UC START# *4DDCD7520351_4DDCD7D0002Eget_var*
//#UC END# *4DDCD7520351_4DDCD7D0002Eget_var*
begin
 if (f_Changes = nil) then
 begin
  f_Changes := TvcmViewAreaControllerRef.Make;
  //#UC START# *4DDCD7520351_4DDCD7D0002Eget_init*
  // - ��� ������������� ������ �� ViewArea
  //#UC END# *4DDCD7520351_4DDCD7D0002Eget_init*
 end;//f_Changes = nil
 if f_Changes.IsEmpty
  //#UC START# *4DDCD7520351_4DDCD7D0002Eget_need*
  // - ������� �������� ViewArea
  //#UC END# *4DDCD7520351_4DDCD7D0002Eget_need*
  then
   f_Changes.Referred := DoGet_Changes;
 Result := IdsChangesBetweenEditions(f_Changes.Referred);
end;//TsdsChangesBetweenEditions.pm_GetChanges

function TsdsChangesBetweenEditions.DoGet_Changes: IdsChangesBetweenEditions;
//#UC START# *4DDCD7520351_4DDCD7D0002Earea_var*
//#UC END# *4DDCD7520351_4DDCD7D0002Earea_var*
begin
//#UC START# *4DDCD7520351_4DDCD7D0002Earea_impl*
 Result := TdsChangesBetweenEditions.Make(Self, InitialUseCaseData);
//#UC END# *4DDCD7520351_4DDCD7D0002Earea_impl*
end;//TsdsChangesBetweenEditions.DoGet_Changes

function TsdsChangesBetweenEditions.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_4DDCD7D0002Eget_var*
//#UC END# *4DF9D63B0360_4DDCD7D0002Eget_var*
begin
//#UC START# *4DF9D63B0360_4DDCD7D0002Eget_impl*
 Result := TdeDocInfo.Make(InitialUseCaseData.RightEdition);
//#UC END# *4DF9D63B0360_4DDCD7D0002Eget_impl*
end;//TsdsChangesBetweenEditions.pm_GetDocInfo

function TsdsChangesBetweenEditions.pm_GetEditionsList: IdsEditions;
//#UC START# *4ED906420134_4DDCD7D0002Eget_var*
//#UC END# *4ED906420134_4DDCD7D0002Eget_var*
begin
 if (f_EditionsList = nil) then
 begin
  f_EditionsList := TvcmViewAreaControllerRef.Make;
  //#UC START# *4ED906420134_4DDCD7D0002Eget_init*
  // - ��� ������������� ������ �� ViewArea
  //#UC END# *4ED906420134_4DDCD7D0002Eget_init*
 end;//f_EditionsList = nil
 if f_EditionsList.IsEmpty
  //#UC START# *4ED906420134_4DDCD7D0002Eget_need*
  // - ������� �������� ViewArea
  //#UC END# *4ED906420134_4DDCD7D0002Eget_need*
  then
   f_EditionsList.Referred := DoGet_EditionsList;
 Result := IdsEditions(f_EditionsList.Referred);
end;//TsdsChangesBetweenEditions.pm_GetEditionsList

function TsdsChangesBetweenEditions.DoGet_EditionsList: IdsEditions;
//#UC START# *4ED906420134_4DDCD7D0002Earea_var*
//#UC END# *4ED906420134_4DDCD7D0002Earea_var*
begin
//#UC START# *4ED906420134_4DDCD7D0002Earea_impl*
 Result := TdsEditions.Make(Self);
//#UC END# *4ED906420134_4DDCD7D0002Earea_impl*
end;//TsdsChangesBetweenEditions.DoGet_EditionsList

{$If NOT Defined(NoVCM)}
function TsdsChangesBetweenEditions.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_4DDCD7D0002E_var*
//#UC END# *53B3BF9C00EF_4DDCD7D0002E_var*
begin
//#UC START# *53B3BF9C00EF_4DDCD7D0002E_impl*
 Result := nsTabIconIndex(titChangesBetweenEditions);
//#UC END# *53B3BF9C00EF_4DDCD7D0002E_impl*
end;//TsdsChangesBetweenEditions.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsChangesBetweenEditions.ClearFields;
begin
 f_Changes := nil;
 f_EditionsList := nil;
 inherited;
end;//TsdsChangesBetweenEditions.ClearFields

{$If NOT Defined(NoVCM)}
procedure TsdsChangesBetweenEditions.ClearAreas;
 {* ������� ������ �� ������� ����� }
begin
 if (f_Changes <> nil) then f_Changes.Referred := nil;
 if (f_EditionsList <> nil) then f_EditionsList.Referred := nil;
 inherited;
end;//TsdsChangesBetweenEditions.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
