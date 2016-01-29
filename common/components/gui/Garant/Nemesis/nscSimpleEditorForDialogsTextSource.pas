unit nscSimpleEditorForDialogsTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis$Tails"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscSimpleEditorForDialogsTextSource.pas"
// �����: 28.02.2011 17:20
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Nemesis$Tails::Editors::TnscSimpleEditorForDialogsTextSource
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

uses
  evCustomMemoTextSource,
  nevTools
  ;

type
 TnscSimpleEditorForDialogsTextSource = class(TevCustomMemoTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TnscSimpleEditorForDialogsTextSource

implementation

uses
  nscSimpleEditorForDialogsContainer
  ;

// start class TnscSimpleEditorForDialogsTextSource

function TnscSimpleEditorForDialogsTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4D6BAF110364_var*
//#UC END# *482D9A030221_4D6BAF110364_var*
begin
//#UC START# *482D9A030221_4D6BAF110364_impl*
 Result := TnscSimpleEditorForDialogsContainer.Make;
//#UC END# *482D9A030221_4D6BAF110364_impl*
end;//TnscSimpleEditorForDialogsTextSource.DoMakeDocumentContainer

end.