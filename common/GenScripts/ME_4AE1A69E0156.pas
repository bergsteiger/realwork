{$IfNDef BaseTextOperations_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseTextOperations.imp.pas"
// Стереотип: "VCMForm"

{$Define BaseTextOperations_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _Text_Parent_ = _BaseTextOperations_Parent_;
 {$Include Text.imp.pas}
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
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ToMSWord; override;
    {* Экспорт в Word }
   procedure SendMailAsAttachment; override;
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
{$Include Text.imp.pas}
_BaseTextOperations_ = _Text_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseTextOperations_imp}

{$IfNDef BaseTextOperations_imp_impl}

{$Define BaseTextOperations_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include Text.imp.pas}

function _BaseTextOperations_.DocumentExport(anExportKind: TnsExportKind;
 aExportSelection: Boolean;
 const aRange: InevRange = nil): Boolean;
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
procedure _BaseTextOperations_.Print;
 {* Печать }
//#UC START# *49521D8E0295_4AE1A69E0156_var*
//#UC END# *49521D8E0295_4AE1A69E0156_var*
begin
//#UC START# *49521D8E0295_4AE1A69E0156_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4AE1A69E0156_impl*
end;//_BaseTextOperations_.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4AE1A69E0156_var*
//#UC END# *495220DE0298_4AE1A69E0156_var*
begin
//#UC START# *495220DE0298_4AE1A69E0156_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4AE1A69E0156_impl*
end;//_BaseTextOperations_.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4AE1A69E0156_var*
//#UC END# *495220F2033A_4AE1A69E0156_var*
begin
//#UC START# *495220F2033A_4AE1A69E0156_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4AE1A69E0156_impl*
end;//_BaseTextOperations_.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _BaseTextOperations_.Save;
 {* Сохранить }
//#UC START# *495235F401C0_4AE1A69E0156_var*
//#UC END# *495235F401C0_4AE1A69E0156_var*
begin
//#UC START# *495235F401C0_4AE1A69E0156_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AE1A69E0156_impl*
end;//_BaseTextOperations_.Save
{$IfEnd} // NOT Defined(NoVCM)

procedure _BaseTextOperations_.ToMSWord;
 {* Экспорт в Word }
//#UC START# *495238EB0160_4AE1A69E0156_var*
//#UC END# *495238EB0160_4AE1A69E0156_var*
begin
//#UC START# *495238EB0160_4AE1A69E0156_impl*
 !!! Needs to be implemented !!!
//#UC END# *495238EB0160_4AE1A69E0156_impl*
end;//_BaseTextOperations_.ToMSWord

procedure _BaseTextOperations_.SendMailAsAttachment;
 {* Послать по e-mail }
//#UC START# *495253870002_4AE1A69E0156_var*
//#UC END# *495253870002_4AE1A69E0156_var*
begin
//#UC START# *495253870002_4AE1A69E0156_impl*
 !!! Needs to be implemented !!!
//#UC END# *495253870002_4AE1A69E0156_impl*
end;//_BaseTextOperations_.SendMailAsAttachment

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

