unit evRange;
 {* Реализация интерфейса IedRange }

// Модуль: "w:\common\components\gui\Garant\Everest\evRange.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evRange" MUID: (48E385660374)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2ProcTagTool
 , evEditorInterfaces
 , nevTools
 , nevBase
 , nevNavigation
 , l3Interfaces
 , Windows
;

type
 TedRangeImplementation = class(Tk2ProcTagTool, IedRange)
  {* Реализация интерфейса IedRange }
  private
   f_TextParagraph: IedTextParagraph;
   f_View: InevView;
   f_Loc: InevLocation;
  protected
   function Get_Paragraph: IedParagraph;
   function Get_Table: IedTable;
   function Get_Hyperlink: IevHyperlink;
   function pm_GetCollapsed: Boolean;
   function pm_GetTextParagraph: IedTextParagraph;
   function pm_GetPart(aPart: TedRangePart): IedRange;
   function pm_GetDocument: IevDocument;
   function ContainsOneLeaf: Boolean;
    {* проверяет содержит ли диапазон только один листьевой параграф }
   function AsString(aFormat: Tl3ClipboardFormat = cf_Text): AnsiString;
    {* получает текст в диапазоне }
   function Delete(aMode: TevClearMode = nevTools.ev_cmKeepOne): Boolean;
    {* удаляет содержимое диапазона }
   function InsertData(aFormat: Tl3ClipboardFormat;
    aData: THandle;
    aNeedClearOld: Boolean = False): Boolean;
    {* вставить данные из памяти в формате aFormat }
   procedure InsertFrom(const aTextSource: InevTagReader;
    const aFilters: InevTagGenerator);
    {* вставить данные из другого источника текста }
   function InsertString(const aSt: Tl3PCharLenPrim;
    aFormat: Tl3ClipboardFormat = cf_Text): Boolean; overload;
    {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
   function InsertString(const aSt: AnsiString;
    aFormat: Tl3ClipboardFormat = cf_Text): Boolean; overload;
    {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString('Hello world!');
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
   function InsertParaBreak: Boolean;
    {* вставляет разрыв параграфов }
   function DeleteChar: Boolean;
    {* удаляет текущий символ }
   function Save(aFormat: Tl3ClipboardFormat;
    const outPool: IStream;
    const aFilters: InevTagGenerator;
    anInternal: Boolean = False;
    ChildrenOnly: Boolean = False): Boolean;
    {* сохранить выделение }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const aView: InevView;
    const aLoc: InevLocation;
    const aProcessor: InevProcessor;
    const aTextParagraph: IedTextParagraph = nil); reintroduce;
   class function Make(const aView: InevView;
    const aLoc: InevLocation;
    const aProcessor: InevProcessor;
    const aTextParagraph: IedTextParagraph = nil): IedRange; reintroduce;
   function Collapse: Boolean;
   procedure Iterate;
    {* Итератор по листьевым параграфам }
 end;//TedRangeImplementation

 TedRange = class(TedRangeImplementation)
  {* Реализация интерфейса IedRange. Для конечного использования }
 end;//TedRange

implementation

uses
 l3ImplUses
 , ParaList_Const
 , Table_Const
 , SysUtils
 {$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
 , evParaUtilClasses
 {$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)
 , l3Memory
 , l3Base
 , evTypes
 , nevFacade
 , evOp
 , evEditorInterfacesMisc
 , Messages
 , evBitmapReader
 , evExcept
 , l3String
 , l3Chars
 , evMsgCode
 , evdInterfaces
 {$If Defined(k2ForEditor)}
 , evUsialParagraph
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoScripts)}
 , IedRangeWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

constructor TedRangeImplementation.Create(const aView: InevView;
 const aLoc: InevLocation;
 const aProcessor: InevProcessor;
 const aTextParagraph: IedTextParagraph = nil);
//#UC START# *4BBCC34901B7_48E3859101D5_var*
//#UC END# *4BBCC34901B7_48E3859101D5_var*
begin
//#UC START# *4BBCC34901B7_48E3859101D5_impl*
 inherited Create(aLoc.Obj^.AsObject, aProcessor);
 f_View := aView;
 f_TextParagraph := aTextParagraph;
 f_Loc := aLoc;
//#UC END# *4BBCC34901B7_48E3859101D5_impl*
end;//TedRangeImplementation.Create

class function TedRangeImplementation.Make(const aView: InevView;
 const aLoc: InevLocation;
 const aProcessor: InevProcessor;
 const aTextParagraph: IedTextParagraph = nil): IedRange;
var
 l_Inst : TedRangeImplementation;
begin
 l_Inst := Create(aView, aLoc, aProcessor, aTextParagraph);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TedRangeImplementation.Make

function TedRangeImplementation.Collapse: Boolean;
//#UC START# *4BBD95BE014E_48E3859101D5_var*
var
 l_Range : IevRange;
//#UC END# *4BBD95BE014E_48E3859101D5_var*
begin
//#UC START# *4BBD95BE014E_48E3859101D5_impl*
 if Supports(f_Loc, IevRange, l_Range) then
  try
   Result := l_Range.Unselect(f_View);
  finally
   l_Range := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *4BBD95BE014E_48E3859101D5_impl*
end;//TedRangeImplementation.Collapse

procedure TedRangeImplementation.Iterate;
 {* Итератор по листьевым параграфам }
var l_Cont: Boolean;
var l_OpPack: InevOp;

 procedure IterateRange;
  {* Перебирает диапазон }

  function BlockAction(const anItem: InevRange;
   anIndex: Integer): Boolean;
   {* Подитеративная функция для вызова L2InevRangePrimIterateAction из IterateRange }

   function DoIt(const anItem: InevRange;
    anIndex: Integer): Boolean;
    {* Подитеративная функция для вызова L2InevRangePrimIterateAction из BlockAction }
   //#UC START# *1B9BCE274A0B__var*
   //#UC END# *1B9BCE274A0B__var*
   begin
   //#UC START# *1B9BCE274A0B__impl*
    Result := BlockAction(anItem, anIndex);
   //#UC END# *1B9BCE274A0B__impl*
   end;//DoIt

  //#UC START# *4BBF194202E8__var*
  //#UC END# *4BBF194202E8__var*
  begin
   //#UC START# *4BBF194202E8iter*
   if anItem.Obj.AsObject.IsKindOf(k2_typParaList) then
    anItem.
   //#UC END# *4BBF194202E8iter*
   IterateF(L2InevRangePrimIterateAction(@DoIt))
   //#UC START# *4BBF194202E8afteriter*
   else
    l_Cont := anAction(TevLeafParagraph.Make(f_View, Processor, anItem));
   Result := l_Cont;
   //#UC END# *4BBF194202E8afteriter*
  end;//BlockAction

 //#UC START# *4BBF18C801F5__var*
 //#UC END# *4BBF18C801F5__var*
 begin
  //#UC START# *4BBF18C801F5iter*
  f_Loc.Range.
  //#UC END# *4BBF18C801F5iter*
  IterateF(L2InevRangePrimIterateAction(@BlockAction));
 end;//IterateRange

//#UC START# *4BBF09C60382_48E3859101D5_var*
//#UC END# *4BBF09C60382_48E3859101D5_var*
begin
//#UC START# *4BBF09C60382_48E3859101D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BBF09C60382_48E3859101D5_impl*
end;//TedRangeImplementation.Iterate

function TedRangeImplementation.Get_Paragraph: IedParagraph;
//#UC START# *4BBCB16B01A8_48E3859101D5get_var*
//#UC END# *4BBCB16B01A8_48E3859101D5get_var*
begin
//#UC START# *4BBCB16B01A8_48E3859101D5get_impl*
 if (f_Loc.AsPoint <> nil) then
 begin
  with f_Loc.AsPoint.MostInner.Obj^ do
   if IsValid AND not IsKindOf(k2_typParaList) then
    Result := TevUsialParagraph.Make(GetRedirect, Processor)
   else
    Result := nil;
 end//f_Loc.AsPoint <> nil
 else
 if (f_Loc.Range <> nil) then
  Pointer(Result) := Pointer(IedParagraph(TevParagraphPack.Create(f_View, Processor, f_Loc.Range)))
 else
  Result := nil;
//#UC END# *4BBCB16B01A8_48E3859101D5get_impl*
end;//TedRangeImplementation.Get_Paragraph

function TedRangeImplementation.Get_Table: IedTable;
//#UC START# *4BBCB17D02BC_48E3859101D5get_var*
var
 l_Cursor       : InevBasePoint;
 l_Finish       : InevBasePoint;
 l_CellRange    : InevLocation;
 l_Block        : InevRange;
 l_BlockFactory : InevRangeFactory;
//#UC END# *4BBCB17D02BC_48E3859101D5get_var*
begin
//#UC START# *4BBCB17D02BC_48E3859101D5get_impl*
 l_CellRange := nil;
 try
  if (f_Loc.AsPoint <> nil) then
  begin                                                     
   l_Cursor := f_Loc.AsPoint.MostInner;
   if (l_Cursor <> nil) and not l_Cursor.AfterEnd and not l_Cursor.BeforeStart then
    l_Cursor := l_Cursor.PointToTypedParent(k2_typTable);
   l_CellRange := l_Cursor;
  end//f_Loc.AsPoint <> nil
  else
  if (f_Loc.Range <> nil) then
  begin
   f_Loc.Range.GetBorderPoints(l_Cursor, l_Finish);
   if l_Cursor <> nil then
   begin
    l_Cursor := l_Cursor.MostInner;
    if l_Cursor <> nil then
     l_Cursor := l_Cursor.PointToTypedParent(k2_typTable);
    if (l_Cursor <> nil) then
    begin
     // - Здесь будем делать блок для диапазона ячеек.
     l_Block := l_Cursor.Obj.Range;
     if (l_Finish = nil) then
     begin
      if Supports(l_Block, InevRangeFactory, l_BlockFactory) then
       l_BlockFactory.Init(l_Cursor, nil);
     end
     else
     begin
      l_Finish := l_Finish.MostInner;
      if l_Finish <> nil then
       l_Finish := l_Finish.PointToParent(l_Cursor.Obj^);
      if Supports(l_Block, InevRangeFactory, l_BlockFactory) then
       l_BlockFactory.Init(l_Cursor, l_Finish);
     end;//l_Finish = nil
     l_CellRange := l_Block;
    end;//l_Cursor <> nil
   end; // if l_Cursor <> nil then
  end 
  else 
  begin
   Result := nil;
   Exit;
  end;
  if (l_Cursor = nil) then
   Result := nil
  else
   Pointer(Result) := Pointer(IedTable(TevTable.Create(f_View, l_Cursor.Obj^.AsObject, Processor, l_CellRange)));
 finally
  l_CellRange := nil;
 end;//try..finally
//#UC END# *4BBCB17D02BC_48E3859101D5get_impl*
end;//TedRangeImplementation.Get_Table

function TedRangeImplementation.Get_Hyperlink: IevHyperlink;
//#UC START# *4BBCB1E00074_48E3859101D5get_var*
//#UC END# *4BBCB1E00074_48E3859101D5get_var*
begin
//#UC START# *4BBCB1E00074_48E3859101D5get_impl*
 if not Supports(f_Loc, IevHyperlink, Result) then
  Result := nil;
//#UC END# *4BBCB1E00074_48E3859101D5get_impl*
end;//TedRangeImplementation.Get_Hyperlink

function TedRangeImplementation.pm_GetCollapsed: Boolean;
//#UC START# *4BBCB211030A_48E3859101D5get_var*
//#UC END# *4BBCB211030A_48E3859101D5get_var*
begin
//#UC START# *4BBCB211030A_48E3859101D5get_impl*
 Result := (f_Loc.Range = nil) OR f_Loc.Range.Collapsed(f_View);
//#UC END# *4BBCB211030A_48E3859101D5get_impl*
end;//TedRangeImplementation.pm_GetCollapsed

function TedRangeImplementation.pm_GetTextParagraph: IedTextParagraph;
//#UC START# *4BBCB22F02D6_48E3859101D5get_var*
//#UC END# *4BBCB22F02D6_48E3859101D5get_var*
begin
//#UC START# *4BBCB22F02D6_48E3859101D5get_impl*
 Result := f_TextParagraph;
//#UC END# *4BBCB22F02D6_48E3859101D5get_impl*
end;//TedRangeImplementation.pm_GetTextParagraph

function TedRangeImplementation.pm_GetPart(aPart: TedRangePart): IedRange;
//#UC START# *4BBCB24A0106_48E3859101D5get_var*
var
 l_Cursor : InevBasePoint;
 l_Block  : InevRange;
 l_Range  : TedRangeImplementation;
//#UC END# *4BBCB24A0106_48E3859101D5get_var*
begin
//#UC START# *4BBCB24A0106_48E3859101D5get_impl*
 Result := Self;
 l_Cursor := f_Loc.AsPoint;
 if (l_Cursor <> nil) then
 begin
  with l_Cursor.Obj^ do
   if IsValid then
   begin
    l_Block := Range;
    try
     if (l_Block <> nil) then
     begin
      with l_Block do
      begin
       Case aPart of
        ed_rpWord         : Select(f_View, l_Cursor, ev_stWord);
        ed_rpToLeftWord   : Select(f_View, l_Cursor, ev_ocWordLeft, -1);
        ed_rpToWordFinish : Select(f_View, l_Cursor, -1, ev_ocWordFinish);
        ed_rpToRightWord  : Select(f_View, l_Cursor, -1, ev_ocWordRight);
        ed_rpWholeWordRight : Select(f_View, l_Cursor, -1, ev_ocWholeWordRight);
       end;//Case aPart
      end;//with l_Block
      l_Range := TedRangeImplementation.Create(f_View, l_Block, Processor, f_TextParagraph);
      try
       Result := l_Range;
      finally
       l3Free(l_Range);
      end;//try..finally
     end;//l_Block <> nil
    finally
     l_Block := nil;
    end;{try..finally}
   end;//IsValid
 end;//l_Owner Is _TevBaseCursor
//#UC END# *4BBCB24A0106_48E3859101D5get_impl*
end;//TedRangeImplementation.pm_GetPart

function TedRangeImplementation.pm_GetDocument: IevDocument;
//#UC START# *4BBCB28E02E6_48E3859101D5get_var*
var
 l_Container : InevDocumentContainer;
//#UC END# *4BBCB28E02E6_48E3859101D5get_var*
begin
//#UC START# *4BBCB28E02E6_48E3859101D5get_impl*
 if (f_Loc = nil) then
  Result := nil
 else
 begin
  l_Container := f_Loc.Obj.AsPara.DocumentContainer;
  if (l_Container = nil) then
   Result := nil
  else
   Result := l_Container.Document; 
 end;//f_Loc = nil
//#UC END# *4BBCB28E02E6_48E3859101D5get_impl*
end;//TedRangeImplementation.pm_GetDocument

function TedRangeImplementation.ContainsOneLeaf: Boolean;
 {* проверяет содержит ли диапазон только один листьевой параграф }
//#UC START# *4BBCB2AD02B2_48E3859101D5_var*
var
 l_Start, l_Finish : InevBasePoint;
//#UC END# *4BBCB2AD02B2_48E3859101D5_var*
begin
//#UC START# *4BBCB2AD02B2_48E3859101D5_impl*
 if (f_Loc.AsPoint <> nil) then
 begin
  with f_Loc.AsPoint.MostInner.Obj^ do
   Result := IsValid AND not IsKindOf(k2_typParaList);
 end
 else
 if (f_Loc.Range <> nil) then
 begin
  f_Loc.Range.GetBorderPoints(l_Start, l_Finish);
  Result := (l_Start <> nil) AND (l_Finish <> nil);
  if Result then
  begin
   l_Start := l_Start.MostInner;
   l_Finish := l_Finish.MostInner;
   with l_Start.Obj^ do
    Result := IsValid AND not IsKindOf(k2_typParaList) AND IsSame(l_Finish.Obj^.AsObject);
  end;//Result
 end//f_Loc.Range <> nil
 else
  Result := false;
//#UC END# *4BBCB2AD02B2_48E3859101D5_impl*
end;//TedRangeImplementation.ContainsOneLeaf

function TedRangeImplementation.AsString(aFormat: Tl3ClipboardFormat = cf_Text): AnsiString;
 {* получает текст в диапазоне }
//#UC START# *4BBCB2C003AE_48E3859101D5_var*
var
 l_String : Tl3String;
 l_Range  : InevRange;
 l_OldLoc : InevLocation;
 l_Stream : IStream;
//#UC END# *4BBCB2C003AE_48E3859101D5_var*
begin
//#UC START# *4BBCB2C003AE_48E3859101D5_impl*
 l_String := Tl3String.Create; 
 if (f_Loc.Range = nil) and (f_Loc.AsPoint <> nil) then
 begin
  l_OldLoc := f_Loc;
  l_Range := f_Loc.Obj.Range;
  if l_Range <> nil then 
  begin
   l_Range.Select(f_View, f_Loc.AsPoint, ev_stWord);
   f_Loc := l_Range;
  end; 
 end;  
 try
  if not l3IOk(l_String.QueryInterface(IStream, l_Stream)) then
   Assert(false);
  Save(aFormat, l_Stream, nil);
  Result := l_String.AsString;
 finally
  l3Free(l_String);
  if l_OldLoc <> nil then
   f_Loc := l_OldLoc;
 end;//try..finally
//#UC END# *4BBCB2C003AE_48E3859101D5_impl*
end;//TedRangeImplementation.AsString

function TedRangeImplementation.Delete(aMode: TevClearMode = nevTools.ev_cmKeepOne): Boolean;
 {* удаляет содержимое диапазона }
//#UC START# *4BBCB3350175_48E3859101D5_var*
var
 l_OpPack : InevOp;
//#UC END# *4BBCB3350175_48E3859101D5_var*
begin
//#UC START# *4BBCB3350175_48E3859101D5_impl*
 Result := true;
 if (f_Loc.Range <> nil) then
  try
   if (Processor = nil) then
    l_OpPack := nil
   else
    l_OpPack := Processor.StartOp(WM_Clear);
   try
    if (l_OpPack <> nil) then
     l_OpPack.CheckReadonly;
    f_Loc.Range.Modify.Delete(f_View, l_OpPack, aMode);
    Collapse;
   finally
    l_OpPack := nil;
   end;//try..finally
  except
   on EevReadOnly do Result := false;
  end;//try..except
//#UC END# *4BBCB3350175_48E3859101D5_impl*
end;//TedRangeImplementation.Delete

function TedRangeImplementation.InsertData(aFormat: Tl3ClipboardFormat;
 aData: THandle;
 aNeedClearOld: Boolean = False): Boolean;
 {* вставить данные из памяти в формате aFormat }
//#UC START# *4BBCB34C003A_48E3859101D5_var*
var
 l_BitmapReader : TevBitmapHandleReader;
 l_Format       : Tl3ClipboardFormat;
 l_Mem          : TObject;
 l_TagStorageW  : InevTagWriter;
 l_Loc          : InevLocation;
 l_Pool         : IStream;          
 l_OpPack       : InevOp;
//#UC END# *4BBCB34C003A_48E3859101D5_var*
begin
//#UC START# *4BBCB34C003A_48E3859101D5_impl*
 Result := false;
 l_Loc := f_Loc;
 l_TagStorageW := l_Loc.Obj.AsPara.DocumentContainer.TagWriter;
 if (l_TagStorageW <> nil) then
  try
   if (Processor = nil) then
    l_OpPack := nil
   else
    l_OpPack := Processor.StartOp(ev_msgInsertBlock);
   try
    if aNeedClearOld then
     Delete(ev_cmEmpty)
     {l_Loc := nil};
    if (aFormat = cf_RTFLite) then
     l_Format := cf_RTF
    else
     l_Format := aFormat;
    if (l_Format = cf_Bitmap) then
    begin
     l_BitmapReader := TevBitmapHandleReader.Create;
     try
      l_BitmapReader.Bitmap := aData;
      Result := true;
      l_TagStorageW.WriteTagEx(f_View, l_BitmapReader, l_Loc);
     finally
      l3Free(l_BitmapReader);
     end;{try..finally}
    end//l_Format = cf_Bitmap
    else
    begin
     if (l_Format = cf_Text) OR (l_Format = cf_OEMText) then
      l_Mem := Tl3HPCharStream.Create(aData)
     else
     if (l_Format = cf_hDrop) then
      l_Mem := Tl3MemoryPool.Make(aData)
     else
      l_Mem := Tl3HMemoryStream.Create(aData);
     try
      if Supports(l_Mem, IStream, l_Pool) then
       try
        Result := l_TagStorageW.WriteTag(f_View, aFormat, l_Pool, l_Loc);
       finally
        l_Pool := nil;
       end;//try..finally
     finally
      l3Free(l_Mem);
     end;//try..finally
    end;//l_Format = cf_Bitmap
   finally
    l_OpPack := nil;
   end;//try..finally
 finally
  l_TagStorageW := nil;
 end;//try..finally
//#UC END# *4BBCB34C003A_48E3859101D5_impl*
end;//TedRangeImplementation.InsertData

procedure TedRangeImplementation.InsertFrom(const aTextSource: InevTagReader;
 const aFilters: InevTagGenerator);
 {* вставить данные из другого источника текста }
//#UC START# *4BBCB36D03B8_48E3859101D5_var*
var
 l_MemoryPool : Tl3MemoryPool;
//#UC END# *4BBCB36D03B8_48E3859101D5_var*
begin
//#UC START# *4BBCB36D03B8_48E3859101D5_impl*
 l_MemoryPool := Tl3MemoryPool.Create;
 try
  aTextSource.ReadTag(cf_EverestBin, l_MemoryPool As IStream, aFilters);
  InsertData(cf_EverestBin, l_MemoryPool.AsHandle, true);
 finally
  l3Free(l_MemoryPool);
 end;//try..finally
//#UC END# *4BBCB36D03B8_48E3859101D5_impl*
end;//TedRangeImplementation.InsertFrom

function TedRangeImplementation.InsertString(const aSt: Tl3PCharLenPrim;
 aFormat: Tl3ClipboardFormat = cf_Text): Boolean;
 {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
//#UC START# *4BBCB38B00C2_48E3859101D5_var*
var
 l_Mem : Tl3ConstMemoryStream;
//#UC END# *4BBCB38B00C2_48E3859101D5_var*
begin
//#UC START# *4BBCB38B00C2_48E3859101D5_impl*
 l_Mem := Tl3ConstMemoryStream.Create(aSt.S, aSt.SLen);
 try
  Result := f_Loc.Text.Modify.InsertStream(f_View, l_Mem, aFormat, nil, evDefaultLoadFlags + [ev_lfInternal], aSt.SCodePage);
 finally
  l3Free(l_Mem);
 end;//try..finally
//#UC END# *4BBCB38B00C2_48E3859101D5_impl*
end;//TedRangeImplementation.InsertString

function TedRangeImplementation.InsertString(const aSt: AnsiString;
 aFormat: Tl3ClipboardFormat = cf_Text): Boolean;
 {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString('Hello world!');
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
//#UC START# *4BBCB3B2009F_48E3859101D5_var*
//#UC END# *4BBCB3B2009F_48E3859101D5_var*
begin
//#UC START# *4BBCB3B2009F_48E3859101D5_impl*
 Result := InsertString(l3PCharLen(aSt), aFormat);
//#UC END# *4BBCB3B2009F_48E3859101D5_impl*
end;//TedRangeImplementation.InsertString

function TedRangeImplementation.InsertParaBreak: Boolean;
 {* вставляет разрыв параграфов }
//#UC START# *4BBCB3D20184_48E3859101D5_var*
//#UC END# *4BBCB3D20184_48E3859101D5_var*
begin
//#UC START# *4BBCB3D20184_48E3859101D5_impl*
 Result := InsertString(cc_EOLStr);
//#UC END# *4BBCB3D20184_48E3859101D5_impl*
end;//TedRangeImplementation.InsertParaBreak

function TedRangeImplementation.DeleteChar: Boolean;
 {* удаляет текущий символ }
//#UC START# *4BBCB3EB003D_48E3859101D5_var*
var 
 l_OpPack : InevOp; 
//#UC END# *4BBCB3EB003D_48E3859101D5_var*
begin
//#UC START# *4BBCB3EB003D_48E3859101D5_impl*
 if (f_Loc.Text <> nil) then
  if (Processor = nil) then
  begin
   Assert(false);
   // - ибо всё равно дальше упадёт
   Result := f_Loc.Text.Modify.DeleteChar(f_View, false, nil);
  end//Processor = nil
  else
  begin
   l_OpPack := Processor.StartOp(ev_msgDeleteChar);
   try
    Result := f_Loc.Text.Modify.DeleteChar(f_View, False, l_OpPack);
   finally
    l_OpPack := nil;
   end//try..finally
  end//Processor = nil
 else
  Result := False;   
//#UC END# *4BBCB3EB003D_48E3859101D5_impl*
end;//TedRangeImplementation.DeleteChar

function TedRangeImplementation.Save(aFormat: Tl3ClipboardFormat;
 const outPool: IStream;
 const aFilters: InevTagGenerator;
 anInternal: Boolean = False;
 ChildrenOnly: Boolean = False): Boolean;
 {* сохранить выделение }
//#UC START# *4BBCB3FE033D_48E3859101D5_var*
var
 l_Block : InevRange;
 l_Flags : TevStoreFlags;
//#UC END# *4BBCB3FE033D_48E3859101D5_var*
begin
//#UC START# *4BBCB3FE033D_48E3859101D5_impl*
 l_Block := f_Loc.Range;
 if (l_Block = nil) then
  Result := false
 else
 begin
  if anInternal then
   l_Flags := evDefaultStoreFlags - [evd_sfStoreParaEnd] + [evd_sfInternal]
  else
   l_Flags := evDefaultStoreFlags - [evd_sfStoreParaEnd] - [evd_sfInternal];
  if ChildrenOnly then
   l_Flags := l_Flags + [evd_sfChildrenOnly]
  else
   l_Flags := l_Flags - [evd_sfChildrenOnly];
  Result := l_Block.Data.Store(aFormat, outPool, aFilters, l_Flags);
 end;//l_Block = nil
//#UC END# *4BBCB3FE033D_48E3859101D5_impl*
end;//TedRangeImplementation.Save

{$If NOT Defined(DesignTimeLibrary)}
class function TedRangeImplementation.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_48E3859101D5_var*
//#UC END# *47A6FEE600FC_48E3859101D5_var*
begin
//#UC START# *47A6FEE600FC_48E3859101D5_impl*
 Result := true;
//#UC END# *47A6FEE600FC_48E3859101D5_impl*
end;//TedRangeImplementation.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TedRangeImplementation.ClearFields;
begin
 f_TextParagraph := nil;
 f_View := nil;
 f_Loc := nil;
 inherited;
end;//TedRangeImplementation.ClearFields

end.
