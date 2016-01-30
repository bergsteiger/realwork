unit TestDocumentList;

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\TestDocumentList.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
;

type
 TTestDocumentList = class(Tl3StringList)
  public
   class function Exists: Boolean;
   class function Instance: TTestDocumentList;
    {* Метод получения экземпляра синглетона TTestDocumentList }
 end;//TTestDocumentList
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TTestDocumentList: TTestDocumentList = nil;
 {* Экземпляр синглетона TTestDocumentList }

procedure TTestDocumentListFree;
 {* Метод освобождения экземпляра синглетона TTestDocumentList }
begin
 l3Free(g_TTestDocumentList);
end;//TTestDocumentListFree

class function TTestDocumentList.Exists: Boolean;
//#UC START# *5279D3220116_5279D2EA02DE_var*
//#UC END# *5279D3220116_5279D2EA02DE_var*
begin
//#UC START# *5279D3220116_5279D2EA02DE_impl*
 Result := g_TTestDocumentList <> nil;
//#UC END# *5279D3220116_5279D2EA02DE_impl*
end;//TTestDocumentList.Exists

class function TTestDocumentList.Instance: TTestDocumentList;
 {* Метод получения экземпляра синглетона TTestDocumentList }
begin
 if (g_TTestDocumentList = nil) then
 begin
  l3System.AddExitProc(TTestDocumentListFree);
  g_TTestDocumentList := Create;
 end;
 Result := g_TTestDocumentList;
end;//TTestDocumentList.Instance
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
