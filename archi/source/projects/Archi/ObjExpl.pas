unit ObjExpl;

{ObjectExplorerWin Support}
{ $Id: ObjExpl.pas,v 1.6 2010/02/03 08:29:44 voba Exp $ }

interface

Uses
 l3Nodes{,
 l3Trees};

Const
 {ExplorerNodeType}
 //enWinAddr   = 0;
 enOpenDocID = 1;
 enDocID     = 2;
 //enDocSetID  = 3;
 enActUser   = 4;
 enUser      = 5;
 enMail      = 6;

 {enMailNone  = 6;
 enMailSrch  = 7;
 enMailDoc   = 8;
 enMailDocLst= 9;}

 enUserGroup = 10;

 enDirDocSet = 11;
 enDirDoc    = 12;
 enDirUser   = 13;
 enDirMail   = 14;

 enOpenDocSet   = 15;
 enSavedDocSet  = 16;

Type
  TDocSetsListNode      = class(Tl3UsualNode{Tl3DataListContainerNode});
  TSavedDocSetsListNode = class(Tl3IListContainerNode);
  TDocSetNode           = class(Tl3UsualNode{Tl3DataListContainerNode});

  TDocsListNode         = class(Tl3UsualNode{Tl3DataListContainerNode});
  TDocumentNode         = class(Tl3UsualNode{Tl3DataListContainerNode});
  TMRUDocListNode       = class(Tl3DataListContainerNode);

  TUsersGroupListNode   = class(Tl3UsualNode);
  TUsersListNode        = class(Tl3DataListContainerNode);
  TMailListNode         = class(Tl3IListContainerNode {Tl3DataListContainerNode});

implementation
end.
