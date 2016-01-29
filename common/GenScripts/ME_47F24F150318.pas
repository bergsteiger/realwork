unit evSubImplementation;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , l3Variant
 , evdTypes
 , l3Interfaces
 , k2ProcTagTool
 , nevBase
;

type
 TevDocumentImplementation = class
  {* Реализация интерфейса IevDocument. }
 end;//TevDocumentImplementation
 
 TevDocumentPartImplementation = class(Tl3CacheableBase, IevSub, IevDocumentPart, IevDocumentPoint)
  procedure SetTo(EntryPoint: Tl3Variant);
   {* устанавливает метку в EntryPoint. }
  function Select(const Selection: InevSelection): Boolean; overload;
   {* перемещает Selection на данную метку. }
  function Delete(const aView: InevView): Boolean;
   {* удаляет метку. }
  function IsInIndex: Boolean;
  function Exists: Boolean;
   {* проверяет существует ли такая метка. }
  function SubInstance: Tl3Variant;
   {* собственно Sub. }
  function SubPlace: TevSubPlace;
   {* попадает ли мека в оглавление. }
  function Name: Tl3WString;
   {* имя метки. }
  function ID: Integer;
   {* идентификатор метки. }
  function LayerID: Integer;
   {* идентификатор слоя на котором находится метка. }
  function Flags: Integer;
   {* набор битовых флагов метки. }
  function Cursor: Tl3Tag;
   {* курсор на метку. }
  function SubList: InevSubList;
   {* список меток. }
  function Next: IevSub;
   {* следующая метка параграфа. }
  function LeafPara: Tl3Variant;
   {* параграф нижнего уровня, на который указывает метка. }
  function Para: Tl3Variant;
   {* параграф, на который указывает метка. }
  function Document: IevDocument;
  function Merge: Boolean;
   {* объединяет блок со следующим. }
  function ExternalHandle: Integer;
   {* внешний идентификатор блока (для сохранения в RTF). }
  function ObjType: Integer;
   {* тип внешнего объекта ObjType. }
  function ParaCount: Integer;
   {* число параграфов в блоке. }
  function ParentDocumentPart: IevDocumentPart;
   {* родительский блок. }
  function ContentsRec: TevContentsRec;
   {* уровень блока в оглавлении. }
  function Select(const Selection: InevSelection): Boolean; overload;
   {* перемещает Selection на данную метку. }
  function Obj: PInevObject;
  function IsVisibleOnSubPanel: Boolean;
  function GetViewKind: TevBlockViewKind;
 end;//TevDocumentPartImplementation
 
 TevSubImplementation = class(Tk2ProcTagTool)
  function DoGetFlags(aTag: Tl3Variant;
   aFlag: LongInt): LongInt;
 end;//TevSubImplementation
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

end.
