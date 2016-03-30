unit nsAppTitleData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsAppTitleData.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsAppTitleData" MUID: (53EDD46F03D2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 TnsAppTitleData = class
  private
   f_Initialized: Boolean;
   f_Title: AnsiString;
  protected
   function pm_GetTitle: AnsiString;
   procedure pm_SetTitle(const aValue: AnsiString);
  public
   class function Instance: TnsAppTitleData;
    {* Метод получения экземпляра синглетона TnsAppTitleData }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Title: AnsiString
    read pm_GetTitle
    write pm_SetTitle;
 end;//TnsAppTitleData

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsAppTitleData: TnsAppTitleData = nil;
 {* Экземпляр синглетона TnsAppTitleData }

procedure TnsAppTitleDataFree;
 {* Метод освобождения экземпляра синглетона TnsAppTitleData }
begin
 l3Free(g_TnsAppTitleData);
end;//TnsAppTitleDataFree

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

class function TnsAppTitleData.Instance: TnsAppTitleData;
 {* Метод получения экземпляра синглетона TnsAppTitleData }
begin
 if (g_TnsAppTitleData = nil) then
 begin
  l3System.AddExitProc(TnsAppTitleDataFree);
  g_TnsAppTitleData := Create;
 end;
 Result := g_TnsAppTitleData;
end;//TnsAppTitleData.Instance

class function TnsAppTitleData.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsAppTitleData <> nil;
end;//TnsAppTitleData.Exists

end.
