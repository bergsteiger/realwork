{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit MaskPr;
{$I dc.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Mask,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcsystem,dcconsts,consts,dcgen, dccommon, dcdreamlib
  {$IFDEF D6} ,maskutils {$ENDIF}
  ;

type
  TMaskEditForm = class(TForm)
    Linputmask: TLabel;
    InputMaskEdit: TEdit;
    LCharBlank: TLabel;
    BlankEdit: TEdit;
    SaveLiteral: TCheckBox;
    CrTestInput: TGroupBox;
    TestEdit: TMaskEdit;
    MaskGrid: TStringGrid;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    MaskButton: TButton;
    OpenDialog: TOpenDialog;
    procedure MaskButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BlankEditChange(Sender: TObject);
    procedure InputMaskEditChange(Sender: TObject);
    procedure SaveLiteralClick(Sender: TObject);
    procedure MaskGridClick(Sender: TObject);
  private
    L:TStringList;
  public
    procedure LoadMasksFromFile(Const AFile:String);
  end;

  TEditMaskPropEdit = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

var
  MaskEditForm: TMaskEditForm;

Function EditMaskProp(Var AMask,AMaskPath:String):Boolean;

implementation
{$R *.DFM}

Var
  MaskPath:String;

{------------------------------------------------------------------}

procedure TEditMaskPropEdit.Edit;
var
  amask : string;
  apath : string;
begin
  amask := GetStrValue;
  apath := ReadFromRegistry('PropEdit\DEMPath',''); //don't resource
  if EditMaskProp(AMask, apath) then
    begin
      SetStrValue(AMask);
      Designer.Modified;
    end;
  WriteToRegistry('PropEdit\DEMPath',APath); //don't resource
end;

{------------------------------------------------------------------}

function TEditMaskPropEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paDialog];
end;

{-----------------------------------------------------------}

Function ExtractStrPart(Const S:String; I:Integer; C:Char):String;
Var
  k,a:Integer;
  SS:String;
Label
  l1;
begin
  a:=0;
  SS:=S+C;
l1:
  k:=Pos(c,SS);
  Result:=Copy(SS,1,k-1);
  Delete(SS,1,k);
  If a<i then
  begin
    inc(a);
    goto l1;
  end;
end;

{-----------------------------------------------------------}

Function ConvertMaskLiteral(Const S,ABlank:String;V:Integer):String;
Const
  cMaskLit:Array[0..1] of Char=('0','1');
Var
  ss:String;
begin
  Result:=ExtractStrPart(S,0,';')+';';
  If V>1
  then
    Result:=Result+ExtractStrPart(S,1,';')
  else
    Result:=Result+cMaskLit[V];
  sS:=ExtractStrPart(S,2,';');
  If (sS<>'') and (ABlank=#0)
  then
    Result:=Result+';'+sS
  else
    Result:=Result+';'+ABlank;
end;

{-----------------------------------------------------------}

Function ExtractDemLine(Const S:String;I:Integer):String;
begin
  Result:=ExtractStrPart(S,i,'|');
end;

{-----------------------------------------------------------}
Const
//BeginSkipConst
  cMaxMasks=7;
  CDefMasks:Array[0..cMaxMasks] of String=(
    'Phone | 4155551212 | !\(999\)000-0000;1;_',
    'Extension | 15450 | !99999;1;_',
    'Social Security | 555555555 | 000\-00\-0000;1;_',
    'Short Zip Code | 90504 | 00000;1;_',
    'Long Zip Code | 905040000 | 00000\-9999;1;_',
    'Date | 062794 | !99/99/00;1;_',
    'Long Time | 090515PM | !90:00:00>LL;1;_',
    'Short Time | 1345 | !90:00;1;_');
//EndSkipConst

procedure TMaskEditForm.LoadMasksFromFile(Const AFile:String);
Var
  i:Integer;
  S:String;
begin
  With MaskGrid do
  begin
    L.Clear;
    RowCount:=0;
    try

      If FileExists(AFile)
      then
        L.LoadFromFile(AFile)
      else
        for i:=0 to cMaxmasks do
          L.Add(cDefmasks[i]);

      RowCount:=L.Count;
      For i:=0 to L.Count-1 do
        If Trim(L[i])<>'' then
        begin
          Cells[0,i]:=ExtractDemLine(L[i],0);
          s:=ConvertMaskLiteral(Trim(ExtractDemLine(L[i],2)),#0,0);
          Cells[1,i]:=' '+FormatMaskText(s,Trim(ExtractDemLine(L[i],1)));
        end;
    finally
      ColWidths[0]:=ClientWidth div 2-1;
      ColWidths[1]:=ClientWidth div 2;
      Row:=0;
    end;

  end;
end;

{-----------------------------------------------------------}

Function EditMaskProp(Var AMask,AMaskPath:String):Boolean;
begin
  MaskPath:=AMaskPath;
  With TMaskEditForm.Create(Application) do
  try
    InputMaskEdit.Text:=AMask;
    BlankEdit.Text:=DefaultBlank;
    Result:=ShowModal=mrOk;
    If Result then
      AMask:=InputMaskEdit.Text;
    AMaskPath:=MaskPath;
  finally  
    Free;
  end;
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.MaskButtonClick(Sender: TObject);
begin
  OpenDialog.FileName:=Maskpath;
  If OpenDialog.Execute then
  begin
    Maskpath:=OpenDialog.FileName;
    LoadMasksFromFile(MaskPath);
  end;
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  L:=TStringList.Create;
  LoadMasksFromFile(MaskPath);

  Caption := RemoveCharSet(['&','.'],SVerbInputMaskEditor);
  Linputmask.Caption := SInputMask;
  LCharBlank.Caption := SCharBlank;
  SaveLiteral.Caption := SSaveLiterChar;
  CrTestInput.Caption := STestInput;
  MaskButton.Caption := SMask ;

  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.FormDestroy(Sender: TObject);
begin
  L.Free;
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.BlankEditChange(Sender: TObject);
begin
 If (InputMaskedit.Text<>'') and (BlankEdit.Text<>'') then
   InputMaskedit.Text:=ConvertMaskLiteral(InputMaskedit.Text,BlankEdit.Text,2);
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.InputMaskEditChange(Sender: TObject);
begin
  TestEdit.EditMask:=InputMaskEdit.Text;
  TestEdit.Text:='';
  BlankEdit.Text:=Copy(ExtractStrPart(InputMaskEdit.Text,2,';'),1,1);
  If BlankEdit.Text='' then
    BlankEdit.Text:=DefaultBlank;
  SaveLiteral.Checked:=ExtractStrPart(InputMaskEdit.Text,1,';')='1';
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.SaveLiteralClick(Sender: TObject);
begin
  If InputMaskEdit.Text='' then exit;
  If SaveLiteral.Checked
  Then
    InputMaskedit.Text:=ConvertMaskLiteral(InputMaskedit.Text,BlankEdit.Text,1)
  else
    InputMaskedit.Text:=ConvertMaskLiteral(InputMaskedit.Text,BlankEdit.Text,0);
end;

{-----------------------------------------------------------}

procedure TMaskEditForm.MaskGridClick(Sender: TObject);
begin
  InputMaskEdit.Text:=ExtractDemLine(L[MaskGrid.Row],2);
end;

{-----------------------------------------------------------}
procedure _InstantRegister;
begin
  {$IFDEF D6}
  RegisterPropertyEditor(TypeInfo(TEditMask), TComponent, 'EditMask', TEditMaskPropEdit); //don't resource
  {$ELSE}
  RegisterPropertyEditor(TypeInfo(String), TComponent, 'EditMask', TEditMaskPropEdit); //don't resource
  {$ENDIF}
  RegisterVisualProperty(SVerbInputMaskEditor,TMaskEdit,'EditMask');//don't resource
end;

{-----------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
end;

{-----------------------------------------------------------}

initialization
  RunRegister;
end.
