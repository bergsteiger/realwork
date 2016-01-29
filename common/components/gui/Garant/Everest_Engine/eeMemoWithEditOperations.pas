unit eeMemoWithEditOperations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeMemoWithEditOperations.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeeMemoWithEditOperations
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  eeMemo,
  evEditorWithOperations
  ;

type
 TeeMemoWithEditOperations = class(TeeMemo)
 protected
 // overridden protected methods
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
     {* ����� �������� ����������� �����������. }
 end;//TeeMemoWithEditOperations

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeMemoWithEditOperations

function TeeMemoWithEditOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
//#UC START# *48735C4A03C3_4AC5D3380185_var*
//#UC END# *48735C4A03C3_4AC5D3380185_var*
begin
//#UC START# *48735C4A03C3_4AC5D3380185_impl*
 Result := [potEdit];
//#UC END# *48735C4A03C3_4AC5D3380185_impl*
end;//TeeMemoWithEditOperations.DefineProvideOperations

initialization
{$If not defined(NoScripts)}
// ����������� TeeMemoWithEditOperations
 TtfwClassRef.Register(TeeMemoWithEditOperations);
{$IfEnd} //not NoScripts

end.