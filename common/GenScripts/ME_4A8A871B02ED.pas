unit nscCustomChatMemo;

interface

uses
 l3IntfUses
 , evCustomChatMemo
 , evInternalInterfaces
 , nevTools
 , nevBase
 , l3Variant
 , evCustomMemo
 , evEditorWithOperations
;

type
 TnscCustomChatMemo = class(TevCustomChatMemo, IevF1LikeEditor)
  {* ����-���� ��� ���� F1 }
  function ValidateInsertionPoint: Boolean;
   {* ��������� ����� ������� �� ����������� ����, � ���� ����������, �� �������� ������ }
  function IsParaInF1Doc(aPara: Tl3Variant;
   out theDoc: InevPara): Boolean;
   {* ��������� �������� �� � ���������, ������������� �� F1 }
  function IsInF1Doc(out theDoc: InevPara): Boolean;
   {* ��������� �� � ���������, ������������� �� F1 }
  function CanInsertParaOnMove: Boolean;
   {* ����� �� ��������� ��������� ��� �������� ������� }
  function IsInReadOnlyPara(const aPara: InevPara;
   NeedDeleteIfReadOnly: Boolean): Boolean;
   {* ��������� �� � ���������, � ������� ��������� �������������� }
 end;//TnscCustomChatMemo
 
implementation

uses
 l3ImplUses
 , nscCustomChatMemoTextSource
 , evMsgCode
 , TtfwClassRef_Proxy
 , evOp
 , TextPara_Const
 , k2Tags
 , Document_Const
 , Para_Const
 , evParaTools
;

end.
