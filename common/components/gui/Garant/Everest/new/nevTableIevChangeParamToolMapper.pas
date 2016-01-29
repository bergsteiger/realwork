unit nevTableIevChangeParamToolMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTableIevChangeParamToolMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevTableIevChangeParamToolMapper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot) AND defined(k2ForEditor)}
uses
  k2InterfaceMapper,
  l3IID,
  l3Variant
  ;
{$IfEnd} //evNeedHotSpot AND k2ForEditor

{$If defined(evNeedHotSpot) AND defined(k2ForEditor)}
type
 TnevTableIevChangeParamToolMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevTableIevChangeParamToolMapper
{$IfEnd} //evNeedHotSpot AND k2ForEditor

implementation

{$If defined(evNeedHotSpot) AND defined(k2ForEditor)}
uses
  nevTools,
  SysUtils
  ;
{$IfEnd} //evNeedHotSpot AND k2ForEditor

{$If defined(evNeedHotSpot) AND defined(k2ForEditor)}

// start class TnevTableIevChangeParamToolMapper

class function TnevTableIevChangeParamToolMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D6745E03A8_var*
var
 l_Obj : InevObject;
//#UC END# *53D639B601D7_53D6745E03A8_var*
begin
//#UC START# *53D639B601D7_53D6745E03A8_impl*
 Result := true;
 if aTag.QT(InevObject, l_Obj, aProcessor) then
  try
   if not Supports(l_Obj.MakePoint, IID.IID, Tool) then
    Result := false;
  finally
   l_Obj := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *53D639B601D7_53D6745E03A8_impl*
end;//TnevTableIevChangeParamToolMapper.Make

{$IfEnd} //evNeedHotSpot AND k2ForEditor

end.