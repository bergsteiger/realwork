unit eeEditorWithoutOperations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeEditorWithoutOperations.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeeEditorWithoutOperations
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  eeEditor,
  evEditorWithOperations
  ;

type
 TeeEditorWithoutOperations = class(TeeEditor)
 protected
 // overridden protected methods
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
     {* ����� �������� ����������� �����������. }
 end;//TeeEditorWithoutOperations

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeEditorWithoutOperations

function TeeEditorWithoutOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
//#UC START# *48735C4A03C3_4CFFD8F603A0_var*
//#UC END# *48735C4A03C3_4CFFD8F603A0_var*
begin
//#UC START# *48735C4A03C3_4CFFD8F603A0_impl*
 Result := [];
//#UC END# *48735C4A03C3_4CFFD8F603A0_impl*
end;//TeeEditorWithoutOperations.DefineProvideOperations

initialization
{$If not defined(NoScripts)}
// ����������� TeeEditorWithoutOperations
 TtfwClassRef.Register(TeeEditorWithoutOperations);
{$IfEnd} //not NoScripts

end.