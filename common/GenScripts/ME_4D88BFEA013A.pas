unit evCommentDecorator;

interface

uses
 l3IntfUses
 , evCommentParaDecorator
 , l3Variant
;

type
 TevWhatOpen = (
  ev_wnoNone
  , ev_wnoRow
  , ev_wnoTable
 );//TevWhatOpen
 
 TevPrevClosed = (
  ev_pcNone
  , ev_pcTable
  , ev_pcAACTable
 );//TevPrevClosed
 
 TevCommentDecorator = class(TevCommentParaDecorator)
  {* ��������� �������� ������ ��� ���. }
  procedure StartAACTable;
   {* ������ �������-�������. }
  procedure AddHeaderRow;
   {* ������ ������� � ���������. }
  procedure AddSpaceRow;
   {* ��������� ������ ����� ������. }
  procedure StartAACRow;
  procedure StartAACRow4Table;
   {* �������� ������ ��� ������ (��� ������� �������) }
  procedure StartAACStyle;
   {* �������� ������� � ��������������� ������. }
  procedure EndRow;
   {* ��������� ������ ���������� �������. }
  procedure EndRowAndTable;
   {* ��������� ������ � �������. }
  procedure CheckWhatOpen(aForTable: Boolean);
   {* �������� ����������� ������� ��� ������ ������� � ���������, ��� ��� ���� �������. }
 end;//TevCommentDecorator
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evDef
 , evdFrame_Const
 , l3Memory
 , Block_Const
 , Document_Const
 , evdStylesRes
 , BitmapPara_Const
 , Table_Const
 , TextPara_Const
 , evParaTools
 , k2Tags
 , evdStyles
 , TableCell_Const
 , ContentsElement_Const
;

end.
