unit nsUserNodes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\nsUserNodes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsUserNodes" MUID: (49E5BB5F02B7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3TreeInterfaces
;

function GetUserID(const aNode: Il3SimpleNode): Integer;
function GetUserByID(aUserID: Integer;
 const aTreeStruct: Il3SimpleTree): Il3SimpleNode;
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , SecurityUnit
 , nsConst
 , l3Nodes
 //#UC START# *49E5BB5F02B7impl_uses*
 //#UC END# *49E5BB5F02B7impl_uses*
;

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
{$IfEnd} // Defined(Admin)

end.
