unit nsUserNodes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/nsUserNodes.pas"
// Начат: 2004/02/12 13:28:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Администратор::Admin::Admin::Users::nsUserNodes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  l3TreeInterfaces
  ;

function GetUserID(const aNode: Il3SimpleNode): Integer;
function GetUserByID(aUserID: Integer;
  const aTreeStruct: Il3SimpleTree): Il3SimpleNode;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  SysUtils,
  SecurityUnit,
  nsConst,
  l3Nodes
  ;

// unit methods

function GetUserID(const aNode: Il3SimpleNode): Integer;
//#UC START# *4AD5ACC50294_49E5BB5F02B7_var*
var
 l_Node: IProfileNode;
//#UC END# *4AD5ACC50294_49E5BB5F02B7_var*
begin
//#UC START# *4AD5ACC50294_49E5BB5F02B7_impl*
 if Supports(aNode, IProfileNode, l_Node) then
  Result := l_Node.GetUid
 else
  Result := cBadUID;
//#UC END# *4AD5ACC50294_49E5BB5F02B7_impl*
end;//GetUserID

function GetUserByID(aUserID: Integer;
  const aTreeStruct: Il3SimpleTree): Il3SimpleNode;
//#UC START# *4B1CD6EE038B_49E5BB5F02B7_var*

 function FindNode(const aIntf : Il3SimpleNode) : Boolean;
 begin
  Result := GetUserID(aIntf) = aUserID;
 end;

//#UC END# *4B1CD6EE038B_49E5BB5F02B7_var*
begin
//#UC START# *4B1CD6EE038B_49E5BB5F02B7_impl*
 Result := aTreeStruct.SimpleIterateF(l3L2SNA(@FindNode), imCheckResult);
//#UC END# *4B1CD6EE038B_49E5BB5F02B7_impl*
end;//GetUserByID
{$IfEnd} //Admin

end.