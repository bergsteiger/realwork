unit vcmFormSetFormsCollectionItemPrim;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionItemPrim.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmFormSetFormsCollectionItemPrim" MUID: (4FFC337003AF)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , l3Interfaces
 , vcmUserControls
;

type
 TvcmNeedMakeFormEvent = function(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean of object;
  {* ������ ����������� ��� �������� ����� }

 TvcmOnFormWeight = function(out aWeight: Integer): Boolean of object;
  {* ���������� ��� ��� ����� }

 TvcmFormCountEvent = procedure(const aDataSource: IvcmFormSetDataSource;
  out aCount: Integer) of object;
  {* ���������� ���� ������� ���������� ������� }

 TvcmFormSetFormsCollectionItemPrim = class(Tl3ProtoObject)
  private
   f_FormDescriptor: PvcmFormDescriptor;
   f_Name: AnsiString;
   f_Caption: Il3CString;
   f_OnFormCount: TvcmFormCountEvent;
   f_OnNeedMakeForm: TvcmNeedMakeFormEvent;
    {* ������ ����������� ��� �������� ����� }
   f_OnFormWeight: TvcmOnFormWeight;
    {* ������� ����������� ���� ��� ����� }
   f_UserType: TvcmUserType;
   f_ActivateIfUpdate: TvcmActivateIfUpdate;
    {* ���������� ����� �� ������� �������� �������� � ������ � ������
           ��������� ��������� ������ }
   f_ZoneType: TvcmZoneType;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   property FormDescriptor: PvcmFormDescriptor
    read f_FormDescriptor
    write f_FormDescriptor;
   property Name: AnsiString
    read f_Name
    write f_Name;
   property Caption: Il3CString
    read f_Caption
    write f_Caption;
   property OnFormCount: TvcmFormCountEvent
    read f_OnFormCount
    write f_OnFormCount;
   property OnNeedMakeForm: TvcmNeedMakeFormEvent
    read f_OnNeedMakeForm
    write f_OnNeedMakeForm;
    {* ������ ����������� ��� �������� ����� }
   property OnFormWeight: TvcmOnFormWeight
    read f_OnFormWeight
    write f_OnFormWeight;
    {* ������� ����������� ���� ��� ����� }
   property UserType: TvcmUserType
    read f_UserType
    write f_UserType;
   property ActivateIfUpdate: TvcmActivateIfUpdate
    read f_ActivateIfUpdate
    write f_ActivateIfUpdate;
    {* ���������� ����� �� ������� �������� �������� � ������ � ������
           ��������� ��������� ������ }
   property ZoneType: TvcmZoneType
    read f_ZoneType
    write f_ZoneType;
 end;//TvcmFormSetFormsCollectionItemPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TvcmFormSetFormsCollectionItemPrim.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4FFC337003AF_var*
//#UC END# *479731C50290_4FFC337003AF_var*
begin
//#UC START# *479731C50290_4FFC337003AF_impl*
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_4FFC337003AF_impl*
end;//TvcmFormSetFormsCollectionItemPrim.Cleanup

procedure TvcmFormSetFormsCollectionItemPrim.InitFields;
//#UC START# *47A042E100E2_4FFC337003AF_var*
//#UC END# *47A042E100E2_4FFC337003AF_var*
begin
//#UC START# *47A042E100E2_4FFC337003AF_impl*
 inherited;
 f_UserType := vcm_utAny;
 f_ActivateIfUpdate := wafNone;
//#UC END# *47A042E100E2_4FFC337003AF_impl*
end;//TvcmFormSetFormsCollectionItemPrim.InitFields

procedure TvcmFormSetFormsCollectionItemPrim.ClearFields;
begin
 Name := '';
 Caption := nil;
 inherited;
end;//TvcmFormSetFormsCollectionItemPrim.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
