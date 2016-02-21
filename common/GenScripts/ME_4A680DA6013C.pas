unit nsChatTreeStruct;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsChatTreeStruct.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsUserTreeStruct
 , ChatTypes
 , l3TreeInterfaces
 , DynamicTreeUnit
;

type
 _FindDataType_ = TbsUserID;
 TnsChatTreeStruct = class(TnsUserTreeStruct)
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
  public
   class function Make(ForAdd: Boolean): Il3SimpleTree;
 end;//TnsChatTreeStruct
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsInterfaces
 , DataAdapter
 , SecurityUnit
 , SysUtils
 , nsUserFlagsFilter
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
