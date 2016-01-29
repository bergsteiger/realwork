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
{*                   OVCPFPE.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcPfPe;
  {-Property editor for the picture field component}

{$I l3Define.inc }  

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  SysUtils, ExtCtrls,
  OvcConst, OvcData, OvcExcpt, OvcHelp, OvcMisc, OvcStr;

type
  TOvcfrmPictureMask = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    lblMask: TLabel;
    lblMaskEdit: TLabel;
    Bevel1: TBevel;
    lblMaskDescription: TLabel;
    lblMaskList: TLabel;
    lbMask: TListBox;
    edMask: TEdit;
    procedure lbMaskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  protected
    { Private declarations }
    Ex : TStringList;
  end;

type
  {property editor for picture masks}
  TPictureMaskProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    function AllEqual: Boolean;
      override;
    procedure Edit;
      override;
  end;


implementation


uses
  OvcPf, OvcAe, OvcTCPic{, OvcPLb};

{$R *.DFM}


{*** TPictureMaskProperty ***}

type
  TLocalPF = class(TOvcCustomPictureField);

function TPictureMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect]
end;

function TPictureMaskProperty.AllEqual: Boolean;
begin
  Result := True;
end;

procedure TPictureMaskProperty.Edit;
var
  PfPE : TOvcfrmPictureMask;
  I, J : Integer;
  Mask : string;
  C    : TComponent;
begin
  PfPE := TOvcfrmPictureMask.Create(Application);
  try
    with PfPE do begin
      C := TComponent(GetComponent(0));
      if C is TOvcCustomPictureField then
        Mask := TLocalPF(C).PictureMask
      else if C is TOvcPictureArrayEditor then
        Mask := TOvcPictureArrayEditor(C).PictureMask
      else if C is TOvcTCPictureField then
        Mask := TOvcTCPictureField(C).PictureMask
{      else if C is TOvcPictureLabel then
        Mask := TOvcPictureLabel(C).PictureMask};

      J := -1;

      {if only one field is selected select the combo box item}
      {that corresponds to the current mask character}
      if PropCount = 1 then begin
        with PfPE.lbMask do begin
          for I := 0 to Items.Count-1 do begin
            if Items[I] = Mask then begin
              J := I;
              Break;
            end;
          end;
        end;
      end else
        Mask := '';

      {show current mask at top of combo box list}
      edMask.Text := Mask;

      {set explanation text, if any}
      if J >= 0 then begin
        lbMask.ItemIndex := J;
        lblMask.Caption := Ex.Strings[J]
      end else
        lblMask.Caption := '';

      {show the form}
      ShowModal;

      if ModalResult = idOK then begin
        {update all selected components with new mask}
        for I := 1 to PropCount do begin
          C := TComponent(GetComponent(I-1));
          if C is TOvcCustomPictureField then
            TLocalPF(C).PictureMask := edMask.Text
          else if C is TOvcPictureArrayEditor then
            TOvcPictureArrayEditor(C).PictureMask := edMask.Text
          else if C is TOvcTCPictureField then
            TOvcTCPictureField(C).PictureMask := edMask.Text
{          else if C is TOvcPictureLabel then
            TOvcPictureLabel(C).PictureMask := edMask.Text};
        end;
        Modified;
      end;
    end;
  finally
    PfPE.Free;
  end;
end;


{*** TfrmPictureMask ***}

procedure TOvcfrmPictureMask.FormCreate(Sender: TObject);
var
  I    : Word;
  S1   : string[20];
  S    : string;
begin
  {create a string list for the mask explanation strings}
  Ex := TStringList.Create;

  {load the picture mask strings from the resource file}
  for I := stnmFirst to stnmLast do begin
    {first 20 characters is the sample mask--remaining part}
    {of the string is a short description of the mask}
    S := GetOrphStr(I);

    {trim the left portion and add it to the combo box}
    S1 := Trim(Copy(S, 1, 20));
    lbMask.Items.Add(S1);

    {take the remaining portion of the string, trim it and}
    {add it to the string list}
    S := Trim(Copy(S, 21, 255));
    Ex.Add(S);
  end;
  for I := stpmFirst to stpmLast do begin
    {first 20 characters is the sample mask--remaining part}
    {of the string is a short description of the mask}
    S := GetOrphStr(I);

    {trim the left portion and add it to the combo box}
    S1 := Trim(Copy(S, 1, 20));
    lbMask.Items.Add(S1);

    {take the remaining portion of the string, trim it and}
    {add it to the string list}
    S := Trim(Copy(S, 21, 255));
    Ex.Add(S);
  end;
end;

procedure TOvcfrmPictureMask.lbMaskClick(Sender: TObject);
var
  I : Integer;
begin
  I := lbMask.ItemIndex;
  if (I >= 0) and (I < Ex.Count) then begin
    lblMask.Caption := Ex.Strings[I];
    edMask.Text := lbMask.Items[I];
  end else
    lblMask.Caption := '';
end;

procedure TOvcfrmPictureMask.FormDestroy(Sender: TObject);
begin
  {destroy string list}
  Ex.Free;
end;


procedure TOvcfrmPictureMask.btnHelpClick(Sender: TObject);
begin
  ShowHelpContext(hcPictureFieldMask);
end;

end.