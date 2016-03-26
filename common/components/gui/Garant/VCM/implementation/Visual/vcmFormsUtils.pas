unit vcmFormsUtils;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormsUtils.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmFormsUtils" MUID: (511389AC0205)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , vcmEntityForm
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvcmEntityForm;
 _l3ObjectPtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmSlayedEntityFormsList = class(_l3ObjectPtrList_)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TvcmSlayedEntityFormsList;
    {* ����� ��������� ���������� ���������� TvcmSlayedEntityFormsList }
 end;//TvcmSlayedEntityFormsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var g_TvcmSlayedEntityFormsList: TvcmSlayedEntityFormsList = nil;
 {* ��������� ���������� TvcmSlayedEntityFormsList }

procedure TvcmSlayedEntityFormsListFree;
 {* ����� ������������ ���������� ���������� TvcmSlayedEntityFormsList }
begin
 l3Free(g_TvcmSlayedEntityFormsList);
end;//TvcmSlayedEntityFormsListFree

type _Instance_R_ = TvcmSlayedEntityFormsList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

class function TvcmSlayedEntityFormsList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmSlayedEntityFormsList <> nil;
end;//TvcmSlayedEntityFormsList.Exists

class function TvcmSlayedEntityFormsList.Instance: TvcmSlayedEntityFormsList;
 {* ����� ��������� ���������� ���������� TvcmSlayedEntityFormsList }
begin
 if (g_TvcmSlayedEntityFormsList = nil) then
 begin
  l3System.AddExitProc(TvcmSlayedEntityFormsListFree);
  g_TvcmSlayedEntityFormsList := Create;
 end;
 Result := g_TvcmSlayedEntityFormsList;
end;//TvcmSlayedEntityFormsList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
