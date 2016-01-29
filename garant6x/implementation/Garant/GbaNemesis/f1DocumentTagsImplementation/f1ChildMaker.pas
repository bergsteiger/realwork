unit f1ChildMaker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "f1DocumentTagsImplementation"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1ChildMaker.pas"
// �����: 23.11.2010 15:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::Tf1ChildMaker
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsParaListNode,
  l3CProtoObject,
  F1TagDataProviderInterface,
  l3Variant
  ;

type
 Tf1ChildMaker = class(Tl3CProtoObject, If1ChildMaker)
 private
 // private fields
   f_Tag : TnsParaListNode;
 protected
 // realized methods
   function MakeChildTag(const aNode: If1TagDataProvider;
    aState: TnsNodeStates): Il3TagRef;
   function Get_Tag: Tl3Tag;
 public
 // public methods
   constructor Create(aTag: TnsParaListNode); reintroduce;
   class function Make(aTag: TnsParaListNode): If1ChildMaker; reintroduce;
     {* ��������� ������� Tf1ChildMaker.Make }
 end;//Tf1ChildMaker

implementation

uses
  SysUtils,
  DynamicTreeUnit
  ;

// start class Tf1ChildMaker

constructor Tf1ChildMaker.Create(aTag: TnsParaListNode);
//#UC START# *4CEBB84401C9_4CEBB7C80129_var*
//#UC END# *4CEBB84401C9_4CEBB7C80129_var*
begin
//#UC START# *4CEBB84401C9_4CEBB7C80129_impl*
 inherited Create;
 f_Tag := aTag;
//#UC END# *4CEBB84401C9_4CEBB7C80129_impl*
end;//Tf1ChildMaker.Create

class function Tf1ChildMaker.Make(aTag: TnsParaListNode): If1ChildMaker;
var
 l_Inst : Tf1ChildMaker;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function Tf1ChildMaker.MakeChildTag(const aNode: If1TagDataProvider;
  aState: TnsNodeStates): Il3TagRef;
//#UC START# *4CEBB765029D_4CEBB7C80129_var*
//#UC END# *4CEBB765029D_4CEBB7C80129_var*
begin
//#UC START# *4CEBB765029D_4CEBB7C80129_impl*
 Result := f_Tag.MakeChildTag(-1, aNode, aState);
//#UC END# *4CEBB765029D_4CEBB7C80129_impl*
end;//Tf1ChildMaker.MakeChildTag

function Tf1ChildMaker.Get_Tag: Tl3Tag;
//#UC START# *4CEBCD9B00D2_4CEBB7C80129get_var*
//#UC END# *4CEBCD9B00D2_4CEBB7C80129get_var*
begin
//#UC START# *4CEBCD9B00D2_4CEBB7C80129get_impl*
 Result := f_Tag;
//#UC END# *4CEBCD9B00D2_4CEBB7C80129get_impl*
end;//Tf1ChildMaker.Get_Tag

end.