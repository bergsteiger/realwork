{$IfNDef BaseTextOperations_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseTextOperations.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "BaseTextOperations" MUID: (4AE1A69E0156)
// Имя типа: "_BaseTextOperations_"

{$Define BaseTextOperations_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _Text_Parent_ = _BaseTextOperations_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Text.imp.pas}
 _BaseTextOperations_ = {abstract} class(_Text_)
  {* Базовые операции с текстом }
  private
   f_Text: TnscEditor;
    {* Поле для свойства Text }
   f_TextSource: TnscTextSource;
    {* Поле для свойства TextSource }
  protected
   HAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
   FilterInfoFactory: IucpFilterInfoFactory;
  private
   procedure MakeMacroReplacer(Sender: TObject;
    var aReplacer: Il3HAFMacroReplacer);
  protected
   function pm_GetHasDoc: Boolean; virtual; abstract;
   function DocumentExport(anExportKind: TnsExportKind;
    aExportSelection: Boolean;
    const aRange: InevRange = nil): Boolean;
   procedure DocumentPrint(aPrintDialog: Boolean = False);
   function MakePreview: IafwComplexDocumentPreview;
   procedure DoMakeExportFilters(aSelection: Boolean;
    aForExport: Boolean;
    var theGen: Ik2TagGenerator);
   function GetDocumentExportName(const aDoc: IDocument;
    aExportSelection: Boolean): Il3CString;
   function GetDocumentShortName(const aDoc: IDocument;
    aExportSelection: Boolean): Il3CString; virtual;
   function DocumentForExport: IDocument; virtual; abstract;
   procedure NotEmptyDocumentTest(const aParams: IvcmTestParamsPrim);
    {* Проверяет, что документ непустой }
   procedure NotEmptyDocumentWithTrialModeTest(const aParams: IvcmTestParamsPrim);
    {* Проверяет, что документ не пустой и версия не демонстрационная }
   function AddBookmark(const aPara: IeeLeafPara): Boolean;
   function IsDrug: Boolean; virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
    {* Экспорт в Word }
   procedure File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Экспорт в Word }
   procedure File_SendMailAsAttachment_Test(const aParams: IvcmTestParamsPrim);
    {* Послать по e-mail }
   procedure File_SendMailAsAttachment_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Послать по e-mail }
  protected
   property TextSource: TnscTextSource
    read f_TextSource;
    {* Источник текста }
   property HasDoc: Boolean
    read pm_GetHasDoc;
    {* Проверяет наличие документа }
  public
   property Text: TnscEditor
    read f_Text;
 end;//_BaseTextOperations_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_Text_Parent_ = _BaseTextOperations_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Text.imp.pas}
_BaseTextOperations_ = _Text_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseTextOperations_imp}

{$IfNDef BaseTextOperations_imp_impl}

{$Define BaseTextOperations_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Text.imp.pas}

function _BaseTextOperations_.DocumentExport(anExportKind: TnsExportKind;
 aExportSelection: Boolean;
 const aRange: InevRange = nil): Boolean;
var l_Ext: AnsiString;
var l_PathName: Il3CString;
var l_Stream: Tl3Stream;
var l_Format: Tl3ClipboardFormat;
var l_F: TnsFileFormat;
var l_G: Tk2CustomFileGenerator;
var l_Visualizer: IafwLongProcessVisualizer;
var l_Head: Tk2TagGenerator;
 {* Голова цепочки генераторов }
//#UC START# *4A1FF17502AC_4AE1A69E0156_var*
var
 l_H    : Tk2TagGenerator;
 l_Output : TnsGetGenOutputStruct;
//#UC END# *4A1FF17502AC_4AE1A69E0156_var*
begin
//#UC START# *4A1FF17502AC_4AE1A69E0156_impl*
 Result := false;
 l_Format := CF_LOCALE;
 if anExportKind = ekDisk then
 begin
  with dmStdRes do
  begin
   SaveDialog.FileName := l3PStr(GetDocumentExportName(DocumentForExport, aExportSelection));
   SaveDialog.DialogKind := ns_sdkDocument;
   if Text.HasSelection then
   begin
    SaveDialog.SelectedOnlyEnabled := true;
    SaveDialog.SelectedOnlyChecked := true;
   end//if Text.HasSelection then
   else
   begin
    SaveDialog.SelectedOnlyEnabled := false;
    SaveDialog.SelectedOnlyChecked := false;
   end;//if Text.HasSelection then
   if not SaveDialog.Execute then
    Exit;
   aExportSelection := SaveDialog.SelectedOnlyChecked;
   l_Output := TnsGetGenOutputStruct_Create(nsCStr(SaveDialog.FileName));
   l_F := SaveDialog.SelectedFileFormat;
   l_Ext := nsGetFileFormatExt(l_F);
   case l_F of
    ns_ffRTF :
     l_Format := CF_RTF;
    ns_ffTxt:
     l_Format := CF_TEXT;
    ns_ffHTML:
     l_Format := CF_HTML;
    ns_ffEvd:
     l_Format := CF_EverestTxt;
   end;//case SaveDialogFileFormat of
   l_Output.rName := nsCStr(ChangeFileExt(l3PStr(l_Output.rName), l_Ext));
  end;
 end
 else
 begin
  l_Output := TnsGetGenOutputStruct_Create(nsMakeTemporaryFileName(
   GetDocumentExportName(DocumentForExport, aExportSelection), '.rtf'));
  l_Format := CF_RTF;
  l_F := ns_ffRTF;
 end;//aNeedDialog
 try
  case anExportKind of
   ekShell, ekActiveWord:
    l_Visualizer := bsMakeExportVisualizer(vcmCStr(str_ExportDocumentVisualizer));
   ekDisk:
    l_Visualizer := bsMakeSaveVisualizer(vcmCStr(str_SaveDocumentVisualizer));
   ekEMail:
    l_Visualizer := bsMakeEMailVisualizer;
  else
   Assert(False);
  end;
  try
   l_Stream := Tl3NamedTextStream.Create(l3PStr(l_Output.rName), l3_fmWrite, 0);
   try
    case l_Format of
     CF_Locale :
     begin
      if nsGetGen(l_Output, l_F, l_G, l_H) then
       try
        l_G.Filer.Mode := l3_fmWrite;
        l_G.Filer.Stream := l_Stream;
        try
         nsSetExportFilters4PDF(l_H, Text.HiddenStyles);
         l_H.Start;
         try
          if aExportSelection then
          begin
           if afw.Application.Settings.LoadBoolean(pi_Document_ExportWithBlockNames, dv_Document_ExportWithBlockNames) then
           begin
            l_Head := TevdBlockNameAdder.Create;
            Ik2TagGenerator(l_Head).NextGenerator := l_H;
           end//afw.Application.Settings.LoadBoolean(pi_Document_ExportWithBlockNames, dv_Document_ExportWithBlockNames)
           else
            l_Head := l_H.Use;
           try
            l_Head.Start;
            try
             if Assigned(aRange) then
              aRange.AsStorable.Store(Text.View, l_Head)
             else
              InevSelection(Text.Selection).GetBlock.AsStorable.Store(Text.View, l_Head);
            finally
             l_Head.Finish;
            end;//try..finally
           finally
            FreeAndNil(l_Head);
           end;//try..finally
          end//aExportSelection
          else
           Text.Document.Range.AsStorable.Store(Text.View, l_H);
         finally
          l_H.Finish;
         end;//try..finally
        finally
         l_G.Filer.Stream := nil;
        end;//try..finally
       finally
        FreeAndNil(l_G);
        FreeAndNil(l_H);
       end;//try..finally
     end;//CF_Locale
     else
     begin
      if aExportSelection and Assigned(aRange) then
       aRange.Data.Store(l_Format, l_Stream, Text.MakeExportFilters(aExportSelection, true))
      else
       Text.SaveTo(l_Stream, l_Format, aExportSelection);
     end;//else
    end;//case l_F
   finally
    FreeAndNil(l_Stream);
   end;//try..finally
  finally
   l_Visualizer := nil;
  end;//try..finally
  Result := True;
  case anExportKind of
   ekDisk:
    TnsExportToFileEvent.Log(DocumentForExport);
   ekShell, ekActiveWord:
    begin
     if LowerCase(ExtractFileExt(l3PStr(l_Output.rName))) = '.rtf' then
      TnsExportToWordEvent.Log(DocumentForExport, aExportSelection, anExportKind = ekActiveWord);
     if anExportKind  = ekShell then
      Result := TnsToMSWordOp.Execute(l_Output.rName, mswekNewFile)
     else
      Result := TnsToMSWordOp.Execute(l_Output.rName, mswekActiveWindow);
    end;
   ekEMail:
    begin
     try
      Result := nsSendAttachedFile(l_Output.rName);
      TnsSendDocumentByEMailEvent.Log(DocumentForExport);
     except
      on EDefaultMailCLientAbsent do
       Say(err_DefaultMailCLientAbsent);
     end;
    end;
  else
   Assert(False);
  end;
 except
  on EStreamError do
  begin
   SysUtils.DeleteFile(l3PStr(l_Output.rName));
   Say(err_NotEnoughRoom, [ExtractFileName(l3PStr(l_Output.rName))]);
  end;//EStreamError
  on EOsError do
   Say(err_CannotCreateFile, [ExtractFileName(l3PStr(l_Output.rName))]);
  on EnevMaybeBaseSwitched do
   Say(err_ExportError, []);
 end;//try..except
//#UC END# *4A1FF17502AC_4AE1A69E0156_impl*
end;//_BaseTextOperations_.DocumentExport

procedure _BaseTextOperations_.DocumentPrint(aPrintDialog: Boolean = False);
var l_Preview: IafwComplexDocumentPreview;
//#UC START# *4AE1B21502BB_4AE1A69E0156_var*
//#UC END# *4AE1B21502BB_4AE1A69E0156_var*
begin
//#UC START# *4AE1B21502BB_4AE1A69E0156_impl*
 if aPrintDialog and
    ((afw.Application = nil) or
     (afw.Application.PrintManager = nil)) then
  Exit;
 l_Preview := MakePreview;
 if (l_Preview <> nil) then
 begin
  if (l_Preview.ContentKind = afw_pckSelection) then
   case MessageDlg(str_PrintSelectedConfirmation) of
    -1:
     ;
    -2:
     l_Preview.ContentKind := afw_pckDocument;
    mrCancel:
     Exit; 
   end;//case MessageDlg(str_DocumentPrintSelectedConfirmation)
  if aPrintDialog then
   afw.Application.PrintManager.PrintDialog(l_Preview)
  else
   l_Preview.Print;
 end;//l_Preview <> nil
//#UC END# *4AE1B21502BB_4AE1A69E0156_impl*
end;//_BaseTextOperations_.DocumentPrint

function _BaseTextOperations_.MakePreview: IafwComplexDocumentPreview;
//#UC START# *4AE1B41802E4_4AE1A69E0156_var*
//#UC END# *4AE1B41802E4_4AE1A69E0156_var*
begin
//#UC START# *4AE1B41802E4_4AE1A69E0156_impl*
 Result := Text.Preview;
//#UC END# *4AE1B41802E4_4AE1A69E0156_impl*
end;//_BaseTextOperations_.MakePreview

procedure _BaseTextOperations_.MakeMacroReplacer(Sender: TObject;
 var aReplacer: Il3HAFMacroReplacer);
//#UC START# *4AE1864F024B_4AE1A69E0156_var*
var
 l_F : IucpHAFMacroReplacerFactory;
//#UC END# *4AE1864F024B_4AE1A69E0156_var*
begin
//#UC START# *4AE1864F024B_4AE1A69E0156_impl*
 l_F := HAFMacroReplacerFactory;
 if (l_F <> nil) then
  aReplacer := l_F.MakeHAFMacroReplacer;
//#UC END# *4AE1864F024B_4AE1A69E0156_impl*
end;//_BaseTextOperations_.MakeMacroReplacer

procedure _BaseTextOperations_.DoMakeExportFilters(aSelection: Boolean;
 aForExport: Boolean;
 var theGen: Ik2TagGenerator);
//#UC START# *4DCD5DE203C5_4AE1A69E0156_var*
//#UC END# *4DCD5DE203C5_4AE1A69E0156_var*
begin
//#UC START# *4DCD5DE203C5_4AE1A69E0156_impl*
 Tf1MultilinkResolver.SetTo(theGen, DocumentForExport);
//#UC END# *4DCD5DE203C5_4AE1A69E0156_impl*
end;//_BaseTextOperations_.DoMakeExportFilters

function _BaseTextOperations_.GetDocumentExportName(const aDoc: IDocument;
 aExportSelection: Boolean): Il3CString;
//#UC START# *53D8D3E90248_4AE1A69E0156_var*
//#UC END# *53D8D3E90248_4AE1A69E0156_var*
begin
//#UC START# *53D8D3E90248_4AE1A69E0156_impl*
 Result := GetDocumentShortName(aDoc, aExportSelection);
 if l3IsNil(Result) then
  Result := CreateFileName(aDoc, aExportSelection)
 else
  Result := CreateFileName(Result, aExportSelection);
//#UC END# *53D8D3E90248_4AE1A69E0156_impl*
end;//_BaseTextOperations_.GetDocumentExportName

function _BaseTextOperations_.GetDocumentShortName(const aDoc: IDocument;
 aExportSelection: Boolean): Il3CString;
//#UC START# *53D8E4B702E4_4AE1A69E0156_var*
//#UC END# *53D8E4B702E4_4AE1A69E0156_var*
begin
//#UC START# *53D8E4B702E4_4AE1A69E0156_impl*
 Result := nil;
//#UC END# *53D8E4B702E4_4AE1A69E0156_impl*
end;//_BaseTextOperations_.GetDocumentShortName

procedure _BaseTextOperations_.NotEmptyDocumentTest(const aParams: IvcmTestParamsPrim);
 {* Проверяет, что документ непустой }
//#UC START# *4AE1BA9302E5_4AE1A69E0156_var*
//#UC END# *4AE1BA9302E5_4AE1A69E0156_var*
begin
//#UC START# *4AE1BA9302E5_4AE1A69E0156_impl*
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := TextSource.HasDocument;
//#UC END# *4AE1BA9302E5_4AE1A69E0156_impl*
end;//_BaseTextOperations_.NotEmptyDocumentTest

procedure _BaseTextOperations_.NotEmptyDocumentWithTrialModeTest(const aParams: IvcmTestParamsPrim);
 {* Проверяет, что документ не пустой и версия не демонстрационная }
//#UC START# *4AE1BAA102BD_4AE1A69E0156_var*
//#UC END# *4AE1BAA102BD_4AE1A69E0156_var*
begin
//#UC START# *4AE1BAA102BD_4AE1A69E0156_impl*
 NotEmptyDocumentTest(aParams);
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4AE1BAA102BD_4AE1A69E0156_impl*
end;//_BaseTextOperations_.NotEmptyDocumentWithTrialModeTest

function _BaseTextOperations_.AddBookmark(const aPara: IeeLeafPara): Boolean;
//#UC START# *4AE1C14801CE_4AE1A69E0156_var*
var
 l_Bookmark : IBookmark;

const
 cIsDrugDocument: array [Boolean] of TFoldersElementType = (
   fetBookMark,
   fetDrugBookmark
 );
 
//#UC END# *4AE1C14801CE_4AE1A69E0156_var*
begin
//#UC START# *4AE1C14801CE_4AE1A69E0156_impl*
 Result := false;
 if (aPara <> nil) then
 begin
  CreateBookmark(DocumentForExport, aPara.ID, true, l_Bookmark);
  if (l_Bookmark <> nil) then
  try
   Result := 
    TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                       FilterInfoFactory.MakeFilterInfo(ffListAndBookMarks),
                       cIsDrugDocument[IsDrug],
                       l_Bookmark,
                       false) = mrOk;
   if Result then
    PostMessage(Handle, CM_NEED_TO_OPEN_CONTENTS, 0, 0);
  finally
   l_Bookmark := nil;
  end;//try..finally
 end;//aPara <> nil 
//#UC END# *4AE1C14801CE_4AE1A69E0156_impl*
end;//_BaseTextOperations_.AddBookmark

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_Print_Test(const aParams: IvcmTestParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4AE1A69E0156test_var*
//#UC END# *49521D8E0295_4AE1A69E0156test_var*
begin
//#UC START# *49521D8E0295_4AE1A69E0156test_impl*
 aParams.CallControl;
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasDoc;
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := Printer.Printers.Count > 0;
 nsDisableOperationInTrialMode(aParams);
//#UC END# *49521D8E0295_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_Print_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4AE1A69E0156exec_var*
var
 l_Preview: IafwComplexDocumentPreview;
//#UC END# *49521D8E0295_4AE1A69E0156exec_var*
begin
//#UC START# *49521D8E0295_4AE1A69E0156exec_impl*
 l_Preview := MakePreview;
 try
  l_Preview.Print;
 finally
  l_Preview := nil;
 end;//try..finally
//#UC END# *49521D8E0295_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_Print_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4AE1A69E0156test_var*
//#UC END# *495220DE0298_4AE1A69E0156test_var*
begin
//#UC START# *495220DE0298_4AE1A69E0156test_impl*
 aParams.CallControl;
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasDoc;
//#UC END# *495220DE0298_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_PrintDialog_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4AE1A69E0156exec_var*
//#UC END# *495220DE0298_4AE1A69E0156exec_var*
begin
//#UC START# *495220DE0298_4AE1A69E0156exec_impl*
 DocumentPrint(True);
//#UC END# *495220DE0298_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_PrintDialog_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4AE1A69E0156test_var*
//#UC END# *495220F2033A_4AE1A69E0156test_var*
begin
//#UC START# *495220F2033A_4AE1A69E0156test_impl*
 aParams.CallControl;
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasDoc;
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := Printer.Printers.Count > 0;
//#UC END# *495220F2033A_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_PrintPreview_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4AE1A69E0156exec_var*
//#UC END# *495220F2033A_4AE1A69E0156exec_var*
begin
//#UC START# *495220F2033A_4AE1A69E0156exec_impl*
 TnsDocumentPrintPreviewEvent.Log(DocumentForExport);
 aParams.CallControl;
//#UC END# *495220F2033A_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_PrintPreview_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_Save_Test(const aParams: IvcmTestParamsPrim);
 {* Сохранить }
//#UC START# *495235F401C0_4AE1A69E0156test_var*
//#UC END# *495235F401C0_4AE1A69E0156test_var*
begin
//#UC START# *495235F401C0_4AE1A69E0156test_impl*
 NotEmptyDocumentWithTrialModeTest(aParams);
//#UC END# *495235F401C0_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_Save_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сохранить }
//#UC START# *495235F401C0_4AE1A69E0156exec_var*
//#UC END# *495235F401C0_4AE1A69E0156exec_var*
begin
//#UC START# *495235F401C0_4AE1A69E0156exec_impl*
 DocumentExport(ekDisk, Text.HasSelection);
//#UC END# *495235F401C0_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_Save_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure _BaseTextOperations_.File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
 {* Экспорт в Word }
//#UC START# *495238EB0160_4AE1A69E0156test_var*
//#UC END# *495238EB0160_4AE1A69E0156test_var*
begin
//#UC START# *495238EB0160_4AE1A69E0156test_impl*
 File_Save_Test(aParams);
 TnsToMSWordOp.Test(aParams);
//#UC END# *495238EB0160_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_ToMSWord_Test

procedure _BaseTextOperations_.File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Экспорт в Word }
//#UC START# *495238EB0160_4AE1A69E0156exec_var*
var
 lExportSelection : Boolean;
const
 cMap: array [Boolean] of TnsExportKind = (ekShell, ekActiveWord);
//#UC END# *495238EB0160_4AE1A69E0156exec_var*
begin
//#UC START# *495238EB0160_4AE1A69E0156exec_impl*
 lExportSelection := Text.HasSelection;
 // Экспортировать выделенные фрагменты в Word
 if (lExportSelection) then
  case MessageDlg(str_ExportSelectionToWord) of
    -1:
     // - выделение
     ;
    -2:
     lExportSelection := False;
    mrCancel:
     Exit;
  end;//case MessageDlg(str_ExportSelectionToWord)
 DocumentExport(cMap[aParams.ItemIndex>1], lExportSelection);
//#UC END# *495238EB0160_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_ToMSWord_Execute

procedure _BaseTextOperations_.File_SendMailAsAttachment_Test(const aParams: IvcmTestParamsPrim);
 {* Послать по e-mail }
//#UC START# *495253870002_4AE1A69E0156test_var*
//#UC END# *495253870002_4AE1A69E0156test_var*
begin
//#UC START# *495253870002_4AE1A69E0156test_impl*
 NotEmptyDocumentWithTrialModeTest(aParams);
//#UC END# *495253870002_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_SendMailAsAttachment_Test

procedure _BaseTextOperations_.File_SendMailAsAttachment_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Послать по e-mail }
//#UC START# *495253870002_4AE1A69E0156exec_var*
var
 l_ExportSelection : Boolean;
//#UC END# *495253870002_4AE1A69E0156exec_var*
begin
//#UC START# *495253870002_4AE1A69E0156exec_impl*
 l_ExportSelection := Text.HasSelection;
 // Экспортировать выделенные фрагменты в Word
 if (l_ExportSelection) then
  case MessageDlg(str_DocumentEMailSelection) of
    -1:
     ; // выделение
    -2:
     l_ExportSelection := False;
    mrCancel:
     Exit;
  end;//case MessageDlg(str_DocumentEMailSelection)
 DocumentExport(ekEMail, l_ExportSelection);
//#UC END# *495253870002_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_SendMailAsAttachment_Execute

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AE1A69E0156_var*
//#UC END# *4A8E8F2E0195_4AE1A69E0156_var*
begin
//#UC START# *4A8E8F2E0195_4AE1A69E0156_impl*
 Text.TextSource := Self.TextSource;
 inherited;
 Text.OnMakeMacroReplacer := Self.MakeMacroReplacer;
 Text.OnMakeExportFilters := Self.DoMakeExportFilters;
//#UC END# *4A8E8F2E0195_4AE1A69E0156_impl*
end;//_BaseTextOperations_.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf BaseTextOperations_imp_impl}

{$EndIf BaseTextOperations_imp}

