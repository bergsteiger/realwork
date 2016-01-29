unit F1Like_FormDefinitions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/F1Like_FormDefinitions_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi F1 Like Application::F1Like::View::FormDefinitions
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

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
   { ChildIDs }
  fm_ChildForm : TvcmFormDescriptor = (rFormID : (rName : 'ChildForm'; rID : 0); rFactory : nil);
   { ������������� ����� TChildForm }

type
 ChildFormDef = interface(IUnknown)
   ['{CFF21CFB-D277-44C2-940B-C1A99F33511F}']
 end;//ChildFormDef

const
   { ParentIDs }
  fm_ParentForm : TvcmFormDescriptor = (rFormID : (rName : 'ParentForm'; rID : 0); rFactory : nil);
   { ������������� ����� TParentForm }

type
 ParentFormDef = interface(IUnknown)
   ['{DEC20464-3FB2-4ABC-921C-08A93E75DAD5}']
 end;//ParentFormDef

implementation

{$If not defined(NoScripts)}

type
 Tkw_Form_Child_ID = {final scriptword} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Child
----
*������ �������������*:
[code]
'aControl' �����::Child TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Child_ID
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_Form_Child_ID

class function Tkw_Form_Child_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Child';
end;//Tkw_Form_Child_ID.GetWordNameForRegister

function Tkw_Form_Child_ID.GetString: AnsiString;
 {-}
begin
 Result := 'ChildForm';
end;//Tkw_Form_Child_ID.GetString

{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}

type
 Tkw_Form_Parent_ID = {final scriptword} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Parent
----
*������ �������������*:
[code]
'aControl' �����::Parent TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Parent_ID
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_Form_Parent_ID

class function Tkw_Form_Parent_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Parent';
end;//Tkw_Form_Parent_ID.GetWordNameForRegister

function Tkw_Form_Parent_ID.GetString: AnsiString;
 {-}
begin
 Result := 'ParentForm';
end;//Tkw_Form_Parent_ID.GetString

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_Child_ID
 Tkw_Form_Child_ID.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Form_Parent_ID
 Tkw_Form_Parent_ID.RegisterInEngine;
{$IfEnd} //not NoScripts

end.