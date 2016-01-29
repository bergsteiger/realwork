unit nevPersistentDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevPersistentDocumentContainer.pas"
// Начат: 14.07.2005 11:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::DocumentContainers::nevPersistentDocumentContainer
//
// Контейнер документа с поддержкой записи/чтения в различных форматах.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevBase,
  k2TagGen,
  evDocumentContainerWithProcessor,
  k2CustomReader,
  l3Interfaces,
  nevInternalInterfaces
  ;

type
 TevGetWriterProc = procedure (Sender: TObject;
  aFormat: TnevFormat;
  var Writer: Tk2TagGenerator);
   {* процедура для получения объекта для записи текста в формате aFormat. }

 TevGetReaderProc = procedure (Sender: TObject;
  aFormat: TnevFormat;
  var Reader: Tk2CustomReader;
  const aFileName: AnsiString = '');
   {* процедура для получения объекта для чтения текста в формате aFormat. }

 TnevPersistentDocumentContainer = class(TevDocumentContainerWithProcessor)
  {* Контейнер документа с поддержкой записи/чтения в различных форматах. }
 protected
 // overridden protected methods
   procedure GetWriter(aFormat: TnevFormat;
    anInternal: Boolean;
    out theWriter: Tk2TagGenerator;
    out theCharCountMul: Integer;
    out theFormatName: Il3CString;
    const aFilters: InevTagGenerator;
    aCodePage: Integer); override;
   procedure DoGetReader(aFormat: TnevFormat;
    const aPool: IStream;
    out theReader: Tk2CustomReader;
    anInternal: Boolean;
    aCodePage: Integer;
    const aBlock: IUnknown); override;
 protected
 // protected methods
   function UseWikiMarkup: Boolean; virtual;
   procedure DoGetWriter(aFormat: TnevFormat;
    anInternal: Boolean;
    var theWriter: Tk2TagGenerator;
    aCodePage: Integer); virtual;
 end;//TnevPersistentDocumentContainer

var evGetWriterProc : TevGetWriterProc = nil;
 {* Callback для получения писателя.}

var evGetReaderProc : TevGetReaderProc = nil;
 {* Callback для получения читателя.}

implementation

uses
  k2Tags,
  evCustomTxtReader,
  evTypes,
  evdNativeReader,
  k2CustomFileGenerator,
  evTextFormatter,
  evdPlainTextWriter,
  nevInterfaces,
  l3Chars,
  SysUtils,
  l3Base,
  evdNativeWriter,
  Document_Const,
  evMergedCellFilter,
  ShellAPI,
  evCustomWikiReader,
  evdTextStyle_Const,
  evStyleHeaderAdder,
  evdNativeUnpackedWriter
  ;

// start class TnevPersistentDocumentContainer

function TnevPersistentDocumentContainer.UseWikiMarkup: Boolean;
//#UC START# *4D6BAFE8013D_47F351160396_var*
//#UC END# *4D6BAFE8013D_47F351160396_var*
begin
//#UC START# *4D6BAFE8013D_47F351160396_impl*
 Result := false;
//#UC END# *4D6BAFE8013D_47F351160396_impl*
end;//TnevPersistentDocumentContainer.UseWikiMarkup

procedure TnevPersistentDocumentContainer.DoGetWriter(aFormat: TnevFormat;
  anInternal: Boolean;
  var theWriter: Tk2TagGenerator;
  aCodePage: Integer);
//#UC START# *483E6C150277_47F351160396_var*
//#UC END# *483E6C150277_47F351160396_var*
begin
//#UC START# *483E6C150277_47F351160396_impl*
 if Assigned(evGetWriterProc) then
  evGetWriterProc(Self, aFormat, theWriter);
 if (TextSource <> nil) then
  TextSource.CheckWriter(aFormat, anInternal, theWriter, aCodePage);
 if not anInternal then
  if (aFormat = cf_EverestBin) or
     (aFormat = cf_EverestBinForce) or
     (aFormat = cf_EverestBinForceAndUnpacked) or
     (aFormat = cf_EverestTxt) then
   TevMergedCellFilter.SetTo(theWriter);
//#UC END# *483E6C150277_47F351160396_impl*
end;//TnevPersistentDocumentContainer.DoGetWriter

procedure TnevPersistentDocumentContainer.GetWriter(aFormat: TnevFormat;
  anInternal: Boolean;
  out theWriter: Tk2TagGenerator;
  out theCharCountMul: Integer;
  out theFormatName: Il3CString;
  const aFilters: InevTagGenerator;
  aCodePage: Integer);
//#UC START# *47F0BE5A00C9_47F351160396_var*
var
 l_PTG : Tk2CustomFileGenerator;
 l_Wrap: Ik2TagGeneratorWrap;
 l_Filter: Tk2TagGenerator;
//#UC END# *47F0BE5A00C9_47F351160396_var*
begin
//#UC START# *47F0BE5A00C9_47F351160396_impl*
 inherited;
 if (theWriter = nil) then
  Case aFormat of
   cf_Text,
   cf_OEMText,
   cf_UnicodeText :
   begin
    theCharCountMul := 1;
    theWriter := TevTextFormatter.Create;
    l_PTG := TevdPlainTextWriter.Create;
    try
     with TevTextFormatter(theWriter) do
     begin
      Case aFormat of
       cf_Text:
       begin
        theFormatName := str_nevtfANSI.AsCStr;
        if (aCodePage = CP_DefaultValue) then
         CodePage := CP_ANSI
        else
         CodePage := aCodePage;
       end;//cf_Text
       cf_UnicodeText:
       begin
        theFormatName := str_nevtfUnicode.AsCStr;
        if (aCodePage = CP_DefaultValue) then
         CodePage := CP_Unicode
        else
         CodePage := aCodePage;
       end;//cf_UnicodeText
       else
       begin
        theFormatName := str_nevtfOEM.AsCStr;
        if (aCodePage = CP_DefaultValue) then
         CodePage := CP_OEMLite
        else
         CodePage := aCodePage;
       end;//aFormat = cf_Text
      end;//Case aFormat
      SBSDelimeter := cc_HardSpace;
      Generator := l_PTG;
      FormatOrdinalParas := false;
     end;//with TevTextFormatter(G)
    finally
     FreeAndNil(l_PTG);
    end;//try..finally
   end;//cf_Text..
   else
   begin
    {$IfDef evNeedDefaultEvdWriter}
    if (aFormat = cf_EverestBin) OR
       (aFormat = cf_EverestBinForce) OR
       (aFormat = cf_EverestTxt) then
    begin
     theCharCountMul := 2;
     {$IfDef evUseIStorage}
     theWriter := TevCustomEvdStorageWriter.Create;
     TevCustomEvdStorageWriter(theWriter).Binary := (aFormat = cf_EverestBin) OR
                                                    (aFormat = cf_EverestBinForce);
     TevCustomEvdStorageWriter(theWriter).NeedOutHeader := (aFormat <> cf_EverestBinForce);
     {$Else  evUseIStorage}
     theWriter := TevdNativeWriter.Create;
     {$IfDef evdNeedEverestTxt}
     TevdNativeWriter(theWriter).Binary := (aFormat = cf_EverestBin) OR
                                           (aFormat = cf_EverestBinForce);
     TevdNativeWriter(theWriter).NeedOutHeader := (aFormat <> cf_EverestBinForce);
     {$IfDef Nemesis}
     if TevdNativeWriter(theWriter).Binary then
      if not TevdNativeWriter(theWriter).NeedOutHeader then
      begin
       TevdNativeWriter(theWriter).SmallHeader := true;
       // - это надо будет включить когда Рома поправит - http://mdp.garant.ru/pages/viewpage.action?pageId=159355611&focusedCommentId=217687348#comment-217687348
       TevdNativeWriter(theWriter).NeedOutHeader := true;
      end;//not TevdNativeWriter(theWriter).NeedOutHeader
     {$EndIf Nemesis}
     {$EndIf evdNeedEverestTxt}
     {$EndIf evUseIStorage}
     {$IfDef evMyEditor}
     theFormatName := str_nevtfThyEditor.AsCStr;
     {$Else  evMyEditor}
     {$IfDef Nemesis}
     theFormatName := str_nevtfGarant.AsCStr;
     {$Else  Nemesis}
     if (aFormat = cf_EverestBin) OR (aFormat = cf_EverestBinForce) then
      theFormatName := str_nevtfEverestBin.AsCStr
     else
      theFormatName := str_nevtfEverest.AsCStr;
     {$EndIf Nemesis}
     {$EndIf evMyEditor}
    end//aFormat = cf_EverestBin
    else
    if (aFormat = cf_EverestBinForceAndUnpacked) then
    begin
     theCharCountMul := 2;
     theWriter := TevdNativeUnpackedWriter.Create;
     {$IfDef evdNeedEverestTxt}
     TevdNativeUnpackedWriter(theWriter).NeedOutHeader := false;
     {$IfDef Nemesis}
      if not TevdNativeUnpackedWriter(theWriter).NeedOutHeader then
      begin
       TevdNativeUnpackedWriter(theWriter).SmallHeader := true;
       // - это надо будет включить когда Рома поправит - http://mdp.garant.ru/pages/viewpage.action?pageId=159355611&focusedCommentId=217687348#comment-217687348
       TevdNativeUnpackedWriter(theWriter).NeedOutHeader := true;
      end;//not TevdNativeUnpackedWriter(theWriter).NeedOutHeader
     {$EndIf Nemesis}
     {$EndIf evdNeedEverestTxt}
     {$IfDef Nemesis}
     theFormatName := str_nevtfGarant.AsCStr;
     {$Else  Nemesis}
     theFormatName := str_nevtfEverestBin.AsCStr;
     {$EndIf Nemesis}
    end//aFormat = cf_EverestBinForceAndUnpacked
    else
    {$EndIf evNeedDefaultEvdWriter}
    if (aFormat = cf_RTF) OR (aFormat = cf_RTFLite) then
    begin
     theFormatName := str_nevtfRtf.AsCStr;
     theCharCountMul := 10;
     theWriter := nil;
    end//aFormat = cf_RTF
    else
    begin
     theFormatName := nil;
     theCharCountMul := 2;
     theWriter := nil;
    end;//aFormat = cf_RTF
   end;//else
  end;//Case aFormat
 DoGetWriter(aFormat, anInternal, theWriter, aCodePage);
 if not anInternal and
    Supports(aFilters, Ik2TagGeneratorWrap, l_Wrap) and
    Assigned(theWriter) then
 begin
  l_Filter := l_Wrap.Generator;
  l_Filter.Link(theWriter);
  l3Set(theWriter, l_Filter);
 end;//not anInternal
 {$IFDEF Nemesis}
 // V - в Арчи такого не заказывали: http://mdp.garant.ru/pages/viewpage.action?pageId=389942714
 if not anInternal then
  Case aFormat of
   cf_Text,
   cf_OEMText,
   cf_UnicodeText:
    TevStyleHeaderAdder.SetTo(theWriter);
   else
   if (aFormat = cf_RTF) OR
      (aFormat = cf_RTFLite) then
    TevStyleHeaderAdder.SetTo(theWriter);
  end;//Case aFormat
 {$ENDIF Nemesis} 
//#UC END# *47F0BE5A00C9_47F351160396_impl*
end;//TnevPersistentDocumentContainer.GetWriter

procedure TnevPersistentDocumentContainer.DoGetReader(aFormat: TnevFormat;
  const aPool: IStream;
  out theReader: Tk2CustomReader;
  anInternal: Boolean;
  aCodePage: Integer;
  const aBlock: IUnknown);
//#UC START# *47F25391018B_47F351160396_var*
var
 l_Handle           : THandle;
 l_FileCount        : Integer;
 l_String           : Tl3String;
 l_HandleMemoryPool : Il3HandleMemoryPool;
//#UC END# *47F25391018B_47F351160396_var*
begin
//#UC START# *47F25391018B_47F351160396_impl*
 inherited;
 if (theReader = nil) then
 begin
  Case aFormat of
   cf_Text,
   cf_OEMText,
   cf_UnicodeText :
   begin
    if UseWikiMarkup then
    begin
     theReader := TevCustomWikiReader.Create;
     TevCustomWikiReader(theReader).DefaultStyle := evd_saDialogs;
    end//UseWikiMarkup
    else
     theReader := TevCustomTxtReader.Create;
    with TevCustomTxtReader(theReader) do
    begin
     DocumentType := GetDocumentType;
     AnalizeCharSet := false;
     if (aCodePage = CP_DefaultValue) then
     begin
      Case aFormat of
       cf_Text:
        Filer.CodePage := CP_ANSI;
       cf_OEMText:
        Filer.CodePage := CP_OEM;
       cf_UnicodeText:
        Filer.CodePage := CP_Unicode;
      end;//Case aFormat of
     end//aCodePage = CP_DefaultValue
     else
      Filer.CodePage := aCodePage;
     PlainText := true;
    end;{with TevCustomTxtReader(Reader)..}
   end;{cf_Text..}
   else
   begin
    {$IfDef evNeedDefaultEvdReader}
    if (aFormat = cf_EverestBin) OR
       (aFormat = cf_EverestBinForce) OR
       (aFormat = cf_EverestTxt) then
    begin
     {$IfNDef evUseIStorage}
     theReader := TevdNativeReader.Create;
     {$Else   evUseIStorage}
     theReader := TevCustomEvdStorageReader.Create;
     {$EndIf  evUseIStorage}
     if (aFormat = cf_EverestBinForce) then
      TevdNativeReader(theReader).ForceBinary := true;
    end;//aFormat = cf_EverestBin
    {$EndIf evNeedDefaultEvdReader}
   end;//else
  end;//Case aFormat
 end;//theReader = nil
 if not anInternal and (theReader = nil) and (aFormat = cf_HDrop) then
 begin
  if Supports(aPool, Il3HandleMemoryPool, l_HandleMemoryPool) then
   try
    l_Handle := l_HandleMemoryPool.ReleaseHandle;
    l_FileCount := DragQueryFile(l_Handle, $FFFFFFFF, nil, 0);
    if (l_FileCount = 1) then begin
     l_String := Tl3String.Create;
     try
      l_String.Len := DragQueryFile(l_Handle, 0, nil, 0);
      if not l_String.Empty then
      begin
       DragQueryFileA(l_Handle, 0, l_String.St, l_String.StSize);
       if Assigned(evGetReaderProc) then
        evGetReaderProc(Self, aFormat, theReader, l_String.AsString);
      end;{not l_String.Empty}
     finally
      FreeAndNil(l_String);
     end;{try..finally}
    end;//l_FileCount = 1
   finally
    l_HandleMemoryPool := nil;
   end;//try..finally
 end;//not anInternal
 if Assigned(evGetReaderProc) then
  evGetReaderProc(Self, aFormat, theReader);
 if (TextSource <> nil) then
  TextSource.CheckReader(aFormat, anInternal, theReader);
//#UC END# *47F25391018B_47F351160396_impl*
end;//TnevPersistentDocumentContainer.DoGetReader

end.