unit evDocumentEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evDocumentEliminator.pas"
// �����: 21.07.2011 18:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevDocumentEliminator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2TagFilter
  ;

type
 TevDocumentEliminator = class(Tk2TagFilter)
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevDocumentEliminator

implementation

uses
  Document_Const
  ;

// start class TevDocumentEliminator

function TevDocumentEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4E2836190160_var*
//#UC END# *4CA3006302BC_4E2836190160_var*
begin
//#UC START# *4CA3006302BC_4E2836190160_impl*
 Result := not CurrentType.IsKindOf(k2_typDocument);
//#UC END# *4CA3006302BC_4E2836190160_impl*
end;//TevDocumentEliminator.NeedTranslateChildToNext

end.