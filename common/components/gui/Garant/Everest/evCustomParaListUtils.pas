unit evCustomParaListUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomParaListUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ParaUtils::evCustomParaListUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
uses
  nevBase,
  nevTools,
  evEditorInterfaces,
  k2ProcessorTagTool,
  l3Variant
  ;

type
 TevLocationProcessorTagTool = class(Tk2ProcessorTagTool)
  {* Базовый класс для инструментов для тегов, с использованием _TevLocation. }
 private
 // private fields
   f_View : InevView;
    {* Поле для свойства View}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_Location : InevLocation;
 public
 // public methods
   constructor Create(const aView: InevView;
     aTagWrap: Tl3Variant;
     const aProcessor: InevProcessor;
     const aLocation: InevLocation = nil); reintroduce;
 public
 // public properties
   property View: InevView
     read f_View;
 end;//TevLocationProcessorTagTool

 TevTableChild = class(TevLocationProcessorTagTool)
 private
 // private fields
   f_Table : IedTable;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function GetTable: IedTable;
 public
 // public methods
   constructor Create(const aView: InevView;
     const aTable: IedTable;
     aTagWrap: Tl3Variant;
     const aProcessor: InevProcessor;
     const aLocation: InevLocation = nil); reintroduce;
 end;//TevTableChild

 TevRowChild = class(TevLocationProcessorTagTool)
 private
 // private fields
   f_Row : IedRow;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function GetRow: IedRow;
 public
 // public methods
   constructor Create(const aView: InevView;
     const aRow: IedRow;
     aTagWrap: Tl3Variant;
     const aProcessor: InevProcessor;
     const aLocation: InevLocation = nil); reintroduce;
 end;//TevRowChild
procedure EvCheckCellStatus(const anOpPack: InevOp;
  const aCell: InevPara);
{$IfEnd} //evNeedEditableCursors AND k2ForEditor

implementation

{$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
uses
  evCursorTools,
  k2Base,
  k2Tags,
  evdStyles
  ;

// start class TevLocationProcessorTagTool

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
 {-}
begin
 {$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
 f_View := nil;
 {$IfEnd} //evNeedEditableCursors AND k2ForEditor
 inherited;
end;//TevLocationProcessorTagTool.ClearFields
// start class TevTableChild

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
//#UC START# *479731C50290_4FA4F2AA0302_var*
//#UC END# *479731C50290_4FA4F2AA0302_var*
begin
//#UC START# *479731C50290_4FA4F2AA0302_impl*
 f_Table := nil;
 inherited;
//#UC END# *479731C50290_4FA4F2AA0302_impl*
end;//TevTableChild.Cleanup
// start class TevRowChild

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
//#UC START# *479731C50290_4FC47ECC03C9_var*
//#UC END# *479731C50290_4FC47ECC03C9_var*
begin
//#UC START# *479731C50290_4FC47ECC03C9_impl*
 f_Row := nil;
 inherited;
//#UC END# *479731C50290_4FC47ECC03C9_impl*
end;//TevRowChild.Cleanup

procedure EvCheckCellStatus(const anOpPack: InevOp;
  const aCell: InevPara);
//#UC START# *502CD0E40149_4F6C2D7901D1_var*
//#UC END# *502CD0E40149_4F6C2D7901D1_var*
begin
//#UC START# *502CD0E40149_4F6C2D7901D1_impl*
 if aCell.AsObject.ChildrenCount = 0 then
  if evInsertPara(anOpPack, aCell.MakePoint, Tk2Type(aCell.AsObject.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject) then
   aCell.AsObject.Child[0].IntW[k2_tiStyle, anOpPack] := ev_saNormalTable;
//#UC END# *502CD0E40149_4F6C2D7901D1_impl*
end;//EvCheckCellStatus
{$IfEnd} //evNeedEditableCursors AND k2ForEditor

end.