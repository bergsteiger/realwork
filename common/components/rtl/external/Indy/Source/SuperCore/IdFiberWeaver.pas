{
  $Project$
  $Workfile$
  $Revision: 1.3 $
  $DateUTC$
  $Id: IdFiberWeaver.pas,v 1.3 2015/06/16 12:31:48 lukyanets Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdFiberWeaver.pas,v $
  Revision 1.3  2015/06/16 12:31:48  lukyanets
  ����� Indy 10

}
{
  Rev 1.0    2004.02.03 12:38:50 AM  czhower
  Move

  Rev 1.0    2003.10.19 2:50:54 PM  czhower
  Fiber cleanup
}

unit IdFiberWeaver;

interface

uses
  IdBaseComponent, IdFiber,
  Windows;

type
  TIdFiberWeaver = class(TIdBaseComponent)
  protected
    procedure Relinquish(
      AFiber: TIdFiber;
      AReschedule: Boolean
      ); virtual; abstract;
  public
    procedure Add(
      AFiber: TIdFiber
      ); virtual; abstract;
    function WaitForFibers(
      ATimeout: Cardinal = Infinite
      ): Boolean;
      virtual; abstract;
  end;

implementation

end.
