{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Support;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util,
  Androidapi.JNI.Widget;

type
// ===== Forward declarations =====

  Japp_Fragment = interface;//android.support.v4.app.Fragment
  Japp_Fragment_SavedState = interface;//android.support.v4.app.Fragment$SavedState
  JFragmentActivity = interface;//android.support.v4.app.FragmentActivity
  Japp_FragmentManager = interface;//android.support.v4.app.FragmentManager
  Japp_FragmentManager_BackStackEntry = interface;//android.support.v4.app.FragmentManager$BackStackEntry
  Japp_FragmentManager_OnBackStackChangedListener = interface;//android.support.v4.app.FragmentManager$OnBackStackChangedListener
  Japp_FragmentTransaction = interface;//android.support.v4.app.FragmentTransaction
  Japp_LoaderManager = interface;//android.support.v4.app.LoaderManager
  Japp_LoaderManager_LoaderCallbacks = interface;//android.support.v4.app.LoaderManager$LoaderCallbacks
  JNotificationCompat_Builder = interface;//android.support.v4.app.NotificationCompat$Builder
  JNotificationCompat_Style = interface;//android.support.v4.app.NotificationCompat$Style
  Jcontent_Loader = interface;//android.support.v4.content.Loader
  Jcontent_Loader_OnLoadCompleteListener = interface;//android.support.v4.content.Loader$OnLoadCompleteListener
  JWakefulBroadcastReceiver = interface;//android.support.v4.content.WakefulBroadcastReceiver

// ===== Interface declarations =====

  Japp_FragmentClass = interface(JObjectClass)
    ['{E3089B9B-FD4C-463E-A7C9-BD9DE5C6D3F7}']
    {class} function init: Japp_Fragment; cdecl;
    {class} function instantiate(context: JContext; fname: JString): Japp_Fragment; cdecl; overload;
    {class} function instantiate(context: JContext; fname: JString; args: JBundle): Japp_Fragment; cdecl; overload;
  end;

  [JavaSignature('android/support/v4/app/Fragment')]
  Japp_Fragment = interface(JObject)
    ['{7C819B68-2FEC-4843-B2FB-B0CCFDA11642}']
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getActivity: JFragmentActivity; cdecl;
    function getArguments: JBundle; cdecl;
    function getChildFragmentManager: Japp_FragmentManager; cdecl;
    function getFragmentManager: Japp_FragmentManager; cdecl;
    function getId: Integer; cdecl;
    function getLoaderManager: Japp_LoaderManager; cdecl;
    function getParentFragment: Japp_Fragment; cdecl;
    function getResources: JResources; cdecl;
    function getRetainInstance: Boolean; cdecl;
    function getString(resId: Integer): JString; cdecl; overload;
    function getTag: JString; cdecl;
    function getTargetFragment: Japp_Fragment; cdecl;
    function getTargetRequestCode: Integer; cdecl;
    function getText(resId: Integer): JCharSequence; cdecl;
    function getUserVisibleHint: Boolean; cdecl;
    function getView: JView; cdecl;
    function hashCode: Integer; cdecl;
    function isAdded: Boolean; cdecl;
    function isDetached: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isInLayout: Boolean; cdecl;
    function isRemoving: Boolean; cdecl;
    function isResumed: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    procedure onActivityCreated(savedInstanceState: JBundle); cdecl;
    procedure onActivityResult(requestCode: Integer; resultCode: Integer; data: JIntent); cdecl;
    procedure onAttach(activity: JActivity); cdecl;
    procedure onConfigurationChanged(newConfig: JConfiguration); cdecl;
    function onContextItemSelected(item: JMenuItem): Boolean; cdecl;
    procedure onCreate(savedInstanceState: JBundle); cdecl;
    function onCreateAnimation(transit: Integer; enter: Boolean; nextAnim: Integer): JAnimation; cdecl;
    procedure onCreateContextMenu(menu: JContextMenu; v: JView; menuInfo: JContextMenu_ContextMenuInfo); cdecl;
    procedure onCreateOptionsMenu(menu: JMenu; inflater: JMenuInflater); cdecl;
    function onCreateView(inflater: JLayoutInflater; container: JViewGroup; savedInstanceState: JBundle): JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyOptionsMenu; cdecl;
    procedure onDestroyView; cdecl;
    procedure onDetach; cdecl;
    procedure onHiddenChanged(hidden: Boolean); cdecl;
    procedure onInflate(activity: JActivity; attrs: JAttributeSet; savedInstanceState: JBundle); cdecl;
    procedure onLowMemory; cdecl;
    function onOptionsItemSelected(item: JMenuItem): Boolean; cdecl;
    procedure onOptionsMenuClosed(menu: JMenu); cdecl;
    procedure onPause; cdecl;
    procedure onPrepareOptionsMenu(menu: JMenu); cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(outState: JBundle); cdecl;
    procedure onStart; cdecl;
    procedure onStop; cdecl;
    procedure onViewCreated(view: JView; savedInstanceState: JBundle); cdecl;
    procedure onViewStateRestored(savedInstanceState: JBundle); cdecl;
    procedure registerForContextMenu(view: JView); cdecl;
    procedure setArguments(args: JBundle); cdecl;
    procedure setHasOptionsMenu(hasMenu: Boolean); cdecl;
    procedure setInitialSavedState(state: Japp_Fragment_SavedState); cdecl;
    procedure setMenuVisibility(menuVisible: Boolean); cdecl;
    procedure setRetainInstance(retain: Boolean); cdecl;
    procedure setTargetFragment(fragment: Japp_Fragment; requestCode: Integer); cdecl;
    procedure setUserVisibleHint(isVisibleToUser: Boolean); cdecl;
    procedure startActivity(intent: JIntent); cdecl;
    procedure startActivityForResult(intent: JIntent; requestCode: Integer); cdecl;
    function toString: JString; cdecl;
    procedure unregisterForContextMenu(view: JView); cdecl;
  end;
  TJapp_Fragment = class(TJavaGenericImport<Japp_FragmentClass, Japp_Fragment>) end;

  Japp_Fragment_SavedStateClass = interface(JObjectClass)
    ['{6AF46B16-0976-4759-AB40-599B705C4239}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/support/v4/app/Fragment$SavedState')]
  Japp_Fragment_SavedState = interface(JObject)
    ['{21C3F0C5-A8C9-444E-B4DF-8DBA6E797052}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJapp_Fragment_SavedState = class(TJavaGenericImport<Japp_Fragment_SavedStateClass, Japp_Fragment_SavedState>) end;

  JFragmentActivityClass = interface(JActivityClass)
    ['{750FF7AB-0643-439B-A6C3-DB0EA3D1AFD7}']
    {class} function init: JFragmentActivity; cdecl;
  end;

  [JavaSignature('android/support/v4/app/FragmentActivity')]
  JFragmentActivity = interface(JActivity)
    ['{150D107F-E0C3-49B0-BFC7-5A551379615C}']
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function getLastCustomNonConfigurationInstance: JObject; cdecl;
    function getSupportFragmentManager: Japp_FragmentManager; cdecl;
    function getSupportLoaderManager: Japp_LoaderManager; cdecl;
    procedure onAttachFragment(fragment: Japp_Fragment); cdecl;
    procedure onBackPressed; cdecl;
    procedure onConfigurationChanged(newConfig: JConfiguration); cdecl;
    function onCreatePanelMenu(featureId: Integer; menu: JMenu): Boolean; cdecl;
    function onCreateView(name: JString; context: JContext; attrs: JAttributeSet): JView; cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    procedure onLowMemory; cdecl;
    function onMenuItemSelected(featureId: Integer; item: JMenuItem): Boolean; cdecl;
    procedure onPanelClosed(featureId: Integer; menu: JMenu); cdecl;
    function onPreparePanel(featureId: Integer; view: JView; menu: JMenu): Boolean; cdecl;
    function onRetainCustomNonConfigurationInstance: JObject; cdecl;
    function onRetainNonConfigurationInstance: JObject; cdecl;
    procedure startActivityForResult(intent: JIntent; requestCode: Integer); cdecl;
    procedure startActivityFromFragment(fragment: Japp_Fragment; intent: JIntent; requestCode: Integer); cdecl;
    procedure supportInvalidateOptionsMenu; cdecl;
  end;
  TJFragmentActivity = class(TJavaGenericImport<JFragmentActivityClass, JFragmentActivity>) end;

  Japp_FragmentManagerClass = interface(JObjectClass)
    ['{B337A371-DC72-4A07-940A-4CA4F5FFB078}']
    {class} function _GetPOP_BACK_STACK_INCLUSIVE: Integer; cdecl;
    {class} function init: Japp_FragmentManager; cdecl;
    {class} procedure enableDebugLogging(enabled: Boolean); cdecl;
    {class} property POP_BACK_STACK_INCLUSIVE: Integer read _GetPOP_BACK_STACK_INCLUSIVE;
  end;

  [JavaSignature('android/support/v4/app/FragmentManager')]
  Japp_FragmentManager = interface(JObject)
    ['{19B65C80-D723-4014-9185-44BEBAD0947A}']
    procedure addOnBackStackChangedListener(listener: Japp_FragmentManager_OnBackStackChangedListener); cdecl;
    function beginTransaction: Japp_FragmentTransaction; cdecl;
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function executePendingTransactions: Boolean; cdecl;
    function findFragmentById(id: Integer): Japp_Fragment; cdecl;
    function findFragmentByTag(tag: JString): Japp_Fragment; cdecl;
    function getBackStackEntryAt(index: Integer): Japp_FragmentManager_BackStackEntry; cdecl;
    function getBackStackEntryCount: Integer; cdecl;
    function getFragment(bundle: JBundle; key: JString): Japp_Fragment; cdecl;
    function isDestroyed: Boolean; cdecl;
    procedure popBackStack; cdecl; overload;
    procedure popBackStack(name: JString; flags: Integer); cdecl; overload;
    procedure popBackStack(id: Integer; flags: Integer); cdecl; overload;
    function popBackStackImmediate: Boolean; cdecl; overload;
    function popBackStackImmediate(name: JString; flags: Integer): Boolean; cdecl; overload;
    function popBackStackImmediate(id: Integer; flags: Integer): Boolean; cdecl; overload;
    procedure putFragment(bundle: JBundle; key: JString; fragment: Japp_Fragment); cdecl;
    procedure removeOnBackStackChangedListener(listener: Japp_FragmentManager_OnBackStackChangedListener); cdecl;
    function saveFragmentInstanceState(f: Japp_Fragment): Japp_Fragment_SavedState; cdecl;
  end;
  TJapp_FragmentManager = class(TJavaGenericImport<Japp_FragmentManagerClass, Japp_FragmentManager>) end;

  Japp_FragmentManager_BackStackEntryClass = interface(IJavaClass)
    ['{DEF82AEE-4F42-417B-81E1-14471A8BA6AE}']
  end;

  [JavaSignature('android/support/v4/app/FragmentManager$BackStackEntry')]
  Japp_FragmentManager_BackStackEntry = interface(IJavaInstance)
    ['{9DCCFF9D-2628-433C-A071-212F3C1DE5FA}']
    function getBreadCrumbShortTitle: JCharSequence; cdecl;
    function getBreadCrumbShortTitleRes: Integer; cdecl;
    function getBreadCrumbTitle: JCharSequence; cdecl;
    function getBreadCrumbTitleRes: Integer; cdecl;
    function getId: Integer; cdecl;
    function getName: JString; cdecl;
  end;
  TJapp_FragmentManager_BackStackEntry = class(TJavaGenericImport<Japp_FragmentManager_BackStackEntryClass, Japp_FragmentManager_BackStackEntry>) end;

  Japp_FragmentManager_OnBackStackChangedListenerClass = interface(IJavaClass)
    ['{F60DD80B-2570-4ED5-A16C-E7EAC6B63F30}']
  end;

  [JavaSignature('android/support/v4/app/FragmentManager$OnBackStackChangedListener')]
  Japp_FragmentManager_OnBackStackChangedListener = interface(IJavaInstance)
    ['{63207AFF-576A-40BA-A51B-4A7C17CC1D45}']
    procedure onBackStackChanged; cdecl;
  end;
  TJapp_FragmentManager_OnBackStackChangedListener = class(TJavaGenericImport<Japp_FragmentManager_OnBackStackChangedListenerClass, Japp_FragmentManager_OnBackStackChangedListener>) end;

  Japp_FragmentTransactionClass = interface(JObjectClass)
    ['{ACA4981E-8459-4155-BF06-5D19957B6BE7}']
    {class} function _GetTRANSIT_ENTER_MASK: Integer; cdecl;
    {class} function _GetTRANSIT_EXIT_MASK: Integer; cdecl;
    {class} function _GetTRANSIT_FRAGMENT_CLOSE: Integer; cdecl;
    {class} function _GetTRANSIT_FRAGMENT_FADE: Integer; cdecl;
    {class} function _GetTRANSIT_FRAGMENT_OPEN: Integer; cdecl;
    {class} function _GetTRANSIT_NONE: Integer; cdecl;
    {class} function _GetTRANSIT_UNSET: Integer; cdecl;
    {class} function init: Japp_FragmentTransaction; cdecl;
    {class} property TRANSIT_ENTER_MASK: Integer read _GetTRANSIT_ENTER_MASK;
    {class} property TRANSIT_EXIT_MASK: Integer read _GetTRANSIT_EXIT_MASK;
    {class} property TRANSIT_FRAGMENT_CLOSE: Integer read _GetTRANSIT_FRAGMENT_CLOSE;
    {class} property TRANSIT_FRAGMENT_FADE: Integer read _GetTRANSIT_FRAGMENT_FADE;
    {class} property TRANSIT_FRAGMENT_OPEN: Integer read _GetTRANSIT_FRAGMENT_OPEN;
    {class} property TRANSIT_NONE: Integer read _GetTRANSIT_NONE;
    {class} property TRANSIT_UNSET: Integer read _GetTRANSIT_UNSET;
  end;

  [JavaSignature('android/support/v4/app/FragmentTransaction')]
  Japp_FragmentTransaction = interface(JObject)
    ['{9B1E0684-DC82-4C71-BC05-56C51FF65DD3}']
    function add(fragment: Japp_Fragment; tag: JString): Japp_FragmentTransaction; cdecl; overload;
    function add(containerViewId: Integer; fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl; overload;
    function add(containerViewId: Integer; fragment: Japp_Fragment; tag: JString): Japp_FragmentTransaction; cdecl; overload;
    function addToBackStack(name: JString): Japp_FragmentTransaction; cdecl;
    function attach(fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl;
    function commit: Integer; cdecl;
    function commitAllowingStateLoss: Integer; cdecl;
    function detach(fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl;
    function disallowAddToBackStack: Japp_FragmentTransaction; cdecl;
    function hide(fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl;
    function isAddToBackStackAllowed: Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function remove(fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl;
    function replace(containerViewId: Integer; fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl; overload;
    function replace(containerViewId: Integer; fragment: Japp_Fragment; tag: JString): Japp_FragmentTransaction; cdecl; overload;
    function setBreadCrumbShortTitle(res: Integer): Japp_FragmentTransaction; cdecl; overload;
    function setBreadCrumbShortTitle(text: JCharSequence): Japp_FragmentTransaction; cdecl; overload;
    function setBreadCrumbTitle(res: Integer): Japp_FragmentTransaction; cdecl; overload;
    function setBreadCrumbTitle(text: JCharSequence): Japp_FragmentTransaction; cdecl; overload;
    function setCustomAnimations(enter: Integer; exit: Integer): Japp_FragmentTransaction; cdecl; overload;
    function setCustomAnimations(enter: Integer; exit: Integer; popEnter: Integer; popExit: Integer): Japp_FragmentTransaction; cdecl; overload;
    function setTransition(transit: Integer): Japp_FragmentTransaction; cdecl;
    function setTransitionStyle(styleRes: Integer): Japp_FragmentTransaction; cdecl;
    function show(fragment: Japp_Fragment): Japp_FragmentTransaction; cdecl;
  end;
  TJapp_FragmentTransaction = class(TJavaGenericImport<Japp_FragmentTransactionClass, Japp_FragmentTransaction>) end;

  Japp_LoaderManagerClass = interface(JObjectClass)
    ['{479A03D5-D5F3-4084-A8EC-241CEA0F0AFB}']
    {class} function init: Japp_LoaderManager; cdecl;
    {class} procedure enableDebugLogging(enabled: Boolean); cdecl;
  end;

  [JavaSignature('android/support/v4/app/LoaderManager')]
  Japp_LoaderManager = interface(JObject)
    ['{E13F6C45-41F3-4A16-9B2D-6C3BFF45FDE5}']
    procedure destroyLoader(id: Integer); cdecl;
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function getLoader(id: Integer): Jcontent_Loader; cdecl;
    function hasRunningLoaders: Boolean; cdecl;
    function initLoader(id: Integer; args: JBundle; callback: Japp_LoaderManager_LoaderCallbacks): Jcontent_Loader; cdecl;
    function restartLoader(id: Integer; args: JBundle; callback: Japp_LoaderManager_LoaderCallbacks): Jcontent_Loader; cdecl;
  end;
  TJapp_LoaderManager = class(TJavaGenericImport<Japp_LoaderManagerClass, Japp_LoaderManager>) end;

  Japp_LoaderManager_LoaderCallbacksClass = interface(IJavaClass)
    ['{49F864F7-F0C4-4990-AE14-1B20E356F92C}']
  end;

  [JavaSignature('android/support/v4/app/LoaderManager$LoaderCallbacks')]
  Japp_LoaderManager_LoaderCallbacks = interface(IJavaInstance)
    ['{FD34E913-C4A1-4D1D-B6B8-421D9C3D9770}']
    function onCreateLoader(id: Integer; args: JBundle): Jcontent_Loader; cdecl;
    procedure onLoadFinished(loader: Jcontent_Loader; data: JObject); cdecl;
    procedure onLoaderReset(loader: Jcontent_Loader); cdecl;
  end;
  TJapp_LoaderManager_LoaderCallbacks = class(TJavaGenericImport<Japp_LoaderManager_LoaderCallbacksClass, Japp_LoaderManager_LoaderCallbacks>) end;

  JNotificationCompat_BuilderClass = interface(JObjectClass)
    ['{6EC74C2C-EBCC-4A55-98B6-6DD36DE3BA8C}']
    {class} function init(context: JContext): JNotificationCompat_Builder; cdecl;
  end;

  [JavaSignature('android/support/v4/app/NotificationCompat$Builder')]
  JNotificationCompat_Builder = interface(JObject)
    ['{7DE9C385-1C34-413C-9E85-D8FA90028065}']
    function addAction(icon: Integer; title: JCharSequence; intent: JPendingIntent): JNotificationCompat_Builder; cdecl;
    function build: JNotification; cdecl;
    function getNotification: JNotification; cdecl;//Deprecated
    function setAutoCancel(autoCancel: Boolean): JNotificationCompat_Builder; cdecl;
    function setContent(views: JRemoteViews): JNotificationCompat_Builder; cdecl;
    function setContentInfo(info: JCharSequence): JNotificationCompat_Builder; cdecl;
    function setContentIntent(intent: JPendingIntent): JNotificationCompat_Builder; cdecl;
    function setContentText(text: JCharSequence): JNotificationCompat_Builder; cdecl;
    function setContentTitle(title: JCharSequence): JNotificationCompat_Builder; cdecl;
    function setDefaults(defaults: Integer): JNotificationCompat_Builder; cdecl;
    function setDeleteIntent(intent: JPendingIntent): JNotificationCompat_Builder; cdecl;
    function setFullScreenIntent(intent: JPendingIntent; highPriority: Boolean): JNotificationCompat_Builder; cdecl;
    function setLargeIcon(icon: JBitmap): JNotificationCompat_Builder; cdecl;
    function setLights(argb: Integer; onMs: Integer; offMs: Integer): JNotificationCompat_Builder; cdecl;
    function setNumber(number: Integer): JNotificationCompat_Builder; cdecl;
    function setOngoing(ongoing: Boolean): JNotificationCompat_Builder; cdecl;
    function setOnlyAlertOnce(onlyAlertOnce: Boolean): JNotificationCompat_Builder; cdecl;
    function setPriority(pri: Integer): JNotificationCompat_Builder; cdecl;
    function setProgress(max: Integer; progress: Integer; indeterminate: Boolean): JNotificationCompat_Builder; cdecl;
    function setSmallIcon(icon: Integer): JNotificationCompat_Builder; cdecl; overload;
    function setSmallIcon(icon: Integer; level: Integer): JNotificationCompat_Builder; cdecl; overload;
    function setSound(sound: Jnet_Uri): JNotificationCompat_Builder; cdecl; overload;
    function setSound(sound: Jnet_Uri; streamType: Integer): JNotificationCompat_Builder; cdecl; overload;
    function setStyle(style: JNotificationCompat_Style): JNotificationCompat_Builder; cdecl;
    function setSubText(text: JCharSequence): JNotificationCompat_Builder; cdecl;
    function setTicker(tickerText: JCharSequence): JNotificationCompat_Builder; cdecl; overload;
    function setTicker(tickerText: JCharSequence; views: JRemoteViews): JNotificationCompat_Builder; cdecl; overload;
    function setUsesChronometer(b: Boolean): JNotificationCompat_Builder; cdecl;
    function setVibrate(pattern: TJavaArray<Int64>): JNotificationCompat_Builder; cdecl;
    function setWhen(when: Int64): JNotificationCompat_Builder; cdecl;
  end;
  TJNotificationCompat_Builder = class(TJavaGenericImport<JNotificationCompat_BuilderClass, JNotificationCompat_Builder>) end;

  JNotificationCompat_StyleClass = interface(JObjectClass)
    ['{A76478B0-8BCB-4AFA-AFCD-CB0460219CDA}']
    {class} function init: JNotificationCompat_Style; cdecl;
  end;

  [JavaSignature('android/support/v4/app/NotificationCompat$Style')]
  JNotificationCompat_Style = interface(JObject)
    ['{5C782C73-8C4B-4ADA-994D-4293E0D2D282}']
    function build: JNotification; cdecl;
    procedure setBuilder(builder: JNotificationCompat_Builder); cdecl;
  end;
  TJNotificationCompat_Style = class(TJavaGenericImport<JNotificationCompat_StyleClass, JNotificationCompat_Style>) end;

  Jcontent_LoaderClass = interface(JObjectClass)
    ['{75230956-00B9-43CD-8C60-ADA295F7E7F3}']
    {class} function init(context: JContext): Jcontent_Loader; cdecl;
  end;

  [JavaSignature('android/support/v4/content/Loader')]
  Jcontent_Loader = interface(JObject)
    ['{B43C247C-8BDF-497A-BAC1-1E900F51A47D}']
    procedure abandon; cdecl;
    procedure commitContentChanged; cdecl;
    function dataToString(data: JObject): JString; cdecl;
    procedure deliverResult(data: JObject); cdecl;
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    procedure forceLoad; cdecl;
    function getContext: JContext; cdecl;
    function getId: Integer; cdecl;
    function isAbandoned: Boolean; cdecl;
    function isReset: Boolean; cdecl;
    function isStarted: Boolean; cdecl;
    procedure onContentChanged; cdecl;
    procedure registerListener(id: Integer; listener: Jcontent_Loader_OnLoadCompleteListener); cdecl;
    procedure reset; cdecl;
    procedure rollbackContentChanged; cdecl;
    procedure startLoading; cdecl;
    procedure stopLoading; cdecl;
    function takeContentChanged: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure unregisterListener(listener: Jcontent_Loader_OnLoadCompleteListener); cdecl;
  end;
  TJcontent_Loader = class(TJavaGenericImport<Jcontent_LoaderClass, Jcontent_Loader>) end;

  Jcontent_Loader_OnLoadCompleteListenerClass = interface(IJavaClass)
    ['{AD54E07C-4FD0-4274-9A2D-A17F9D57FF5C}']
  end;

  [JavaSignature('android/support/v4/content/Loader$OnLoadCompleteListener')]
  Jcontent_Loader_OnLoadCompleteListener = interface(IJavaInstance)
    ['{C9E1065D-CEC5-4C51-BBFB-CEE633EADB45}']
    procedure onLoadComplete(loader: Jcontent_Loader; data: JObject); cdecl;
  end;
  TJcontent_Loader_OnLoadCompleteListener = class(TJavaGenericImport<Jcontent_Loader_OnLoadCompleteListenerClass, Jcontent_Loader_OnLoadCompleteListener>) end;

  JWakefulBroadcastReceiverClass = interface(JBroadcastReceiverClass)
    ['{DECFDD83-E88E-449A-8198-F539F905B2A8}']
    {class} function init: JWakefulBroadcastReceiver; cdecl;
    {class} function completeWakefulIntent(intent: JIntent): Boolean; cdecl;
    {class} function startWakefulService(context: JContext; intent: JIntent): JComponentName; cdecl;
  end;

  [JavaSignature('android/support/v4/content/WakefulBroadcastReceiver')]
  JWakefulBroadcastReceiver = interface(JBroadcastReceiver)
    ['{2B7CD6F2-EB86-4F3C-9BB7-804797C60B05}']
  end;
  TJWakefulBroadcastReceiver = class(TJavaGenericImport<JWakefulBroadcastReceiverClass, JWakefulBroadcastReceiver>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_Fragment', TypeInfo(Androidapi.JNI.Support.Japp_Fragment));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_Fragment_SavedState', TypeInfo(Androidapi.JNI.Support.Japp_Fragment_SavedState));
  TRegTypes.RegisterType('Androidapi.JNI.Support.JFragmentActivity', TypeInfo(Androidapi.JNI.Support.JFragmentActivity));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_FragmentManager', TypeInfo(Androidapi.JNI.Support.Japp_FragmentManager));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_FragmentManager_BackStackEntry', TypeInfo(Androidapi.JNI.Support.Japp_FragmentManager_BackStackEntry));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_FragmentManager_OnBackStackChangedListener', TypeInfo(Androidapi.JNI.Support.Japp_FragmentManager_OnBackStackChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_FragmentTransaction', TypeInfo(Androidapi.JNI.Support.Japp_FragmentTransaction));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_LoaderManager', TypeInfo(Androidapi.JNI.Support.Japp_LoaderManager));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Japp_LoaderManager_LoaderCallbacks', TypeInfo(Androidapi.JNI.Support.Japp_LoaderManager_LoaderCallbacks));
  TRegTypes.RegisterType('Androidapi.JNI.Support.JNotificationCompat_Builder', TypeInfo(Androidapi.JNI.Support.JNotificationCompat_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Support.JNotificationCompat_Style', TypeInfo(Androidapi.JNI.Support.JNotificationCompat_Style));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Jcontent_Loader', TypeInfo(Androidapi.JNI.Support.Jcontent_Loader));
  TRegTypes.RegisterType('Androidapi.JNI.Support.Jcontent_Loader_OnLoadCompleteListener', TypeInfo(Androidapi.JNI.Support.Jcontent_Loader_OnLoadCompleteListener));
  TRegTypes.RegisterType('Androidapi.JNI.Support.JWakefulBroadcastReceiver', TypeInfo(Androidapi.JNI.Support.JWakefulBroadcastReceiver));
end;

initialization
  RegisterTypes;
end.


