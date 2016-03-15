unit evLeafParaMultiSelectionBlock;

// Модуль: "w:\common\components\gui\Garant\Everest\evLeafParaMultiSelectionBlock.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evMultiSelectionBlock
 , nevTools
 , l3Variant
 , nevRangeList
 , nevBase
 , evdInterfaces
;

type
 TevLeafParaMultiSelectionBlock = class(TevMultiSelectionBlock)
  protected
   procedure DoStore(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
    {* сохраняет выделение в G }
  public
   function Iterate(anAction: InevRangePrim_Iterate_Action;
    aStart: Integer = l3Types.l3MinIndex): Integer; override;
   class function Make(aTagWrap: Tl3Variant;
    aBlocks: TnevRangeList): InevRange; reintroduce;
    {* список блоков выделения, д. б отсортирован по порядку следования параграфов, и по положению блока внутри параграфа }
 end;//TevLeafParaMultiSelectionBlock

implementation

uses
 l3ImplUses
 , l3Base
;

function TevLeafParaMultiSelectionBlock.Iterate(anAction: InevRangePrim_Iterate_Action;
 aStart: Integer = l3Types.l3MinIndex): Integer;
//#UC START# *4BAA60370285_48ECD64B005A_var*
//#UC END# *4BAA60370285_48ECD64B005A_var*
begin
//#UC START# *4BAA60370285_48ECD64B005A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BAA60370285_48ECD64B005A_impl*
end;//TevLeafParaMultiSelectionBlock.Iterate

class function TevLeafParaMultiSelectionBlock.Make(aTagWrap: Tl3Variant;
 aBlocks: TnevRangeList): InevRange;
 {* список блоков выделения, д. б отсортирован по порядку следования параграфов, и по положению блока внутри параграфа }
var
 l_Inst : TevLeafParaMultiSelectionBlock;
begin
 l_Inst := Create(aTagWrap, aBlocks);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevLeafParaMultiSelectionBlock.Make

procedure TevLeafParaMultiSelectionBlock.DoStore(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* сохраняет выделение в G }
//#UC START# *48ECE4420180_48ECD64B005A_var*
//#UC END# *48ECE4420180_48ECD64B005A_var*
begin
//#UC START# *48ECE4420180_48ECD64B005A_impl*
 if (Blocks <> nil) AND (Blocks.Count = 1) then
  Blocks.First.AsStorable.Store(aView, G, aFlags)
 else
  Assert(false, 'Опс.. мы пока не умееем сохранять множественное выделение для листьевого параграфа.');
//#UC END# *48ECE4420180_48ECD64B005A_impl*
end;//TevLeafParaMultiSelectionBlock.DoStore

end.
