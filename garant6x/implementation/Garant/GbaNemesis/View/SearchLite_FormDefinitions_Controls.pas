unit SearchLite_FormDefinitions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/SearchLite_FormDefinitions_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ������� ����������� ���������� �������::SearchLite::View::FormDefinitions
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwString
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a}
  ;

const
   { TreeAttributeSelectIDs }
  fm_efTreeAttributeSelect : TvcmFormDescriptor = (rFormID : (rName : 'efTreeAttributeSelect'; rID : 0); rFactory : nil);
   { ������������� ����� TefTreeAttributeSelect }

type
 TreeAttributeSelectFormDef = interface(IUnknown)
   ['{0933678C-206B-4B91-9452-24D754AB76AB}']
 end;//TreeAttributeSelectFormDef

const
   { SelectedAttributesIDs }
  fm_enSelectedAttributes : TvcmFormDescriptor = (rFormID : (rName : 'enSelectedAttributes'; rID : 0); rFactory : nil);
   { ������������� ����� TenSelectedAttributes }

type
 SelectedAttributesFormDef = interface(IUnknown)
   ['{E67C391C-CA9A-40EF-A203-0AC4A633D327}']
 end;//SelectedAttributesFormDef

const
   { AttributeSelectIDs }
  fm_cfAttributeSelect : TvcmFormDescriptor = (rFormID : (rName : 'cfAttributeSelect'; rID : 0); rFactory : nil);
   { ������������� ����� TcfAttributeSelect }

type
 AttributeSelectFormDef = interface(IUnknown)
   ['{8D3AADC2-E9A4-4383-B8D6-1B1D81711E91}']
 end;//AttributeSelectFormDef

implementation

{$If not defined(NoScripts)}

type
 Tkw_Form_TreeAttributeSelect_ID = {final scriptword} class(TtfwString)
  {* ����� ������� ��� �������������� ����� TreeAttributeSelect
----
*������ �������������*:
[code]
'aControl' �����::TreeAttributeSelect TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TreeAttributeSelect_ID
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_Form_TreeAttributeSelect_ID

class function Tkw_Form_TreeAttributeSelect_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect_ID.GetWordNameForRegister

function Tkw_Form_TreeAttributeSelect_ID.GetString: AnsiString;
 {-}
begin
 Result := 'efTreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect_ID.GetString

{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}

type
 Tkw_Form_SelectedAttributes_ID = {final scriptword} class(TtfwString)
  {* ����� ������� ��� �������������� ����� SelectedAttributes
----
*������ �������������*:
[code]
'aControl' �����::SelectedAttributes TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SelectedAttributes_ID
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_Form_SelectedAttributes_ID

class function Tkw_Form_SelectedAttributes_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::SelectedAttributes';
end;//Tkw_Form_SelectedAttributes_ID.GetWordNameForRegister

function Tkw_Form_SelectedAttributes_ID.GetString: AnsiString;
 {-}
begin
 Result := 'enSelectedAttributes';
end;//Tkw_Form_SelectedAttributes_ID.GetString

{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}

type
 Tkw_Form_AttributeSelect_ID = {final scriptword} class(TtfwString)
  {* ����� ������� ��� �������������� ����� AttributeSelect
----
*������ �������������*:
[code]
'aControl' �����::AttributeSelect TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AttributeSelect_ID
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_Form_AttributeSelect_ID

class function Tkw_Form_AttributeSelect_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::AttributeSelect';
end;//Tkw_Form_AttributeSelect_ID.GetWordNameForRegister

function Tkw_Form_AttributeSelect_ID.GetString: AnsiString;
 {-}
begin
 Result := 'cfAttributeSelect';
end;//Tkw_Form_AttributeSelect_ID.GetString

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_TreeAttributeSelect_ID
 Tkw_Form_TreeAttributeSelect_ID.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Form_SelectedAttributes_ID
 Tkw_Form_SelectedAttributes_ID.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Form_AttributeSelect_ID
 Tkw_Form_AttributeSelect_ID.RegisterInEngine;
{$IfEnd} //not NoScripts

end.