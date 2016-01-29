unit vcmCommandIDsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmCommandIDsList.pas"
// Начат: 20.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Containers::TvcmCommandIDsList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmCommandIDsListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmCommandIDsList = {final} class(TvcmCommandIDsListPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvcmCommandIDsList;
    {- возвращает экземпляр синглетона. }
 end;//TvcmCommandIDsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvcmCommandIDsList

var g_TvcmCommandIDsList : TvcmCommandIDsList = nil;

procedure TvcmCommandIDsListFree;
begin
 l3Free(g_TvcmCommandIDsList);
end;

class function TvcmCommandIDsList.Instance: TvcmCommandIDsList;
begin
 if (g_TvcmCommandIDsList = nil) then
 begin
  l3System.AddExitProc(TvcmCommandIDsListFree);
  g_TvcmCommandIDsList := Create;
 end;
 Result := g_TvcmCommandIDsList;
end;


class function TvcmCommandIDsList.Exists: Boolean;
 {-}
begin
 Result := g_TvcmCommandIDsList <> nil;
end;//TvcmCommandIDsList.Exists

{$IfEnd} //not NoVCM

end.