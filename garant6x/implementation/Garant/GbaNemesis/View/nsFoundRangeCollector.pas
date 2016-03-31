unit nsFoundRangeCollector;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFoundRangeCollector.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFoundRangeCollector" MUID: (4D8A2C1700FD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evSearch
 , nevRangeList
 , nevTools
 , nevBase
;

type
 TnsFoundRangeCollector = class(TevBaseReplacer)
  private
   f_FoundRanges: TnevRangeList;
    {* Поле для свойства FoundRanges }
  protected
   function ReplaceFunc(const aView: InevView;
    const Container: InevOp;
    const aBlock: InevRange): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   property FoundRanges: TnevRangeList
    read f_FoundRanges
    write f_FoundRanges;
 end;//TnsFoundRangeCollector
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
;

function TnsFoundRangeCollector.ReplaceFunc(const aView: InevView;
 const Container: InevOp;
 const aBlock: InevRange): Boolean;
//#UC START# *4D553AC103A3_4D8A2C1700FD_var*
//#UC END# *4D553AC103A3_4D8A2C1700FD_var*
begin
//#UC START# *4D553AC103A3_4D8A2C1700FD_impl*
 Result := true;
 if (f_FoundRanges = nil) then
  f_FoundRanges := TnevRangeList.Create;
 f_FoundRanges.Add(aBlock); 
//#UC END# *4D553AC103A3_4D8A2C1700FD_impl*
end;//TnsFoundRangeCollector.ReplaceFunc

procedure TnsFoundRangeCollector.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D8A2C1700FD_var*
//#UC END# *479731C50290_4D8A2C1700FD_var*
begin
//#UC START# *479731C50290_4D8A2C1700FD_impl*
 FreeAndNil(f_FoundRanges);
 inherited;
//#UC END# *479731C50290_4D8A2C1700FD_impl*
end;//TnsFoundRangeCollector.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
