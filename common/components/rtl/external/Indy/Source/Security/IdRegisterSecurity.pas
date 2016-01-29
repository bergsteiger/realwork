{
  $Project$
  $Workfile$
  $Revision: 1.3 $
  $DateUTC$
  $Id: IdRegisterSecurity.pas,v 1.3 2015/06/16 12:31:51 lukyanets Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdRegisterSecurity.pas,v $
  Revision 1.3  2015/06/16 12:31:51  lukyanets
  Новый Indy 10

}
{
  Rev 1.1    3/28/2005 1:11:30 PM  JPMugaas
  Package build errors.

  Rev 1.0    3/28/2005 5:59:14 AM  JPMugaas
  New Security package.
}

unit IdRegisterSecurity;

interface

uses
  Classes;

 {$R IconsDotNet\TIdIOHandlerTls.bmp}
 {$R IconsDotNet\TIdServerIOHandlerTls.bmp}

// Procedures
  procedure Register;

implementation
uses IdIOHandlerTls,
     IdServerIOHandlerTls,
     IdDsnCoreResourceStrings;

procedure Register;
begin
  RegisterComponents(RSRegIndyIOHandlers,
    [TIdIOHandlerTls,
    TIdServerIOHandlerTls]);
end;

end.
