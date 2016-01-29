unit nevNullPara;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevNullPara.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevNullPara
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
  nevTools,
  nevParaPrim
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevNullPara = class(TnevParaPrim)
 public
 // public methods
   class function Make: InevPara; reintroduce;
   constructor Create; reintroduce;
 end;//TnevNullPara
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TnevNullPara

class function TnevNullPara.Make: InevPara;
var
 l_Inst : TnevNullPara;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnevNullPara.Create;
//#UC START# *48E0BD4D0277_48E0BD200269_var*
//#UC END# *48E0BD4D0277_48E0BD200269_var*
begin
//#UC START# *48E0BD4D0277_48E0BD200269_impl*
 inherited Create(nil);
//#UC END# *48E0BD4D0277_48E0BD200269_impl*
end;//TnevNullPara.Create

{$IfEnd} //k2ForEditor

end.