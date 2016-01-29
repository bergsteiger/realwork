unit TTreeNodeForTestsWordsPack;

interface

uses
 l3IntfUses
 , ComCtrls
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , FolderSupport
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TTTreeNodeForTestsWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TTTreeNodeForTestsWordsPackResNameGetter
 
 TkwPopTreeNodeIsNodeFolder = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:IsNodeFolder
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:IsNodeFolder >>> l_Boolean
[code]  }
  function IsNodeFolder(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): Boolean;
   {* ���������� ����� ������� pop:TreeNode:IsNodeFolder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeIsNodeFolder
 
end.
