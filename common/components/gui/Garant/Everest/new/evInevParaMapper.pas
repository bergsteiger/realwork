unit evInevParaMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/evInevParaMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TevInevParaMapper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  k2InterfaceMapper,
  l3IID,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevInevParaMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevParaMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevTools,
  nevBase
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevInevParaMapper

class function TevInevParaMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8F025001E_var*
var
 l_Para : InevPara;
//#UC END# *53D639B601D7_53D8F025001E_var*
begin
//#UC START# *53D639B601D7_53D8F025001E_impl*
 if not aTag.QT(InevPara, l_Para, aProcessor) then
  Result := false
 else
 if IID.EQ(InevObjectPrim) then
 begin
  InevObjectPrim(Tool) := l_Para;
  Result := true;
 end//IID.EQ(InevObjectPrim)
 else
 if IID.EQ(InevObject) then
 begin
  InevObject(Tool) := l_Para;
  Result := true;
 end//IID.EQ(InevObject)
 else
 if not l_Para.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8F025001E_impl*
end;//TevInevParaMapper.Make

{$IfEnd} //k2ForEditor

end.