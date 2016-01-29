unit b132Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, dt_DbInfo, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    deBasePath: TDirectoryEdit;
    btnExecute: TButton;
    stDisp: TStaticText;
    Bevel1: TBevel;
    procedure deBasePathAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure btnExecuteClick(Sender: TObject);
  private
    { Private declarations }
   f_DbInfo: TDbInfo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 l3Base,
 HT_DLL,
 HT_Const,
 DT_DbReformer;

{$R *.dfm}

const
 DT7_TBL = 'DT#7001';
 c_ComentFieldName = 'Coment';

procedure TForm1.deBasePathAfterDialog(Sender: TObject; var Name: String;
  var Action: Boolean);
begin
 if Action then
 begin
  if Assigned(f_DbInfo) then
   FreeAndNil(f_DbInfo);
  f_DbInfo := TDbInfo.Make(Name);
  stDisp.Caption := f_DbInfo.Data;
  btnExecute.Enabled := f_DbInfo.MainFolderVersion = 133;
 end;
end;

procedure fn_RestoreCommentField(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_Tmp: ThtElementInfo;
begin
 SetLength(aStruct, Length(aStruct) + 1);
 aStruct[5] := aStruct[4];
 l3FillChar(l_Tmp, SizeOf(ThtElementInfo));
 with l_Tmp do
 begin
  wLength := 70;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_CHAR;
  cKey    := EK_NOTKEY;
  mName   := c_ComentFieldName;
 end;
 aStruct[4] := l_Tmp;
end;

procedure TForm1.btnExecuteClick(Sender: TObject);
var
 l_BR : TDbReformer;
begin
 Screen.Cursor := crHourGlass;
 try
  l_BR := TDbReformer.Create(f_DbInfo);
  try
   l_BR.InitHt;
   try
    l_BR.RestructTable(DT7_TBL, ffGarant, fn_RestoreCommentField);
   finally
    l_BR.CloseHt;
   end;
  finally
   l3Free(l_BR);
  end;
  f_DbInfo.MainFolderVersion := 132;
  f_DbInfo.FamilyFolderVersion := 132;
  stDisp.Caption := f_DbInfo.Data;
  btnExecute.Enabled := False;
 finally
  Screen.Cursor := crDefault;
 end;
 MessageDlg('Откачено успешно!', mtInformation, [mbOK], 0);
end;

end.
