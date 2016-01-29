unit hcQueryStatusForm;

// ���������� : �������� ����;
// �����      : ������� �.�.;
// �����      : 26.03.2006 16.48;
// ������     : hcUtils;
// ��������   : ��������� ������� �������;
// ������     : $Id: hcQueryStatusForm.pas,v 1.6 2008/03/03 06:56:34 mmorozov Exp $

{-------------------------------------------------------------------------------
  $Log: hcQueryStatusForm.pas,v $
  Revision 1.6  2008/03/03 06:56:34  mmorozov
  - new: ��������� ����� �������� � ������� ������������ ����� ���� ���� � ������� �� ������� �� ����� ������������, ������������� ������ ����������, ������� ��������� �������� ����� ��������;

  Revision 1.5  2008/02/27 06:10:04  mmorozov
  - new: � �� ���� �������� ����������� �������� � ������� ������������ (CQ: OIT5-28426);

  Revision 1.4  2008/02/26 13:15:44  mmorozov
  - new: ���������� �������� �������� (CQ: OIT5-28426);

  Revision 1.3  2007/06/29 06:05:19  mmorozov
  - bugfix: �������� �� ��� ����� � ������ ������� ��������� ������ � ������ (CQ: OIT5-25586);

  �����������:
  - ������ ��������������� �������� ��� ������ � ���������� ���������� XMLDocument;
  - ��������� ��������� ������� ��� ������ ��������, ������/������ ��� ��������;
  - �������������� ����� ������������ ����� ��� ������ � ���������� ������������;
  - ������������� ������������ ���� ���������;
  - ������������ ������������ ������������ ���� ��� �� ������� ����������, � �� ������ ��� ��� ������;
  - �������� �������� ������ "������" � "���������" ���������, � �������� ��������� �������� ���������� 'jrn', 'sts'. ����� �������, � ����� ����, ��� ��������� ������ ����� ������� ����� ��� � � �������;

  Revision 1.2  2007/01/24 09:20:39  mmorozov
  - MERGE WITH B_NEMESIS_6_4 (CQ: OIT5-24141);

  Revision 1.1.2.1  2007/01/24 08:52:15  mmorozov
  - ����� �������� ������������ (CQ: OIT5-24141);

-------------------------------------------------------------------------------}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  SHDocVw,
  Grids,

  vtLabel,

  hcInterfaces
  ;

type
  TfrmQueryStatus = class(TForm)
    pnlQueryBrowser: TPanel;
    Splitter1: TSplitter;
    pnlStatusBrowser: TPanel;
    pnlQueryEditor: TPanel;
    pnlShowQueryEditor: TPanel;
    btnQueryEditor: TButton;
    pnlQueryEditorButtons: TPanel;
    btnDoQuery: TButton;
    vtQuery: TvtLabel;
    vtLabel1: TvtLabel;
    vtLabel2: TvtLabel;
    sgQueryInfo: TStringGrid;
    sBottom: TSplitter;
    procedure btnQueryEditorClick(Sender: TObject);
    procedure btnDoQueryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  // fields
    f_Manager  : IhcManager;
    f_QueryWB  : TWebBrowser;
    f_StatusWB : TWebBrowser;
    f_Builder  : IhcQueryBuilder;
  private
  // methods
    procedure ShowQueryEditor;
      {* - �������� �������� ��������. }
    procedure ShowStatus;
      {* - �������� ������� ������������. }
  private
  // proeprties
    property Builder: IhcQueryBuilder
      read f_Builder
      write f_Builder;
      {-}
  public
  // methods
    constructor Create(          aOwner : TComponent;
                       const aBuilder   : IhcQueryBuilder);
      reintroduce;
      {-}
    destructor Destroy;
      override;
      {-}
  end;//TfrmQueryStatus

implementation

uses
  hcUtils,
  hcQueryIdList,
  hcDeleteQueryOptionsForm
  ;

{$R *.dfm}

const
  c_IdCol      = 0;
  c_VersionCol = 1;
  c_FirstRow   = 1;

{ TfrmQueryStatus }

constructor TfrmQueryStatus.Create(          aOwner : TComponent;
                                   const aBuilder   : IhcQueryBuilder);
begin
 inherited Create(aOwner);
 f_QueryWB := hcMakeWebBrowser(pnlQueryBrowser);
 f_StatusWB := hcMakeWebBrowser(pnlStatusBrowser);
 Builder := aBuilder;
 ShowStatus;
end;//CreateNew

procedure TfrmQueryStatus.ShowStatus;
  {* - �������� ������� ������������. }
begin
 with Builder do
 begin
  hcLoadToBrowser(f_QueryWB, QueryXML);
  hcLoadToBrowser(f_StatusWB, AnswerXML);
 end;
end;//ShowStatus

procedure TfrmQueryStatus.ShowQueryEditor;
begin
 with pnlQueryEditor do
 begin
  sBottom.Visible := not Visible;
  Visible := not Visible;
  if Visible then
   sBottom.Top := Top - sBottom.Height;
 end;
end;//ShowQueryEditor

procedure TfrmQueryStatus.btnQueryEditorClick(Sender: TObject);
begin
 ShowQueryEditor;
end;//btnQueryEditorClick

procedure TfrmQueryStatus.btnDoQueryClick(Sender: TObject);
var
 l_QueryXML : String;
 l_Index    : Integer;
 l_Id       : PhcConsultationId;
 l_Queries  : IhcQueryIdList;
begin
 l_Queries := ThcQueryIdList.Make;
 try
  with sgQueryInfo do
   for l_Index := c_FirstRow to Pred(RowCount) do
    if (Cells[c_IdCol, l_Index] <> '') and (Cells[c_VersionCol, l_Index] <> '') then
     l_Queries.AddQuery(Cells[c_IdCol, l_Index], Cells[c_VersionCol, l_Index]);
  if l_Queries.Count > 0 then
  begin
   Builder.Build(l_Queries);
   ShowStatus;
  end;//if l_Queries.Count > 0 then
 finally
  l_Queries := nil;
 end;//try..finally
end;//btnShowStatusClick

procedure TfrmQueryStatus.FormCreate(Sender: TObject);
begin
 sgQueryInfo.Cells[c_IdCol, 0] := '������������� �������';
 sgQueryInfo.Cells[c_VersionCol, 0] := '������ �������';
end;

destructor TfrmQueryStatus.Destroy;
begin
 Builder := nil;
 inherited;
end;

end.
