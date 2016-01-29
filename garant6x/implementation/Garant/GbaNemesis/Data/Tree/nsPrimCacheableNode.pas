unit nsPrimCacheableNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsPrimCacheableNode.pas"
// �����: 21.10.2009 14:41
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::OldTree::TnsPrimCacheableNode
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  nsPrimAdapterNode,
  l3Interfaces
  ;

type
 TnsPrimCacheableNode = {abstract} class(TnsPrimAdapterNode)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function GetAsPCharLen: Tl3WString; override;
 protected
 // protected fields
   f_AdapterCaption : IString;
 end;//TnsPrimCacheableNode

implementation

uses
  l3String,
  nsTypes
  ;

// start class TnsPrimCacheableNode

procedure TnsPrimCacheableNode.Cleanup;
//#UC START# *479731C50290_4ADDF42201A2_var*
//#UC END# *479731C50290_4ADDF42201A2_var*
begin
//#UC START# *479731C50290_4ADDF42201A2_impl*
 f_AdapterCaption := nil;
 inherited;
//#UC END# *479731C50290_4ADDF42201A2_impl*
end;//TnsPrimCacheableNode.Cleanup

function TnsPrimCacheableNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4ADDF42201A2_var*
//#UC END# *47A869BB02DE_4ADDF42201A2_var*
begin
//#UC START# *47A869BB02DE_4ADDF42201A2_impl*
 if (f_AdapterCaption = nil) then
  if (AdapterNode <> nil) then
   AdapterNode.GetCaption(f_AdapterCaption);
 Result := nsWStr(f_AdapterCaption);
//#UC END# *47A869BB02DE_4ADDF42201A2_impl*
end;//TnsPrimCacheableNode.GetAsPCharLen

end.