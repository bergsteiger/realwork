unit NOT_FINISHED_evMarker;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evMarker.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , k2TagTool
 , nevTools
 , nevBase
 , l3Variant
 , l3Interfaces
;

type
 RevMarker = class of TevMarker;

 _nevParaTool_Parent_ = Tk2TagTool;
 {$Include nevParaTool.imp.pas}
 TevMarker = class(_nevParaTool_, IevMarker)
  protected
   procedure SetClientValue(aValue: Integer;
    const aContext: InevOp); virtual;
   function DoGetClientValue: Integer; virtual;
   function DoGetValue: Integer; virtual;
   procedure DoSetValue(aValue: Integer;
    const Context: InevOp); virtual;
   function MakeCopy(const aTagWrap: InevPara): IevMarker;
    {* делает копию маркера для aTagWrap. }
   procedure SetValue(Value: Integer;
    const Context: InevOp);
    {* установить новое значение параметра. }
   function CompareLevel(aTagWrap: Tl3Variant): Integer;
    {* сравнить уровени вложенности маркера и тега. }
   function Compare(const aMarker: IevMarker): Integer;
    {* сравнивает маркеры. }
   function pm_GetValue: Integer;
   function pm_GetClientValue: Integer;
   function pm_GetLevel: Integer;
   function pm_GetPara: InevPara;
   function Get_TagIndex: Integer;
   function Get_Acc: Integer;
   function Get_Style: TevParaMarkerStyle;
   function Get_Hint: Il3CString;
   function Get_View: InevView;
   procedure Set_View(const aValue: InevView);
  public
   constructor Create(const aView: InevView;
    aPara: Tl3Tag;
    aTag: LongInt;
    aStyle: TevParaMarkerStyle;
    const aHint: Il3CString = nil); reintroduce;
 end;//TevMarker
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , SysUtils
;

type _Instance_R_ = TevMarker;

{$Include nevParaTool.imp.pas}

procedure TevMarker.SetClientValue(aValue: Integer;
 const aContext: InevOp);
//#UC START# *4E3A3F0D0388_4A38AB2A00E2_var*
//#UC END# *4E3A3F0D0388_4A38AB2A00E2_var*
begin
//#UC START# *4E3A3F0D0388_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E3A3F0D0388_4A38AB2A00E2_impl*
end;//TevMarker.SetClientValue

function TevMarker.DoGetClientValue: Integer;
//#UC START# *4E3A4C4B03A0_4A38AB2A00E2_var*
//#UC END# *4E3A4C4B03A0_4A38AB2A00E2_var*
begin
//#UC START# *4E3A4C4B03A0_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E3A4C4B03A0_4A38AB2A00E2_impl*
end;//TevMarker.DoGetClientValue

function TevMarker.DoGetValue: Integer;
//#UC START# *4ECF8E2C007D_4A38AB2A00E2_var*
//#UC END# *4ECF8E2C007D_4A38AB2A00E2_var*
begin
//#UC START# *4ECF8E2C007D_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ECF8E2C007D_4A38AB2A00E2_impl*
end;//TevMarker.DoGetValue

procedure TevMarker.DoSetValue(aValue: Integer;
 const Context: InevOp);
//#UC START# *4ED31DEA0077_4A38AB2A00E2_var*
//#UC END# *4ED31DEA0077_4A38AB2A00E2_var*
begin
//#UC START# *4ED31DEA0077_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED31DEA0077_4A38AB2A00E2_impl*
end;//TevMarker.DoSetValue

constructor TevMarker.Create(const aView: InevView;
 aPara: Tl3Tag;
 aTag: LongInt;
 aStyle: TevParaMarkerStyle;
 const aHint: Il3CString = nil);
//#UC START# *4F3DFD670264_4A38AB2A00E2_var*
//#UC END# *4F3DFD670264_4A38AB2A00E2_var*
begin
//#UC START# *4F3DFD670264_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F3DFD670264_4A38AB2A00E2_impl*
end;//TevMarker.Create

function TevMarker.MakeCopy(const aTagWrap: InevPara): IevMarker;
 {* делает копию маркера для aTagWrap. }
//#UC START# *47C688720388_4A38AB2A00E2_var*
//#UC END# *47C688720388_4A38AB2A00E2_var*
begin
//#UC START# *47C688720388_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C688720388_4A38AB2A00E2_impl*
end;//TevMarker.MakeCopy

procedure TevMarker.SetValue(Value: Integer;
 const Context: InevOp);
 {* установить новое значение параметра. }
//#UC START# *47C688850028_4A38AB2A00E2_var*
//#UC END# *47C688850028_4A38AB2A00E2_var*
begin
//#UC START# *47C688850028_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C688850028_4A38AB2A00E2_impl*
end;//TevMarker.SetValue

function TevMarker.CompareLevel(aTagWrap: Tl3Variant): Integer;
 {* сравнить уровени вложенности маркера и тега. }
//#UC START# *47C68895037D_4A38AB2A00E2_var*
//#UC END# *47C68895037D_4A38AB2A00E2_var*
begin
//#UC START# *47C68895037D_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C68895037D_4A38AB2A00E2_impl*
end;//TevMarker.CompareLevel

function TevMarker.Compare(const aMarker: IevMarker): Integer;
 {* сравнивает маркеры. }
//#UC START# *47C688A60250_4A38AB2A00E2_var*
//#UC END# *47C688A60250_4A38AB2A00E2_var*
begin
//#UC START# *47C688A60250_4A38AB2A00E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C688A60250_4A38AB2A00E2_impl*
end;//TevMarker.Compare

function TevMarker.pm_GetValue: Integer;
//#UC START# *47C688BC0372_4A38AB2A00E2get_var*
//#UC END# *47C688BC0372_4A38AB2A00E2get_var*
begin
//#UC START# *47C688BC0372_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C688BC0372_4A38AB2A00E2get_impl*
end;//TevMarker.pm_GetValue

function TevMarker.pm_GetClientValue: Integer;
//#UC START# *47C688D40338_4A38AB2A00E2get_var*
//#UC END# *47C688D40338_4A38AB2A00E2get_var*
begin
//#UC START# *47C688D40338_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C688D40338_4A38AB2A00E2get_impl*
end;//TevMarker.pm_GetClientValue

function TevMarker.pm_GetLevel: Integer;
//#UC START# *47C688E50309_4A38AB2A00E2get_var*
//#UC END# *47C688E50309_4A38AB2A00E2get_var*
begin
//#UC START# *47C688E50309_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C688E50309_4A38AB2A00E2get_impl*
end;//TevMarker.pm_GetLevel

function TevMarker.pm_GetPara: InevPara;
//#UC START# *47C6892E0289_4A38AB2A00E2get_var*
//#UC END# *47C6892E0289_4A38AB2A00E2get_var*
begin
//#UC START# *47C6892E0289_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6892E0289_4A38AB2A00E2get_impl*
end;//TevMarker.pm_GetPara

function TevMarker.Get_TagIndex: Integer;
//#UC START# *47C6894703C9_4A38AB2A00E2get_var*
//#UC END# *47C6894703C9_4A38AB2A00E2get_var*
begin
//#UC START# *47C6894703C9_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6894703C9_4A38AB2A00E2get_impl*
end;//TevMarker.Get_TagIndex

function TevMarker.Get_Acc: Integer;
//#UC START# *47C68956021B_4A38AB2A00E2get_var*
//#UC END# *47C68956021B_4A38AB2A00E2get_var*
begin
//#UC START# *47C68956021B_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C68956021B_4A38AB2A00E2get_impl*
end;//TevMarker.Get_Acc

function TevMarker.Get_Style: TevParaMarkerStyle;
//#UC START# *47C689630094_4A38AB2A00E2get_var*
//#UC END# *47C689630094_4A38AB2A00E2get_var*
begin
//#UC START# *47C689630094_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C689630094_4A38AB2A00E2get_impl*
end;//TevMarker.Get_Style

function TevMarker.Get_Hint: Il3CString;
//#UC START# *47C689700040_4A38AB2A00E2get_var*
//#UC END# *47C689700040_4A38AB2A00E2get_var*
begin
//#UC START# *47C689700040_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C689700040_4A38AB2A00E2get_impl*
end;//TevMarker.Get_Hint

function TevMarker.Get_View: InevView;
//#UC START# *4821A3A90370_4A38AB2A00E2get_var*
//#UC END# *4821A3A90370_4A38AB2A00E2get_var*
begin
//#UC START# *4821A3A90370_4A38AB2A00E2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4821A3A90370_4A38AB2A00E2get_impl*
end;//TevMarker.Get_View

procedure TevMarker.Set_View(const aValue: InevView);
//#UC START# *4821A3A90370_4A38AB2A00E2set_var*
//#UC END# *4821A3A90370_4A38AB2A00E2set_var*
begin
//#UC START# *4821A3A90370_4A38AB2A00E2set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4821A3A90370_4A38AB2A00E2set_impl*
end;//TevMarker.Set_View
{$IfEnd} // Defined(evUseVisibleCursors)

end.
