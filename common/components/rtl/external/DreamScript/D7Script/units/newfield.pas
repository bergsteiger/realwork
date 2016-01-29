{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit newfield;
{$I dc.inc}
interface

uses
  dcsystem, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dcGen, dccommon, dcdreamlib, dcconsts, consts;

type
  TNewFieldForm = class(TForm)
    OkBut: TButton;
    CancelBut: TButton;
    Panel1: TPanel;
    FieldNameEdit: TEdit;
    FieldTypeCombo: TComboBox;
    HelpBut: TButton;
    LName: TLabel;
    LType: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OkButClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewFieldForm: TNewFieldForm;

implementation

{$R *.DFM}

{-----------------------------------------------}

function FieldTypeFromClassName(Const CName:String):String;
begin
  Result:=Copy(CName,2,Length(CName)-6);
end;

{-----------------------------------------------}

procedure TNewFieldForm.FormCreate(Sender: TObject);

{Const
  cFieldClasses='String,Integer,Smallint,Word,Float,Currency,BCD,Boolean,Date,'+
    'VarBytes,Bytes,Time,DateTime,Blob,Memo,Graphic,AutoInc';}

  procedure GetLoadedClasses;
    Var
      L:TList;
      i:Integer;
  begin
     L:=TList.Create;
     ClassItems.ListFieldClasses(L);
     for i:=0 to L.Count-1 do
       FieldTypeCombo.Items.Add(FieldTypeFromClassName(TComponentClass(L[i]).ClassName));
     L.Free;
  end;

begin
// FieldTypeCombo.Items.CommaText:=cFieldClasses;
  SetFormFont(self);
  GetLoadedClasses;
  FieldTypeCombo.ItemIndex:=0;

  Caption := SNewField;
  LName.Caption := SFieldName;
  LType.Caption := SFieldType;

  OkBut.Caption := ResStr(SOKButton);
  CancelBut.Caption := ResStr(SCancelButton);
  HelpBut.Caption := ResStr(SHelpButton);
  HelpBut.Visible := boolShowHelpButton;
end;

{-----------------------------------------------}

procedure TNewFieldForm.OkButClick(Sender: TObject);
begin
  If (FieldNameEdit.Text='') or not ISValidIdent(FieldNameEdit.Text) then
  begin
    ModalResult:=mrNone;
    MessageBeep(0);
    ActiveControl:=FieldNameEdit;
  end;
end;

end.
