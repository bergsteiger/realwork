unit nscSimpleEditorForDialogsContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis$Tails"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscSimpleEditorForDialogsContainer.pas"
// �����: 28.02.2011 17:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Nemesis$Tails::Editors::TnscSimpleEditorForDialogsContainer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

uses
  evCustomMemoContainer
  ;

type
 TnscSimpleEditorForDialogsContainer = class(TevCustomMemoContainer)
 protected
 // overridden protected methods
   function UseWikiMarkup: Boolean; override;
 end;//TnscSimpleEditorForDialogsContainer

implementation

// start class TnscSimpleEditorForDialogsContainer

function TnscSimpleEditorForDialogsContainer.UseWikiMarkup: Boolean;
//#UC START# *4D6BAFE8013D_4D6BAF99010E_var*
//#UC END# *4D6BAFE8013D_4D6BAF99010E_var*
begin
//#UC START# *4D6BAFE8013D_4D6BAF99010E_impl*
 Result := true;
//#UC END# *4D6BAFE8013D_4D6BAF99010E_impl*
end;//TnscSimpleEditorForDialogsContainer.UseWikiMarkup

end.