unit SearchLite_Services;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_Services.pas"
// ���������: "VCMContracts"
// ������� ������: "Services" MUID: (57A3150402BC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObject
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MLiteSearchService = interface
  {* �������� ������� TLiteSearchService }
  function OpenTreeSelection(const aTag: Il3CString;
   anAdditionalFilter: TnsFilterType;
   const aFormData: IdsTreeAttributeSelect): Integer;
  function MakeAttributeSelect(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
  function MakeSelectedAttributes(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean): IvcmEntityForm;
  function MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
 end;//MLiteSearchService
 *)

type
 ILiteSearchService = interface
  {* ��������� ������� TLiteSearchService }
  function OpenTreeSelection(const aTag: Il3CString;
   anAdditionalFilter: TnsFilterType;
   const aFormData: IdsTreeAttributeSelect): Integer;
  function MakeAttributeSelect(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
  function MakeSelectedAttributes(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean): IvcmEntityForm;
  function MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
   aZoneType: TvcmZoneType;
   aRecursive: Boolean;
   aUserType: TvcmUserType): IvcmEntityForm;
 end;//ILiteSearchService

 TLiteSearchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ILiteSearchService;
    {* ������� ���������� ������� ILiteSearchService }
  protected
   procedure pm_SetAlien(const aValue: ILiteSearchService);
   procedure ClearFields; override;
  public
   function OpenTreeSelection(const aTag: Il3CString;
    anAdditionalFilter: TnsFilterType;
    const aFormData: IdsTreeAttributeSelect): Integer;
   function MakeAttributeSelect(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   function MakeSelectedAttributes(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean): IvcmEntityForm;
   function MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   class function Instance: TLiteSearchService;
    {* ����� ��������� ���������� ���������� TLiteSearchService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ILiteSearchService
    write pm_SetAlien;
    {* ������� ���������� ������� ILiteSearchService }
 end;//TLiteSearchService

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_TLiteSearchService: TLiteSearchService = nil;
 {* ��������� ���������� TLiteSearchService }

procedure TLiteSearchServiceFree;
 {* ����� ������������ ���������� ���������� TLiteSearchService }
begin
 l3Free(g_TLiteSearchService);
end;//TLiteSearchServiceFree

procedure TLiteSearchService.pm_SetAlien(const aValue: ILiteSearchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TLiteSearchService.pm_SetAlien

function TLiteSearchService.OpenTreeSelection(const aTag: Il3CString;
 anAdditionalFilter: TnsFilterType;
 const aFormData: IdsTreeAttributeSelect): Integer;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenTreeSelection(aTag, anAdditionalFilter, aFormData)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TLiteSearchService.OpenTreeSelection

function TLiteSearchService.MakeAttributeSelect(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeAttributeSelect(aParams, aZoneType, aRecursive, aUserType)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TLiteSearchService.MakeAttributeSelect

function TLiteSearchService.MakeSelectedAttributes(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeSelectedAttributes(aParams, aZoneType, aRecursive)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TLiteSearchService.MakeSelectedAttributes

function TLiteSearchService.MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeTreeAttributeSelect(aParams, aZoneType, aRecursive, aUserType)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TLiteSearchService.MakeTreeAttributeSelect

class function TLiteSearchService.Instance: TLiteSearchService;
 {* ����� ��������� ���������� ���������� TLiteSearchService }
begin
 if (g_TLiteSearchService = nil) then
 begin
  l3System.AddExitProc(TLiteSearchServiceFree);
  g_TLiteSearchService := Create;
 end;
 Result := g_TLiteSearchService;
end;//TLiteSearchService.Instance

class function TLiteSearchService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TLiteSearchService <> nil;
end;//TLiteSearchService.Exists

procedure TLiteSearchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TLiteSearchService.ClearFields

initialization

end.
