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
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TTTreeNodeForTestsWordsPackResNameGetter
 
 TkwPopTreeNodeIsNodeFolder = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:IsNodeFolder
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:IsNodeFolder >>> l_Boolean
[code]  }
  function IsNodeFolder(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): Boolean;
   {* Реализация слова скрипта pop:TreeNode:IsNodeFolder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeIsNodeFolder
 
end.
