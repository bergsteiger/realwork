unit nsAppTitleData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/nsAppTitleData.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Common::nsAppTitleData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

type
 TnsAppTitleData = class
 private
 // private fields
   f_Initialized : Boolean;
   f_Title : AnsiString;
    {* Поле для свойства Title}
 protected
 // property methods
   function pm_GetTitle: AnsiString;
   procedure pm_SetTitle(const aValue: AnsiString);
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Title: AnsiString
     read pm_GetTitle
     write pm_SetTitle;
 public
 // singleton factory method
   class function Instance: TnsAppTitleData;
    {- возвращает экземпляр синглетона. }
 end;//TnsAppTitleData

implementation

uses
  l3Base {a}
  ;


// start class TnsAppTitleData

var g_TnsAppTitleData : TnsAppTitleData = nil;

procedure TnsAppTitleDataFree;
begin
 l3Free(g_TnsAppTitleData);
end;

class function TnsAppTitleData.Instance: TnsAppTitleData;
begin
 if (g_TnsAppTitleData = nil) then
 begin
  l3System.AddExitProc(TnsAppTitleDataFree);
  g_TnsAppTitleData := Create;
 end;
 Result := g_TnsAppTitleData;
end;


function TnsAppTitleData.pm_GetTitle: AnsiString;
//#UC START# *53EDD57A01CA_53EDD51203D9get_var*
//#UC END# *53EDD57A01CA_53EDD51203D9get_var*
begin
//#UC START# *53EDD57A01CA_53EDD51203D9get_impl*
 Assert(not f_Initialized);
 Result := f_Title;
//#UC END# *53EDD57A01CA_53EDD51203D9get_impl*
end;//TnsAppTitleData.pm_GetTitle

procedure TnsAppTitleData.pm_SetTitle(const aValue: AnsiString);
//#UC START# *53EDD57A01CA_53EDD51203D9set_var*
//#UC END# *53EDD57A01CA_53EDD51203D9set_var*
begin
//#UC START# *53EDD57A01CA_53EDD51203D9set_impl*
 Assert(not f_Initialized);
 f_Title := aValue;
//#UC END# *53EDD57A01CA_53EDD51203D9set_impl*
end;//TnsAppTitleData.pm_SetTitle

class function TnsAppTitleData.Exists: Boolean;
 {-}
begin
 Result := g_TnsAppTitleData <> nil;
end;//TnsAppTitleData.Exists

end.