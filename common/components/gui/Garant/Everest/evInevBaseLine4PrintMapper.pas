unit evInevBaseLine4PrintMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\evInevBaseLine4PrintMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevInevBaseLine4PrintMapper" MUID: (53D8ED8D007F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevInevBaseLine4PrintMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevBaseLine4PrintMapper
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , nevTools
 //#UC START# *53D8ED8D007Fimpl_uses*
 //#UC END# *53D8ED8D007Fimpl_uses*
;

class function TevInevBaseLine4PrintMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8ED8D007F_var*
//#UC END# *53D639B601D7_53D8ED8D007F_var*
begin
//#UC START# *53D639B601D7_53D8ED8D007F_impl*
 if not aTag.QT(InevPoint, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8ED8D007F_impl*
end;//TevInevBaseLine4PrintMapper.Make
{$IfEnd} // Defined(evUseVisibleCursors)

end.
