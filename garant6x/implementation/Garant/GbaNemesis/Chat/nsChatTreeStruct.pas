unit nsChatTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/nsChatTreeStruct.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::TnsChatTreeStruct
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  nsUserTreeStruct,
  ChatTypes,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FindDataType_ = TbsUserID;
 TnsChatTreeStruct = class(TnsUserTreeStruct)
 protected
 // overridden protected methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 public
 // public methods
   class function Make(ForAdd: Boolean): Il3SimpleTree;
 end;//TnsChatTreeStruct
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsInterfaces,
  DataAdapter,
  SecurityUnit,
  SysUtils,
  nsUserFlagsFilter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsChatTreeStruct

class function TnsChatTreeStruct.Make(ForAdd: Boolean): Il3SimpleTree;
//#UC START# *4A680DCB0084_4A680DA6013C_var*
var
 l_UserTree: TnsChatTreeStruct;
 l_Current: Integer;
 l_FilterableTree: Il3FilterableTree;
 l_TreeFilters: InsUserFlagsFilters;
 l_Flag: LongWord;
//#UC END# *4A680DCB0084_4A680DA6013C_var*
begin
//#UC START# *4A680DCB0084_4A680DA6013C_impl*
 Result := nil;
 if ForAdd then
  l_Flag := 0
 else
  l_Flag := UFF_CHAT_CONTACT_LIST_USERS;
 if Assigned(DefDataAdapter) then
 begin
  l_UserTree := Create(defDataAdapter.GetChatUsersTree, False);
  try
   Result := l_UserTree;
   if Supports(Result, Il3FilterableTree, l_FilterableTree) and
      Supports(l_FilterableTree.CloneFilters, InsUserFlagsFilters, l_TreeFilters) then
   begin
    Result := l_FilterableTree.MakeFiltered(l_TreeFilters.
                                            SetPermanentUserFlag(TnsUserFlagsFilter.Make(
                                                        UFF_USER_NOT_SYSTEM or UFF_USER_NOT_CURRENT or l_Flag
                                                        )
                                            ),
                                            nil,
                                            l_Current,
                                            True);
   end;
  finally
   FreeAndNil(l_UserTree);
  end;
 end;
//#UC END# *4A680DCB0084_4A680DA6013C_impl*
end;//TnsChatTreeStruct.Make

function TnsChatTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4A680DA6013C_var*
//#UC END# *48FF64F60078_4A680DA6013C_var*
begin
//#UC START# *48FF64F60078_4A680DA6013C_impl*
 Result := defDataAdapter.GetChatUsersTree;
//#UC END# *48FF64F60078_4A680DA6013C_impl*
end;//TnsChatTreeStruct.ReAqurieUnfilteredRoot

{$IfEnd} //not Admin AND not Monitorings

end.