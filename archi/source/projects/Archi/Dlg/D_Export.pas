unit D_Export;

{ $Id: D_Export.pas,v 1.97 2015/10/14 10:19:21 fireton Exp $ }

{$I ProjectDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RightBtnDlg, ExtCtrls, StdCtrls, Mask, ToolEdit, vtHeader, Buttons,
  HelpCnst,
  SrchWin, TabRBtnDlg, ComCtrls, OvcBase, vtlister,  vtSpin, afwControl,
  afwInputControl, afwControlPrim, afwBaseControl, DT_Types, CheckLst;

type
  TExportDlg = class(TTabRBtnDlg)
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    cbWorkDir: TComboBox;
    gbExpType: TRadioGroup;
    cbxWithDict: TCheckBox;
    lstDicts: TvtDStringlister;
    cbxViaServer: TCheckBox;
    gbExportThings: TGroupBox;
    cbOutFormat: TComboBox;
    Label6: TLabel;
    gbExpMethod: TGroupBox;
    Label4: TLabel;
    rbSeparatedFiles: TRadioButton;
    rbOneFile: TRadioButton;
    cbxPieceSize: TCheckBox;
    edPieceSize: TvtSpinEdit;
    gbPaths: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    edtDocFileName: TEdit;
    edtSprFileName: TEdit;
    edtObjFileName: TEdit;
    edtAnnoFileName: TEdit;
    btnSelectDir: TSpeedButton;
    comboToRegionList: TComboBox;
    Label8: TLabel;
    checkExportParts: TCheckListBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure cbxExpTextClick(Sender: TObject);
    procedure rgOutMethodClick(Sender: TObject);
    procedure rbOneFileClick(Sender: TObject);
    procedure rbSeparatedFilesClick(Sender: TObject);
    procedure cbOutFormatChange(Sender: TObject);
    procedure gbExpTypeClick(Sender: TObject);
    procedure btnSelectDirClick(Sender: TObject);
    procedure checkExportPartsClickCheck(Sender: TObject);
  private
    procedure AddPathToHistory;
    procedure CheckPathWritable(const aPath: AnsiString);
    { Private declarations }
  protected
    procedure FillToRegionList;
    function ItemIndexToDictID: TDictID;
  public
    { Public declarations }
  end;


procedure DoDocExport(aSWin : TSearchWin; aViaServer: Boolean);

implementation

{$R *.DFM}

Uses
 Main,
 l3Base, l3FileUtils, l3IniFile,
 daDataProvider,
 daTypes,
 HT_Const, HT_Dll,
 DT_Const, dt_AttrSchema,
 dtIntf, DT_Sab,
 DT_Dict, DT_Doc, 
 ExportPipe, ArchiUserRequestManager, ddServerTask,
 IniShop, VConst,
 //DictsSup,
 DocAttrUtils, ddClientBaseEngine,
 D_SelectDir, BtnDlg, l3Languages, Base_CFG, csExport, DT_DictConst,
//  l3LongintListPrim,
 l3MultiThreadIntegerList, ddPipeOutInterfaces
 ;

procedure DoDocExport(aSWin : TSearchWin; aViaServer: Boolean);
 var
  //Progress   : TProgressDlg;
  ExpSrv     : TExportPipe;
  lExpDlg    : TExportDlg;

  l_FileName: ShortString;
  l_Stream: TStream;
  tmpSab: SAB;
  l_Params: TcsExport;
  l_Sab: ISab;

 begin
  lExpDlg := TExportDlg.Create(MainForm);

  With lExpDlg do
   try
    {$IfDef DisableNSRCOut}
     rbSeparatedFiles.Checked := True;
     TabSheet2.TabVisible := False;
     TabSheet3.TabVisible := False;
     TabSheet4.TabVisible := False;

     //PageCtrl.Pages[1].Visible := False;
     //PageCtrl.Pages[2].Visible := False;
     //PageCtrl.Pages[3].Visible := False;
    {$EndIf}

    StationConfig.Section := PrefSectName;
    cbxViaServer.Visible :=  StationConfig.ReadParamBoolDef('Admin',false);
    cbxViaServer.Checked := g_BaseEngine.CSClient.IsStarted; //сервер запущен
    cbxViaServer.Enabled := cbxViaServer.Checked;
    comboToRegionList.Visible := cbxViaServer.Checked;

    if ShowModal = mrOk then
     if not aSWin.DocList.Query.IsEmpty then
     begin
      Application.ProcessMessages;
      Screen.Cursor:=crHourGlass;
      try
       if cbxViaServer.Checked then
       begin
        l_Params := TcsExport.Create({nil,} GlobalDataProvider.UserID);
        try
 //        l_Params.UserID                := GlobalDataProvider.UserID;
         l_Params.ExportEmptyKW         := False;
         l_Params.ExportDocument        := checkExportParts.Checked[0];
         l_Params.ExportReferences      := checkExportParts.Checked[1];
         l_Params.ExportRTFBody         := False;
         l_Params.ExportAnnoTopics      := checkExportParts.Checked[2];
         l_Params.ExportDocImage        := checkExportParts.Checked[3];
         l_Params.ExportKW              := checkExportParts.Checked[4];
         l_Params.FormulaAsPicture      := checkExportParts.Checked[5];
         l_Params.MultiUser             := True;
         l_Params.Family                := CurrentFamily;
         l_Params.InternalFormat        := False;
         l_Params.OutFileType           := TepSupportFileType(cbOutFormat.ItemIndex);
         If rbSeparatedFiles.Checked then
          l_Params.SeparateFiles  := divTopic
         else
          If cbxPieceSize.Checked then
          begin
           l_Params.SeparateFiles     := divSize;
           l_Params.OutputFileSize     := edPieceSize.AsInteger * 1024;
          end
          else
           l_Params.SeparateFiles := divNone;
         { TODO -oДмитрий Дудко -cРазвитие : Обновлять файлы нужно на этапе возвращения задания }
         //l_Params.UpdateFiles          := cbxAppend.Checked;
         l_Params.ToRegion              := ItemIndexToDictID;
         l_Params.DocumentFileNameMask  := ExtractFileName(edtDocFileName.Text);
         l_Params.ReferenceFileNameMask := ExtractFileName(edtSprFileName.Text);
         l_Params.ObjTopicFileName      := ExtractFileName(edtObjFileName.Text);
         l_Params.ExportDirectory       := Trim(cbWorkDir.Text);
         l_Params.AnnoTopicFileName     := ExtractFileName(edtAnnoFileName.Text);
         l_Params.OnlyStructure         := False;
         if gbExpType.ItemIndex = 0 then
         begin
          if aSWin.DocList.SrchResultLister.Current <> -1 then
          begin
           l_Params.DocID                 := aSWin.DocList.QueryProvider.GetItem(aSWin.DocList.SrchResultLister.Current).rID;
           l_Params.DiapasonType          := tdSingle;
          end
          else
          begin
           // Видимо, стоит сообщить
           MessageDlg('Нечего экспортировать', mtWarning, [mbOk], 0);
           Exit;
          end;
         end
         else
         begin
          l_Params.DiapasonType := tdNumList;
          l_Sab := aSWin.DocList.QueryProvider.MakeDocIDList;
          if (l_Sab = nil) or l_Sab.IsEmpty then
          begin
           // Видимо, стоит сообщить
           MessageDlg('Нечего экспортировать', mtWarning, [mbOk], 0);
           Exit;
          end;
          dtOutSabToStream(l_Sab, l_Params.SABStream);
         end;
         ArchiRequestManager.SendTask(l_Params)
        finally
         l3Free(l_Params);
        end
       end
       else
       begin // Самостоятельный экспорт
        ExpSrv := TExportPipe.Create{(lExpDlg)};
        try
         ExpSrv.Family := aSWin.Family;
         ExpSrv.CodePage:= l3CodePageFromLangID(GlobalDataProvider.BaseLanguage[aSWin.Family].LanguageID,TepSupportFileType(cbOutFormat.ItemIndex) = outNSRC);
         case gbExpType.ItemIndex of
          0 : ExpSrv.MakeSingleDocSab(aSWin.DocList.QueryProvider.GetItem(aSWin.DocList.SrchResultLister.Current).rID, False);
          1 : ExpSrv.DocSab := aSWin.DocList.QueryProvider.MakeDocIDList;
         end;

         //!!! ExpSrv.TotalProgressProc := aSWin.PercentMeter.ProgressProc_ev; {Progress.ProgressProc;}
         //ExpSrv.DServer.Renum := True;

         ExpSrv.ExportDirectory   := Trim(cbWorkDir.Text);
         //ExpSrv.ReferenceDirectory := cbWorkDir.Text;
         ExpSrv.FileMask[edpDocument]   := l3CStr(ExtractFileName(edtDocFileName.Text));
         ExpSrv.FileMask[edpReference]  := l3CStr(ExtractFileName(edtSprFileName.Text));
         ExpSrv.FileMask[edpAnnotation] := l3CStr(ExtractFileName(edtAnnoFileName.Text));
         ExpSrv.ObjTopicFileName        := ExtractFileName(edtObjFileName.Text);

         If rbSeparatedFiles.Checked then
          ExpSrv.AllPartsDivideBy([edbTopic])
         else
          If cbxPieceSize.Checked then
          begin
           ExpSrv.AllPartsDivideBy([edbSize]);
           ExpSrv.OutputFileSize     := edPieceSize.AsInteger * 1024;
          end
          else
           ExpSrv.AllPartsDivideBy([]); //none

         //ExpSrv.UpdateFiles          := cbxAppend.Checked;
         ExpSrv.ExportRTFBody        := False; //cbxRTFBodyOut.Checked;
         //cbxViaServer.Enabled and cbxViaServer.Checked;

         //ExpSrv.InternalFormat := True; //!!!

         ExpSrv.OutFileType := TepSupportFileType(cbOutFormat.ItemIndex);
        {$IfDef DisableNSRCOut}
         ExpSrv.OutFileType := outRTF;
        {$EndIf}

         ExpSrv.ExportDocument := checkExportParts.Checked[0];
         //ExpSrv.WorkVAnonced := cbxAsAnonced.Checked;
         ExpSrv.ExportReferences:= checkExportParts.Checked[1];
         ExpSrv.ExportAnnotation := checkExportParts.Checked[2];
         ExpSrv.ExportDocImage := checkExportParts.Checked[3];
         ExpSrv.ExportKW := checkExportParts.Checked[4];
        {$IfDef DisableNSRCOut}
         ExpSrv.ExportKW := False;
        {$EndIf}
         ExpSrv.FormulaAsPicture := checkExportParts.Checked[5];
        {$IfDef DisableNSRCOut}
         if chbWithDict.Checked then
          ExpSrv.Dicts := GetSelectOfAttrList(lstDicts.Items);
        {$EndIf}

         If checkExportParts.Checked[4] then
          // перевыкачать KW
         begin
          DictServer(aSWin.Family).DictRootNode[da_dlKeyWords].Load;
         end;
         // ExpSrv.TaskPriority := ?
         ExpSrv.Execute;
        finally
         l3Free(ExpSrv);
        end;
       end;
      finally
       Screen.Cursor:=crDefault;
      end;
      {Progress.Free;}
     end; // if not aSWin.DocList.Query.IsEmpty then
   finally
    Free;
   end;
 end;

procedure TExportDlg.AddPathToHistory;
var
 l_Idx: Integer;
 l_Str: string;
begin
 l_Str := Trim(cbWorkDir.Text);
 if l_Str = '' then
  Exit;
 l_Idx := cbWorkDir.Items.IndexOf(l_Str);
 if l_Idx = -1 then
  cbWorkDir.Items.Insert(0, l_Str)
 else
  cbWorkDir.Items.Move(l_Idx, 0);
 cbWorkDir.ItemIndex:= 0;
end;

procedure TExportDlg.FormActivate(Sender: TObject);
 begin
  inherited;
  If cbWorkDir.Text = '' then ActiveControl := cbWorkDir;
 end;

procedure TExportDlg.FormCreate(Sender: TObject);
 begin
  inherited;
  UserConfig.Section := 'Export';
  cbWorkDir.Text         := UserConfig.ReadParamStrDef ('ExpDir','');
  with checkExportParts do
  begin
   Checked[0] := UserConfig.ReadParamBoolDef('ExpText', True);
   Checked[1] := UserConfig.ReadParamBoolDef('ExpRel', True);;
   Checked[2] := UserConfig.ReadParamBoolDef('ExpAnno', False);
   Checked[3] := UserConfig.ReadParamBoolDef('ExpImages', False);
   Checked[4] := UserConfig.ReadParamBoolDef('ExpKW', False);
   Checked[5] := False;
  end; // with checkExportParts
  gbExpType.ItemIndex    := UserConfig.ReadParamIntDef ('ExpType',0);

  cbxWithDict.Checked    := UserConfig.ReadParamBoolDef('ExpWithDir', False);

  edtDocFileName.Text    := UserConfig.ReadParamStrDef ('DocFileName','document.nsr');
  edtSprFileName.Text    := UserConfig.ReadParamStrDef ('SprFileName','related.nsr');
  edtObjFileName.Text    := UserConfig.ReadParamStrDef ('ObjFileName','objtopic.nsr');
  edtAnnoFileName.Text   := UserConfig.ReadParamStrDef ('AnnoFileName','Annotat.nsr');


  rbSeparatedFiles.checked := UserConfig.ReadParamIntDef ('OutMethod',0) = 1;
  edPieceSize.AsInteger    := UserConfig.ReadParamIntDef('OutFilrPieceSize', 0);
  cbxPieceSize.Checked     := UserConfig.ReadParamBoolDef('cbxPieceSize', False);
  //cbxAppend.Checked        := UserConfig.ReadParamBoolDef('cbxAppend', False);
  //cbxViaServer.Checked   := UserConfig.ReadParamBoolDef('cbxExportViaServer', False);
  //cbxRTFBodyOut.Checked  := UserConfig.ReadParamBoolDef('RTFBodyOut', False);
  rgOutMethodClick(Self);

  cbOutFormat.ItemIndex    := UserConfig.ReadParamIntDef('OutFormat', 3 {NSRC});
  cbOutFormatChange(Self);

  // Читаем историю путей
  UserConfig.Section := 'ExportPathHistory';
  UserConfig.ReadParamList('PathHistory', cbWorkDir.Items, 10);

  //cgbDict.GroupCheckData := UserConfig.ReadParamIntDef ('CheckDicts',0);
  HelpContext := hcExport;
  LoadAttrList(_DictAttrSet, lstDicts.Items);
  // Установить список "Переданы в регион"
  FillToRegionList;
 end;

procedure TExportDlg.OKClick(Sender: TObject);
 begin
  try
   CheckPathWritable(Trim(cbWorkDir.Text));
  except
   ModalResult := mrNone;
   cbWorkDir.SetFocus;
   raise;
  end;
  inherited;
  AddPathToHistory;
  UserConfig.Section := 'Export';
  UserConfig.WriteParamStr  ('ExpDir',           Trim(cbWorkDir.Text));
  with checkExportParts do
  begin
   UserConfig.WriteParamBool('ExpText', Checked[0]);
   UserConfig.WriteParamBool('ExpRel', Checked[1]);;
   UserConfig.WriteParamBool('ExpAnno', Checked[2]);
   UserConfig.WriteParamBool('ExpImages', Checked[3]);
   UserConfig.WriteParamBool('ExpKW', Checked[4]);
  end; // with checkExportParts

  UserConfig.WriteParamInt  ('ExpType',          gbExpType.ItemIndex);
  UserConfig.WriteParamBool ('ExpWithDir',       cbxWithDict.Checked);
  UserConfig.WriteParamStr  ('DocFileName',      edtDocFileName.Text);
  UserConfig.WriteParamStr  ('SprFileName',      edtSprFileName.Text);
  UserConfig.WriteParamStr  ('ObjFileName',      edtObjFileName.Text);
  UserConfig.WriteParamStr  ('AnnoFileName',     edtAnnoFileName.Text);

  If rbSeparatedFiles.checked then
   UserConfig.WriteParamInt ('OutMethod',   1)
  else
   UserConfig.WriteParamInt ('OutMethod',   0);
  UserConfig.WriteParamInt  ('OutFilrPieceSize', edPieceSize.AsInteger);
  //UserConfig.WriteParamBool ('cbxAppend',        cbxAppend.Checked);
  UserConfig.WriteParamBool ('cbxPieceSize',     cbxPieceSize.Checked);
  //UserConfig.WriteParamBool ('cbxExportViaServer', cbxViaServer.Checked);
  //UserConfig.WriteParamBool ('RTFBodyOut',         cbxRTFBodyOut.Checked);

  //UserConfig.WriteParamInt ('CheckDicts', cgbDict.GroupCheckData);
  UserConfig.WriteParamInt ('OutFormat', cbOutFormat.ItemIndex);

  // Записываем историю путей
  UserConfig.Section := 'ExportPathHistory';
  UserConfig.WriteParamList('PathHistory', cbWorkDir.Items, 10);

  try
   MakeDir(Trim(cbWorkDir.Text));
  except
   ModalResult := mrNone;
   Raise;
  end;
 end;

procedure TExportDlg.cbxExpTextClick(Sender: TObject);
 begin
  //cbxAsAnonced.Enabled := cbxExpText.Checked;
 end;

procedure TExportDlg.rgOutMethodClick(Sender: TObject);
 begin
  edtDocFileName.Enabled := rbOneFile.Checked;
  edtSprFileName.Enabled := rbOneFile.Checked;
  //cbxAppend     .Enabled := rbOneFile.Checked;
  cbxPieceSize  .Enabled := rbOneFile.Checked;
  edPieceSize   .Enabled := rbOneFile.Checked;
 end;

procedure TExportDlg.rbOneFileClick(Sender: TObject);
begin
 rgOutMethodClick(Self);
end;

procedure TExportDlg.rbSeparatedFilesClick(Sender: TObject);
begin
 rgOutMethodClick(Self);
end;

procedure TExportDlg.cbOutFormatChange(Sender: TObject);
const
 cExts: array[0..6] of string = ('.evd','.evd','.txt','.nsr','.rtf','.html', '.xml');

 procedure ChangeExtInEditbox(aEdit: TEdit);
 begin
  aEdit.Text := ChangeFileExt(aEdit.Text, cExts[cbOutFormat.ItemIndex]);
 end;

begin
 if (cbOutFormat.ItemIndex in [4,5,6]) and rbOneFile.Checked then // если формат - RTF или HTML
 begin
  rbSeparatedFiles.Checked := True;
  rbOneFile.Enabled := False;
 end
 else
  rbOneFile.Enabled := True;
 //
 // приведем расширения файлов к выбранному типу файлов
 ChangeExtInEditbox(edtDocFileName);
 ChangeExtInEditbox(edtSprFileName);
 ChangeExtInEditbox(edtObjFileName);
 ChangeExtInEditbox(edtAnnoFileName);
end;

procedure TExportDlg.gbExpTypeClick(Sender: TObject);
begin
  inherited;
  comboToRegionList.Enabled:= gbExpType.ItemIndex <> 0;
  if not comboToRegionList.Enabled then
   comboToRegionList.ItemIndex := 0;
end;

procedure TExportDlg.btnSelectDirClick(Sender: TObject);
var
 l_Dlg: TarDirSelectDlg;
begin
 l_Dlg := TarDirSelectDlg.Create(Self);
 try
  l_Dlg.Path := Trim(cbWorkDir.Text);
  if l_Dlg.ShowModal = mrOK then
   cbWorkDir.Text := l_Dlg.Path;
 finally
  l3Free(l_Dlg);
 end;
end;

procedure TExportDlg.checkExportPartsClickCheck(Sender: TObject);
begin
 inherited;
 if (checkExportParts.ItemIndex = 5) and (checkExportParts.Checked[5]) then
  checkExportParts.Checked[5]:= IsPositiveResult(MessageDlg('ВНИМАНИЕ! Экспорт формул как картинок является необратимой операцией. Вы уверены, что хотите продолжить?', mtWarning, [mbOk, mbNo], 0));
end;

procedure TExportDlg.FillToRegionList;

 function DoIt(anItem: Integer): Boolean;
 begin
  Result := true;
  comboToRegionList.Items.Add(DictServer(CurrentFamily).Dict[da_dlAccGroups].GetFullDictItemName(anItem, False));
 end;

(*var
 i: Integer;*)
begin
 comboToRegionList.Items.Clear;
 comboToRegionList.Items.Add('Не присваивать группу доступа');
 DictServer(CurrentFamily).DictRootNode[da_dlAccGroups].Load;
 ArchiRequestManager.RequestToRegionList;
 ArchiRequestManager.ToRegionList.ForEachF(L2IntegerIteratorForEachFAction(@DoIt));
(* for i:= 0 to ArchiRequestManager.ToRegionList.Hi do
  comboToRegionList.Items.Add(DictServer(CurrentFamily).Dict[da_dlAccGroups].GetFullDictItemName(ArchiRequestManager.ToRegionList.Items[i], False));*)
 comboToRegionList.ItemIndex:= 0;
end;

function TExportDlg.ItemIndexToDictID: TDictID;

 function DoIt(anItem: Integer): Boolean;
 begin
  Result := true;
  ItemIndexToDictID := anItem;
 end;
 
begin
 Result:= cUndefDictID;
 if comboToRegionList.Visible and (comboToRegionList.ItemIndex > 0) then
  ArchiRequestManager.ToRegionList.ForOneF(L2IntegerIteratorForOneFAction(@DoIt), Pred(comboToRegionList.ItemIndex));
(*  Result:= ArchiRequestManager.ToRegionList[Pred(comboToRegionList.ItemIndex)];*)
end;

procedure TExportDlg.CheckPathWritable(const aPath: AnsiString);
begin
 if not l3CheckPathWritable(aPath) then
  raise Exception.Create('Невозможно запсать в указанную папку');
end;

end.


