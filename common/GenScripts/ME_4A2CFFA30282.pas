unit evdBlockNameAdder;
 {* Фильтр, добавляющий имена блоков }

// Модуль: "w:\common\components\gui\Garant\Everest\evdBlockNameAdder.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdHeaderHyperlinkAdder
 , k2Base
 , l3Variant
 , l3Interfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 TevdBlockInfo = record
  {* Информация о блоке }
  rInContents: Boolean;
   {* Попадает ли блок в оглавление }
  rBlockType: Tk2Type;
   {* Тип блока }
  rBlockID: Integer;
   {* Идентификатор блока }
  rName: Il3CString;
   {* Имя блока }
  rSaved: Boolean;
   {* Информация о блоке уже была сохранена }
 end;//TevdBlockInfo

 _ItemType_ = TevdBlockInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TevdBlocks = class(_l3RecordListPrim_)
  {* Накопленные в результате анализа документа блоки }
 end;//TevdBlocks

 TevdBlockNameAdder = class(TevdHeaderHyperlinkAdder)
  {* Фильтр, добавляющий имена блоков }
  private
   f_Blocks: TevdBlocks;
    {* Накопленные блоки }
   f_NeedDecorHeader: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure CloseStructure(NeedUndo: Boolean); override;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure OutBlockNames(aLeaf: Tl3Variant); override;
    {* Выводит имена блоков, в которые вложен данный параграф }
 end;//TevdBlockNameAdder

function TevdBlockInfo_C(const aName: Il3CString): TevdBlockInfo;
function TevdBlockInfo_E: TevdBlockInfo;
 {* Создаёт пустую структуру }
function TevdBlockInfo_T(aType: Tk2Type): TevdBlockInfo;

implementation

uses
 l3ImplUses
 , SysUtils
 , Block_Const
 , k2Tags
 , TextPara_Const
 , evTextStyle_Const
 , l3CustomString
 , ContentsElement_Const
 , Document_Const
 , evdTypes
 , Table_Const
 , PageBreak_Const
 , l3String
 , k2Facade
 , SegmentsLayer_Const
 , HyperLink_Const
 , Address_Const
 , evdTextStyle_Const
 , DecorTextPara_Const
 , l3Base
 , l3MinMax
 , RTLConsts
;

function TevdBlockInfo_C(const aName: Il3CString): TevdBlockInfo;
//#UC START# *4A2D14530087_4A2D046A01BE_var*
//#UC END# *4A2D14530087_4A2D046A01BE_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A2D14530087_4A2D046A01BE_impl*
 Result.rName := aName;
//#UC END# *4A2D14530087_4A2D046A01BE_impl*
end;//TevdBlockInfo_C

function TevdBlockInfo_E: TevdBlockInfo;
 {* Создаёт пустую структуру }
//#UC START# *4A2D263C02BE_4A2D046A01BE_var*
//#UC END# *4A2D263C02BE_4A2D046A01BE_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A2D263C02BE_4A2D046A01BE_impl*
//#UC END# *4A2D263C02BE_4A2D046A01BE_impl*
end;//TevdBlockInfo_E

function TevdBlockInfo_T(aType: Tk2Type): TevdBlockInfo;
//#UC START# *4A2FE6E60214_4A2D046A01BE_var*
//#UC END# *4A2FE6E60214_4A2D046A01BE_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A2FE6E60214_4A2D046A01BE_impl*
 Result.rBlockType := aType;
//#UC END# *4A2FE6E60214_4A2D046A01BE_impl*
end;//TevdBlockInfo_T

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4A2D03DC0068_var*
//#UC END# *47B07CF403D0_4A2D03DC0068_var*
begin
//#UC START# *47B07CF403D0_4A2D03DC0068_impl*
 Result := false;
//#UC END# *47B07CF403D0_4A2D03DC0068_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A2D03DC0068_var*
//#UC END# *47B2C42A0163_4A2D03DC0068_var*
begin
//#UC START# *47B2C42A0163_4A2D03DC0068_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4A2D03DC0068_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4A2D03DC0068_var*
//#UC END# *47B99D4503A2_4A2D03DC0068_var*
begin
//#UC START# *47B99D4503A2_4A2D03DC0068_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4A2D03DC0068_impl*
end;//CompareExistingItems

type _Instance_R_ = TevdBlocks;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

procedure TevdBlockNameAdder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A2CFFA30282_var*
//#UC END# *479731C50290_4A2CFFA30282_var*
begin
//#UC START# *479731C50290_4A2CFFA30282_impl*
 FreeAndNil(f_Blocks);
 inherited;
//#UC END# *479731C50290_4A2CFFA30282_impl*
end;//TevdBlockNameAdder.Cleanup

procedure TevdBlockNameAdder.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_4A2CFFA30282_var*
//#UC END# *4836D4C20059_4A2CFFA30282_var*
begin
//#UC START# *4836D4C20059_4A2CFFA30282_impl*
 if CurrentType.IsKindOf(k2_typContentsElement) then
  f_Blocks.Count := f_Blocks.Count - 1; 
 inherited;
//#UC END# *4836D4C20059_4A2CFFA30282_impl*
end;//TevdBlockNameAdder.CloseStructure

procedure TevdBlockNameAdder.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_4A2CFFA30282_var*
//#UC END# *4A2D1217037A_4A2CFFA30282_var*
begin
//#UC START# *4A2D1217037A_4A2CFFA30282_impl*
 if TypeID.IsKindOf(k2_typTable) then
  OutBlockNames(nil);
 inherited;
 if CurrentType.IsKindOf(k2_typContentsElement) then
 begin
  if (f_Blocks = nil) then
   f_Blocks := TevdBlocks.Create;
  f_Blocks.Add(TevdBlockInfo_T(TypeID));
 end;//CurrentType.IsKindOf(k2_typContentsElement)
//#UC END# *4A2D1217037A_4A2CFFA30282_impl*
end;//TevdBlockNameAdder.DoStartChild

procedure TevdBlockNameAdder.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4A2CFFA30282_var*

 procedure SaveName;
 var
  l_String : Tl3CustomString;
  l_Item   : TevdBlockInfo;
 begin
  l_String := VariantAsString(Value);
  try
   l_Item := f_Blocks.Last;
   if (l_String = nil) then
    l_Item.rName := nil
   else
   if not l3IOk(l_String.QueryInterface(Il3CString, l_Item.rName)) then
    Assert(false);
   f_Blocks.Last := l_Item;
  finally
   FreeAndNil(l_String);
  end;//try..finally
 end;

 procedure SaveBlockID;
 var
  l_Item : TevdBlockInfo;
 begin
  l_Item := f_Blocks.Last;
  l_Item.rBlockID := VariantAsInteger(AtomIndex, Value) ;
  f_Blocks.Last := l_Item;
 end;

 procedure SaveInContentsPrim(aValue : Boolean);
 var
  l_Item : TevdBlockInfo;
 begin
  l_Item := f_Blocks.Last;
  l_Item.rInContents := aValue;
  f_Blocks.Last := l_Item;
 end;

 procedure SaveInContents;
 begin
  SaveInContentsPrim(VariantAsInteger(AtomIndex, Value) <> 0);
 end;

 procedure SaveDocInContents;
 begin
  SaveInContentsPrim(true);
 end;

var
 l_CT       : Tk2Type;
// l_NewValue : Tk2Variant;
//#UC END# *4A2D1634025B_4A2CFFA30282_var*
begin
//#UC START# *4A2D1634025B_4A2CFFA30282_impl*
 l_CT := CurrentType;
 if (AtomIndex = k2_tiInContents) AND
    l_CT.IsKindOf(k2_typContentsElement) then
  SaveInContents
 else 
 if (AtomIndex = k2_tiHandle) AND
    l_CT.IsKindOf(k2_typContentsElement) then
  SaveBlockID
 else 
 if l_CT.IsKindOf(k2_typDocument) {AND (TopType[1] = nil) }then
 begin
  f_NeedDecorHeader := False;
  if (AtomIndex = k2_tiName) then
  begin
   SaveDocInContents;
   SaveName;
  end;//AtomIndex = k2_tiName
  if (AtomIndex = k2_tiStyle) and (VariantAsInteger(AtomIndex, Value) = ev_saLinkToPublication) then
  // ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=400195823
  begin
   AddIntegerAtom(AtomIndex, evd_saTxtNormalANSI);
(*   l_NewValue.Kind := k2_vkInteger;
   l_NewValue.AsInteger := evd_saTxtNormalANSI;
   inherited DoAddAtomEx(AtomIndex, l_NewValue);*)
   Exit;
  end; // if (AtomIndex = k2_tiStyle) and (VariantAsInteger(AtomIndex, Value) = ev_saLinkToPublication) then
 end//l_CT.IsKindOf(k2_typDocument)
 else
 if l_CT.IsKindOf(k2_typContentsElement) then
  if (AtomIndex = k2_tiStyle) and (VariantAsInteger(AtomIndex, Value) = ev_saExpandedText) then
   f_NeedDecorHeader := True
  else
   if (AtomIndex = k2_tiShortName) then
    SaveName;
 inherited;
//#UC END# *4A2D1634025B_4A2CFFA30282_impl*
end;//TevdBlockNameAdder.DoAddAtomEx

procedure TevdBlockNameAdder.OutBlockNames(aLeaf: Tl3Variant);
 {* Выводит имена блоков, в которые вложен данный параграф }
//#UC START# *4CF513300102_4A2CFFA30282_var*
var
 l_Item : TevdBlockInfo;
 l_Index : Integer;
//#UC END# *4CF513300102_4A2CFFA30282_var*
begin
//#UC START# *4CF513300102_4A2CFFA30282_impl*
 for l_Index := 0 to f_Blocks.Hi do
 begin
  l_Item := f_Blocks[l_Index];
  with l_Item do
   if not rSaved then
   begin
    l_Item.rSaved := true;
    f_Blocks[l_Index] := l_Item;
    if not l3IsNil(rName) then
     if rInContents then
      if  (rBlockType = k2_typContentsElement) OR
         rBlockType.IsKindOf(k2_typDocument) then
       begin
        if (l_Index = f_Blocks.Hi) then
         // - обрабатываем самый вложенный блок
         if (aLeaf <> nil) AND
            l3Starts(l3PCharLen(rName), aLeaf.PCharLenA[k2_tiText]) then
          // - типа такой текст уже есть в самом параграфе
          continue;
        if f_NeedDecorHeader then
         Generator.StartChild(k2_typDecorTextPara)
        else
         Generator.StartChild(k2_typTextPara);
        try
         Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
         //Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
         Generator.AddStringAtom(k2_tiText, l3PCharLen(rName));
         if (f_DocID <> 0) then
         begin
          f_WasSomeLink := true;
          Generator.StartTag(k2_tiSegments);
          try
           Generator.StartChild(k2_typSegmentsLayer);
           try
            Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperlinks));
            Generator.StartChild(k2_typHyperlink);
            try
             Generator.AddIntegerAtom(k2_tiStart, 1);
             Generator.AddIntegerAtom(k2_tiFinish, l3Len(rName));
             Generator.StartChild(k2_typAddress);
             try
              Generator.AddIntegerAtom(k2_tiType, CI_REF);
              Generator.AddIntegerAtom(k2_tiDocID, f_DocID);
              if (rBlockID <> 0) then
               Generator.AddIntegerAtom(k2_tiSubID, rBlockID);
             finally
              Generator.Finish;
             end;//try..finally
            finally
             Generator.Finish;
            end;//try..finally
           finally
            Generator.Finish;
           end;//try..finally
          finally
           Generator.Finish;
          end;//try..finally
         end;//f_DocID <> 0
        finally
         Generator.Finish;
        end;//try..finally
       end;//not l3IsNil(rName)
    end;//not rSaved
 end;//for l_Index
 inherited;
//#UC END# *4CF513300102_4A2CFFA30282_impl*
end;//TevdBlockNameAdder.OutBlockNames

end.
