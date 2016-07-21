unit NOT_COMPLETED_nevViewInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevViewInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "nevViewInterfaces" MUID: (578F8F6C0050)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

type
 HnevView = object
  {* Обёртка над InevView }
  private
   f_InevView: InevView;
    {* Ссылка на интерфейс InevView }
  private
   procedure Fake; virtual;
    {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
  protected
   function pm_GetMetrics: InevViewMetrics;
   function Data: InevObject;
   function RootMap: InevMap;
   function Processor: InevProcessor;
   procedure ClearShapes;
   procedure BeginDrawShape(const aShape: InevObject;
    const anAnchor: InevBasePoint;
    const anOrg: TnevPoint;
    var theMap: InevMap;
    aFake: Boolean;
    const aHacker: InevK235870994Hacker);
    {* Начинает добавление формы в список. }
   procedure EndDrawShape;
    {* Заканчивает добавление формы в список. }
   function MapByPoint(const aPoint: InevBasePoint;
    aCheckTopVisible: Boolean = False): InevMap;
   function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
   function RootFormatInfo: TnevFormatInfoPrim;
   function Get_ActiveElement: InevActiveElement;
   function Get_ForceDrawFocusRect: Boolean;
   function Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
   procedure Set_IsObjectCollapsed(const anObject: InevObject;
    aValue: Boolean);
   {$If Defined(evNeedCollapsedVersionComments)}
   procedure VersionInfoVisabilityChanged(aValue: Boolean);
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
   function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
   function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
  public
   procedure InvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts);
   constructor Init(const aInevView: InevView); reintroduce;
 end;//HnevView

implementation

uses
 l3ImplUses
;

function HnevView.pm_GetMetrics: InevViewMetrics;
//#UC START# *47C5B99001C4_4A4B231403B6get_var*
//#UC END# *47C5B99001C4_4A4B231403B6get_var*
begin
//#UC START# *47C5B99001C4_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B99001C4_4A4B231403B6get_impl*
end;//HnevView.pm_GetMetrics

function HnevView.Data: InevObject;
//#UC START# *47C5B9A30018_4A4B231403B6_var*
//#UC END# *47C5B9A30018_4A4B231403B6_var*
begin
//#UC START# *47C5B9A30018_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9A30018_4A4B231403B6_impl*
end;//HnevView.Data

function HnevView.RootMap: InevMap;
//#UC START# *47C5B9AA03E1_4A4B231403B6_var*
//#UC END# *47C5B9AA03E1_4A4B231403B6_var*
begin
//#UC START# *47C5B9AA03E1_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9AA03E1_4A4B231403B6_impl*
end;//HnevView.RootMap

function HnevView.Processor: InevProcessor;
//#UC START# *47C5B9B202F0_4A4B231403B6_var*
//#UC END# *47C5B9B202F0_4A4B231403B6_var*
begin
//#UC START# *47C5B9B202F0_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9B202F0_4A4B231403B6_impl*
end;//HnevView.Processor

procedure HnevView.ClearShapes;
//#UC START# *47C5B9C301B9_4A4B231403B6_var*
//#UC END# *47C5B9C301B9_4A4B231403B6_var*
begin
//#UC START# *47C5B9C301B9_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9C301B9_4A4B231403B6_impl*
end;//HnevView.ClearShapes

procedure HnevView.BeginDrawShape(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const anOrg: TnevPoint;
 var theMap: InevMap;
 aFake: Boolean;
 const aHacker: InevK235870994Hacker);
 {* Начинает добавление формы в список. }
//#UC START# *47C5B9DB0136_4A4B231403B6_var*
//#UC END# *47C5B9DB0136_4A4B231403B6_var*
begin
//#UC START# *47C5B9DB0136_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9DB0136_4A4B231403B6_impl*
end;//HnevView.BeginDrawShape

procedure HnevView.EndDrawShape;
 {* Заканчивает добавление формы в список. }
//#UC START# *47C5B9FB03D1_4A4B231403B6_var*
//#UC END# *47C5B9FB03D1_4A4B231403B6_var*
begin
//#UC START# *47C5B9FB03D1_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9FB03D1_4A4B231403B6_impl*
end;//HnevView.EndDrawShape

function HnevView.MapByPoint(const aPoint: InevBasePoint;
 aCheckTopVisible: Boolean = False): InevMap;
//#UC START# *47C5BA240004_4A4B231403B6_var*
//#UC END# *47C5BA240004_4A4B231403B6_var*
begin
//#UC START# *47C5BA240004_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5BA240004_4A4B231403B6_impl*
end;//HnevView.MapByPoint

function HnevView.FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
//#UC START# *481078F302DD_4A4B231403B6_var*
//#UC END# *481078F302DD_4A4B231403B6_var*
begin
//#UC START# *481078F302DD_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *481078F302DD_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPoint

function HnevView.RootFormatInfo: TnevFormatInfoPrim;
//#UC START# *4811BA6C005A_4A4B231403B6_var*
//#UC END# *4811BA6C005A_4A4B231403B6_var*
begin
//#UC START# *4811BA6C005A_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4811BA6C005A_4A4B231403B6_impl*
end;//HnevView.RootFormatInfo

procedure HnevView.InvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *4816E2B2004E_4A4B231403B6_var*
//#UC END# *4816E2B2004E_4A4B231403B6_var*
begin
//#UC START# *4816E2B2004E_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4816E2B2004E_4A4B231403B6_impl*
end;//HnevView.InvalidateShape

function HnevView.Get_ActiveElement: InevActiveElement;
//#UC START# *4A27CEB10364_4A4B231403B6get_var*
//#UC END# *4A27CEB10364_4A4B231403B6get_var*
begin
//#UC START# *4A27CEB10364_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A27CEB10364_4A4B231403B6get_impl*
end;//HnevView.Get_ActiveElement

function HnevView.Get_ForceDrawFocusRect: Boolean;
//#UC START# *4B59A96702D9_4A4B231403B6get_var*
//#UC END# *4B59A96702D9_4A4B231403B6get_var*
begin
//#UC START# *4B59A96702D9_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B59A96702D9_4A4B231403B6get_impl*
end;//HnevView.Get_ForceDrawFocusRect

function HnevView.Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A3DD60219_4A4B231403B6get_var*
//#UC END# *4D5A3DD60219_4A4B231403B6get_var*
begin
//#UC START# *4D5A3DD60219_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3DD60219_4A4B231403B6get_impl*
end;//HnevView.Get_IsObjectCollapsed

procedure HnevView.Set_IsObjectCollapsed(const anObject: InevObject;
 aValue: Boolean);
//#UC START# *4D5A3DD60219_4A4B231403B6set_var*
//#UC END# *4D5A3DD60219_4A4B231403B6set_var*
begin
//#UC START# *4D5A3DD60219_4A4B231403B6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3DD60219_4A4B231403B6set_impl*
end;//HnevView.Set_IsObjectCollapsed

{$If Defined(evNeedCollapsedVersionComments)}
procedure HnevView.VersionInfoVisabilityChanged(aValue: Boolean);
//#UC START# *4D5A3E3E01B7_4A4B231403B6_var*
//#UC END# *4D5A3E3E01B7_4A4B231403B6_var*
begin
//#UC START# *4D5A3E3E01B7_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3E3E01B7_4A4B231403B6_impl*
end;//HnevView.VersionInfoVisabilityChanged
{$IfEnd} // Defined(evNeedCollapsedVersionComments)

function HnevView.FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim;
//#UC START# *4E6F8ED402EF_4A4B231403B6_var*
//#UC END# *4E6F8ED402EF_4A4B231403B6_var*
begin
//#UC START# *4E6F8ED402EF_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F8ED402EF_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPara

function HnevView.FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
//#UC START# *4E6F8EF302A4_4A4B231403B6_var*
//#UC END# *4E6F8EF302A4_4A4B231403B6_var*
begin
//#UC START# *4E6F8EF302A4_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F8EF302A4_4A4B231403B6_impl*
end;//HnevView.FormatInfoByObj

function HnevView.FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim;
//#UC START# *4E6F98080175_4A4B231403B6_var*
//#UC END# *4E6F98080175_4A4B231403B6_var*
begin
//#UC START# *4E6F98080175_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F98080175_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPara

procedure HnevView.Fake;
 {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
begin
 Assert(false);
end;//HnevView.Fake

constructor HnevView.Init(const aInevView: InevView);
begin
 f_InevView := aInevView;
end;//HnevView.Init

end.
