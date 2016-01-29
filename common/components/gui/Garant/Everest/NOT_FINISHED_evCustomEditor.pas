unit NOT_FINISHED_evCustomEditor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evCustomEditor.pas"
// �����: 25.11.2004 10:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevCustomEditor
//
// ������� ����� ���� ��������� � ����� "��������" �������. ������������� ��� ���������
// ������������ (������������).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdTypes,
  evTypes,
  evCustomEditorModelPart
  ;

type
 TevCustomEditor = class(TevCustomEditorModelPart)
  {* ������� ����� ���� ��������� � ����� "��������" �������. ������������� ��� ��������� ������������ (������������). }
 protected
 // protected methods
   function InTable: Boolean; virtual;
   function DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean; virtual;
   function AllowAutoSelectByMouse: Boolean; virtual;
 public
 // public methods
   function InsertPageBreak(NeedNewSection: Boolean = False;
     aPageOrientation: TevPageOrientation = ev_poPortrait): Boolean; virtual;
   procedure DecIndent; virtual;
     {* ��������� ������ DecIndent }
   procedure IncIndent; virtual;
     {* ��������� ������ IncIndent }
 end;//TevCustomEditor

implementation

uses
  evdInterfaces
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TevCustomEditorWordsPack
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomEditor

function TevCustomEditor.InTable: Boolean;
//#UC START# *54C0FF7C0012_4829D89703D2_var*
//#UC END# *54C0FF7C0012_4829D89703D2_var*
begin
//#UC START# *54C0FF7C0012_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FF7C0012_4829D89703D2_impl*
end;//TevCustomEditor.InTable

function TevCustomEditor.InsertPageBreak(NeedNewSection: Boolean = False;
  aPageOrientation: TevPageOrientation = ev_poPortrait): Boolean;
//#UC START# *54C10AFF0075_4829D89703D2_var*
//#UC END# *54C10AFF0075_4829D89703D2_var*
begin
//#UC START# *54C10AFF0075_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C10AFF0075_4829D89703D2_impl*
end;//TevCustomEditor.InsertPageBreak

procedure TevCustomEditor.DecIndent;
//#UC START# *54C10BEA0345_4829D89703D2_var*
//#UC END# *54C10BEA0345_4829D89703D2_var*
begin
//#UC START# *54C10BEA0345_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C10BEA0345_4829D89703D2_impl*
end;//TevCustomEditor.DecIndent

procedure TevCustomEditor.IncIndent;
//#UC START# *54C10BFE0098_4829D89703D2_var*
//#UC END# *54C10BFE0098_4829D89703D2_var*
begin
//#UC START# *54C10BFE0098_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C10BFE0098_4829D89703D2_impl*
end;//TevCustomEditor.IncIndent

function TevCustomEditor.DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean;
//#UC START# *55CDBD7600D4_4829D89703D2_var*
//#UC END# *55CDBD7600D4_4829D89703D2_var*
begin
//#UC START# *55CDBD7600D4_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CDBD7600D4_4829D89703D2_impl*
end;//TevCustomEditor.DoSearchHyperLink

function TevCustomEditor.AllowAutoSelectByMouse: Boolean;
//#UC START# *4C346719001A_4829D89703D2_var*
//#UC END# *4C346719001A_4829D89703D2_var*
begin
//#UC START# *4C346719001A_4829D89703D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C346719001A_4829D89703D2_impl*
end;//TevCustomEditor.AllowAutoSelectByMouse

initialization
{$If not defined(NoScripts)}
// ����������� TevCustomEditor
 TtfwClassRef.Register(TevCustomEditor);
{$IfEnd} //not NoScripts

end.