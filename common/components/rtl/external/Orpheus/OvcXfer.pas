{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCXFER.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcXfer;
  {-Data transfer non-visual component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, ExtCtrls, Forms, StdCtrls, SysUtils,
  OvcAe, OvcConst, OvcData, OvcEf, OvcExcpt, OvcMisc, {OvcRLbl,} OvcVer;

{***************************************************************
 Supported types             Data to transfer
----------------------------------------------------------------
  TLabel                       ShortString or char array
  TPanel                       ShortString or char array
  TEdit                        ShortString or char array
  TMemo                        TStrings
  TCheckBox                    Boolean
  TRadioButton                 Boolean
  TListBox                     Integer, TStrings
  TComboBox                    Integer, string, TStrings
  TOvcRotatedLabel             ShortString or char array
  TOvcBaseEntryField           variable (size obtained from field)
*****************************************************************}

type
  {structure used to transfer data for a TListBox component}
  PListBoxTransfer = ^TListBoxTransfer;
  TListBoxTransfer = packed record
    ItemIndex : Integer;
    Items     : TStrings;
  end;

  {structure used to transfer data for a TComboBox component}
  PComboBoxTransfer = ^TComboBoxTransfer;
  TComboBoxTransfer = packed record
    ItemIndex : Integer;
    Text      : string[255];
    Items     : TStrings;
  end;

type
  TOvcTransfer = class(TComponent)
  {.Z+}
  protected {private}
    xfrList : TList;

    {property methods}
    function GetVersion : string;                                      {!!.13}
    procedure SetVersion(Value : string);                              {!!.13}

    {internal methods}
    procedure xfrFillTransferList(L : TList);
      {-build list of all components that require data transfer}
    function xfrGetComponentDataSize(C : TComponent) : Word;
      {-return the size of the data for this component}
    function xfrGetTransferBufferSize(L : TList) : Word;
      {-return the expected size of the transfer buffer}

  public
    {for internal use by the property editor}
    procedure GetTransferList(L : TList);
      {-return the list of components}
  {.Z-}

    function GetTransferBufferSize(CNA : array of TComponent) : Word;
      {-return the required size for the transfer buffer}
    procedure TransferFromForm(CNA : array of TComponent; var Data);
      {-transfer forms data to structure pointed to by Data}
    procedure TransferFromFormZ(CNA : array of TComponent; var Data);
      {-transfer forms data to structure pointed to by Data}
    procedure TransferToForm(CNA : array of TComponent; const Data);
      {-transfer data from structure pointed to by Data to form}
    procedure TransferToFormZ(CNA : array of TComponent; const Data);
      {-transfer data from structure pointed to by Data to form}

  published                                                            {!!.13}
    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

{*** TOvcTransfer ***}

function TOvcTransfer.GetTransferBufferSize(CNA : array of TComponent) : Word;
  {-return the required size for the transfer buffer}
var
  I : Integer;
begin
  xfrList := TList.Create;
  try
    for I := Low(CNA) to High(CNA) do
      xfrList.Add(CNA[I]);
    Result := xfrGetTransferBufferSize(xfrList);
  finally
    xfrList.Free;
  end;
end;

procedure TOvcTransfer.GetTransferList(L : TList);
  {-return the list of compoents}
begin
  xfrFillTransferList(L);
end;

{!!.13}
function TOvcTransfer.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

{!!.13}
procedure TOvcTransfer.SetVersion(Value : string);
begin
end;

type
  TLocalEF = class (TOvcBaseEntryField);

procedure TOvcTransfer.TransferFromForm(CNA : array of TComponent; var Data);
  {-transfer forms data to structure pointed to by Data}
var
  I  : Integer;
  P  : PAnsiChar;
  C  : TComponent;
  St : TStrings;
begin
  P := PAnsiChar(@Data);
  if P = nil then
    Exit;

  xfrList := TList.Create;
  try
    {fill list with components}
    for I := Low(CNA) to High(CNA) do
      xfrList.Add(CNA[I]);

    {transfer data to the buffer for each component in the list}
    for I := 0 to xfrList.Count-1 do begin
      C := TComponent(xfrList.Items[I]);
      if C is TEdit then
        ShortString(Pointer(P)^) := TEdit(C).Text
      else if C is TLabel then
        ShortString(Pointer(P)^) := TLabel(C).Caption
      else if C is TPanel then
        ShortString(Pointer(P)^) := TPanel(C).Caption
      else if C is TMemo then begin
        Move(P^, ST, SizeOf(TStrings));
        ST.Assign(TMemo(C).Lines);
      end else if C is TCheckBox then
        Boolean(P^) := TCheckBox(C).Checked
      else if C is TRadioButton then
        Boolean(P^) := TRadioButton(C).Checked
      else if C is TListBox then begin
        PListBoxTransfer(P)^.ItemIndex := TListBox(C).ItemIndex;
        PListBoxTransfer(P)^.Items.Assign(TListBox(C).Items);
      end else if C is TComboBox then begin
        PComboBoxTransfer(P)^.ItemIndex := TComboBox(C).ItemIndex;
        PComboBoxTransfer(P)^.Text := TComboBox(C).Text;
        PComboBoxTransfer(P)^.Items.Assign(TComboBox(C).Items);
      end else if C is TOvcBaseEntryField then
        TOvcBaseEntryField(C).GetValue(P^)
      {else if C is TOvcRotatedLabel then
        ShortString(Pointer(P)^) := TOvcRotatedLabel(C).Caption};

      {position to next item in the transfer buffer}
      Inc(P, xfrGetComponentDataSize(C));
    end;
  finally
    xfrList.Free;
  end;
end;

procedure TOvcTransfer.TransferFromFormZ(CNA : array of TComponent; var Data);
  {-transfer forms data to structure pointed to by Data}
var
  I  : Integer;
  P  : PAnsiChar;
  C  : TComponent;
  St : TStrings;
begin
  P := PAnsiChar(@Data);
  if P = nil then
    Exit;

  xfrList := TList.Create;
  try
    {fill list with components}
    for I := Low(CNA) to High(CNA) do
      xfrList.Add(CNA[I]);

    {transfer data to the buffer for each component in the list}
    for I := 0 to xfrList.Count-1 do begin
      C := TComponent(xfrList.Items[I]);
      if C is TEdit then
        StrPCopy(P, TEdit(C).Text)
      else if C is TLabel then
        StrPCopy(P, TLabel(C).Caption)
      else if C is TPanel then
        StrPCopy(P, TPanel(C).Caption)
      else if C is TMemo then begin
        Move(P^, ST, SizeOf(TStrings));
        ST.Assign(TMemo(C).Lines);
      end else if C is TCheckBox then
        Boolean(P^) := TCheckBox(C).Checked
      else if C is TRadioButton then
        Boolean(P^) := TRadioButton(C).Checked
      else if C is TListBox then begin
        PListBoxTransfer(P)^.ItemIndex := TListBox(C).ItemIndex;
        PListBoxTransfer(P)^.Items.Assign(TListBox(C).Items);
      end else if C is TComboBox then begin
        PComboBoxTransfer(P)^.ItemIndex := TComboBox(C).ItemIndex;
        PComboBoxTransfer(P)^.Text := TComboBox(C).Text;
        PComboBoxTransfer(P)^.Items.Assign(TComboBox(C).Items);
      end else if C is TOvcBaseEntryField then
        if (TLocalEF(C).efDataType mod fcpDivisor) = fsubString then
          StrPCopy(P, TOvcBaseEntryField(C).AsString)
        else
          TOvcBaseEntryField(C).GetValue(P^)
      {else if C is TOvcRotatedLabel then
        ShortString(Pointer(P)^) := TOvcRotatedLabel(C).Caption};

      {position to next item in the transfer buffer}
      Inc(P, xfrGetComponentDataSize(C));
    end;
  finally
    xfrList.Free;
  end;
end;

procedure TOvcTransfer.TransferToForm(CNA : array of TComponent; const Data);
  {-transfer data from structure pointed to by Data to form}
var
  I  : Integer;
  P  : PAnsiChar;
  C  : TComponent;
  St : TStrings;
begin
  P := PAnsiChar(@Data);
  if P = nil then
    Exit;

  xfrList := TList.Create;
  try
    {fill list with components}
    for I := Low(CNA) to High(CNA) do
      xfrList.Add(CNA[I]);

    {transfer data to the form for each component in the list}
    for I := 0 to xfrList.Count-1 do begin
      C := TComponent(xfrList.Items[I]);
      if C is TEdit then
        TEdit(C).Text := ShortString(Pointer(P)^)
      else if C is TLabel then
        TLabel(C).Caption := ShortString(Pointer(P)^)
      else if C is TPanel then
        TPanel(C).Caption := ShortString(Pointer(P)^)
      else if C is TMemo then begin
        Move(P^, ST, SizeOf(TStrings));
        TMemo(C).Lines.Assign(ST);
      end else if C is TCheckBox then
        TCheckBox(C).Checked := Boolean(P^)
      else if C is TRadioButton then
        TRadioButton(C).Checked := Boolean(P^)
      else if C is TListBox then begin
        TListBox(C).Items.Assign(PListBoxTransfer(P)^.Items);
        TListBox(C).ItemIndex := PListBoxTransfer(P)^.ItemIndex;
      end else if C is TComboBox then begin
        TComboBox(C).Items.Assign(PComboBoxTransfer(P)^.Items);
        TComboBox(C).ItemIndex := PComboBoxTransfer(P)^.ItemIndex;
        TComboBox(C).Text := PComboBoxTransfer(P)^.Text;
      end else if C is TOvcBaseEntryField then
        TOvcBaseEntryField(C).SetValue(P^)
      {else if C is TOvcRotatedLabel then
        TOvcRotatedLabel(C).Caption := ShortString(Pointer(P)^)};

      {position to next item in the transfer buffer}
      Inc(P, xfrGetComponentDataSize(C));
    end;
  finally
    xfrList.Free;
  end;
end;

procedure TOvcTransfer.TransferToFormZ(CNA : array of TComponent; const Data);
  {-transfer data from structure pointed to by Data to form}
var
  I  : Integer;
  P  : PAnsiChar;
  C  : TComponent;
  St : TStrings;
begin
  P := PAnsiChar(@Data);
  if P = nil then
    Exit;

  xfrList := TList.Create;
  try
    {fill list with components}
    for I := Low(CNA) to High(CNA) do
      xfrList.Add(CNA[I]);

    {transfer data to the form for each component in the list}
    for I := 0 to xfrList.Count-1 do begin
      C := TComponent(xfrList.Items[I]);
      if C is TEdit then
        TEdit(C).Text := StrPas(P)
      else if C is TLabel then
        TLabel(C).Caption := StrPas(P)
     else if C is TPanel then
        TPanel(C).Caption := StrPas(P)
     else if C is TMemo then begin
        Move(P^, ST, SizeOf(TStrings));
        TMemo(C).Lines.Assign(ST);
      end else if C is TCheckBox then
        TCheckBox(C).Checked := Boolean(P^)
      else if C is TRadioButton then
        TRadioButton(C).Checked := Boolean(P^)
      else if C is TListBox then begin
        TListBox(C).Items.Assign(PListBoxTransfer(P)^.Items);
        TListBox(C).ItemIndex := PListBoxTransfer(P)^.ItemIndex;
      end else if C is TComboBox then begin
        TComboBox(C).Items.Assign(PComboBoxTransfer(P)^.Items);
        TComboBox(C).ItemIndex := PComboBoxTransfer(P)^.ItemIndex;
        TComboBox(C).Text := PComboBoxTransfer(P)^.Text;
      end else if C is TOvcBaseEntryField then
        if (TLocalEF(C).efDataType mod fcpDivisor) = fsubString then
           TOvcBaseEntryField(C).AsString := StrPas(P)
        else
          TOvcBaseEntryField(C).SetValue(P^)
      {else if C is TOvcRotatedLabel then
        TOvcRotatedLabel(C).Caption := ShortString(Pointer(P)^)};

      {position to next item in the transfer buffer}
      Inc(P, xfrGetComponentDataSize(C));
    end;
  finally
    xfrList.Free;
  end;
end;

procedure TOvcTransfer.xfrFillTransferList(L : TList);
  {-build list of all components that require data transfer}

  function CanAdd(C : TComponent) : Boolean;
  begin
    Result := False;

    {don't add ourself}
    if (C = Self) then
      Exit;

    {if component isn't owned by out form, don't add}
    if (C.Owner <> Self.Owner) then
      Exit;

    {if a component doesn't have a name, don't add}
    if (C.Name = '') then
      Exit;

    if (C is TEdit) then
      Result := True
    else if (C is TLabel) then
      Result := True
    else if (C is TPanel) then
      Result := True
    else if (C is TMemo) then
      Result := True
    else if (C is TCheckBox) then
      Result := True
    else if (C is TRadioButton) then
      Result := True
    else if (C is TListBox) then
      Result := True
    else if (C is TComboBox) then
      Result := True
    else if (C is TOvcBaseEntryField) and
            (Pos('TOVCDB', UpperCase(C.ClassName)) = 0) then
      Result := True
    {else if (C is TOvcRotatedLabel) then
      Result := True};
  end;

  procedure AddComponent(C : TComponent);
  begin
    if CanAdd(C) then
      L.Add(C);
  end;

  procedure FindComponents(C : TComponent);
  var
    I  : Integer;
  begin
    if not Assigned(C) then
      Exit;

    {look through all of the owned components}
    for I := 0 to C.ComponentCount-1 do begin
      {conditionally add to the list}
      AddComponent(C.Components[I]);

      {see if this component owns other componets}
      FindComponents(C.Components[I]);
    end;
  end;

begin
  {find all components belonging to the form}
  FindComponents(Owner);
end;

function TOvcTransfer.xfrGetComponentDataSize(C : TComponent) : Word;
  {-return the size of the data for this component}
begin
  if C is TEdit then begin
    Result := TEdit(C).MaxLength + 1;
    if Result = 1 then
      Result := SizeOf(ShortString)
  end else if (C is TLabel) or (C is TPanel) {or (C is TOvcRotatedLabel)} then
    Result := SizeOf(ShortString)
  else if C is TListBox then
    Result := SizeOf(TListBoxTransfer)
  else if C is TComboBox then
    Result := SizeOf(TComboBoxTransfer)
  else if C is TMemo then
    Result := SizeOf(TStrings)
  else if (C is TCheckbox) or (C is TRadioButton) then
    Result := SizeOf(Boolean)
  else if C is TOvcBaseEntryField then
    Result := TOvcBaseEntryField(C).DataSize
  else
    Result := 0;
end;

function TOvcTransfer.xfrGetTransferBufferSize(L : TList) : Word;
  {-return the expected size of the transfer buffer}
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to L.Count-1 do
    Inc(Result, xfrGetComponentDataSize(TComponent(L.Items[I])));
end;



end.