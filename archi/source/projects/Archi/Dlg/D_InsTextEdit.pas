unit D_InsTextEdit;

{$Include l3Define.inc}

{ $Id: D_InsTextEdit.pas,v 1.9 2012/06/05 13:19:05 voba Exp $}

// $Log: D_InsTextEdit.pas,v $
// Revision 1.9  2012/06/05 13:19:05  voba
// - ����� ������� �������� � ������� ����������, ������� ������ ProjectDefine.inc
//
// Revision 1.8  2008/10/13 13:33:56  dinishev
// <K> : 84640081
//
// Revision 1.7  2008/05/20 10:52:01  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.6  2008/04/16 11:50:20  lulin
// - �������� ����� ��� ������� �������� ������� � ������ ����������.
//
// Revision 1.5  2008/04/15 17:14:32  lulin
// - �������������� ������������ ����� �������� ���������.
//
// Revision 1.4  2008/04/15 08:30:51  dinishev
// ��������������� ������ ��������
//
// Revision 1.3  2007/12/03 10:04:01  dinishev
// ���������� �������� �� �����
//
// Revision 1.2  2005/07/14 10:15:43  fireton
// - add: ������� ������� ������� ���
//
// Revision 1.1  2005/06/15 15:00:14  fireton
// - ������ �������������� ������ ��� ������� �������
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, OvcBase, 
  evEditorWindow, evMultiSelectEditorWindow, evEditor, evMemo,
  evCustomEditor, evEditorWithOperations, vtForm, F_TextEditor,
  l3InterfacedComponent, l3ProgressComponent, evTextSource,
  evEditorWindowTextSource, evCustomTextSource, evTextSourcePublished;

type
  TInsTextEditDlg = class(TBottomBtnDlg)
   lblNameRus: TLabel;
   sbSpellChecker: TSpeedButton;
   TextEditorFrm: TTextEditorWin;
   TextSource: TevTextSource;
   Panel3: TPanel;
   procedure FormCreate(Sender: TObject);
  private
   { Private declarations }
  public
   { Public declarations }
   function Execute: Boolean; override;
  end;

var
  InsTextEditDlg: TInsTextEditDlg;

implementation

uses
  evFacadTextSource
  ;

{$INCLUDE ProjectDefine.inc}

{$R *.dfm}
                                                  
procedure TInsTextEditDlg.FormCreate(Sender: TObject);
begin
 inherited;
 TextEditorFrm.DocEditor.WebStyle := True;
 evSetTextParaLimit(TextEditorFrm.DocEditor.TextSource, 1);
end;

function TInsTextEditDlg.Execute: Boolean; //override;
begin
 with TextSource do
  if not Document.IsValid then
   New;
 Result := inherited Execute;
end;

end.
