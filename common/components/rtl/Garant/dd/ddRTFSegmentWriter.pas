unit ddRTFSegmentWriter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddRTFSegmentWriter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Writers::TddRTFSegmentWriter
//
// Предок, умеющий выливать сегменты.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddDocument,
  ddTextSegment,
  ddCharacterProperty,
  ddParagraphProperty,
  ddRTFProperties,
  ddTextParagraph,
  ddTextSegmentQueue
  ;

const
  { SegmentConsts }
 cnGarantMagicDocIDContant = 100000;
 subAlias = 'sub_';

type
 TddRTFSegmentWriter = class(TddDocumentGenerator)
  {* Предок, умеющий выливать сегменты. }
 private
 // private fields
   f_TextSegmentQueue : TddTextSegmentQueue;
   f_Host : AnsiString;
    {* Поле для свойства Host}
 private
 // private methods
   procedure CheckSegmentStart(const aPara: TddTextParagraph;
     const aSeg: TddTextSegment);
   procedure CheckSegmentFinish(const aSeg: TddTextSegment);
   procedure WriteSegmentObject(aSegment: TddTextSegment;
     aCHP: TddCharacterProperty);
 protected
 // protected methods
   procedure CheckFinishSegments(const aPara: TddTextParagraph;
     anIndex: Integer);
   function CheckObjectSegment(const aPara: TddTextParagraph;
     anIndex: Integer;
     const aStyle: TddStyleEntry): Boolean;
   procedure CheckStartSegments(const aPara: TddTextParagraph;
     anIndex: Integer);
   function Style2RTF(aStyle: TddStyleEntry;
     aBlockIndent: Integer;
     anIgnoreLeftIndent: Boolean): AnsiString; virtual; abstract;
   function CHP2RTF(aCHP: TddCharacterProperty;
     aParent: TddCharacterProperty;
     const WithStyle: Boolean = True): AnsiString; virtual; abstract;
   function DIffCHP2RTF(aCHP1: TddCharacterProperty;
     aCHP2: TddCharacterProperty): AnsiString; virtual; abstract;
   function PAP2RTF(aPAP: TddParagraphProperty;
     aBlockIndent: Integer;
     anIgnoreLeftIndent: Boolean;
     WithStyle: Boolean = True): AnsiString; virtual; abstract;
   procedure Init4Segments;
   procedure DeInit4Segments;
   procedure IncBracesCount(aValue: Integer;
     aWriteBarket: Boolean);
   procedure DecBracesCount(aValue: Integer);
   procedure WriteOpenBarket;
   procedure WriteCloseBarket;
 public
 // public properties
   property Host: AnsiString
     read f_Host
     write f_Host;
 end;//TddRTFSegmentWriter

implementation

uses
  ddTypes,
  SysUtils,
  evdTypes,
  l3Base,
  RTFtypes,
  ddPicture,
  l3Chars,
  ddPictureSegment,
  ddFormulaSegment,
  ddHyperlink,
  ddObjectSegment
  ;

// start class TddRTFSegmentWriter

procedure TddRTFSegmentWriter.CheckSegmentStart(const aPara: TddTextParagraph;
  const aSeg: TddTextSegment);
//#UC START# *52DCE0AA0066_52DCDD6201E9_var*
var
 l_DocID   : Integer;
 l_SubID   : Integer;
 l_TypeID  : Integer;
 l_Format  : AnsiString;
 l_SegCHP  : TddCharacterProperty;
 l_TmpCHP  : TddCharacterProperty;
 l_SegStyle: TddStyleEntry;
//#UC END# *52DCE0AA0066_52DCDD6201E9_var*
begin
//#UC START# *52DCE0AA0066_52DCDD6201E9_impl*
 if (aSeg <> nil) then
 begin
  if aSeg.CHP.Style <> propUndefined then
  begin
   l_Format := '';
   l_SegStyle := Document.StyleTable[aSeg.CHP.Style];
   if l_SegStyle <> nil then
   begin
    l_TmpCHP := TddCharacterProperty(aSeg.CHP.Diff(l_SegStyle.CHP));
    try
     if l_SegStyle.StyleDef = sdCharacter then
      l_Format := Style2RTF(l_SegStyle, propUndefined, False) + CHP2RTF(l_TmpCHP, nil, False)
     else
      l_Format := CHP2RTF(l_TmpCHP, nil, False);
    finally
     l3Free(l_TmpCHP);
    end;
   end; // if l_SegStyle <> nil then
  end // if aSeg.CHP.Style <> propUndefined then
  else //aSeg.Style <> propUndefined
  begin
   l_SegCHP:= TddCharacterProperty(aSeg.CHP.Diff(aPara.CHP));
   try
    l_Format := DiffCHP2RTF(l_SegCHP, aPara.CHP);
   finally
    l3Free(l_SegCHP);
   end;
  end;
  aSeg.Opened := True;
  if not aSeg.IsHyperlink then
  begin
   IncBracesCount(1, True);
   OutString(l_Format);
  end//not aSeg.IsHyperlink
  else
  begin
   l_Format:= Trim(l_Format);
   if not aSeg.URL.Empty then
   begin
    OutString(Format('{\field{\*\fldinst {HYPERLINK "%s"}}{\fldrslt {%s ',
                      [aSeg.URL.AsString, l_Format]));
    IncBracesCount(3, False);
   end // if not aSeg.URL.Empty then
   else
   if aSeg.TargetList.Count = 1 then // мультиссылки не нужны
   begin
    with aSeg.TargetList.First do
    begin
     l_DocID := DocID;
     l_SubID := SubID;
     l_TypeID := TypeID;
    end;//with TddHyperlinkTarget(aSeg.TargetList.Items[j])
    if ((l_DocID = ExtNumber) or
        (l_DocID = 0)) AND
       (l_TypeID <> CI_REF) then
    begin
     // внутренняя ссылка    
     OutString(Format('{\field{\*\fldinst {HYPERLINK \\l "%s%d"}}{\fldrslt {%s ',
                      [SubAlias, l_SubID,
                       l_Format]));
     IncBracesCount(3, False);
    end//l_DocID = ExtNumber..
    else
    if UseExternalLinks then
    begin
     // внешняя ссылка             garantF1://
     IncBracesCount(3, False);
     if Host <> '' then
      OutString(Format('{\field{\*\fldinst {HYPERLINK "%s/document?id=%d&sub=%d"}}{\fldrslt {%s ',
                      [Host,
                       l_DocID - cnGarantMagicDocIDContant,
                       l_SubID,
                       l_Format]))

     else
      OutString(Format('{\field{\*\fldinst {HYPERLINK "garantF1://%d.%d"}}{\fldrslt {%s ',
                      [l_DocID - cnGarantMagicDocIDContant,
                       l_SubID,
                       l_Format]));
    end;//UseExternalLinks
   end;// for j
  end;//not aSeg.IsHyperlink
 end;//aSeg <> nil
//#UC END# *52DCE0AA0066_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.CheckSegmentStart

procedure TddRTFSegmentWriter.CheckSegmentFinish(const aSeg: TddTextSegment);
//#UC START# *52DCE0D60200_52DCDD6201E9_var*
var
 l_DocID : Integer;
 l_SubID : Integer;
//#UC END# *52DCE0D60200_52DCDD6201E9_var*
begin
//#UC START# *52DCE0D60200_52DCDD6201E9_impl*
 if (aSeg <> nil) and (f_TextSegmentQueue.BraceCount > 0) then
 begin
  aSeg.Opened := False;
  if aSeg.IsHyperlink then
  begin
   if not aSeg.URL.Empty then
    DecBracesCount(3)
   else
   if aSeg.TargetList.Count = 1 then
   begin
    with aSeg.TargetList.First do
    begin
     l_DocID := DocID;
     l_SubID := SubID;
    end;//with TddHyperlinkTarget(aSeg.TargetList.Items[j])
    if (l_DocID = ExtNumber) or (l_DocID = 0) then
     DecBracesCount(3)
    else
    if UseExternalLinks then
     DecBracesCount(3)
   end;// for j
  end//aSeg.IsHyperlink
  else
   DecBracesCount(1);
 end;//aSeg <> nil..
//#UC END# *52DCE0D60200_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.CheckSegmentFinish

procedure TddRTFSegmentWriter.WriteSegmentObject(aSegment: TddTextSegment;
  aCHP: TddCharacterProperty);
//#UC START# *52DCF2D303E7_52DCDD6201E9_var*
//#UC END# *52DCF2D303E7_52DCDD6201E9_var*
begin
//#UC START# *52DCF2D303E7_52DCDD6201E9_impl*
 if aSegment is TddFormulaSegment then
 {$IFDEF nsTest}
  WriteFormula(aSegment, aCHP, False)
 {$ELSE}
  WriteFormula(aSegment, aCHP, True)
 {$ENDIF nsTest}
 else
  if aSegment is TddPictureSegment then
   WritePicture(aSegment.Data as TddPicture, False);
//#UC END# *52DCF2D303E7_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.WriteSegmentObject

procedure TddRTFSegmentWriter.CheckFinishSegments(const aPara: TddTextParagraph;
  anIndex: Integer);
//#UC START# *52DCDFF9033B_52DCDD6201E9_var*

 procedure lp_CheckNotClosed(aFirst, aLast: Integer);
 var
  j         : Integer;
  l_InnerSeg: TddTextSegment;
 begin
  for j := aFirst downto aLast do // Закоываем все следующие сегменты...
  begin
   l_InnerSeg := f_TextSegmentQueue[j];
   if not l_InnerSeg.Opened then Break;
   CheckSegmentFinish(l_InnerSeg);
  end; // for j := i + 1 to l_Count do
 end;

var
 i          : Integer;
 l_Seg      : TddTextSegment;
 l_Count    : Integer;
 l_NeedStart: Boolean;
//#UC END# *52DCDFF9033B_52DCDD6201E9_var*
begin
//#UC START# *52DCDFF9033B_52DCDD6201E9_impl*
 l_Count := f_TextSegmentQueue.Count - 1;
 i := l_Count;
 l_NeedStart := False;
 while i >= 0 do
 begin
  l_Seg := f_TextSegmentQueue[i];
  if not (l_Seg is TddObjectSegment) and (l_Seg.Stop = anIndex) then
  begin
   if i = l_Count then // Если сегмент - последний, то просто закрываем и удаляем из очереди сегментов...
    l_Seg := f_TextSegmentQueue.PopLast
   else
   begin
    lp_CheckNotClosed(l_Count, i + 1);
    l_NeedStart := True;
    l_Seg := f_TextSegmentQueue.Pop;
   end; // if i = l_Count then
   CheckSegmentFinish(l_Seg);
   Dec(l_Count);
  end; // if (l_Seg.SegmentType <> dd_segObject) and (l_Seg.Stop = i) then
  Dec(i);
 end; // for i := f_TextSegmentQueue.Count - 1 downto 0 do
 if l_NeedStart then
  for i := 0 to l_Count do
  begin
   l_Seg := f_TextSegmentQueue[i];
   if not l_Seg.Opened then
    CheckSegmentStart(aPara, l_Seg);
  end; // for i := 0 to l_Count do
//#UC END# *52DCDFF9033B_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.CheckFinishSegments

function TddRTFSegmentWriter.CheckObjectSegment(const aPara: TddTextParagraph;
  anIndex: Integer;
  const aStyle: TddStyleEntry): Boolean;
//#UC START# *52DCE03E037C_52DCDD6201E9_var*
var
 l_Seg: TddTextSegment;
 l_CHP: TddCharacterProperty;
//#UC END# *52DCE03E037C_52DCDD6201E9_var*
begin
//#UC START# *52DCE03E037C_52DCDD6201E9_impl*
 Result := aPara <> nil;
 if Result then
 begin
  l_Seg := aPara.ObjectByCharIndex(anIndex);
  Result := l_Seg <> nil;
  if Result then
  begin
   if f_TextSegmentQueue.BraceCount > 0 then
   begin
    l_CHP := TddCharacterProperty.Create;
    try
     if aStyle <> nil then
      l_CHP.MergeWith(aStyle.CHP)
     else
      l_CHP.MergeWith(aPara.CHP);
     l_CHP.MergeWith(aPara.PrevCHP(l_Seg));
     if (l_Seg.Data Is TddPicture) then
      TddPicture(l_Seg.Data).PAP.AssignFrom(aPara.PAP)
     else
      (l_Seg.Data As TddTextParagraph).PAP.AssignFrom(aPara.PAP);
     WriteSegmentObject(l_Seg, l_CHP);
    finally
     l3Free(l_CHP);
    end;
   end // if f_TextSegmentQueue.BraceCount > 0 then
   else
   begin
    l_CHP := l_Seg.CHP.Clone;
    try
     if aStyle <> nil then
      l_CHP.MergeWith(aStyle.CHP)
     else
      l_CHP.MergeWith(aPara.CHP);
     WriteSegmentObject(l_Seg, l_CHP);
    finally
     l3Free(l_CHP);
    end
   end
  end; // if Result then
 end; // if Result then
//#UC END# *52DCE03E037C_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.CheckObjectSegment

procedure TddRTFSegmentWriter.CheckStartSegments(const aPara: TddTextParagraph;
  anIndex: Integer);
//#UC START# *52DCE14F0228_52DCDD6201E9_var*

 procedure lp_StartSegment(const aSeg: TddTextSegment);
 begin
  CheckSegmentStart(aPara, aSeg);
  f_TextSegmentQueue.Push(aSeg);
 end; // lp_StartSegment 

var
 l_Seg      : TddTextSegment;
 l_Started  : Boolean;
 l_HyperLink: TddTextSegment;
//#UC END# *52DCE14F0228_52DCDD6201E9_var*
begin
//#UC START# *52DCE14F0228_52DCDD6201E9_impl*
 l_HyperLink := f_TextSegmentQueue.GetHyperlink;
 try
  l_Started := False;
  l_Seg := aPara.SegmentByCharIndex(anIndex);
  while l_Seg <> nil do
  begin
   if (l_HyperLink <> nil) and not l_Started then
   begin
    l_Started := True;
    CheckSegmentFinish(l_HyperLink);
   end; // if (l_HyperLink <> nil) and not l_Started then
   lp_StartSegment(l_Seg);
   l_Seg := aPara.SegmentByCharIndex(anIndex, False, l_Seg.Index);
  end; // while l_Seg <> nil do
  l_Seg := aPara.HyperlinkByCharIndex(anIndex);
  if l_Seg <> nil then
  begin
   Assert(l_HyperLink = nil);
   lp_StartSegment(l_Seg);
  end; // if l_Seg <> nil then
 finally
  if (l_HyperLink <> nil) and l_Started then
  begin
   f_TextSegmentQueue.MoveHyperlinkToBottom;
   CheckSegmentStart(aPara, l_HyperLink);
  end; // if (l_HyperLink <> nil) and l_Started then
 end;
//#UC END# *52DCE14F0228_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.CheckStartSegments

procedure TddRTFSegmentWriter.Init4Segments;
//#UC START# *52DCFF7B038B_52DCDD6201E9_var*
//#UC END# *52DCFF7B038B_52DCDD6201E9_var*
begin
//#UC START# *52DCFF7B038B_52DCDD6201E9_impl*
 f_TextSegmentQueue := TddTextSegmentQueue.Create;
//#UC END# *52DCFF7B038B_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.Init4Segments

procedure TddRTFSegmentWriter.DeInit4Segments;
//#UC START# *52DCFFB701C4_52DCDD6201E9_var*
var
 i: Integer;
//#UC END# *52DCFFB701C4_52DCDD6201E9_var*
begin
//#UC START# *52DCFFB701C4_52DCDD6201E9_impl*
 if (f_TextSegmentQueue <> nil) and (f_TextSegmentQueue.BraceCount > 0) then
  for i := 0 to f_TextSegmentQueue.Count - 1 do
   WriteCloseBarket;
 l3Free(f_TextSegmentQueue);
//#UC END# *52DCFFB701C4_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.DeInit4Segments

procedure TddRTFSegmentWriter.IncBracesCount(aValue: Integer;
  aWriteBarket: Boolean);
//#UC START# *52DD022F0118_52DCDD6201E9_var*
//#UC END# *52DD022F0118_52DCDD6201E9_var*
begin
//#UC START# *52DD022F0118_52DCDD6201E9_impl*
 f_TextSegmentQueue.IncBraceCount(aValue);
 if aWriteBarket then
  if aValue = 1 then
   WriteOpenBarket
  else
   Assert(aValue = 3);
//#UC END# *52DD022F0118_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.IncBracesCount

procedure TddRTFSegmentWriter.DecBracesCount(aValue: Integer);
//#UC START# *52DD02450254_52DCDD6201E9_var*
//#UC END# *52DD02450254_52DCDD6201E9_var*
begin
//#UC START# *52DD02450254_52DCDD6201E9_impl*
 f_TextSegmentQueue.DecBraceCount(aValue);
 if aValue = 1 then
  WriteCloseBarket
 else
  if aValue = 3 then
   OutString('}}}')
  else
   Assert(False);
//#UC END# *52DD02450254_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.DecBracesCount

procedure TddRTFSegmentWriter.WriteOpenBarket;
//#UC START# *542BBAE00125_52DCDD6201E9_var*
//#UC END# *542BBAE00125_52DCDD6201E9_var*
begin
//#UC START# *542BBAE00125_52DCDD6201E9_impl*
 OutString('{');
//#UC END# *542BBAE00125_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.WriteOpenBarket

procedure TddRTFSegmentWriter.WriteCloseBarket;
//#UC START# *542BBB020308_52DCDD6201E9_var*
//#UC END# *542BBB020308_52DCDD6201E9_var*
begin
//#UC START# *542BBB020308_52DCDD6201E9_impl*
 OutString('}');
//#UC END# *542BBB020308_52DCDD6201E9_impl*
end;//TddRTFSegmentWriter.WriteCloseBarket

end.