{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.IOUtils;

interface

//  File Locations in Internal memory. (Accessible only to the program.
// Not accessible to anyone without rooting the Android system.)
// Files written here are deleted when uninstalling the application.)
function GetFilesDir: string;
function GetCacheDir: string;
function GetLibraryPath: string;

//  File Locations in External memory. (Accessible only to the program, but easily
// readable mounting the external storage as a drive in a computer.
// Files written here are deleted when uninstalling the application.)
function GetExternalFilesDir: string;
function GetExternalCacheDir: string;

function GetExternalPicturesDir: string;
function GetExternalCameraDir: string;
/// <summary>Get documents from external storage</summary>
function GetExternalDocumentsDir: string;
function GetExternalDownloadsDir: string;
function GetExternalMoviesDir: string;
function GetExternalMusicDir: string;
function GetExternalAlarmsDir: string;
function GetExternalRingtonesDir: string;


//  File Locations in External memory. (Accessible to all programs, easily
// readable mounting the external storage as a drive in a computer.
// Files written here are preserved when uninstalling the application.)
function GetSharedFilesDir: string;
function GetSharedPicturesDir: string;
function GetSharedCameraDir: string;
/// <summary>Get Shared documents from external storage</summary>
function GetSharedDocumentsDir: string;
function GetSharedDownloadsDir: string;
function GetSharedMoviesDir: string;
function GetSharedMusicDir: string;
function GetSharedAlarmsDir: string;
function GetSharedRingtonesDir: string;


implementation

uses
  Androidapi.Jni,
  Androidapi.NativeActivity;

const
  sDocuments = 'Documents'; { do not translate }
  cPathDelimiter = '/'; { do not translate }

procedure RemoveLastFolder(var APath: string);
var
  I: Integer;
begin
  for I := High(APath) downto 0 do
  begin
    if APath[I] = cPathDelimiter then
      Break;
  end;
  SetLength(APath, I);
end;

function GetJniPath(MethodName, Signature: MarshaledAString): string;
var
  PEnv: PJniEnv;
  ContextClass: JNIClass;
  FileClass: JNIClass;
  GetMethod: JNIMethodID;
  GetPathMethod: JNIMethodID;
  StrPathObject: JNIObject;
  FileObject: JNIObject;
begin
  Result := '';
  PJavaVM(System.JavaMachine)^.AttachCurrentThread(System.JavaMachine, @PEnv, nil);
  ContextClass := PEnv^.GetObjectClass(PEnv, System.JavaContext);

  GetMethod := PEnv^.GetMethodID(PEnv, ContextClass, MethodName, Signature);
  FileObject := PEnv^.CallObjectMethodA(PEnv, System.JavaContext, GetMethod, PJNIValue(ArgsToJNIValues([nil])));
  if FileObject <> nil then
  begin
    FileClass := PEnv^.GetObjectClass(PEnv, FileObject);

    GetPathMethod := PEnv^.GetMethodID(PEnv, FileClass, 'getPath', '()Ljava/lang/String;');
    StrPathObject := PEnv^.CallObjectMethodA(PEnv, FileObject, GetPathMethod, PJNIValue(ArgsToJNIValues([])));

    Result := JNIStringToString(PEnv, StrPathObject);

    PEnv^.DeleteLocalRef(PEnv, StrPathObject);
    PEnv^.DeleteLocalRef(PEnv, FileClass);
    PEnv^.DeleteLocalRef(PEnv, FileObject);
  end;

  PEnv^.DeleteLocalRef(PEnv, ContextClass);
end;

{
  public static String constants related to common directories.
 	DIRECTORY_ALARMS 	Standard directory in which to place any audio files that should be in the list of alarms that the user can select (not as regular music).
 	DIRECTORY_DCIM 	The traditional location for pictures and videos when mounting the device as a camera.
 	DIRECTORY_DOCUMENTS 	Standard directory in which to place documents that have been created by the user.
 	DIRECTORY_DOWNLOADS 	Standard directory in which to place files that have been downloaded by the user.
  DIRECTORY_MOVIES 	Standard directory in which to place movies that are available to the user.
 	DIRECTORY_MUSIC 	Standard directory in which to place any audio files that should be in the regular list of music for the user.
  DIRECTORY_NOTIFICATIONS 	Standard directory in which to place any audio files that should be in the list of notifications that the user can select (not as regular music).
  DIRECTORY_PICTURES 	Standard directory in which to place pictures that are available to the user.
  DIRECTORY_PODCASTS 	Standard directory in which to place any audio files that should be in the list of podcasts that the user can select (not as regular music).
  DIRECTORY_RINGTONES 	Standard directory in which to place any audio files that should be in the list of ringtones that the user can select (not as regular music).
}
type
  TCustomPathType = (cpNONE, cpALARMS, cpDCIM, cpDOCUMENTS, cpDOWNLOADS, cpMOVIES, cpMUSIC, cpNOTIFICATIONS, cpPICTURES,
    cpPODCASTS, cpRINGTONES);

const
  StrPathType: array [TCustomPathType] of MarshaledAString = ('', 'DIRECTORY_ALARMS', 'DIRECTORY_DCIM', 'DIRECTORY_DOCUMENTS',
    'DIRECTORY_DOWNLOADS', 'DIRECTORY_MOVIES', 'DIRECTORY_MUSIC', 'DIRECTORY_NOTIFICATIONS', 'DIRECTORY_PICTURES',
    'DIRECTORY_PODCASTS', 'DIRECTORY_RINGTONES'
  ); { do not translate }

function GetJniCustomPath(MethodName, Signature: MarshaledAString; PathType:TCustomPathType; IsStatic: Boolean = False): string;
var
  PEnv: PJniEnv;
  ContextClass, EnvironmentClass: JNIClass;
  FileClass: JNIClass;
  GetMethod: JNIMethodID;
  GetPathMethod: JNIMethodID;
  StrPathObject: JNIObject;
  CustomPathObject: JNIObject;
  FileObject: JNIObject;
  PathFieldID: JNIFieldID;
begin
  Result := '';
  PJavaVM(System.JavaMachine)^.AttachCurrentThread(System.JavaMachine, @PEnv, nil);
  ContextClass := PEnv^.GetObjectClass(PEnv, System.JavaContext);
  EnvironmentClass := PEnv^.FindClass(PEnv, 'android/os/Environment');

  if PathType = cpNONE then
    PathFieldID := nil
  else
  begin
    PathFieldID := PEnv^.GetStaticFieldID(PEnv, EnvironmentClass, StrPathType[PathType], 'Ljava/lang/String;');
    // Swallow any exception that occurred under JNI if GetStaticFieldID failed to find the Field and returned nil.
    if PEnv^.ExceptionCheck(PEnv) = 1 then
      PEnv^.ExceptionClear(PEnv);
  end;

   // If the PathType cannot be obtained from the system return a blank path. That way we can try an alternate one.
  if not ((PathFieldID = nil) and (PathType <> cpNONE)) then
  begin
    if PathFieldID = nil then
      CustomPathObject := nil
    else
      CustomPathObject := PEnv^.GetStaticObjectField(PEnv, EnvironmentClass, PathFieldID);

    if IsStatic then
    begin
      GetMethod := PEnv^.GetStaticMethodID(PEnv, EnvironmentClass, MethodName, Signature);
      FileObject := PEnv^.CallStaticObjectMethodA(PEnv, EnvironmentClass, GetMethod, PJNIValue(ArgsToJNIValues([CustomPathObject])));
    end
    else begin
      GetMethod := PEnv^.GetMethodID(PEnv, ContextClass, MethodName, Signature);
      FileObject := PEnv^.CallObjectMethodA(PEnv, System.JavaContext, GetMethod, PJNIValue(ArgsToJNIValues([CustomPathObject])));
    end;
    if FileObject <> nil then
    begin
      FileClass := PEnv^.GetObjectClass(PEnv, FileObject);

      GetPathMethod := PEnv^.GetMethodID(PEnv, FileClass, 'getPath', '()Ljava/lang/String;');
      StrPathObject := PEnv^.CallObjectMethodA(PEnv, FileObject, GetPathMethod, PJNIValue(ArgsToJNIValues([])));

      Result := JNIStringToString(PEnv, StrPathObject);

      PEnv^.DeleteLocalRef(PEnv, StrPathObject);
      PEnv^.DeleteLocalRef(PEnv, FileClass);
      PEnv^.DeleteLocalRef(PEnv, FileObject);
    end;
    if CustomPathObject <> nil then
      PEnv^.DeleteLocalRef(PEnv, CustomPathObject);
  end;

  PEnv^.DeleteLocalRef(PEnv, EnvironmentClass);
  PEnv^.DeleteLocalRef(PEnv, ContextClass);
end;

function GetLibraryPath: string;
var
  PEnv: PJniEnv;
  ContextClass: JNIClass;
  FileClass: JNIClass;
  GetMethod: JNIMethodID;
  PropertyID: JNIFieldID;
  StrPathObject: JNIObject;
  FileObject: JNIObject;
begin
  Result := '';
  PJavaVM(System.JavaMachine)^.AttachCurrentThread(System.JavaMachine, @PEnv, nil);
  ContextClass := PEnv^.GetObjectClass(PEnv, System.JavaContext);


  GetMethod := PEnv^.GetMethodID(PEnv, ContextClass, 'getApplicationInfo', '()Landroid/content/pm/ApplicationInfo;');
  FileObject := PEnv^.CallObjectMethodA(PEnv, System.JavaContext, GetMethod, PJNIValue(ArgsToJNIValues([nil])));
  if FileObject <> nil then
  begin
    FileClass := PEnv^.GetObjectClass(PEnv, FileObject);
    PropertyID := PEnv^.GetFieldID(PEnv, FileClass, 'nativeLibraryDir', 'Ljava/lang/String;');
    StrPathObject := PEnv^.GetObjectField(PEnv, FileObject, PropertyID);

    Result := JNIStringToString(PEnv, StrPathObject);

    PEnv^.DeleteLocalRef(PEnv, StrPathObject);
    PEnv^.DeleteLocalRef(PEnv, FileClass);
    PEnv^.DeleteLocalRef(PEnv, FileObject);
  end;
  PEnv^.DeleteLocalRef(PEnv, ContextClass);
end;

function GetFilesDir: string;
begin
{  Retrieving it via JNI, ensures that the retrieved path exists.
  The folder is created if it does not exist. This way we can avoid the problem
  that if we do it via NativeActivity we can have problems trying to write to
  the folder if we do not do a previous ForceDirectories.
}
  Result := GetJniPath('getFilesDir', '()Ljava/io/File;');
end;

function GetExternalFilesDir: string;
begin
{  Retrieving it via JNI, ensures that the retrieved path exists.
  The folder is created if it does not exist. This way we can avoid the problem
  that if we do it via NativeActivity we can have problems trying to write to
  the folder if we do not do a previous ForceDirectories.
}
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpNONE);
end;

function GetCacheDir: string;
begin
  Result := GetJniPath('getCacheDir', '()Ljava/io/File;');
end;

function GetExternalCacheDir: string;
begin
  Result := GetJniPath('getExternalCacheDir', '()Ljava/io/File;');
end;

function GetExternalPicturesDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpPICTURES);
end;

function GetExternalCameraDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpDCIM);
end;

function GetExternalDocumentsDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpDOCUMENTS);
  if Result = '' then
    Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpNONE) + cPathDelimiter + sDocuments;
end;

function GetExternalDownloadsDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpDOWNLOADS);
end;

function GetExternalMoviesDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpMOVIES);
end;

function GetExternalMusicDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpMUSIC);
end;

function GetExternalAlarmsDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpALARMS);
end;

function GetExternalRingtonesDir: string;
begin
  Result := GetJniCustomPath('getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;', cpRINGTONES);
end;

// Shared Folders functions.

function GetSharedFilesDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpDOWNLOADS, True);
  RemoveLastFolder(Result);
end;

function GetSharedPicturesDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpPICTURES, True);
end;

function GetSharedCameraDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpDCIM, True);
end;

function GetSharedDocumentsDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpDOCUMENTS, True);
  if Result = '' then
  begin
    Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpDOWNLOADS, True);
    RemoveLastFolder(Result);
    Result := Result + cPathDelimiter + sDocuments;
  end;
end;

function GetSharedDownloadsDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpDOWNLOADS, True);
end;

function GetSharedMoviesDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpMOVIES, True);
end;

function GetSharedMusicDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpMUSIC, True);
end;

function GetSharedAlarmsDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpALARMS, True);
end;

function GetSharedRingtonesDir: string;
begin
  Result := GetJniCustomPath('getExternalStoragePublicDirectory', '(Ljava/lang/String;)Ljava/io/File;', cpRINGTONES, True);
end;

end.
