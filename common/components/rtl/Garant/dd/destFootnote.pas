unit destFootnote;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destFootnote.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestFootnote
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  destNorm,
  ddRTFState,
  RTFtypes,
  k2Interfaces,
  ddRTFdestination,
  ddDocumentAtom
  ;

type
 TdestFootnote = class(TdestNorm)
 private
 // private fields
   f_PrevNumber : Integer;
   f_ParaID : Integer;
   f_InitSymbol : Boolean;
   f_ExternalSymbol : Boolean;
 private
 // private methods
   procedure Try2AddFootNote(anInClose: Boolean);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure AddPageBreak(aSymbol: Integer); override;
   function FindFootnoteSymbol(aState: TddRTFState;
     aSymbol: Integer): Boolean; override;
   procedure AfterAddPara(const anAtom: TddDocumentAtom); override;
 public
 // overridden public methods
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure ParseSymbol(Symbol: Integer;
     propType: TPropType;
     aState: TddRTFState); override;
   procedure Write(const aGenerator: Ik2TagGenerator); override;
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure FlushBuffer(aState: TddRTFState); override;
 public
 // public methods
   procedure FootNoteSymbol;
 end;//TdestFootnote

implementation

uses
  SysUtils,
  k2Tags,
  l3Chars,
  evdStyles,
  l3String,
  ddTextParagraph,
  ddTypes
  ;

// start class TdestFootnote

procedure TdestFootnote.Try2AddFootNote(anInClose: Boolean);
//#UC START# *5526883F0018_51E8E8770374_var*
var
 l_FN  : AnsiString;
 l_Atom: TddDocumentAtom;
 l_Para: TddTextParagraph;
 l_Last: TddTextParagraph;
//#UC END# *5526883F0018_51E8E8770374_var*
begin
//#UC START# *5526883F0018_51E8E8770374_impl*
 if (f_PrevNumber = f_CustomRTFReader.NextFootnoteNumber) then Exit;
 if f_ParaID = -1 then
  AddTextPara2Document;
 l_Atom := Paragraph[f_ParaID];
 if l_Atom.IsTextPara then
  l_Para := TddTextParagraph(l_Atom)
 else
 begin
  l_Para := nil;
  Assert(False);
 end;
 l_FN := Format('*(%d)', [f_CustomRTFReader.NextFootnoteNumber]);
 with l_Para do
 begin
  AddSub(f_CustomRTFReader.NextFootnoteNumber, Format('Сноска %d', [f_CustomRTFReader.NextFootnoteNumber]));
  if not (Text[0] in cc_WhiteSpaceExt) then
   l_FN := l_FN + cc_HardSpace;
  Text.Insert(l3PCharLen(l_FN), 0);
  Closed := True;
  l_Last := Self.LastParagraph;
  if l_Last <> nil then
   l_Last.Closed := True;
  f_PrevNumber := f_CustomRTFReader.NextFootnoteNumber;
  f_InitSymbol := False;
  f_ParaID := -1;
 end; // with Lastparagraph
//#UC END# *5526883F0018_51E8E8770374_impl*
end;//TdestFootnote.Try2AddFootNote

procedure TdestFootnote.FootNoteSymbol;
//#UC START# *5626172003A9_51E8E8770374_var*
//#UC END# *5626172003A9_51E8E8770374_var*
begin
//#UC START# *5626172003A9_51E8E8770374_impl*
 f_ExternalSymbol := True;
//#UC END# *5626172003A9_51E8E8770374_impl*
end;//TdestFootnote.FootNoteSymbol

procedure TdestFootnote.Cleanup;
//#UC START# *479731C50290_51E8E8770374_var*
//#UC END# *479731C50290_51E8E8770374_var*
begin
//#UC START# *479731C50290_51E8E8770374_impl*
 inherited;
 f_PrevNumber := -1;
 f_ParaID := -1;
 f_InitSymbol := False;
 f_ExternalSymbol := False;
//#UC END# *479731C50290_51E8E8770374_impl*
end;//TdestFootnote.Cleanup

procedure TdestFootnote.InitFields;
//#UC START# *47A042E100E2_51E8E8770374_var*
//#UC END# *47A042E100E2_51E8E8770374_var*
begin
//#UC START# *47A042E100E2_51E8E8770374_impl*
 inherited;
 f_InitSymbol := False;
 f_PrevNumber := -1;
 f_ParaID := -1;
 f_ExternalSymbol := False;
//#UC END# *47A042E100E2_51E8E8770374_impl*
end;//TdestFootnote.InitFields

procedure TdestFootnote.Clear;
//#UC START# *51D27A48038E_51E8E8770374_var*
//#UC END# *51D27A48038E_51E8E8770374_var*
begin
//#UC START# *51D27A48038E_51E8E8770374_impl*
 inherited;
 f_PrevNumber := -1;
 f_ParaID := -1;
 f_InitSymbol := False;
 f_ExternalSymbol := False;
//#UC END# *51D27A48038E_51E8E8770374_impl*
end;//TdestFootnote.Clear

procedure TdestFootnote.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_51E8E8770374_var*
//#UC END# *51D27C0402E9_51E8E8770374_var*
begin
//#UC START# *51D27C0402E9_51E8E8770374_impl*
 inherited;
//#UC END# *51D27C0402E9_51E8E8770374_impl*
end;//TdestFootnote.AddAnsiChar

procedure TdestFootnote.ParseSymbol(Symbol: Integer;
  propType: TPropType;
  aState: TddRTFState);
//#UC START# *51E8CFEF027A_51E8E8770374_var*
//#UC END# *51E8CFEF027A_51E8E8770374_var*
begin
//#UC START# *51E8CFEF027A_51E8E8770374_impl*
 if not ((propType = propCHP) and (Symbol = symbolFootnote)) then
  inherited;
//#UC END# *51E8CFEF027A_51E8E8770374_impl*
end;//TdestFootnote.ParseSymbol

procedure TdestFootnote.Write(const aGenerator: Ik2TagGenerator);
//#UC START# *51E8D04603DF_51E8E8770374_var*
var
 i      : LongInt;
 l_Para : TddDocumentAtom;
//#UC END# *51E8D04603DF_51E8E8770374_var*
begin
//#UC START# *51E8D04603DF_51E8E8770374_impl*
 aGenerator.StartDefaultChild;
 try
  aGenerator.AddIntegerAtom(k2_tiStyle, ev_saTxtNormalOEM);
  aGenerator.AddStringAtom(k2_tiText, 'ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД', CP_OEM);
 finally
  aGenerator.Finish;
 end; { TextPara }

 for i := 0 to GetParagraphsCount - 1 do
 begin
  l_Para := Paragraph[i];
  l_Para.Write2Generator(aGenerator, True, dd_lvStyleOnly); // Грохаем все стили у сносок: http://mdp.garant.ru/pages/viewpage.action?pageId=596626773
 end; { for Paragraphs.Count }
//#UC END# *51E8D04603DF_51E8E8770374_impl*
end;//TdestFootnote.Write

procedure TdestFootnote.AddPageBreak(aSymbol: Integer);
//#UC START# *5385C5C802D5_51E8E8770374_var*
//#UC END# *5385C5C802D5_51E8E8770374_var*
begin
//#UC START# *5385C5C802D5_51E8E8770374_impl*

//#UC END# *5385C5C802D5_51E8E8770374_impl*
end;//TdestFootnote.AddPageBreak

procedure TdestFootnote.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51E8E8770374_var*
//#UC END# *5461BEC2017D_51E8E8770374_var*
begin
//#UC START# *5461BEC2017D_51E8E8770374_impl*
 if (aNewDest.RDS = RDS) and not f_InitSymbol then
 begin
  f_CustomRTFReader.AddFooterHyperlink;
  FlushBuffer(aState);
  f_InitSymbol := True;
 end; // if (aNewDest.RDS = RDS) and not f_InitSymbol then
 if (aNewDest.RDS <> RDS) and (aNewDest is TdestNorm) then
 begin
  if f_ExternalSymbol and not f_InitSymbol then
  begin
   f_CustomRTFReader.AddFooterHyperlink;
   FlushBuffer(aState);
  end;
  Try2AddFootNote(True);
 end; // if (aNewDest.RDS <> RDS) and (aNewDest is TdestNorm) then
//#UC END# *5461BEC2017D_51E8E8770374_impl*
end;//TdestFootnote.Close

procedure TdestFootnote.FlushBuffer(aState: TddRTFState);
//#UC START# *55F1787803BB_51E8E8770374_var*
//#UC END# *55F1787803BB_51E8E8770374_var*
begin
//#UC START# *55F1787803BB_51E8E8770374_impl*
 if f_InitSymbol then
  inherited
 else
  ClearTextBuffer;
//#UC END# *55F1787803BB_51E8E8770374_impl*
end;//TdestFootnote.FlushBuffer

function TdestFootnote.FindFootnoteSymbol(aState: TddRTFState;
  aSymbol: Integer): Boolean;
//#UC START# *5620DCA40213_51E8E8770374_var*
//#UC END# *5620DCA40213_51E8E8770374_var*
begin
//#UC START# *5620DCA40213_51E8E8770374_impl*
 Result := aSymbol = symbolFootnote;
//#UC END# *5620DCA40213_51E8E8770374_impl*
end;//TdestFootnote.FindFootnoteSymbol

procedure TdestFootnote.AfterAddPara(const anAtom: TddDocumentAtom);
//#UC START# *5624D79C03A8_51E8E8770374_var*
//#UC END# *5624D79C03A8_51E8E8770374_var*
begin
//#UC START# *5624D79C03A8_51E8E8770374_impl*
 if anAtom.IsTextPara and (f_ParaID = -1) then
  f_ParaID := GetParagraphsCount - 1;
//#UC END# *5624D79C03A8_51E8E8770374_impl*
end;//TdestFootnote.AfterAddPara

end.