unit evStyleInterfaceEx;

// Модуль: "w:\common\components\gui\Garant\Everest\evStyleInterfaceEx.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evStyleInterfaceEx" MUID: (4857EFDA01E5)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evStyleInterface
 , k2DocumentGenerator
 , nevInternalInterfaces
 , Classes
 , k2TagGen
;

type
 TevStyleInterfaceEx = class(TevStyleInterface)
  private
   f_ForExport: Boolean;
    {* Поле для свойства ForExport }
  protected
   function DoFinishAtom(G: Tk2DocumentGenerator;
    var Atom: Tk2StackAtom): Boolean;
   procedure InitFields; override;
  public
   procedure Load(const Reader: Tk2CustomReader); overload;
   procedure Load(S: TStream); overload;
   procedure Save(G: Tk2TagGenerator); overload;
   procedure Save(S: TStream;
    aBinary: Boolean = False); overload;
   procedure SaveCurrent(G: Tk2TagGenerator);
  public
   property ForExport: Boolean
    read f_ForExport
    write f_ForExport;
 end;//TevStyleInterfaceEx

var g_InCreateDocumentSchema: Boolean;

implementation

uses
 l3ImplUses
 , k2Dictionary
 , k2Tags
 , l3Variant
 , Style_Const
 , k2BaseTypes
 , evdStyles
 , Graphics
 , evOpProc
 , k2Context
 , nevBase
 , l3Base
 , l3Filer
 , evdNativeReader
 , StrUtils
 , k2Base
 , k2SimpleTagList
 , evStyleTableFontSizeCorrector
 , l3Types
 , k2NonOptimizeContext
 , evdNativeWriter
;

type
 Tk2DictionaryFriend = {abstract} class(Tk2Dictionary)
  {* Друг для Tk2Dictionary }
 end;//Tk2DictionaryFriend

 TevStyleTableGenerator = class(Tk2DocumentGenerator)
  private
   f_StyleTable: Tk2Dictionary;
 end;//TevStyleTableGenerator

function TevStyleInterfaceEx.DoFinishAtom(G: Tk2DocumentGenerator;
 var Atom: Tk2StackAtom): Boolean;
//#UC START# *55522C52008B_55522B5101D3_var*
{$IfDef Nemesis}
const
 cTagToKeep: array [0..10] of Integer =
  (k2_tiHandle, k2_tiStyle,
   k2_tiName, k2_tiShortName,
   //k2_tiLeftIndent, k2_tiFirstIndent, k2_tiRightIndent,
   k2_tiJustification,
   k2_tiLineSpacing, k2_tiHeaderHasOwnSpace,
   k2_tiApply2Para,
   k2_tiVisible,
   //k2_tiSpaceBefore, k2_tiSpaceAfter,
   {k2_tiIsChangeableFont,}
   // http://mdp.garant.ru/pages/viewpage.action?pageId=336142662
   // http://mdp.garant.ru/pages/viewpage.action?pageId=338463119
   // - теперь УМ это может настраивать
   k2_tiVisibleToUser{,
   k2_tiHeader, k2_tiFooter},
   k2_tiFrame);
{$Else Nemesis}
const
 cTagToKeep: array [0..7] of Integer =
  (k2_tiHandle,
   //k2_tiStyle,
   k2Tags.k2_tiName,
   k2_tiShortName,
   //k2_tiLeftIndent, k2_tiFirstIndent, k2_tiRightIndent,
   //k2_tiJustification,
   k2_tiLineSpacing, k2_tiHeaderHasOwnSpace,
   //k2_tiApply2Para,
   //k2_tiVisible,
   k2_tiSpaceBefore, k2_tiSpaceAfter{,
   k2_tiHeader, k2_tiFooter},
   k2_tiFrame);
{$EndIf Nemesis}
var
 l_Found: Tl3Variant;
 l_Prev: Tl3Variant;
 l_Index: Integer;
 l_TI: Integer;
 l_TTK: Integer;
//#UC END# *55522C52008B_55522B5101D3_var*
begin
//#UC START# *55522C52008B_55522B5101D3_impl*
 Result := True;
 if Atom.IsKindOf(k2_typStyle) then
 begin
  if (Atom.Box.IntA[k2_tiHandle] = -65528) then
   Exit;
  if not g_InCreateDocumentSchema AND
     Tk2DictionaryFriend(TevStyleTableGenerator(G).f_StyleTable).
      DoFindInsertionPlace(Atom.Box, l_Index) then
  begin
   l_Found := TevStyleTableGenerator(G).f_StyleTable.Items[l_Index];
   l_Prev := l_Found.CloneTag.AsObject;
   try
    l_Found.AssignTag(Atom.Box, k2_amAll, G.Context);
    for l_TI := Low(cTagToKeep) to High(cTagToKeep) do
    begin
     l_TTK := cTagToKeep[l_TI];
     if l_Prev.HasSubAtom(l_TTK) then
     begin
      if (l_TTK = k2_tiStyle) AND (l_Prev.IntA[l_TTK] = -1) then
       l_Found.AttrW[l_TTK, G.Context] := nil
      else
       l_Found.AttrW[l_TTK, G.Context] := l_Prev.Attr[l_TTK];
     end//l_Prev.HasSubAtom(cTagToKeep[l_TI])
     else
      l_Found.AttrW[l_TTK, G.Context] := nil;
    end;//for l_TI
    // - восстанавливает то, что в интерфейсе настроить невозможно
    if (l_Found.IntA[k2_tiHandle] = ev_saDialogs) then
     l_Found.cAtom(k2_tiFont).IntA[k2_tiBackColor] := clDefault;
    // - вставляем костыль от крывых ручек УМ 
   finally
    l_Prev := nil;
   end;//try..finally
  end//Tk2DictionaryHack(TevStyleTableGenerator(G).f_StyleTable)
  else
   TevStyleTableGenerator(G).f_StyleTable.Add(Atom.Box);
 end;//Atom.IsKindOf(k2_typStyle)
//#UC END# *55522C52008B_55522B5101D3_impl*
end;//TevStyleInterfaceEx.DoFinishAtom

procedure TevStyleInterfaceEx.Load(const Reader: Tk2CustomReader);
//#UC START# *55522CA900D2_55522B5101D3_var*
var
 G: TevStyleTableGenerator;
 OG: Ik2TagGenerator;
 VT: Tk2Dictionary;
 l_Processor: TevCustomUndoProcessor;
 l_Context: Tk2Context;
//#UC END# *55522CA900D2_55522B5101D3_var*
begin
//#UC START# *55522CA900D2_55522B5101D3_impl*
 VT := GetVT;
 if (VT <> nil) then
 begin
  Changing;
  try
   l_Processor := TevCustomUndoProcessor.Create;
   try
    l_Context := Tk2Context.Create(l_Processor);
    try
     OG := Reader.Generator;
     try
      InevOp(l_Context).InIOProcess := True;
      InevOp(l_Context).SaveUndo := False;
      InevOp(l_Context).DeleteMapped := False;
      InevOp(l_Context).Optimize := False;
      G := TevStyleTableGenerator.Create;
      try
       G.Context := l_Context;
       G.OnFinishAtom := DoFinishAtom;
       G.f_StyleTable := VT;
       Reader.Generator := G;
       Reader.Execute;
       G.f_StyleTable.Sort;
      finally
       l3Free(G);
      end;{try..finally}
     finally
      Reader.Generator := OG;
     end;{try..finally}
    finally
     l3Free(l_Context);
    end;{try..finally}
   finally
    l3Free(l_Processor);
   end;{try..finally}
  finally
   Changed;
  end;//try..finally
 end;{VT <> nil}
//#UC END# *55522CA900D2_55522B5101D3_impl*
end;//TevStyleInterfaceEx.Load

procedure TevStyleInterfaceEx.Load(S: TStream);
//#UC START# *55522CC50260_55522B5101D3_var*
var
 F: Tl3CustomFiler;
 R: TevdNativeReader;
//#UC END# *55522CC50260_55522B5101D3_var*
begin
//#UC START# *55522CC50260_55522B5101D3_impl*
 F := Tl3CustomFiler.Create;
 try
  F.Stream := S;
  R := TevdNativeReader.Create;
  try
   R.Filer := F;
   Load(R);
  finally
   l3Free(R);
  end;{try..finally}
 finally
  l3Free(F);
 end;{try..finally}
//#UC END# *55522CC50260_55522B5101D3_impl*
end;//TevStyleInterfaceEx.Load

procedure TevStyleInterfaceEx.Save(G: Tk2TagGenerator);
//#UC START# *55522CDE0277_55522B5101D3_var*
 procedure DoSave(G: Tk2TagGenerator);

  function SaveStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
  begin//SaveStyle
   if not ANSIStartsStr('Элемент №', aStyle.StrA[k2_tiName]) AND
      // - не выливаем автодобавленные стили
      (not ForExport OR aStyle.BoolA[k2_tiVisibleToUser])
      // - не выливаем стили "не попадающие в таблицу стилей"
      then
   begin
    G.StartChild(Tk2Type(aStyle^.TagType));
    try
     aStyle^.AsObject.WriteTag(G);
    finally
     G.Finish;
    end;//try..finally
   end;//not ANSIStartsStr('Элемент №', aStyle.StrA[k2_tiName])
   Result := True;
  end;//SaveStyle

 var
  VT1: Tk2SimpleTagList;

  function SortStyle(aStyle: Pl3Variant; Index: Integer): Boolean;
  var
   I: Integer;
   l_Style: Tl3Variant;
   l_Parent: Tl3Variant;
  begin//SortStyle
   I := VT1.Count;
   l_Style := aStyle^.AsObject;
   //l_Style := k2Tag(aStyle^);
   while l_Style.IsValid AND (VT1.IndexOf(l_Style) < 0) do
   begin
    VT1.Insert(I, l_Style);
    l_Parent := l_Style.Attr[k2_tiStyle];
    if l_Style.IsSame(l_Parent) then
     l_Style := k2NullTag
    else
     l_Style := l_Parent;
   end;//while l_Style.IsValid..
   Result := True;
  end;//SortStyle

 var
  VT: Tk2Dictionary;
  GSO: Boolean;
 begin//DoSave
  VT := GetVT;
  if (VT <> nil) then
  begin
   GSO := not G.StreamOpened;
   VT1 := Tk2SimpleTagList.Make;
   try
    VT.IterateAllF(l3L2IA(@SortStyle));
    if GSO then
     G.Start;
    try
     VT1.IterateAllF(l3L2IA(@SaveStyle));
    finally
     if GSO then
      G.Finish;
    end;//try..finally
   finally
    l3Free(VT1);
   end;//try..finally
  end;//VT <> nil
 end;//DoSave
var 
 l_G: TevStyleTableFontSizeCorrector;
 l_GSO: Boolean;
//#UC END# *55522CDE0277_55522B5101D3_var*
begin
//#UC START# *55522CDE0277_55522B5101D3_impl*
 if ForExport AND (Self.PrintAndExportFontSize > 0){Self.DocumentUseFixedFontForPrintAndExportSetting} then
 begin
  //assert(False, 'Недоделано');
  l_G := TevStyleTableFontSizeCorrector.Create;
  // !!! SetTo тут нельзя использовать, т.к. там проблемы с FakeStarts и лишним CloseStructure !!!
  try
   l_G.Start;
   try
    l_GSO := not G.StreamOpened;
    if l_GSO then G.Start;
    try
     l_G.Generator := G;
     try
      DoSave(l_G);
     finally
      l_G.Generator := nil;
     end;//try..finally
    finally
     if l_GSO then G.Finish;
    end;//try..finally
   finally
    l_G.Finish;
   end;//try..finally
  finally
   l3Free(l_G);
  end;//try..finally
 end//DocumentUseFixedFontForPrintAndExportSetting
 else
  DoSave(G);
//#UC END# *55522CDE0277_55522B5101D3_impl*
end;//TevStyleInterfaceEx.Save

procedure TevStyleInterfaceEx.Save(S: TStream;
 aBinary: Boolean = False);
//#UC START# *55522D1803AB_55522B5101D3_var*
var
 F: Tl3CustomFiler;
 W: TevdNativeWriter;
//#UC END# *55522D1803AB_55522B5101D3_var*
begin
//#UC START# *55522D1803AB_55522B5101D3_impl*
 F := Tl3CustomFiler.Create;
 try
  F.Mode := l3_fmWrite;
  F.Stream := S;
  try
   W := TevdNativeWriter.Create;
   try
    W.Filer := F;
    {$IfDef evdNeedEverestTxt}
    W.Binary := aBinary;
    {$EndIf evdNeedEverestTxt}
    W.Context := Tk2NonOptimizeContext.Instance;
    Save(W);
   finally
    l3Free(W);
   end;//try..finally
  finally
   F.Stream := nil;
  end;//try..finally
 finally
  l3Free(F);
 end;//try..finally
//#UC END# *55522D1803AB_55522B5101D3_impl*
end;//TevStyleInterfaceEx.Save

procedure TevStyleInterfaceEx.SaveCurrent(G: Tk2TagGenerator);
//#UC START# *55522D4500AB_55522B5101D3_var*
var
 GSO: Boolean;
//#UC END# *55522D4500AB_55522B5101D3_var*
begin
//#UC START# *55522D4500AB_55522B5101D3_impl*
 GSO := not G.StreamOpened;
 if GSO then
  G.Start;
 try
  G.StartChild(Tk2Type(Tag.TagType));
  try
   Tag.AsObject.WriteTag(G);
  finally
   G.Finish;
  end;{try..finally}
 finally
  if GSO then
   G.Finish;
 end;{try..finally}
//#UC END# *55522D4500AB_55522B5101D3_impl*
end;//TevStyleInterfaceEx.SaveCurrent

procedure TevStyleInterfaceEx.InitFields;
//#UC START# *47A042E100E2_55522B5101D3_var*
//#UC END# *47A042E100E2_55522B5101D3_var*
begin
//#UC START# *47A042E100E2_55522B5101D3_impl*
 inherited;
 f_ForExport := False;
//#UC END# *47A042E100E2_55522B5101D3_impl*
end;//TevStyleInterfaceEx.InitFields

end.
