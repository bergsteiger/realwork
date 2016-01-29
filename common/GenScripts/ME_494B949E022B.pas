unit eeTreeView;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , ImgList
 , eeInterfaces
 , eeTreeViewExport
 , Messages
;

type
 TeeCurrentChanged = procedure(aSender: TObject;
  aNewCurrent: Integer;
  aOldCurrent: Integer) of object;
  {* ������� ��� ��������� ��������� �������� �������� }
 
 TeeNewCharPressed = procedure(aChar: AnsiChar) of object;
  {* ������� ��� ������� ��������� WMChar }
 
 TeeMakeTreeSource = procedure(out theTree: Il3SimpleTree) of object;
 
 TeeGetItemImage = function(aSender: TObject;
  anIndex: Integer;
  var aImages: TCustomImageList): Integer of object;
  {* ������� ��� ����������� ������ �������� }
 
 TeeActionElement = procedure(aSender: TObject;
  anIndex: Integer) of object;
  {* ������� ��� ��������� "�������� �����" �� �������� }
 
 TeeBeforeExpandNode = function(Sender: TObject;
  const CNode: IeeNode;
  anExpand: Boolean): Boolean of object;
 
 TeeExpandNodeEvent = procedure(Sender: TObject;
  const CNode: IeeNode) of object;
 
 TeeCustomTreeView = class(TeeTreeViewExport)
  {* ��������� ��� ������� ����������� ������ }
 end;//TeeCustomTreeView
 
 TeeTreeView = class(TeeCustomTreeView)
  {* ��������� ��� ������� ����������� ������. ��� ��������� �������������. }
 end;//TeeTreeView
 
implementation

uses
 l3ImplUses
 , Windows
 , l3Const
 , l3Types
 , eeNode
 , TtfwClassRef_Proxy
;

end.
