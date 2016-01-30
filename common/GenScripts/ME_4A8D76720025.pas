unit vcmCommandIDsList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmCommandIDsList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmCommandIDsListPrim
;

type
 TvcmCommandIDsList = {final} class(TvcmCommandIDsListPrim)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TvcmCommandIDsList;
    {* Метод получения экземпляра синглетона TvcmCommandIDsList }
 end;//TvcmCommandIDsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvcmCommandIDsList: TvcmCommandIDsList = nil;
 {* Экземпляр синглетона TvcmCommandIDsList }

procedure TvcmCommandIDsListFree;
 {* Метод освобождения экземпляра синглетона TvcmCommandIDsList }
begin
 l3Free(g_TvcmCommandIDsList);
end;//TvcmCommandIDsListFree

class function TvcmCommandIDsList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmCommandIDsList <> nil;
end;//TvcmCommandIDsList.Exists

class function TvcmCommandIDsList.Instance: TvcmCommandIDsList;
 {* Метод получения экземпляра синглетона TvcmCommandIDsList }
begin
 if (g_TvcmCommandIDsList = nil) then
 begin
  l3System.AddExitProc(TvcmCommandIDsListFree);
  g_TvcmCommandIDsList := Create;
 end;
 Result := g_TvcmCommandIDsList;
end;//TvcmCommandIDsList.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
