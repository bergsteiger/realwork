unit nscInterfaces;

// ���������� : ���������� ����������� ������� "�������";                       }
// �����      : ������� �.�;                                                    }
// �����      : 16.02.2005 14.44;                                               }
// ������     : nscInterfaces;                                                  }
// ��������   : ������ ������ ����� "fcSynchroView";                            }
// ������     : $Id: nscInterfaces.pas,v 1.43 2016/03/29 09:16:01 kostitsin Exp $                                                            }

(*-------------------------------------------------------------------------------
  $Log: nscInterfaces.pas,v $
  Revision 1.43  2016/03/29 09:16:01  kostitsin
  {requestlink: 620672440 }

  Revision 1.42  2012/10/26 14:57:56  lulin
  {RequestLink:406489593}

  Revision 1.41  2010/03/10 19:41:58  lulin
  {RequestLink:196445017}.

  Revision 1.40  2010/03/10 17:50:39  lulin
  {RequestLink:196445017}.

  Revision 1.39  2010/03/10 16:46:28  lulin
  {RequestLink:196445017}.

  Revision 1.38  2010/03/10 13:22:16  lulin
  {RequestLink:196445017}.
  - ������ ����.

  Revision 1.37  2009/11/17 10:34:39  oman
  - fix: {RequestLink:171967027}

  Revision 1.36  2009/10/13 15:11:16  lulin
  - ��� ����������� ��������� ������ ����������� ������.

  Revision 1.35  2009/10/12 16:35:05  lulin
  - ���������� �� ����������� [$166428831].

  Revision 1.34  2009/10/12 11:27:13  lulin
  - �������� ����� ������� CVS.

  Revision 1.34  2009/10/08 09:50:53  lulin
  - ���������� ��������� � ����������� ��������� ��� �����.

  Revision 1.33  2009/10/06 13:19:01  lulin
  - bug fix: �� ����������.

  Revision 1.32  2009/10/06 13:14:05  lulin
  {RequestLink:162596818}. ������� ���������� ������.

  Revision 1.31  2009/04/13 12:54:38  oman
  - new: ����������� ������ - [$143392959]

  Revision 1.30  2009/01/28 11:14:12  lulin
  - <K>: 133138664. �26.

  Revision 1.29  2009/01/12 17:38:11  lulin
  - <K>: 133138664. � 24.

  Revision 1.28  2008/10/29 12:04:23  lulin
  - <K>: 121166314.

  Revision 1.27  2008/08/06 16:57:06  mmorozov
  - bugfix: �������� ������ ������� ������ ����� ��� ����� (K<104435077>);

  Revision 1.26  2008/07/01 12:46:08  oman
  - new: ��� ������� �� ��������� ����������������� ������ ����������� (�-96474339)

  Revision 1.25  2008/06/26 11:18:35  oman
  - fix: ������� � ��������������� ����� (cq11768)

  Revision 1.24  2008/05/15 12:39:55  oman
  - fix: �������� ����� �������� ��� �������� � ���������� (cq28402)

  Revision 1.23  2008/03/19 06:28:30  mmorozov
  - new: ������������� ����������� ������ ��� �������������� (� ������ CQ: OIT5-28528);

  Revision 1.22  2007/11/02 12:23:22  mmorozov
  - new: ��� ����������� ����� ��������� ������� �������� ������ ��������� �� ���������� ����� ������ � ������� �� �������� ���������, � ���������� ������ (� ������ ������ ��� CQ: OIT5-27189) + ������������� �����������;

  Revision 1.21  2007/10/30 12:36:29  mmorozov
  � ������ ������ ��� CQ: OIT5-27189:
  - TvtHideField ������ ��������� � ������� �����;
  - ���������� TvtHideField � ��������� ����� � ����������;
  - ���������� TvtHideField � ������� �������� ������;

  Revision 1.20  2007/09/17 10:42:55  mmorozov
  New:
  - ������� ��������� ��� ��������� ����������� � ����������\������������� ���������� ���� �� ����� ����������� �������� ������ ����� �������� (������ ������ IvcmForm);
  - ������ ����� ������ �������� ���������, ��������� ������������ �������� ����� ���������� ��������� ����� ����������, � �� ������ ��� ��� ���� ������;
  - ���������� �� �������� � ������ �����, ��� ��������� ����� ������������;
  - ������� ���;

  � ������ ������ CQ: OIT5-26623;

  Revision 1.19  2007/08/20 09:06:07  mmorozov
  - new: ����������� �� ��������� �������� ������� (CQ: OIT5-26352);

  Revision 1.18  2007/08/16 06:58:50  mmorozov
  - new behaviour: ����� ������� ���������� ������ ����� ��� ���������� ��������� ���������� (CQ: OIT5-26366);

  Revision 1.17  2007/08/03 09:39:49  oman
  - new: ��������� � ���������� �������� �� ���������� (cq25326)

  Revision 1.16  2007/07/26 09:38:38  mmorozov
  - new: ����������� �������� �� ������� ������������ ������� (� ������ CQ: OIT5-25852);

  Revision 1.15  2007/03/30 11:02:53  oman
  Cleanup (ContextParams)

  Revision 1.14  2007/03/28 13:12:09  mmorozov
  - new: ������� ������� �������� ������;

  Revision 1.13  2007/03/28 11:39:38  mmorozov
  - ���������� ������� �������� ������ � ������ �����;

  Revision 1.12  2007/03/28 11:02:54  mmorozov
  - "������� �������� ������" ���������� � ���������� ���������� ����������� ������� �������;

  Revision 1.11  2007/03/27 13:59:09  mmorozov
  - cleanup;

  Revision 1.10  2007/03/27 07:41:24  mmorozov
  - ������� ������ � ����� ��������� (������);

  Revision 1.9  2007/03/23 12:56:11  mmorozov
  - � ������ ������ ��� �������������� ������ �����, ������������� ��������� ��� ���������� ��� ��������� ������;

-------------------------------------------------------------------------------*)

interface

uses
  Controls,
  Classes,
  Windows,

  l3Interfaces,

  afwInterfaces

  {$IfNDef NoVCM}
  ,
  vcmExternalInterfaces
  {$EndIf  NoVCM}
  ;

type
  {----------------------------------------------------------------------------}
  { ArrangeGrid - ����� ���������.                                             }
  {----------------------------------------------------------------------------}
  IagRow = interface;
  IagColumn = interface;

  IagBaseCell = interface(IUnknown)
   {* ������ � �����������. }
    ['{71868E30-C9ED-43C9-9ECD-63B1FE8E14FB}']
    // property methods
      function pm_GetMinWidth: Integer;
      procedure pm_SetMinWidth(const aValue: Integer);
        {* - ����������� ������, �� ������� ����� ��������� ���������. }
      function pm_GetFullWidth: Integer;
        {* - ������, ��� ������� ��������� ����� ������� ���������. }
      function pm_GetMinHeight: Integer;
      procedure pm_SetMinHeight(const aValue: Integer);
        {* - ����������� ������, �� ������� ����� ��������� ���������. }
      function pm_GetFullHeight: Integer;
        {* - ������, ��� ������� ��������� ����� ������� ���������. }
      function pm_GetStartColumn: IagColumn;
      procedure pm_SetStartColumn(const Value: IagColumn);
        {-}
      function pm_GetEndColumn: IagColumn;
      procedure pm_SetEndColumn(const Value: IagColumn);
        {-}
      function pm_GetStartRow: IagRow;
      procedure pm_SetStartRow(const Value: IagRow);
        {-}
      function pm_GetEndRow: IagRow;
      procedure pm_SetEndRow(const Value: IagRow);
        {-}
    // public methods
      procedure ArrangeContent;
        {* - ���������� ���������� ������. }
      procedure Constraints(const aMinWidth   : Integer;
                            const aFullWidth  : Integer;
                            const aMinHeight  : Integer;
                            const aFullHeight : Integer);
        {* - ����������� �� ������ ������. }
      procedure Attached;
        {* - ���������� ��� ������������� ������ � �������. }
      procedure RecalcConstraints;
        {* - ����������� ����������� ������. }
      function TwoStageBuild: Boolean;
        {-}
    // properties
      property MinWidth: Integer
        read pm_GetMinWidth
        write pm_SetMinWidth;
        {* - ����������� ������, �� ������� ����� ��������� ���������. }
      property FullWidth: Integer
        read pm_GetFullWidth;
        {* - ������, ��� ������� ��������� ����� ������� ���������. }
      property MinHeight: Integer
        read pm_GetMinHeight
        write pm_SetMinHeight;
        {* - ����������� ������, �� ������� ����� ��������� ���������. }
      property FullHeight: Integer
        read pm_GetFullHeight;
        {* - ������, ��� ������� ��������� ����� ������� ���������. }
      property StartColumn: IagColumn
        read pm_GetStartColumn
        write pm_SetStartColumn;
        {-}
      property EndColumn: IagColumn
        read pm_GetEndColumn
        write pm_SetEndColumn;
        {-}
      property StartRow: IagRow
        read pm_GetStartRow
        write pm_SetStartRow;
        {-}
      property EndRow: IagRow
        read pm_GetEndRow
        write pm_SetEndRow;
        {-}
  end;//IagBaseCell

  IagControlCell = interface(IagBaseCell)
  {* ������ ���������� ���������. }
   ['{7E9F2C03-6B50-4CBF-B05B-D10C222EE60B}']
   // property methods
     function pm_GetControl: TControl;
     procedure pm_SetControl(const aValue: TControl);
       {* - ��������� ������. }
   // properties
     property Control: TControl
       read pm_GetControl
       write pm_SetControl;
       {* - ��������� ������. }
  end;//IagControlCell

  IagCellsOwner = interface(IUnknown)
   {* �������� �����. }
    ['{08D9593E-872C-4EEB-983B-FAEBB7825A87}']
    // property methods
      function pm_GetCell(const aIndex: Integer): IagBaseCell;
      procedure pm_SetCell(const aIndex : Integer;
                           const Value  : IagBaseCell);
        {-}
      function pm_GetCellCount: Integer;
        {-}
    // public methods
      procedure AddCell(const aCell: IagBaseCell);
        {-}
      procedure DeleteCell(const aIndex: Integer);
        {-}
      procedure CellChanged;
        {-}
      procedure RecalcCells;
        {* - ����������� ������� �����. }
      procedure ResetConstraints;
        {-}
      procedure Delete;
        {-}
    // properties
      property Cell[const aIndex: Integer]: IagBaseCell
        read pm_GetCell
        write pm_SetCell;
        {-}
      property CellCount: Integer
        read pm_GetCellCount;
        {-}
  end;//IagCellsOwner

  IagRow = interface(IagCellsOwner)
   {* ������ �����������. }
    ['{7E071A62-DBAF-495E-9C98-BAA2C406F104}']
    // property methods
      function pm_GetHeight: Integer;
        {-}
      function pm_GetTop: Integer;
        {-}
      function pm_GetBottom: Integer;
        {-}
      function pm_GetMinHeight: Integer;
      procedure pm_SetMinHeight(const aValue: Integer);
        {-}
      function pm_GetFullHeight: Integer;
        {-}
      function pm_GetFixedHeight: Integer;
      procedure pm_SetFixedHeight(const aValue: Integer);
        {* - ������ ����� ������ �������������� �������. }
    // public methods
      procedure SetBounds(const aTop, aBottom: Integer);
        {-}
      function TwoStageBuild: Boolean;
        {-}
    // properties
      property Top: Integer
        read pm_GetTop;
        {-}
      property Bottom: Integer
        read pm_GetBottom;
        {-}
      property MinHeight: Integer
        read pm_GetMinHeight
        write pm_SetMinHeight;
        {-}
      property FullHeight: Integer
        read pm_GetFullHeight;
        {-}
      property FixedHeight: Integer
        read pm_GetFixedHeight
        write pm_SetFixedHeight;
        {* - ������ ����� ������ �������������� �������. }
      property Height: Integer
        read pm_GetHeight;
        {-}
  end;//IagRow

  IagColumn = interface(IagCellsOwner)
   {* ������� �����������. }
    ['{36ECB62C-4D85-491D-A97C-1EC677AC03B9}']
    // property methods
      function pm_GetLeft: Integer;
        {-}
      function pm_GetRight: Integer;
        {-}
      function pm_GetMinWidth: Integer;
      procedure pm_SetMinWidth(const aValue: Integer);
        {-}
      function pm_GetFullWidth: Integer;
        {-}
      function pm_GetWidth: Integer;
        {* - �������� ������ �������. }
      function pm_GetFixedWidth: Integer;
      procedure pm_SetFixedWidth(const aValue: Integer);
        {* - ������ ����� ������ �������������� �������. }
    // public methods
      procedure SetBounds(const aLeft, aRight: Integer);
        {-}
    // properties
      property Left: Integer
        read pm_GetLeft;
        {-}
      property Right: Integer
        read pm_GetRight;
        {-}
      property MinWidth: Integer
        read pm_GetMinWidth
        write pm_SetMinWidth;
        {* - ����������� ������ ��� ����������� ����������� �������. }
      property FullWidth: Integer
        read pm_GetFullWidth;
        {* - ������ ��� ������� ������������ �� ����������. }
      property Width: Integer
        read pm_GetWidth;
        {* - �������� ������ �������. }
      property FixedWidth: Integer
        read pm_GetFixedWidth
        write pm_SetFixedWidth;
        {* - ������ ����� ������ �������������� �������. }
  end;//IagColumn

  InscArrangeGrid = interface(IUnknown)
   {* ����� �����������. }
    ['{80C2D058-A990-4CBA-8576-AAC95BF4C47D}']
    // property methods
      function pm_GetIsEmpty: Boolean;
        {* - �������� �� ������� ������. }
      function pm_GetColumn(const aIndex: Integer): IagColumn;
        {-}
      function pm_GetRow(const aIndex: Integer): IagRow;
        {-}
      function pm_GetHeight: Integer;
        {* - ������ �������. }
      function pm_GetWidth: Integer;
        {* - ������ �������. }
      function pm_GetRowCount: Integer;
        {-}
      function pm_GetColumnCount: Integer;
        {-}
      function pm_GetCell(const aRow : Integer;
                          const aCol : Integer): IagBaseCell;
      procedure pm_SetCell(const aRow  : Integer;
                           const aCol  : Integer;
                           const Value : IagBaseCell);
        {-}
      function pm_GetMinHeight: Integer;
        {-}
      function pm_GetMinWidth: Integer;
        {-}
      function pm_GetFullWidth: Integer;
        {* - ������ ��� ������� ���������� ������ ������������ ���������. }
      function pm_GetFullHeight: Integer;
        {* - ������ ��� ������� ���������� ������ ������������ ���������. }
      function pm_GetLeft: Integer;
        {-}
      function pm_GetTop: Integer;
        {-}
      function pm_GetLastColumn: IagColumn;
        {-}
      function pm_GetLastRow: IagRow;
        {-}
    // property of events
      function pm_GetOnSizeChanged: TNotifyEvent;
      procedure pm_SetOnSizeChanged(const aValue: TNotifyEvent);
        {* - ����������� ������ �������. }
    // public methods
      function AddRow: IagRow;
        {* - �������� ������. }
      function AddColumn: IagColumn;
        {* - �������� �������. }
      procedure SetBounds(const aLeft   : Integer;
                          const aTop    : Integer;
                          const aWidth  : Integer;
                          const aHeight : Integer);
        {-}
      procedure Recalc;
        {* - ����������� ������� �����. }
      procedure MergeCells(const aRow  : Integer;
                           const aFrom : Integer;
                           const aTo   : Integer;
                           const aCell : IagBaseCell);
        {* - ���������� ������. }
      procedure BeginUpdate;
        {* - ������ ��������� ����������, � ���� ������ ������������ ������ ��
             �����. }
      procedure EndUpdate;
        {* - ��������� ��������� ����������, ����� ����������� �����, ���� ��
             ����� ���� ������� �� ������������. }
      function TwoStageBuild: Boolean;
        {-}
    // properties
      property Left: Integer
        read pm_GetLeft;
        {-}
      property Top: Integer
        read pm_GetTop;
        {-}
      property Height: Integer
        read pm_GetHeight;
        {* - ������ �������. }
      property Width: Integer
        read pm_GetWidth;
        {* - ������ �������. }
      property MinHeight: Integer
        read pm_GetMinHeight;
        {-}
      property MinWidth: Integer
        read pm_GetMinWidth;
        {-}
      property FullWidth: Integer
        read pm_GetFullWidth;
        {* - ������ ��� ������� ���������� ������ ������������ ���������. }
      property FullHeight: Integer
        read pm_GetFullHeight;
        {* - ������ ��� ������� ���������� ������ ������������ ���������. }
      property Cell[const aRow: Integer;
                    const aCol: Integer]: IagBaseCell
        read pm_GetCell
        write pm_SetCell;
        {-}
      property Row[const aIndex: Integer]: IagRow
        read pm_GetRow;
        {-}
      property RowCount: Integer
        read pm_GetRowCount;
        {-}
      property Column[const aIndex: Integer]: IagColumn
        read pm_GetColumn;
        {-}
      property ColumnCount: Integer
        read pm_GetColumnCount;
        {-}
      property LastColumn: IagColumn
        read pm_GetLastColumn;
        {-}
      property LastRow: IagRow
        read pm_GetLastRow;
        {-}
      property IsEmpty: Boolean
        read pm_GetIsEmpty;
        {* - �������� �� ������� ������. }
    // events
      property OnSizeChanged: TNotifyEvent
        read pm_GetOnSizeChanged
        write pm_SetOnSizeChanged;
        {* - ����������� ������ �������. }
  end;//InscArrangeGrid
  {----------------------------------------------------------------------------}
  { TabTable - ������� �������� ������.                                        }
  {----------------------------------------------------------------------------}

  TnscTabTableKey = (
  {* ������� ������� �� �������. }
    ns_kLeft,
    ns_kRight,
    ns_kUp,
    ns_kDown,
    ns_kNone
  );//TnscTabTableKey

  TnscOnProcessKey = procedure (const aKey : TnscTabTableKey) of Object;
   {* ������� ������� �� ������ � ����������, ���� False, �� ���������� �� �����
      ������������ �������. }

  InscTabTableCell = interface(IUnknown)
   {* ������� ������� � ���������. }
    ['{CCF8B348-7903-4874-9498-59D4A4C25AC5}']
    // private methods
      function pm_GetBounds: TRect;
        {* - ������� ������ � ����������� ������. }
      function pm_GetCurrent: Integer;
      procedure pm_SetCurrent(const aValue : Integer);
        {-}
      function pm_GetCount : Integer;
        {-}
      function pm_GetOnProcessKey : TnscOnProcessKey;
        {-}
      procedure pm_SetOnProcessKey(const aValue : TnscOnProcessKey);
        {-}
      function pm_GetControl: TWinControl;
        {-}
    // public methods
      procedure SetFocus(const aFromNext: Boolean = True);
        {* - ���������� �����, ������� ��� � ���������� ��������. ��� ����� ���
             ��������� �� ������\��������� ������� ��������. }
    // public properties
      property Current : Integer
        read pm_GetCurrent
        write pm_SetCurrent;
        {-}
      property Count : Integer
        read pm_GetCount;
        {-}
      property Bounds: TRect
        read pm_GetBounds;
        {* - ������� ������ � ����������� ������. }
    // public events
      property OnProcessKey : TnscOnProcessKey
        read pm_GetOnProcessKey
        write pm_SetOnProcessKey;
        {* - ���������� ������� ������� �� ������� � ����������. }
      property Control : TWinControl
        read pm_GetControl;
        {-}
  end;//InscTabTableCell

  InscTabTableColumn = interface(IUnknown)
   {* ������� ������� � ���������. }
    ['{516A139E-15C7-465E-AC19-D9AA8596B555}']
    // public methods
      procedure AddItem(const aItem: InscTabTableCell);
        {* - ��������� ������� � ������. }
  end;//InscTabTableColumn

  InscTabTable = interface(IUnknown)
   {* ������� � ��������� ��� ������������ ������ ����� ��������� �
      ����������. }
    ['{33052648-30B9-4718-9F30-99AE85313C61}']
    // property methods
      function pm_GetColumnCount: Integer;
        {-}
      function pm_GetColumn(const aIndex: Integer): InscTabTableColumn;
        {-}
    // public methods
      function AddColumn : InscTabTableColumn;
        {* - ��������� ����� �������. }
      procedure Clear;
        {-}
    // properties
      property ColumnCount: Integer
        read pm_GetColumnCount;
        {-}
      property Column[const aIndex: Integer]: InscTabTableColumn
        read pm_GetColumn;
        {-}
  end;//InscTabTable

implementation

end.