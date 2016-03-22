{$IfNDef BaseTextOperations_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseTextOperations.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::BaseTextOperations
//
// ������� �������� � �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseTextOperations_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _Text_Parent_ = _BaseTextOperations_Parent_;
 {$Include ..\View\Text.imp.pas}
 _BaseTextOperations_ = {abstract form} class(_Text_)
  {* ������� �������� � ������� }
 private
 // private fields
   f_Text : TnscEditor;
    {* ���� ��� �������� Text}
   f_TextSource : TnscTextSource;
    {* ���� ��� �������� TextSource}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure MakeMacroReplacer(Sender: TObject;
     var aReplacer: Il3HAFMacroReplacer);
 protected
 // property methods
   function pm_GetHasDoc: Boolean; virtual; abstract;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* ������ }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* ������... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
     {* ��������������� �������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ��������������� �������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
     {* ��������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ��������� }
   {$IfEnd} //not NoVCM
   procedure File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
     {* ������� � Word }
   procedure File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� � Word }
   procedure File_SendMailAsAttachment_Test(const aParams: IvcmTestParamsPrim);
     {* ������� �� e-mail }
   procedure File_SendMailAsAttachment_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� �� e-mail }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   HAFMacroReplacerFactory : IucpHAFMacroReplacerFactory;
   FilterInfoFactory : IucpFilterInfoFactory;
 protected
 // protected methods
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
     {* ���������, ��� �������� �������� }
   procedure NotEmptyDocumentWithTrialModeTest(const aParams: IvcmTestParamsPrim);
     {* ���������, ��� �������� �� ������ � ������ �� ���������������� }
   function AddBookmark(const aPara: IeeLeafPara): Boolean;
   function IsDrug: Boolean; virtual; abstract;
 protected
 // protected properties
   property TextSource: TnscTextSource
     read f_TextSource;
     {* �������� ������ }
   property HasDoc: Boolean
     read pm_GetHasDoc;
     {* ��������� ������� ��������� }
 public
 // public properties
   property Text: TnscEditor
     read f_Text;
 end;//_BaseTextOperations_
{$Else}

 _Text_Parent_ = _BaseTextOperations_Parent_;
 {$Include ..\View\Text.imp.pas}
 _BaseTextOperations_ = _Text_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseTextOperations_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\View\Text.imp.pas}

// start class _BaseTextOperations_

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

function _BaseTextOperations_.DocumentExport(anExportKind: TnsExportKind;
  aExportSelection: Boolean;
  const aRange: InevRange = nil): Boolean;
//#UC START# *4A1FF17502AC_4AE1A69E0156_var*
var
 l_H    : Tk2TagGenerator;
 l_Output : TnsGetGenOutputStruct;
//#UC END# *4A1FF17502AC_4AE1A69E0156_var*
var
 l_Ext : AnsiString;
 l_PathName : Il3CString;
 l_Stream : Tl3Stream;
 l_Format : Tl3ClipboardFormat;
 l_F : TnsFileFormat;
 l_G : Tk2CustomFileGenerator;
 l_Visualizer : IafwLongProcessVisualizer;
 l_Head : Tk2TagGenerator; // ������ ������� �����������
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
var
 l_Preview : IafwComplexDocumentPreview;
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
//#UC START# *4AE1BA9302E5_4AE1A69E0156_var*
//#UC END# *4AE1BA9302E5_4AE1A69E0156_var*
begin
//#UC START# *4AE1BA9302E5_4AE1A69E0156_impl*
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := TextSource.HasDocument;
//#UC END# *4AE1BA9302E5_4AE1A69E0156_impl*
end;//_BaseTextOperations_.NotEmptyDocumentTest

procedure _BaseTextOperations_.NotEmptyDocumentWithTrialModeTest(const aParams: IvcmTestParamsPrim);
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

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_Print_Test(const aParams: IvcmTestParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_4AE1A69E0156test_var*
//#UC END# *495220DE0298_4AE1A69E0156test_var*
begin
//#UC START# *495220DE0298_4AE1A69E0156test_impl*
 aParams.CallControl;
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasDoc;
//#UC END# *495220DE0298_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4AE1A69E0156exec_var*
//#UC END# *495220DE0298_4AE1A69E0156exec_var*
begin
//#UC START# *495220DE0298_4AE1A69E0156exec_impl*
 DocumentPrint(True);
//#UC END# *495220DE0298_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4AE1A69E0156exec_var*
//#UC END# *495220F2033A_4AE1A69E0156exec_var*
begin
//#UC START# *495220F2033A_4AE1A69E0156exec_impl*
 TnsDocumentPrintPreviewEvent.Log(DocumentForExport);
 aParams.CallControl;
//#UC END# *495220F2033A_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495235F401C0_4AE1A69E0156test_var*
//#UC END# *495235F401C0_4AE1A69E0156test_var*
begin
//#UC START# *495235F401C0_4AE1A69E0156test_impl*
 //NotEmptyDocumentWithTrialModeTest(aParams);
 NotEmptyDocumentTest(aParams);
//#UC END# *495235F401C0_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_Save_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495235F401C0_4AE1A69E0156exec_var*
//#UC END# *495235F401C0_4AE1A69E0156exec_var*
begin
//#UC START# *495235F401C0_4AE1A69E0156exec_impl*
 DocumentExport(ekDisk, Text.HasSelection);
//#UC END# *495235F401C0_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_Save_Execute
{$IfEnd} //not NoVCM

procedure _BaseTextOperations_.File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495238EB0160_4AE1A69E0156test_var*
//#UC END# *495238EB0160_4AE1A69E0156test_var*
begin
//#UC START# *495238EB0160_4AE1A69E0156test_impl*
 File_Save_Test(aParams);
 TnsToMSWordOp.Test(aParams);
//#UC END# *495238EB0160_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_ToMSWord_Test

procedure _BaseTextOperations_.File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495238EB0160_4AE1A69E0156exec_var*
var
 lExportSelection : Boolean;
const
 cMap: array [Boolean] of TnsExportKind = (ekShell, ekActiveWord);
//#UC END# *495238EB0160_4AE1A69E0156exec_var*
begin
//#UC START# *495238EB0160_4AE1A69E0156exec_impl*
 lExportSelection := Text.HasSelection;
 // �������������� ���������� ��������� � Word
 if (lExportSelection) then
  case MessageDlg(str_ExportSelectionToWord) of
    -1:
     // - ���������
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
//#UC START# *495253870002_4AE1A69E0156test_var*
//#UC END# *495253870002_4AE1A69E0156test_var*
begin
//#UC START# *495253870002_4AE1A69E0156test_impl*
 //NotEmptyDocumentWithTrialModeTest(aParams);
 NotEmptyDocumentTest(aParams);
//#UC END# *495253870002_4AE1A69E0156test_impl*
end;//_BaseTextOperations_.File_SendMailAsAttachment_Test

procedure _BaseTextOperations_.File_SendMailAsAttachment_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495253870002_4AE1A69E0156exec_var*
var
 l_ExportSelection : Boolean;
//#UC END# *495253870002_4AE1A69E0156exec_var*
begin
//#UC START# *495253870002_4AE1A69E0156exec_impl*
 l_ExportSelection := Text.HasSelection;
 // �������������� ���������� ��������� � Word
 if (l_ExportSelection) then
  case MessageDlg(str_DocumentEMailSelection) of
    -1:
     ; // ���������
    -2:
     l_ExportSelection := False;
    mrCancel:
     Exit;
  end;//case MessageDlg(str_DocumentEMailSelection)
 DocumentExport(ekEMail, l_ExportSelection);
//#UC END# *495253870002_4AE1A69E0156exec_impl*
end;//_BaseTextOperations_.File_SendMailAsAttachment_Execute

{$If not defined(NoVCM)}
procedure _BaseTextOperations_.InitControls;
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
{$IfEnd} //not NoVCM

procedure _BaseTextOperations_.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  HAFMacroReplacerFactory := nil;
  FilterInfoFactory := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IucpHAFMacroReplacerFactory, HAFMacroReplacerFactory);
  Supports(aDsNew, IucpFilterInfoFactory, FilterInfoFactory);
 end;//aDsNew = nil
end;

procedure _BaseTextOperations_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Redactions, nil);
  MakeEntitySupportedByControl(en_Redactions, Text);
  PublishFormEntity(en_TimeMachine, nil);
  MakeEntitySupportedByControl(en_TimeMachine, Text);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Save, File_Save_Execute, File_Save_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_File, op_ToMSWord, File_ToMSWord_Execute, File_ToMSWord_Test, nil);
  PublishOp(en_File, op_SendMailAsAttachment, File_SendMailAsAttachment_Execute, File_SendMailAsAttachment_Test, nil, true);
 end;//with Entities.Entities
end;

procedure _BaseTextOperations_.MakeControls;
begin
 inherited;
 f_Text := TnscEditor.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 f_TextSource := TnscTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseTextOperations_imp}
