{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcAppReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcapp, dcgen;

procedure Register;
begin
  RegisterComponents(SPalDream,[TInstantReport]);
  RegisterComponentAction(SVerbAdd,TCustomIDEProject, ActionAddToProject);
  RegisterComponentAction(SVerbSave,TIDEObject, ActionSaveObject);
  RegisterComponentAction(SVerbSaveAs,TIDEObject, ActionSaveObjectAs);
  RegisterComponentAction(SVerbClose,TIDEObject, ActionCloseObject);

  RegisterComponentAction('-',TCustomIDEProject,nil);
  RegisterComponentAction(SVerbActivateProject,TCustomIDEProject,
    ActionActivateProject);

  RegisterComponentAction(SVerbSave,TIDEProjectItem, ActionSaveObject);
  RegisterComponentAction(SVerbSaveAs,TIDEProjectItem, ActionSaveObjectAs);
  RegisterComponentAction(SVerbClose,TIDEProjectItem, ActionCloseObject);

end;

end.
