unit evReqRow_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evReqRow_Wrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::Everest::Standard::WevReqRow
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evPara_Wrap,
  k2Base,
  l3Variant
  ;

type
 WevReqRow = class(WevPara)
 protected
 // overridden protected methods
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevReqRow

implementation

uses
  k2Tags,
  nevTools
  ;

// start class WevReqRow

function WevReqRow.GetAtomData(AE: Tl3Variant;
  aProp: Tk2CustomProperty;
  out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_4857EB02013C_var*
var
 l_RR : InevPara;
 l_R  : Tl3Variant;
//#UC END# *4857A995029E_4857EB02013C_var*
begin
//#UC START# *4857A995029E_4857EB02013C_impl*
 Result := inherited GetAtomData(AE, aProp, Data);
 if not Result then
 begin
  if (aProp.TagIndex = k2_tiModelControl) then
  begin
   if not AE.QT(InevPara, l_RR) then
    Assert(false);
   l_RR := l_RR.Prev;
   while (l_RR <> nil) AND l_RR.AsObject.IsValid do
   begin
    l_R := l_RR.AsObject.Attr[k2_tiModelControl];
    if (l_R <> nil) AND l_R.IsValid then
    begin
     Result := true;
     Data := l_R;
     AE.AttrW[k2_tiModelControl, nil] := l_R;
     break;
    end;//l_R <> 0
    l_RR := l_RR.Prev;
   end;//while (l_RR <> nil)
   // - берем реквизит от предыдущей строки таблицы
  end;//aProp.TagIndex = k2_tiModelControl
 end;//not Result
//#UC END# *4857A995029E_4857EB02013C_impl*
end;//WevReqRow.GetAtomData

end.