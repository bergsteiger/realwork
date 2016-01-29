unit vgRemindersLineWithState;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgRemindersLineWithState.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Rem::NewReminders::TvgRemindersLineWithState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgRemindersLine
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  afwInterfaces
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
const
  { nscReminderConstants }
 csidLeft = 'LeftDelta';
 csidRight = 'RightDelta';
 csidTop = 'TopDelta';
 csidBottom = 'BottomDelta';
 csidDefaultParams = 'DefaultParams';

type
 _nsUnknownComponentWithIvcmState_Parent_ = TvgRemindersLine;
 {$Include ..\VT\nsUnknownComponentWithIvcmState.imp.pas}
 TvgRemindersLineWithState = class(_nsUnknownComponentWithIvcmState_)
 private
 // private fields
   f_Left : Integer;
   f_Top : Integer;
   f_Width : Integer;
   f_Height : Integer;
 private
 // private methods
   procedure CheckName;
     {* Сигнатура метода CheckName }
   function MakeId(const aId: AnsiString): AnsiString;
 protected
 // overridden protected methods
    {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
   procedure LoadSettings; override;
    {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
    {$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
   procedure SaveSettings; override;
    {$IfEnd} //not DesignTimeLibrary AND not NoVGScene
   procedure BoundsChanged(aLeft: Integer;
     aTop: Integer;
     aWidth: Integer;
     aHeight: Integer); override;
 end;//TvgRemindersLineWithState
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  afwConsts,
  Types
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

{$Include ..\VT\nsUnknownComponentWithIvcmState.imp.pas}

// start class TvgRemindersLineWithState

procedure TvgRemindersLineWithState.CheckName;
//#UC START# *533BFFBD03B8_533BF7030112_var*
//#UC END# *533BFFBD03B8_533BF7030112_var*
begin
//#UC START# *533BFFBD03B8_533BF7030112_impl*
 Assert((Name <> ''), 'Для сохранения в настройки необходимо установить property Name.');
//#UC END# *533BFFBD03B8_533BF7030112_impl*
end;//TvgRemindersLineWithState.CheckName

function TvgRemindersLineWithState.MakeId(const aId: AnsiString): AnsiString;
//#UC START# *533BFFD20377_533BF7030112_var*
//#UC END# *533BFFD20377_533BF7030112_var*
begin
//#UC START# *533BFFD20377_533BF7030112_impl*
 Result := BaseId + g_afwPathSep + Name + g_afwPathSep + aId;
//#UC END# *533BFFD20377_533BF7030112_impl*
end;//TvgRemindersLineWithState.MakeId

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
procedure TvgRemindersLineWithState.LoadSettings;
//#UC START# *4F9A5C410274_533BF7030112_var*
var
 l_Left, l_Right, l_Top, l_Bottom: Integer;
//#UC END# *4F9A5C410274_533BF7030112_var*
begin
//#UC START# *4F9A5C410274_533BF7030112_impl*
 CheckName;
 if (BaseId <> '') then
 begin
  with Settings do
   if not LoadBoolean(MakeId(csidDefaultParams), True) then
   begin
    l_Left := LoadInteger(MakeId(csidLeft), 0);
    l_Right := LoadInteger(MakeId(csidRight), 0);
    l_Top := LoadInteger(MakeId(csidTop), 0);
    l_Bottom := LoadInteger(MakeId(csidBottom), 0);

    if (l_Right > 0) and (l_Bottom > 0) then
    begin
     Self.HorzPos := l_Left / l_Right;
     Self.VertPos := l_Top / l_Bottom;
    end;
   end;
 end;
//#UC END# *4F9A5C410274_533BF7030112_impl*
end;//TvgRemindersLineWithState.LoadSettings
{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
procedure TvgRemindersLineWithState.SaveSettings;
//#UC START# *4F9A5C530398_533BF7030112_var*
var
 l_Left, l_Right, l_Top, l_Bottom: Integer;
//#UC END# *4F9A5C530398_533BF7030112_var*
begin
//#UC START# *4F9A5C530398_533BF7030112_impl*
 CheckName;
 if (BaseId <> '') then
 begin
  with Settings do
  begin
   SaveBoolean(MakeId(csidDefaultParams), False);

   SaveInteger(MakeId(csidLeft), f_Left);
   SaveInteger(MakeId(csidRight), f_Width);
   SaveInteger(MakeId(csidTop), f_Top);
   SaveInteger(MakeId(csidBottom), f_Height);
  end;
 end;
//#UC END# *4F9A5C530398_533BF7030112_impl*
end;//TvgRemindersLineWithState.SaveSettings
{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

procedure TvgRemindersLineWithState.BoundsChanged(aLeft: Integer;
  aTop: Integer;
  aWidth: Integer;
  aHeight: Integer);
//#UC START# *533D31F800DD_533BF7030112_var*
//#UC END# *533D31F800DD_533BF7030112_var*
begin
//#UC START# *533D31F800DD_533BF7030112_impl*
 with Self.Parent.ScreenToClient(Point(aLeft, aTop)) do
 begin
  f_Left := X;
  f_Top := Y;
 end;
 f_Width := Self.Parent.ClientWidth - aWidth;
 f_Height := Self.Parent.ClientHeight - aHeight;
//#UC END# *533D31F800DD_533BF7030112_impl*
end;//TvgRemindersLineWithState.BoundsChanged

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgRemindersLineWithState
 TtfwClassRef.Register(TvgRemindersLineWithState);
{$IfEnd} //not NoScripts AND not NoVGScene

end.