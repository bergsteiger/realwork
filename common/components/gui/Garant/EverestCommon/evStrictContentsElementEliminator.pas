unit evStrictContentsElementEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/EverestCommon/evStrictContentsElementEliminator.pas"
// �����: 29.09.2010 13:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Generators::TevStrictContentsElementEliminator
//
// ������, ��������� "�������� ����������" (k2_idContentsElement). �� �� �����, � ������� ������
// �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  k2TagFilter
  ;

type
 TevStrictContentsElementEliminator = class(Tk2TagFilter)
  {* ������, ��������� "�������� ����������" (k2_idContentsElement). �� �� �����, � ������� ������ ����������� }
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevStrictContentsElementEliminator

implementation

uses
  ContentsElement_Const
  ;

// start class TevStrictContentsElementEliminator

function TevStrictContentsElementEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4CA2FFC10275_var*
//#UC END# *4CA3006302BC_4CA2FFC10275_var*
begin
//#UC START# *4CA3006302BC_4CA2FFC10275_impl*
 Result := (CurrentType.ID <> k2_idContentsElement);
//#UC END# *4CA3006302BC_4CA2FFC10275_impl*
end;//TevStrictContentsElementEliminator.NeedTranslateChildToNext

end.