unit evScrollBar;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evScrollBar -   }
{ Начат: 15.03.2000 15:59 }
{ $Id: evScrollBar.pas,v 1.7 2011/05/19 12:17:32 lulin Exp $ }

// $Log: evScrollBar.pas,v $
// Revision 1.7  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.6  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.5  2002/01/08 13:54:14  law
// - rename type: TevOrientation -> Tl3Orientation.
//
// Revision 1.4  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3ProtoObject,

  l3Units,

  evInternalInterfaces
  ;

type
  TevScrollBar = class(Tl3ProtoObject)
    private
    {internal fields}
      f_Window : Pointer;
      f_Orientation : Tl3Orientation1;
    protected
    {property methods}
      function pm_GetWindow: IevWindow;
      procedure pm_SetWindow(Value: IevWindow);
        {-}
      procedure pm_SetOrientation(Value: Tl3Orientation1);
        {-}
    public
    {public properties}
      property Window: IevWindow
        read pm_GetWindow
        write pm_SetWindow;
        {-}
      property Orientation: Tl3Orientation1
        read f_Orientation
        write pm_SetOrientation;
        {-}
  end;{TevScrollBar}

implementation

function TevScrollBar.pm_GetWindow: IevWindow;
  {-}
begin
 Result := IevWindow(f_Window);
end;

procedure TevScrollBar.pm_SetWindow(Value: IevWindow);
  {-}
begin
 f_Window := Pointer(Value);
end;

procedure TevScrollBar.pm_SetOrientation(Value: Tl3Orientation1);
  {-}
begin
 f_Orientation := Value;
end;

end.

