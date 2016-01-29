unit SimpleMainMenu_Form;

// ���������� : ������ �������;
// ��������   : enSimpleMainMenu
// �����      : ������� �.�.
// ���������� : ������� �������� ����;
// ������     : $Id: SimpleMainMenu_Form.pas,v 1.32 2014/08/19 12:04:56 kostitsin Exp $

(*-------------------------------------------------------------------------------
   $Log: SimpleMainMenu_Form.pas,v $
   Revision 1.32  2014/08/19 12:04:56  kostitsin
   {requestlink: 562594400 }

   Revision 1.31  2014/08/19 11:26:51  kostitsin
   {requestlink: 562594400 }

   Revision 1.30  2013/01/22 15:59:55  kostitsin
   [$424399029]

   Revision 1.29  2010/05/26 12:08:23  oman
   Warning fix

   Revision 1.28  2010/04/30 17:43:44  lulin
   {RequestLink:207389954}.

   Revision 1.27  2010/04/30 15:27:06  lulin
   {RequestLink:207389954}.
   - ������ ����.

   Revision 1.26  2010/02/04 16:09:51  lulin
   {RequestLink:185834848}.

   Revision 1.25  2010/02/01 08:46:40  oman
   - fix: {RequestLink:185827991}

   Revision 1.24  2009/12/07 19:13:55  lulin
   - ������ �������� ������.

   Revision 1.23  2009/11/18 13:06:32  lulin
   - ���������� ������� ��������� ��������.

   Revision 1.22  2009/10/12 11:27:49  lulin
   - �������� ����� ������� CVS.

   Revision 1.22  2009/10/08 11:37:12  lulin
   - ���������� �������.

   Revision 1.21  2009/10/07 12:12:18  lulin
   - ���������������� � ������ ����� ��������� ����.

   Revision 1.20  2009/10/05 18:42:53  lulin
   {RequestLink:162596818}. ������ ������.

   Revision 1.19  2009/10/05 11:15:24  lulin
   {RequestLink:162596818}. �������������� ��������������.

   Revision 1.18  2009/09/30 17:25:14  lulin
   - ��������������� �������� ��������� ������� �����, ����� � ����� ���� ������.

   Revision 1.17  2009/09/28 19:36:42  lulin
   - ������� �� StdRes ��������� ��� �������� �������.

   Revision 1.16  2009/09/28 18:51:08  lulin
   - ������� ������ ����� ��� ������ ��������.

   Revision 1.15  2009/09/24 16:41:20  lulin
   - ���������� ���������� �� ������ ������ Common.

   Revision 1.90  2009/09/18 12:21:45  lulin
   - ������������� �������, ������ ��������� �� ������.

   Revision 1.89  2009/09/09 18:55:32  lulin
   - ��������� �� ������ ��� ��������.

   Revision 1.88  2009/09/03 18:49:28  lulin
   - ����������������� ������ � ������� ��������.

   Revision 1.87  2009/09/03 13:26:27  lulin
   - ������ ���������� ����� �������������� ���� �� �����.

   Revision 1.86  2009/08/21 12:44:33  lulin
   {RequestLink:159360578}. �8.

   Revision 1.85  2009/08/13 12:16:32  oman
   - new: ����� ���������� ����������� - {RequestLink:159355458}

   Revision 1.84  2009/08/13 07:13:08  oman
   - new: ����� ���������� ����������� - {RequestLink:159355458}

   Revision 1.83  2009/08/12 10:48:09  oman
   - new: ������ ����������� - {RequestLink:159355458}

   Revision 1.82  2009/08/06 17:18:10  lulin
   - ��������� �������� ��������� �������� � ������ ��������.

   Revision 1.81  2009/08/06 16:08:33  lulin
   {RequestLink:159352843}.

   Revision 1.80  2009/02/20 10:12:54  lulin
   - ������ ������������.

   Revision 1.79  2009/02/10 19:03:50  lulin
   - <K>: 133891247. �������� �������� ���������� ������.

   Revision 1.78  2009/02/09 15:51:04  lulin
   - <K>: 133891247. �������� ���������� ��������� ����.

   Revision 1.77  2009/01/19 11:22:23  lulin
   - <K>: 135597923.

   Revision 1.76  2009/01/16 12:37:41  lulin
   - bug fix: http://mdp.garant.ru/pages/viewpage.action?pageId=135597923

   Revision 1.75  2009/01/12 15:58:31  lulin
   - <K>: 133138664. � 22.

   Revision 1.74  2008/12/29 16:40:59  lulin
   - <K>: 134316705.

   Revision 1.73  2008/12/29 15:26:39  lulin
   - <K>: 133891773.

   Revision 1.72  2008/12/25 12:20:05  lulin
   - <K>: 121153186.

   Revision 1.71  2008/12/24 19:49:38  lulin
   - <K>: 121153186.

   Revision 1.70  2008/11/07 14:20:09  lulin
   - <K>: 121167570.

   Revision 1.69  2008/11/01 11:19:53  lulin
   - <K>: 121167580.

   Revision 1.68  2008/11/01 10:58:28  lulin
   - <K>: 121167580.

   Revision 1.67  2008/11/01 10:37:54  lulin
   - <K>: 121167580.

   Revision 1.66  2008/11/01 10:08:55  lulin
   - <K>: 121167580.

   Revision 1.65  2008/10/31 11:55:07  lulin
   - <K>: 121167580.

   Revision 1.64  2008/07/07 14:27:06  lulin
   - ���������������� � ��������������.

   Revision 1.63  2008/06/18 10:33:00  mmorozov
   - new: ��������� �������� ��������� (CQ: OIT5-29385);

   Revision 1.62  2008/05/22 07:05:59  mmorozov
   - new: �������� ���� ������.

   Revision 1.61  2008/05/15 18:16:27  lulin
   - �������� ��������.

   Revision 1.60  2008/05/13 16:24:26  lulin
   - ��������� � ������ <K>: 90441490.

   Revision 1.59  2008/04/08 08:12:50  oman
   - new: ����������� �� ��� �������

   Revision 1.58  2007/12/28 17:49:53  lulin
   - ������ �������� ���������� �����.

   Revision 1.57  2007/12/25 12:27:28  mmorozov
   - new: ���������� ����� ���������� ������� � ���������� ������ AS (� ������ CQ: OIT5-27823);

   Revision 1.56  2007/12/25 11:32:20  mmorozov
   - new: �������� �� ���������� ������ ���������� (CQ: OIT5-27823);

   Revision 1.55  2007/12/17 12:22:32  mmorozov
   - ����������� � ������ ��������������, � ����� ��������� ���������������� �������� + ����������� �� �������� enSystem.opConfigUpdated (� ������ CQ: OIT5-27823);

   Revision 1.54  2007/12/12 12:21:23  mmorozov
   - cleanup: �������� �������� enSystem (opActiveConfigChange, _opSetActive) (� ������ ������ ��� CQ: OIT5-27823);

   Revision 1.53  2007/12/04 12:36:38  oman
   - new: ������ ������ ����������� ������ ��� �� (cq27326)

   Revision 1.52  2007/11/13 13:37:55  mmorozov
   - new: ��������� ������� ���� � ������� �������� ���� (CQ: OIT5-27201);

   Revision 1.51  2007/10/30 12:39:44  mmorozov
   - rename field;

   Revision 1.50  2007/10/22 11:53:26  mmorozov
   - bugfix: �� ���������� ����������� �������� ��� �������� (CQ: OIT5-27167);

   Revision 1.49  2007/10/16 12:29:36  mmorozov
   - new behviour: ���������� TnscTreeView (� ������ ������ ��� CQ: OIT5-26997);

   Revision 1.48  2007/10/10 12:55:27  mmorozov
   - bugfix: ������������ ������� ��������� �����, � ����� ���� ������������ ��������� �������� ��������, �� ������� ����� ����� ���������, ������ ����������� ��� ������������ ������������ (�������� � �������� CQ: OIT5-26991);

   Revision 1.47  2007/08/28 10:33:50  oman
   - new: ������ �� ������� ������ � ��� (cq26503)

   Revision 1.46  2007/08/28 07:26:04  oman
   - fix: ���������� �� �� �������� ����� (cq26511)

   Revision 1.45  2007/08/13 05:53:47  mmorozov
   - change: ������ ��������� �������� ���������� ������� ��������������� (CQ: OIT5-26279);

   Revision 1.44  2007/08/09 10:05:47  oman
   - new: �������� �� �� �� �������� ��� ������ ����� �� - �.�. �
    ����������� ������ ��������� ������ �� (cq26300)

   Revision 1.43  2007/07/30 09:24:32  mmorozov
   - new: ���������� ������� ������ ��� �������� ����� ���� ��������� ����������� ����;

   Revision 1.42  2007/06/14 13:50:15  mmorozov
   - change: ������� �������;

   Revision 1.41  2007/05/08 11:17:37  oman
   - fix: ��� �������� �������� ������  (cq25145)

   Revision 1.40  2007/05/07 14:31:18  mmorozov
   - new: ������� �� ��������� ���� ��������� ���� � ���������� (CQ: OIT5-24871);

   Revision 1.39  2007/05/04 10:55:06  oman
   - fix: ������� ����� - �� �������� � �� ������ �����

   Revision 1.38  2007/05/04 07:45:47  oman
   - fix: ���������� ��� �������� ������ ���������� � ������ (cq25145)

   Revision 1.37  2007/05/03 15:01:32  oman
   - fix: ���� ����������� ������� ��� ��� ����� ������ (cq25149)

   Revision 1.36  2007/05/03 14:25:00  oman
   - fix: �������� ����������� ������� ��� (cq25149)

   Revision 1.35  2007/05/03 09:44:21  mmorozov
   - change: �������� ��������� "������������ ��������� ����" (CQ: OIT5-25061);

   Revision 1.34  2007/05/03 08:24:03  oman
   - new: ����� ������� ����� �� ����������� ��������� ���� (cq25149)

   Revision 1.33  2007/05/03 06:57:56  oman
   - new: ������������� ������� ��������� �������� ���� ��������
    ������ (cq25145)

   Revision 1.32  2007/05/02 14:23:22  oman
   - fix: ����� ���������� �������� ��������/������������ ���� (cq25145)

   Revision 1.31  2007/05/02 09:07:00  oman
   - new: �������� ��������/������������ ���� (cq25145)

   Revision 1.30  2007/04/28 12:05:54  oman
   - new: �������������� ��������� ��������� �����������
    ��� �������� ������ (cq25145)

   Revision 1.29  2007/04/17 12:31:51  mmorozov
   - bugfix: ������������ �����;

   Revision 1.28  2007/04/17 12:08:56  mmorozov
   - change: ���������� ���������� ������� ��� ���������� �������� �����;

   Revision 1.27  2007/04/17 11:50:00  lulin
   - cleanup.

   Revision 1.26  2007/04/17 10:49:20  mmorozov
   - new: �������� �� (CQ: OIT5-25062);

   Revision 1.25  2007/04/16 10:41:48  oman
   - fix: ��������������� "�������� ���������" � "��������
    ��������� ������" (cq25059)

   Revision 1.24  2007/04/11 15:15:37  mmorozov
   - new: � ������� �������� ���� ���������� ������ �������� � ������ ��������� �������� (CQ: OIT5-24958);
   - change: ����� ��������;

   Revision 1.23  2007/04/09 13:04:00  mmorozov
   - bugfix: ��� ������ � �������� ���� ���������� ���������� ������� ������ (CQ: OIT5-24547);

   Revision 1.22  2007/04/06 08:29:48  mmorozov
   - new: � �������� ������� ������� ����� + ����� �� ����� ������ � �������, ������ ����� ��������� ����� �������� (Loaded) (CQ: OIT5-24903);

   Revision 1.21  2007/04/06 07:52:07  mmorozov
   - change: �������� ������������, ��������� ����� (CQ: OIT5-24602);

   Revision 1.20  2007/04/05 13:42:45  lulin
   - ����������� �� ������ �������������� �����.

   Revision 1.19  2007/03/28 19:43:02  lulin
   - ����������� �������� ��������� �� ������ � ����������.

   Revision 1.18  2007/03/28 11:40:39  mmorozov
   - rename method;

   Revision 1.17  2007/03/28 11:04:56  mmorozov
   - "������� �������� ������" ���������� � ���������� ���������� ����������� ������� �������;

   Revision 1.16  2007/03/22 12:29:34  mmorozov
   - change: ������ ����� ��������� � ���� ����������� ���� � ������� ���������� � ����� �����;

   Revision 1.15  2007/03/20 11:38:15  lulin
   - �� ������ ��������� ��� ������������ ���������� ���� � ���������.

   Revision 1.14  2007/03/02 13:15:48  lulin
   - ������������ ������ � ����������, ��� �������������� �� � ������ �����������.

   Revision 1.13  2007/02/16 19:19:18  lulin
   - � ���������� ������� ���������� ������ ������ �����.

   Revision 1.12  2007/02/09 15:56:18  mmorozov
   - new: ��������� ��������� ����� �� ��������� � ������� �������� ���� (CQ: OIT5-24353);

   Revision 1.11  2007/02/08 13:36:12  mmorozov
   - new: ������� �� ����� �� ������� ��������� (CQ: OIT5-24293);

   Revision 1.10  2007/02/08 12:39:43  mmorozov
   - change: �������� � �������� ������ �� ������ � ���������� ������ ���������� (CQ: OIT5-23939);

   Revision 1.9  2007/02/07 14:30:43  lulin
   - ��������� �� ������ � ����������.

   Revision 1.8  2007/02/05 12:06:09  mmorozov
   - opt: �� ������ ������ ��� ������� ���������;

   Revision 1.7  2007/02/05 11:08:29  mmorozov
   - new behaviour: ������������� ���� ����� �������� �� �������;

   Revision 1.6  2007/02/02 14:55:09  mmorozov
   - new: ���������� ����� ���� ����� �����������;

   Revision 1.5  2007/02/02 08:39:11  lulin
   - ��������� �� ������ � ����������.

   Revision 1.4  2007/01/29 14:29:23  mmorozov
   - new: ������ ������� �������; ���������� �������� ������; (� ������ CQ: OIT5-24234);

   Revision 1.3  2007/01/29 10:08:33  mmorozov
   - new: � ������ ������ ��� CQ: OIT5-24234;
   - bugfix: �� ��������� ������� ����� ������������ ����;

   Revision 1.2  2007/01/19 14:35:45  mmorozov
   - new: ����� �� ��������� � ������� �������� ��������� ���� (CQ: OIT5-23939);

   Revision 1.1  2007/01/18 12:57:20  mmorozov
   - new: ������� �������� ���� (CQ: OIT5-23939);
-------------------------------------------------------------------------------*)

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,

  afwControl,
  afwInputControl,
  afwInterfaces,
  afwCustomCommonControl,

  l3Interfaces,
  l3TreeInterfaces,

  vtLabel,
  vtLister,
  vtOutliner,
  vtOutlinerWithQuickSearch,
  vtOutlinerWithDragDrop,
  vtHideField,

  OvcBase,

  vtPanel,

  ElXPThemedControl,

  AbstractDropDown,
  DropDownTree,

  eeTreeViewExport,
  eeTreeView,

  nscInterfaces,
  nscCombobox,

  vcmInterfaces,
  vcmBase,
  vcmEntityForm,
  vcmEntities,
  vcmComponent,
  vcmBaseEntities,
  vcmExternalInterfaces,

  nscHideField,
  nscTreeView,

  nsMainMenuNew,

  MainMenuNewRes, afwControlPrim, afwBaseControl, afwTextControlPrim,
  afwTextControl,

  bsInterfaces,
  WorkJournalInterfaces,

  PrimSimpleMainMenu_Form, l3InterfacedComponent,

  BaseSearchInterfaces, nscTreeViewHotTruck
  ;

type
  Ten_SimpleMainMenu = class(TvcmEntityFormRef)
    Entities : TvcmEntities;
    pnlMain: TvtPanel;
    hfSearch: TnscHideField;
    hfLawNews: TnscHideField;
    hfLawSupport: TnscHideField;
    hfReferences: TnscHideField;
    hfLastOpenDocs: TnscHideField;
    tvSearch: TnscTreeView;
    tvLawSupport: TnscTreeView;
    tvLastOpenDocs: TnscTreeViewHotTruck;
    tvReferences: TnscTreeViewHotTruck;
    tvLawNews: TnscTreeViewHotTruck;
    procedure lblCompNameClick(Sender: TObject);
  protected
  // methods
    procedure DoInitKeyboardNavigation(const aTable : InscTabTable); override;
      {-}
    procedure LoadLastOpenDocs; override;
      {* - ��������� ������ ��������� �������� ����������. }
    function DoBuildGrid: InscArrangeGrid; override;
      {* - ��������� ����� ���������. }
    procedure LoadTrees; override;
      {-}
  end;//Ten_SimpleMainMenu

implementation

uses
  l3Base,
  l3String,
  l3Chars,
  
  afwFacade,

  lgTypes,

  vcmStringList,

  nscArrangeGrid,
  nscArrangeGridCell,

  StartUnit,

  nsTypes,
  nsUtils,
  nsSettings,
  nsConst,
  nscTabTable,
  nscTabTableCell,
  nsOpenUtils,

  DataAdapter,

  StdRes,
  nsLastOpenDocTree,
  smSearchTree,
  smLawNewsTree,
  smLawSupport,
  smReferencesTree,

  MainMenuDomainInterfaces
  ;

{$R *.DFM}

function Ten_SimpleMainMenu.DoBuildGrid: InscArrangeGrid;
begin
 Result := TnscArrangeGrid.Make(False);
 with Result do
 begin
  AddColumn;
  AddColumn;
  AddRow;
  AddRow;
  Cell[0, 0] := TnscHideFieldCell.Make(hfSearch, True);
  Cell[0, 1] := TnscHideFieldCell.Make(hfReferences, True);
  Cell[1, 0] := TnscHideFieldCell.Make(hfLawNews, True);
  Cell[1, 1] := TnscHideFieldCell.Make(hfLawSupport, True);
  MergeCells(2, 0, 1, TnscHideFieldCell.Make(hfLastOpenDocs));
 end;//with Result do
end;//BuildGrid

procedure Ten_SimpleMainMenu.LoadTrees;
begin
 inherited;
 tvSearch.TreeStruct := TsmSearchTree.Make;
 tvLawSupport.TreeStruct := TsmLawSupport.Make;
end;

procedure Ten_SimpleMainMenu.DoInitKeyboardNavigation(const aTable : InscTabTable);
begin
 // ��������� � ������� ����������
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvSearch));
  AddItem(TnscTreeViewTabCell.Make(tvLawNews));
  AddItem(TnscTreeViewTabCell.Make(tvLastOpenDocs));
 end;//with aTable.AddItem do
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvReferences));
  AddItem(TnscTreeViewTabCell.Make(tvLawSupport));
 end;//with aTable.AddItem do
end;//KeyboardNavigation

procedure Ten_SimpleMainMenu.lblCompNameClick(Sender: TObject);
begin
 Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Common_ComplectInfo);
end;//lblCompNameClick

procedure Ten_SimpleMainMenu.LoadLastOpenDocs;
begin
 tvLastOpenDocs.TreeStruct := TnsLastOpenDocTree.Make(afw.Settings.LoadInteger(
  pi_RecentlyOpenDocumentsCount, dv_RecentlyOpenDocumentsCount),
  False,
  True);
end;//LoadLastOpenDocs

end.