{*******************************************************}
{                                                       }
{  Code working only under client-server Delphi         }
{                                                       }
{  Copyright (c) 1997-2000 Dream Company                }
{  http://www.dream-com.com                             }
{  e-mail: contact@dream-com.com                        }
{                                                       }
{*******************************************************}
unit csdelphi;

interface
{$I dc.inc}

{$IFDEF D3}
uses
  dbconsts, classes, db, {$IFDEF USEBDE}dbtables,{$ENDIF} dbclient,
  {$IFDEF D5}provider{$ELSE}bdeprov{$ENDIF}, dialogs, dcconsts,
  treemod, dcgen, dcsystem, dcdreamlib;
{$ENDIF}

implementation

{$IFDEF D3}

procedure SaveDatset(DSet: TPersistent);
var
  SaveDlg: TSaveDialog;
begin
  if Dset is TClientDataset then
    with TClientDataset(Dset) do
    begin
      SaveDlg := TSaveDialog.Create(nil);
      SaveDlg.Filter := ResStr(SClientDataFilter);
      SaveDlg.FileName := SdatasetName;
      try
        if SaveDlg.Execute then
        begin
          if not Active then
            Open;
          SaveToFile(SaveDlg.FileName);
        end;
      finally
        SaveDlg.Free;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure LoadDatset(DSet: TPersistent);
var
  OpenDlg: TOpenDialog;
begin
  if Dset is TClientDataset then
    with TClientDataset(Dset) do
    begin
      OpenDlg := TOpenDialog.Create(nil);
      OpenDlg.Filter := ResStr(SClientDataFilter);
      OpenDlg.FileName := SdatasetName;
      try
        if OpenDlg.Execute then
        begin
          LoadFromFile(OpenDlg.FileName);
          if not Active then
            Open;
        end;
      finally
        OpenDlg.Free;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure AssignDatset(DSet: TPersistent);
var
  Source: TObject;
  Prov: TProvider;
  RecsOut: integer;
  U: TStringList;
  i: integer;
begin
  if not (Dset is TClientDataset) then
    Exit;

  U := TStringList.Create;
  with TComponent(Dset).Owner do
    for i := 0 to ComponentCount - 1 do
      {$IFDEF USEBDE}
      if (Components[i] is TDbDataset)
      {$ELSE}
      if (Components[i] is TDataset)
      {$ENDIF}
      and (Components[i] <> DSet) then
        U.AddObject(Components[i].Name, Components[i]);
  if U.Count > 0 then
    if FilterStringsForm(U, SCapSelectSource, 0, []) and (U.Count > 0) then
    begin
      Source := U.Objects[0];
      {$IFDEF USEBDE}
      if Source is TDBDataset then
      {$ELSE}
      if Source is TDataset then
      {$ENDIF}
      begin
        Prov := TProvider.Create(nil);
        try
          Prov.DataSet := TDataset(Source);
          {$IFNDEF D5}
          Prov.Reset(true);
          {$ENDIF}
          with TClientDataset(Dset) do
          begin
            Data := Prov.GetRecords(-1, RecsOut{$IFDEF D5}, ord(grReset){$ENDIF});
            Open;
          end;
        finally
          Prov.Free;
        end;
      end;
    end;
end;

procedure _InstantRegister;
begin
  RegisterComponentAction(ResStr(SSaveToFile), TClientDataset, SaveDatset);
  RegisterComponentAction(ResStr(SLoadFromFile), TClientDataset, LoadDatset);
  RegisterComponentAction(ResStr(SClientDSAssignData), TClientDataset, AssignDatset);
end;

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
end;

initialization
  RunRegister;

{$ENDIF}

end.
