unit eeSub;

interface

uses
 l3IntfUses
 , eeDocumentTool
 , eeInterfaces
 , eeInterfacesEx
 , evdTypes
 , l3Interfaces
;

type
 TeeSub = class(TeeDocumentTool, IeeSub)
  procedure Create(const aDocument: IeeDocumentEx;
   anID: Integer;
   aLayerID: Integer;
   aFlag: Integer);
  procedure Make(const aDocument: IeeDocumentEx;
   anID: Integer;
   aLayerID: Integer;
   aFlag: Integer);
  function Delete: Boolean;
  function Exists: Boolean;
  function Select: Boolean;
  function IsSame(const aSub: IeeSub): Boolean;
  function SubPlace: TevSubPlace;
  function ID: Integer;
  function LayerID: Integer;
  function Flag: Integer;
  function Flags: Integer;
  function Name: Tl3WString;
  function Next: IeeSub;
   {* следующая метка параграфа в том же слое }
  function LeafPara: IeeLeafPara;
   {* абзац, на который указывает метка, является абзацем нижнего уровня }
  function Para: IeePara;
   {* абзац, на который указывает метка }
 end;//TeeSub
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3String
 , eePara
 , nevTools
;

end.
