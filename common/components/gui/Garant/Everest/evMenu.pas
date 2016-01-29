unit evMenu;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В.     }
{ Модуль: evMenu - }
{ Начат: 08.10.1998 15:00 }
{ $Id: evMenu.pas,v 1.11 2012/11/01 09:41:35 lulin Exp $ }

// $Log: evMenu.pas,v $
// Revision 1.11  2012/11/01 09:41:35  lulin
// - забыл точку с запятой.
//
// Revision 1.10  2012/11/01 07:42:57  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.9  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.8.54.1  2007/04/20 11:07:19  lulin
// - убираем ненужную функциональность.
//
// Revision 1.8  2002/12/04 12:32:56  voba
// - bug fix: двойной вызов обработчика меню.
//
// Revision 1.7  2001/09/28 14:30:47  law
// - new version: заточка по Delphi 6.0
//
// Revision 1.6  2001/09/21 09:58:54  law
// - cleanup.
//
// Revision 1.5  2001/03/15 17:21:44  law
// - немного поправлена обработка сообщений для меню.
//
// Revision 1.4  2000/12/15 15:10:36  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

{$IfDef evNeedDisp}
uses
  Menus,

  l3Types,
  
  evStandardActions
  ;

type
  TevMenuItem = class(TMenuItem)
    private
    {internal fields}
      f_Operation : TevOperation;
      {$IfNDef Delphi6}
      f_AutoCheck : Bool;
      {$EndIf  Delphi6}
    protected
    {property methods}
      procedure pm_SetOperation(Value: TevOperation);
        {-}
    protected
    {internal methods}
      procedure Click;
        override;
        {-}
    public
    {public methods}
      destructor Destroy;
        override;
        {-}
    published
    {published properties}
      property Operation: TevOperation
        read f_Operation
        write pm_SetOperation
        default ev_ccNone;
        {-}
      property Enabled
        stored false;
        {-}
      {$IfNDef Delphi6}
      property AutoCheck: Bool
        read f_AutoCheck
        write f_AutoCheck
        default false;
        {-}
      {$EndIf  Delphi6}  
  end;//TevMenuItem
{$EndIf evNeedDisp}

implementation

{$IfDef evNeedDisp}

uses
  Classes,
  evDisp
  ;

{ start class TevMenuItem }

destructor TevMenuItem.Destroy;
  {override;}
  {-}
begin
 evOperationDispatcher.RemoveControl(f_Operation, Self);
 inherited Destroy;
end;

procedure TevMenuItem.pm_SetOperation(Value: TevOperation);
  {-}
begin
 if (f_Operation <> Value) then begin
  evOperationDispatcher.RemoveControl(f_Operation, Self);
  f_Operation := Value;
  evOperationDispatcher.AddControl(f_Operation, Self);
 end;
end;

procedure TevMenuItem.Click;
  {override;}
  {-}
begin
 {$IfDef  Delphi6}
 inherited;
 if (Action = nil) then
  evOperationDispatcher.ProcessOperation(Self, f_Operation, Checked);
 {$Else   Delphi6}
 if AutoCheck then Checked := not Checked;
 if (Action = nil) then
  evOperationDispatcher.ProcessOperation(Self, f_Operation, Checked);
 inherited;
 {$EndIf  Delphi6}
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evMenu.pas initialization enter'); {$EndIf}
  RegisterClasses([TevMenuItem]);
{$EndIf evNeedDisp}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evMenu.pas initialization leave'); {$EndIf}
end.

