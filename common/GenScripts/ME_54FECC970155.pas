unit nsDataExchangeRealization;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDataExchangeRealization.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsDataExchangeRealization" MUID: (54FECC970155)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , nsDataExchangeProxy
 , DynamicDocListUnit
 , bsTypes
;

type
 TnsDataExchangeRealization = class(Tl3ProtoDataContainer, InsDataExchangeSubscriber)
  protected
   procedure MakeAndOpenList(const aList: IDynList;
    aOpenFrom: TbsListOpenFrom = bsTypes.lofNone);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   class function Instance: TnsDataExchangeRealization;
    {* ����� ��������� ���������� ���������� TnsDataExchangeRealization }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsDataExchangeRealization
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , deListSet
 , deSearchInfo
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
;

var g_TnsDataExchangeRealization: TnsDataExchangeRealization = nil;
 {* ��������� ���������� TnsDataExchangeRealization }

procedure TnsDataExchangeRealizationFree;
 {* ����� ������������ ���������� ���������� TnsDataExchangeRealization }
begin
 l3Free(g_TnsDataExchangeRealization);
end;//TnsDataExchangeRealizationFree

procedure TnsDataExchangeRealization.MakeAndOpenList(const aList: IDynList;
 aOpenFrom: TbsListOpenFrom = bsTypes.lofNone);
//#UC START# *54FECB920224_54FECC970155_var*
//#UC END# *54FECB920224_54FECC970155_var*
begin
//#UC START# *54FECB920224_54FECC970155_impl*
 TdmStdRes.OpenList(TdeListSet.Make(aList, wdOpenIfUserDefine, aOpenFrom, True, nil,
   TdeSearchInfo.Make(aList, aOpenFrom = lofAttributeSearch)), nil);
//#UC END# *54FECB920224_54FECC970155_impl*
end;//TnsDataExchangeRealization.MakeAndOpenList

class function TnsDataExchangeRealization.Instance: TnsDataExchangeRealization;
 {* ����� ��������� ���������� ���������� TnsDataExchangeRealization }
begin
 if (g_TnsDataExchangeRealization = nil) then
 begin
  l3System.AddExitProc(TnsDataExchangeRealizationFree);
  g_TnsDataExchangeRealization := Create;
 end;
 Result := g_TnsDataExchangeRealization;
end;//TnsDataExchangeRealization.Instance

class function TnsDataExchangeRealization.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsDataExchangeRealization <> nil;
end;//TnsDataExchangeRealization.Exists

procedure TnsDataExchangeRealization.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_54FECC970155_var*
//#UC END# *479731C50290_54FECC970155_var*
begin
//#UC START# *479731C50290_54FECC970155_impl*
 inherited;
//#UC END# *479731C50290_54FECC970155_impl*
end;//TnsDataExchangeRealization.Cleanup

initialization
//#UC START# *54FECE510392*
 TnsDataExchangeProxy.Instance.Subscriber := TnsDataExchangeRealization.Instance;
//#UC END# *54FECE510392*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
