unit NOT_FINISHED_nsContentsNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "f1DocumentTagsImplementation"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/NOT_FINISHED_nsContentsNode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsContentsNode
//
// ���� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  k2Interfaces,
  l3TreeInterfaces,
  nsINodeWrapBase
  ;

type
 TnsContentsNode = class(TnsINodeWrapBase, Il3HandleNode)
  {* ���� ����������. }
 private
 // private fields
   f_Document : Ik2Tag;
    {* ��������.}
 protected
 // realized methods
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 end;//TnsContentsNode

implementation

// start class TnsContentsNode

function TnsContentsNode.Get_Handle: Integer;
//#UC START# *46827CAF03CD_46827E69026Aget_var*
//#UC END# *46827CAF03CD_46827E69026Aget_var*
begin
//#UC START# *46827CAF03CD_46827E69026Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46827CAF03CD_46827E69026Aget_impl*
end;//TnsContentsNode.Get_Handle

procedure TnsContentsNode.Set_Handle(aValue: Integer);
//#UC START# *46827CAF03CD_46827E69026Aset_var*
//#UC END# *46827CAF03CD_46827E69026Aset_var*
begin
//#UC START# *46827CAF03CD_46827E69026Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46827CAF03CD_46827E69026Aset_impl*
end;//TnsContentsNode.Set_Handle

procedure TnsContentsNode.ClearFields;
 {-}
begin
 f_Document := nil;
 inherited;
end;//TnsContentsNode.ClearFields

end.