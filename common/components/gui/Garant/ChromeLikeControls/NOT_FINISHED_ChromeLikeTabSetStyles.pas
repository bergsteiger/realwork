unit NOT_FINISHED_ChromeLikeTabSetStyles;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\NOT_FINISHED_ChromeLikeTabSetStyles.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ChromeLikeTabSetStyles" MUID: (55096E56007C)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;

type
 TChromeLikeTabSetStyles = class
  public
   class function Instance: TChromeLikeTabSetStyles;
    {* Метод получения экземпляра синглетона TChromeLikeTabSetStyles }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TChromeLikeTabSetStyles
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , GDIPUTIL
 , GDIPAPI
 , GDIPOBJ
 , SysUtils
 , l3Base
 //#UC START# *55096E56007Cimpl_uses*
 //#UC END# *55096E56007Cimpl_uses*
;

var g_TChromeLikeTabSetStyles: TChromeLikeTabSetStyles = nil;
 {* Экземпляр синглетона TChromeLikeTabSetStyles }

procedure TChromeLikeTabSetStylesFree;
 {* Метод освобождения экземпляра синглетона TChromeLikeTabSetStyles }
begin
 l3Free(g_TChromeLikeTabSetStyles);
end;//TChromeLikeTabSetStylesFree

class function TChromeLikeTabSetStyles.Instance: TChromeLikeTabSetStyles;
 {* Метод получения экземпляра синглетона TChromeLikeTabSetStyles }
begin
 if (g_TChromeLikeTabSetStyles = nil) then
 begin
  l3System.AddExitProc(TChromeLikeTabSetStylesFree);
  g_TChromeLikeTabSetStyles := Create;
 end;
 Result := g_TChromeLikeTabSetStyles;
end;//TChromeLikeTabSetStyles.Instance

class function TChromeLikeTabSetStyles.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TChromeLikeTabSetStyles <> nil;
end;//TChromeLikeTabSetStyles.Exists
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
