{$IfNDef ListAnalizeUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "ListAnalizeUserTypes" MUID: (4FFBDE68006D)
// ��� ����: "_ListAnalizeUserTypes_"

{$Define ListAnalizeUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListAnalizeUserTypes_ = {abstract} class(_ListAnalizeUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_ListAnalizeUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListAnalizeUserTypes_ = _ListAnalizeUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListAnalizeUserTypes_imp}

{$IfNDef ListAnalizeUserTypes_imp_impl}

{$Define ListAnalizeUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ AnalizeLocalConstants }
 str_AnalizeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AnalizeCaption'; rValue : '������ ������');
  {* ��������� ����������������� ���� "������ ������" }

{$If NOT Defined(NoVCM)}
procedure _ListAnalizeUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(AnalizeName,
  str_AnalizeCaption,
  str_AnalizeCaption,
  False,
  202,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(AnalizeName
end;//_ListAnalizeUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else ListAnalizeUserTypes_imp_impl}

 str_AnalizeCaption.Init;
 {* ������������� str_AnalizeCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ListAnalizeUserTypes_imp_impl}

{$EndIf ListAnalizeUserTypes_imp}

