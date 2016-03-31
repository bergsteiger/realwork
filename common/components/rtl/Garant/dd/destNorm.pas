unit destNorm;

// Модуль: "w:\common\components\rtl\Garant\dd\destNorm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestNorm" MUID: (51D278280093)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddTypes
 , RTFtypes
 , ddTab
 , l3Base
 , l3Memory
 , ddDocumentAtom
 , ddTextParagraph
 , ddDocumentAtomList
 , ddTable
 , ddCellProperty
 , ddCharacterProperty
 , ddRTFState
 , ddParagraphProperty
 , ddRTFProperties
 , Graphics
 , ddPicture
 , l3Interfaces
 , ddCustomRTFReader
 , k2Interfaces
 , rtfListTable
;

type
 RdestNorm = class of TdestNorm;

 TdestNorm = class(TddRTFDestination)
  private
   f_BorderOwner: TddBorderOwner;
   f_CurBorderPart: TddBorderParts;
   f_TabEntry: TddTab;
   f_UnicodeBuffer: Tl3MemoryStream;
   f_LastShape: TddDocumentAtom;
   f_FirstShape: Integer;
   f_Paragraphs: TddDocumentAtomList;
   f_TextBuffer: Tl3String;
  private
   procedure AddTable(aLevel: Integer);
   function FindNestedLastTable: TddTable;
   procedure ApplyToCell(aWhat: TIProp;
    aValue: LongInt;
    aCEP: TddCellProperty);
   procedure ApplyToCHP(aWhat: TIProp;
    aValue: Integer;
    aCHP: TddCharacterProperty);
   procedure ApplyToFrame(aWhat: TIProp;
    aValue: LongInt;
    aState: TddRTFState);
   procedure ApplyToRow(aWhat: TIProp;
    aValue: LongInt;
    aState: TddRTFState);
   procedure ApplyToStyle(aWhat: TIProp;
    aValue: LongInt;
    aState: TddRTFState);
   procedure ApplyToTAB(aWhat: TIProp;
    aValue: LongInt;
    aPAP: TddParagraphProperty);
   procedure CorrectCharset(aCHP: TddCharacterProperty;
    aText: Tl3String);
   procedure FlushTextBuffer(aState: TddRTFState;
    aCheckCodePage: Boolean);
   procedure FlushUnicodeBuffer(aState: TddRTFState);
   procedure Unicode2Text;
   function GetLastTextParaOrCreateNew(aPAP: TddParagraphProperty;
    out aNewPara: Boolean): TddTextParagraph;
   procedure JoinPAPWithLastParaPAP(aPAP: TddParagraphProperty;
    aNeedClose: Boolean);
   function GetFirstTableWidth: Integer;
   function CheckAnsiChar(aText: AnsiChar;
    aState: TddRTFState): Boolean;
   procedure SimpleAddShape(aShape: TddDocumentAtom);
   function Try2CloseNestedTable(anItap: Integer): Boolean;
  protected
   function pm_GetLastAtom: TddDocumentAtom;
   function pm_GetLastParagraph: TddTextParagraph; virtual;
   function pm_GetParagraph(anIndex: Integer): TddDocumentAtom;
   procedure Try2AddTable(aLevel: Integer);
   procedure ApplyToPAP(What: TIProp;
    aValue: Integer;
    aPAP: TddParagraphProperty); virtual;
   procedure ApplyToSep(aWhat: TIProp;
    aValue: LongInt); virtual;
   function GetFontEvent(aFontID: Integer): TddFontEntry;
   function GetColor(aColorIndex: Integer): TColor;
   function InternalAddTextPara(aPAP: TddParagraphProperty): TddTextParagraph; virtual;
   procedure Try2ApplyParaProperty(aState: TddRTFState;
    aPara: TddTextParagraph;
    aWasPara: Boolean); virtual;
   procedure AddPageBreak(aSymbol: Integer); virtual;
   procedure AddFormula(const aTextPara: TddTextParagraph;
    const aFormulaText: Tl3WString);
   function CanAddTable: Boolean; virtual;
   function AddTextPara(aPAP: TddParagraphProperty): TddTextParagraph;
   function FindFootnoteSymbol(aState: TddRTFState;
    aSymbol: Integer): Boolean; virtual;
   procedure ParagraphsClear;
   procedure ClearTextBuffer;
   procedure AfterAddPara(const anAtom: TddDocumentAtom); virtual;
   procedure CloseTextPara(aPAP: TddParagraphProperty;
    aPara: TddTextParagraph); virtual;
   function InTable(aPAP: TddParagraphProperty): Boolean; virtual;
    {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
   procedure DeleteLastAtom(aPrev: Boolean);
   function Itap(aPAP: TddParagraphProperty): Integer; virtual;
    {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
   procedure DoAddTabStop(aPAP: TddParagraphProperty); virtual;
   function AddTextPara2Document: TddTextParagraph;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddPicture(aPicture: TddPicture;
    aState: TddRTFState;
    anAssign2Last: Boolean);
   procedure Append(aState: TddRTFState;
    aDest: TdestNorm;
    aInSamePara: Boolean = False);
   function BufferEmpty: Boolean;
   function LastTable(aCheckNested: Boolean): TddTable;
   procedure CheckBeforeWrite(aState: TddRTFState);
   procedure WriteOldStyleItemText(aState: TddRTFState;
    const aItemText: AnsiString);
    {* Поддержка добавления номера стиля из Word 6.0/95. Создает текстовый параграф, если нужно. }
   function GetTextBuffer(aState: TddRTFState): Tl3String;
    {* Получение TextBuffer буфера с проверкой UnicodeBuffer }
   procedure AfterClose(aNewDest: TddRTFDestination;
    aState: TddRTFState;
    aCHP: TddCharacterProperty);
   procedure AddShape(aState: TddRTFState;
    aShape: TddDocumentAtom);
   procedure AddFooterHyperlink(aState: TddRTFState);
   function AddParagraph(const anAtom: TddDocumentAtom): Integer;
   function GetParagraphsCount: Integer;
   procedure AddSub(aState: TddRTFState;
    const aText: Tl3String);
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
    aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
    aState: TddRTFState); override;
   procedure AddUnicodeChar(aText: Word;
    aState: TddRTFState); override;
   procedure ApplyProperty(propType: TPropType;
    What: TIProp;
    Value: LongInt;
    aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
   procedure ParseSymbol(Symbol: Integer;
    propType: TPropType;
    aState: TddRTFState); override;
   procedure Write(const aGenerator: Ik2TagGenerator); override;
   procedure WriteText(aText: Tl3String;
    aState: TddRTFState); override;
   function GetList(aListID: Integer;
    out aWasRestart: Boolean): TrtfList; override;
   function GetStyle(aStyleID: Integer): TddStyleEntry; override;
   procedure BeforeCloseParagraph(const aDocAtom: TObject;
    var aNewStyle: Integer); override;
   procedure FlushBuffer(aState: TddRTFState); override;
   function NextTextPara(const anCurrent: TObject): TObject; override;
  protected
   property TextBuffer: Tl3String
    read f_TextBuffer;
  public
   property LastAtom: TddDocumentAtom
    read pm_GetLastAtom;
   property LastParagraph: TddTextParagraph
    read pm_GetLastParagraph;
   property Paragraph[anIndex: Integer]: TddDocumentAtom
    read pm_GetParagraph;
 end;//TdestNorm

implementation

uses
 l3ImplUses
 , SysUtils
 , ddTableCell
 , ddTableRow
 , ddTextSegment
 , l3Chars
 , ddBreak
 , l3String
 , l3StringEx
 , l3Types
 , Windows
 , ddBorder
 , ddRTFConst
 , ddFormulaParagraph
 , ddFormulaSegment
 , ddRTFShape
 , Classes
;

function TdestNorm.pm_GetLastAtom: TddDocumentAtom;
//#UC START# *51E8D657026C_51D278280093get_var*
//#UC END# *51E8D657026C_51D278280093get_var*
begin
//#UC START# *51E8D657026C_51D278280093get_impl*
 if f_Paragraphs.Empty then
  Result := nil
 else
  Result := f_Paragraphs.Last;
//#UC END# *51E8D657026C_51D278280093get_impl*
end;//TdestNorm.pm_GetLastAtom

function TdestNorm.pm_GetLastParagraph: TddTextParagraph;
//#UC START# *51E8D68F0379_51D278280093get_var*
var
 l_Cell  : TddTableCell;
 l_Table : TddTable;
//#UC END# *51E8D68F0379_51D278280093get_var*
begin
//#UC START# *51E8D68F0379_51D278280093get_impl*
 Result := nil;
 if LastAtom <> nil then
 begin
  if LastAtom.IsTextPara then
   Result := TddTextParagraph(LastAtom)
  else
   if LastAtom.IsTable then
   begin
    l_Table := LastTable(True);
    if l_Table <> nil then
     Result := l_Table.LastParagraph;
   end;
  if (Result <> nil) and Result.Closed then
   Result := nil;
 end; // LastAtom <> nil
//#UC END# *51E8D68F0379_51D278280093get_impl*
end;//TdestNorm.pm_GetLastParagraph

function TdestNorm.pm_GetParagraph(anIndex: Integer): TddDocumentAtom;
//#UC START# *5624D6E90334_51D278280093get_var*
//#UC END# *5624D6E90334_51D278280093get_var*
begin
//#UC START# *5624D6E90334_51D278280093get_impl*
 if (f_Paragraphs.Count = 0) or (f_Paragraphs.Count <= anIndex) then
  Result := nil
 else
  Result := f_Paragraphs[anIndex];
//#UC END# *5624D6E90334_51D278280093get_impl*
end;//TdestNorm.pm_GetParagraph

procedure TdestNorm.AddTable(aLevel: Integer);
//#UC START# *51E8D1CA0328_51D278280093_var*
var
 l_Table   : TddTable;
 l_Nested  : Boolean;
 l_OutCell : TddTableCell;
 l_LastRow : TddTableRow;
 l_OutTable: TddTable;
//#UC END# *51E8D1CA0328_51D278280093_var*
begin
//#UC START# *51E8D1CA0328_51D278280093_impl*
 l_Nested := aLevel > 1;
 l_OutCell := nil;
 if l_Nested then
 begin
  l_OutTable := LastTable(True);
  if l_OutTable = nil then
  begin
   AddTable(aLevel - 1);
   l_OutTable := LastTable(True);
  end; // if l_OutTable = nil then
  l_OutTable.CheckLastRow(False);
  l_LastRow := l_OutTable.LastRow;
  l_OutCell := l_LastRow.GetLastNonClosedCellOrAddNew;
 end; // if l_Nested then
 l_Table := TddTable.Create(Self);
 try
  l_Table.Level := aLevel;
  if l_Nested and (l_OutCell <> nil) then
   l_OutCell.Add(l_Table, False)
  else
   AddParagraph(l_Table);
 finally
  FreeAndNil(l_Table);
 end;
//#UC END# *51E8D1CA0328_51D278280093_impl*
end;//TdestNorm.AddTable

procedure TdestNorm.Try2AddTable(aLevel: Integer);
//#UC START# *51E8D1F10328_51D278280093_var*
var
 l_LastTable : TddTable;
//#UC END# *51E8D1F10328_51D278280093_var*
begin
//#UC START# *51E8D1F10328_51D278280093_impl*
 if not CanAddTable then Exit;
 if (LastAtom = nil) or not LastAtom.IsTable then
  AddTable(aLevel);
 if aLevel > 1 then
 begin
  l_LastTable := FindNestedLastTable;
  if (l_LastTable = nil) or (l_LastTable.Level < aLevel) then
   AddTable(aLevel);
 end // if aLevel > 1 then
 else
  if LastAtom.Closed then
   AddTable(aLevel);
//#UC END# *51E8D1F10328_51D278280093_impl*
end;//TdestNorm.Try2AddTable

function TdestNorm.FindNestedLastTable: TddTable;
//#UC START# *51E8D21A020C_51D278280093_var*
var
 l_Cell      : TddTableCell;
 l_LastTable : TddTable;
 l_TableAtom : TddDocumentAtom;
//#UC END# *51E8D21A020C_51D278280093_var*
begin
//#UC START# *51E8D21A020C_51D278280093_impl*
 Result := nil;
 if (LastAtom.IsTable) then
 begin
  l_LastTable := LastTable(False);
  while l_LastTable <> nil do
  begin
   if l_LastTable.LastRow = nil then Break;
   l_Cell := l_LastTable.LastRow.LastCell;
   if l_Cell = nil then Break;
   l_TableAtom := l_Cell.LastTableAtom;
   if (l_TableAtom <> nil) and not l_TableAtom.Closed then
   begin
    l_LastTable := l_TableAtom as TddTable;
    Result := l_LastTable;
   end // if (l_TableAtom <> nil) and not l_TableAtom.Closed then
   else
    l_LastTable := nil;
  end; // while l_Cell <> nil do
 end; // if (LastAtom.AtomType = dd_docTable) then
//#UC END# *51E8D21A020C_51D278280093_impl*
end;//TdestNorm.FindNestedLastTable

procedure TdestNorm.ApplyToCell(aWhat: TIProp;
 aValue: LongInt;
 aCEP: TddCellProperty);
//#UC START# *51E8D23B01F6_51D278280093_var*
var
 l_CellClosed: Boolean;
 l_RowClosed: Boolean;
//#UC END# *51E8D23B01F6_51D278280093_var*
begin
//#UC START# *51E8D23B01F6_51D278280093_impl*
 if not CanAddTable then Exit;
 case aWhat of
  ipropWidth :
      begin
        aCEP.CellOffset := aValue;
        Try2AddTable(1);
        LastTable(True).ApplyCellProperty(aCEP, GetClearBorderType);
        aCep.Clear;
      end;{ipropWidth}
  ipropclwWidth: aCEP.CellWidth := aValue;
  ipropJust  :
        aCEP.CellJust := TddCellJust(aValue);
  ipropTop   :
     begin
       f_CurBorderPart := bpTop;
       f_BorderOwner := boCell;
     end;{ipropTop}
  ipropLeft  :
   begin
    f_CurBorderPart := bpLeft;
    f_BorderOwner := boCell;
   end;{ipropLeft}
  ipropBottom:
   begin
    f_CurBorderPart := bpBottom;
    f_BorderOwner := boCell;
   end;{ipropBottom}
  ipropRight :
   begin
    f_CurBorderPart := bpRight;
    f_BorderOwner := boCell;
   end;{ipropRight}
  ipropVMerged :
   if not aCEP.VMergeFirst then
    aCEP.VMerged := True;
  ipropVMergeFirst :
   begin
    aCEP.VMergeFirst := True;
   end;
  ipropMerged :
   if not aCEP.MergeFirst then
    aCEP.Merged := True;
  ipropMergedFirst : aCEP.MergeFirst := True;
  ipropColorB: aCEP.PatternBackColor:= GetColor(aValue - 1);
  ipropColorF: aCEP.PatternForeColor:= GetColor(aValue - 1);
 end;{case What}
//#UC END# *51E8D23B01F6_51D278280093_impl*
end;//TdestNorm.ApplyToCell

procedure TdestNorm.ApplyToCHP(aWhat: TIProp;
 aValue: Integer;
 aCHP: TddCharacterProperty);
//#UC START# *51E8D26202B2_51D278280093_var*
var
 l_Font: TddFontEntry;
//#UC END# *51E8D26202B2_51D278280093_var*
begin
//#UC START# *51E8D26202B2_51D278280093_impl*
 with aCHP do
 begin
  case aWhat of
    ipropAnime : ;
    ipropPos: Pos := TCharPosition(aValue);
    ipropHighlight : Highlight := GetColor(aValue - 1);
    ipropBold: Bold := ByteBool(aValue);
    ipropItalic: Italic := ByteBool(aValue);
    ipropUnderline : if not LongBool(aValue) then
                       Underline := utNone
                     else
                       Underline := TUnderline(aValue);
    iproPAnsiCharCaps : Caps := TddCharCapsType(aValue);
    ipropHidden  : Hidden := ByteBool(aValue);
    ipropDeleted : ;
    iproPAnsiCharScale : ;
    iproPAnsiCharpos: ;
    ipropNumber:
     begin
      FontNumber := aValue;
      l_Font:= GetFontEvent(FontNumber);
      if l_Font <> nil then
      begin
       FontName := l_Font.AsString;
       FontCharSet := l_Font.CharSet;
      end; // l_Font <> nil
     end; // ipropNumber
    ipropHeight: FontSize := aValue;
    ipropLang: Language := aValue;
    ipropColorF: FColor := GetColor(aValue - 1);
    ipropColorB: BColor := GetColor(aValue - 1);
    ipropStrikeout: Strikeout := ByteBool(aValue);
    ipropDefault: Clear;
  end;
 end;
//#UC END# *51E8D26202B2_51D278280093_impl*
end;//TdestNorm.ApplyToCHP

procedure TdestNorm.ApplyToFrame(aWhat: TIProp;
 aValue: LongInt;
 aState: TddRTFState);
//#UC START# *51E8D2B103DB_51D278280093_var*
var
 tmpBorder: TddBorder;
//#UC END# *51E8D2B103DB_51D278280093_var*
begin
//#UC START# *51E8D2B103DB_51D278280093_impl*
 { TODO : Нужно починить }
  case f_BorderOwner of
   boPara: tmpBorder := aState.PAP.Border;
   boRow : tmpBorder := aState.TAP.Border;
   boCell: tmpBorder := aState.CEP.Border
  else
   tmpBorder := nil;
  end;{case BorderOwner}
 if tmpBorder <> nil then
  case aWhat of
   ipropWidth: tmpBorder.FrameWidth[f_CurBorderPart] := aValue;
   ipropColorF: tmpBorder.FrameColor[f_CurBorderPart] := aValue;
   ipropLineType: tmpBorder.FrameType[f_CurBorderPart] := TddBorderType(aValue);
   ipropBrdrTbl: tmpBorder.Frames[f_CurBorderPart].Enable := False; // http://mdp.garant.ru/pages/viewpage.action?pageId=479402808
   ipropBrdrNil: tmpBorder.isFramed := False;
  end;{case What}
//#UC END# *51E8D2B103DB_51D278280093_impl*
end;//TdestNorm.ApplyToFrame

procedure TdestNorm.ApplyToPAP(What: TIProp;
 aValue: Integer;
 aPAP: TddParagraphProperty);
//#UC START# *51E8D2F90025_51D278280093_var*
var
 i         : Integer;
 l_LastAtom: TddDocumentAtom;
//#UC END# *51E8D2F90025_51D278280093_var*
begin
//#UC START# *51E8D2F90025_51D278280093_impl*
 with aPAP do
 begin
   case What of
     ipropLeft   : XaLeft := aValue;
     ipropFirst  : XaFirst := aValue;
     ipropRight  : XaRight := aValue;
     ipropBottom : After := aValue;
     ipropTop    : Before := aValue;
     ipropJust   : Just := TJust(aValue);
     ipropInTable: begin
                    InTable := True;
                    itap := 1; // Значения может не быть
                   end; 
     ipropBorderWhere:
       begin
         f_BorderOwner := boPara;   
         case TddBorderWhere(aValue) of
          bwTop: begin
                  f_CurBorderPart := bpTop;
                  Border.Frames[bpTop].Enable := True;
                 end;
          bwRight: begin
                    Border.Frames[bpRight].Enable := True;
                    f_CurBorderPart := bpRight;
                   end;
          bwBottom: begin
                     Border.Frames[bpBottom].Enable := True;
                     f_CurBorderPart := bpBottom;
                    end;
          bwLeft: begin
                   Border.Frames[bpLeft].Enable := True;
                   f_CurBorderPart := bpLeft;
                  end;
          bwHorizontal: Border.Frames[bpHorizontal].Enable := True;
          bwVertical: Border.Frames[bpVertical].Enable := True;
          bwBox:
            for i := ord(bpTop) to ord(bpRight) do
            begin
             Border.Frames[TddBorderParts(i)].Enable := True;
             Border.FrameWidth[TddBorderParts(i)] := 10;
             Border.FrameType[TddBorderParts(i)] := btSingleThick;
            end;
         end;    
       end;
     ipropDefault: Clear;
     ipropLs: ListItem := aValue;
     ipropilvl: ilvl := aValue;
     ipropitap: itap := aValue;
     ipropposx: begin
                 PosX := aValue;
                 if (f_LastShape <> nil) then
                 begin
                  f_LastShape.Closed := True;
                  f_LastShape := nil;
                 end; // if (f_LastShape <> nil) then
                end;
     ipropposy: PosY := aValue;
     ipropabsw: AbsW := aValue;
     ipropabsh: AbsH := -aValue;
   end; { case}
 end;
//#UC END# *51E8D2F90025_51D278280093_impl*
end;//TdestNorm.ApplyToPAP

procedure TdestNorm.ApplyToRow(aWhat: TIProp;
 aValue: LongInt;
 aState: TddRTFState);
//#UC START# *51E8D343020F_51D278280093_var*
var
 l_LastTable: TddTable;   
//#UC END# *51E8D343020F_51D278280093_var*
begin
//#UC START# *51E8D343020F_51D278280093_impl*
 if not CanAddTable then Exit;
 case aWhat of
  ipropFirst: aState.TAP.Gaph := aValue;
  ipropBorderWhere: f_CurBorderPart := TddBorderparts(aValue - 1);
  ipropLeft: aState.TAP.Left := aValue;
  iproptrwWidthA: aState.TAP.trwWidthA := aValue;
  iproptrwWidthB: aState.TAP.trwWidthB := aValue;
  iproptrftsWidthA: aState.TAP.trftsWidthA := TddRTFWidthUnits(aValue);
  iproptrftsWidthB: aState.TAP.trftsWidthB := TddRTFWidthUnits(aValue);
  ipropLast: aState.TAP.IsLastRow := True;
  ipropirow: aState.TAP.RowIndex := aValue;
  ipropDefault:
   begin
     aState.TAP.Clear;
     l_LastTable := LastTable(True);
     if l_LastTable <> nil then
      l_LastTable.ClearLastRow;
    end;
 end;{case What}
//#UC END# *51E8D343020F_51D278280093_impl*
end;//TdestNorm.ApplyToRow

procedure TdestNorm.ApplyToSep(aWhat: TIProp;
 aValue: LongInt);
//#UC START# *51E8D3A20193_51D278280093_var*
var
 l_A: TddDocumentAtom;
//#UC END# *51E8D3A20193_51D278280093_var*
begin
//#UC START# *51E8D3A20193_51D278280093_impl*
 l_A := LastAtom;
 if (l_A <> nil) and (l_A.IsBreak) then
 begin
  with TddBreak(l_A).SEP do
   case aWhat of
    ipropLandscape: Landscape := True;
    ipropWidth: xaPage := aValue;
    ipropHeight: YaPage := aValue;
    ipropLeft: xaLeft := aValue;
    ipropRight: xaRight := aValue;
    ipropTop: yaTop := aValue;
    ipropBottom: yaBottom := aValue;
   end;
 end;
//#UC END# *51E8D3A20193_51D278280093_impl*
end;//TdestNorm.ApplyToSep

procedure TdestNorm.ApplyToStyle(aWhat: TIProp;
 aValue: LongInt;
 aState: TddRTFState);
//#UC START# *51E8D3D10291_51D278280093_var*
//#UC END# *51E8D3D10291_51D278280093_var*
begin
//#UC START# *51E8D3D10291_51D278280093_impl*
 if aWhat = ipropParaStyle then
   aState.PAP.Style := aValue
 else
 if aWhat = iproPAnsiCharStyle then
  aState.CHP.Style := aValue;
//#UC END# *51E8D3D10291_51D278280093_impl*
end;//TdestNorm.ApplyToStyle

procedure TdestNorm.ApplyToTAB(aWhat: TIProp;
 aValue: LongInt;
 aPAP: TddParagraphProperty);
//#UC START# *51E8D4200232_51D278280093_var*
//#UC END# *51E8D4200232_51D278280093_var*
begin
//#UC START# *51E8D4200232_51D278280093_impl*
 if f_TabEntry = nil then
  f_TabEntry := TddTab.Create;
 case aWhat of
  ipropJust : f_TabEntry.Kind := TTabKind(aValue);
  ipropWidth:
   begin
    if aValue > 0 then
    begin
     f_TabEntry.TabPos := aValue;
     aPAP.TabList.Add(f_TabEntry);
     DoAddTabStop(aPAP);
    end; // if aValue > 0 then
    FreeAndNil(f_TabEntry);
   end;
  ipropTabBar:
   begin
    f_TabEntry.TabBar := aValue;
    f_TabEntry.Kind := tkNotDefined;
    aPAP.TabList.Add(f_TabEntry);
    FreeAndNil(f_TabEntry);
   end;
  ipropTabLead: f_TabEntry.TabLead := TTabLead(aValue);
 end;
//#UC END# *51E8D4200232_51D278280093_impl*
end;//TdestNorm.ApplyToTAB

function TdestNorm.GetFontEvent(aFontID: Integer): TddFontEntry;
//#UC START# *51E8D7880381_51D278280093_var*
//#UC END# *51E8D7880381_51D278280093_var*
begin
//#UC START# *51E8D7880381_51D278280093_impl*
 Result := f_CustomRTFReader.GetFonts(aFontID);
//#UC END# *51E8D7880381_51D278280093_impl*
end;//TdestNorm.GetFontEvent

function TdestNorm.GetColor(aColorIndex: Integer): TColor;
//#UC START# *51E8D7A401F0_51D278280093_var*
//#UC END# *51E8D7A401F0_51D278280093_var*
begin
//#UC START# *51E8D7A401F0_51D278280093_impl*
 Result := f_CustomRTFReader.ColorByIndex(aColorIndex);
//#UC END# *51E8D7A401F0_51D278280093_impl*
end;//TdestNorm.GetColor

function TdestNorm.InternalAddTextPara(aPAP: TddParagraphProperty): TddTextParagraph;
//#UC START# *51E8D7E60235_51D278280093_var*
var
 l_Table: TddTable;
//#UC END# *51E8D7E60235_51D278280093_var*
begin
//#UC START# *51E8D7E60235_51D278280093_impl*
 // Абзац может добавляться в документ или таблицу. Причем таблицы может и не быть
 if aPAP.InTable and CanAddTable then
 begin
  if not Try2CloseNestedTable(aPAP.itap) then
   if f_Paragraphs.Empty then
    AddTable(aPAP.itap)
   else
    Try2AddTable(aPAP.itap);
  l_Table := LastTable(True);
  Result := l_Table.AddParaWithCheckingRow(nil, False) as TddTextParagraph;
 end // aInTable
 else
  Result := AddTextPara2Document;
//#UC END# *51E8D7E60235_51D278280093_impl*
end;//TdestNorm.InternalAddTextPara

procedure TdestNorm.AddPicture(aPicture: TddPicture;
 aState: TddRTFState;
 anAssign2Last: Boolean);
//#UC START# *51E8D80401F5_51D278280093_var*
var
 l_Prop: TddParagraphProperty;

 function lp_GetPicture: TddPicture;
 begin
  Result := aPicture.Clone(l_Prop);
 end;

 procedure lp_CopyOrMovePicture;
 var
  l_Picture: TddPicture;
 begin
  if anAssign2Last then
  begin
   l_Picture := (f_Paragraphs.Last as TddPicture);
   l_Picture.PAP.AssignFrom(aState.PAP);
   l_Picture.Assign(aPicture);
  end // if aMove then
  else
  begin
   l_Picture := lp_GetPicture;
   try
    AddParagraph(l_Picture);
   finally
    FreeAndNil(l_Picture);
   end;
  end;
 end;

var
 l_P       : TddPicture;
 l_Cell    : TddTableCell;
 l_Table   : TddTable;
 l_TextPara: TddTextParagraph;
//#UC END# *51E8D80401F5_51D278280093_var*
begin
//#UC START# *51E8D80401F5_51D278280093_impl*
 l_P := nil;
 if aState = nil then
  l_Prop := nil
 else
  l_Prop := aState.PAP;
 try
  if LastAtom <> nil then
  begin
   if LastAtom.IsTextPara then
   begin
    if LastAtom.Closed then
     lp_CopyOrMovePicture
    else
    begin
     l_P := lp_GetPicture;
     LastParagraph.AddPicture(l_P, anAssign2Last);
    end
   end // if LastAtom.IsTextPara then
   else
   if LastAtom.IsTable then
   begin
    Try2AddTable(aState.PAP.itap);
    LastTable(True).AddPicture(aPicture, l_Prop, anAssign2Last);
   end // if LastAtom.IsTable then
   else
    if LastAtom is TddRTFShape then
     if LastAtom.Closed then
      lp_CopyOrMovePicture
     else
      (LastAtom as TddRTFShape).AddPicture(aPicture, aState)
    else
     if LastAtom.IsPicture and anAssign2Last then
      lp_CopyOrMovePicture;
  end // LastAtom <> nil
  else
   lp_CopyOrMovePicture;
 finally
  FreeAndNil(l_P);
 end;
//#UC END# *51E8D80401F5_51D278280093_impl*
end;//TdestNorm.AddPicture

procedure TdestNorm.Append(aState: TddRTFState;
 aDest: TdestNorm;
 aInSamePara: Boolean = False);
//#UC START# *51E8D8250134_51D278280093_var*

 procedure lp_AddTextPara(const aPara: TddTextParagraph);

  procedure lp_Try2AddSegmentWithURL;
  var
   l_Start       : Integer;
   l_AddHyperlink: Boolean;
  begin
   l_AddHyperlink := (aPara.SegmentCount = 1) and aPara.Segments[0].IsHyperlink and not aPara.Segments[0].URL.Empty;
   if l_AddHyperlink then
    l_Start := LastParagraph.Text.Len + 1;
   LastParagraph.AddText(aPara.Text);
   if l_AddHyperlink then
    LastParagraph.AddHyperlinkWithURL(l_Start, aPara.Segments[0].URL.AsString);
  end;

 var
  l_NewPara : TddTextParagraph;
 begin
  if aPara <> nil then
  begin
   if aInSamePara then
   begin
    if LastParagraph = nil then
    begin
     InternalAddTextPara(aState.PAP);
     LastParagraph.PAP := aState.PAP;
    end // LastParagraph = nil
    else
     FlushTextBuffer(aState, True);
    if (aPara.SegmentCount = 1) and (aPara.Segments[0] is TddFormulaSegment) then // Копирование формулы {Requestlink:591142760} из символа.
     AddFormula(LastParagraph, TddFormulaParagraph(aPara.Segments[0].Data).FormulaText.AsWStr)
    else
    begin
     LastParagraph.AddSegment(aPara.CHP, nil, False);
     lp_Try2AddSegmentWithURL;
     if aPara.Closed then
      CloseTextPara(aState.PAP, LastParagraph);
    end;
   end // aInSamePara
   else
   begin
    l_NewPara := TddTextParagraph.Create(Self);
    try
     l_NewPara.Assign(aPara);
     AddParagraph(l_NewPara);
     if aPara.Closed then
      CloseTextPara(aState.PAP, l_NewPara);
    finally
     FreeAndNil(l_NewPara);
    end;
   end; // not aInSamePara
  end; // aPara <> nil
 end;

 procedure lp_AppendRowPara(const aTable: TddTable);
 var
  k: Integer;
 begin
  for k := 0 to aTable.RowCount - 1 do
   lp_AddTextPara(aTable.Rows[k].LastCell.LastTextPara);
 end;

var
 i      : Integer;
 l_Para : TddTextParagraph;
//#UC END# *51E8D8250134_51D278280093_var*
begin
//#UC START# *51E8D8250134_51D278280093_impl*
 if aDest <> nil then
 begin
  for i:= 0 to aDest.f_Paragraphs.Hi do
  begin
   l_Para := nil;
   // Может приехать что угодно
   if aDest.Paragraph[i] is TddTextParagraph then
    l_Para := aDest.Paragraph[i] as TddTextParagraph
   else
   if (aDest.Paragraph[i] is TddTable) then
    lp_AppendRowPara(aDest.Paragraph[i] as TddTable);
   lp_AddTextPara(l_Para);
  end; // for i
 end; // aDest <> nil
//#UC END# *51E8D8250134_51D278280093_impl*
end;//TdestNorm.Append

function TdestNorm.BufferEmpty: Boolean;
//#UC START# *51E8D84900D6_51D278280093_var*
//#UC END# *51E8D84900D6_51D278280093_var*
begin
//#UC START# *51E8D84900D6_51D278280093_impl*
 Result:= f_TextBuffer.Empty and (f_UnicodeBuffer.Position = 0);
//#UC END# *51E8D84900D6_51D278280093_impl*
end;//TdestNorm.BufferEmpty

procedure TdestNorm.CorrectCharset(aCHP: TddCharacterProperty;
 aText: Tl3String);
//#UC START# *51E8D8870140_51D278280093_var*
type
  TCharsetEntry = record
    CodePage: Word;
    Charset: Byte;
  end;
  
const
  cnCharsetLast = 11;
  CharsetTable: array [1..cnCharsetLast] of TCharsetEntry =
   (
    (CodePage: CP_WesternWin; Charset: ANSI_CHARSET),
    (CodePage: CP_EastEurope; Charset: EASTEUROPE_CHARSET),
    (CodePage: CP_RussianWin; Charset: RUSSIAN_CHARSET),
    (CodePage: CP_OEM; Charset: OEM_CHARSET),
    (CodePage: CP_Greek; Charset: GREEK_CHARSET),
    (CodePage: CP_Turkish; Charset: TURKISH_CHARSET),
    (CodePage: CP_Hebrew; Charset: HEBREW_CHARSET),
    (CodePage: CP_Arabic; Charset: ARABIC_CHARSET),
    (CodePage: CP_Baltic; Charset: BALTIC_CHARSET),
    (CodePage: CP_Thai; Charset: THAI_CHARSET),
    (CodePage: CP_Shift_JIS; Charset: SHIFTJIS_CHARSET)
   );

var
 l_S       : Tl3String;
 l_Start   : Integer;
 l_CodePage: Integer;

 procedure lp_CheckStart(anIndex: Integer);
 begin
  if l_Start > -1 then
  begin
   l_S.Append(l3PCharLen(aText.St + l_Start, anIndex - l_Start, l_CodePage));
   l_Start := -1;
  end; // if l_Start > -1 then
 end;

var
 l_AddNextChar : Boolean;
 l_ChinaCharSet: Boolean;

const
 cnChinaID = #$84;
 cnUTF16ID = #$80;
 csWritableChars = cc_WhiteSpaceExt + [cc_Dot];
 
 procedure lp_Correct4China(aLen, aStart: Integer);
 var
  l_NewStr     : AnsiString;
  l_Length     : Integer;
  l_WideStr    : WideString;
  l_ConvertStr : Tl3PCharLen;
 begin
  l_Length := aLen;
  l_ConvertStr := l3PCharLen(aText.St + aStart, l_Length, l_CodePage);
  l_Length := l_Length div 2;
  SetLength(l_WideStr, l_Length);
  MultiByteToWideChar(l_CodePage, 0, l_ConvertStr.S, l_ConvertStr.SLen, PWideChar(l_WideStr), Length(l_WideStr));
  SetLength(l_NewStr, Length(l_WideStr));
  WideCharToMultiByte(CP_RussianWin, 0, PWideChar(l_WideStr), Length(l_WideStr), PAnsiChar(l_NewStr), Length(l_NewStr), nil, nil);
  l_S.Append(l3PCharLen(l_NewStr));
 end;

var
 i, j  : Integer;
 l_Char: AnsiChar;
//#UC END# *51E8D8870140_51D278280093_var*
begin
//#UC START# *51E8D8870140_51D278280093_impl*
 if (aCHP <> nil) AND (aCHP.FontCharSet <> High(aCHP.FontCharSet)) and (aText.Len > 0) then
 begin
  l_CodePage := CP_RussianWin;
  for i := Low(CharsetTable) to High(CharsetTable) do
   if (CharsetTable[I].CharSet = aCHP.FontCharSet) then
   begin
    l_CodePage := CharsetTable[I].CodePage;
    Break;
   end;//CharsetTable[I].CharSet = aCHP.FontCharSet
  if (l_CodePage = CP_RussianWin) then
   Exit;
  Assert(aText.CodePage <> CP_Unicode);  
  l_S := Tl3String.Create;
  try
   i := 0;
   l_AddNextChar := False;
   l_Start := -1;
   while (i < aText.Len) do
   begin
    l_Char := aText.Ch[i];
    if (l_Char > cnUTF16ID) and (aText.Ch[i] <> cc_SoftSpace) then
    begin
     lp_CheckStart(i);
     l_ChinaCharSet := aCHP.FontCharSet in [THAI_CHARSET, SHIFTJIS_CHARSET];
     j := i;
     while (i < aText.Len) AND
           (((l_Char > cnUTF16ID) or l_AddNextChar) and not (l_Char in csWritableChars)) do
     begin
      l_AddNextChar := l_ChinaCharSet and (l_Char = cnChinaID);
      Inc(i);
      l_Char := aText.Ch[i];
     end;//while aText.Ch[i] > #$80
     if l_ChinaCharSet then
      lp_Correct4China(i - j, j)
     else
      l_S.Append(l3PCharLen(aText.St + j, i - j, l_CodePage));
    end//(aText.Ch[i] > #$80) and not(aText.Ch[i] in [cc_SoftSpace])
    else
    begin
     if l_Start = -1 then
      l_Start := i;
     Inc(i);
    end;//(aText.Ch[i] > #$80) and not(aText.Ch[i] in [cc_SoftSpace])
   end;//i < aText.Len
   lp_CheckStart(i);
   aText.Assign(l_S);
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//(aCHP <> nil) AND (aCHP.FontCharSet <> High(aCHP.FontCharSet))
//#UC END# *51E8D8870140_51D278280093_impl*
end;//TdestNorm.CorrectCharset

procedure TdestNorm.FlushTextBuffer(aState: TddRTFState;
 aCheckCodePage: Boolean);
//#UC START# *51E8D8AA00D4_51D278280093_var*
//#UC END# *51E8D8AA00D4_51D278280093_var*
begin
//#UC START# *51E8D8AA00D4_51D278280093_impl*
 if not BufferEmpty and aCheckCodePage then
  CorrectCharset(aState.CHP, f_TextBuffer);
 WriteText(f_TextBuffer, aState);
 {$IFDEF Debug}
 if RDS = rdsShpTxt then
  l3System.Msg2Log('Shape Text');
 {$ENDIF}
//#UC END# *51E8D8AA00D4_51D278280093_impl*
end;//TdestNorm.FlushTextBuffer

procedure TdestNorm.FlushUnicodeBuffer(aState: TddRTFState);
//#UC START# *51E8D8CD0019_51D278280093_var*
//#UC END# *51E8D8CD0019_51D278280093_var*
begin
//#UC START# *51E8D8CD0019_51D278280093_impl*
 Unicode2Text;
 WriteText(f_TextBuffer, aState);
 ClearTextBuffer;
//#UC END# *51E8D8CD0019_51D278280093_impl*
end;//TdestNorm.FlushUnicodeBuffer

function TdestNorm.LastTable(aCheckNested: Boolean): TddTable;
//#UC START# *51E8D8F10076_51D278280093_var*
var
 l_NestedTable : TddTable;
//#UC END# *51E8D8F10076_51D278280093_var*
begin
//#UC START# *51E8D8F10076_51D278280093_impl*
 Result := nil;
 if (LastAtom <> nil) and LastAtom.IsTable and not LastAtom.Closed then
  Result := TddTable(LastAtom);
 if aCheckNested and (Result <> nil) then
 begin
  l_NestedTable := FindNestedLastTable;
  if l_NestedTable <> nil then
   Result := l_NestedTable;
 end; // if aNested and (Result <> nil) then
//#UC END# *51E8D8F10076_51D278280093_impl*
end;//TdestNorm.LastTable

procedure TdestNorm.Unicode2Text;
//#UC START# *51E8D9130134_51D278280093_var*
var
 l_Str : Tl3Str;
 aSt   : Tl3PCharLen;
 l_Ansi: Boolean;
//#UC END# *51E8D9130134_51D278280093_var*
begin
//#UC START# *51E8D9130134_51D278280093_impl*
 l_Ansi := False;
 aSt := l3PCharLen(f_UnicodeBuffer.MemoryPool.AsPointer, f_UnicodeBuffer.Position div 2, cp_Unicode);
 l_Str.Init(aSt, CP_OEM); // - здесь CP_то что надо
 try
  if l3CharSetPresent(l_Str.S, l_Str.SLen, cc_Graph_Criteria) then
  // Преобразовываем в строку
    f_TextBuffer.AsPCharLen := l_Str
  else
   l_Ansi := True;
 finally
  l_Str.Clear;
 end;{try..finally}
 if l_Ansi then
 begin
  try
   f_TextBuffer.AsPCharLen := aSt;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=585129079
(*   {$IFDEF HasTatar}
   if not l3HasTatar(PWideChar(aSt.S)) then
   {$ENDIF}
   begin
    l_Str.Init(aSt, CP_ANSI); // - здесь CP_то что надо
    try
     f_TextBuffer.AsPCharLen := l_Str;
    finally
     l_Str.Clear;
    end;{try..finally}
   end
   {$IFDEF HasTatar}
   else
    f_TextBuffer.AsPCharLen := aSt;
   {$ENDIF}*)
  except
   f_TextBuffer.AsString := 'unknown';
  end;
 end;
 f_UnicodeBuffer.Size := 0;
 f_UnicodeBuffer.Position := 0;
//#UC END# *51E8D9130134_51D278280093_impl*
end;//TdestNorm.Unicode2Text

function TdestNorm.GetLastTextParaOrCreateNew(aPAP: TddParagraphProperty;
 out aNewPara: Boolean): TddTextParagraph;
//#UC START# *51E93A240331_51D278280093_var*
//#UC END# *51E93A240331_51D278280093_var*
begin
//#UC START# *51E93A240331_51D278280093_impl*
 aNewPara := False;
 Result := LastParagraph;
 if Result = nil then
 begin
  Result := AddTextPara(aPAP);
  aNewPara := True;
 end; // if Result = nil then
//#UC END# *51E93A240331_51D278280093_impl*
end;//TdestNorm.GetLastTextParaOrCreateNew

procedure TdestNorm.JoinPAPWithLastParaPAP(aPAP: TddParagraphProperty;
 aNeedClose: Boolean);
//#UC START# *51E93F26033C_51D278280093_var*
var
 l_Para   : TddTextParagraph;
 l_NewPara: Boolean;
//#UC END# *51E93F26033C_51D278280093_var*
begin
//#UC START# *51E93F26033C_51D278280093_impl*
 l_Para := GetLastTextParaOrCreateNew(aPAP, l_NewPara);
 if l_Para.PAP.IsDefault and (l_Para.PAP.OCompare(aPAP) <> 0) then
  l_Para.PAP.JoinWith(aPAP);
 if aNeedClose then
  CloseTextPara(aPAP, l_Para);
//#UC END# *51E93F26033C_51D278280093_impl*
end;//TdestNorm.JoinPAPWithLastParaPAP

procedure TdestNorm.Try2ApplyParaProperty(aState: TddRTFState;
 aPara: TddTextParagraph;
 aWasPara: Boolean);
//#UC START# *521B22240197_51D278280093_var*
//#UC END# *521B22240197_51D278280093_var*
begin
//#UC START# *521B22240197_51D278280093_impl*
 if aPara.Empty then
 begin
  aPara.PAP.IsDefault := True;
  aPara.ApplyPAP(aState.PAP);
  aPara.ApplyCHP(aState.CHP);
  if aWasPara and aState.CHP.Bold <> aPara.CHP.Bold then // Создали параграф давно, но State уже поменялось: http://mdp.garant.ru/pages/viewpage.action?pageId=538546220
   aPara.CHP.Bold := aState.CHP.Bold;
  if aState.PAP.anInherited and (aState.CHP.FontNumber <> propUndefined) then
   aPara.PAP.Style := 0; // http://mdp.garant.ru/pages/viewpage.action?pageId=479402974
 end; // LastParagraph.Empty
//#UC END# *521B22240197_51D278280093_impl*
end;//TdestNorm.Try2ApplyParaProperty

procedure TdestNorm.CheckBeforeWrite(aState: TddRTFState);
//#UC START# *52369DF0015C_51D278280093_var*
var
 l_Width : Integer;
 l_Table : TddTable;
//#UC END# *52369DF0015C_51D278280093_var*
begin
//#UC START# *52369DF0015C_51D278280093_impl*
 l_Table := LastTable(True);
 l_Width := GetFirstTableWidth;
 while l_Table <> nil do
 begin
  l_Table.Try2CloseNotClosedRow(l_Width);
  l_Table := LastTable(True);
 end; // while l_Table <> nil do
//#UC END# *52369DF0015C_51D278280093_impl*
end;//TdestNorm.CheckBeforeWrite

function TdestNorm.GetFirstTableWidth: Integer;
//#UC START# *5236EAA9015B_51D278280093_var*
var
 i       : Integer;
 l_Atom  : TddDocumentAtom;
 l_Count : Integer;
//#UC END# *5236EAA9015B_51D278280093_var*
begin
//#UC START# *5236EAA9015B_51D278280093_impl*
 Result := 0;
 l_Count := f_Paragraphs.Count - 1;
 for i := 0 to l_Count do
 begin
  l_Atom := f_Paragraphs[i];
  if l_Atom is TddTable then
  begin
   Result := (l_Atom as TddTable).GetFirstRowWidth;
   Break;
  end; // if l_Atom is TddTable then
 end; // for i := 0 to l_Count - 1 do
//#UC END# *5236EAA9015B_51D278280093_impl*
end;//TdestNorm.GetFirstTableWidth

procedure TdestNorm.WriteOldStyleItemText(aState: TddRTFState;
 const aItemText: AnsiString);
 {* Поддержка добавления номера стиля из Word 6.0/95. Создает текстовый параграф, если нужно. }
//#UC START# *53857DBD01C4_51D278280093_var*
var
 l_NewPara: Boolean;
 l_TextPara : TddTextParagraph;
//#UC END# *53857DBD01C4_51D278280093_var*
begin
//#UC START# *53857DBD01C4_51D278280093_impl*
 l_TextPara := GetLastTextParaOrCreateNew(aState.PAP, l_NewPara);
 l_TextPara.AddItemText(aItemText);
//#UC END# *53857DBD01C4_51D278280093_impl*
end;//TdestNorm.WriteOldStyleItemText

procedure TdestNorm.AddPageBreak(aSymbol: Integer);
//#UC START# *5385C5C802D5_51D278280093_var*
var
 l_Table : TddTable;

 function lp_SingleCell: Boolean;
 begin
  Result := (l_Table <> nil) and (l_Table.RowCount = 1) and (l_Table.Rows[0].CellCount = 1)
 end;

var
 l_Index : Integer;
 l_Break : TddBreak;
//#UC END# *5385C5C802D5_51D278280093_var*
begin
//#UC START# *5385C5C802D5_51D278280093_impl*
 l_Table := LastTable(True);
 if lp_SingleCell then Exit; // Для таблиц с одиной ячейкой, игнорируем разрывы.
 l_Break := TddBreak.Create(Self);
 try
  l_Break.BreakType := TddBreakType(aSymbol);
  if (l_Table <> nil) and not l_Table.Closed then
  begin
   if (f_Paragraphs.Count > 1) then
    l_Index := f_Paragraphs.Count - 2
   else
    l_Index := 0;
   f_Paragraphs.Insert(l_Index, l_Break)
  end // if (l_Table <> nil) and not l_Table.IsTableCorrect then
  else
   AddParagraph(l_Break);
 finally
  FreeAndNil(l_Break);
 end;
//#UC END# *5385C5C802D5_51D278280093_impl*
end;//TdestNorm.AddPageBreak

function TdestNorm.GetTextBuffer(aState: TddRTFState): Tl3String;
 {* Получение TextBuffer буфера с проверкой UnicodeBuffer }
//#UC START# *54E3108D02E5_51D278280093_var*
//#UC END# *54E3108D02E5_51D278280093_var*
begin
//#UC START# *54E3108D02E5_51D278280093_impl*
 if f_TextBuffer.Empty then
  Unicode2Text
 else
  CorrectCharset(aState.CHP, f_TextBuffer);
 Result := f_TextBuffer;
//#UC END# *54E3108D02E5_51D278280093_impl*
end;//TdestNorm.GetTextBuffer

procedure TdestNorm.AfterClose(aNewDest: TddRTFDestination;
 aState: TddRTFState;
 aCHP: TddCharacterProperty);
//#UC START# *54E468E502A2_51D278280093_var*
//#UC END# *54E468E502A2_51D278280093_var*
begin
//#UC START# *54E468E502A2_51D278280093_impl*
 if (Self.RDS = aNewDest.RDS) and (RDS in CollectibleRDS) then
 begin
  if not BufferEmpty then
   FlushTextBuffer(aState, True)                 
  else
  if (LastParagraph <> nil) then
   LastParagraph.ApplyCHP(aCHP);
 end; // if (l_OldRDS = l_NewRDS) and (RDS in CollectibleRDS) then
 if not BufferEmpty then
 begin
  WriteText(RDS, GetTextBuffer(aState), aState);
  ClearTextBuffer
 end;
//#UC END# *54E468E502A2_51D278280093_impl*
end;//TdestNorm.AfterClose

function TdestNorm.CheckAnsiChar(aText: AnsiChar;
 aState: TddRTFState): Boolean;
//#UC START# *54F83A430171_51D278280093_var*
var
 l_TextPara: TddTextParagraph;
//#UC END# *54F83A430171_51D278280093_var*
begin
//#UC START# *54F83A430171_51D278280093_impl*
 Result := False;
 if aText = cc_PlusMinus then
 begin
  l_TextPara := LastParagraph;
  if (l_TextPara <> nil) and not l_TextPara.Closed then
  begin
   FlushTextBuffer(aState, False);
   AddFormula(l_TextPara, csFormulaRepresent[carCharID2FormualRepresent[cc_PlusMinus]]);
   Result := True;
  end; // if (l_TextPara <> nil) and not l_TextPara.Closed then
 end; // if aText = cc_PlusMinus then
//#UC END# *54F83A430171_51D278280093_impl*
end;//TdestNorm.CheckAnsiChar

procedure TdestNorm.AddFormula(const aTextPara: TddTextParagraph;
 const aFormulaText: Tl3WString);
//#UC START# *550BDE5C0161_51D278280093_var*
var
 l_Formula : TddFormulaParagraph;
//#UC END# *550BDE5C0161_51D278280093_var*
begin
//#UC START# *550BDE5C0161_51D278280093_impl*
 l_Formula := TddFormulaParagraph.Create(Self);
 try
  l_Formula.Text.Append(aFormulaText);
  aTextPara.AddFormula(l_Formula);
 finally
  FreeAndNil(l_Formula);
 end;
//#UC END# *550BDE5C0161_51D278280093_impl*
end;//TdestNorm.AddFormula

function TdestNorm.CanAddTable: Boolean;
//#UC START# *559516AA0098_51D278280093_var*
//#UC END# *559516AA0098_51D278280093_var*
begin
//#UC START# *559516AA0098_51D278280093_impl*
 Result := True;
//#UC END# *559516AA0098_51D278280093_impl*
end;//TdestNorm.CanAddTable

procedure TdestNorm.AddShape(aState: TddRTFState;
 aShape: TddDocumentAtom);
//#UC START# *559652250144_51D278280093_var*
//#UC END# *559652250144_51D278280093_var*
begin
//#UC START# *559652250144_51D278280093_impl*
 if InTable(aState.PAP) and CanAddTable then
 begin
  if f_Paragraphs.Empty then
   AddTable(aState.PAP.itap)
  else
   Try2AddTable(aState.PAP.itap);
  LastTable(True).AddParaWithCheckingRow(aShape, False);
 end // aInTable
 else
  SimpleAddShape(aShape);
//#UC END# *559652250144_51D278280093_impl*
end;//TdestNorm.AddShape

procedure TdestNorm.SimpleAddShape(aShape: TddDocumentAtom);
//#UC START# *55C4750C02BF_51D278280093_var*

 function lp_CheckPos: Integer;
 var
  l_Atom    : TddDocumentAtom;
  l_Index   : Integer;
  l_NewShape: TddRTFShape;
 begin
  Result := -1;
  if f_FirstShape = -1 then Exit;
  l_Index := f_Paragraphs.Count - 1;
  l_NewShape := aShape as TddRTFShape;
  while l_Index >= f_FirstShape do
  begin
   l_Atom := f_Paragraphs[l_Index];
   if not (l_Atom is TddRTFShape) then Break;
   if (l_Atom as TddRTFShape).BottomAndRight(l_NewShape) then
    Result := l_Index
   else
    Break;
   Dec(l_Index);
  end; // while l_Index >= 0 do
 end;

var
 l_Pos       : Integer;
 l_ShapeIndex: Integer;
//#UC END# *55C4750C02BF_51D278280093_var*
begin
//#UC START# *55C4750C02BF_51D278280093_impl*
 l_Pos := lp_CheckPos;
 if l_Pos = -1 then
 begin
  l_ShapeIndex := AddParagraph(aShape);
  if f_FirstShape = -1 then
   f_FirstShape := l_ShapeIndex;
 end // if l_Pos = -1 then
 else
  f_Paragraphs.Insert(l_Pos, aShape)
//#UC END# *55C4750C02BF_51D278280093_impl*
end;//TdestNorm.SimpleAddShape

function TdestNorm.AddTextPara(aPAP: TddParagraphProperty): TddTextParagraph;
//#UC START# *55C4754B00B7_51D278280093_var*

 procedure lp_AddShape;

  function lp_ClearUndef(aValue: Integer): Integer;
  begin
   if aValue = propUndefined then
    Result := 0
   else
    Result := aValue;
  end;
  
 var
  l_Shape: TddRTFShape;
 begin
  l_Shape := TddRTFShape.Create(Self);
  try
   l_Shape.Left := aPAP.PosX;
   l_Shape.Top := aPAP.PosY;
   l_Shape.Right := l_Shape.Left + lp_ClearUndef(aPAP.AbsW);
   l_Shape.Bottom := l_Shape.Top + lp_ClearUndef(aPAP.AbsH);
   Result := l_Shape.AddTextPara;
   f_LastShape := l_Shape;
   SimpleAddShape(l_Shape);
  finally
   FreeAndNil(l_Shape);
  end;
 end;

var
 l_Shape   : TddRTFShape;
 l_LastAtom: TddDocumentAtom;
//#UC END# *55C4754B00B7_51D278280093_var*
begin
//#UC START# *55C4754B00B7_51D278280093_impl*
 if InTable(aPAP) or (aPAP.PosY = propUndefined) or (aPAP.PosX = propUndefined) then
  Result := InternalAddTextPara(aPAP)
 else
  begin
   l_LastAtom := f_LastShape;
   if (l_LastAtom = nil) or not (l_LastAtom is TddRTFShape) then
    lp_AddShape
   else
    begin
     l_Shape := l_LastAtom as TddRTFShape;
     if l_Shape.Closed or (l_Shape.Left <> aPAP.PosX) or (l_Shape.Top <> aPAP.PosY) then
      lp_AddShape
     else
     begin
      Result := l_Shape.LastPara;
      if (Result = nil) or Result.Closed then
       Result := l_Shape.AddTextPara;
     end;
    end;
  end;
//#UC END# *55C4754B00B7_51D278280093_impl*
end;//TdestNorm.AddTextPara

function TdestNorm.Try2CloseNestedTable(anItap: Integer): Boolean;
//#UC START# *560A489E0398_51D278280093_var*
var
 l_Table: TddTable;
//#UC END# *560A489E0398_51D278280093_var*
begin
//#UC START# *560A489E0398_51D278280093_impl*
 Result := False;
 l_Table := LastTable(True);
 if (l_Table <> nil) and (l_Table.Level > anItap) then
 begin
  l_Table.Closed := True;
  Result := True;
 end; // if l_Table.Level > aState.PAP.itap then
//#UC END# *560A489E0398_51D278280093_impl*
end;//TdestNorm.Try2CloseNestedTable

function TdestNorm.FindFootnoteSymbol(aState: TddRTFState;
 aSymbol: Integer): Boolean;
//#UC START# *5620DCA40213_51D278280093_var*
//#UC END# *5620DCA40213_51D278280093_var*
begin
//#UC START# *5620DCA40213_51D278280093_impl*
 Result := aSymbol = symbolFootnote;
 if Result then
  f_CustomRTFReader.FootNoteSymbol; 
//#UC END# *5620DCA40213_51D278280093_impl*
end;//TdestNorm.FindFootnoteSymbol

procedure TdestNorm.AddFooterHyperlink(aState: TddRTFState);
//#UC START# *5624D64601E3_51D278280093_var*
var
 l_FN   : AnsiString;
 l_New  : Boolean;
 l_Para : TddTextParagraph;
//#UC END# *5624D64601E3_51D278280093_var*
begin
//#UC START# *5624D64601E3_51D278280093_impl*
 l_Para := LastParagraph;
 if l_Para <> nil then
 begin
  f_CustomRTFReader.IncNextFootnoteNumber;
  l_FN := Format('*(%d)', [f_CustomRTFReader.NextFootnoteNumber]);
  l_Para := GetLastTextParaOrCreateNew(aState.PAP, l_New);
  l_Para.AddHyperLink(l_FN, 0, f_CustomRTFReader.NextFootnoteNumber);
 end; // if l_Para <> nil then
//#UC END# *5624D64601E3_51D278280093_impl*
end;//TdestNorm.AddFooterHyperlink

function TdestNorm.AddParagraph(const anAtom: TddDocumentAtom): Integer;
//#UC START# *5624D66F026F_51D278280093_var*
//#UC END# *5624D66F026F_51D278280093_var*
begin
//#UC START# *5624D66F026F_51D278280093_impl*
 Result := f_Paragraphs.Add(anAtom);
 AfterAddPara(anAtom);
//#UC END# *5624D66F026F_51D278280093_impl*
end;//TdestNorm.AddParagraph

function TdestNorm.GetParagraphsCount: Integer;
//#UC START# *5624D6920362_51D278280093_var*
//#UC END# *5624D6920362_51D278280093_var*
begin
//#UC START# *5624D6920362_51D278280093_impl*
 Result := f_Paragraphs.Count;
//#UC END# *5624D6920362_51D278280093_impl*
end;//TdestNorm.GetParagraphsCount

procedure TdestNorm.ParagraphsClear;
//#UC START# *5624D7550366_51D278280093_var*
//#UC END# *5624D7550366_51D278280093_var*
begin
//#UC START# *5624D7550366_51D278280093_impl*
 f_Paragraphs.Clear;
//#UC END# *5624D7550366_51D278280093_impl*
end;//TdestNorm.ParagraphsClear

procedure TdestNorm.ClearTextBuffer;
//#UC START# *5624D77C0376_51D278280093_var*
//#UC END# *5624D77C0376_51D278280093_var*
begin
//#UC START# *5624D77C0376_51D278280093_impl*
 f_TextBuffer.Clear;
//#UC END# *5624D77C0376_51D278280093_impl*
end;//TdestNorm.ClearTextBuffer

procedure TdestNorm.AfterAddPara(const anAtom: TddDocumentAtom);
//#UC START# *5624D79C03A8_51D278280093_var*
//#UC END# *5624D79C03A8_51D278280093_var*
begin
//#UC START# *5624D79C03A8_51D278280093_impl*

//#UC END# *5624D79C03A8_51D278280093_impl*
end;//TdestNorm.AfterAddPara

procedure TdestNorm.AddSub(aState: TddRTFState;
 const aText: Tl3String);
//#UC START# *56A9F2670380_51D278280093_var*
var
 l_New     : Boolean;
 l_LastPara: TddTextParagraph;
//#UC END# *56A9F2670380_51D278280093_var*
begin
//#UC START# *56A9F2670380_51D278280093_impl*
 l_LastPara := GetLastTextParaOrCreateNew(aState.PAP, l_New);
 f_CustomRTFReader.IncNextFootnoteNumber;
 l_LastPara.AddSub(f_CustomRTFReader.NextFootnoteNumber, aText.AsPCharLen);
//#UC END# *56A9F2670380_51D278280093_impl*
end;//TdestNorm.AddSub

procedure TdestNorm.CloseTextPara(aPAP: TddParagraphProperty;
 aPara: TddTextParagraph);
//#UC START# *56BC3011019B_51D278280093_var*
//#UC END# *56BC3011019B_51D278280093_var*
begin
//#UC START# *56BC3011019B_51D278280093_impl*
 aPara.Closed := True;
//#UC END# *56BC3011019B_51D278280093_impl*
end;//TdestNorm.CloseTextPara

function TdestNorm.InTable(aPAP: TddParagraphProperty): Boolean;
 {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
//#UC START# *56BC304D02E0_51D278280093_var*
//#UC END# *56BC304D02E0_51D278280093_var*
begin
//#UC START# *56BC304D02E0_51D278280093_impl*
 Result := aPAP.InTable;
//#UC END# *56BC304D02E0_51D278280093_impl*
end;//TdestNorm.InTable

procedure TdestNorm.DeleteLastAtom(aPrev: Boolean);
//#UC START# *56BD9F790092_51D278280093_var*
//#UC END# *56BD9F790092_51D278280093_var*
begin
//#UC START# *56BD9F790092_51D278280093_impl*
 if aPrev then
  f_Paragraphs.Delete(f_Paragraphs.Count - 2)
 else
  f_Paragraphs.DeleteLast;
//#UC END# *56BD9F790092_51D278280093_impl*
end;//TdestNorm.DeleteLastAtom

function TdestNorm.Itap(aPAP: TddParagraphProperty): Integer;
 {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
//#UC START# *56BDB2CD037F_51D278280093_var*
//#UC END# *56BDB2CD037F_51D278280093_var*
begin
//#UC START# *56BDB2CD037F_51D278280093_impl*
 Result := aPAP.itap;
//#UC END# *56BDB2CD037F_51D278280093_impl*
end;//TdestNorm.Itap

procedure TdestNorm.DoAddTabStop(aPAP: TddParagraphProperty);
//#UC START# *56C574EA022E_51D278280093_var*
//#UC END# *56C574EA022E_51D278280093_var*
begin
//#UC START# *56C574EA022E_51D278280093_impl*

//#UC END# *56C574EA022E_51D278280093_impl*
end;//TdestNorm.DoAddTabStop

function TdestNorm.AddTextPara2Document: TddTextParagraph;
//#UC START# *56C5946F0006_51D278280093_var*
var
 l_TextPara : TddTextParagraph;
//#UC END# *56C5946F0006_51D278280093_var*
begin
//#UC START# *56C5946F0006_51D278280093_impl*
 l_TextPara := TddTextParagraph.Create(Self);
 try
  AddParagraph(l_TextPara);
  Result := TddTextParagraph(LastAtom);
 finally
  FreeAndNil(l_TextPara);
 end;
//#UC END# *56C5946F0006_51D278280093_impl*
end;//TdestNorm.AddTextPara2Document

procedure TdestNorm.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51D278280093_var*
//#UC END# *5461BEC2017D_51D278280093_var*
begin
//#UC START# *5461BEC2017D_51D278280093_impl*
 
//#UC END# *5461BEC2017D_51D278280093_impl*
end;//TdestNorm.Close

procedure TdestNorm.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_51D278280093_var*
//#UC END# *54E1F08400F9_51D278280093_var*
begin
//#UC START# *54E1F08400F9_51D278280093_impl*
 if f_UnicodeBuffer.Position > 0 then
  FlushUnicodeBuffer(aState)
 else
  if aText.RTrimLen > 0 then
   WriteText(aText, aState);
//#UC END# *54E1F08400F9_51D278280093_impl*
end;//TdestNorm.WriteText

procedure TdestNorm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51D278280093_var*
//#UC END# *479731C50290_51D278280093_var*
begin
//#UC START# *479731C50290_51D278280093_impl*
 f_LastShape := nil;
 f_FirstShape := -1;
 FreeAndNil(f_UnicodeBuffer);
 FreeAndNil(f_TextBuffer);
 FreeAndNil(f_Paragraphs);
 inherited;
//#UC END# *479731C50290_51D278280093_impl*
end;//TdestNorm.Cleanup

procedure TdestNorm.Clear;
//#UC START# *51D27A48038E_51D278280093_var*
//#UC END# *51D27A48038E_51D278280093_var*
begin
//#UC START# *51D27A48038E_51D278280093_impl*
 inherited;
 f_LastShape := nil;
 f_TextBuffer.Clear;
 f_FirstShape := -1;
//#UC END# *51D27A48038E_51D278280093_impl*
end;//TdestNorm.Clear

procedure TdestNorm.AddAnsiChar(aText: AnsiChar;
 aState: TddRTFState);
//#UC START# *51D27C0402E9_51D278280093_var*
//#UC END# *51D27C0402E9_51D278280093_var*
begin
//#UC START# *51D27C0402E9_51D278280093_impl*
 if f_UnicodeBuffer.Position > 0 then
  FlushUnicodeBuffer(aState);
 if not CheckAnsiChar(aText, aState) then
  f_TextBuffer.Append(aText);
//#UC END# *51D27C0402E9_51D278280093_impl*
end;//TdestNorm.AddAnsiChar

procedure TdestNorm.AddString(aText: Tl3String;
 aState: TddRTFState);
//#UC START# *51D27C3302EC_51D278280093_var*

 function lp_CheckQL: Boolean;
 begin
  Result := l3Same(aText.AsWStr, 'ql', True);
  if Result then
   ClearTextBuffer;
 end;

//#UC END# *51D27C3302EC_51D278280093_var*
begin
//#UC START# *51D27C3302EC_51D278280093_impl*
 if f_UnicodeBuffer.Position > 0 then
  FlushUnicodeBuffer(aState);

 if not lp_CheckQL then
  f_TextBuffer.JoinWith(aText);
//#UC END# *51D27C3302EC_51D278280093_impl*
end;//TdestNorm.AddString

procedure TdestNorm.AddUnicodeChar(aText: Word;
 aState: TddRTFState);
//#UC START# *51D27DFA0308_51D278280093_var*

 function lp_CheckBREVE: Boolean;
 const
  cnBREVE = 774;
  cnRusBigI = 1048;
  cnRusSmallI = 1080;
  csRusSmallI = 'и';
  csRusBigI = 'И';
  csSetRusI = [csRusSmallI, csRusBigI];
 var
  l_Char: AnsiChar;
  l_Text: Word;
 begin
  Result := False;
  if aText = cnBREVE then
  begin
   l_Char := f_TextBuffer.Last;
   if (l_Char in csSetRusI) then
   begin
    f_TextBuffer.Ch[f_TextBuffer.Len - 1] := Char(Ord(l_Char) + 1);
    Result := True;
   end // if (l_Char in csSetRusI) then
   else
    if f_UnicodeBuffer.Size > 0 then // Поищем в Unicode...
    begin
     f_UnicodeBuffer.Seek(-SizeOf(aText), soCurrent);
     f_UnicodeBuffer.Read(l_Text, SizeOf(l_Text));
     if (l_Text = cnRusSmallI) or (l_Text = cnRusBigI) then
     begin
      Inc(l_Text);
      f_UnicodeBuffer.Seek(-SizeOf(l_Text), soCurrent);
      f_UnicodeBuffer.Write(l_Text, SizeOf(l_Text));
      Result := True;
     end; // if (l_Text = cnRusSmallI) or (l_Text = cnRusBigI) then
    end; // if f_UnicodeBuffer.Size > 0 then
  end; // if aText = cnBREVE then
 end;

 procedure lp_CheckUnicode;
 const
  cnUnicodeHLine = 9472;
  cnUnicodeDash = 8212;
 var
  l_Str : Tl3Str;
 begin
  if (aText = cnUnicodeHLine) and (f_UnicodeBuffer.Position = 0) then // Если есть какие-то еще символы, то разбираемся дальше...
  begin
   l_Str.Init(f_TextBuffer.AsPCharLen, CP_OEM);
   try
    if not l3CharSetPresent(l_Str.S, l_Str.SLen, cc_Graph_Criteria) then
     aText := cnUnicodeDash;
   finally
    l_Str.Clear;
   end;
  end; // if (UnicodeBuffer.Position = 0) then
 end;

//#UC END# *51D27DFA0308_51D278280093_var*
begin
//#UC START# *51D27DFA0308_51D278280093_impl*
 lp_CheckUnicode; // http://mdp.garant.ru/pages/viewpage.action?pageId=601456720
 if lp_CheckBREVE then Exit;
 if not f_TextBuffer.Empty then
  FlushTextBuffer(aState, True);
 f_UnicodeBuffer.Write(aText, SizeOf(aText));
//#UC END# *51D27DFA0308_51D278280093_impl*
end;//TdestNorm.AddUnicodeChar

procedure TdestNorm.ApplyProperty(propType: TPropType;
 What: TIProp;
 Value: LongInt;
 aState: TddRTFState);
//#UC START# *51D27EC50388_51D278280093_var*
//#UC END# *51D27EC50388_51D278280093_var*
begin
//#UC START# *51D27EC50388_51D278280093_impl*
 case propType of
  propStyle: ApplyToStyle(What, Value, aState);
  propCHP  : ApplyToCHP(What, Value, aState.CHP);
  propTAB  : ApplyToTAB(What, Value, aState.PAP);
  propPAP  : ApplyToPAP(What, Value, aState.PAP);
  propSep  : ApplyToSep(What, Value);
  propRow  : ApplyToRow(What, Value, aState);
  propCell : ApplyToCell(What, Value, aState.CEP);
  propShape: if What = ipropsectd then
              f_FirstShape := -1;
  propFrame: ApplyToFrame(What, Value, aState);
 end; // case PropType;
//#UC END# *51D27EC50388_51D278280093_impl*
end;//TdestNorm.ApplyProperty

constructor TdestNorm.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51D278280093_var*
//#UC END# *51E7C9DB0213_51D278280093_var*
begin
//#UC START# *51E7C9DB0213_51D278280093_impl*
 inherited Create(aRTFReader);
 f_TextBuffer := Tl3String.Create;
 f_UnicodeBuffer := Tl3MemoryStream.Create;
 f_Paragraphs := TddDocumentAtomList.Make;
//#UC END# *51E7C9DB0213_51D278280093_impl*
end;//TdestNorm.Create

procedure TdestNorm.ParseSymbol(Symbol: Integer;
 propType: TPropType;
 aState: TddRTFState);
//#UC START# *51E8CFEF027A_51D278280093_var*
var
 l_Para   : TddTextParagraph;
 l_Table  : TddTable;
 l_LastRow: Boolean;
//#UC END# *51E8CFEF027A_51D278280093_var*
begin
//#UC START# *51E8CFEF027A_51D278280093_impl*
 case propType of
  propPAP :
   begin
    if aState.SkipGroup then Exit;
    if aState.PAP.InTable and (LastAtom <> nil) and LastAtom.IsTable then
     if not Try2CloseNestedTable(aState.PAP.itap) then
      Try2AddTable(aState.PAP.itap);
    JoinPAPWithLastParaPAP(aState.PAP, f_TextBuffer.Len = 0);
    if f_TextBuffer.Len > 0 then
    begin
     FlushTextBuffer(aState, True);
     l_Para := LastParagraph;
     if l_Para <> nil then
      CloseTextPara(aState.PAP, l_Para);
    end; // if TextBuffer.Len > 0 then
   end; // propPAP
  propCell, propNestedCell:
   begin
    if not Try2CloseNestedTable(aState.PAP.itap) then
     Try2AddTable(aState.PAP.itap); // наследуем оформление от предыдущей строки
    if aState.PAP.ListItem <> propUndefined then
    begin
     JoinPAPWithLastParaPAP(aState.PAP, True);
     aState.PAP.ListItem := propUndefined;
    end; // if aState.PAP.LevelItem = 1 then
    if CanAddTable then
    begin
     l_Table := LastTable(propType <> propCell);
     if l_Table.Level < aState.PAP.itap then
     begin
      Try2AddTable(aState.PAP.itap);
      l_Table := LastTable(True);
     end; // if l_Table.Level < aState.PAP.itap then
    end; // if CanAddTable then
    if f_TextBuffer.Len > 0 then
     FlushTextBuffer(aState, True);
    if CanAddTable then
     l_Table.CloseCell;
   end; // propCell
  propRow, propNestedRow: // конец строки таблицы
    begin
     l_Table := LastTable(propType <> propRow); // http://mdp.garant.ru/pages/viewpage.action?pageId=479402089 - Может быть закрывающая \row без ячеек.
     if l_Table <> nil then
     begin
      if (l_Table.LastRow <> nil) and (l_Table.LastRow.LastCell <> nil) then
      begin
       l_Table.LastRow.LastCell.Closed := False;
       if f_TextBuffer.Len > 0 then
        FlushTextBuffer(aState, True);
      end; // if (l_Table.LastRow <> nil) and (l_Table.LastRow.LastCell <> nil) then
      l_Table.CloseLastRow(aState.TAP, aState.PAP, l_LastRow);
      if l_LastRow then
       aState.PAP.InTable := False;
     end; // if l_Table <> nil then
    end;
  propCHP:
    begin
     if f_UnicodeBuffer.Position > 0 then
       FlushUnicodeBuffer(aState);
     if not FindFootnoteSymbol(aState, Symbol) then
      f_TextBuffer.Append(AnsiChar(Symbol));
    end; // propCHP
  propDOP: AddPageBreak(Symbol);
 end; { case propType }
//#UC END# *51E8CFEF027A_51D278280093_impl*
end;//TdestNorm.ParseSymbol

procedure TdestNorm.Write(const aGenerator: Ik2TagGenerator);
//#UC START# *51E8D04603DF_51D278280093_var*
var
 i       : LongInt;
 l_Para  : TddDocumentAtom;
 l_Count : Integer;

 function lp_SkipLastParas: Boolean;
 var
  l_LastPara: TddDocumentAtom;
 begin
  Result := False;
  if not LiteVersion then
   if (i = l_Count - 1) and l_Para.IsBreak then
   begin
    l_LastPara := f_Paragraphs.Items[l_Count];
    Result := l_LastPara.IsTextPara and ((l_LastPara as TddTextParagraph).Text.RTrimLen = 0);
   end; // if (i = l_Count - 1) and l_Para.IsBreak then
 end;

 function lp_DontWriteBreak: Boolean;
 begin
  Result := False;
  if not LiteVersion then
  begin
   Result := (i = 0) and l_Para.IsBreak and (l_Para as TddBreak).HasDefaultParams;
   if not Result then
    Result := (i = l_Count) and l_Para.IsBreak;
   if not Result then
    Result := (i > 0) and l_Para.IsBreak and f_Paragraphs[i - 1].IsBreak;
  end; // if LiteVersion then
 end;

 function lp_SkipFirstPara(anIndex: Integer): Boolean; // http://mdp.garant.ru/pages/viewpage.action?pageId=598118986
 var
  l_TextPara: TddTextParagraph;
 begin
  Result := False;
  if (anIndex = 0) and (l_Count > 1) then
   if l_Para.IsTextPara and (LiteVersion or Paragraph[1].IsBreak) then
   begin
    l_TextPara := l_Para as TddTextParagraph;
    Result := (l_TextPara.Text.Len = 1);
   end; // if l_Para.IsTextPara and Paragraphs[1].IsBreak then
 end;

var
 l_SaveShape: TddRTFShape;
 
 function lp_SaveShape(anIndex: Integer): Boolean;
 const
  cnShapeIndex = 5;
 var
  l_PrevPara: TddDocumentAtom;
  l_NextPara: TddDocumentAtom;
 begin
  Result := False;
  if (anIndex < l_Count) and (anIndex > 0) and ((l_Count - anIndex) <= cnShapeIndex) and (l_SaveShape = nil) and (l_Para is TddRTFShape) then
  begin
   l_NextPara := f_Paragraphs[anIndex + 1];
   Result := l_NextPara.IsTextPara and not l_NextPara.Empty;
   if Result then
   begin
    l_PrevPara := f_Paragraphs[anIndex - 1];
    Result := l_PrevPara.IsTextPara and l_PrevPara.Empty;
    if Result then
     l_SaveShape := TddRTFShape(l_Para);
   end; // if Result then
  end; // if l_SaveShape = nil then
 end;

//#UC END# *51E8D04603DF_51D278280093_var*
begin
//#UC START# *51E8D04603DF_51D278280093_impl*
 l_Count := f_Paragraphs.Count - 1;
 l_SaveShape := nil;
 for i := 0 to l_Count do
 begin
  l_Para := f_Paragraphs.Items[i];
  if lp_DontWriteBreak then Continue;
  if lp_SkipFirstPara(i) then Continue;
  if lp_SkipLastParas then Break;
  if lp_SaveShape(i) then Continue;
  l_Para.Write2Generator(aGenerator, True, TddLiteVersion(LiteVersion));
  if l_SaveShape <> nil then
  begin
   l_SaveShape.Write2Generator(aGenerator, True, TddLiteVersion(LiteVersion));
   l_SaveShape := nil;
  end; // if l_SaveShape <> nil then
 end; { for Paragraphs.Count }
//#UC END# *51E8D04603DF_51D278280093_impl*
end;//TdestNorm.Write

procedure TdestNorm.WriteText(aText: Tl3String;
 aState: TddRTFState);
//#UC START# *51E8D0710060_51D278280093_var*
var
 l_PictureIndex: Integer;

 procedure lp_CheckStartedPicture;
 var
  l_LastAtom: TddDocumentAtom;
 begin
  l_LastAtom := LastAtom;
  if (l_LastAtom <> nil) and l_LastAtom.IsPicture and not l_LastAtom.Closed then
   l_PictureIndex := f_Paragraphs.Count - 1;
 end;

 procedure lp_TryMergeWithPicture;
 begin
  if l_PictureIndex > -1 then
  begin
   AddPicture(Paragraph[l_PictureIndex] as TddPicture, nil, False);
   f_Paragraphs.Delete(l_PictureIndex);
   l_PictureIndex := -1;
  end; // if l_PictureIndex > -1 then
 end;

 function lp_NeedIngnoreText: Boolean;
 const
  csIgrnoreFontName = 'MARLETT';
 begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=607284891
  Result := UpperCase(aState.CHP.FontName) = csIgrnoreFontName;
 end;


var
 l_CHP        : TddCharacterProperty;
 l_Add        : Boolean;
 l_Para       : TddTextParagraph;
 l_NewPara    : Boolean;
 l_LastSegment: TddTextSegment;
//#UC END# *51E8D0710060_51D278280093_var*
begin
//#UC START# *51E8D0710060_51D278280093_impl*
 if lp_NeedIngnoreText then Exit;
 l_PictureIndex := -1;
 if (LastAtom <> nil) and LastAtom.IsTable and aState.PAP.InTable and (aText.RTrimLen > 0) then // http://mdp.garant.ru/pages/viewpage.action?pageId=482752570
  Try2AddTable(aState.PAP.itap)
 else
  lp_CheckStartedPicture;
 l_Para := GetLastTextParaOrCreateNew(aState.PAP, l_NewPara);
 if l_NewPara then
  lp_TryMergeWithPicture;
 if l_Para <> nil then
 begin
  Try2ApplyParaProperty(aState, l_Para, not l_NewPara);
  l_CHP := TddCharacterProperty(l_Para.CHP.Diff(aState.CHP, True));
  try
   l_LastSegment := l_Para.LastStyledSegment;
   if not LiteVersion then
   begin
    if (l_CHP <> nil) then
    begin
     if (l_LastSegment <> nil) then
      l_Add := (l_CHP.OCompare(l_LastSegment.CHP) <> 0) or (l_LastSegment.Stop <> l_Para.Text.Len)
     else
      l_Add := True;
     if l_Add then
      l_Para.AddSegment(l_CHP, aState.CHP)
     else
      if (l_LastSegment <> nil) then
       l_Para.LastStyledSegment.Stop := l_LastSegment.Stop + aText.Len;
    end; // aCHP <> nil
   end // not LiteVersion
   else
    if (l_LastSegment <> nil) and (l_CHP <> nil) then
    begin
     if (l_LastSegment <> nil) and (l_LastSegment.CHP.Style <> l_CHP.Style) then
      l_Para.AddSegment(l_CHP, nil);
    end; // (LastParagraph.SegmentList.Count > 0) and (aCHP <> nil)
  finally
   FreeAndNil(l_CHP);
  end;
  if l_Para.CHP.Caps = ccAllCaps then
   aText.MakeUpper
  else
   if l_Para.CHP.Caps = ccSmallCaps then
    aText.MakeLower;
  l_Para.AddText(aText);
 end; // if l_Para <> nil then
 ClearTextBuffer;
//#UC END# *51E8D0710060_51D278280093_impl*
end;//TdestNorm.WriteText

function TdestNorm.GetList(aListID: Integer;
 out aWasRestart: Boolean): TrtfList;
//#UC START# *51E8D6CF03A1_51D278280093_var*
//#UC END# *51E8D6CF03A1_51D278280093_var*
begin
//#UC START# *51E8D6CF03A1_51D278280093_impl*
 Result := f_CustomRTFReader.ListByID(aListID, aWasRestart);
//#UC END# *51E8D6CF03A1_51D278280093_impl*
end;//TdestNorm.GetList

function TdestNorm.GetStyle(aStyleID: Integer): TddStyleEntry;
//#UC START# *51E8D73F0187_51D278280093_var*
//#UC END# *51E8D73F0187_51D278280093_var*
begin
//#UC START# *51E8D73F0187_51D278280093_impl*
 Result := f_CustomRTFReader.StyleByNumber(aStyleID);
//#UC END# *51E8D73F0187_51D278280093_impl*
end;//TdestNorm.GetStyle

procedure TdestNorm.BeforeCloseParagraph(const aDocAtom: TObject;
 var aNewStyle: Integer);
//#UC START# *534F9B57003E_51D278280093_var*
//#UC END# *534F9B57003E_51D278280093_var*
begin
//#UC START# *534F9B57003E_51D278280093_impl*
 f_CustomRTFReader.BeforeClosePara(aDocAtom as TddDocumentAtom, aNewStyle);
//#UC END# *534F9B57003E_51D278280093_impl*
end;//TdestNorm.BeforeCloseParagraph

procedure TdestNorm.FlushBuffer(aState: TddRTFState);
//#UC START# *55F1787803BB_51D278280093_var*
//#UC END# *55F1787803BB_51D278280093_var*
begin
//#UC START# *55F1787803BB_51D278280093_impl*
 if not BufferEmpty then
  if not ((f_TextBuffer.Len = 1) and (f_TextBuffer.Ch[0] = cc_Multyply)) then
   WriteText(RDS, GetTextBuffer(aState), aState);
//#UC END# *55F1787803BB_51D278280093_impl*
end;//TdestNorm.FlushBuffer

function TdestNorm.NextTextPara(const anCurrent: TObject): TObject;
//#UC START# *5658453300F6_51D278280093_var*
var
 l_Index: Integer;
//#UC END# *5658453300F6_51D278280093_var*
begin
//#UC START# *5658453300F6_51D278280093_impl*
 Result := inherited NextTextPara(anCurrent);
 l_Index := f_Paragraphs.IndexOf(TddDocumentAtom(anCurrent));
 Inc(l_Index);
 if (l_Index < f_Paragraphs.Count) then
 begin
  Result := f_Paragraphs[l_Index];
  if not TddDocumentAtom(Result).IsTextPara then
   Result := nil;
 end; // if (l_Index < f_Paragraph.Count) then
//#UC END# *5658453300F6_51D278280093_impl*
end;//TdestNorm.NextTextPara

end.
