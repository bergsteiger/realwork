unit NOT_FINISHED_evSubImplementation;
 {* Реализация интерфейсов IevSub, IevDocumentPart и IevDocument. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_evSubImplementation.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , l3Variant
 , evdTypes
 , l3Interfaces
 , k2BaseTypes
 , l3Types
 , k2ProcTagTool
 , nevBase
;

type
 TevDocumentImplementation = class
  {* Реализация интерфейса IevDocument. }
 end;//TevDocumentImplementation

 _k2TagHolder_Parent_ = Tl3CacheableBase;
 {$Include w:\common\components\rtl\Garant\K2\k2TagHolder.imp.pas}
 _k2TagBox_Parent_ = _k2TagHolder_;
 {$Include w:\common\components\rtl\Garant\K2\k2TagBox.imp.pas}
 TevDocumentPartImplementation = class(_k2TagBox_, IevSub, IevDocumentPart, IevDocumentPoint)
  protected
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
   function pm_GetSubPlace: TevSubPlace;
   function pm_GetName: Tl3WString;
   procedure pm_SetName(const aValue: Tl3WString);
   function pm_GetID: Integer;
   procedure pm_SetID(aValue: Integer);
   function pm_GetLayerID: Integer;
   function pm_GetFlags: Integer;
   procedure pm_SetFlags(aValue: Integer);
   function pm_GetCursor: Tl3Tag;
   procedure pm_SetCursor(aValue: Tl3Tag);
   function pm_GetSubList: InevSubList;
   function pm_GetNext: IevSub;
   function pm_GetLeafPara: Tl3Variant;
   function pm_GetPara: Tl3Variant;
   function pm_GetDocument: IevDocument;
   function Merge: Boolean;
    {* объединяет блок со следующим. }
   function pm_GetExternalHandle: Integer;
   procedure pm_SetExternalHandle(aValue: Integer);
   function pm_GetObjType: Integer;
   procedure pm_SetObjType(aValue: Integer);
   function pm_GetParaCount: Integer;
   function pm_GetParentDocumentPart: IevDocumentPart;
   function pm_GetContentsRec: TevContentsRec;
   procedure pm_SetContentsRec(const aValue: TevContentsRec);
   function Select(const Selection: InevSelection): Boolean; overload;
    {* перемещает Selection на данную метку. }
   function Get_Obj: PInevObject;
   function IsVisibleOnSubPanel: Boolean;
   function GetViewKind: TevBlockViewKind;
 end;//TevDocumentPartImplementation

 TevSubImplementation = class(Tk2ProcTagTool)
  protected
   function DoGetFlags(aTag: Tl3Variant;
    aFlag: LongInt): LongInt; virtual;
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

{$Include w:\common\components\rtl\Garant\K2\k2TagHolder.imp.pas}

type _Instance_R_ = TevDocumentPartImplementation;

{$Include w:\common\components\rtl\Garant\K2\k2TagBox.imp.pas}

procedure TevDocumentPartImplementation.SetTo(EntryPoint: Tl3Variant);
 {* устанавливает метку в EntryPoint. }
//#UC START# *47C6BB0B03A1_4A573E210187_var*
//#UC END# *47C6BB0B03A1_4A573E210187_var*
begin
//#UC START# *47C6BB0B03A1_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BB0B03A1_4A573E210187_impl*
end;//TevDocumentPartImplementation.SetTo

function TevDocumentPartImplementation.Select(const Selection: InevSelection): Boolean;
 {* перемещает Selection на данную метку. }
//#UC START# *47C6BB2001BC_4A573E210187_var*
//#UC END# *47C6BB2001BC_4A573E210187_var*
begin
//#UC START# *47C6BB2001BC_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BB2001BC_4A573E210187_impl*
end;//TevDocumentPartImplementation.Select

function TevDocumentPartImplementation.Delete(const aView: InevView): Boolean;
 {* удаляет метку. }
//#UC START# *47C6BB3401C6_4A573E210187_var*
//#UC END# *47C6BB3401C6_4A573E210187_var*
begin
//#UC START# *47C6BB3401C6_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BB3401C6_4A573E210187_impl*
end;//TevDocumentPartImplementation.Delete

function TevDocumentPartImplementation.IsInIndex: Boolean;
//#UC START# *47C6BB43001B_4A573E210187_var*
//#UC END# *47C6BB43001B_4A573E210187_var*
begin
//#UC START# *47C6BB43001B_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BB43001B_4A573E210187_impl*
end;//TevDocumentPartImplementation.IsInIndex

function TevDocumentPartImplementation.Exists: Boolean;
 {* проверяет существует ли такая метка. }
//#UC START# *47C6BB4C01C4_4A573E210187_var*
//#UC END# *47C6BB4C01C4_4A573E210187_var*
begin
//#UC START# *47C6BB4C01C4_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BB4C01C4_4A573E210187_impl*
end;//TevDocumentPartImplementation.Exists

function TevDocumentPartImplementation.SubInstance: Tl3Variant;
 {* собственно Sub. }
//#UC START# *47C6BB750290_4A573E210187_var*
//#UC END# *47C6BB750290_4A573E210187_var*
begin
//#UC START# *47C6BB750290_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BB750290_4A573E210187_impl*
end;//TevDocumentPartImplementation.SubInstance

function TevDocumentPartImplementation.pm_GetSubPlace: TevSubPlace;
//#UC START# *47C6BBB30039_4A573E210187get_var*
//#UC END# *47C6BBB30039_4A573E210187get_var*
begin
//#UC START# *47C6BBB30039_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BBB30039_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetSubPlace

function TevDocumentPartImplementation.pm_GetName: Tl3WString;
//#UC START# *47C6BBC7008F_4A573E210187get_var*
//#UC END# *47C6BBC7008F_4A573E210187get_var*
begin
//#UC START# *47C6BBC7008F_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BBC7008F_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetName

procedure TevDocumentPartImplementation.pm_SetName(const aValue: Tl3WString);
//#UC START# *47C6BBC7008F_4A573E210187set_var*
//#UC END# *47C6BBC7008F_4A573E210187set_var*
begin
//#UC START# *47C6BBC7008F_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BBC7008F_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetName

function TevDocumentPartImplementation.pm_GetID: Integer;
//#UC START# *47C6BBD70171_4A573E210187get_var*
//#UC END# *47C6BBD70171_4A573E210187get_var*
begin
//#UC START# *47C6BBD70171_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BBD70171_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetID

procedure TevDocumentPartImplementation.pm_SetID(aValue: Integer);
//#UC START# *47C6BBD70171_4A573E210187set_var*
//#UC END# *47C6BBD70171_4A573E210187set_var*
begin
//#UC START# *47C6BBD70171_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BBD70171_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetID

function TevDocumentPartImplementation.pm_GetLayerID: Integer;
//#UC START# *47C6BBEC0287_4A573E210187get_var*
//#UC END# *47C6BBEC0287_4A573E210187get_var*
begin
//#UC START# *47C6BBEC0287_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BBEC0287_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetLayerID

function TevDocumentPartImplementation.pm_GetFlags: Integer;
//#UC START# *47C6BC030177_4A573E210187get_var*
//#UC END# *47C6BC030177_4A573E210187get_var*
begin
//#UC START# *47C6BC030177_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC030177_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetFlags

procedure TevDocumentPartImplementation.pm_SetFlags(aValue: Integer);
//#UC START# *47C6BC030177_4A573E210187set_var*
//#UC END# *47C6BC030177_4A573E210187set_var*
begin
//#UC START# *47C6BC030177_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC030177_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetFlags

function TevDocumentPartImplementation.pm_GetCursor: Tl3Tag;
//#UC START# *47C6BC15011E_4A573E210187get_var*
//#UC END# *47C6BC15011E_4A573E210187get_var*
begin
//#UC START# *47C6BC15011E_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC15011E_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetCursor

procedure TevDocumentPartImplementation.pm_SetCursor(aValue: Tl3Tag);
//#UC START# *47C6BC15011E_4A573E210187set_var*
//#UC END# *47C6BC15011E_4A573E210187set_var*
begin
//#UC START# *47C6BC15011E_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC15011E_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetCursor

function TevDocumentPartImplementation.pm_GetSubList: InevSubList;
//#UC START# *47C6BC2C02E0_4A573E210187get_var*
//#UC END# *47C6BC2C02E0_4A573E210187get_var*
begin
//#UC START# *47C6BC2C02E0_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC2C02E0_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetSubList

function TevDocumentPartImplementation.pm_GetNext: IevSub;
//#UC START# *47C6BC5D00DA_4A573E210187get_var*
//#UC END# *47C6BC5D00DA_4A573E210187get_var*
begin
//#UC START# *47C6BC5D00DA_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC5D00DA_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetNext

function TevDocumentPartImplementation.pm_GetLeafPara: Tl3Variant;
//#UC START# *47C6BC77007B_4A573E210187get_var*
//#UC END# *47C6BC77007B_4A573E210187get_var*
begin
//#UC START# *47C6BC77007B_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC77007B_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetLeafPara

function TevDocumentPartImplementation.pm_GetPara: Tl3Variant;
//#UC START# *47C6BC8E0271_4A573E210187get_var*
//#UC END# *47C6BC8E0271_4A573E210187get_var*
begin
//#UC START# *47C6BC8E0271_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BC8E0271_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetPara

function TevDocumentPartImplementation.pm_GetDocument: IevDocument;
//#UC START# *47C6BCA60255_4A573E210187get_var*
//#UC END# *47C6BCA60255_4A573E210187get_var*
begin
//#UC START# *47C6BCA60255_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BCA60255_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetDocument

function TevDocumentPartImplementation.Merge: Boolean;
 {* объединяет блок со следующим. }
//#UC START# *47C6BCEE0369_4A573E210187_var*
//#UC END# *47C6BCEE0369_4A573E210187_var*
begin
//#UC START# *47C6BCEE0369_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BCEE0369_4A573E210187_impl*
end;//TevDocumentPartImplementation.Merge

function TevDocumentPartImplementation.pm_GetExternalHandle: Integer;
//#UC START# *47C6BD0402A2_4A573E210187get_var*
//#UC END# *47C6BD0402A2_4A573E210187get_var*
begin
//#UC START# *47C6BD0402A2_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD0402A2_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetExternalHandle

procedure TevDocumentPartImplementation.pm_SetExternalHandle(aValue: Integer);
//#UC START# *47C6BD0402A2_4A573E210187set_var*
//#UC END# *47C6BD0402A2_4A573E210187set_var*
begin
//#UC START# *47C6BD0402A2_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD0402A2_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetExternalHandle

function TevDocumentPartImplementation.pm_GetObjType: Integer;
//#UC START# *47C6BD1603BB_4A573E210187get_var*
//#UC END# *47C6BD1603BB_4A573E210187get_var*
begin
//#UC START# *47C6BD1603BB_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD1603BB_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetObjType

procedure TevDocumentPartImplementation.pm_SetObjType(aValue: Integer);
//#UC START# *47C6BD1603BB_4A573E210187set_var*
//#UC END# *47C6BD1603BB_4A573E210187set_var*
begin
//#UC START# *47C6BD1603BB_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD1603BB_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetObjType

function TevDocumentPartImplementation.pm_GetParaCount: Integer;
//#UC START# *47C6BD2E00D3_4A573E210187get_var*
//#UC END# *47C6BD2E00D3_4A573E210187get_var*
begin
//#UC START# *47C6BD2E00D3_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD2E00D3_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetParaCount

function TevDocumentPartImplementation.pm_GetParentDocumentPart: IevDocumentPart;
//#UC START# *47C6BD4102D7_4A573E210187get_var*
//#UC END# *47C6BD4102D7_4A573E210187get_var*
begin
//#UC START# *47C6BD4102D7_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD4102D7_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetParentDocumentPart

function TevDocumentPartImplementation.pm_GetContentsRec: TevContentsRec;
//#UC START# *47C6BD68029F_4A573E210187get_var*
//#UC END# *47C6BD68029F_4A573E210187get_var*
begin
//#UC START# *47C6BD68029F_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD68029F_4A573E210187get_impl*
end;//TevDocumentPartImplementation.pm_GetContentsRec

procedure TevDocumentPartImplementation.pm_SetContentsRec(const aValue: TevContentsRec);
//#UC START# *47C6BD68029F_4A573E210187set_var*
//#UC END# *47C6BD68029F_4A573E210187set_var*
begin
//#UC START# *47C6BD68029F_4A573E210187set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6BD68029F_4A573E210187set_impl*
end;//TevDocumentPartImplementation.pm_SetContentsRec

function TevDocumentPartImplementation.Select(const Selection: InevSelection): Boolean;
 {* перемещает Selection на данную метку. }
//#UC START# *47C7DE650012_4A573E210187_var*
//#UC END# *47C7DE650012_4A573E210187_var*
begin
//#UC START# *47C7DE650012_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7DE650012_4A573E210187_impl*
end;//TevDocumentPartImplementation.Select

function TevDocumentPartImplementation.Get_Obj: PInevObject;
//#UC START# *49DDD02D00E3_4A573E210187get_var*
//#UC END# *49DDD02D00E3_4A573E210187get_var*
begin
//#UC START# *49DDD02D00E3_4A573E210187get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DDD02D00E3_4A573E210187get_impl*
end;//TevDocumentPartImplementation.Get_Obj

function TevDocumentPartImplementation.IsVisibleOnSubPanel: Boolean;
//#UC START# *51E6790B0351_4A573E210187_var*
//#UC END# *51E6790B0351_4A573E210187_var*
begin
//#UC START# *51E6790B0351_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *51E6790B0351_4A573E210187_impl*
end;//TevDocumentPartImplementation.IsVisibleOnSubPanel

function TevDocumentPartImplementation.GetViewKind: TevBlockViewKind;
//#UC START# *5278BA5C0245_4A573E210187_var*
//#UC END# *5278BA5C0245_4A573E210187_var*
begin
//#UC START# *5278BA5C0245_4A573E210187_impl*
 !!! Needs to be implemented !!!
//#UC END# *5278BA5C0245_4A573E210187_impl*
end;//TevDocumentPartImplementation.GetViewKind

function TevSubImplementation.DoGetFlags(aTag: Tl3Variant;
 aFlag: LongInt): LongInt;
//#UC START# *535F5A7D00BB_4C9B0A3D0184_var*
//#UC END# *535F5A7D00BB_4C9B0A3D0184_var*
begin
//#UC START# *535F5A7D00BB_4C9B0A3D0184_impl*
 !!! Needs to be implemented !!!
//#UC END# *535F5A7D00BB_4C9B0A3D0184_impl*
end;//TevSubImplementation.DoGetFlags

end.
