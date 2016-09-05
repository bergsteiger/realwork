unit csServerStatusRequest;

interface

uses
 Classes,
 CsDataPipe,
 csRequestTask,
 daTypes,
 ddServerStatusRequestPrim
 ;

type
  TddServerStatusRequest = class(TddServerStatusRequestPrim)
  private
    f_LineLength: Integer;
    f_ServerStatus: string;
    f_UsersCount: Integer;
(*  protected
    procedure _LoadFrom(aStream: TStream; aIsPipe: Boolean); override;*)
  public
    constructor Create(aUserID: TdaUserID); override;
(*    procedure _SaveTo(aStream: TStream; aIsPipe: Boolean); override;*)
    procedure SaveRequestToPipe(aPipe: TCsDataPipe); override;
    property LineLength: Integer read f_LineLength;
    property ServerStatus: string read f_ServerStatus;
    property UsersCount: Integer read f_UsersCount;
  end;//TddServerStatusRequest

implementation

uses
 CsTaskTypes,
 ddServerTask
 ;

{
**************************** TddServerStatusRequest ****************************
}
constructor TddServerStatusRequest.Create(aUserID: TdaUserID);
begin
  inherited;
  //TaskType := cs_ttServerStatus;
end;

(*procedure TddServerStatusRequest._LoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
  inherited _LoadFrom(aStream, aIsPipe);
end;

procedure TddServerStatusRequest._SaveTo(aStream: TStream; aIsPipe: Boolean);
begin
  inherited _SaveTo(aStream, aIsPipe);
end;*)

procedure TddServerStatusRequest.SaveRequestToPipe(aPipe: TCsDataPipe);
begin
  inherited;
  f_ServerStatus := aPipe.ReadLn;
  f_UsersCount := aPipe.ReadInteger;
  f_LineLength := aPipe.ReadInteger;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csServerStatusRequest.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttServerStatus, TddServerStatusRequest, 'запрос статуса сервера');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csServerStatusRequest.pas initialization leave'); {$EndIf}
end.
