{$IfNDef AttributesUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "AttributesUserTypes" MUID: (4D776CFE031E)
// ��� ����: "_AttributesUserTypes_"

{$Define AttributesUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _AttributesUserTypes_ = {abstract} class(_AttributesUserTypes_Parent_)
  protected
   procedure fDocAttributeQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� fDocAttribute.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_AttributesUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_AttributesUserTypes_ = _AttributesUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else AttributesUserTypes_imp}

{$IfNDef AttributesUserTypes_imp_impl}

{$Define AttributesUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ fDocAttributeLocalConstants }
 str_fDocAttributeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fDocAttributeCaption'; rValue : '���������� � ���������');
  {* ��������� ����������������� ���� "���������� � ���������" }
 {* ������������ ������ fAttributeSynchroViewLocalConstants }
 str_fAttributeSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fAttributeSynchroViewCaption'; rValue : '���������� � ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "���������� � ��������� (���������� ��������)" }

{$If NOT Defined(NoVCM)}
procedure _AttributesUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(fDocAttributeName,
  str_fDocAttributeCaption,
  str_fDocAttributeCaption,
  False,
  19,
  20,
  '',
  nil,
  nil,
  fDocAttributeQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(fDocAttributeName
 with AddUsertype(fAttributeSynchroViewName,
  str_fAttributeSynchroViewCaption,
  str_fAttributeSynchroViewCaption,
  False,
  19,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(fAttributeSynchroViewName
end;//_AttributesUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else AttributesUserTypes_imp_impl}

 str_fDocAttributeCaption.Init;
 {* ������������� str_fDocAttributeCaption }
 str_fAttributeSynchroViewCaption.Init;
 {* ������������� str_fAttributeSynchroViewCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf AttributesUserTypes_imp_impl}

{$EndIf AttributesUserTypes_imp}

