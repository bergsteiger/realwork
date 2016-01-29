unit vcmOVCCommands;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmOVCCommands.pas"
// Начат: 20.08.2009 20:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::Containers::vcmOVCCommands
//
// Работа с командами OVC
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmCommandIDsListPrim,
  vcmCommandIDsList
  ;

function vcmCommandID(aItemID: Integer;
  aIsModule: Boolean;
  aOperationID: Integer): Word;
function vcmCommandInfo(anID: Word): TvcmCommandInfo;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
const
  { Constants }
 c_Offset = 512;

// unit methods

function vcmCommandID(aItemID: Integer;
  aIsModule: Boolean;
  aOperationID: Integer): Word;
//#UC START# *4A8D78F801FC_4A8D789702FA_var*
//#UC END# *4A8D78F801FC_4A8D789702FA_var*
var
 l_C : TvcmCommandInfo;
 l_L : TvcmCommandIDsList;
 l_Index : Integer;
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
{$IfEnd} //not NoVCM

end.