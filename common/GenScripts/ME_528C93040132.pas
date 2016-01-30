unit vcmBaseTypes;

// ������: "w:\common\components\gui\Garant\VCM\vcmBaseTypes.pas"
// ���������: "InternalInterfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Types
;

const
 vcm_utAny = 31;
  {* ����� ���������������� ��� }

type
 TvcmFormID = object
  public
   rName: AnsiString;
   rID: Integer;
  public
   function EQ(const anOther: TvcmFormID): Boolean;
 end;//TvcmFormID

 TvcmZoneType = (
  vcm_ztAny
  , vcm_ztMain
  , vcm_ztNavigator
  , vcm_ztParent
  , vcm_ztChild
  , vcm_ztReminder
  , vcm_ztFloating
  , vcm_ztModal
  , vcm_ztManualModal
  , vcm_ztForToolbarsInfo
  , vcm_ztSimpleFloat
  , vcm_ztMainObjectForm
  , vcm_ztForFocus
 );//TvcmZoneType

 TvcmNeedMakeDS = (
  {* ������������ ��� ������������ ������������� �������� ��� }
  vcm_nmForce
   {* ��������� �� ������ �� �� ��� }
  , vcm_nmNo
   {* ������ ���������, �������� ������, ��� ����� ���� ������� ������������� � ��� ���������� ������ �� ��������� �� ����� }
  , vcm_nmYes
   {* ��������� ��������� }
 );//TvcmNeedMakeDS

 TvcmIteratorAction = Tl3IteratorAction;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

function TvcmFormID.EQ(const anOther: TvcmFormID): Boolean;
//#UC START# *528C93AC00EB_528C9354017B_var*
//#UC END# *528C93AC00EB_528C9354017B_var*
begin
//#UC START# *528C93AC00EB_528C9354017B_impl*
 Result := (Self.rName = anOther.rName);
//#UC END# *528C93AC00EB_528C9354017B_impl*
end;//TvcmFormID.EQ
{$IfEnd} // NOT Defined(NoVCM)

end.
