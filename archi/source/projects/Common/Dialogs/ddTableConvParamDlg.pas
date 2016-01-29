unit ddTableConvParamDlg;

// $Id: ddTableConvParamDlg.pas,v 1.26 2015/04/09 11:42:31 dinishev Exp $

// $Log: ddTableConvParamDlg.pas,v $
// Revision 1.26  2015/04/09 11:42:31  dinishev
// {Requestlink:583082850}
//
// Revision 1.25  2015/04/09 10:26:40  dinishev
// {Requestlink:583082850}
//
// Revision 1.24  2012/03/21 07:36:58  dinishev
// {Requestlink:347636551}
//
// Revision 1.23  2012/03/20 11:59:02  dinishev
// Переносим evTableConverter на модель + избавляемся от лишних IFDEF + меняем его местоположение.
//
// Revision 1.22  2011/05/23 11:31:57  dinishev
// [$266421641]
//
// Revision 1.21  2011/02/17 07:25:14  dinishev
// [$254351028]
//
// Revision 1.20  2011/01/21 16:17:07  dinishev
// [$185830965]
//
// Revision 1.19  2005/05/27 14:44:22  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.18  2005/04/27 13:42:49  fireton
// - bug fix: минимальное значение масштаба должно быть не меньше 10%
//
// Revision 1.17  2004/01/08 15:03:51  narry
// - bug fix: QC#00004930 - Деление на ноль
//
// Revision 1.16  2003/10/14 16:38:03  law
// - rename unit: evTxtSrc -> evTextSource.
//
// Revision 1.15  2003/10/13 15:06:35  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.14  2003/05/15 11:15:36  narry
// - change: возможность управлять склейкой строк для псевдографической таблицы
//
// Revision 1.13  2003/05/12 09:20:09  narry
// - bug fix: преобразование таблиц, образованных пробелами
//
// Revision 1.12  2002/10/18 11:31:27  law
// - new folder: Meta.
//
// Revision 1.11  2002/05/21 11:07:16  narry
// - update
//
// Revision 1.10  2002/05/17 15:15:18  narry
// - update: область просмотра
//
// Revision 1.9  2002/04/18 08:20:20  narry
// - new behavior: изменение масштаба предварительного просмотра
//
// Revision 1.8  2002/04/18 07:53:41  narry
// - update: исправленный механизм преобразования текста в таблицу
//
// Revision 1.7  2001/08/24 07:28:57  voba
// - clear warning
//
// Revision 1.6  2001/02/20 13:29:49  voba
// Заменил rxSpin на vtSpin
//
// Revision 1.5  2000/12/15 16:21:58  law
// - вставлены директивы Log.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, vtSpin, ExtCtrls, ddTableConvTypes, l3InterfacedComponent,
  l3ProgressComponent, evTextSource, evEditorWindow, OvcBase,  evEditor, evMemo,
  Buttons, D_Base, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, afwControlPrim, afwBaseControl, afwControl,
  nevControl, evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, evCustomMemo, l3WinControlCanvas,
  evCustomEditorWindow;

type
  TCellCountEvent = procedure (CellCount: Longint) of object;
  TCellSeparatorEvent = procedure (CellSeparator: TddCellSeparator) of object;
  TShowPreviewEvent = procedure (Enable: Boolean) of Object;
  TAutoFitChangeEvent = procedure (AutoFit: TddAutoFitBehavior) of object;

  TTableConvParamDialog = class(TBaseDlg)
    Label1: TLabel;
    Label2: TLabel;
    spinCellCount: TvtSpinEdit;
    Label3: TLabel;
    spinRowCount: TvtSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    rbGraphic: TRadioButton;
    rbParagraph: TRadioButton;
    rbTab: TRadioButton;
    rbSemicolon: TRadioButton;
    rbSpace: TRadioButton;
    rbOther: TRadioButton;
    edOther: TEdit;
    Panel1: TPanel;
    rbFitWidth: TRadioButton;
    rbFitContent: TRadioButton;
    cbGlueLines: TCheckBox;
    cbIgnoreDoubles: TCheckBox;
    Button3: TButton;
    Label6: TLabel;
    PreviewMemo: TevMemo;
    spinWidth: TvtSpinEdit;
    Label7: TLabel;
    spinZoom: TvtSpinEdit;
    Label8: TLabel;
    procedure spinCellCountChange(Sender: TObject);
    procedure rbGraphicClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbGlueLinesClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure spinZoomBottomClick(Sender: TObject);
    procedure AutoFitChanged(Sender: TObject);
  private
    { Private declarations }
    f_OtherSeparator: String;
    F_OnCellCount: TCellCountEvent;
    f_OnCellSeparator : TCellSeparatorEvent;
    f_OnShowPreview: TShowPreviewEvent;
    f_OnAutoFitChanged: TAutoFitChangeEvent;
    f_SetParams: Boolean;
    f_OnGlueLines: TShowPreviewEvent;
    procedure SetCellCount(Value: Integer);
    function GetCellCount: Integer;
    procedure SetRowCount(Value: Integer);
    function GetRowCount: Integer;
    procedure SetCellSeparator(Value: TddCellSeparator);
    function GetCellSeparator: TddCellSeparator;
    function FullWidth : Integer;
    function SimpleWidth : Integer;
  public
    { Public declarations }
    function Execute: Boolean;

    property CellCount: Integer
      read GetCellCount write SetCellCount;
    property RowCount: Integer
      read GetRowCount write SetRowCount;
    property CellSeparator: TddCellSeparator
      read GetCellSeparator write SetCellSeparator;
    property Otherseparator: String
      read f_OtherSeparator write f_OtherSeparator;

    property SetParams: Boolean
     read f_SetParams
     write f_SetParams;
    property OnAutoFitChanged: TAutoFitChangeEvent
     read f_OnAutoFitChanged
     write f_OnAutoFitChanged;
    property OnCellCount: TCellCountEvent
     read f_OnCellCount
     write f_OnCellCount;
    property OnCellSeparator : TCellSeparatorEvent
     read f_OnCellSeparator
     write f_OnCellSeparator;
    property OnShowPreview: TShowPreviewEvent
     read f_OnShowPreview
     write f_OnShowPreview;
    property OnGlueLines: TShowPreviewEvent
     read f_OnGlueLines
     write f_OnGlueLines;
  end;

var
  TableConvParamDialog: TTableConvParamDialog;

implementation

{$R *.DFM}

Uses
 evDef,
 evFacadeGUI,

 Math;

procedure TTableConvParamDialog.SetCellCount(Value: Integer);
begin
 spinCellCount.AsInteger:= Value;
end;

function TTableConvParamDialog.GetCellCount: Integer;
begin
 Result:= spinCellCount.AsInteger;
 btOk.Enabled:= (Result >= spinCellCount.MinValue) and
                (Result <= spinCellCount.MaxValue);
end;

procedure TTableConvParamDialog.SetRowCount(Value: Integer);
begin
  spinRowCount.AsInteger:= Value;
end;

function TTableConvParamDialog.GetRowCount: Integer;
begin
  Result:= spinRowCount.AsInteger;
end;

procedure TTableConvParamDialog.SetCellSeparator(Value: TddCellSeparator);
begin
  case Value of
    csOther     : rbOther.Checked:= True;
    csGraphic   : rbGraphic.Checked:= True;
    csParagraph : rbParagraph.Checked:= True;
    csTab       : rbTab.Checked:= True;
    csSemicolon : rbSemicolon.Checked:= True;
    csSpace     : rbSpace.Checked:= True;
  end;
 spinCellCount.Enabled:= not (Value in [csGraphic, csSpace]); 
end;

function TTableConvParamDialog.GetCellSeparator: TddCellSeparator;
begin
  Result:= csOther;
  if rbOther.Checked then
    Result:= csOther
  else
  if rbGraphic.Checked then
    Result:= csGraphic
  else
  if rbParagraph.Checked then
    Result:= csParagraph
  else
  if rbTab.Checked then
    Result:= csTab
  else
  if rbSemicolon.Checked then
    Result:= csSemicolon
  else
  if rbSpace.Checked then
    Result:= csSpace;
end;

function TTableConvParamDialog.Execute: Boolean;
begin
 btOk.Enabled:= InRange(spinCellCount.AsInteger, spinCellCount.MinValue,
                                                 spinCellCount.MaxValue);
 Result:= ShowModal = mrOk;
end;

procedure TTableConvParamDialog.spinCellCountChange(Sender: TObject);
begin
  if not SetParams and Assigned(f_OnCellCount) and
     (CellCount >= spinCellCount.MinValue)then
    f_OnCellCount(CellCount);
end;

procedure TTableConvParamDialog.rbGraphicClick(Sender: TObject);
begin
 spinCellCount.Enabled:= (not rbGraphic.Checked) and (not rbSpace.Checked);
 cbIgnoreDoubles.Enabled:= rbOther.Checked;
 cbGlueLines.Enabled:= rbSpace.Checked or rbGraphic.Checked;
 OtherSeparator:= edOther.Text;

 if rbGraphic.Checked or rbSpace.Checked then
  rbFitContent.Checked:= True;
 rbFitContent.Enabled:= (not rbGraphic.Checked) and (not rbSpace.Checked);
 rbFitWidth.Enabled:= (not rbGraphic.Checked) and (not rbSpace.Checked);

 if not SetParams and Assigned(f_OnCellSeparator) then
  f_OnCellSeparator(CellSeparator);
end;

procedure TTableConvParamDialog.FormCreate(Sender: TObject);
begin
 spinCellCount.AsInteger:= 2;
 Width:= SimpleWidth;
 // - сделать перерасчет на большой шрифт
 PreviewMemo.TabStop := false;
 PreviewMemo.Canvas.DrawSpecial := True;
end;

procedure TTableConvParamDialog.cbGlueLinesClick(Sender: TObject);
begin
  if not SetParams and Assigned(f_OnGlueLines) then
    f_OnGlueLines(cbGlueLines.Checked);
end;

procedure TTableConvParamDialog.Button3Click(Sender: TObject);
begin
 if (Width = SimpleWidth) then begin
  Width:= FullWidth;
  PreviewMemo.TabStop := true;
 end else begin
  Width:= SimpleWidth;
  PreviewMemo.TabStop := false;
 end;
 //Position:= poDesktopCenter;
 if Assigned(f_OnShowPreview) then
  f_OnShowPreview(Width = FullWidth);
end;

procedure TTableConvParamDialog.spinZoomBottomClick(Sender: TObject);
begin
 if spinZoom.AsInteger >= spinZoom.MinValue then
  PreviewMemo.Zoom := spinZoom.AsInteger;
end;

procedure TTableConvParamDialog.AutoFitChanged(Sender: TObject);
begin
 { Инициировать пересчет ширины }
 if Assigned(f_OnAutoFitChanged) then
  f_OnAutoFitChanged(TddAutoFitBehavior(TComponent(Sender).Tag));
end;

function TTableConvParamDialog.FullWidth : Integer;
begin
 with PreviewMemo do
  Result := Left + Width + 20;
end;

function TTableConvParamDialog.SimpleWidth : Integer;
begin
 with PreviewMemo do
  Result := Left - 1;
end;

end.
