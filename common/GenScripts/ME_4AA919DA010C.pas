unit moCommonPost;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCommonPost.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "CommonPost" MUID: (4AA919DA010C)
// ��� ����: "Tmo_CommonPost"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , CommonPost_Module
;

type
 Tmo_CommonPost = {final} class(TCommonPostModule)
  {* ���� }
 end;//Tmo_CommonPost
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
