{$IfNDef nsTaggedTreeInfo_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsTaggedTreeInfo.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsTaggedTreeInfo" MUID: (490070F20004)
// Имя типа: "_nsTaggedTreeInfo_"

{$Define nsTaggedTreeInfo_imp}

 _nsTaggedTreeInfo_ = class(_nsTaggedTreeInfo_Parent_, InsTaggedTreeInfo)
  {* Коллеги, это что? }
  private
   f_LogicOperations: TLogicOperationSet;
   f_IsOneOperation: Boolean;
   f_IsDataOneLevel: Boolean;
   f_Tag: Il3CString;
   f_ServerOneLevel: Boolean;
  protected
   procedure Cleanup; override;
    {* Метод очистки полей объекта }
   procedure TagChanged; virtual;
    {* Tag сменился }
   procedure AssignInfo(const aInfo: InsTaggedTreeInfo);
   function IsDataOneLevel: Boolean;
   function pm_GetTag: Il3CString;
   procedure pm_SetTag(const aValue: Il3CString);
   function pm_GetLogicOperations: TLogicOperationSet;
   procedure pm_SetLogicOperations(aValue: TLogicOperationSet);
   function pm_GetServerOneLevel: Boolean;
   procedure pm_SetServerOneLevel(aValue: Boolean);
   function pm_GetIsOneLogicOperation: Boolean;
  protected
   property Tag: Il3CString
    read f_Tag;
   property ServerOneLevel: Boolean
    read f_ServerOneLevel;
 end;//_nsTaggedTreeInfo_

{$Else nsTaggedTreeInfo_imp}

{$IfNDef nsTaggedTreeInfo_imp_impl}

{$Define nsTaggedTreeInfo_imp_impl}

procedure _nsTaggedTreeInfo_.Cleanup;
 {* Метод очистки полей объекта }
//#UC START# *490071BB01F4_490070F20004_var*
//#UC END# *490071BB01F4_490070F20004_var*
begin
//#UC START# *490071BB01F4_490070F20004_impl*
 f_Tag := nil;
 f_IsDataOneLevel := False;
 inherited;
//#UC END# *490071BB01F4_490070F20004_impl*
end;//_nsTaggedTreeInfo_.Cleanup

procedure _nsTaggedTreeInfo_.TagChanged;
 {* Tag сменился }
//#UC START# *490071C401C8_490070F20004_var*
//#UC END# *490071C401C8_490070F20004_var*
begin
//#UC START# *490071C401C8_490070F20004_impl*
 f_IsDataOneLevel :=
  l3Same(f_Tag, AT_REG_NUM) or
  l3Same(f_Tag, AT_REG_IN_MU_NUM) or
  l3Same(f_Tag, AT_REG_IN_MU) or
  l3Same(f_Tag, AT_NORM) or
  l3Same(f_Tag, AT_STATUS) or
  l3Same(f_Tag, AT_BASES);
//#UC END# *490071C401C8_490070F20004_impl*
end;//_nsTaggedTreeInfo_.TagChanged

procedure _nsTaggedTreeInfo_.AssignInfo(const aInfo: InsTaggedTreeInfo);
//#UC START# *49006C7E0341_490070F20004_var*
//#UC END# *49006C7E0341_490070F20004_var*
begin
//#UC START# *49006C7E0341_490070F20004_impl*
 f_Tag := aInfo.Tag;
 f_LogicOperations := aInfo.LogicOperations;
 f_IsOneOperation := aInfo.IsOneLogicOperation;
 f_ServerOneLevel  := aInfo.ServerOneLevel;
 TagChanged;
//#UC END# *49006C7E0341_490070F20004_impl*
end;//_nsTaggedTreeInfo_.AssignInfo

function _nsTaggedTreeInfo_.IsDataOneLevel: Boolean;
//#UC START# *49006C8A02D0_490070F20004_var*
//#UC END# *49006C8A02D0_490070F20004_var*
begin
//#UC START# *49006C8A02D0_490070F20004_impl*
 Result := f_IsDataOneLevel;
//#UC END# *49006C8A02D0_490070F20004_impl*
end;//_nsTaggedTreeInfo_.IsDataOneLevel

function _nsTaggedTreeInfo_.pm_GetTag: Il3CString;
//#UC START# *49006CA10328_490070F20004get_var*
//#UC END# *49006CA10328_490070F20004get_var*
begin
//#UC START# *49006CA10328_490070F20004get_impl*
 Result := f_Tag;
//#UC END# *49006CA10328_490070F20004get_impl*
end;//_nsTaggedTreeInfo_.pm_GetTag

procedure _nsTaggedTreeInfo_.pm_SetTag(const aValue: Il3CString);
//#UC START# *49006CA10328_490070F20004set_var*
//#UC END# *49006CA10328_490070F20004set_var*
begin
//#UC START# *49006CA10328_490070F20004set_impl*
 if not l3Same(f_Tag, aValue) then
 begin
  f_Tag := aValue;
  pm_SetLogicOperations(bsGetOperations(f_Tag));
  TagChanged;
 end;
//#UC END# *49006CA10328_490070F20004set_impl*
end;//_nsTaggedTreeInfo_.pm_SetTag

function _nsTaggedTreeInfo_.pm_GetLogicOperations: TLogicOperationSet;
//#UC START# *49006CB00191_490070F20004get_var*
//#UC END# *49006CB00191_490070F20004get_var*
begin
//#UC START# *49006CB00191_490070F20004get_impl*
 Result := f_LogicOperations;
//#UC END# *49006CB00191_490070F20004get_impl*
end;//_nsTaggedTreeInfo_.pm_GetLogicOperations

procedure _nsTaggedTreeInfo_.pm_SetLogicOperations(aValue: TLogicOperationSet);
//#UC START# *49006CB00191_490070F20004set_var*
//#UC END# *49006CB00191_490070F20004set_var*
begin
//#UC START# *49006CB00191_490070F20004set_impl*
 if f_LogicOperations <> aValue then
 begin
  f_LogicOperations := aValue;
  f_IsOneOperation := bsIsOneOperation(f_LogicOperations);
 end;//if f_LogicOperations <> aValue then
//#UC END# *49006CB00191_490070F20004set_impl*
end;//_nsTaggedTreeInfo_.pm_SetLogicOperations

function _nsTaggedTreeInfo_.pm_GetServerOneLevel: Boolean;
//#UC START# *49006CC30205_490070F20004get_var*
//#UC END# *49006CC30205_490070F20004get_var*
begin
//#UC START# *49006CC30205_490070F20004get_impl*
 Result := f_ServerOneLevel;
//#UC END# *49006CC30205_490070F20004get_impl*
end;//_nsTaggedTreeInfo_.pm_GetServerOneLevel

procedure _nsTaggedTreeInfo_.pm_SetServerOneLevel(aValue: Boolean);
//#UC START# *49006CC30205_490070F20004set_var*
//#UC END# *49006CC30205_490070F20004set_var*
begin
//#UC START# *49006CC30205_490070F20004set_impl*
 f_ServerOneLevel := aValue;
//#UC END# *49006CC30205_490070F20004set_impl*
end;//_nsTaggedTreeInfo_.pm_SetServerOneLevel

function _nsTaggedTreeInfo_.pm_GetIsOneLogicOperation: Boolean;
//#UC START# *49006CD60357_490070F20004get_var*
//#UC END# *49006CD60357_490070F20004get_var*
begin
//#UC START# *49006CD60357_490070F20004get_impl*
 Result := f_IsOneOperation;
//#UC END# *49006CD60357_490070F20004get_impl*
end;//_nsTaggedTreeInfo_.pm_GetIsOneLogicOperation

{$EndIf nsTaggedTreeInfo_imp_impl}

{$EndIf nsTaggedTreeInfo_imp}

