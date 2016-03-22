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

{$Else AttributesUserTypes_imp_impl}

 str_fDocAttributeCaption.Init;
 {* ������������� str_fDocAttributeCaption }
 str_fAttributeSynchroViewCaption.Init;
 {* ������������� str_fAttributeSynchroViewCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf AttributesUserTypes_imp_impl}

{$EndIf AttributesUserTypes_imp}

