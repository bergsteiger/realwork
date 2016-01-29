unit TB97Reg;

{
  Toolbar97
  Copyright (C) 1998-99 by Jordan Russell
  For conditions of distribution and use, see LICENSE.TXT.
}
{ $Id: TB97REG.PAS,v 1.7 2004/09/16 11:31:13 lulin Exp $ }

interface

{$I l3Delphi.inc }
{$I TB97Ver.inc}

procedure Register;

implementation

{$R TB97Reg.dcr}

uses
  SysUtils, Classes, Dialogs,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  TB97, TB97Tlbr, TB97Tlwn, TB97Ctls
  ;

procedure Register;
begin
  RegisterComponents ('Toolbar97', [TDock97, TToolbar97, TToolWindow97,
    TToolbarButton97, TToolbarSep97, TEdit97]);
end;

end.
