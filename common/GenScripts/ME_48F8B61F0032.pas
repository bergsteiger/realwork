unit nsContentsTreeStorable;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsContentsTreeStorable.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evTreeStorable
 , DocumentUnit
 , nevBase
 , nevTools
;

type
 TnsContentsTreeStorable = class(TevTreeStorable)
  private
   f_Document: IDocument;
  protected
   procedure DoIterate(const aNode: InevSimpleNode;
    aLevel: Integer;
    const G: InevTagGenerator);
   procedure DoIterateTree(const G: InevTagGenerator;
    aFlags: TevStoreFlags = evDefaultStoreFlags); override;
   procedure ClearFields; override;
  public
   constructor Create(const aDocument: IDocument;
    const aData: InevSimpleTree;
    const aSubRoot: InevSimpleNode); reintroduce;
   class function Make(const aDocument: IDocument;
    const aData: InevSimpleTree;
    const aSubRoot: InevSimpleNode): InevStorable; reintroduce;
 end;//TnsContentsTreeStorable
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , k2Tags
 , TextPara_Const
 , IOUnit
 , nsTypes
;

constructor TnsContentsTreeStorable.Create(const aDocument: IDocument;
 const aData: InevSimpleTree;
 const aSubRoot: InevSimpleNode);
//#UC START# *4C933899017C_48F8B61F0032_var*
//#UC END# *4C933899017C_48F8B61F0032_var*
begin
//#UC START# *4C933899017C_48F8B61F0032_impl*
 inherited Create(TevTreeStorableData_C(aData, k2_tiLeftIndent, 0), nil, 1, aSubRoot);
 f_Document := aDocument;
//#UC END# *4C933899017C_48F8B61F0032_impl*
end;//TnsContentsTreeStorable.Create

class function TnsContentsTreeStorable.Make(const aDocument: IDocument;
 const aData: InevSimpleTree;
 const aSubRoot: InevSimpleNode): InevStorable;
var
 l_Inst : TnsContentsTreeStorable;
begin
 l_Inst := Create(aDocument, aData, aSubRoot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsContentsTreeStorable.Make

procedure TnsContentsTreeStorable.DoIterate(const aNode: InevSimpleNode;
 aLevel: Integer;
 const G: InevTagGenerator);
//#UC START# *48F8B68401A1_48F8B61F0032_var*
var
 l_Next: InevSimpleNode;
//#UC END# *48F8B68401A1_48F8B61F0032_var*
begin
//#UC START# *48F8B68401A1_48F8B61F0032_impl*
 if not aNode.IsSame(Data.RootNode) then
  DoStoreNode(aNode, G, aLevel);
 if aNode.HasChild and Data.IsExpanded(aNode) then
 begin
  l_Next := aNode.Child;
  while Assigned(l_Next) do
  begin
   DoIterate(l_Next, aLevel + 1, G);
   l_Next := l_Next.Next;
  end;//while Assigned(l_Next)
 end;//aNode.HasChild
//#UC END# *48F8B68401A1_48F8B61F0032_impl*
end;//TnsContentsTreeStorable.DoIterate

procedure TnsContentsTreeStorable.DoIterateTree(const G: InevTagGenerator;
 aFlags: TevStoreFlags = evDefaultStoreFlags);
//#UC START# *48F8A8F501DD_48F8B61F0032_var*
var
 l_Root : InevSimpleNode;
 l_Name : IString;
//#UC END# *48F8A8F501DD_48F8B61F0032_var*
begin
//#UC START# *48F8A8F501DD_48F8B61F0032_impl*
 if Assigned(SubRoot) then
  l_Root := SubRoot
 else
  l_Root := Data.RootNode;
 G.StartChild(k2_typTextPara);
 try
  f_Document.GetName(l_Name);
  G.AddStringAtom(k2_tiText, nsWStr(l_Name));
  G.AddIntegerAtom(k2_tiFirstIndent, 0);
 finally
  G.Finish;
 end;//try..finally
 DoIterate(l_Root, 1, G);
//#UC END# *48F8A8F501DD_48F8B61F0032_impl*
end;//TnsContentsTreeStorable.DoIterateTree

procedure TnsContentsTreeStorable.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TnsContentsTreeStorable.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
