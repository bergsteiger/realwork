{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcVCLLib;

interface
{$I dcprod.inc}

uses
  classes,sysutils,windows,messages,typinfo,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}
  
  dcconsts, dcdreamlib{$IFDEF DREAMINFOTREE}, DCFieldsSelectDlg{$ENDIF};

//=========================================================================
// typedec
// ------------------------ types declaration ------------------
type
{------------------------------------------------------------------}

  {$IFDEF DREAMINFOTREE}
  TDCMultiFieldsProperty = class(TStringProperty)
  protected
    Procedure GetFieldsList( AList : TStrings ); virtual;
  public
    Function GetAttributes : TPropertyAttributes; override;
    Procedure Edit; override;
  end;
  {$ENDIF}
{------------------------------------------------------------------}

  TLimitComponentProperty = class(TComponentProperty)
  private
    FProc : TGetStrProc;
    procedure AcceptProc(Const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function AcceptComponent(AComponent : TComponent):boolean ;virtual;abstract;
  end;

{$IFDEF WIN}
  TDCVersionEditor = class(TStringProperty)
    function  GetAttributes: TPropertyAttributes; override;
    Function GetProductName:String;virtual;
    function  GetValue : string; override;
    procedure Edit; override;
  end;
{$ENDIF}

procedure Register;

implementation

{--------TLimitComponentProperty------------------------------------}

procedure TLimitComponentProperty.AcceptProc(const S: string);
var
  C: TComponent;
begin
  C := Designer.GetComponent(S);
  if Assigned(C) and  AcceptComponent(C) then
    FProc(S);
end;

{------------------------------------------------------------------}

procedure TLimitComponentProperty.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(AcceptProc);
end;


{$IFDEF WIN}
{-------TDCVersionEditor--------------------------------------------}

function TDCVersionEditor.GetAttributes: TPropertyAttributes;
begin
  result := inherited GetAttributes + [paReadOnly, paDialog];
end;

{-----------------------------------------------------------}

Function TDCVersionEditor.GetProductName:String;
Begin
  Result:='Dream Controls';
End;

{-----------------------------------------------------------}

function TDCVersionEditor.GetValue : string;
begin
  result := SDreamControlsVersion;
end;

{-----------------------------------------------------------}
//BeginSkipConst
procedure TDCVersionEditor.Edit;
var
  s : string;
begin
  s := GetProductName +' version '+ GetValue +
  #13#10#13#10'e-mail: contact@dream-com.com'#13#10+
  'WWW: http://www.dream-com.com'#13#10;
  MessageBox(0, pchar(s), pchar('About'), MB_ICONINFORMATION);
end;
//EndSkipConst
{$ENDIF}

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TDCVersion), nil, '' , TDCVersionEditor);
end;

{------------------------------------------------------------------}

{$IFDEF DREAMINFOTREE}

procedure TDCMultiFieldsProperty.Edit;
Var
  Fields          : String;
  AvailableFields : TStringList;
begin
  AvailableFields := TStringList.Create;
  try
    GetFieldsList( AvailableFields );
    Fields := GetStrValue;
    If DCShowFieldsDialog( GetComponent( 0 ).ClassName, Fields, AvailableFields ) Then
      Value := Fields;
  finally
    AvailableFields.Free;
  end;
end;

{------------------------------------------------------------------}

Function TDCMultiFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := Inherited GetAttributes + [paDialog];
end;

{------------------------------------------------------------------}

Procedure TDCMultiFieldsProperty.GetFieldsList( AList : TStrings );
begin
end;

{------------------------------------------------------------------}
{$ENDIF}

end.

