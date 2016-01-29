    {$IFNDEF ADX_TRIAL}
    {$I reg_crypt_begin.inc}
    lblTitle.Caption := 'Ready to create';
    lblTitle.Font.Color := clWindowText;
    MainForm.btnNext.Enabled := True;
    Exit;
    {$I reg_crypt_end.inc}
    lblTitle.Caption := 'Unregistered version';
    lblTitle.Font.Color := clMaroon;
    MainForm.btnNext.Enabled := False;
    MainForm.btnNext.Free;
    MainForm.ProjectName := 'Unregistered';
    MainForm.DestinationFolder := 'Unregistered';
    MainForm.AddInCoClassName := 'Unregistered';
    MainForm.btnBack.Enabled := False;
    {$ENDIF}

    {$IFDEF ADX_TRIAL}
    lblTitle.Caption := 'Ready to create';
    lblTitle.Font.Color := clWindowText;
    MainForm.btnNext.Enabled := True;
    {$ENDIF}

