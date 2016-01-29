unit nscTreeView;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3IID
 , eeTreeView
 , vcmExternalInterfaces
 , l3InternalInterfaces
 , OfficeLike_Text_Controls
 , OfficeLike_Tree_Controls
 , l3Interfaces
 , Classes
;

type
 InscTreeState = interface
 end;//InscTreeState
 
 TnscTreeViewState = class(Tl3CacheableBase, InscTreeState)
  procedure Create(const aAggregate: IUnknown;
   aWrap: Boolean);
  procedure Make(const aAggregate: IUnknown;
   aWrap: Boolean);
  function Aggregate: IUnknown;
  function Wrap: Boolean;
 end;//TnscTreeViewState
 
 TnscTreeViewPrim = class(TeeTreeView, IvcmOperationsProvider, Il3CommandPublisherInfo, Edit, Tree)
  function DoIsCommandPublished(Cmd: Tl3OperationCode): Boolean;
  function IsEmpty: Boolean;
  procedure DoProvideOps(const aPublisher: IvcmOperationsPublisher);
  function MakePath(const aSetting: AnsiString): AnsiString;
  procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
   {* предоставить список доступных операций. }
  function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
  procedure Copy;
   {* Копировать }
  procedure Paste;
   {* Вставка }
  procedure SelectAll;
   {* Выделить всё }
  procedure Deselect;
   {* Снять выделение }
  procedure ExpandAll;
   {* Развернуть все }
  procedure CollapseAll;
   {* Свернуть все }
  procedure Wrap;
   {* Перенос по словам }
 end;//TnscTreeViewPrim
 
 TnscTreeView = class(TnscTreeViewPrim)
 end;//TnscTreeView
 
implementation

uses
 l3ImplUses
 , nscTreeViewRes
 , OvcConst
 , vcmDefaultOperations
 , afwConsts
 , l3Base
 , ActiveX
 , afwFacade
 , SysUtils
 , TtfwClassRef_Proxy
;

end.
