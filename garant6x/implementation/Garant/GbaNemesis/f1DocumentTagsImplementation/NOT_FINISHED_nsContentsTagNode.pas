unit NOT_FINISHED_nsContentsTagNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "f1DocumentTagsImplementation"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/NOT_FINISHED_nsContentsTagNode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsContentsTagNode
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
  nsContentsNode
  ;

type
 TnsContentsTagNode = class(TnsContentsNode)
 private
 // private fields
   f_Tag : Ik2Tag;
    {* ���, ������� ������������ ����.}
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 end;//TnsContentsTagNode

implementation

// start class TnsContentsTagNode

procedure TnsContentsTagNode.ClearFields;
 {-}
begin
 f_Tag := nil;
 inherited;
end;//TnsContentsTagNode.ClearFields

end.