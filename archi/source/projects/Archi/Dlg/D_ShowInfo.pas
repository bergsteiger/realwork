unit D_ShowInfo;

{ $Id: D_ShowInfo.pas,v 1.17 2014/08/14 10:48:49 dinishev Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OvcBase, vtlister, StdCtrls, Buttons, ExtCtrls,
  BottomBtnDlg, HelpCnst, vtStringLister, afwControl, afwInputControl,
  l3Types, l3Interfaces,
  evEditorWindow, evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations, evCustomMemo, evMemo,
  arInterfaces, afwControlPrim, afwBaseControl, nevControl,
  evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evCustomEditorModelPart;

type
  TShowInfoDlg = class(TBottomBtnDlg, IInfoOut)
    emInfo: TevMemo;
  private
    { Private declarations }
  public
   constructor Create(AOwner: TComponent; aCaption : string); reintroduce;
   procedure AddString(const aStr : string; aFormat : Tl3ClipboardFormat = cf_Text);
   procedure StartData;
   procedure EndData;
  end;

  procedure ShowInfoDialog(const aCaption: AnsiString; anHelpId: Integer; const aFillProc: TarFillDocInfo);

implementation

{$R *.DFM}
{$Include l3Define.inc}

uses
  l3Base,
  evTypes,
  evdStyles,
  evFacadTextSource,
  evFacadeSelection
  ;

constructor TShowInfoDlg.Create(AOwner: TComponent; aCaption : string);
begin
 inherited Create(AOwner);
 Caption := aCaption;
 emInfo.ReadOnly := True;
 emInfo.TextSource.Processor.DefaultStyle := ev_saInterface;
end;

procedure TShowInfoDlg.AddString(const aStr : string; aFormat : Tl3ClipboardFormat = cf_Text);
begin
 evAddStringToTextSource(emInfo.TextSource, aStr, aFormat);
end;

procedure TShowInfoDlg.EndData;
begin
 emInfo.Modified := False;
 emInfo.Processor.UndoBuffer.Clear;
 emInfo.ReadOnly := True;
end;

procedure TShowInfoDlg.StartData;
begin
 emInfo.ReadOnly := False;
end;

procedure ShowInfoDialog(const aCaption: AnsiString; anHelpId: Integer; const aFillProc: TarFillDocInfo);
var
 l_Dlg: TShowInfoDlg;
begin
 l_Dlg := TShowInfoDlg.Create(nil, aCaption);
 try
  l_Dlg.HelpContext := anHelpId;
  aFillProc(l_Dlg as IInfoOut);
  l_Dlg.ShowModal;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

end.
