unit smChangeableTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MainMenu"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/MainMenu/smChangeableTree.pas"
// �����: 16.09.2011 14:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������������ ��������::MainMenu::MainMenu::MainMenuTrees::TsmChangeableTree
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  smTree,
  MainMenuUnit,
  l3Interfaces,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TsmChangeableTree = class(TsmTree)
 private
 // private fields
   f_SectionType : TSectionType;
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* ������ ������ ������ }
 public
 // public methods
   constructor Create(aSectionType: TSectionType); reintroduce;
   class function Make(aSectionType: TSectionType): Il3SimpleTree; reintroduce;
     {* ��������� ������� TsmChangeableTree.Make }
 end;//TsmChangeableTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsmChangeableTree

constructor TsmChangeableTree.Create(aSectionType: TSectionType);
//#UC START# *4E73249703A9_4E73239003D0_var*
//#UC END# *4E73249703A9_4E73239003D0_var*
begin
//#UC START# *4E73249703A9_4E73239003D0_impl*
 inherited Create;
 f_SectionType := aSectionType;
//#UC END# *4E73249703A9_4E73239003D0_impl*
end;//TsmChangeableTree.Create

class function TsmChangeableTree.Make(aSectionType: TSectionType): Il3SimpleTree;
var
 l_Inst : TsmChangeableTree;
begin
 l_Inst := Create(aSectionType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TsmChangeableTree.MakeRoot: Il3RootNode;
//#UC START# *4909EF6E0361_4E73239003D0_var*
//#UC END# *4909EF6E0361_4E73239003D0_var*
begin
//#UC START# *4909EF6E0361_4E73239003D0_impl*
 Result := inherited MakeRoot;
 AddItems2011(Result, f_SectionType);
//#UC END# *4909EF6E0361_4E73239003D0_impl*
end;//TsmChangeableTree.MakeRoot

{$IfEnd} //not Admin AND not Monitorings

end.