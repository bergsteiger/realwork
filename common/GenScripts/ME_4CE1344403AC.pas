unit ClipboardOperations.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
;

type
 _ClipboardOperations_ = class
  {* ������� ��� ��������� ������ � ������� ������ (� ��� �������� ����� ������). }
  procedure CopyToClipboard(aText: TevCustomEditorWindow);
   {* ����������� ��������� � ����� ������ }
  procedure PasteFromClipboard(aText: TevCustomEditorWindow);
   {* �������� �� ������ ������ }
  procedure ClearClipboard;
   {* ������� ������ ������ (����� �� ���� ������ ������). }
  procedure CopyAndPaste2DocumentBottom(aText: TevCustomEditorWindow);
   {* ����������� ���������� � ��������� � ����� ���������. }
 end;//_ClipboardOperations_
 
implementation

uses
 l3ImplUses
 , l3Base
 , evOp
 , l3InternalInterfaces
;

end.
