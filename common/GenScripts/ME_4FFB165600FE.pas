{$IfNDef ListInfoUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "ListInfoUserTypes" MUID: (4FFB165600FE)
// ��� ����: "_ListInfoUserTypes_"

{$Define ListInfoUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListInfoUserTypes_ = {abstract} class(_ListInfoUserTypes_Parent_)
  protected
   procedure liListInfoQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� liListInfo.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_ListInfoUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListInfoUserTypes_ = _ListInfoUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListInfoUserTypes_imp}

{$IfNDef ListInfoUserTypes_imp_impl}

{$Define ListInfoUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ liListInfoLocalConstants }
 str_liListInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoCaption'; rValue : '������� � ������');
  {* ��������� ����������������� ���� "������� � ������" }
 str_liListInfoSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoSettingsCaption'; rValue : '������: ������� � ������');
  {* ��������� ����������������� ���� "������� � ������" ��� ��������� ������� ������������ }

{$If NOT Defined(NoVCM)}
procedure _ListInfoUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(liListInfoName,
  str_liListInfoCaption,
  str_liListInfoSettingsCaption,
  False,
  20,
  10,
  '',
  nil,
  nil,
  liListInfoQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(liListInfoName
end;//_ListInfoUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else ListInfoUserTypes_imp_impl}

 str_liListInfoCaption.Init;
 {* ������������� str_liListInfoCaption }
 str_liListInfoSettingsCaption.Init;
 {* ������������� str_liListInfoSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ListInfoUserTypes_imp_impl}

{$EndIf ListInfoUserTypes_imp}

