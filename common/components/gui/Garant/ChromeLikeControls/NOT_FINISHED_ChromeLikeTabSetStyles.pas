unit NOT_FINISHED_ChromeLikeTabSetStyles;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/NOT_FINISHED_ChromeLikeTabSetStyles.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::ChromeLikeTabSetStyles
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeTabSetStyles = class
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TChromeLikeTabSetStyles;
    {- возвращает экземпляр синглетона. }
 end;//TChromeLikeTabSetStyles
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base {a},
  GDIPUTIL,
  GDIPAPI,
  GDIPOBJ
  ;


// start class TChromeLikeTabSetStyles

var g_TChromeLikeTabSetStyles : TChromeLikeTabSetStyles = nil;

procedure TChromeLikeTabSetStylesFree;
begin
 l3Free(g_TChromeLikeTabSetStyles);
end;

class function TChromeLikeTabSetStyles.Instance: TChromeLikeTabSetStyles;
begin
 if (g_TChromeLikeTabSetStyles = nil) then
 begin
  l3System.AddExitProc(TChromeLikeTabSetStylesFree);
  g_TChromeLikeTabSetStyles := Create;
 end;
 Result := g_TChromeLikeTabSetStyles;
end;


class function TChromeLikeTabSetStyles.Exists: Boolean;
 {-}
begin
 Result := g_TChromeLikeTabSetStyles <> nil;
end;//TChromeLikeTabSetStyles.Exists
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.