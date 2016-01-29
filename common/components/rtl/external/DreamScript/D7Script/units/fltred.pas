{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit fltred;
{$I dc.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcsystem,dcconsts,consts,dcedit,dccommon,dcdreamlib;

type
  TFilterEditorForm = class(TForm)
    FilterGrid: TStringGrid;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FilterEditorForm: TFilterEditorForm;

type
  TFilterPropertyEdit = class(TPropertyEditor)
  function  GetAttributes : TPropertyAttributes; override;
  function  GetValue : string; override;
  procedure SetValue(const val : string); override;
  procedure Edit; override;
end;

implementation
{$R *.DFM}

{------------------------------------------------------------------}

procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(string), TOpenDialog, 'Filter', TFilterPropertyEdit); //don't resource
end;

{------------------------------------------------------------------}

procedure _Register;
begin

end;

{------------------------------------------------------------------}

function  TFilterPropertyEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paDialog];
end;

{------------------------------------------------------------------}

function  TFilterPropertyEdit.GetValue : string;
begin
  result := GetStrValue;
end;

{------------------------------------------------------------------}

procedure TFilterPropertyEdit.SetValue(const val : string);
begin
  SetStrValue(val);
end;

{------------------------------------------------------------------}
type
  TMStringGrid = class(TStringGrid)
  end;

procedure TFilterPropertyEdit.Edit;
var
  filter : string;
  form   : TFilterEditorForm;
  ccol   : integer;
  crow   : integer;
  p      : integer;
  i      : integer;
begin
  filter := GetStrValue;
  form := TFilterEditorForm.Create(nil);
  with TMStringGrid(form.FilterGrid) do
    begin
      Cells[0, 0] := STitleFilterName;
      Cells[1, 0] := STitleFilter;
      ColWidths[0] := ClientWidth div 2;
      ColWidths[1] := ClientWidth - ColWidths[0] - 2;
      Col := 0;
      Row := 2;
      ShowEditor;
    end;
  with form do
    try
      ccol := 0;
      crow := 1;

      while filter <> '' do
        begin
          p := pos('|', filter);
          if p = 0 then
            p := length(filter) + 1;

          FilterGrid.Cells[ccol, crow] := copy(filter, 1, p - 1);
          inc (ccol);
          if ccol = 2 then
            begin
              ccol := 0;
              inc(crow);
            end;
          delete(filter, 1, p);
        end;

       if ShowModal = idOk then
         begin
           filter := '';
           with FilterGrid do
             for i := 1 to RowCount - 1 do
               filter := filter + Cells[0, i] + '|' + Cells[1, i] + '|';
           i := length(filter);
           while (i >= 0) and (filter[i] = '|') do
             dec(i);
           filter := copy(filter, 1, i);
           SetStrValue(filter);
         end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TFilterEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_ESCAPE then
  begin
    ModalResult:=mrCancel;
    Key:=0;
  end;
end;

{------------------------------------------------------------------}

procedure TFilterEditorForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  Caption := SFilterEdit;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
  RegisterForDelphi(_Register);
end;

{------------------------------------------------------------------}

initialization
  RunRegister;
end.
