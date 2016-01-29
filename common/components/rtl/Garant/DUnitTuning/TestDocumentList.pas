unit TestDocumentList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/TestDocumentList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::Source::TTestDocumentList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3StringList
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TTestDocumentList = class(Tl3StringList)
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TTestDocumentList;
    {- возвращает экземпляр синглетона. }
 end;//TTestDocumentList
{$IfEnd} //nsTest AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3Base {a}
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}


// start class TTestDocumentList

var g_TTestDocumentList : TTestDocumentList = nil;

procedure TTestDocumentListFree;
begin
 l3Free(g_TTestDocumentList);
end;

class function TTestDocumentList.Instance: TTestDocumentList;
begin
 if (g_TTestDocumentList = nil) then
 begin
  l3System.AddExitProc(TTestDocumentListFree);
  g_TTestDocumentList := Create;
 end;
 Result := g_TTestDocumentList;
end;


class function TTestDocumentList.Exists: Boolean;
//#UC START# *5279D3220116_5279D2EA02DE_var*
//#UC END# *5279D3220116_5279D2EA02DE_var*
begin
//#UC START# *5279D3220116_5279D2EA02DE_impl*
 Result := g_TTestDocumentList <> nil;
//#UC END# *5279D3220116_5279D2EA02DE_impl*
end;//TTestDocumentList.Exists

{$IfEnd} //nsTest AND not NotTunedDUnit

end.