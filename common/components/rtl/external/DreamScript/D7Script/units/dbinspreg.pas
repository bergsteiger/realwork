{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dbInspReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes, db,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}
  
  dcconsts, dbInsp, dcdbctlreg;

type
  TItemFieldEditor = class(TFieldNameProperty)
  public
    function GetDataSource(instance : TComponent) : TDataSource; override;
  end;

function TItemFieldEditor.GetDataSource(instance : TComponent) : TDataSource;
begin
  result := TInspectorItem(instance).Inspector.DataSource;
end;

procedure Register;
begin
  RegisterComponents(SPalDream,[TDataSetInspector]);
  RegisterComponentEditor(TDataSetInspector,TDataSetInspectorEdit);
  RegisterPropertyEditor(TypeInfo(string), TInspectorItem, 'FieldName', TItemFieldEditor);//don't resource
end;

end.
