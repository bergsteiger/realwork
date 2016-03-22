unit evCustomParaListUtils;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomParaListUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evCustomParaListUtils" MUID: (4F6C2D7901D1)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3IntfUses
 , nevBase
 , nevTools
 , k2ProcessorTagTool
 , l3Variant
 , evEditorInterfaces
;

type
 TevLocationProcessorTagTool = class(Tk2ProcessorTagTool)
  {* Базовый класс для инструментов для тегов, с использованием _TevLocation. }
  private
   f_View: InevView;
    {* Поле для свойства View }
  protected
   f_Location: InevLocation;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aView: InevView;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aLocation: InevLocation = nil); reintroduce;
  public
   property View: InevView
    read f_View;
 end;//TevLocationProcessorTagTool

 TevTableChild = class(TevLocationProcessorTagTool)
  private
   f_Table: IedTable;
  protected
   function GetTable: IedTable;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aView: InevView;
    const aTable: IedTable;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aLocation: InevLocation = nil); reintroduce;
 end;//TevTableChild

 TevRowChild = class(TevLocationProcessorTagTool)
  private
   f_Row: IedRow;
  protected
   function GetRow: IedRow;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aView: InevView;
    const aRow: IedRow;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aLocation: InevLocation = nil); reintroduce;
 end;//TevRowChild

procedure evCheckCellStatus(const anOpPack: InevOp;
 const aCell: InevPara);
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

implementation

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3ImplUses
 , evCursorTools
 , k2Base
 , k2Tags
 , evdStyles
;

procedure evCheckCellStatus(const anOpPack: InevOp;
 const aCell: InevPara);
//#UC START# *502CD0E40149_4F6C2D7901D1_var*
//#UC END# *502CD0E40149_4F6C2D7901D1_var*
begin
//#UC START# *502CD0E40149_4F6C2D7901D1_impl*
 if aCell.AsObject.ChildrenCount = 0 then
  if evInsertPara(anOpPack, aCell.MakePoint, Tk2Type(aCell.AsObject.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject) then
   aCell.AsObject.Child[0].IntW[k2_tiStyle, anOpPack] := ev_saNormalTable;
//#UC END# *502CD0E40149_4F6C2D7901D1_impl*
end;//evCheckCellStatus

constructor TevLocationProcessorTagTool.Create(const aView: InevView;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aLocation: InevLocation = nil);
//#UC START# *4F6C2EBF02EA_4F6C2DB4038D_var*
//#UC END# *4F6C2EBF02EA_4F6C2DB4038D_var*
begin
//#UC START# *4F6C2EBF02EA_4F6C2DB4038D_impl*
 inherited Create(aTagWrap, aProcessor);
 f_View := aView;
 f_Location := aLocation;
//#UC END# *4F6C2EBF02EA_4F6C2DB4038D_impl*
end;//TevLocationProcessorTagTool.Create

procedure TevLocationProcessorTagTool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F6C2DB4038D_var*
//#UC END# *479731C50290_4F6C2DB4038D_var*
begin
//#UC START# *479731C50290_4F6C2DB4038D_impl*
 f_View := nil;
 f_Location := nil;
 inherited;
//#UC END# *479731C50290_4F6C2DB4038D_impl*
end;//TevLocationProcessorTagTool.Cleanup

procedure TevLocationProcessorTagTool.ClearFields;
begin
 f_View := nil;
 inherited;
end;//TevLocationProcessorTagTool.ClearFields

constructor TevTableChild.Create(const aView: InevView;
 const aTable: IedTable;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aLocation: InevLocation = nil);
//#UC START# *4FA4F2DB015A_4FA4F2AA0302_var*
//#UC END# *4FA4F2DB015A_4FA4F2AA0302_var*
begin
//#UC START# *4FA4F2DB015A_4FA4F2AA0302_impl*
 inherited Create(aView, aTagWrap, aProcessor, aLocation);
 f_Table := aTable;
//#UC END# *4FA4F2DB015A_4FA4F2AA0302_impl*
end;//TevTableChild.Create

function TevTableChild.GetTable: IedTable;
//#UC START# *4FA4F36702FC_4FA4F2AA0302_var*
//#UC END# *4FA4F36702FC_4FA4F2AA0302_var*
begin
//#UC START# *4FA4F36702FC_4FA4F2AA0302_impl*
 Result := f_Table;
//#UC END# *4FA4F36702FC_4FA4F2AA0302_impl*
end;//TevTableChild.GetTable

procedure TevTableChild.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FA4F2AA0302_var*
//#UC END# *479731C50290_4FA4F2AA0302_var*
begin
//#UC START# *479731C50290_4FA4F2AA0302_impl*
 f_Table := nil;
 inherited;
//#UC END# *479731C50290_4FA4F2AA0302_impl*
end;//TevTableChild.Cleanup

function TevRowChild.GetRow: IedRow;
//#UC START# *4FC47FAC0128_4FC47ECC03C9_var*
//#UC END# *4FC47FAC0128_4FC47ECC03C9_var*
begin
//#UC START# *4FC47FAC0128_4FC47ECC03C9_impl*
 Result := f_Row;
//#UC END# *4FC47FAC0128_4FC47ECC03C9_impl*
end;//TevRowChild.GetRow

constructor TevRowChild.Create(const aView: InevView;
 const aRow: IedRow;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aLocation: InevLocation = nil);
//#UC START# *4FC4800103A2_4FC47ECC03C9_var*
//#UC END# *4FC4800103A2_4FC47ECC03C9_var*
begin
//#UC START# *4FC4800103A2_4FC47ECC03C9_impl*
 inherited Create(aView, aTagWrap, aProcessor, aLocation);
 f_Row := aRow;
//#UC END# *4FC4800103A2_4FC47ECC03C9_impl*
end;//TevRowChild.Create

procedure TevRowChild.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FC47ECC03C9_var*
//#UC END# *479731C50290_4FC47ECC03C9_var*
begin
//#UC START# *479731C50290_4FC47ECC03C9_impl*
 f_Row := nil;
 inherited;
//#UC END# *479731C50290_4FC47ECC03C9_impl*
end;//TevRowChild.Cleanup
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

end.
