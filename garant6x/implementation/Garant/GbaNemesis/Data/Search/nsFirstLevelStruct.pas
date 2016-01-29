unit nsFirstLevelStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Search/nsFirstLevelStruct.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Search::TnsFirstLevelStruct
//
// �������, ��� ���?
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces,
  l3TreeInterfaces,
  nsAttributeOneLevelTreeStruct
  ;

type
 TnsFirstLevelStruct = class(TnsAttributeOneLevelTreeStruct)
  {* �������, ��� ���? }
 public
 // public methods
   class function Make(const aTag: Il3CString;
    aShowRoot: Boolean): Il3SimpleTree;
     {* ������ ��������� ������ }
 end;//TnsFirstLevelStruct

implementation

uses
  nsAttributeTreeCacheNew,
  DynamicTreeUnit
  ;

// start class TnsFirstLevelStruct

class function TnsFirstLevelStruct.Make(const aTag: Il3CString;
  aShowRoot: Boolean): Il3SimpleTree;
//#UC START# *4909DCCD018E_4909DC950238_var*
var
 l_Node: INodeBase;
//#UC END# *4909DCCD018E_4909DC950238_var*
begin
//#UC START# *4909DCCD018E_4909DC950238_impl*
 Result := nil;
 l_Node := TnsAttributeTreeCacheNew.Instance.AttributeRootClosed[aTag];
 try
  if (l_Node <> nil) then
   Result := inherited Make(l_Node, aTag, aShowRoot);
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4909DCCD018E_4909DC950238_impl*
end;//TnsFirstLevelStruct.Make

end.