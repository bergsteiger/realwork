{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFDEF Win32}
{$H+} {Long strings}
{$ENDIF}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCFNPE.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcFNPE;
  {-File name property editor}

{$I l3Define.inc }  

interface

uses
  Dialogs,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  Forms;

type
  {property editor for ranges}
  TOvcFileNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    function GetValue : string;
      override;
    procedure Edit;
      override;
  end;

  {property editor for the version property}
  TOvcVersionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
  end;


implementation


{*** TOvcFileNameProperty ***}

function TOvcFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TOvcFileNameProperty.GetValue : string;
begin
  Result := inherited GetValue;
end;

procedure TOvcFileNameProperty.Edit;
var
  D : TOpenDialog;
begin
  D := TOpenDialog.Create(Application);
  try
    D.DefaultExt := '*.*';
    D.Filter := 'All Files (*.*)|*.*|Text Files (*.txt)|*.txt|Ini Files (*.ini)|*.ini';
    D.FilterIndex := 0;
    D.Options := [ofHideReadOnly];
    D.Title := 'Select File Name';
    D.FileName := Value;
    if D.Execute then
      Value := D.FileName;
  finally
    D.Free;
  end;
end;


{*** TOvcVersionProperty ***}

{!!.13}
function TOvcVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly];
end;

end.
