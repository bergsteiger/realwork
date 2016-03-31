unit nsFormCoordinates;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\nsFormCoordinates.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFormCoordinates" MUID: (4AC0ABB70051)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , Types
;

type
 InsFormCoordinates = interface
  ['{19A17133-BBBB-44F6-8763-1D186621B75E}']
  function Get_Rect: TRect;
  property Rect: TRect
   read Get_Rect;
 end;//InsFormCoordinates

 TnsFormCoordinates = class(Tl3ProtoObject, InsFormCoordinates)
  private
   f_Coord: TRect;
  protected
   function Get_Rect: TRect;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(const aRect: TRect); reintroduce;
   class function Make(const aRect: TRect): InsFormCoordinates; reintroduce;
 end;//TnsFormCoordinates
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsFormCoordinates.Create(const aRect: TRect);
//#UC START# *4AC0AC2800FE_4AC0ABB70051_var*
//#UC END# *4AC0AC2800FE_4AC0ABB70051_var*
begin
//#UC START# *4AC0AC2800FE_4AC0ABB70051_impl*
 inherited Create;
 f_Coord := aRect;
//#UC END# *4AC0AC2800FE_4AC0ABB70051_impl*
end;//TnsFormCoordinates.Create

class function TnsFormCoordinates.Make(const aRect: TRect): InsFormCoordinates;
var
 l_Inst : TnsFormCoordinates;
begin
 l_Inst := Create(aRect);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFormCoordinates.Make

function TnsFormCoordinates.Get_Rect: TRect;
//#UC START# *4AC0AC110099_4AC0ABB70051get_var*
//#UC END# *4AC0AC110099_4AC0ABB70051get_var*
begin
//#UC START# *4AC0AC110099_4AC0ABB70051get_impl*
 Result := f_Coord;
//#UC END# *4AC0AC110099_4AC0ABB70051get_impl*
end;//TnsFormCoordinates.Get_Rect

{$If NOT Defined(DesignTimeLibrary)}
class function TnsFormCoordinates.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4AC0ABB70051_var*
//#UC END# *47A6FEE600FC_4AC0ABB70051_var*
begin
//#UC START# *47A6FEE600FC_4AC0ABB70051_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4AC0ABB70051_impl*
end;//TnsFormCoordinates.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
