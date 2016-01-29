unit m3FileStreamMapView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/NOT_FINISHED_m3FileStreamMapView.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3FileStreamMapView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  l3CProtoObject
  ;

type
 Tm3FileStreamMapView = class(Tl3CProtoObject)
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AStream: IStream;
                                                       aStreamHandle: THandle
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


                function          InitProc00000002    (const ABitMask: LongWord;
                                                       const AProtect: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000002    (
                                                      );


                function          InitProc00000004    (const ABitMask: LongWord;
                                                       const AAccess: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000004    (
                                                      );


         private


          FHandle:                THandle;
          FStream:                IStream;
          FStreamHandle:          THandle;

          FMemBase:               Pointer;
          FMemSize:               LongInt;


                function          pm_GetMemSize       (
                                                      ): LongInt;


         protected


         public


                property          MemBase: Pointer read FMemBase;
                property          MemSize: LongInt read pm_GetMemSize;


                constructor       Create              (const AStream: IStream;
                                                       aStreamHandle: THandle;
                                                       const AProtect: LongWord;
                                                       const AAccess: LongWord
                                                      );

                procedure Cleanup;
                  override;
                  {-}
 end;//Tm3FileStreamMapView

implementation

uses
  Windows,
  SysUtils,
  m2AddPrc
  ;

// start class Tm3FileStreamMapView

 function    Tm3FileStreamMapView.InitProc00000001(const ABitMask: LongWord;
                                                   const AStream: IStream;
                                                   aStreamHandle: THandle
                                                  ): LongWord;
 begin

  with Self do
   begin

    FStream:=AStream;
    FStreamHandle := aStreamHandle;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3FileStreamMapView.DoneProc00000001(
                                                  );
 begin
  FStream := nil;
 end;

 function    Tm3FileStreamMapView.InitProc00000002(const ABitMask: LongWord;
                                                   const AProtect: LongWord
                                                  ): LongWord;

  function    __CreateFileMapping(const AHandle: THandle;
                                  const AProtect: LongWord;
                                  var   AResult: THandle
                                 ): LongBool;
  begin

   if (Win32Platform = VER_PLATFORM_WIN32_NT)
    then
     begin

      AResult:=CreateFileMappingW(AHandle,nil,AProtect,0,0,nil);

     end
    else
     begin

      AResult:=CreateFileMappingA(AHandle,nil,AProtect,0,0,nil);

     end;

   Result:=(AResult <> THandle(0));

  end;

 begin

  with Self do
   begin

    Win32Check(__CreateFileMapping(FStreamHandle,AProtect,FHandle));

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3FileStreamMapView.DoneProc00000002(
                                                  );
 begin

  with Self do
   begin

    Win32Check(CloseHandle(FHandle));

   end;

 end;

 function    Tm3FileStreamMapView.InitProc00000004(const ABitMask: LongWord;
                                                   const AAccess: LongWord
                                                  ): LongWord;

  function    __MapViewOfFile(const AHandle: THandle;
                              const AAccess: LongWord;
                              var   AResult: Pointer
                             ): LongBool;
  begin

   AResult:=MapViewOfFile(AHandle,AAccess,0,0,0);
   Result:=(AResult <> nil);

  end;

 begin

  with Self do
   begin

    Win32Check(__MapViewOfFile(FHandle,AAccess,FMemBase));

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3FileStreamMapView.DoneProc00000004(
                                                  );
 begin

  with Self do
   begin

    Win32Check(UnmapViewOfFile(FMemBase));

   end;

 end;

function Tm3FileStreamMapView.pm_GetMemSize: LongInt;

 function __GetFileSize(const AHandle: THandle;
                        var   AResult: LongInt): LongBool;
 begin//__GetFileSize
  AResult := LongInt(GetFileSize(AHandle, nil));
  Result := (AResult <> LongInt(-1));
 end;//__GetFileSize

begin
 if (FMemSize = LongInt(-1)) then
  Win32Check(__GetFileSize(FStreamHandle, FMemSize));
 Result := FMemSize;
end;

constructor Tm3FileStreamMapView.Create(const AStream: IStream;
                                        aStreamHandle: THandle;
                                        const AProtect: LongWord;
                                        const AAccess: LongWord);
begin
 FMemSize := LongInt(-1);
 inherited Create;
 m2InitOperation(_Status, InitProc00000001($00000001,AStream,aStreamHandle));
 m2InitOperation(_Status, InitProc00000002($00000002,AProtect));
 m2InitOperation(_Status, InitProc00000004($00000004,AAccess));
end;

procedure Tm3FileStreamMapView.Cleanup;
begin
 m2DoneOperation(_Status, $00000004,DoneProc00000004);
 m2DoneOperation(_Status, $00000002,DoneProc00000002);
 m2DoneOperation(_Status, $00000001,DoneProc00000001);
 inherited;
 _Status := 0;
end;

end.