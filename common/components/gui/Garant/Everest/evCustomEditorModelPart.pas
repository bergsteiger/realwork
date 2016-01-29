unit evCustomEditorModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evCustomEditorModelPart.pas"
// �����: 26.02.2010 10:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevCustomEditorModelPart
//
// ����� TevCustomEditor ����������� �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evMultiSelectEditorWindow
  ;

type
 TevAllowParaType = (
  {* ����������� ���� ���������� }
   ev_aptTable
 , ev_aptSBS
 , ev_aptPicture
 , ev_aptFormula
 , ev_aptPageBreak
 );//TevAllowParaType

 TevAllowParaTypes = set of TevAllowParaType;
  {* ��������� ����� ����������� ���������� }

 TevCustomEditorModelPart = class(TevMultiSelectEditorWindow)
  {* ����� TevCustomEditor ����������� �� ������ }
 protected
 // property methods
   function pm_GetAllowParaType: TevAllowParaTypes; virtual;
 protected
 // protected properties
   property AllowParaType: TevAllowParaTypes
     read pm_GetAllowParaType;
 end;//TevCustomEditorModelPart

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomEditorModelPart

function TevCustomEditorModelPart.pm_GetAllowParaType: TevAllowParaTypes;
//#UC START# *4B877E7B0330_4B877C5101C1get_var*
//#UC END# *4B877E7B0330_4B877C5101C1get_var*
begin
//#UC START# *4B877E7B0330_4B877C5101C1get_impl*
 Result := [Low(TevAllowParaType) .. High(TevAllowParaType)];
//#UC END# *4B877E7B0330_4B877C5101C1get_impl*
end;//TevCustomEditorModelPart.pm_GetAllowParaType

initialization
{$If not defined(NoScripts)}
// ����������� TevCustomEditorModelPart
 TtfwClassRef.Register(TevCustomEditorModelPart);
{$IfEnd} //not NoScripts

end.