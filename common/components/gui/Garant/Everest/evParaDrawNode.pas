unit evParaDrawNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evParaDrawNode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::PaintedNode::TevParaDrawNode
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Interfaces,
  nevTools,
  evParaNode,
  l3IID,
  l3Variant,
  nevBase
  ;

type
 TevParaDrawNode = class(TevParaNode, Ik2TagBoxContainer, IevTreeDataObject)
 protected
 // realized methods
   procedure SetTag(aTag: Tl3Variant);
   procedure Store(const G: InevTagGenerator;
    aLevelTag: Integer;
    aIndent: Integer);
     {* ��������� ���� ������ � G }
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* ���������� ������� ���������� }
 end;//TevParaDrawNode

implementation

uses
  evNodePainter,
  l3InternalInterfaces,
  k2Const
  ;

// start class TevParaDrawNode

procedure TevParaDrawNode.SetTag(aTag: Tl3Variant);
//#UC START# *469F9FD9025D_4E24151202E1_var*
//#UC END# *469F9FD9025D_4E24151202E1_var*
begin
//#UC START# *469F9FD9025D_4E24151202E1_impl*
 Redirect := aTag.Box;
//#UC END# *469F9FD9025D_4E24151202E1_impl*
end;//TevParaDrawNode.SetTag

procedure TevParaDrawNode.Store(const G: InevTagGenerator;
  aLevelTag: Integer;
  aIndent: Integer);
//#UC START# *48F8AD980361_4E24151202E1_var*
//#UC END# *48F8AD980361_4E24151202E1_var*
begin
//#UC START# *48F8AD980361_4E24151202E1_impl*
 if Assigned(Tag) then
 begin
  G.StartChild(Tag.TagType);
  try
   Tag.AsObject.WriteTag(G);
   if aLevelTag <> k2_tiVoid then
    G.AddIntegerAtom(aLevelTag, aIndent);
  finally
   G.Finish;
  end;
 end; {if..}
//#UC END# *48F8AD980361_4E24151202E1_impl*
end;//TevParaDrawNode.Store

function TevParaDrawNode.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4E24151202E1_var*
//#UC END# *4A60B23E00C3_4E24151202E1_var*
begin
//#UC START# *4A60B23E00C3_4E24151202E1_impl*
 if IID.EQ(Il3NodePainter) then
 begin
  Result.SetOk;
  Il3NodePainter(Obj) := TevNodePainter.Make(Tag);
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4E24151202E1_impl*
end;//TevParaDrawNode.COMQueryInterface

end.