
{***************************************************************************}
{  eDocEngine version2 to version3                                 }
{  Conversion utility                                                       }
{                                                                           }
{  Copyright © 2000-20010 Gnostice Information Technologies Private Limited  }
{                                                                           }
{***************************************************************************}

{!!!!!!!!!!!!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!!!!!!!!!!!!}
{                                                           }
{ COMPILE THIS PROJECT IN THE SAME VERSION OF DELPHI/       }
{ C++ BUIDLER AS THE PROJECTS, WHICH WILL BE CONVERTED,     }
{ WERE DEVELOPED IN.                                        }
{                                                           }
{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
unit Main;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, FileCtrl, ShellAPI;

type
	TfrmMain = class(TForm)
		btnStart: TBitBtn;
		gbSingleFile: TGroupBox;
		gbMultiFile: TGroupBox;
		rbSingleFile: TRadioButton;
		rbFolderFiles: TRadioButton;
		edSingleFile: TEdit;
		btnSelectFile: TSpeedButton;
		edMultiFile: TEdit;
		btnSelectDir: TSpeedButton;
		gbFileType: TGroupBox;
		Bevel1: TBevel;
		lblFilesDone: TLabel;
		Image1: TImage;
    progFiles: TProgressBar;
		Bevel4: TBevel;
		chbBackup: TCheckBox;
		edBackupDir: TEdit;
    cbxPAS: TCheckBox;
    cbxH: TCheckBox;
    OpenDialog: TOpenDialog;
		procedure btnStartClick(Sender: TObject);
		procedure btnSelectDirClick(Sender: TObject);
		procedure rbSingleFileClick(Sender: TObject);
		procedure rbFolderFilesClick(Sender: TObject);
		procedure btnSelectFileClick(Sender: TObject);
		procedure edPathChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);

	private
		FFileCount: Integer;
		FCurrPathEdit: TEdit;

		procedure UpdateStartBtn;
	end;

var
	frmMain: TfrmMain;
  LeftPos: Integer;
  Resl: Integer;

implementation

{$R *.DFM}

type

	THackWinControl = class(TWinControl);


var
 UnitNames: array[1..8] of string = ('gtClasses','gtUtils','gtConsts','gtHash',
    'gtPDFFont','gtDZLIB','gtPDFCrypt','gtFilters' );

{------------------------------------------------------------------------------}

{-Conversion & file routines --------------------------------------------------}

function AppendTrailingBackslash(const S: string): string;
begin
	Result := S;
	if not IsPathDelimiter(Result, Length(Result)) then Result := Result + '\';
end;

{------------------------------------------------------------------------------}

function GetFilesInDirectory(const DirName, FileTypes: string;
	Attrib: Integer): TStringList;

	procedure AddFileNamesToList(const ADir, AFileExt: string; AAttrib: Integer;
		AList: TStrings);
	var
		SRec: TSearchRec;
		S: string;
	begin
		S := AppendTrailingBackslash(ADir) + '*.' + AFileExt;
		if FindFirst(S, AAttrib, SRec) = 0 then
			with AList do
			begin
				repeat
						Add(SRec.Name);
				until FindNext(SRec) <> 0;
				FindClose(SRec);
			end;
	end;

var
	I: Integer;
begin
	Result := nil;
	if DirectoryExists(DirName) then
	begin
		Result := TStringList.Create;
		with TStringList.Create do
			try
				CommaText := FileTypes;
				for I := 0 to Count - 1 do
					AddFileNamesToList(DirName, Strings[I], Attrib, Result);
			finally
				Free;
			end;
	end;
end;

{------------------------------------------------------------------------------}

function ReplaceString(const S, OldPattern, NewPattern: string;
	var NumFound: Integer): string;

	function IsWholeMatch(const S, Patt: string; StartPos: Integer): Boolean;
	begin
		Result := ((StartPos = 1) or not(S[StartPos - 1] in ['A'..'Z', '0'..'9']))
			and	((StartPos + Length(Patt) >= Length(S)) or
				not(S[StartPos + Length(Patt)] in ['A'..'Z', '0'..'9']));
	end;

var
	I: Integer;
	SearchStr, Str, OldPat: string;
begin
	SearchStr := AnsiUpperCase(S);
	OldPat := AnsiUpperCase(OldPattern);
	Str := S;
	NumFound := 0;
	Result := '';
	while SearchStr <> '' do
	begin
		I := AnsiPos(OldPat, SearchStr);
		if I = 0 then
		begin
			Result := Result + Str;
			Break;
		end;
		// ------ Match whole words only ------
		if IsWholeMatch(SearchStr, OldPat, I) then
		begin
			Inc(NumFound);
			Result := Result + Copy(Str, 1, I - 1) + NewPattern;
		end
		else
			Result := Result + Copy(Str, 1, I + Length(OldPat) - 1);
		Str := Copy(Str, I + Length(OldPattern), MaxInt);
		SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
	end;
end;

{------------------------------------------------------------------------------}

procedure ConvertFile(SrcFile, DestFile: string);

  procedure ConvertPAS;
  var
    Myf: TStringList;
    tempstring1: string;
    tempstring: string;
    i,c, Count : Integer;
    p: integer;
    infcnt : integer;
    S: string;
	begin
    Myf := TStringList.Create;
    Myf.LoadFromFile(SrcFile);
    try
		for I := Myf.Count - 1 downto 0 do
		begin
			S := Myf[I];
			for C := Low(UnitNames) to High(UnitNames) do
				S := ReplaceString(S, UnitNames[C], UnitNames[C]+IntToStr(3), Count);
			Myf[I] := S;
			Application.ProcessMessages;
		end;
	  finally
      Myf.SaveToFile(DestFile);
      Myf.SaveToFile(SrcFile);
      Myf.Free;
    end;
  end;
begin
    ConvertPAS;
end;


{------------------------------------------------------------------------------}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
	FCurrPathEdit := edMultiFile;
end;

{-Convert-method selection ----------------------------------------------------}

procedure EnableGroupBox(AGroupBox: TGroupBox);
var
	I: Integer;
begin
	with AGroupBox do
	begin
		Enabled := True;
		for I := 0 to ControlCount - 1 do
			if (Controls[I] is TWinControl) and
					(THackWinControl(Controls[I]).Color = clInactiveBorder) then
				THackWinControl(Controls[I]).Color := clWindow;
	end;
end;

{------------------------------------------------------------------------------}

procedure DisableGroupBox(AGroupBox: TGroupBox);
var
	I: Integer;
begin
	with AGroupBox do
	begin
		Enabled := False;
		for I := 0 to ControlCount - 1 do
			if (Controls[I] is TWinControl) and
					(THackWinControl(Controls[I]).Color = clWindow) then
				THackWinControl(Controls[I]).Color := clInactiveBorder;
	end;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.rbSingleFileClick(Sender: TObject);
begin
	DisableGroupBox(gbFileType);
	DisableGroupBox(gbMultiFile);
	EnableGroupBox(gbSingleFile);
	FCurrPathEdit := edSingleFile;
	UpdateStartBtn;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.rbFolderFilesClick(Sender: TObject);
begin
	DisableGroupBox(gbSingleFile);
	EnableGroupBox(gbMultiFile);
	EnableGroupBox(gbFileType);
	FCurrPathEdit := edMultiFile;
	UpdateStartBtn;
end;

{-File/Folder dialog invoke ---------------------------------------------------}

procedure TfrmMain.btnSelectFileClick(Sender: TObject);
begin
	if OpenDialog.Execute then
		edSingleFile.Text := OpenDialog.FileName;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.btnSelectDirClick(Sender: TObject);
var
	S: string;
begin
{$IFDEF VER100}
	S := '\';
	if SelectDirectory(S, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
{$ELSE}
	if SelectDirectory('Select folder to find files in', '\', S) then
{$ENDIF}
		edMultiFile.Text := S;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.edPathChange(Sender: TObject);
begin
	UpdateStartBtn;
end;

procedure TfrmMain.UpdateStartBtn;
begin
	btnStart.Enabled := FCurrPathEdit.Text <> '';
end;

{-Get file-List and start conversion ------------------------------------------}

procedure TfrmMain.btnStartClick(Sender: TObject);
var
	FileList, FileTypeList: TStrings;
	I: Integer;
	TempFile, FileName, PathName: string;
 // IsDFM: Boolean;

	function CopyFiles(AFileList: TStrings; const SrcPath,
		DestPath: string): Boolean;
	var
		Fo: TSHFileOpStruct;
		Buff: array[0..1024 * 32] of Char;
		P: PChar;
		I: Integer;
		SPath: string;

		procedure InitBuff;
		begin
			FillChar(Buff, SizeOf(Buff), #0);
			P := @Buff;
		end;

		procedure DoCopyFiles;
		begin
			FillChar(Fo, SizeOf(Fo), #0);
			Fo.Wnd := Handle;
			Fo.wFunc := FO_COPY;
			Fo.pFrom := @Buff;
			Fo.pTo := PChar(AppendTrailingBackslash(DestPath));
			Fo.fFlags := 0;
			Fo.lpszProgressTitle := 'Copying files to Backup folder...';
			Result := (SHFileOperation(Fo) = 0) and (
				Fo.fAnyOperationsAborted = False);
			InitBuff;
		end;

	begin
		Result := True;
		InitBuff;
		SPath := AppendTrailingBackslash(SrcPath);
		for I := 0 to AFileList.Count - 1 do
		begin
			//**** Copy in batches if there are too many files ****
			if (P - @Buff) + Length(SPath + AFileList[I]) + 2 > SizeOf(Buff) then
				DoCopyFiles;
			if not Result then Break;
			P := StrECopy(P, PChar(SPath + AFileList[I])) + 1;
		end;
		if Result then DoCopyFiles;
	end;

	procedure UpdateFileStatus(I: Integer; CurrFile: string);
	begin
		progFiles.Position := I + 1;
		progFiles.Update;
		lblFilesDone.Caption := Format('%d of %d', [I + 1, FFileCount]);
		lblFilesDone.Update;
	end;

  procedure PrepareFileTypeList;
  begin
    FileTypeList := TStringList.Create;
    if cbxPAS.Checked then
      FileTypeList.Add('pas');
    if cbxH.Checked then
      FileTypeList.Add('h');
  end;

begin
	FileList := nil;
	Screen.Cursor := crHourGlass;
	btnStart.Enabled := False;
  PrepareFileTypeList;

	try
		if rbSingleFile.Checked then
		begin
			FileList := TStringList.Create;
			if FileExists(edSingleFile.Text) then
			begin
				FileList.Add(ExtractFileName(edSingleFile.Text));
				PathName := AppendTrailingBackslash(ExtractFilePath(edSingleFile.Text));
			end;
		end
		else
		begin
			PathName := AppendTrailingBackslash(edMultiFile.Text);
			if DirectoryExists(PathName) then
				Filelist := GetFilesInDirectory(PathName,
					FileTypeList.CommaText, faAnyFile - faDirectory);
		end;
		if (FileList = nil) or (FileList.Count = 0) then
		begin
			MessageDlg('No files to convert!'#13#10#13#10 +
				'Make sure the file/folder specified is correct', mtError, [mbOK], 0);
			Exit;
		end;

		//------------- Backup files before conversion -------------------
		if chbBackup.Checked then
		begin
			ForceDirectories(PathName + edBackupDir.Text);
			if not CopyFiles(FileList, PathName, PathName + edBackupDir.Text) then
				if MessageDlg('Backup operation did not complete successfully!' +
					'#13#10#13#10 Continue anyway?', mtConfirmation, [mbYes, mbNO], 0) =
						mrNo then
					Exit;
		end;

		//------------- Supply file name and get it converted ------------
		FFileCount := FileList.Count;
		progFiles.Max := FFileCount;
		for I := 0 to FFileCount - 1 do
		begin
		UpdateFileStatus(I, FileList[I]);
			FileName := PathName + FileList[I];
			TempFile := ChangeFileExt(FileName, '.$$$');
			if FileExists(TempFile) then
				DeleteFile(TempFile);

      if (FileGetAttr(FileName) and faReadOnly) <> 0 then
        if MessageDlg(FileName + ' is marked read-only.' + #13#10 +
            'Continue anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          FileSetAttr(FileName, FileGetAttr(FileName) - faReadOnly)
        else
          Continue;
      begin
				RenameFile(FileName, TempFile);
				ConvertFile(TempFile, FileName);
			end;
			DeleteFile(TempFile);
		end;
		MessageDlg('All Done!' , mtInformation, [mbOK], 0);
	finally
		FileList.Free;
    FileTypeList.Free;
		Screen.Cursor := crDefault;
		btnStart.Enabled := True;
	end;
end;

{------------------------------------------------------------------------------}

initialization
  LeftPos := 25;
  Resl := Screen.PixelsPerInch;
finalization

end.
