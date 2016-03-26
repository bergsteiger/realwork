unit vcmOVCCommands;
 {* Работа с командами OVC }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmOVCCommands.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmOVCCommands" MUID: (4A8D789702FA)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmCommandIDsListPrim
 , vcmCommandIDsList
;

function vcmCommandID(aItemID: Integer;
 aIsModule: Boolean;
 aOperationID: Integer): Word;
function vcmCommandInfo(anID: Word): TvcmCommandInfo;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

const
 c_Offset = 512;

function vcmCommandID(aItemID: Integer;
 aIsModule: Boolean;
 aOperationID: Integer): Word;
var l_C: TvcmCommandInfo;
var l_L: TvcmCommandIDsList;
var l_Index: Integer;
//#UC START# *4A8D78F801FC_4A8D789702FA_var*
//#UC END# *4A8D78F801FC_4A8D789702FA_var*
begin
//#UC START# *4A8D78F801FC_4A8D789702FA_impl*
 l_C := TvcmCommandInfo_C(aItemID, aIsModule, aOperationID);
 l_L := TvcmCommandIDsList.Instance;
 Assert(l_L <> nil);
 l_Index := l_L.IndexOf(l_C);
 if (l_Index < 0) then
  Result := l_L.Add(l_C)
 else
  Result := l_Index;
 Inc(Result, c_Offset);  
//#UC END# *4A8D78F801FC_4A8D789702FA_impl*
end;//vcmCommandID

function vcmCommandInfo(anID: Word): TvcmCommandInfo;
//#UC START# *4A8D7BCE03E4_4A8D789702FA_var*
//#UC END# *4A8D7BCE03E4_4A8D789702FA_var*
begin
//#UC START# *4A8D7BCE03E4_4A8D789702FA_impl*
 Assert(anID >= c_Offset);
 Dec(anID, c_Offset);
 Result := TvcmCommandIDsList.Instance.Items[anID];
//#UC END# *4A8D7BCE03E4_4A8D789702FA_impl*
end;//vcmCommandInfo
{$IfEnd} // NOT Defined(NoVCM)

end.
