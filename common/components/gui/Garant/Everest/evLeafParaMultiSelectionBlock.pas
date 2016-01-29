unit evLeafParaMultiSelectionBlock;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evLeafParaMultiSelectionBlock.pas"
// �����: 08.10.2008 18:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevLeafParaMultiSelectionBlock
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  nevRangeList,
  evMultiSelectionBlock,
  l3Variant,
  l3Types,
  nevBase,
  evdInterfaces
  ;

type
 TevLeafParaMultiSelectionBlock = class(TevMultiSelectionBlock)
 protected
 // overridden protected methods
   procedure DoStore(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* ��������� ��������� � G }
 public
 // public methods
   {iterator} function Iterate(anAction: InevRangePrim_Iterate_Action;
    aStart: Integer = l3MinIndex): Integer; override;
   class function Make(aTagWrap: Tl3Variant;
    aBlocks: TnevRangeList): InevRange; reintroduce;
     {* ������ ������ ���������, �. � ������������ �� ������� ���������� ����������, � �� ��������� ����� ������ ��������� }
 end;//TevLeafParaMultiSelectionBlock

implementation

uses
  l3Base
  ;

// start class TevLeafParaMultiSelectionBlock

{iterator} function TevLeafParaMultiSelectionBlock.Iterate(anAction: InevRangePrim_Iterate_Action;
  aStart: Integer = l3MinIndex): Integer;
//#UC START# *4BA8DE8C03D8_48ECD64B005A_var*

  function l_StoreSel(aSel: PIUnknown; anIndex: Integer): Boolean;
  begin//l_StoreSel
   Result := anAction(InevRange(aSel^), anIndex);
  end;//l_StoreSel

//#UC END# *4BA8DE8C03D8_48ECD64B005A_var*
begin
//#UC START# *4BA8DE8C03D8_48ECD64B005A_impl*
 if (Blocks <> nil) then
  Result := Blocks.IterateAllF(l3L2IA(@l_StoreSel))
 else
  Result := -1;
//#UC END# *4BA8DE8C03D8_48ECD64B005A_impl*
end;//TevLeafParaMultiSelectionBlock.Iterate

class function TevLeafParaMultiSelectionBlock.Make(aTagWrap: Tl3Variant;
  aBlocks: TnevRangeList): InevRange;
var
 l_Inst : TevLeafParaMultiSelectionBlock;
begin
 l_Inst := Create(aTagWrap, aBlocks);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TevLeafParaMultiSelectionBlock.DoStore(const aView: InevView;
  const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
//#UC START# *48ECE4420180_48ECD64B005A_var*
//#UC END# *48ECE4420180_48ECD64B005A_var*
begin
//#UC START# *48ECE4420180_48ECD64B005A_impl*
 if (Blocks <> nil) AND (Blocks.Count = 1) then
  Blocks.First.AsStorable.Store(aView, G, aFlags)
 else
  Assert(false, '���.. �� ���� �� ������ ��������� ������������� ��������� ��� ���������� ���������.');
//#UC END# *48ECE4420180_48ECD64B005A_impl*
end;//TevLeafParaMultiSelectionBlock.DoStore

end.