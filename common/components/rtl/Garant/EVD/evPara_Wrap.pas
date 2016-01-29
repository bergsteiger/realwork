unit evPara_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evPara_Wrap.pas"
// Начат: 19.12.2002 19:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::EVD::Standard::WevPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Tag_Wrap,
  l3Variant
  ;

type
 TevdParaModifier = class
 public
 // public methods
   class function MarkModified(aTag: Tl3Variant): Boolean; virtual;
 end;//TevdParaModifier

 RevdParaModifier = class of TevdParaModifier;

 WevPara = class(Wk2Tag)
 public
 // overridden public methods
   function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//WevPara

var
   g_ParaModifier : RevdParaModifier = nil;

implementation

// start class TevdParaModifier

class function TevdParaModifier.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE6187015A_4CEE60C90052_var*
//#UC END# *4CEE6187015A_4CEE60C90052_var*
begin
//#UC START# *4CEE6187015A_4CEE60C90052_impl*
 Result := false;
//#UC END# *4CEE6187015A_4CEE60C90052_impl*
end;//TevdParaModifier.MarkModified

function WevPara.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE5D3002FC_484FD34600BA_var*
//#UC END# *4CEE5D3002FC_484FD34600BA_var*
begin
//#UC START# *4CEE5D3002FC_484FD34600BA_impl*
 if (g_ParaModifier = nil) then
  Result := TevdParaModifier.MarkModified(aTag)
 else
  Result := g_ParaModifier.MarkModified(aTag);
//#UC END# *4CEE5D3002FC_484FD34600BA_impl*
end;//WevPara.MarkModified

end.