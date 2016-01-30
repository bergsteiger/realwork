unit smChangeableTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smChangeableTree.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , smTree
 , MainMenuUnit
 , l3TreeInterfaces
 , l3Tree_TLB
;

type
 TsmChangeableTree = class(TsmTree)
  private
   f_SectionType: TSectionType;
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
  public
   constructor Create(aSectionType: TSectionType); reintroduce;
   class function Make(aSectionType: TSectionType): Il3SimpleTree; reintroduce;
 end;//TsmChangeableTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

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
end;//TsmChangeableTree.Make

function TsmChangeableTree.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
//#UC START# *4909EF6E0361_4E73239003D0_var*
//#UC END# *4909EF6E0361_4E73239003D0_var*
begin
//#UC START# *4909EF6E0361_4E73239003D0_impl*
 Result := inherited MakeRoot;
 AddItems2011(Result, f_SectionType);
//#UC END# *4909EF6E0361_4E73239003D0_impl*
end;//TsmChangeableTree.MakeRoot
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
