unit dsMainList;
 {* ������ ���������� ���������� "������". ������� � ������� �����, � �������� � ����� �������� ���������� ������ ������ ���� - ������ ���������� ���������� "C�����". ��� ���� ���� ������ dsMainList � ���������� NotifyAboutChangeCurrent }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\List\dsMainList.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "TdsMainList" MUID: (4926C0970020)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocumentList
 , l3TreeInterfaces
;

type
 TdsMainList = class(TdsDocumentList)
  {* ������ ���������� ���������� "������". ������� � ������� �����, � �������� � ����� �������� ���������� ������ ������ ���� - ������ ���������� ���������� "C�����". ��� ���� ���� ������ dsMainList � ���������� NotifyAboutChangeCurrent }
  protected
   function NotifyAboutChangeCurrent: Boolean; override;
    {* ���������� ������ ������ ���������� � ����� ��������. }
   function DoIsMain: Boolean; override;
    {* - ���������� ������ � �������� ���� ����������. }
   function DoGet_IsShortList: Boolean; override;
   procedure DoSetupNewSimpleTree(const aTree: Il3SimpleTree); override;
   function DoGet_IsSnippet: Boolean; override;
   function DoCanAnalize: Boolean; override;
 end;//TdsMainList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4926C0970020impl_uses*
 //#UC END# *4926C0970020impl_uses*
;

function TdsMainList.NotifyAboutChangeCurrent: Boolean;
 {* ���������� ������ ������ ���������� � ����� ��������. }
//#UC START# *47F0D913030D_4926C0970020_var*
//#UC END# *47F0D913030D_4926C0970020_var*
begin
//#UC START# *47F0D913030D_4926C0970020_impl*
 Result := true;
//#UC END# *47F0D913030D_4926C0970020_impl*
end;//TdsMainList.NotifyAboutChangeCurrent

function TdsMainList.DoIsMain: Boolean;
 {* - ���������� ������ � �������� ���� ����������. }
//#UC START# *47FB00640212_4926C0970020_var*
//#UC END# *47FB00640212_4926C0970020_var*
begin
//#UC START# *47FB00640212_4926C0970020_impl*
 Result := true;
//#UC END# *47FB00640212_4926C0970020_impl*
end;//TdsMainList.DoIsMain

function TdsMainList.DoGet_IsShortList: Boolean;
//#UC START# *4A2D0838019C_4926C0970020_var*
//#UC END# *4A2D0838019C_4926C0970020_var*
begin
//#UC START# *4A2D0838019C_4926C0970020_impl*
 Result := Assigned(ImpList) and ImpList.GetIsShort;
//#UC END# *4A2D0838019C_4926C0970020_impl*
end;//TdsMainList.DoGet_IsShortList

procedure TdsMainList.DoSetupNewSimpleTree(const aTree: Il3SimpleTree);
//#UC START# *4A4074FB0192_4926C0970020_var*
//#UC END# *4A4074FB0192_4926C0970020_var*
begin
//#UC START# *4A4074FB0192_4926C0970020_impl*
 if DoGet_IsSnippet then
  aTree.ExpandSubDir(nil, True, 0);
//#UC END# *4A4074FB0192_4926C0970020_impl*
end;//TdsMainList.DoSetupNewSimpleTree

function TdsMainList.DoGet_IsSnippet: Boolean;
//#UC START# *4A796F46039D_4926C0970020_var*
//#UC END# *4A796F46039D_4926C0970020_var*
begin
//#UC START# *4A796F46039D_4926C0970020_impl*
 Result := Assigned(ImpList) and ImpList.GetIsSnippet;
//#UC END# *4A796F46039D_4926C0970020_impl*
end;//TdsMainList.DoGet_IsSnippet

function TdsMainList.DoCanAnalize: Boolean;
//#UC START# *4AA0F2E70398_4926C0970020_var*
//#UC END# *4AA0F2E70398_4926C0970020_var*
begin
//#UC START# *4AA0F2E70398_4926C0970020_impl*
 Result := true;
//#UC END# *4AA0F2E70398_4926C0970020_impl*
end;//TdsMainList.DoCanAnalize
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
