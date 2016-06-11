{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.NativeActivity;

interface

uses
  Posix.SysTypes, Androidapi.AssetManager, Androidapi.Input,
  Androidapi.NativeWindow, Androidapi.Rect, Androidapi.Jni;

(*$HPPEMIT '#include <android/native_activity.h>' *)

{$I Androidapi.inc}

{ Flags for ANativeActivity_showSoftInput; see the Java InputMethodManager
  API for documentation.
}
const
  ANATIVEACTIVITY_SHOW_SOFT_INPUT_IMPLICIT = $0001;
  {$EXTERNALSYM ANATIVEACTIVITY_SHOW_SOFT_INPUT_IMPLICIT}
  
  ANATIVEACTIVITY_SHOW_SOFT_INPUT_FORCED = $0002;
  {$EXTERNALSYM ANATIVEACTIVITY_SHOW_SOFT_INPUT_FORCED}


{ Flags for ANativeActivity_hideSoftInput; see the Java InputMethodManager
  API for documentation.
}
const
  ANATIVEACTIVITY_HIDE_SOFT_INPUT_IMPLICIT_ONLY = $0001;
  {$EXTERNALSYM ANATIVEACTIVITY_HIDE_SOFT_INPUT_IMPLICIT_ONLY}
  
  ANATIVEACTIVITY_HIDE_SOFT_INPUT_NOT_ALWAYS = $0002;
  {$EXTERNALSYM ANATIVEACTIVITY_HIDE_SOFT_INPUT_NOT_ALWAYS}
  
{ This structure defines the native side of an Androidapi.app.NativeActivity.
  It is created by the framework, and handed to the application's native
  code as it is being launched.
 }
type
  
  PANativeActivityCallbacks = ^ANativeActivityCallbacks;

  ANativeActivity = record
    { Pointer to the callback function table of the native application.
      You can set the functions here to your own callbacks.  The callbacks
      pointer itself here should not be changed; it is allocated and managed
      for you by the framework.
    }
    callbacks : PANativeActivityCallbacks;
    
    { The global handle on the process's Java VM.}
    vm : PJavaVM;
    
    { JNI context for the main thread of the app.  Note that this field
      can ONLY be used from the main thread of the process; that is, the
      thread that calls into the ANativeActivityCallbacks.
    }
    env : PJNIEnv;
    
    { The NativeActivity Java class. }
    clazz : JNIObject;
    
    { Path to this application's internal data directory. }
    internalDataPath : MarshaledAString;
    
    { Path to this application's external (removable/mountable) data directory. }
    externalDataPath : MarshaledAString;
    
    { The platform's SDK version code. }
    sdkVersion : Int32;
    
    { This is the native instance of the application.  It is not used by
      the framework, but can be set by the application to its own instance
      state. }
    instance : Pointer;
    
    { Pointer to the Asset Manager instance for the application.  The application
      uses this to access binary assets bundled inside its own .apk file. 
    }
    assetManager : PAAssetManager;
  end;
  {$EXTERNALSYM ANativeActivity}
  
  PANativeActivity = ^ANativeActivity;


   { ANativeActivityCallbacks }

  { NativeActivity has started.  See Java documentation for Activity.onStart()
    for more information.}
  TOnStartCallback  = procedure(Activity: PANativeActivity); cdecl;

  { NativeActivity has resumed.  See Java documentation for Activity.onResume()
    for more information.
  }
  TOnResumeCallback = procedure(Activity: PANativeActivity); cdecl;

  { Framework is asking NativeActivity to save its current instance state.
    See Java documentation for Activity.onSaveInstanceState() for more
    information.  The returned pointer needs to be created with malloc();
    the framework will call free() on it for you.  You also must fill in
    outSize with the number of bytes in the allocation.  Note that the
    saved state will be persisted, so it can not contain any active
    entities (pointers to memory, file descriptors, etc).
  }
  TOnSaveInstanceStateCallback = function(Activity: PANativeActivity; OutSize: Psize_t): Pointer; cdecl;

  { NativeActivity has paused.  See Java documentation for Activity.onPause()
    for more information.
  }
  TOnPauseCallback = procedure(Activity: PANativeActivity); cdecl;

  { NativeActivity has stopped.  See Java documentation for Activity.onStop()
    for more information.
  }
  TOnStopCallback = procedure(Activity: PANativeActivity); cdecl;

  { NativeActivity is being destroyed.  See Java documentation for Activity.onDestroy()
    for more information.
  }
  TOnDestroyCallback = procedure(Activity: PANativeActivity); cdecl;

  { Focus has changed in this NativeActivity's window.  This is often used,
    for example, to pause a game when it loses input focus.
  }
  TOnWindowFocusChangedCallback = procedure(Activity: PANativeActivity; HasFocus: Integer); cdecl;

  { The drawing window for this native Activity has been created.  You
    can use the given native window object to start drawing.
  }
  TOnNativeWindowCreatedCallback = procedure(Activity: PANativeActivity; Window: PANativeWindow); cdecl;

  { The drawing window for this native activity has been resized.  You should
    retrieve the new size from the window and ensure that your rendering in
    it now matches.
  }
  TOnNativeWindowResizedCallback = procedure(Activity: PANativeActivity; Window: PANativeWindow); cdecl;

  { The drawing window for this native activity needs to be redrawn.  To avoid
    transient artifacts during screen changes (such resizing after rotation),
    applications should not return from this function until they have finished
    drawing their window in its current state.
  }
  TOnNativeWindowRedrawNeededCallback = procedure(Activity: PANativeActivity; Window: PANativeWindow); cdecl;

  { The drawing window for this native activity is going to be destroyed.
    You MUST ensure that you do not touch the window object after returning
    from this function: in the common case of drawing to the window from
    another thread, that means the implementation of this callback must
    properly synchronize with the other thread to stop its drawing before
    returning from here.
  }
  TOnNativeWindowDestroyedCallback = procedure(Activity: PANativeActivity; Window: PANativeWindow); cdecl;

  { The input queue for this native activity's window has been created.
    You can use the given input queue to start retrieving input events.
  }
  TOnInputQueueCreatedCallback = procedure(Activity: PANativeActivity; Queue: PAInputQueue); cdecl;


  { The input queue for this native activity's window is being destroyed.
    You should no longer try to reference this object upon returning from this
    function.
  }
  TOnInputQueueDestroyedCallback = procedure(Activity: PANativeActivity; Queue: PAInputQueue); cdecl;

  { The rectangle in the window in which content should be placed has changed.
  }
  TOnContentRectChangedCallback = procedure(Activity: PANativeActivity; Rect: PARect); cdecl;

  { The current device AConfiguration has changed.  The new configuration can
    be retrieved from assetManager.
  }
  TOnConfigurationChangedCallback = procedure(Activity: PANativeActivity); cdecl;

  { The system is running low on memory.  Use this callback to release
    resources you do not need, to help the system avoid killing more
    important processes.
  }
  TOnLowMemoryCallback = procedure(Activity: PANativeActivity); cdecl;


{ These are the callbacks the framework makes into a native application.
  All of these callbacks happen on the main thread of the application.
  By default, all callbacks are NULL; set to a pointer to your own function
  to have it called.
 }
  ANativeActivityCallbacks = record
    onStart: TOnStartCallback;
    onResume: TOnResumeCallback;
    onSaveInstanceState : TOnSaveInstanceStateCallback;
    onPause : TOnPauseCallback;
    onStop : TOnStopCallback;
    onDestroy : TOnDestroyCallback;
    onWindowFocusChanged : TOnWindowFocusChangedCallback;
    onNativeWindowCreated : TOnNativeWindowCreatedCallback;
    onNativeWindowResized : TOnNativeWindowResizedCallback;
    onNativeWindowRedrawNeeded : TOnNativeWindowRedrawNeededCallback;
    onNativeWindowDestroyed : TOnNativeWindowDestroyedCallback;
    onInputQueueCreated : TOnInputQueueCreatedCallback;
    onInputQueueDestroyed : TOnInputQueueDestroyedCallback;
    onContentRectChanged : TOnContentRectChangedCallback;
    onConfigurationChanged : TOnConfigurationChangedCallback;
    onLowMemory : TOnLowMemoryCallback;
  end;
  {$EXTERNALSYM ANativeActivityCallbacks}
  

{ This is the function that must be in the native code to instantiate the
  application's native activity.  It is called with the activity instance (see
  above); if the code is being instantiated from a previously saved instance,
  the savedState will be non-NULL and point to the saved data.  You must make
  any copy of this data you need -- it will be released after you return from
  this function.
 }
  ANativeActivity_createFunc = procedure(Activity: PANativeActivity; SavedState: Pointer; SavedStateSize: size_t); cdecl;

{ The name of the function that NativeInstance looks for when launching its
  native code.  This is the default function that is used, you can specify
  "Androidapi.app.func_name" string meta-data in your manifest to use a different
  function.
 }
var
  ANativeActivity_onCreate : ANativeActivity_createFunc;
  {
  external AndroidLib name 'ANativeActivity_onCreate'
{$EXTERNALSYM ANativeActivity_onCreate}

{ Finish the given activity.  Its finish() method will be called, causing it
  to be stopped and destroyed.  Note that this method can be called from
  *any* thread; it will send a message to the main thread of the process
  where the Java finish call will take place.
}
procedure ANativeActivity_finish(Activity: PANativeActivity); cdecl;
  external AndroidLib name 'ANativeActivity_finish'
{$EXTERNALSYM ANativeActivity_finish}

{ Change the window format of the given activity.  Calls getWindow().setFormat()
  of the given activity.  Note that this method can be called from
  *any* thread; it will send a message to the main thread of the process
  where the Java finish call will take place.
}
procedure ANativeActivity_setWindowFormat(Activity: PANativeActivity; Format: Int32); cdecl;
  external AndroidLib name 'ANativeActivity_setWindowFormat'
{$EXTERNALSYM ANativeActivity_setWindowFormat}

{ Change the window flags of the given activity.  Calls getWindow().setFlags()
  of the given activity.  Note that this method can be called from
  *any* thread; it will send a message to the main thread of the process
  where the Java finish call will take place.  See window.h for flag constants.
}
procedure ANativeActivity_setWindowFlags(Activity: PANativeActivity; AddFlags, RemoveFlags: UInt32); cdecl;
  external AndroidLib name 'ANativeActivity_setWindowFlags'
{$EXTERNALSYM ANativeActivity_setWindowFlags}

{ Show the IME while in the given activity.  Calls InputMethodManager.showSoftInput()
  for the given activity.  Note that this method can be called from
  *any* thread; it will send a message to the main thread of the process
  where the Java finish call will take place.
}
procedure ANativeActivity_showSoftInput(Activity: PANativeActivity; Flags: UInt32); cdecl;
  external AndroidLib name 'ANativeActivity_showSoftInput'
{$EXTERNALSYM ANativeActivity_showSoftInput}

{ Hide the IME while in the given activity.  Calls InputMethodManager.hideSoftInput()
  for the given activity.  Note that this method can be called from
  *any* thread; it will send a message to the main thread of the process
  where the Java finish call will take place.
}
procedure ANativeActivity_hideSoftInput(Activity: PANativeActivity; Flags: UInt32); cdecl;
  external AndroidLib name 'ANativeActivity_hideSoftInput'
{$EXTERNALSYM ANativeActivity_hideSoftInput}

implementation

end.
