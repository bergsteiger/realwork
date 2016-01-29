unit evEditorWithOperations;

interface

uses
 l3IntfUses
 , evCustomEditor
 , vcmExternalInterfaces
 , l3InternalInterfaces
 , l3Interfaces
 , Types
;

type
 TevEditorProvideOperationType = (
  {* Операции которые публикует редактор. }
  potEdit
   {* редактирование текста }
  , potTable
   {* работа с таблицами }
  , potFontStyle
   {* стиль текста }
  , potPrint
   {* операции печати }
  , potText
 );//TevEditorProvideOperationType
 
 TevEditorProvideOperationTypes = set of TevEditorProvideOperationType;
 
 TevEditorWithOperations = class(TevCustomEditor, IvcmOperationsProvider, Il3CommandPublisherInfo)
  function TextGetTarget(const aPt: TPoint;
   out theTarget: IUnknown): Boolean;
  function IsReadOnlyTarget(const aTarget: IUnknown): Boolean;
  function CanCut: Boolean;
  function DefineProvideOperations: TevEditorProvideOperationTypes;
   {* Какие операции публикуются компонентом. }
  procedure opSelectAll(const aParams: IvcmExecuteParamsPrim);
  procedure testSelectAll(const aParams: IvcmTestParamsPrim);
  function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; overload;
  procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
   {* предоставить список доступных операций. }
  function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; overload;
 end;//TevEditorWithOperations
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
