unit XPTokenMulticaster;

{
 $Source: /export/home/cvs/common/components/rtl/external/DUnit/Contrib/DUnitWizard/Source/DelphiExperts/Common/XPTokenMulticaster.pas,v $
 $Revision: 1.1 $
 $Date: 2009/03/11 15:16:53 $
 Last amended by $Author: lulin $
 $State: Exp $

 TXPTokenMulticaster:

 Copyright (c) 2001 by The Excellent Programming Company Pty Ltd
 (ABN 27 005 394 918). All rights reserved. This source code is not to be
 redistributed without prior permission from the copyright holder.
 }

interface

uses XPEvent, XPToken;

///////////////////////////////////////////////////////////////////////////
///        IXPTokenMulticaster declaration
///////////////////////////////////////////////////////////////////////////

type

  IXPTokenMulticaster = interface(IXPCount)
    ['{7EF7F401-48E3-11D5-8CC7-0080ADB62643}']
    procedure Add(const Handler: TXPTokenEvent);
    function Insert(const Handler: TXPTokenEvent;
      const idx: integer): integer;
    procedure Delete(const Handler: TXPTokenEvent);
    function Handler: TXPTokenEvent;
    procedure Notify(const Token: TXPToken);
    procedure Clear;
    end;

function CreateIXPTokenMulticaster: IXPTokenMulticaster;


implementation

const CVSID: string = '$Header: /export/home/cvs/common/components/rtl/external/DUnit/Contrib/DUnitWizard/Source/DelphiExperts/Common/XPTokenMulticaster.pas,v 1.1 2009/03/11 15:16:53 lulin Exp $';


///////////////////////////////////////////////////////////////////////////
///        IXPTokenMulticaster implementation
///////////////////////////////////////////////////////////////////////////

type
  TXPTokenMulticaster = class(TXPEventMulticaster, IXPTokenMulticaster)
    protected
    procedure Add(const Handler: TXPTokenEvent);
    function Insert(const Handler: TXPTokenEvent;
      const idx: integer): integer;
    procedure Delete(const Handler: TXPTokenEvent);
    procedure Notify(const Token: TXPToken);
    function Handler: TXPTokenEvent;
    end;

procedure TXPTokenMulticaster.Add(const Handler: TXPTokenEvent);
  begin
  inherited Add(TXPEvent(Handler));
  end;

procedure TXPTokenMulticaster.Delete(const Handler: TXPTokenEvent);
  begin
  inherited Delete(TXPEvent(Handler));
  end;

function TXPTokenMulticaster.Insert(const Handler: TXPTokenEvent;
  const idx: integer): integer;
  begin
  Result := inherited Insert(TXPEvent(Handler), idx);
  end;

procedure TXPTokenMulticaster.Notify(const Token: TXPToken);
  var
  idx: integer;

  begin

  for idx := 0 to Count - 1 do
    TXPTokenEvent(Events[idx])(Token);

  end;

function TXPTokenMulticaster.Handler: TXPTokenEvent;
  begin
  Result := Notify;
  end;


function CreateIXPTokenMulticaster: IXPTokenMulticaster;
  begin
  Result := TXPTokenMulticaster.Create;
  end;

end.


