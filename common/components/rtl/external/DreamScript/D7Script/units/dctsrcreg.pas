{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcTSrcReg;

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

  dcconsts, dcgenreg, dctslite, dctsrc;

procedure Register;
begin
  RegisterComponents(SPalDreamTree,[TDCResViewSource,TDCMenuSource,TDCListViewSource,
                     TDCTreeViewSource,TDCCollectSource,TDCStringSource,TDCCompViewSource,
                     TDCFormSource,TDCStringSource,TDCImgListSource,TDCMultiSource]);
  RegisterPropertyEditor(TypeInfo(string),TDCCollectSource,'PropName',TCollPropName);
  RegisterPropertyEditor(TypeInfo(string),TDCStringSource,'PropName',TStringsPropName);
  RegisterPropertyEditor(TypeInfo(TPersistent),TDCCollectSource,'',TComponentProperty);
  RegisterPropertyEditor(TypeInfo(TPersistent),TDCStringSource,'',TComponentProperty);
  RegisterPropertyEditor(TypeInfo(string), TDCResViewSource, 'FileName', TFileNameEdit);
end;

end.
