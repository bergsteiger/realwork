unit nsChangesBetweenEditionsDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChangesBetweenEditions$Domain"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/ChangesBetweenEditions/nsChangesBetweenEditionsDocumentContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::ChangesBetweenEditions$Domain::ChangesBetweenEditionsImplementation::TnsChangesBetweenEditionsDocumentContainer
//
// Контейнер документа для ОИД
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
  DocumentUnit
  {$If defined(Nemesis)}
  ,
  eeDocumentContainer
  {$IfEnd} //Nemesis
  ,
  nevTools,
  ChangesBetweenEditionsInterfaces,
  l3Variant,
  DocumentInterfaces,
  F1TagDataProviderInterface,
  afwInterfaces,
  l3Interfaces,
  nevBase,
  k2Base,
  nevPrintableDocumentContainer,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _nsDocumentContainer_Parent_ = TeeDocumentContainer;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 _nsEditionsDecorationRules_Parent_ = _nsDocumentContainer_;
 {$Include w:\common\components\gui\Garant\Everest\nsEditionsDecorationRules.imp.pas}
 TnsChangesBetweenEditionsDocumentContainer = class(_nsEditionsDecorationRules_)
  {* Контейнер документа для ОИД }
 private
 // private fields
   f_DiffProvider : IDiffDocDataProvider;
   f_Data : InsChangesBetweenEditionsInfo;
   f_GettingDocumentCount : Integer;
 private
 // private methods
   function MakeDocument: Il3TagRef;
     {* Создаёт документ из данных, которые приехали с адаптера }
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   function ReplaceContainerInOwner(const aDocumentContainer: InevDocumentContainer): Boolean; override;
   function CanBePlacedInDocumentsCache: Boolean; override;
   function GetDocument: Tl3Tag; override;
   procedure AfterCreate(const aDocInfo: IdeDocInfo); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: InsChangesBetweenEditionsInfo); reintroduce;
   class function Make(const aData: InsChangesBetweenEditionsInfo): InevDocumentContainer; reintroduce;
     {* Сигнатура фабрики TnsChangesBetweenEditionsDocumentContainer.Make }
 end;//TnsChangesBetweenEditionsDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  k2SizedMemoryPool,
  l3BaseStream,
  k2RawData_Const,
  ComObj,
  l3Types,
  deDocInfo,
  Document_Const,
  TextPara_Const,
  k2Facade,
  k2Tags,
  nsTagString,
  Table_Const,
  TableRow_Const,
  TableCell_Const,
  l3MinMax,
  l3Defaults,
  nsStyleParser,
  evdStyles
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const
  {$IfEnd} //Nemesis
  ,
  BitmapPara_Const,
  l3Memory,
  l3Stream,
  Classes,
  SysUtils,
  nsIDocumentDataObject,
  nsDocumentPreview,
  nsHAFPainter,
  LoggingInterfaces,
  nsDocumentPrintEvent,
  DataAdapter,
  evdTypes,
  nsTypes,
  LeafPara_Const
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  afwFacade,
  evTextStyle_Const
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nsEditionsDecorationRules.imp.pas}

// start class TnsChangesBetweenEditionsDocumentContainer

function TnsChangesBetweenEditionsDocumentContainer.MakeDocument: Il3TagRef;
//#UC START# *4EA6BBFA01DF_4DDD0D92039C_var*

 function MakeLeafPara(const aData : TDiffDocPara; aStyleID : Integer): Il3TagRef;
 var
  l_T : Tl3Variant;
  l_S : TnsTagString;
  l_Stream : Tk2RawData;
  l_Read : Large;
  l_Written : Large;
  l_Position : Large;
  l_InStream : Tl3Stream;
 begin//MakeLeafPara
  if (k2.TypeTable.TypeByHandle[Integer(aData.rType)] = nil) then
  // - костыль, на случай приезжания мусора с сервера
   Result := k2_typTextPara.MakeTag
  else
(*  begin
   Result := nil;
   Exit;
  end;//k2.TypeTable[Integer(aData.rType)] = nil*)
   Result := k2.TypeTable.TypeByHandle[Integer(aData.rType)].MakeTag;
  l_T := Result.AsObject;
  try
   if (aData.rStyle <> nil) then
    TnsStyleParser.Parse(aData.rStyle, l_T);
   if (aStyleID <> 0) then
    l_T.IntA[k2_tiStyle] := aStyleID;
   if (l_T.IntA[k2_tiStyle] = ev_saChangesInfo) then
    l_T.BoolA[k2_tiCollapsed] := false;
   if (aData.rText <> nil) AND (aData.rText.GetLength > 0) then
   begin
    l_S := TnsTagString.Create(aData.rText);
    try
     l_T.AttrW[k2_tiText, nil] := l_S;
    finally
     FreeAndNil(l_S);
    end;//try..finally
   end;//aData.rText <> nil
   l_T.IntA[k2_tiHandle] := aData.rID;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=290267630
   // http://mdp.garant.ru/pages/viewpage.action?pageId=290267630&focusedCommentId=290952637#comment-290952637
   if l_T.IsKindOf(k2_typBitmapPara) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=303858634
   begin
    if (aData.rData <> nil) then
    begin
     l_Stream := nil{Tk2RawData.Create};
     try
(*      {$IfDef nsTest}
      Dec(g_IStreamCopyTo_Guard);
      try
      {$EndIf nsTest}*)
       l3IStream2Stream(aData.rData, TStream(l_InStream));
       try
        l_Stream := Tk2RawData.CreateFromIStream(l_InStream);
(*        OleCheck(IStream(l_InStream).Seek(0, STREAM_SEEK_SET, l_Position));
        IStream(l_InStream).CopyTo(l_Stream As IStream, High(Large), l_Read, l_Written);*)
       finally
        FreeAndNil(l_InStream);
       end;//try..finally
(*      {$IfDef nsTest}
      finally
       Inc(g_IStreamCopyTo_Guard);
      end;//try..finally
      {$EndIf nsTest}*)
       l_T.AttrW[k2_tiData, nil] := l_Stream;
     finally
      FreeAndNil(l_Stream);
     end;//try..finally
    end;//aData.rData <> nil
   end;//l_T.IsKindOf(k2_typBitmapPara)
  finally
   l_T := nil;
  end;//try..finally
 end;//MakeLeafPara

 function MakeCell(aRow : Tl3Variant): Il3TagRef;
 var
  l_TC : Tl3Tag;
 begin//MakeCell
  Result := k2_typTableCell.MakeTag;
  try
   l_TC := Result.AsObject;
   l_TC.IntA[k2_tiWidth] := def_inchPrintableWidth div 2;
   aRow.AddChild(l_TC);
  finally
   l_TC := nil;
  end;//try..finally
 end;//MakeCell

 procedure AddLeafToCont(aCont : Tl3Variant;
                         const aData : TDiffDocPara;
                         aStyleID    : Integer = 0);
 var
  l_LP : Il3TagRef;
 begin//AddLeafToCont
  l_LP := MakeLeafPara(aData, aStyleID);
  Assert(l_LP <> nil);
  if (l_LP <> nil) then
   try
    aCont.AddChild(l_LP.AsObject);
   finally
    l_LP := nil;
   end;//try..finally
 end;//AddLeafToCont

 procedure AddListToCont(aCont : Tl3Variant;
                         const aList : IDiffDocParaList;
                         const aStyles : array of Integer);
 var
  l_P : TDiffDocPara;
  l_Index : Integer;
  l_St    : Integer;
  l_Added : Boolean;
  l_EmptyTextPara : Tl3Variant;
 begin//AddListToCont
  l_Added := false;
  if (aList <> nil) then
  begin
   for l_Index := 0 to Pred(aList.Count) do
   begin
    aList.pm_GetItem(l_Index, l_P);
    try
     if (l_Index >= Low(aStyles)) AND (l_Index <= High(aStyles)) then
      l_St := aStyles[l_Index]
     else
      l_St := 0;
     AddLeafToCont(aCont, l_P, l_St);
     l_Added := true;
    finally
     Finalize(l_P);
    end;//try..finally
   end;//for l_Index
  end;//aList <> nil
  if not l_Added AND aCont.IsKindOf(k2_typTableCell) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=327826921
  begin
   //l_EmptyTextPara := k2_typTextPara.MakeTag;
   l_EmptyTextPara := Tk2Type(aCont.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
   try
    aCont.AddChild(l_EmptyTextPara);
   finally
    l_EmptyTextPara := nil;
   end;//try..finally
  end;//not l_Added..
 end;//AddListToCont

 procedure AddListToContWithFixedStyle(aCont : Tl3Variant;
                                       const aList : IDiffDocParaList;
                                       aStyle      : Integer);
 var
  l_P : TDiffDocPara;
  l_Index : Integer;
 begin//AddListToContWithFixedStyle
  if (aList <> nil) then
   for l_Index := 0 to Pred(aList.Count) do
   begin
    aList.pm_GetItem(l_Index, l_P);
    try
     AddLeafToCont(aCont, l_P, aStyle);
    finally
     Finalize(l_P);
    end;//try..finally
   end;//for l_Index
 end;//AddListToContWithFixedStyle

var
 l_D : Tl3Variant;
 l_L : IDiffDocParaList;
 l_P : TDiffDocPara;
 l_Index : Integer;
 l_Tb    : Tl3Variant;
 l_TR    : Tl3Variant;
 l_CB    : TChangedBlock;
 l_LeftDate : TDiffDocPara;
 l_RightDate : TDiffDocPara;
 l_LeftDateGot : Boolean;
 l_RightDateGot : Boolean;
//#UC END# *4EA6BBFA01DF_4DDD0D92039C_var*
begin
//#UC START# *4EA6BBFA01DF_4DDD0D92039C_impl*
 Assert(f_DocumentInfo <> nil);
 Assert(f_DocumentInfo.Doc <> nil);
 Assert(f_DiffProvider <> nil);
 Result := k2_typDocument.MakeTag;
 try
  l_D := Result.AsObject;
  l_D.IntA[k2_tiExternalHandle] := f_DocumentInfo.Doc.GetInternalId + 100000;
  // Ога. Гы-гы.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=570118754&focusedCommentId=620262032&#comment-620262032
  f_DiffProvider.GetHeaderParaList(l_L);
  try
   AddListToCont(l_D, l_L, [f1_saChanges1, ev_saTxtHeader1, f1_saChanges1, f1_saChanges2]);
  finally
   l_L := nil;
  end;//try..finally

  Finalize(l_LeftDate);
  l3FillChar(l_LeftDate, SizeOf(l_LeftDate));
  // - перестраховываемся
  l_LeftDateGot := f_DiffProvider.GetDateParaLeft(l_LeftDate);

  Finalize(l_RightDate);
  l3FillChar(l_RightDate, SizeOf(l_RightDate));
  // - перестраховываемся
  l_RightDateGot := f_DiffProvider.GetDateParaRight(l_RightDate);

  if l_LeftDateGot AND  l_RightDateGot then
  begin
   l_Tb := k2_typTable.MakeTag.AsObject;
   try
    l_TR := k2_typTableRow.MakeTag.AsObject;
    try
     AddLeafToCont(MakeCell(l_TR).AsObject, l_LeftDate, ev_saChangesInfo);
     AddLeafToCont(MakeCell(l_TR).AsObject, l_RightDate, ev_saChangesInfo);
     l_Tb.AddChild(l_TR.AsObject);
    finally
     l_TR := nil;
    end;//try..finally
    l_D.AddChild(l_Tb.AsObject);
   finally
    l_Tb := nil;
   end;//try..finally
  end//l_LeftDateGot AND l_RightDateGot
  else
  begin
   Assert(l_LeftDateGot = l_RightDateGot, 'http://mdp.garant.ru/pages/viewpage.action?pageId=281525453&focusedCommentId=336138971#comment-336138971');
  end;//l_LeftDateGot AND l_RightDateGot

  for l_Index := 0 to Pred(
                      Integer(f_DiffProvider.GetChangedBlockCount)
                      // http://mdp.garant.ru/pages/viewpage.action?pageId=294599509
                      ) do
  begin
   f_DiffProvider.GetChangedBlock(l_Index, l_CB);
   try
    AddListToContWithFixedStyle(l_D, l_CB.rHeader, ev_saTxtHeader1);
    l_Tb := k2_typTable.MakeTag.AsObject;
    try
     l_TR := k2_typTableRow.MakeTag.AsObject;
     try
      f_DiffProvider.GetRedactionNameLeft(l_P);
      AddLeafToCont(MakeCell(l_TR).AsObject, l_P);
      f_DiffProvider.GetRedactionNameRight(l_P);
      AddLeafToCont(MakeCell(l_TR).AsObject, l_P);
      l_Tb.AddChild(l_TR);
     finally
      l_TR := nil;
     end;//try..finally
     l_TR := k2_typTableRow.MakeTag.AsObject;
     try
      AddListToCont(MakeCell(l_TR).AsObject, l_CB.rLeftTextParaList, []);
      AddListToCont(MakeCell(l_TR).AsObject, l_CB.rRightTextParaList, []);
      l_Tb.AddChild(l_TR);
     finally
      l_TR := nil;
     end;//try..finally
     l_D.AddChild(l_Tb);
    finally
     l_Tb := nil;
    end;//try..finally
   finally
    Finalize(l_CB);
   end;//try..finally
  end;//for l_Index
  l_D.IntA[k2_tiAllChildrenCount] := Max(l_D.ChildrenCount, f_DiffProvider.GetAllLeafParaCount);
  Document := l_D;
 finally
  l_D := nil;
 end;//try..finally
//#UC END# *4EA6BBFA01DF_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.MakeDocument

constructor TnsChangesBetweenEditionsDocumentContainer.Create(const aData: InsChangesBetweenEditionsInfo);
//#UC START# *4DDD0E080101_4DDD0D92039C_var*
//#UC END# *4DDD0E080101_4DDD0D92039C_var*
begin
//#UC START# *4DDD0E080101_4DDD0D92039C_impl*
 f_Data := aData;
 f_DiffProvider := aData.DiffProvider;
 inherited Create(TdeDocInfo.Make(aData.RightEdition));
//#UC END# *4DDD0E080101_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.Create

class function TnsChangesBetweenEditionsDocumentContainer.Make(const aData: InsChangesBetweenEditionsInfo): InevDocumentContainer;
var
 l_Inst : TnsChangesBetweenEditionsDocumentContainer;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsChangesBetweenEditionsDocumentContainer.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4DDD0D92039C_var*
//#UC END# *47EA4E9002C6_4DDD0D92039C_var*
begin
//#UC START# *47EA4E9002C6_4DDD0D92039C_impl*
 inherited;
 f_DiffProvider := nil;
(* Assert(f_Data <> nil);
 f_DiffProvider := f_Data.DiffProvider;
 MakeDocument;*)
 // - вообще говоря тут это нельзя делать, т.к. TnsChangesBetweenEditionsInfo.FinishDataUpdate
 //   может придти позже и его данные - не сбросятся 
//#UC END# *47EA4E9002C6_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.FinishDataUpdate

function TnsChangesBetweenEditionsDocumentContainer.ReplaceContainerInOwner(const aDocumentContainer: InevDocumentContainer): Boolean;
//#UC START# *47F1024C0150_4DDD0D92039C_var*
//#UC END# *47F1024C0150_4DDD0D92039C_var*
begin
//#UC START# *47F1024C0150_4DDD0D92039C_impl*
 Result := inherited ReplaceContainerInOwner(aDocumentContainer);
 // - см. комментарии к TnsChangesBetweenEditionsDocumentContainer.CanBePlacedInDocumentsCache
//#UC END# *47F1024C0150_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.ReplaceContainerInOwner

function TnsChangesBetweenEditionsDocumentContainer.CanBePlacedInDocumentsCache: Boolean;
//#UC START# *47F10C6E0240_4DDD0D92039C_var*
//#UC END# *47F10C6E0240_4DDD0D92039C_var*
begin
//#UC START# *47F10C6E0240_4DDD0D92039C_impl*
 //Result := inherited CanBePlacedInDocumentsCache;
 Result := false;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=305962757
 // - на самом деле конечно - костыль, т.к. надо в TnevDocumentContainer.IsSame
 //   проверять ещё и класс контейнера,
 //   а в TnsChangesBetweenEditionsDocumentContainer.GetIsSame ещё и вторую редакцию
 //   если уж так захочется класть контейнеры ОИД в кеш документов.
 // !!! Хотя в кеш помещать может и придётся - для тех же нотификаций
//#UC END# *47F10C6E0240_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.CanBePlacedInDocumentsCache

function TnsChangesBetweenEditionsDocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4DDD0D92039C_var*
//#UC END# *47F27DA80172_4DDD0D92039C_var*
begin
//#UC START# *47F27DA80172_4DDD0D92039C_impl*
 Result := inherited GetDocument;
 if (Result = nil) then
 begin
  Assert(f_GettingDocumentCount = 0);
  Inc(f_GettingDocumentCount);
  try
   Assert(f_Data <> nil);
   if (f_DiffProvider = nil) then
    f_DiffProvider := f_Data.DiffProvider;
   Result := MakeDocument.AsObject;
  finally
   Dec(f_GettingDocumentCount);
  end;//try..finally
 end;//Result = nil
//#UC END# *47F27DA80172_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.GetDocument

procedure TnsChangesBetweenEditionsDocumentContainer.AfterCreate(const aDocInfo: IdeDocInfo);
//#UC START# *4B1FBF87020C_4DDD0D92039C_var*
//#UC END# *4B1FBF87020C_4DDD0D92039C_var*
begin
//#UC START# *4B1FBF87020C_4DDD0D92039C_impl*
 inherited;
 MakeDocument;
//#UC END# *4B1FBF87020C_4DDD0D92039C_impl*
end;//TnsChangesBetweenEditionsDocumentContainer.AfterCreate

procedure TnsChangesBetweenEditionsDocumentContainer.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_DiffProvider := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsChangesBetweenEditionsDocumentContainer.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.