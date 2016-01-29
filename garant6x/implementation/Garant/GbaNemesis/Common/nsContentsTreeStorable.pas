unit nsContentsTreeStorable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsContentsTreeStorable.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentDataObjects::TnsContentsTreeStorable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nevBase,
  nevTools,
  evTreeStorable,
  evdInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsContentsTreeStorable = class(TevTreeStorable)
 private
 // private fields
   f_Document : IDocument;
 protected
 // overridden protected methods
   procedure DoIterateTree(const G: InevTagGenerator;
    aFlags: TevStoreFlags = evDefaultStoreFlags); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure DoIterate(const aNode: InevSimpleNode;
    aLevel: Integer;
    const G: InevTagGenerator);
 public
 // public methods
   constructor Create(const aDocument: IDocument;
     const aData: InevSimpleTree;
     const aSubRoot: InevSimpleNode); reintroduce;
   class function Make(const aDocument: IDocument;
     const aData: InevSimpleTree;
     const aSubRoot: InevSimpleNode): InevStorable; reintroduce;
     {* Сигнатура фабрики TnsContentsTreeStorable.Make }
 end;//TnsContentsTreeStorable
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  k2Tags,
  TextPara_Const,
  IOUnit,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsContentsTreeStorable

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
end;

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Document := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsContentsTreeStorable.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.