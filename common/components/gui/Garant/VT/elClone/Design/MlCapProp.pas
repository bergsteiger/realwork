{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$I ElPack.inc}

unit MlCapProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$ifdef VCL_6_USED}
  DesignIntf, DesignEditors, DesignWindows, DsnConst,
{$else}
  DsgnIntf,
{$endif}

  Typinfo,
  ExtCtrls, StdCtrls, ComCtrls, {ElIni, ElFrmPers, ElXPThemedControl,
  ElEdits, }Buttons;

type
  TMlCapEditDialog = class(TForm)
    Panel1: TPanel;
    OkButton: TButton;
    CancelButton: TButton;
    Panel2: TPanel;
    LineCounter: TLabel;
    Memo: TMemo;
    Load: TSpeedButton;
    Save: TSpeedButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  end;//TMlCapEditDialog

type
  TMlCaptionProperty = class(TStringProperty)
  private
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;//TMlCaptionProperty

(*{$ifdef ELPACK_UNICODE}
  TElWideStringsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;//TElWideStringsProperty
{$endif}*)

  Tl3StringsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;//Tl3StringsProperty

implementation

uses
  ToolsAPI,
  
  l3VCLStrings
  ;

{$R *.DFM}

procedure TMlCaptionProperty.Edit;
begin
  with TMlCapEditDialog.Create(Application) do
  try
    {$ifdef D_6_UP}
    if GetPropType^.Kind = tkWString then
    begin
      Memo.Text := TypInfo.GetWideStrProp(GetComponent(0), GetPropInfo);
    end
    else
    {$endif}
      Memo.Text := GetValue;

    if ShowModal = mrOk then
    begin
      {$ifdef D_6_UP}
      if GetPropType^.Kind = tkWString then
      begin
        SetWideStrProp(GetComponent(0), GetPropInfo, Memo.Text);
      end
      else
      {$endif}
        SetValue(Memo.Text);
    end;
  finally
    Free
  end
end;

function TMlCaptionProperty.GetAttributes : TPropertyAttributes;
begin
  {$ifdef D_6_UP}
  Result := [paDialog];
  {$else}
  Result := [paMultiSelect, paDialog];
  {$endif}
end;

(*{$ifdef ELPACK_UNICODE}
procedure TElWideStringsProperty.Edit;
begin
  with TMlCapEditDialog.Create(Application) do
  try
    Memo.Lines.Assign(TElWideStrings(GetOrdValue));
    MemoChange(Memo);
    if ShowModal = mrOk then
    begin
      SetOrdValue(Longint(Memo.Lines));
      // TElWideStrings(GetOrdValue).Assign(Memo.Lines);
    end;
  finally
    Free;
  end
end;

function TElWideStringsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

{$endif}*)

procedure Tl3StringsProperty.Edit;
var
 l_MS : IOTAModuleServices;
begin
  with TMlCapEditDialog.Create(Application) do
  try
    Memo.Lines.Assign(Tl3CustomStrings(GetOrdValue));
    //MemoChange(Memo);
    if ShowModal = mrOk then
    begin
      //SetOrdValue(Longint(Memo.Lines));
      Tl3CustomStrings(GetOrdValue).Assign(Memo.Lines);
      if (Designer = nil) then
      begin
       if Supports(BorlandIDEServices, IOTAModuleServices, l_MS) then
        if (l_MS.CurrentModule <> nil) then
         l_MS.CurrentModule.MarkModified;
      end//Designer = nil
      else
       Designer.Modified; 
    end;
  finally
    Free;
  end
end;

function Tl3StringsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

procedure TMlCapEditDialog.LoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    Memo.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TMlCapEditDialog.SaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Memo.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMlCapEditDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27{VK_ESCAPE} then
    ModalResult := mrCancel;
end;

end.
