unit evTunedEditor;

interface

uses
 l3IntfUses
 , evEditorWithOperations
 , Messages
;

type
 TevTunedEditor = class(TevEditorWithOperations)
  {* ������������� ����� ��� ���������� ������������ ��������� (�� ��� published-�������). }
  procedure WMKeyDown(var Msg: TWMKeyDown);
 end;//TevTunedEditor
 
implementation

uses
 l3ImplUses
 , nevTools
 , k2Tags
 , Windows
 , l3Base
 , evMsgCode
 , evParaTools
 , evOp
 , l3Chars
 , evCursorTools
 , Block_Const
 , Table_Const
 , k2Base
 , evExcept
 , TtfwClassRef_Proxy
;

end.
