unit l3FormatActionInfoHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FormatActionInfoHelper.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , ActnList
;

 (*
 Ml3FormatActionInfoHelper = interface
  {* Контракт сервиса Tl3FormatActionInfoHelper }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Ml3FormatActionInfoHelper
 *)

type
 Il3FormatActionInfoHelper = interface
  {* Интерфейс сервиса Tl3FormatActionInfoHelper }
  ['{CBBE7B8C-EED1-4A7B-ADB2-361BE86A2A05}']
  function Format(anAction: TCustomAction): AnsiString;
 end;//Il3FormatActionInfoHelper

 Tl3FormatActionInfoHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3FormatActionInfoHelper;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3FormatActionInfoHelper);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function Format(anAction: TCustomAction): AnsiString;
   class function Instance: Tl3FormatActionInfoHelper;
    {* Метод получения экземпляра синглетона Tl3FormatActionInfoHelper }
  public
   property Alien: Il3FormatActionInfoHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3FormatActionInfoHelper }
 end;//Tl3FormatActionInfoHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

var g_Tl3FormatActionInfoHelper: Tl3FormatActionInfoHelper = nil;
 {* Экземпляр синглетона Tl3FormatActionInfoHelper }

procedure Tl3FormatActionInfoHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3FormatActionInfoHelper }
begin
 l3Free(g_Tl3FormatActionInfoHelper);
end;//Tl3FormatActionInfoHelperFree

procedure Tl3FormatActionInfoHelper.pm_SetAlien(const aValue: Il3FormatActionInfoHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3FormatActionInfoHelper.pm_SetAlien

class function Tl3FormatActionInfoHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3FormatActionInfoHelper <> nil;
end;//Tl3FormatActionInfoHelper.Exists

function Tl3FormatActionInfoHelper.Format(anAction: TCustomAction): AnsiString;
//#UC START# *781F06EEA149_551442110069_var*
 function FormatName(const aName: AnsiString): AnsiString;
 begin
  if Length(aName) = 0
   then Result := '-'
   else Result := aName;
 end;
var
 S: AnsiString;
//#UC END# *781F06EEA149_551442110069_var*
begin
//#UC START# *781F06EEA149_551442110069_impl*
 Result := FormatName(anAction.Name) + ': ' + anAction.ClassName;
 if Assigned(f_Alien) then
 begin
  S := f_Alien.Format(anAction);
  if Length(S) > 0 then
   Result := Result + ' (' + S + ');';
 end;
//#UC END# *781F06EEA149_551442110069_impl*
end;//Tl3FormatActionInfoHelper.Format

class function Tl3FormatActionInfoHelper.Instance: Tl3FormatActionInfoHelper;
 {* Метод получения экземпляра синглетона Tl3FormatActionInfoHelper }
begin
 if (g_Tl3FormatActionInfoHelper = nil) then
 begin
  l3System.AddExitProc(Tl3FormatActionInfoHelperFree);
  g_Tl3FormatActionInfoHelper := Create;
 end;
 Result := g_Tl3FormatActionInfoHelper;
end;//Tl3FormatActionInfoHelper.Instance

procedure Tl3FormatActionInfoHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3FormatActionInfoHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
