unit evNestedCommentsEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evNestedCommentsEliminator.pas"
// �����: 07.07.2011 19:13
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevNestedCommentsEliminator
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
 TevNestedCommentsEliminator = class(Tk2TagFilter)
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevNestedCommentsEliminator

implementation

uses
  CommentPara_Const
  ;

// start class TevNestedCommentsEliminator

function TevNestedCommentsEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4E15CCEC0256_var*
//#UC END# *4CA3006302BC_4E15CCEC0256_var*
begin
//#UC START# *4CA3006302BC_4E15CCEC0256_impl*
 if CurrentType.IsKindOf(k2_typCommentPara) then
  Result:= (TopType[1] = nil)
 else
  Result:= True;
//#UC END# *4CA3006302BC_4E15CCEC0256_impl*
end;//TevNestedCommentsEliminator.NeedTranslateChildToNext

end.