unit nevSegmentObject;

// Модуль: "w:\common\components\gui\Garant\Everest\nevSegmentObject.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagTool
 , nevBase
 , l3Variant
;

type
 TnevSegmentObject = class(Tk2TagTool, InevObjectPrim)
  protected
   function pm_GetText: TnevStr;
   function pm_GetTabStops: InevTabStops;
   function pm_GetOffsetX: Integer;
   function pm_GetPID: TnevParaIndex;
   function pm_GetIsVertical: Boolean;
   function Get_OverlapType: TOverlapType;
   function IsLegalComment: Boolean;
    {* Юридический комментарий? }
   function IsDecorationElement: Boolean;
   function DecorObj(aType: TnevDecorType): Tl3Variant;
   function Get_HolderPrim: InevObjectHolderPrim;
   function Get_TreatCollapsedAsHidden: Boolean;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function NeedEvents: Boolean; override;
    {* Нужно ли подписываться на события тегов }
  public
   constructor Create(aTag: Tl3Variant); reintroduce;
   class function Make(aTag: Tl3Variant): InevObjectPrim; reintroduce;
   function IsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean;
   function IsList: Boolean;
   function NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
    {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
 end;//TnevSegmentObject

implementation

uses
 l3ImplUses
 , l3String
 , TextSegment_Const
;

constructor TnevSegmentObject.Create(aTag: Tl3Variant);
//#UC START# *4E5FB49D0253_4E5FAE1700D5_var*
//#UC END# *4E5FB49D0253_4E5FAE1700D5_var*
begin
//#UC START# *4E5FB49D0253_4E5FAE1700D5_impl*
 Assert(aTag.IsKindOf(k2_typTextSegment));
 inherited;
//#UC END# *4E5FB49D0253_4E5FAE1700D5_impl*
end;//TnevSegmentObject.Create

class function TnevSegmentObject.Make(aTag: Tl3Variant): InevObjectPrim;
var
 l_Inst : TnevSegmentObject;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevSegmentObject.Make

function TnevSegmentObject.pm_GetText: TnevStr;
//#UC START# *47C6AB1D02C0_4E5FAE1700D5get_var*
//#UC END# *47C6AB1D02C0_4E5FAE1700D5get_var*
begin
//#UC START# *47C6AB1D02C0_4E5FAE1700D5get_impl*
 l3AssignNil(Result);
 Assert(false);
//#UC END# *47C6AB1D02C0_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.pm_GetText

function TnevSegmentObject.pm_GetTabStops: InevTabStops;
//#UC START# *47C6AB2A0082_4E5FAE1700D5get_var*
//#UC END# *47C6AB2A0082_4E5FAE1700D5get_var*
begin
//#UC START# *47C6AB2A0082_4E5FAE1700D5get_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C6AB2A0082_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.pm_GetTabStops

function TnevSegmentObject.IsHiddenPrim(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *49D0BBEE0383_4E5FAE1700D5_var*
//#UC END# *49D0BBEE0383_4E5FAE1700D5_var*
begin
//#UC START# *49D0BBEE0383_4E5FAE1700D5_impl*
 Result := false;
 Assert(false);
//#UC END# *49D0BBEE0383_4E5FAE1700D5_impl*
end;//TnevSegmentObject.IsHiddenPrim

function TnevSegmentObject.pm_GetOffsetX: Integer;
//#UC START# *49D0C441019B_4E5FAE1700D5get_var*
//#UC END# *49D0C441019B_4E5FAE1700D5get_var*
begin
//#UC START# *49D0C441019B_4E5FAE1700D5get_impl*
 Result := 0;
 Assert(false);
//#UC END# *49D0C441019B_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.pm_GetOffsetX

function TnevSegmentObject.IsList: Boolean;
//#UC START# *49D0E3CE00F5_4E5FAE1700D5_var*
//#UC END# *49D0E3CE00F5_4E5FAE1700D5_var*
begin
//#UC START# *49D0E3CE00F5_4E5FAE1700D5_impl*
 Result := false;
//#UC END# *49D0E3CE00F5_4E5FAE1700D5_impl*
end;//TnevSegmentObject.IsList

function TnevSegmentObject.pm_GetPID: TnevParaIndex;
//#UC START# *49D0E4E7009C_4E5FAE1700D5get_var*
//#UC END# *49D0E4E7009C_4E5FAE1700D5get_var*
begin
//#UC START# *49D0E4E7009C_4E5FAE1700D5get_impl*
 Result := -1;
 Assert(false);
//#UC END# *49D0E4E7009C_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.pm_GetPID

function TnevSegmentObject.pm_GetIsVertical: Boolean;
//#UC START# *49D0E75F00E4_4E5FAE1700D5get_var*
//#UC END# *49D0E75F00E4_4E5FAE1700D5get_var*
begin
//#UC START# *49D0E75F00E4_4E5FAE1700D5get_impl*
 Result := false;
 Assert(false);
//#UC END# *49D0E75F00E4_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.pm_GetIsVertical

function TnevSegmentObject.Get_OverlapType: TOverlapType;
//#UC START# *49D104BB01AF_4E5FAE1700D5get_var*
//#UC END# *49D104BB01AF_4E5FAE1700D5get_var*
begin
//#UC START# *49D104BB01AF_4E5FAE1700D5get_impl*
 Result := Low(Result);
 Assert(false);
//#UC END# *49D104BB01AF_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.Get_OverlapType

function TnevSegmentObject.NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
 {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
//#UC START# *49D105D10274_4E5FAE1700D5_var*
//#UC END# *49D105D10274_4E5FAE1700D5_var*
begin
//#UC START# *49D105D10274_4E5FAE1700D5_impl*
 Result := false;
 Assert(false);
//#UC END# *49D105D10274_4E5FAE1700D5_impl*
end;//TnevSegmentObject.NeedIncludeHeight

function TnevSegmentObject.IsLegalComment: Boolean;
 {* Юридический комментарий? }
//#UC START# *4B7BDCA502F7_4E5FAE1700D5_var*
//#UC END# *4B7BDCA502F7_4E5FAE1700D5_var*
begin
//#UC START# *4B7BDCA502F7_4E5FAE1700D5_impl*
 Result := false;
 Assert(false);
//#UC END# *4B7BDCA502F7_4E5FAE1700D5_impl*
end;//TnevSegmentObject.IsLegalComment

function TnevSegmentObject.IsDecorationElement: Boolean;
//#UC START# *4E1AFECA025B_4E5FAE1700D5_var*
//#UC END# *4E1AFECA025B_4E5FAE1700D5_var*
begin
//#UC START# *4E1AFECA025B_4E5FAE1700D5_impl*
 Result := false;
 Assert(false);
//#UC END# *4E1AFECA025B_4E5FAE1700D5_impl*
end;//TnevSegmentObject.IsDecorationElement

function TnevSegmentObject.DecorObj(aType: TnevDecorType): Tl3Variant;
//#UC START# *4E243EF60356_4E5FAE1700D5_var*
//#UC END# *4E243EF60356_4E5FAE1700D5_var*
begin
//#UC START# *4E243EF60356_4E5FAE1700D5_impl*
 Result := nil;
 Assert(false);
//#UC END# *4E243EF60356_4E5FAE1700D5_impl*
end;//TnevSegmentObject.DecorObj

function TnevSegmentObject.Get_HolderPrim: InevObjectHolderPrim;
//#UC START# *4E5E1CB9007D_4E5FAE1700D5get_var*
//#UC END# *4E5E1CB9007D_4E5FAE1700D5get_var*
begin
//#UC START# *4E5E1CB9007D_4E5FAE1700D5get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4E5E1CB9007D_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.Get_HolderPrim

function TnevSegmentObject.Get_TreatCollapsedAsHidden: Boolean;
//#UC START# *4E6F7B7902C4_4E5FAE1700D5get_var*
//#UC END# *4E6F7B7902C4_4E5FAE1700D5get_var*
begin
//#UC START# *4E6F7B7902C4_4E5FAE1700D5get_impl*
 Result := false;
 Assert(false);
//#UC END# *4E6F7B7902C4_4E5FAE1700D5get_impl*
end;//TnevSegmentObject.Get_TreatCollapsedAsHidden

{$If NOT Defined(DesignTimeLibrary)}
class function TnevSegmentObject.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4E5FAE1700D5_var*
//#UC END# *47A6FEE600FC_4E5FAE1700D5_var*
begin
//#UC START# *47A6FEE600FC_4E5FAE1700D5_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4E5FAE1700D5_impl*
end;//TnevSegmentObject.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TnevSegmentObject.NeedEvents: Boolean;
 {* Нужно ли подписываться на события тегов }
//#UC START# *4A48AFBD001D_4E5FAE1700D5_var*
//#UC END# *4A48AFBD001D_4E5FAE1700D5_var*
begin
//#UC START# *4A48AFBD001D_4E5FAE1700D5_impl*
 Result := false;
//#UC END# *4A48AFBD001D_4E5FAE1700D5_impl*
end;//TnevSegmentObject.NeedEvents

end.
