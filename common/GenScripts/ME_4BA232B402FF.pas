unit nsFolderFilterInfo;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsFolderFilterInfo.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , FoldersDomainInterfaces
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _l3Notifier_Parent_ = Tl3SimpleObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}
 TnsFolderFilterInfo = class(_l3Notifier_, InsFolderFilterInfo, Il3ChangeNotifier)
  private
   f_FilterType: TnsFolderFilter;
   f_FilterFor: TnsFolderFilterFor;
   f_ShowFolders: TnsShowFolders;
  private
   procedure NotifyAboutChanged;
  protected
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
    {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
   function IsSame(const aValue: InsFolderFilterInfo): Boolean;
   function pm_GetFilterFor: TnsFolderFilterFor;
   function pm_GetFilterType: TnsFolderFilter;
   procedure pm_SetFilterType(aValue: TnsFolderFilter);
   function pm_GetShowFolders: TnsShowFolders;
   procedure pm_SetShowFolders(aValue: TnsShowFolders);
  public
   constructor Create(aFilterType: TnsFolderFilter;
    aFilterFor: TnsFolderFilterFor;
    aShowFolders: TnsShowFolders = sfAll); reintroduce;
   class function Make(aFilterType: TnsFolderFilter;
    aFilterFor: TnsFolderFilterFor;
    aShowFolders: TnsShowFolders = sfAll): _l3Notifier_; reintroduce;
 end;//TnsFolderFilterInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}

constructor TnsFolderFilterInfo.Create(aFilterType: TnsFolderFilter;
 aFilterFor: TnsFolderFilterFor;
 aShowFolders: TnsShowFolders = sfAll);
//#UC START# *4BA3A8330320_4BA232B402FF_var*
//#UC END# *4BA3A8330320_4BA232B402FF_var*
begin
//#UC START# *4BA3A8330320_4BA232B402FF_impl*
 inherited Create;
 f_FilterType := aFilterType;
 f_FilterFor := aFilterFor;
 f_ShowFolders := aShowFolders;
//#UC END# *4BA3A8330320_4BA232B402FF_impl*
end;//TnsFolderFilterInfo.Create

class function TnsFolderFilterInfo.Make(aFilterType: TnsFolderFilter;
 aFilterFor: TnsFolderFilterFor;
 aShowFolders: TnsShowFolders = sfAll): _l3Notifier_;
var
 l_Inst : TnsFolderFilterInfo;
begin
 l_Inst := Create(aFilterType, aFilterFor, aShowFolders);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFolderFilterInfo.Make

procedure TnsFolderFilterInfo.NotifyAboutChanged;
//#UC START# *4BA3AA6D0181_4BA232B402FF_var*
var
 l_Index : Integer;
 l_Intf  : InsFolderFilterInfoListener;
 l_Item  : IUnknown;
//#UC END# *4BA3AA6D0181_4BA232B402FF_var*
begin
//#UC START# *4BA3AA6D0181_4BA232B402FF_impl*
 if (NotifiedObjList <> nil) then
  for l_Index := NotifiedObjList.Hi downto 0 do
  begin
   l_Item := IUnknown(f_NotifiedObjList[l_Index]);
   if Supports(l_Item, InsFolderFilterInfoListener, l_Intf) AND
    (l_Item = l_Intf) then
   try
    l_Intf.Changed;
   finally
    l_Intf := nil;
   end;//try..finaly
  end;//for l_Index := NotifiedObjList.Hi downto 0 do
//#UC END# *4BA3AA6D0181_4BA232B402FF_impl*
end;//TnsFolderFilterInfo.NotifyAboutChanged

function TnsFolderFilterInfo.As_Il3ChangeNotifier: Il3ChangeNotifier;
 {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
begin
 Result := Self;
end;//TnsFolderFilterInfo.As_Il3ChangeNotifier

function TnsFolderFilterInfo.IsSame(const aValue: InsFolderFilterInfo): Boolean;
//#UC START# *49900FC80246_4BA232B402FF_var*
//#UC END# *49900FC80246_4BA232B402FF_var*
begin
//#UC START# *49900FC80246_4BA232B402FF_impl*
 Result := (aValue = nil) or
           ((f_FilterType = aValue.FilterType) and (f_FilterFor = aValue.FilterFor));
//#UC END# *49900FC80246_4BA232B402FF_impl*
end;//TnsFolderFilterInfo.IsSame

function TnsFolderFilterInfo.pm_GetFilterFor: TnsFolderFilterFor;
//#UC START# *4990101E01A4_4BA232B402FFget_var*
//#UC END# *4990101E01A4_4BA232B402FFget_var*
begin
//#UC START# *4990101E01A4_4BA232B402FFget_impl*
 Result := f_FilterFor;
//#UC END# *4990101E01A4_4BA232B402FFget_impl*
end;//TnsFolderFilterInfo.pm_GetFilterFor

function TnsFolderFilterInfo.pm_GetFilterType: TnsFolderFilter;
//#UC START# *499010600294_4BA232B402FFget_var*
//#UC END# *499010600294_4BA232B402FFget_var*
begin
//#UC START# *499010600294_4BA232B402FFget_impl*
 Result := f_FilterType;
//#UC END# *499010600294_4BA232B402FFget_impl*
end;//TnsFolderFilterInfo.pm_GetFilterType

procedure TnsFolderFilterInfo.pm_SetFilterType(aValue: TnsFolderFilter);
//#UC START# *499010600294_4BA232B402FFset_var*
//#UC END# *499010600294_4BA232B402FFset_var*
begin
//#UC START# *499010600294_4BA232B402FFset_impl*
 if f_FilterType <> aValue then
 begin
  f_FilterType := aValue;
  NotifyAboutChanged;
 end;//if f_FilterType <> aValue then
//#UC END# *499010600294_4BA232B402FFset_impl*
end;//TnsFolderFilterInfo.pm_SetFilterType

function TnsFolderFilterInfo.pm_GetShowFolders: TnsShowFolders;
//#UC START# *49901491011E_4BA232B402FFget_var*
//#UC END# *49901491011E_4BA232B402FFget_var*
begin
//#UC START# *49901491011E_4BA232B402FFget_impl*
 Result := f_ShowFolders;
//#UC END# *49901491011E_4BA232B402FFget_impl*
end;//TnsFolderFilterInfo.pm_GetShowFolders

procedure TnsFolderFilterInfo.pm_SetShowFolders(aValue: TnsShowFolders);
//#UC START# *49901491011E_4BA232B402FFset_var*
//#UC END# *49901491011E_4BA232B402FFset_var*
begin
//#UC START# *49901491011E_4BA232B402FFset_impl*
 if f_ShowFolders <> aValue then
 begin
  f_ShowFolders := aValue;
  NotifyAboutChanged;
 end;//if f_ShowFolders <> aValue then
//#UC END# *49901491011E_4BA232B402FFset_impl*
end;//TnsFolderFilterInfo.pm_SetShowFolders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
