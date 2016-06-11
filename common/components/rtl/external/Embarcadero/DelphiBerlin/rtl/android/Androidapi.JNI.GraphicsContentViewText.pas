{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.GraphicsContentViewText;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util;

type
// ===== Forward declarations =====

  JAbstractThreadedSyncAdapter = interface;//android.content.AbstractThreadedSyncAdapter
  JActivityNotFoundException = interface;//android.content.ActivityNotFoundException
  JAsyncQueryHandler = interface;//android.content.AsyncQueryHandler
  JLoader = interface;//android.content.Loader
  JAsyncTaskLoader = interface;//android.content.AsyncTaskLoader
  JBroadcastReceiver = interface;//android.content.BroadcastReceiver
  JBroadcastReceiver_PendingResult = interface;//android.content.BroadcastReceiver$PendingResult
  JClipData = interface;//android.content.ClipData
  JClipData_Item = interface;//android.content.ClipData$Item
  JClipDescription = interface;//android.content.ClipDescription
  JClipboardManager = interface;//android.text.ClipboardManager
  Jcontent_ClipboardManager = interface;//android.content.ClipboardManager
  JClipboardManager_OnPrimaryClipChangedListener = interface;//android.content.ClipboardManager$OnPrimaryClipChangedListener
  JComponentCallbacks = interface;//android.content.ComponentCallbacks
  JComponentCallbacks2 = interface;//android.content.ComponentCallbacks2
  JComponentName = interface;//android.content.ComponentName
  JContentProvider = interface;//android.content.ContentProvider
  JContentProvider_PipeDataWriter = interface;//android.content.ContentProvider$PipeDataWriter
  JContentProviderClient = interface;//android.content.ContentProviderClient
  JContentProviderOperation = interface;//android.content.ContentProviderOperation
  JContentProviderOperation_Builder = interface;//android.content.ContentProviderOperation$Builder
  JContentProviderResult = interface;//android.content.ContentProviderResult
  JContentQueryMap = interface;//android.content.ContentQueryMap
  JContentResolver = interface;//android.content.ContentResolver
  JContentUris = interface;//android.content.ContentUris
  JContentValues = interface;//android.content.ContentValues
  JContext = interface;//android.content.Context
  JContextWrapper = interface;//android.content.ContextWrapper
  JCursorLoader = interface;//android.content.CursorLoader
  JDialogInterface = interface;//android.content.DialogInterface
  JDialogInterface_OnCancelListener = interface;//android.content.DialogInterface$OnCancelListener
  JDialogInterface_OnClickListener = interface;//android.content.DialogInterface$OnClickListener
  JDialogInterface_OnDismissListener = interface;//android.content.DialogInterface$OnDismissListener
  JDialogInterface_OnKeyListener = interface;//android.content.DialogInterface$OnKeyListener
  JDialogInterface_OnMultiChoiceClickListener = interface;//android.content.DialogInterface$OnMultiChoiceClickListener
  JDialogInterface_OnShowListener = interface;//android.content.DialogInterface$OnShowListener
  Jcontent_Entity = interface;//android.content.Entity
  JEntity_NamedContentValues = interface;//android.content.Entity$NamedContentValues
  JEntityIterator = interface;//android.content.EntityIterator
  JIntent = interface;//android.content.Intent
  JIntent_FilterComparison = interface;//android.content.Intent$FilterComparison
  JIntent_ShortcutIconResource = interface;//android.content.Intent$ShortcutIconResource
  JIntentFilter = interface;//android.content.IntentFilter
  JIntentFilter_AuthorityEntry = interface;//android.content.IntentFilter$AuthorityEntry
  JIntentFilter_MalformedMimeTypeException = interface;//android.content.IntentFilter$MalformedMimeTypeException
  JIntentSender = interface;//android.content.IntentSender
  JIntentSender_OnFinished = interface;//android.content.IntentSender$OnFinished
  JIntentSender_SendIntentException = interface;//android.content.IntentSender$SendIntentException
  JContentObserver = interface;//android.database.ContentObserver
  JLoader_ForceLoadContentObserver = interface;//android.content.Loader$ForceLoadContentObserver
  JLoader_OnLoadCanceledListener = interface;//android.content.Loader$OnLoadCanceledListener
  JLoader_OnLoadCompleteListener = interface;//android.content.Loader$OnLoadCompleteListener
  JMutableContextWrapper = interface;//android.content.MutableContextWrapper
  JOperationApplicationException = interface;//android.content.OperationApplicationException
  JPeriodicSync = interface;//android.content.PeriodicSync
  JReceiverCallNotAllowedException = interface;//android.content.ReceiverCallNotAllowedException
  JRestrictionEntry = interface;//android.content.RestrictionEntry
  JRestrictionsManager = interface;//android.content.RestrictionsManager
  JSearchRecentSuggestionsProvider = interface;//android.content.SearchRecentSuggestionsProvider
  JServiceConnection = interface;//android.content.ServiceConnection
  JSharedPreferences = interface;//android.content.SharedPreferences
  JSharedPreferences_Editor = interface;//android.content.SharedPreferences$Editor
  JSharedPreferences_OnSharedPreferenceChangeListener = interface;//android.content.SharedPreferences$OnSharedPreferenceChangeListener
  JSyncAdapterType = interface;//android.content.SyncAdapterType
  JSyncContext = interface;//android.content.SyncContext
  JSyncInfo = interface;//android.content.SyncInfo
  JSyncRequest = interface;//android.content.SyncRequest
  JSyncRequest_Builder = interface;//android.content.SyncRequest$Builder
  JSyncResult = interface;//android.content.SyncResult
  JSyncStats = interface;//android.content.SyncStats
  JSyncStatusObserver = interface;//android.content.SyncStatusObserver
  JUriMatcher = interface;//android.content.UriMatcher
  JUriPermission = interface;//android.content.UriPermission
  JPackageItemInfo = interface;//android.content.pm.PackageItemInfo
  JComponentInfo = interface;//android.content.pm.ComponentInfo
  JActivityInfo = interface;//android.content.pm.ActivityInfo
  JApplicationInfo = interface;//android.content.pm.ApplicationInfo
  JApplicationInfo_DisplayNameComparator = interface;//android.content.pm.ApplicationInfo$DisplayNameComparator
  JConfigurationInfo = interface;//android.content.pm.ConfigurationInfo
  JFeatureGroupInfo = interface;//android.content.pm.FeatureGroupInfo
  JFeatureInfo = interface;//android.content.pm.FeatureInfo
  JInstrumentationInfo = interface;//android.content.pm.InstrumentationInfo
  JLabeledIntent = interface;//android.content.pm.LabeledIntent
  JLauncherActivityInfo = interface;//android.content.pm.LauncherActivityInfo
  JLauncherApps = interface;//android.content.pm.LauncherApps
  JLauncherApps_Callback = interface;//android.content.pm.LauncherApps$Callback
  JPackageInfo = interface;//android.content.pm.PackageInfo
  JPackageInstaller = interface;//android.content.pm.PackageInstaller
  JPackageInstaller_Session = interface;//android.content.pm.PackageInstaller$Session
  JPackageInstaller_SessionCallback = interface;//android.content.pm.PackageInstaller$SessionCallback
  JPackageInstaller_SessionInfo = interface;//android.content.pm.PackageInstaller$SessionInfo
  JPackageInstaller_SessionParams = interface;//android.content.pm.PackageInstaller$SessionParams
  JPackageItemInfo_DisplayNameComparator = interface;//android.content.pm.PackageItemInfo$DisplayNameComparator
  JPackageManager = interface;//android.content.pm.PackageManager
  JPackageManager_NameNotFoundException = interface;//android.content.pm.PackageManager$NameNotFoundException
  JPackageStats = interface;//android.content.pm.PackageStats
  JPathPermission = interface;//android.content.pm.PathPermission
  JPermissionGroupInfo = interface;//android.content.pm.PermissionGroupInfo
  JPermissionInfo = interface;//android.content.pm.PermissionInfo
  JProviderInfo = interface;//android.content.pm.ProviderInfo
  JResolveInfo = interface;//android.content.pm.ResolveInfo
  JResolveInfo_DisplayNameComparator = interface;//android.content.pm.ResolveInfo$DisplayNameComparator
  JServiceInfo = interface;//android.content.pm.ServiceInfo
  JSignature = interface;//android.content.pm.Signature
  JAssetFileDescriptor = interface;//android.content.res.AssetFileDescriptor
  JAssetFileDescriptor_AutoCloseInputStream = interface;//android.content.res.AssetFileDescriptor$AutoCloseInputStream
  JAssetFileDescriptor_AutoCloseOutputStream = interface;//android.content.res.AssetFileDescriptor$AutoCloseOutputStream
  JAssetManager = interface;//android.content.res.AssetManager
  JAssetManager_AssetInputStream = interface;//android.content.res.AssetManager$AssetInputStream
  JColorStateList = interface;//android.content.res.ColorStateList
  JConfiguration = interface;//android.content.res.Configuration
  JObbInfo = interface;//android.content.res.ObbInfo
  JObbScanner = interface;//android.content.res.ObbScanner
  JResources = interface;//android.content.res.Resources
  JResources_NotFoundException = interface;//android.content.res.Resources$NotFoundException
  JResources_Theme = interface;//android.content.res.Resources$Theme
  JTypedArray = interface;//android.content.res.TypedArray
  JXmlResourceParser = interface;//android.content.res.XmlResourceParser
  JAbstractCursor = interface;//android.database.AbstractCursor
  JAbstractWindowedCursor = interface;//android.database.AbstractWindowedCursor
  Jdatabase_CharArrayBuffer = interface;//android.database.CharArrayBuffer
  JCursor = interface;//android.database.Cursor
  JSQLiteClosable = interface;//android.database.sqlite.SQLiteClosable
  JCursorWindow = interface;//android.database.CursorWindow
  JDataSetObserver = interface;//android.database.DataSetObserver
  JDatabaseErrorHandler = interface;//android.database.DatabaseErrorHandler
  JSQLiteCursorDriver = interface;//android.database.sqlite.SQLiteCursorDriver
  JSQLiteDatabase = interface;//android.database.sqlite.SQLiteDatabase
  JSQLiteDatabase_CursorFactory = interface;//android.database.sqlite.SQLiteDatabase$CursorFactory
  JSQLiteProgram = interface;//android.database.sqlite.SQLiteProgram
  JSQLiteQuery = interface;//android.database.sqlite.SQLiteQuery
  JSQLiteStatement = interface;//android.database.sqlite.SQLiteStatement
  JSQLiteTransactionListener = interface;//android.database.sqlite.SQLiteTransactionListener
  JXfermode = interface;//android.graphics.Xfermode
  JAvoidXfermode = interface;//android.graphics.AvoidXfermode
  JAvoidXfermode_Mode = interface;//android.graphics.AvoidXfermode$Mode
  JBitmap = interface;//android.graphics.Bitmap
  JBitmap_CompressFormat = interface;//android.graphics.Bitmap$CompressFormat
  JBitmap_Config = interface;//android.graphics.Bitmap$Config
  JBitmapFactory = interface;//android.graphics.BitmapFactory
  JBitmapFactory_Options = interface;//android.graphics.BitmapFactory$Options
  JBitmapRegionDecoder = interface;//android.graphics.BitmapRegionDecoder
  JShader = interface;//android.graphics.Shader
  JBitmapShader = interface;//android.graphics.BitmapShader
  JMaskFilter = interface;//android.graphics.MaskFilter
  JBlurMaskFilter = interface;//android.graphics.BlurMaskFilter
  JBlurMaskFilter_Blur = interface;//android.graphics.BlurMaskFilter$Blur
  Jgraphics_Camera = interface;//android.graphics.Camera
  JCanvas = interface;//android.graphics.Canvas
  JCanvas_EdgeType = interface;//android.graphics.Canvas$EdgeType
  JCanvas_VertexMode = interface;//android.graphics.Canvas$VertexMode
  JCanvasProperty = interface;//android.graphics.CanvasProperty
  JColor = interface;//android.graphics.Color
  JColorFilter = interface;//android.graphics.ColorFilter
  JColorMatrix = interface;//android.graphics.ColorMatrix
  JColorMatrixColorFilter = interface;//android.graphics.ColorMatrixColorFilter
  JPathEffect = interface;//android.graphics.PathEffect
  JComposePathEffect = interface;//android.graphics.ComposePathEffect
  JComposeShader = interface;//android.graphics.ComposeShader
  JCornerPathEffect = interface;//android.graphics.CornerPathEffect
  JDashPathEffect = interface;//android.graphics.DashPathEffect
  JDiscretePathEffect = interface;//android.graphics.DiscretePathEffect
  JDrawFilter = interface;//android.graphics.DrawFilter
  JEmbossMaskFilter = interface;//android.graphics.EmbossMaskFilter
  JImageFormat = interface;//android.graphics.ImageFormat
  Jgraphics_Interpolator = interface;//android.graphics.Interpolator
  JInterpolator_Result = interface;//android.graphics.Interpolator$Result
  JRasterizer = interface;//android.graphics.Rasterizer
  JLayerRasterizer = interface;//android.graphics.LayerRasterizer
  JLightingColorFilter = interface;//android.graphics.LightingColorFilter
  JLinearGradient = interface;//android.graphics.LinearGradient
  JMatrix = interface;//android.graphics.Matrix
  JMatrix_ScaleToFit = interface;//android.graphics.Matrix$ScaleToFit
  JMovie = interface;//android.graphics.Movie
  JNinePatch = interface;//android.graphics.NinePatch
  JOutline = interface;//android.graphics.Outline
  JPaint = interface;//android.graphics.Paint
  JPaint_Align = interface;//android.graphics.Paint$Align
  JPaint_Cap = interface;//android.graphics.Paint$Cap
  JPaint_FontMetrics = interface;//android.graphics.Paint$FontMetrics
  JPaint_FontMetricsInt = interface;//android.graphics.Paint$FontMetricsInt
  JPaint_Join = interface;//android.graphics.Paint$Join
  JPaint_Style = interface;//android.graphics.Paint$Style
  JPaintFlagsDrawFilter = interface;//android.graphics.PaintFlagsDrawFilter
  JPath = interface;//android.graphics.Path
  JPath_Direction = interface;//android.graphics.Path$Direction
  JPath_FillType = interface;//android.graphics.Path$FillType
  JPath_Op = interface;//android.graphics.Path$Op
  JPathDashPathEffect = interface;//android.graphics.PathDashPathEffect
  JPathDashPathEffect_Style = interface;//android.graphics.PathDashPathEffect$Style
  JPathMeasure = interface;//android.graphics.PathMeasure
  JPicture = interface;//android.graphics.Picture
  JPixelFormat = interface;//android.graphics.PixelFormat
  JPixelXorXfermode = interface;//android.graphics.PixelXorXfermode
  JPoint = interface;//android.graphics.Point
  JPointF = interface;//android.graphics.PointF
  JPorterDuff = interface;//android.graphics.PorterDuff
  JPorterDuff_Mode = interface;//android.graphics.PorterDuff$Mode
  JPorterDuffColorFilter = interface;//android.graphics.PorterDuffColorFilter
  JPorterDuffXfermode = interface;//android.graphics.PorterDuffXfermode
  JRadialGradient = interface;//android.graphics.RadialGradient
  JRect = interface;//android.graphics.Rect
  JRectF = interface;//android.graphics.RectF
  JRegion = interface;//android.graphics.Region
  JRegion_Op = interface;//android.graphics.Region$Op
  JRegionIterator = interface;//android.graphics.RegionIterator
  JShader_TileMode = interface;//android.graphics.Shader$TileMode
  JSumPathEffect = interface;//android.graphics.SumPathEffect
  JSurfaceTexture = interface;//android.graphics.SurfaceTexture
  JSurfaceTexture_OnFrameAvailableListener = interface;//android.graphics.SurfaceTexture$OnFrameAvailableListener
  JSurfaceTexture_OutOfResourcesException = interface;//android.graphics.SurfaceTexture$OutOfResourcesException
  JSweepGradient = interface;//android.graphics.SweepGradient
  JTypeface = interface;//android.graphics.Typeface
  JYuvImage = interface;//android.graphics.YuvImage
  JAnimatable = interface;//android.graphics.drawable.Animatable
  JAnimatable2 = interface;//android.graphics.drawable.Animatable2
  JAnimatable2_AnimationCallback = interface;//android.graphics.drawable.Animatable2$AnimationCallback
  JDrawable = interface;//android.graphics.drawable.Drawable
  JDrawableContainer = interface;//android.graphics.drawable.DrawableContainer
  JStateListDrawable = interface;//android.graphics.drawable.StateListDrawable
  JAnimatedStateListDrawable = interface;//android.graphics.drawable.AnimatedStateListDrawable
  JAnimatedVectorDrawable = interface;//android.graphics.drawable.AnimatedVectorDrawable
  JAnimationDrawable = interface;//android.graphics.drawable.AnimationDrawable
  JBitmapDrawable = interface;//android.graphics.drawable.BitmapDrawable
  JDrawableWrapper = interface;//android.graphics.drawable.DrawableWrapper
  JClipDrawable = interface;//android.graphics.drawable.ClipDrawable
  JColorDrawable = interface;//android.graphics.drawable.ColorDrawable
  JDrawable_Callback = interface;//android.graphics.drawable.Drawable$Callback
  JDrawable_ConstantState = interface;//android.graphics.drawable.Drawable$ConstantState
  JDrawableContainer_DrawableContainerState = interface;//android.graphics.drawable.DrawableContainer$DrawableContainerState
  JGradientDrawable = interface;//android.graphics.drawable.GradientDrawable
  JGradientDrawable_Orientation = interface;//android.graphics.drawable.GradientDrawable$Orientation
  JIcon = interface;//android.graphics.drawable.Icon
  JIcon_OnDrawableLoadedListener = interface;//android.graphics.drawable.Icon$OnDrawableLoadedListener
  JInsetDrawable = interface;//android.graphics.drawable.InsetDrawable
  JLayerDrawable = interface;//android.graphics.drawable.LayerDrawable
  JLevelListDrawable = interface;//android.graphics.drawable.LevelListDrawable
  JNinePatchDrawable = interface;//android.graphics.drawable.NinePatchDrawable
  JShapeDrawable = interface;//android.graphics.drawable.ShapeDrawable
  JPaintDrawable = interface;//android.graphics.drawable.PaintDrawable
  JPictureDrawable = interface;//android.graphics.drawable.PictureDrawable
  JRippleComponent_RenderNodeAnimatorSet = interface;//android.graphics.drawable.RippleComponent$RenderNodeAnimatorSet
  JRippleDrawable = interface;//android.graphics.drawable.RippleDrawable
  JRotateDrawable = interface;//android.graphics.drawable.RotateDrawable
  JScaleDrawable = interface;//android.graphics.drawable.ScaleDrawable
  JShapeDrawable_ShaderFactory = interface;//android.graphics.drawable.ShapeDrawable$ShaderFactory
  JTransitionDrawable = interface;//android.graphics.drawable.TransitionDrawable
  JVectorDrawable = interface;//android.graphics.drawable.VectorDrawable
  JShape = interface;//android.graphics.drawable.shapes.Shape
  JRectShape = interface;//android.graphics.drawable.shapes.RectShape
  JArcShape = interface;//android.graphics.drawable.shapes.ArcShape
  JOvalShape = interface;//android.graphics.drawable.shapes.OvalShape
  JPathShape = interface;//android.graphics.drawable.shapes.PathShape
  JRoundRectShape = interface;//android.graphics.drawable.shapes.RoundRectShape
  JPdfDocument = interface;//android.graphics.pdf.PdfDocument
  JPdfDocument_Page = interface;//android.graphics.pdf.PdfDocument$Page
  JPdfDocument_PageInfo = interface;//android.graphics.pdf.PdfDocument$PageInfo
  JPageInfo_Builder = interface;//android.graphics.pdf.PdfDocument$PageInfo$Builder
  JPdfRenderer = interface;//android.graphics.pdf.PdfRenderer
  JPdfRenderer_Page = interface;//android.graphics.pdf.PdfRenderer$Page
  JEditable = interface;//android.text.Editable
  JEditable_Factory = interface;//android.text.Editable$Factory
  JInputFilter = interface;//android.text.InputFilter
  JInputType = interface;//android.text.InputType
  JLayout = interface;//android.text.Layout
  JLayout_Alignment = interface;//android.text.Layout$Alignment
  JLayout_Directions = interface;//android.text.Layout$Directions
  JNoCopySpan = interface;//android.text.NoCopySpan
  JSpanned = interface;//android.text.Spanned
  JSpannable = interface;//android.text.Spannable
  JSpannable_Factory = interface;//android.text.Spannable$Factory
  JTextPaint = interface;//android.text.TextPaint
  JTextUtils_TruncateAt = interface;//android.text.TextUtils$TruncateAt
  JTextWatcher = interface;//android.text.TextWatcher
  JKeyListener = interface;//android.text.method.KeyListener
  JMovementMethod = interface;//android.text.method.MovementMethod
  JTransformationMethod = interface;//android.text.method.TransformationMethod
  JCharacterStyle = interface;//android.text.style.CharacterStyle
  JClickableSpan = interface;//android.text.style.ClickableSpan
  JTtsSpan = interface;//android.text.style.TtsSpan
  JURLSpan = interface;//android.text.style.URLSpan
  JActionMode = interface;//android.view.ActionMode
  JActionMode_Callback = interface;//android.view.ActionMode$Callback
  JActionProvider = interface;//android.view.ActionProvider
  JActionProvider_VisibilityListener = interface;//android.view.ActionProvider$VisibilityListener
  JMenu = interface;//android.view.Menu
  JContextMenu = interface;//android.view.ContextMenu
  JContextMenu_ContextMenuInfo = interface;//android.view.ContextMenu$ContextMenuInfo
  JContextThemeWrapper = interface;//android.view.ContextThemeWrapper
  JDisplay = interface;//android.view.Display
  JDisplay_Mode = interface;//android.view.Display$Mode
  JDisplayListCanvas = interface;//android.view.DisplayListCanvas
  JDragEvent = interface;//android.view.DragEvent
  JGestureDetector = interface;//android.view.GestureDetector
  JGestureDetector_OnContextClickListener = interface;//android.view.GestureDetector$OnContextClickListener
  JGestureDetector_OnDoubleTapListener = interface;//android.view.GestureDetector$OnDoubleTapListener
  JGestureDetector_OnGestureListener = interface;//android.view.GestureDetector$OnGestureListener
  JGestureDetector_SimpleOnGestureListener = interface;//android.view.GestureDetector$SimpleOnGestureListener
  JInputDevice = interface;//android.view.InputDevice
  JInputDevice_MotionRange = interface;//android.view.InputDevice$MotionRange
  JInputEvent = interface;//android.view.InputEvent
  JInputQueue = interface;//android.view.InputQueue
  JInputQueue_Callback = interface;//android.view.InputQueue$Callback
  JKeyCharacterMap = interface;//android.view.KeyCharacterMap
  JKeyCharacterMap_KeyData = interface;//android.view.KeyCharacterMap$KeyData
  JKeyEvent = interface;//android.view.KeyEvent
  JKeyEvent_Callback = interface;//android.view.KeyEvent$Callback
  JKeyEvent_DispatcherState = interface;//android.view.KeyEvent$DispatcherState
  JLayoutInflater = interface;//android.view.LayoutInflater
  JLayoutInflater_Factory = interface;//android.view.LayoutInflater$Factory
  JLayoutInflater_Factory2 = interface;//android.view.LayoutInflater$Factory2
  JLayoutInflater_Filter = interface;//android.view.LayoutInflater$Filter
  JMenuInflater = interface;//android.view.MenuInflater
  JMenuItem = interface;//android.view.MenuItem
  JMenuItem_OnActionExpandListener = interface;//android.view.MenuItem$OnActionExpandListener
  JMenuItem_OnMenuItemClickListener = interface;//android.view.MenuItem$OnMenuItemClickListener
  JMotionEvent = interface;//android.view.MotionEvent
  JMotionEvent_PointerCoords = interface;//android.view.MotionEvent$PointerCoords
  JMotionEvent_PointerProperties = interface;//android.view.MotionEvent$PointerProperties
  JRenderNode = interface;//android.view.RenderNode
  //JRenderNodeAnimator = interface;//android.view.RenderNodeAnimator
  JScaleGestureDetector = interface;//android.view.ScaleGestureDetector
  JScaleGestureDetector_OnScaleGestureListener = interface;//android.view.ScaleGestureDetector$OnScaleGestureListener
  JScaleGestureDetector_SimpleOnScaleGestureListener = interface;//android.view.ScaleGestureDetector$SimpleOnScaleGestureListener
  JSearchEvent = interface;//android.view.SearchEvent
  JSubMenu = interface;//android.view.SubMenu
  JSurface = interface;//android.view.Surface
  JSurfaceHolder = interface;//android.view.SurfaceHolder
  JSurfaceHolder_Callback = interface;//android.view.SurfaceHolder$Callback
  JSurfaceHolder_Callback2 = interface;//android.view.SurfaceHolder$Callback2
  JView = interface;//android.view.View
  JSurfaceView = interface;//android.view.SurfaceView
  JTouchDelegate = interface;//android.view.TouchDelegate
  JView_AccessibilityDelegate = interface;//android.view.View$AccessibilityDelegate
  JView_DragShadowBuilder = interface;//android.view.View$DragShadowBuilder
  JView_OnApplyWindowInsetsListener = interface;//android.view.View$OnApplyWindowInsetsListener
  JView_OnAttachStateChangeListener = interface;//android.view.View$OnAttachStateChangeListener
  JView_OnClickListener = interface;//android.view.View$OnClickListener
  JView_OnContextClickListener = interface;//android.view.View$OnContextClickListener
  JView_OnCreateContextMenuListener = interface;//android.view.View$OnCreateContextMenuListener
  JView_OnDragListener = interface;//android.view.View$OnDragListener
  JView_OnFocusChangeListener = interface;//android.view.View$OnFocusChangeListener
  JView_OnGenericMotionListener = interface;//android.view.View$OnGenericMotionListener
  JView_OnHoverListener = interface;//android.view.View$OnHoverListener
  JView_OnKeyListener = interface;//android.view.View$OnKeyListener
  JView_OnLayoutChangeListener = interface;//android.view.View$OnLayoutChangeListener
  JView_OnLongClickListener = interface;//android.view.View$OnLongClickListener
  JView_OnScrollChangeListener = interface;//android.view.View$OnScrollChangeListener
  JView_OnSystemUiVisibilityChangeListener = interface;//android.view.View$OnSystemUiVisibilityChangeListener
  JView_OnTouchListener = interface;//android.view.View$OnTouchListener
  JViewGroup = interface;//android.view.ViewGroup
  JViewGroup_LayoutParams = interface;//android.view.ViewGroup$LayoutParams
  JViewGroup_MarginLayoutParams = interface;//android.view.ViewGroup$MarginLayoutParams
  JViewGroup_OnHierarchyChangeListener = interface;//android.view.ViewGroup$OnHierarchyChangeListener
  JViewOverlay = interface;//android.view.ViewOverlay
  JViewGroupOverlay = interface;//android.view.ViewGroupOverlay
  JViewManager = interface;//android.view.ViewManager
  JViewOutlineProvider = interface;//android.view.ViewOutlineProvider
  JViewParent = interface;//android.view.ViewParent
  JViewPropertyAnimator = interface;//android.view.ViewPropertyAnimator
  JViewStructure = interface;//android.view.ViewStructure
  JViewTreeObserver = interface;//android.view.ViewTreeObserver
  JViewTreeObserver_OnDrawListener = interface;//android.view.ViewTreeObserver$OnDrawListener
  JViewTreeObserver_OnGlobalFocusChangeListener = interface;//android.view.ViewTreeObserver$OnGlobalFocusChangeListener
  JViewTreeObserver_OnGlobalLayoutListener = interface;//android.view.ViewTreeObserver$OnGlobalLayoutListener
  JViewTreeObserver_OnPreDrawListener = interface;//android.view.ViewTreeObserver$OnPreDrawListener
  JViewTreeObserver_OnScrollChangedListener = interface;//android.view.ViewTreeObserver$OnScrollChangedListener
  JViewTreeObserver_OnTouchModeChangeListener = interface;//android.view.ViewTreeObserver$OnTouchModeChangeListener
  JViewTreeObserver_OnWindowAttachListener = interface;//android.view.ViewTreeObserver$OnWindowAttachListener
  JViewTreeObserver_OnWindowFocusChangeListener = interface;//android.view.ViewTreeObserver$OnWindowFocusChangeListener
  JWindow = interface;//android.view.Window
  JWindow_Callback = interface;//android.view.Window$Callback
  JWindowId = interface;//android.view.WindowId
  JWindowId_FocusObserver = interface;//android.view.WindowId$FocusObserver
  JWindowInsets = interface;//android.view.WindowInsets
  JWindowManager = interface;//android.view.WindowManager
  JWindowManager_LayoutParams = interface;//android.view.WindowManager$LayoutParams
  JAccessibilityRecord = interface;//android.view.accessibility.AccessibilityRecord
  JAccessibilityEvent = interface;//android.view.accessibility.AccessibilityEvent
  JAccessibilityNodeInfo = interface;//android.view.accessibility.AccessibilityNodeInfo
  JAccessibilityNodeInfo_AccessibilityAction = interface;//android.view.accessibility.AccessibilityNodeInfo$AccessibilityAction
  JAccessibilityNodeInfo_CollectionInfo = interface;//android.view.accessibility.AccessibilityNodeInfo$CollectionInfo
  JAccessibilityNodeInfo_CollectionItemInfo = interface;//android.view.accessibility.AccessibilityNodeInfo$CollectionItemInfo
  JAccessibilityNodeInfo_RangeInfo = interface;//android.view.accessibility.AccessibilityNodeInfo$RangeInfo
  JAccessibilityNodeProvider = interface;//android.view.accessibility.AccessibilityNodeProvider
  JAccessibilityWindowInfo = interface;//android.view.accessibility.AccessibilityWindowInfo
  JAnimation = interface;//android.view.animation.Animation
  JAnimation_AnimationListener = interface;//android.view.animation.Animation$AnimationListener
  //JInterpolator = interface;//android.view.animation.Interpolator
  JLayoutAnimationController = interface;//android.view.animation.LayoutAnimationController
  JLayoutAnimationController_AnimationParameters = interface;//android.view.animation.LayoutAnimationController$AnimationParameters
  JTransformation = interface;//android.view.animation.Transformation
  JBaseInputConnection = interface;//android.view.inputmethod.BaseInputConnection
  JCompletionInfo = interface;//android.view.inputmethod.CompletionInfo
  JCorrectionInfo = interface;//android.view.inputmethod.CorrectionInfo
  JCursorAnchorInfo = interface;//android.view.inputmethod.CursorAnchorInfo
  JCursorAnchorInfo_Builder = interface;//android.view.inputmethod.CursorAnchorInfo$Builder
  JEditorInfo = interface;//android.view.inputmethod.EditorInfo
  JExtractedText = interface;//android.view.inputmethod.ExtractedText
  JExtractedTextRequest = interface;//android.view.inputmethod.ExtractedTextRequest
  JInputBinding = interface;//android.view.inputmethod.InputBinding
  JInputConnection = interface;//android.view.inputmethod.InputConnection
  JInputConnectionWrapper = interface;//android.view.inputmethod.InputConnectionWrapper
  JInputMethod = interface;//android.view.inputmethod.InputMethod
  JInputMethod_SessionCallback = interface;//android.view.inputmethod.InputMethod$SessionCallback
  JInputMethodInfo = interface;//android.view.inputmethod.InputMethodInfo
  JInputMethodManager = interface;//android.view.inputmethod.InputMethodManager
  JInputMethodSession = interface;//android.view.inputmethod.InputMethodSession
  JInputMethodSession_EventCallback = interface;//android.view.inputmethod.InputMethodSession$EventCallback
  JInputMethodSubtype = interface;//android.view.inputmethod.InputMethodSubtype
  JInputMethodSubtype_InputMethodSubtypeBuilder = interface;//android.view.inputmethod.InputMethodSubtype$InputMethodSubtypeBuilder

// ===== Interface declarations =====

  JAbstractThreadedSyncAdapterClass = interface(JObjectClass)
    ['{84F624CB-6DD0-43C4-B565-646C373BA09D}']
    {class} function _GetLOG_SYNC_DETAILS: Integer; cdecl;
    {class} function init(context: JContext; autoInitialize: Boolean): JAbstractThreadedSyncAdapter; cdecl; overload;
    {class} function init(context: JContext; autoInitialize: Boolean; allowParallelSyncs: Boolean): JAbstractThreadedSyncAdapter; cdecl; overload;
    {class} property LOG_SYNC_DETAILS: Integer read _GetLOG_SYNC_DETAILS;
  end;

  [JavaSignature('android/content/AbstractThreadedSyncAdapter')]
  JAbstractThreadedSyncAdapter = interface(JObject)
    ['{15B35E75-7646-4F1A-B0FD-8F5CCD9D52CE}']
    function getContext: JContext; cdecl;
    function getSyncAdapterBinder: JIBinder; cdecl;
    //procedure onPerformSync(account: JAccount; extras: JBundle; authority: JString; provider: JContentProviderClient; syncResult: JSyncResult); cdecl;
    //procedure onSecurityException(account: JAccount; extras: JBundle; authority: JString; syncResult: JSyncResult); cdecl;
    procedure onSyncCanceled; cdecl; overload;
    procedure onSyncCanceled(thread: JThread); cdecl; overload;
  end;
  TJAbstractThreadedSyncAdapter = class(TJavaGenericImport<JAbstractThreadedSyncAdapterClass, JAbstractThreadedSyncAdapter>) end;

  JActivityNotFoundExceptionClass = interface(JRuntimeExceptionClass)
    ['{073EE9FA-3FED-43AD-8BE6-5DBD8A50D3DF}']
    {class} function init: JActivityNotFoundException; cdecl; overload;
    {class} function init(name: JString): JActivityNotFoundException; cdecl; overload;
  end;

  [JavaSignature('android/content/ActivityNotFoundException')]
  JActivityNotFoundException = interface(JRuntimeException)
    ['{87851F6B-1234-4A5C-8C94-3B6E101B90A9}']
  end;
  TJActivityNotFoundException = class(TJavaGenericImport<JActivityNotFoundExceptionClass, JActivityNotFoundException>) end;

  JAsyncQueryHandlerClass = interface(JHandlerClass)
    ['{DCE5CC9D-9176-4C35-9776-4AAD65F610DE}']
    {class} function init(cr: JContentResolver): JAsyncQueryHandler; cdecl;
  end;

  [JavaSignature('android/content/AsyncQueryHandler')]
  JAsyncQueryHandler = interface(JHandler)
    ['{82729BB8-F6CC-4636-A1F9-736EA8141F63}']
    procedure cancelOperation(token: Integer); cdecl;
    procedure handleMessage(msg: JMessage); cdecl;
    procedure startDelete(token: Integer; cookie: JObject; uri: Jnet_Uri; selection: JString; selectionArgs: TJavaObjectArray<JString>); cdecl;
    procedure startInsert(token: Integer; cookie: JObject; uri: Jnet_Uri; initialValues: JContentValues); cdecl;
    procedure startQuery(token: Integer; cookie: JObject; uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; orderBy: JString); cdecl;
    procedure startUpdate(token: Integer; cookie: JObject; uri: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>); cdecl;
  end;
  TJAsyncQueryHandler = class(TJavaGenericImport<JAsyncQueryHandlerClass, JAsyncQueryHandler>) end;

  JLoaderClass = interface(JObjectClass)
    ['{3579AEB2-2950-4D22-B62F-8FE4EAEDDD5D}']
    {class} function init(context: JContext): JLoader; cdecl;
  end;

  [JavaSignature('android/content/Loader')]
  JLoader = interface(JObject)
    ['{57E129AA-1B42-4642-A3AF-08E4EB94EE0D}']
    procedure abandon; cdecl;
    function cancelLoad: Boolean; cdecl;
    procedure commitContentChanged; cdecl;
    function dataToString(data: JObject): JString; cdecl;
    procedure deliverCancellation; cdecl;
    procedure deliverResult(data: JObject); cdecl;
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    procedure forceLoad; cdecl;
    function getContext: JContext; cdecl;
    function getId: Integer; cdecl;
    function isAbandoned: Boolean; cdecl;
    function isReset: Boolean; cdecl;
    function isStarted: Boolean; cdecl;
    procedure onContentChanged; cdecl;
    procedure registerListener(id: Integer; listener: JLoader_OnLoadCompleteListener); cdecl;
    procedure registerOnLoadCanceledListener(listener: JLoader_OnLoadCanceledListener); cdecl;
    procedure reset; cdecl;
    procedure rollbackContentChanged; cdecl;
    procedure startLoading; cdecl;
    procedure stopLoading; cdecl;
    function takeContentChanged: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure unregisterListener(listener: JLoader_OnLoadCompleteListener); cdecl;
    procedure unregisterOnLoadCanceledListener(listener: JLoader_OnLoadCanceledListener); cdecl;
  end;
  TJLoader = class(TJavaGenericImport<JLoaderClass, JLoader>) end;

  JAsyncTaskLoaderClass = interface(JLoaderClass)
    ['{A062D485-BEC3-4495-9879-3A7C567EE29F}']
    {class} function init(context: JContext): JAsyncTaskLoader; cdecl;
  end;

  [JavaSignature('android/content/AsyncTaskLoader')]
  JAsyncTaskLoader = interface(JLoader)
    ['{B9A48AE1-A477-4851-A889-06A23B999FF2}']
    procedure cancelLoadInBackground; cdecl;
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function isLoadInBackgroundCanceled: Boolean; cdecl;
    function loadInBackground: JObject; cdecl;
    procedure onCanceled(data: JObject); cdecl;
    procedure setUpdateThrottle(delayMS: Int64); cdecl;
  end;
  TJAsyncTaskLoader = class(TJavaGenericImport<JAsyncTaskLoaderClass, JAsyncTaskLoader>) end;

  JBroadcastReceiverClass = interface(JObjectClass)
    ['{633E207B-4483-4EB5-B2B1-C7830A2237A9}']
    {class} function init: JBroadcastReceiver; cdecl;
  end;

  [JavaSignature('android/content/BroadcastReceiver')]
  JBroadcastReceiver = interface(JObject)
    ['{32FE5004-DE3B-4733-98E2-A37B87A6F663}']
    procedure abortBroadcast; cdecl;
    procedure clearAbortBroadcast; cdecl;
    function getAbortBroadcast: Boolean; cdecl;
    function getDebugUnregister: Boolean; cdecl;
    function getResultCode: Integer; cdecl;
    function getResultData: JString; cdecl;
    function getResultExtras(makeMap: Boolean): JBundle; cdecl;
    function goAsync: JBroadcastReceiver_PendingResult; cdecl;
    function isInitialStickyBroadcast: Boolean; cdecl;
    function isOrderedBroadcast: Boolean; cdecl;
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
    function peekService(myContext: JContext; service: JIntent): JIBinder; cdecl;
    procedure setDebugUnregister(debug: Boolean); cdecl;
    procedure setOrderedHint(isOrdered: Boolean); cdecl;
    procedure setResult(code: Integer; data: JString; extras: JBundle); cdecl;
    procedure setResultCode(code: Integer); cdecl;
    procedure setResultData(data: JString); cdecl;
    procedure setResultExtras(extras: JBundle); cdecl;
  end;
  TJBroadcastReceiver = class(TJavaGenericImport<JBroadcastReceiverClass, JBroadcastReceiver>) end;

  JBroadcastReceiver_PendingResultClass = interface(JObjectClass)
    ['{41EB4E26-FA55-4428-819D-0C56DC11596B}']
  end;

  [JavaSignature('android/content/BroadcastReceiver$PendingResult')]
  JBroadcastReceiver_PendingResult = interface(JObject)
    ['{8F52DCF6-7EEC-4EBA-8A4D-A1DE293A1A41}']
    procedure abortBroadcast; cdecl;
    procedure clearAbortBroadcast; cdecl;
    procedure finish; cdecl;
    function getAbortBroadcast: Boolean; cdecl;
    function getResultCode: Integer; cdecl;
    function getResultData: JString; cdecl;
    function getResultExtras(makeMap: Boolean): JBundle; cdecl;
    procedure setResult(code: Integer; data: JString; extras: JBundle); cdecl;
    procedure setResultCode(code: Integer); cdecl;
    procedure setResultData(data: JString); cdecl;
    procedure setResultExtras(extras: JBundle); cdecl;
  end;
  TJBroadcastReceiver_PendingResult = class(TJavaGenericImport<JBroadcastReceiver_PendingResultClass, JBroadcastReceiver_PendingResult>) end;

  JClipDataClass = interface(JObjectClass)
    ['{350C6650-0BF9-4608-A3E8-A083C5ED4543}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(label_: JCharSequence; mimeTypes: TJavaObjectArray<JString>; item: JClipData_Item): JClipData; cdecl; overload;
    {class} function init(description: JClipDescription; item: JClipData_Item): JClipData; cdecl; overload;
    {class} function init(other: JClipData): JClipData; cdecl; overload;
    {class} function newHtmlText(label_: JCharSequence; text: JCharSequence; htmlText: JString): JClipData; cdecl;
    {class} function newIntent(label_: JCharSequence; intent: JIntent): JClipData; cdecl;
    {class} function newPlainText(label_: JCharSequence; text: JCharSequence): JClipData; cdecl;
    {class} function newRawUri(label_: JCharSequence; uri: Jnet_Uri): JClipData; cdecl;
    {class} function newUri(resolver: JContentResolver; label_: JCharSequence; uri: Jnet_Uri): JClipData; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/ClipData')]
  JClipData = interface(JObject)
    ['{C2884715-49ED-4BFE-BCE3-204FD4DAA417}']
    procedure addItem(item: JClipData_Item); cdecl;
    function describeContents: Integer; cdecl;
    function getDescription: JClipDescription; cdecl;
    function getItemAt(index: Integer): JClipData_Item; cdecl;
    function getItemCount: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJClipData = class(TJavaGenericImport<JClipDataClass, JClipData>) end;

  JClipData_ItemClass = interface(JObjectClass)
    ['{FC99163D-9B5D-4F25-BBE0-7C05AE05D5E2}']
    {class} function init(text: JCharSequence): JClipData_Item; cdecl; overload;
    {class} function init(text: JCharSequence; htmlText: JString): JClipData_Item; cdecl; overload;
    {class} function init(intent: JIntent): JClipData_Item; cdecl; overload;
    {class} function init(uri: Jnet_Uri): JClipData_Item; cdecl; overload;
    {class} function init(text: JCharSequence; intent: JIntent; uri: Jnet_Uri): JClipData_Item; cdecl; overload;
    {class} function init(text: JCharSequence; htmlText: JString; intent: JIntent; uri: Jnet_Uri): JClipData_Item; cdecl; overload;
  end;

  [JavaSignature('android/content/ClipData$Item')]
  JClipData_Item = interface(JObject)
    ['{CC198ECA-644C-456A-8065-E00F54D3EDE1}']
    function coerceToHtmlText(context: JContext): JString; cdecl;
    function coerceToStyledText(context: JContext): JCharSequence; cdecl;
    function coerceToText(context: JContext): JCharSequence; cdecl;
    function getHtmlText: JString; cdecl;
    function getIntent: JIntent; cdecl;
    function getText: JCharSequence; cdecl;
    function getUri: Jnet_Uri; cdecl;
    function toString: JString; cdecl;
  end;
  TJClipData_Item = class(TJavaGenericImport<JClipData_ItemClass, JClipData_Item>) end;

  JClipDescriptionClass = interface(JObjectClass)
    ['{6C6FB2F7-7FDB-4625-8C43-3663387476D5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetMIMETYPE_TEXT_HTML: JString; cdecl;
    {class} function _GetMIMETYPE_TEXT_INTENT: JString; cdecl;
    {class} function _GetMIMETYPE_TEXT_PLAIN: JString; cdecl;
    {class} function _GetMIMETYPE_TEXT_URILIST: JString; cdecl;
    {class} function init(label_: JCharSequence; mimeTypes: TJavaObjectArray<JString>): JClipDescription; cdecl; overload;
    {class} function init(o: JClipDescription): JClipDescription; cdecl; overload;
    {class} function compareMimeTypes(concreteType: JString; desiredType: JString): Boolean; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property MIMETYPE_TEXT_HTML: JString read _GetMIMETYPE_TEXT_HTML;
    {class} property MIMETYPE_TEXT_INTENT: JString read _GetMIMETYPE_TEXT_INTENT;
    {class} property MIMETYPE_TEXT_PLAIN: JString read _GetMIMETYPE_TEXT_PLAIN;
    {class} property MIMETYPE_TEXT_URILIST: JString read _GetMIMETYPE_TEXT_URILIST;
  end;

  [JavaSignature('android/content/ClipDescription')]
  JClipDescription = interface(JObject)
    ['{BA87A0BC-6174-460C-BA29-521BC4824920}']
    function describeContents: Integer; cdecl;
    function filterMimeTypes(mimeType: JString): TJavaObjectArray<JString>; cdecl;
    function getLabel: JCharSequence; cdecl;
    function getMimeType(index: Integer): JString; cdecl;
    function getMimeTypeCount: Integer; cdecl;
    function hasMimeType(mimeType: JString): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJClipDescription = class(TJavaGenericImport<JClipDescriptionClass, JClipDescription>) end;

  JClipboardManagerClass = interface(JObjectClass)
    ['{CA54A5DE-6509-4DC9-89C6-CF1D6009466E}']
    {class} function init: JClipboardManager; cdecl;
  end;

  [JavaSignature('android/text/ClipboardManager')]
  JClipboardManager = interface(JObject)
    ['{0053FEAD-CD66-4FA9-934F-02AD63669797}']
    function getText: JCharSequence; cdecl;
    function hasText: Boolean; cdecl;
    procedure setText(text: JCharSequence); cdecl;
  end;
  TJClipboardManager = class(TJavaGenericImport<JClipboardManagerClass, JClipboardManager>) end;

  Jcontent_ClipboardManagerClass = interface(JClipboardManagerClass)
    ['{45DFEA1B-074F-4A1A-8CFF-8E8E5F13A36F}']
  end;

  [JavaSignature('android/content/ClipboardManager')]
  Jcontent_ClipboardManager = interface(JClipboardManager)
    ['{4A648B9F-6FF6-4F14-BEC0-03F29E9BD84B}']
    procedure addPrimaryClipChangedListener(what: JClipboardManager_OnPrimaryClipChangedListener); cdecl;
    function getPrimaryClip: JClipData; cdecl;
    function getPrimaryClipDescription: JClipDescription; cdecl;
    function getText: JCharSequence; cdecl;//Deprecated
    function hasPrimaryClip: Boolean; cdecl;
    function hasText: Boolean; cdecl;//Deprecated
    procedure removePrimaryClipChangedListener(what: JClipboardManager_OnPrimaryClipChangedListener); cdecl;
    procedure setPrimaryClip(clip: JClipData); cdecl;
    procedure setText(text: JCharSequence); cdecl;//Deprecated
  end;
  TJcontent_ClipboardManager = class(TJavaGenericImport<Jcontent_ClipboardManagerClass, Jcontent_ClipboardManager>) end;

  JClipboardManager_OnPrimaryClipChangedListenerClass = interface(IJavaClass)
    ['{3EC09394-C7F1-4DB3-A7C1-F9D274F8DEEC}']
  end;

  [JavaSignature('android/content/ClipboardManager$OnPrimaryClipChangedListener')]
  JClipboardManager_OnPrimaryClipChangedListener = interface(IJavaInstance)
    ['{A4F0CC5D-0887-4114-A38E-160C75FD198F}']
    procedure onPrimaryClipChanged; cdecl;
  end;
  TJClipboardManager_OnPrimaryClipChangedListener = class(TJavaGenericImport<JClipboardManager_OnPrimaryClipChangedListenerClass, JClipboardManager_OnPrimaryClipChangedListener>) end;

  JComponentCallbacksClass = interface(IJavaClass)
    ['{916F97DB-E2D9-44BA-A88B-A9636A3381B5}']
  end;

  [JavaSignature('android/content/ComponentCallbacks')]
  JComponentCallbacks = interface(IJavaInstance)
    ['{A878B465-4CD0-4210-A990-5B05CE38A99F}']
    procedure onConfigurationChanged(newConfig: JConfiguration); cdecl;
    procedure onLowMemory; cdecl;
  end;
  TJComponentCallbacks = class(TJavaGenericImport<JComponentCallbacksClass, JComponentCallbacks>) end;

  JComponentCallbacks2Class = interface(JComponentCallbacksClass)
    ['{A16878C7-9C07-4346-BB24-8ADC7D943B48}']
    {class} function _GetTRIM_MEMORY_BACKGROUND: Integer; cdecl;
    {class} function _GetTRIM_MEMORY_COMPLETE: Integer; cdecl;
    {class} function _GetTRIM_MEMORY_MODERATE: Integer; cdecl;
    {class} function _GetTRIM_MEMORY_RUNNING_CRITICAL: Integer; cdecl;
    {class} function _GetTRIM_MEMORY_RUNNING_LOW: Integer; cdecl;
    {class} function _GetTRIM_MEMORY_RUNNING_MODERATE: Integer; cdecl;
    {class} function _GetTRIM_MEMORY_UI_HIDDEN: Integer; cdecl;
    {class} property TRIM_MEMORY_BACKGROUND: Integer read _GetTRIM_MEMORY_BACKGROUND;
    {class} property TRIM_MEMORY_COMPLETE: Integer read _GetTRIM_MEMORY_COMPLETE;
    {class} property TRIM_MEMORY_MODERATE: Integer read _GetTRIM_MEMORY_MODERATE;
    {class} property TRIM_MEMORY_RUNNING_CRITICAL: Integer read _GetTRIM_MEMORY_RUNNING_CRITICAL;
    {class} property TRIM_MEMORY_RUNNING_LOW: Integer read _GetTRIM_MEMORY_RUNNING_LOW;
    {class} property TRIM_MEMORY_RUNNING_MODERATE: Integer read _GetTRIM_MEMORY_RUNNING_MODERATE;
    {class} property TRIM_MEMORY_UI_HIDDEN: Integer read _GetTRIM_MEMORY_UI_HIDDEN;
  end;

  [JavaSignature('android/content/ComponentCallbacks2')]
  JComponentCallbacks2 = interface(JComponentCallbacks)
    ['{2D389328-9C3F-44D8-8D5A-B124D8E5C5C5}']
    procedure onTrimMemory(level: Integer); cdecl;
  end;
  TJComponentCallbacks2 = class(TJavaGenericImport<JComponentCallbacks2Class, JComponentCallbacks2>) end;

  JComponentNameClass = interface(JObjectClass)
    ['{299BEF02-1270-416B-8F7C-657B0F7F8873}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(pkg: JString; cls: JString): JComponentName; cdecl; overload;
    {class} function init(pkg: JContext; cls: JString): JComponentName; cdecl; overload;
    {class} function init(pkg: JContext; cls: Jlang_Class): JComponentName; cdecl; overload;
    {class} function init(in_: JParcel): JComponentName; cdecl; overload;
    {class} function createRelative(pkg: JString; cls: JString): JComponentName; cdecl; overload;
    {class} function createRelative(pkg: JContext; cls: JString): JComponentName; cdecl; overload;
    {class} function readFromParcel(in_: JParcel): JComponentName; cdecl;
    {class} function unflattenFromString(str: JString): JComponentName; cdecl;
    {class} procedure writeToParcel(c: JComponentName; out_: JParcel); cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/ComponentName')]
  JComponentName = interface(JObject)
    ['{D5059D73-4735-465B-958D-E552E5534EA3}']
    function clone: JComponentName; cdecl;
    function compareTo(that: JComponentName): Integer; cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function flattenToShortString: JString; cdecl;
    function flattenToString: JString; cdecl;
    function getClassName: JString; cdecl;
    function getPackageName: JString; cdecl;
    function getShortClassName: JString; cdecl;
    function hashCode: Integer; cdecl;
    function toShortString: JString; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl; overload;
  end;
  TJComponentName = class(TJavaGenericImport<JComponentNameClass, JComponentName>) end;

  JContentProviderClass = interface(JObjectClass)
    ['{8EE3C773-05FF-43F9-9258-8DEF6555223E}']
    {class} function init: JContentProvider; cdecl;
  end;

  [JavaSignature('android/content/ContentProvider')]
  JContentProvider = interface(JObject)
    ['{F0B401FB-B195-4776-B2F6-0723D8BF8A06}']
    function applyBatch(operations: JArrayList): TJavaObjectArray<JContentProviderResult>; cdecl;
    procedure attachInfo(context: JContext; info: JProviderInfo); cdecl;
    function bulkInsert(uri: Jnet_Uri; values: TJavaObjectArray<JContentValues>): Integer; cdecl;
    function call(method: JString; arg: JString; extras: JBundle): JBundle; cdecl;
    function canonicalize(url: Jnet_Uri): Jnet_Uri; cdecl;
    function delete(uri: Jnet_Uri; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
    procedure dump(fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function getCallingPackage: JString; cdecl;
    function getContext: JContext; cdecl;
    function getPathPermissions: TJavaObjectArray<JPathPermission>; cdecl;
    function getReadPermission: JString; cdecl;
    function getStreamTypes(uri: Jnet_Uri; mimeTypeFilter: JString): TJavaObjectArray<JString>; cdecl;
    function getType(uri: Jnet_Uri): JString; cdecl;
    function getWritePermission: JString; cdecl;
    function insert(uri: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    procedure onConfigurationChanged(newConfig: JConfiguration); cdecl;
    function onCreate: Boolean; cdecl;
    procedure onLowMemory; cdecl;
    procedure onTrimMemory(level: Integer); cdecl;
    function openAssetFile(uri: Jnet_Uri; mode: JString): JAssetFileDescriptor; cdecl; overload;
    function openAssetFile(uri: Jnet_Uri; mode: JString; signal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function openFile(uri: Jnet_Uri; mode: JString): JParcelFileDescriptor; cdecl; overload;
    function openFile(uri: Jnet_Uri; mode: JString; signal: JCancellationSignal): JParcelFileDescriptor; cdecl; overload;
    function openPipeHelper(uri: Jnet_Uri; mimeType: JString; opts: JBundle; args: JObject; func: JContentProvider_PipeDataWriter): JParcelFileDescriptor; cdecl;
    function openTypedAssetFile(uri: Jnet_Uri; mimeTypeFilter: JString; opts: JBundle): JAssetFileDescriptor; cdecl; overload;
    function openTypedAssetFile(uri: Jnet_Uri; mimeTypeFilter: JString; opts: JBundle; signal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl; overload;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    procedure shutdown; cdecl;
    function uncanonicalize(url: Jnet_Uri): Jnet_Uri; cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJContentProvider = class(TJavaGenericImport<JContentProviderClass, JContentProvider>) end;

  JContentProvider_PipeDataWriterClass = interface(IJavaClass)
    ['{885A1239-1EE5-40A1-A053-EA283661D1BC}']
  end;

  [JavaSignature('android/content/ContentProvider$PipeDataWriter')]
  JContentProvider_PipeDataWriter = interface(IJavaInstance)
    ['{ABFB532E-1496-4099-85DB-E9099B6BAAEA}']
    procedure writeDataToPipe(output: JParcelFileDescriptor; uri: Jnet_Uri; mimeType: JString; opts: JBundle; args: JObject); cdecl;
  end;
  TJContentProvider_PipeDataWriter = class(TJavaGenericImport<JContentProvider_PipeDataWriterClass, JContentProvider_PipeDataWriter>) end;

  JContentProviderClientClass = interface(JObjectClass)
    ['{E35B7920-67B1-4ED4-A635-9E3E96A27413}']
  end;

  [JavaSignature('android/content/ContentProviderClient')]
  JContentProviderClient = interface(JObject)
    ['{3D01ECDB-0FC3-4949-A3C1-53A6A100582F}']
    function applyBatch(operations: JArrayList): TJavaObjectArray<JContentProviderResult>; cdecl;
    function bulkInsert(url: Jnet_Uri; initialValues: TJavaObjectArray<JContentValues>): Integer; cdecl;
    function call(method: JString; arg: JString; extras: JBundle): JBundle; cdecl;
    function canonicalize(url: Jnet_Uri): Jnet_Uri; cdecl;
    function delete(url: Jnet_Uri; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
    function getLocalContentProvider: JContentProvider; cdecl;
    function getStreamTypes(url: Jnet_Uri; mimeTypeFilter: JString): TJavaObjectArray<JString>; cdecl;
    function getType(url: Jnet_Uri): JString; cdecl;
    function insert(url: Jnet_Uri; initialValues: JContentValues): Jnet_Uri; cdecl;
    function openAssetFile(url: Jnet_Uri; mode: JString): JAssetFileDescriptor; cdecl; overload;
    function openAssetFile(url: Jnet_Uri; mode: JString; signal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function openFile(url: Jnet_Uri; mode: JString): JParcelFileDescriptor; cdecl; overload;
    function openFile(url: Jnet_Uri; mode: JString; signal: JCancellationSignal): JParcelFileDescriptor; cdecl; overload;
    function openTypedAssetFileDescriptor(uri: Jnet_Uri; mimeType: JString; opts: JBundle): JAssetFileDescriptor; cdecl; overload;
    function openTypedAssetFileDescriptor(uri: Jnet_Uri; mimeType: JString; opts: JBundle; signal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function query(url: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl; overload;
    function query(url: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    function release: Boolean; cdecl;
    function uncanonicalize(url: Jnet_Uri): Jnet_Uri; cdecl;
    function update(url: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJContentProviderClient = class(TJavaGenericImport<JContentProviderClientClass, JContentProviderClient>) end;

  JContentProviderOperationClass = interface(JObjectClass)
    ['{07D5CC7B-D9E7-4BE4-ACDC-0452935B5D93}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newAssertQuery(uri: Jnet_Uri): JContentProviderOperation_Builder; cdecl;
    {class} function newDelete(uri: Jnet_Uri): JContentProviderOperation_Builder; cdecl;
    {class} function newInsert(uri: Jnet_Uri): JContentProviderOperation_Builder; cdecl;
    {class} function newUpdate(uri: Jnet_Uri): JContentProviderOperation_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/ContentProviderOperation')]
  JContentProviderOperation = interface(JObject)
    ['{48EB1D9B-DB88-447D-A009-3FA8B16CB6F8}']
    function apply(provider: JContentProvider; backRefs: TJavaObjectArray<JContentProviderResult>; numBackRefs: Integer): JContentProviderResult; cdecl;
    function describeContents: Integer; cdecl;
    function getUri: Jnet_Uri; cdecl;
    function isAssertQuery: Boolean; cdecl;
    function isDelete: Boolean; cdecl;
    function isInsert: Boolean; cdecl;
    function isReadOperation: Boolean; cdecl;
    function isUpdate: Boolean; cdecl;
    function isWriteOperation: Boolean; cdecl;
    function isYieldAllowed: Boolean; cdecl;
    function resolveSelectionArgsBackReferences(backRefs: TJavaObjectArray<JContentProviderResult>; numBackRefs: Integer): TJavaObjectArray<JString>; cdecl;
    function resolveValueBackReferences(backRefs: TJavaObjectArray<JContentProviderResult>; numBackRefs: Integer): JContentValues; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJContentProviderOperation = class(TJavaGenericImport<JContentProviderOperationClass, JContentProviderOperation>) end;

  JContentProviderOperation_BuilderClass = interface(JObjectClass)
    ['{ECA2D315-FD5C-4271-856B-768CAE25888A}']
  end;

  [JavaSignature('android/content/ContentProviderOperation$Builder')]
  JContentProviderOperation_Builder = interface(JObject)
    ['{29CFAD81-EBF2-4FAD-91B9-21A28868A58E}']
    function build: JContentProviderOperation; cdecl;
    function withExpectedCount(count: Integer): JContentProviderOperation_Builder; cdecl;
    function withSelection(selection: JString; selectionArgs: TJavaObjectArray<JString>): JContentProviderOperation_Builder; cdecl;
    function withSelectionBackReference(selectionArgIndex: Integer; previousResult: Integer): JContentProviderOperation_Builder; cdecl;
    function withValue(key: JString; value: JObject): JContentProviderOperation_Builder; cdecl;
    function withValueBackReference(key: JString; previousResult: Integer): JContentProviderOperation_Builder; cdecl;
    function withValueBackReferences(backReferences: JContentValues): JContentProviderOperation_Builder; cdecl;
    function withValues(values: JContentValues): JContentProviderOperation_Builder; cdecl;
    function withYieldAllowed(yieldAllowed: Boolean): JContentProviderOperation_Builder; cdecl;
  end;
  TJContentProviderOperation_Builder = class(TJavaGenericImport<JContentProviderOperation_BuilderClass, JContentProviderOperation_Builder>) end;

  JContentProviderResultClass = interface(JObjectClass)
    ['{0D9801F6-6AC7-41F4-B54B-1B3AFFDFCCEB}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(uri: Jnet_Uri): JContentProviderResult; cdecl; overload;
    {class} function init(count: Integer): JContentProviderResult; cdecl; overload;
    {class} function init(source: JParcel): JContentProviderResult; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/ContentProviderResult')]
  JContentProviderResult = interface(JObject)
    ['{675498D2-9DDF-489E-9B8B-C41CEACF829E}']
    function _Getcount: JInteger; cdecl;
    function _Geturi: Jnet_Uri; cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property count: JInteger read _Getcount;
    property uri: Jnet_Uri read _Geturi;
  end;
  TJContentProviderResult = class(TJavaGenericImport<JContentProviderResultClass, JContentProviderResult>) end;

  JContentQueryMapClass = interface(Jutil_ObservableClass)
    ['{61DB2504-CA86-4425-B750-B1D54AF83693}']
    {class} function init(cursor: JCursor; columnNameOfKey: JString; keepUpdated: Boolean; handlerForUpdateNotifications: JHandler): JContentQueryMap; cdecl;
  end;

  [JavaSignature('android/content/ContentQueryMap')]
  JContentQueryMap = interface(Jutil_Observable)
    ['{4DE3BCB2-9904-4CD9-B9E0-31D7B312AA4E}']
    procedure close; cdecl;
    function getRows: JMap; cdecl;
    function getValues(rowName: JString): JContentValues; cdecl;
    procedure requery; cdecl;
    procedure setKeepUpdated(keepUpdated: Boolean); cdecl;
  end;
  TJContentQueryMap = class(TJavaGenericImport<JContentQueryMapClass, JContentQueryMap>) end;

  JContentResolverClass = interface(JObjectClass)
    ['{29F2ED97-64A0-435B-A79C-7B8F80E6659A}']
    {class} function _GetANY_CURSOR_ITEM_TYPE: JString; cdecl;
    {class} function _GetCURSOR_DIR_BASE_TYPE: JString; cdecl;
    {class} function _GetCURSOR_ITEM_BASE_TYPE: JString; cdecl;
    {class} function _GetEXTRA_SIZE: JString; cdecl;
    {class} function _GetSCHEME_ANDROID_RESOURCE: JString; cdecl;
    {class} function _GetSCHEME_CONTENT: JString; cdecl;
    {class} function _GetSCHEME_FILE: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_ACCOUNT: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_DISCARD_LOCAL_DELETIONS: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_DO_NOT_RETRY: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_EXPEDITED: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_FORCE: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_IGNORE_BACKOFF: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_IGNORE_SETTINGS: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_INITIALIZE: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_MANUAL: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_OVERRIDE_TOO_MANY_DELETIONS: JString; cdecl;
    {class} function _GetSYNC_EXTRAS_UPLOAD: JString; cdecl;
    {class} function _GetSYNC_OBSERVER_TYPE_ACTIVE: Integer; cdecl;
    {class} function _GetSYNC_OBSERVER_TYPE_PENDING: Integer; cdecl;
    {class} function _GetSYNC_OBSERVER_TYPE_SETTINGS: Integer; cdecl;
    {class} function init(context: JContext): JContentResolver; cdecl;
    {class} //procedure addPeriodicSync(account: JAccount; authority: JString; extras: JBundle; pollFrequency: Int64); cdecl;
    {class} function addStatusChangeListener(mask: Integer; callback: JSyncStatusObserver): JObject; cdecl;
    {class} //procedure cancelSync(account: JAccount; authority: JString); cdecl; overload;
    {class} procedure cancelSync(request: JSyncRequest); cdecl; overload;
    {class} function getCurrentSync: JSyncInfo; cdecl;//Deprecated
    {class} function getCurrentSyncs: JList; cdecl;
    {class} //function getIsSyncable(account: JAccount; authority: JString): Integer; cdecl;
    {class} function getMasterSyncAutomatically: Boolean; cdecl;
    {class} //function getPeriodicSyncs(account: JAccount; authority: JString): JList; cdecl;
    {class} function getSyncAdapterTypes: TJavaObjectArray<JSyncAdapterType>; cdecl;
    {class} //function getSyncAutomatically(account: JAccount; authority: JString): Boolean; cdecl;
    {class} //function isSyncActive(account: JAccount; authority: JString): Boolean; cdecl;
    {class} //function isSyncPending(account: JAccount; authority: JString): Boolean; cdecl;
    {class} //procedure removePeriodicSync(account: JAccount; authority: JString; extras: JBundle); cdecl;
    {class} procedure removeStatusChangeListener(handle: JObject); cdecl;
    {class} //procedure requestSync(account: JAccount; authority: JString; extras: JBundle); cdecl; overload;
    {class} procedure requestSync(request: JSyncRequest); cdecl; overload;
    {class} //procedure setIsSyncable(account: JAccount; authority: JString; syncable: Integer); cdecl;
    {class} procedure setMasterSyncAutomatically(sync: Boolean); cdecl;
    {class} //procedure setSyncAutomatically(account: JAccount; authority: JString; sync: Boolean); cdecl;
    {class} procedure validateSyncExtrasBundle(extras: JBundle); cdecl;
    {class} property ANY_CURSOR_ITEM_TYPE: JString read _GetANY_CURSOR_ITEM_TYPE;
    {class} property CURSOR_DIR_BASE_TYPE: JString read _GetCURSOR_DIR_BASE_TYPE;
    {class} property CURSOR_ITEM_BASE_TYPE: JString read _GetCURSOR_ITEM_BASE_TYPE;
    {class} property EXTRA_SIZE: JString read _GetEXTRA_SIZE;
    {class} property SCHEME_ANDROID_RESOURCE: JString read _GetSCHEME_ANDROID_RESOURCE;
    {class} property SCHEME_CONTENT: JString read _GetSCHEME_CONTENT;
    {class} property SCHEME_FILE: JString read _GetSCHEME_FILE;
    {class} property SYNC_EXTRAS_ACCOUNT: JString read _GetSYNC_EXTRAS_ACCOUNT;
    {class} property SYNC_EXTRAS_DISCARD_LOCAL_DELETIONS: JString read _GetSYNC_EXTRAS_DISCARD_LOCAL_DELETIONS;
    {class} property SYNC_EXTRAS_DO_NOT_RETRY: JString read _GetSYNC_EXTRAS_DO_NOT_RETRY;
    {class} property SYNC_EXTRAS_EXPEDITED: JString read _GetSYNC_EXTRAS_EXPEDITED;
    {class} property SYNC_EXTRAS_FORCE: JString read _GetSYNC_EXTRAS_FORCE;
    {class} property SYNC_EXTRAS_IGNORE_BACKOFF: JString read _GetSYNC_EXTRAS_IGNORE_BACKOFF;
    {class} property SYNC_EXTRAS_IGNORE_SETTINGS: JString read _GetSYNC_EXTRAS_IGNORE_SETTINGS;
    {class} property SYNC_EXTRAS_INITIALIZE: JString read _GetSYNC_EXTRAS_INITIALIZE;
    {class} property SYNC_EXTRAS_MANUAL: JString read _GetSYNC_EXTRAS_MANUAL;
    {class} property SYNC_EXTRAS_OVERRIDE_TOO_MANY_DELETIONS: JString read _GetSYNC_EXTRAS_OVERRIDE_TOO_MANY_DELETIONS;
    {class} property SYNC_EXTRAS_UPLOAD: JString read _GetSYNC_EXTRAS_UPLOAD;
    {class} property SYNC_OBSERVER_TYPE_ACTIVE: Integer read _GetSYNC_OBSERVER_TYPE_ACTIVE;
    {class} property SYNC_OBSERVER_TYPE_PENDING: Integer read _GetSYNC_OBSERVER_TYPE_PENDING;
    {class} property SYNC_OBSERVER_TYPE_SETTINGS: Integer read _GetSYNC_OBSERVER_TYPE_SETTINGS;
  end;

  [JavaSignature('android/content/ContentResolver')]
  JContentResolver = interface(JObject)
    ['{774C50C1-66DC-489E-9CAC-5434A5DE7CE0}']
    function acquireContentProviderClient(uri: Jnet_Uri): JContentProviderClient; cdecl; overload;
    function acquireContentProviderClient(name: JString): JContentProviderClient; cdecl; overload;
    function acquireUnstableContentProviderClient(uri: Jnet_Uri): JContentProviderClient; cdecl; overload;
    function acquireUnstableContentProviderClient(name: JString): JContentProviderClient; cdecl; overload;
    function applyBatch(authority: JString; operations: JArrayList): TJavaObjectArray<JContentProviderResult>; cdecl;
    function bulkInsert(url: Jnet_Uri; values: TJavaObjectArray<JContentValues>): Integer; cdecl;
    function call(uri: Jnet_Uri; method: JString; arg: JString; extras: JBundle): JBundle; cdecl;
    procedure cancelSync(uri: Jnet_Uri); cdecl; overload;//Deprecated
    function canonicalize(url: Jnet_Uri): Jnet_Uri; cdecl;
    function delete(url: Jnet_Uri; where: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
    function getOutgoingPersistedUriPermissions: JList; cdecl;
    function getPersistedUriPermissions: JList; cdecl;
    function getStreamTypes(url: Jnet_Uri; mimeTypeFilter: JString): TJavaObjectArray<JString>; cdecl;
    function getType(url: Jnet_Uri): JString; cdecl;
    function insert(url: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    procedure notifyChange(uri: Jnet_Uri; observer: JContentObserver); cdecl; overload;
    procedure notifyChange(uri: Jnet_Uri; observer: JContentObserver; syncToNetwork: Boolean); cdecl; overload;
    function openAssetFileDescriptor(uri: Jnet_Uri; mode: JString): JAssetFileDescriptor; cdecl; overload;
    function openAssetFileDescriptor(uri: Jnet_Uri; mode: JString; cancellationSignal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function openFileDescriptor(uri: Jnet_Uri; mode: JString): JParcelFileDescriptor; cdecl; overload;
    function openFileDescriptor(uri: Jnet_Uri; mode: JString; cancellationSignal: JCancellationSignal): JParcelFileDescriptor; cdecl; overload;
    function openInputStream(uri: Jnet_Uri): JInputStream; cdecl;
    function openOutputStream(uri: Jnet_Uri): JOutputStream; cdecl; overload;
    function openOutputStream(uri: Jnet_Uri; mode: JString): JOutputStream; cdecl; overload;
    function openTypedAssetFileDescriptor(uri: Jnet_Uri; mimeType: JString; opts: JBundle): JAssetFileDescriptor; cdecl; overload;
    function openTypedAssetFileDescriptor(uri: Jnet_Uri; mimeType: JString; opts: JBundle; cancellationSignal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl; overload;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    procedure registerContentObserver(uri: Jnet_Uri; notifyForDescendents: Boolean; observer: JContentObserver); cdecl;
    procedure releasePersistableUriPermission(uri: Jnet_Uri; modeFlags: Integer); cdecl;
    procedure startSync(uri: Jnet_Uri; extras: JBundle); cdecl;//Deprecated
    procedure takePersistableUriPermission(uri: Jnet_Uri; modeFlags: Integer); cdecl;
    function uncanonicalize(url: Jnet_Uri): Jnet_Uri; cdecl;
    procedure unregisterContentObserver(observer: JContentObserver); cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; where: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJContentResolver = class(TJavaGenericImport<JContentResolverClass, JContentResolver>) end;

  JContentUrisClass = interface(JObjectClass)
    ['{5D5A5751-372E-4023-A753-53D97377774E}']
    {class} function init: JContentUris; cdecl;
    {class} function appendId(builder: JUri_Builder; id: Int64): JUri_Builder; cdecl;
    {class} function parseId(contentUri: Jnet_Uri): Int64; cdecl;
    {class} function withAppendedId(contentUri: Jnet_Uri; id: Int64): Jnet_Uri; cdecl;
  end;

  [JavaSignature('android/content/ContentUris')]
  JContentUris = interface(JObject)
    ['{1E64E1A3-4CD2-46E6-9A36-FCD92EEDE341}']
  end;
  TJContentUris = class(TJavaGenericImport<JContentUrisClass, JContentUris>) end;

  JContentValuesClass = interface(JObjectClass)
    ['{292EE66E-E970-4812-89F5-8E22A32EDA29}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetTAG: JString; cdecl;
    {class} function init: JContentValues; cdecl; overload;
    {class} function init(size: Integer): JContentValues; cdecl; overload;
    {class} function init(from: JContentValues): JContentValues; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property TAG: JString read _GetTAG;
  end;

  [JavaSignature('android/content/ContentValues')]
  JContentValues = interface(JObject)
    ['{1A22E83D-2DC3-4E93-9FB4-9476C7402066}']
    procedure clear; cdecl;
    function containsKey(key: JString): Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(key: JString): JObject; cdecl;
    function getAsBoolean(key: JString): JBoolean; cdecl;
    function getAsByte(key: JString): JByte; cdecl;
    function getAsByteArray(key: JString): TJavaArray<Byte>; cdecl;
    function getAsDouble(key: JString): JDouble; cdecl;
    function getAsFloat(key: JString): JFloat; cdecl;
    function getAsInteger(key: JString): JInteger; cdecl;
    function getAsLong(key: JString): JLong; cdecl;
    function getAsShort(key: JString): JShort; cdecl;
    function getAsString(key: JString): JString; cdecl;
    function hashCode: Integer; cdecl;
    function keySet: JSet; cdecl;
    procedure put(key: JString; value: JString); cdecl; overload;
    procedure put(key: JString; value: JByte); cdecl; overload;
    procedure put(key: JString; value: JShort); cdecl; overload;
    procedure put(key: JString; value: JInteger); cdecl; overload;
    procedure put(key: JString; value: JLong); cdecl; overload;
    procedure put(key: JString; value: JFloat); cdecl; overload;
    procedure put(key: JString; value: JDouble); cdecl; overload;
    procedure put(key: JString; value: JBoolean); cdecl; overload;
    procedure put(key: JString; value: TJavaArray<Byte>); cdecl; overload;
    procedure putAll(other: JContentValues); cdecl;
    procedure putNull(key: JString); cdecl;
    procedure remove(key: JString); cdecl;
    function size: Integer; cdecl;
    function toString: JString; cdecl;
    function valueSet: JSet; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJContentValues = class(TJavaGenericImport<JContentValuesClass, JContentValues>) end;

  JContextClass = interface(JObjectClass)
    ['{DFC8B995-8B7D-4BBF-8100-C0782A8B9086}']
    {class} function _GetACCESSIBILITY_SERVICE: JString; cdecl;
    {class} function _GetACCOUNT_SERVICE: JString; cdecl;
    {class} function _GetACTIVITY_SERVICE: JString; cdecl;
    {class} function _GetALARM_SERVICE: JString; cdecl;
    {class} function _GetAPPWIDGET_SERVICE: JString; cdecl;
    {class} function _GetAPP_OPS_SERVICE: JString; cdecl;
    {class} function _GetAUDIO_SERVICE: JString; cdecl;
    {class} function _GetBATTERY_SERVICE: JString; cdecl;
    {class} function _GetBIND_ABOVE_CLIENT: Integer; cdecl;
    {class} function _GetBIND_ADJUST_WITH_ACTIVITY: Integer; cdecl;
    {class} function _GetBIND_ALLOW_OOM_MANAGEMENT: Integer; cdecl;
    {class} function _GetBIND_AUTO_CREATE: Integer; cdecl;
    {class} function _GetBIND_DEBUG_UNBIND: Integer; cdecl;
    {class} function _GetBIND_IMPORTANT: Integer; cdecl;
    {class} function _GetBIND_NOT_FOREGROUND: Integer; cdecl;
    {class} function _GetBIND_WAIVE_PRIORITY: Integer; cdecl;
    {class} function _GetBLUETOOTH_SERVICE: JString; cdecl;
    {class} function _GetCAMERA_SERVICE: JString; cdecl;
    {class} function _GetCAPTIONING_SERVICE: JString; cdecl;
    {class} function _GetCARRIER_CONFIG_SERVICE: JString; cdecl;
    {class} function _GetCLIPBOARD_SERVICE: JString; cdecl;
    {class} function _GetCONNECTIVITY_SERVICE: JString; cdecl;
    {class} function _GetCONSUMER_IR_SERVICE: JString; cdecl;
    {class} function _GetCONTEXT_IGNORE_SECURITY: Integer; cdecl;
    {class} function _GetCONTEXT_INCLUDE_CODE: Integer; cdecl;
    {class} function _GetCONTEXT_RESTRICTED: Integer; cdecl;
    {class} function _GetDEVICE_POLICY_SERVICE: JString; cdecl;
    {class} function _GetDISPLAY_SERVICE: JString; cdecl;
    {class} function _GetDOWNLOAD_SERVICE: JString; cdecl;
    {class} function _GetDROPBOX_SERVICE: JString; cdecl;
    {class} function _GetFINGERPRINT_SERVICE: JString; cdecl;
    {class} function _GetINPUT_METHOD_SERVICE: JString; cdecl;
    {class} function _GetINPUT_SERVICE: JString; cdecl;
    {class} function _GetJOB_SCHEDULER_SERVICE: JString; cdecl;
    {class} function _GetKEYGUARD_SERVICE: JString; cdecl;
    {class} function _GetLAUNCHER_APPS_SERVICE: JString; cdecl;
    {class} function _GetLAYOUT_INFLATER_SERVICE: JString; cdecl;
    {class} function _GetLOCATION_SERVICE: JString; cdecl;
    {class} function _GetMEDIA_PROJECTION_SERVICE: JString; cdecl;
    {class} function _GetMEDIA_ROUTER_SERVICE: JString; cdecl;
    {class} function _GetMEDIA_SESSION_SERVICE: JString; cdecl;
    {class} function _GetMIDI_SERVICE: JString; cdecl;
    {class} function _GetMODE_APPEND: Integer; cdecl;
    {class} function _GetMODE_ENABLE_WRITE_AHEAD_LOGGING: Integer; cdecl;
    {class} function _GetMODE_MULTI_PROCESS: Integer; cdecl;
    {class} function _GetMODE_PRIVATE: Integer; cdecl;
    {class} function _GetMODE_WORLD_READABLE: Integer; cdecl;
    {class} function _GetMODE_WORLD_WRITEABLE: Integer; cdecl;
    {class} function _GetNETWORK_STATS_SERVICE: JString; cdecl;
    {class} function _GetNFC_SERVICE: JString; cdecl;
    {class} function _GetNOTIFICATION_SERVICE: JString; cdecl;
    {class} function _GetNSD_SERVICE: JString; cdecl;
    {class} function _GetPOWER_SERVICE: JString; cdecl;
    {class} function _GetPRINT_SERVICE: JString; cdecl;
    {class} function _GetRESTRICTIONS_SERVICE: JString; cdecl;
    {class} function _GetSEARCH_SERVICE: JString; cdecl;
    {class} function _GetSENSOR_SERVICE: JString; cdecl;
    {class} function _GetSTORAGE_SERVICE: JString; cdecl;
    {class} function _GetTELECOM_SERVICE: JString; cdecl;
    {class} function _GetTELEPHONY_SERVICE: JString; cdecl;
    {class} function _GetTELEPHONY_SUBSCRIPTION_SERVICE: JString; cdecl;
    {class} function _GetTEXT_SERVICES_MANAGER_SERVICE: JString; cdecl;
    {class} function _GetTV_INPUT_SERVICE: JString; cdecl;
    {class} function _GetUI_MODE_SERVICE: JString; cdecl;
    {class} function _GetUSAGE_STATS_SERVICE: JString; cdecl;
    {class} function _GetUSB_SERVICE: JString; cdecl;
    {class} function _GetUSER_SERVICE: JString; cdecl;
    {class} function _GetVIBRATOR_SERVICE: JString; cdecl;
    {class} function _GetWALLPAPER_SERVICE: JString; cdecl;
    {class} function _GetWIFI_P2P_SERVICE: JString; cdecl;
    {class} function _GetWIFI_SERVICE: JString; cdecl;
    {class} function _GetWINDOW_SERVICE: JString; cdecl;
    {class} function init: JContext; cdecl;
    {class} property ACCESSIBILITY_SERVICE: JString read _GetACCESSIBILITY_SERVICE;
    {class} property ACCOUNT_SERVICE: JString read _GetACCOUNT_SERVICE;
    {class} property ACTIVITY_SERVICE: JString read _GetACTIVITY_SERVICE;
    {class} property ALARM_SERVICE: JString read _GetALARM_SERVICE;
    {class} property APPWIDGET_SERVICE: JString read _GetAPPWIDGET_SERVICE;
    {class} property APP_OPS_SERVICE: JString read _GetAPP_OPS_SERVICE;
    {class} property AUDIO_SERVICE: JString read _GetAUDIO_SERVICE;
    {class} property BATTERY_SERVICE: JString read _GetBATTERY_SERVICE;
    {class} property BIND_ABOVE_CLIENT: Integer read _GetBIND_ABOVE_CLIENT;
    {class} property BIND_ADJUST_WITH_ACTIVITY: Integer read _GetBIND_ADJUST_WITH_ACTIVITY;
    {class} property BIND_ALLOW_OOM_MANAGEMENT: Integer read _GetBIND_ALLOW_OOM_MANAGEMENT;
    {class} property BIND_AUTO_CREATE: Integer read _GetBIND_AUTO_CREATE;
    {class} property BIND_DEBUG_UNBIND: Integer read _GetBIND_DEBUG_UNBIND;
    {class} property BIND_IMPORTANT: Integer read _GetBIND_IMPORTANT;
    {class} property BIND_NOT_FOREGROUND: Integer read _GetBIND_NOT_FOREGROUND;
    {class} property BIND_WAIVE_PRIORITY: Integer read _GetBIND_WAIVE_PRIORITY;
    {class} property BLUETOOTH_SERVICE: JString read _GetBLUETOOTH_SERVICE;
    {class} property CAMERA_SERVICE: JString read _GetCAMERA_SERVICE;
    {class} property CAPTIONING_SERVICE: JString read _GetCAPTIONING_SERVICE;
    {class} property CARRIER_CONFIG_SERVICE: JString read _GetCARRIER_CONFIG_SERVICE;
    {class} property CLIPBOARD_SERVICE: JString read _GetCLIPBOARD_SERVICE;
    {class} property CONNECTIVITY_SERVICE: JString read _GetCONNECTIVITY_SERVICE;
    {class} property CONSUMER_IR_SERVICE: JString read _GetCONSUMER_IR_SERVICE;
    {class} property CONTEXT_IGNORE_SECURITY: Integer read _GetCONTEXT_IGNORE_SECURITY;
    {class} property CONTEXT_INCLUDE_CODE: Integer read _GetCONTEXT_INCLUDE_CODE;
    {class} property CONTEXT_RESTRICTED: Integer read _GetCONTEXT_RESTRICTED;
    {class} property DEVICE_POLICY_SERVICE: JString read _GetDEVICE_POLICY_SERVICE;
    {class} property DISPLAY_SERVICE: JString read _GetDISPLAY_SERVICE;
    {class} property DOWNLOAD_SERVICE: JString read _GetDOWNLOAD_SERVICE;
    {class} property DROPBOX_SERVICE: JString read _GetDROPBOX_SERVICE;
    {class} property FINGERPRINT_SERVICE: JString read _GetFINGERPRINT_SERVICE;
    {class} property INPUT_METHOD_SERVICE: JString read _GetINPUT_METHOD_SERVICE;
    {class} property INPUT_SERVICE: JString read _GetINPUT_SERVICE;
    {class} property JOB_SCHEDULER_SERVICE: JString read _GetJOB_SCHEDULER_SERVICE;
    {class} property KEYGUARD_SERVICE: JString read _GetKEYGUARD_SERVICE;
    {class} property LAUNCHER_APPS_SERVICE: JString read _GetLAUNCHER_APPS_SERVICE;
    {class} property LAYOUT_INFLATER_SERVICE: JString read _GetLAYOUT_INFLATER_SERVICE;
    {class} property LOCATION_SERVICE: JString read _GetLOCATION_SERVICE;
    {class} property MEDIA_PROJECTION_SERVICE: JString read _GetMEDIA_PROJECTION_SERVICE;
    {class} property MEDIA_ROUTER_SERVICE: JString read _GetMEDIA_ROUTER_SERVICE;
    {class} property MEDIA_SESSION_SERVICE: JString read _GetMEDIA_SESSION_SERVICE;
    {class} property MIDI_SERVICE: JString read _GetMIDI_SERVICE;
    {class} property MODE_APPEND: Integer read _GetMODE_APPEND;
    {class} property MODE_ENABLE_WRITE_AHEAD_LOGGING: Integer read _GetMODE_ENABLE_WRITE_AHEAD_LOGGING;
    {class} property MODE_MULTI_PROCESS: Integer read _GetMODE_MULTI_PROCESS;
    {class} property MODE_PRIVATE: Integer read _GetMODE_PRIVATE;
    {class} property MODE_WORLD_READABLE: Integer read _GetMODE_WORLD_READABLE;
    {class} property MODE_WORLD_WRITEABLE: Integer read _GetMODE_WORLD_WRITEABLE;
    {class} property NETWORK_STATS_SERVICE: JString read _GetNETWORK_STATS_SERVICE;
    {class} property NFC_SERVICE: JString read _GetNFC_SERVICE;
    {class} property NOTIFICATION_SERVICE: JString read _GetNOTIFICATION_SERVICE;
    {class} property NSD_SERVICE: JString read _GetNSD_SERVICE;
    {class} property POWER_SERVICE: JString read _GetPOWER_SERVICE;
    {class} property PRINT_SERVICE: JString read _GetPRINT_SERVICE;
    {class} property RESTRICTIONS_SERVICE: JString read _GetRESTRICTIONS_SERVICE;
    {class} property SEARCH_SERVICE: JString read _GetSEARCH_SERVICE;
    {class} property SENSOR_SERVICE: JString read _GetSENSOR_SERVICE;
    {class} property STORAGE_SERVICE: JString read _GetSTORAGE_SERVICE;
    {class} property TELECOM_SERVICE: JString read _GetTELECOM_SERVICE;
    {class} property TELEPHONY_SERVICE: JString read _GetTELEPHONY_SERVICE;
    {class} property TELEPHONY_SUBSCRIPTION_SERVICE: JString read _GetTELEPHONY_SUBSCRIPTION_SERVICE;
    {class} property TEXT_SERVICES_MANAGER_SERVICE: JString read _GetTEXT_SERVICES_MANAGER_SERVICE;
    {class} property TV_INPUT_SERVICE: JString read _GetTV_INPUT_SERVICE;
    {class} property UI_MODE_SERVICE: JString read _GetUI_MODE_SERVICE;
    {class} property USAGE_STATS_SERVICE: JString read _GetUSAGE_STATS_SERVICE;
    {class} property USB_SERVICE: JString read _GetUSB_SERVICE;
    {class} property USER_SERVICE: JString read _GetUSER_SERVICE;
    {class} property VIBRATOR_SERVICE: JString read _GetVIBRATOR_SERVICE;
    {class} property WALLPAPER_SERVICE: JString read _GetWALLPAPER_SERVICE;
    {class} property WIFI_P2P_SERVICE: JString read _GetWIFI_P2P_SERVICE;
    {class} property WIFI_SERVICE: JString read _GetWIFI_SERVICE;
    {class} property WINDOW_SERVICE: JString read _GetWINDOW_SERVICE;
  end;

  [JavaSignature('android/content/Context')]
  JContext = interface(JObject)
    ['{72BE5195-DD04-4E6E-8A27-AA4DF0D8F912}']
    function bindService(service: JIntent; conn: JServiceConnection; flags: Integer): Boolean; cdecl;
    function checkCallingOrSelfPermission(permission: JString): Integer; cdecl;
    function checkCallingOrSelfUriPermission(uri: Jnet_Uri; modeFlags: Integer): Integer; cdecl;
    function checkCallingPermission(permission: JString): Integer; cdecl;
    function checkCallingUriPermission(uri: Jnet_Uri; modeFlags: Integer): Integer; cdecl;
    function checkPermission(permission: JString; pid: Integer; uid: Integer): Integer; cdecl;
    function checkSelfPermission(permission: JString): Integer; cdecl;
    function checkUriPermission(uri: Jnet_Uri; pid: Integer; uid: Integer; modeFlags: Integer): Integer; cdecl; overload;
    function checkUriPermission(uri: Jnet_Uri; readPermission: JString; writePermission: JString; pid: Integer; uid: Integer; modeFlags: Integer): Integer; cdecl; overload;
    procedure clearWallpaper; cdecl;//Deprecated
    function createConfigurationContext(overrideConfiguration: JConfiguration): JContext; cdecl;
    function createDisplayContext(display: JDisplay): JContext; cdecl;
    function createPackageContext(packageName: JString; flags: Integer): JContext; cdecl;
    function databaseList: TJavaObjectArray<JString>; cdecl;
    function deleteDatabase(name: JString): Boolean; cdecl;
    function deleteFile(name: JString): Boolean; cdecl;
    procedure enforceCallingOrSelfPermission(permission: JString; message: JString); cdecl;
    procedure enforceCallingOrSelfUriPermission(uri: Jnet_Uri; modeFlags: Integer; message: JString); cdecl;
    procedure enforceCallingPermission(permission: JString; message: JString); cdecl;
    procedure enforceCallingUriPermission(uri: Jnet_Uri; modeFlags: Integer; message: JString); cdecl;
    procedure enforcePermission(permission: JString; pid: Integer; uid: Integer; message: JString); cdecl;
    procedure enforceUriPermission(uri: Jnet_Uri; pid: Integer; uid: Integer; modeFlags: Integer; message: JString); cdecl; overload;
    procedure enforceUriPermission(uri: Jnet_Uri; readPermission: JString; writePermission: JString; pid: Integer; uid: Integer; modeFlags: Integer; message: JString); cdecl; overload;
    function fileList: TJavaObjectArray<JString>; cdecl;
    function getApplicationContext: JContext; cdecl;
    function getApplicationInfo: JApplicationInfo; cdecl;
    function getAssets: JAssetManager; cdecl;
    function getCacheDir: JFile; cdecl;
    function getClassLoader: JClassLoader; cdecl;
    function getCodeCacheDir: JFile; cdecl;
    function getColor(id: Integer): Integer; cdecl;
    function getColorStateList(id: Integer): JColorStateList; cdecl;
    function getContentResolver: JContentResolver; cdecl;
    function getDatabasePath(name: JString): JFile; cdecl;
    function getDir(name: JString; mode: Integer): JFile; cdecl;
    function getDrawable(id: Integer): JDrawable; cdecl;
    function getExternalCacheDir: JFile; cdecl;
    function getExternalCacheDirs: TJavaObjectArray<JFile>; cdecl;
    function getExternalFilesDir(type_: JString): JFile; cdecl;
    function getExternalFilesDirs(type_: JString): TJavaObjectArray<JFile>; cdecl;
    function getExternalMediaDirs: TJavaObjectArray<JFile>; cdecl;
    function getFileStreamPath(name: JString): JFile; cdecl;
    function getFilesDir: JFile; cdecl;
    function getMainLooper: JLooper; cdecl;
    function getNoBackupFilesDir: JFile; cdecl;
    function getObbDir: JFile; cdecl;
    function getObbDirs: TJavaObjectArray<JFile>; cdecl;
    function getPackageCodePath: JString; cdecl;
    function getPackageManager: JPackageManager; cdecl;
    function getPackageName: JString; cdecl;
    function getPackageResourcePath: JString; cdecl;
    function getResources: JResources; cdecl;
    function getSharedPreferences(name: JString; mode: Integer): JSharedPreferences; cdecl;
    function getString(resId: Integer): JString; cdecl; overload;
    function getSystemService(name: JString): JObject; cdecl; overload;
    function getSystemService(serviceClass: Jlang_Class): JObject; cdecl; overload;
    function getSystemServiceName(serviceClass: Jlang_Class): JString; cdecl;
    function getText(resId: Integer): JCharSequence; cdecl;
    function getTheme: JResources_Theme; cdecl;
    function getWallpaper: JDrawable; cdecl;//Deprecated
    function getWallpaperDesiredMinimumHeight: Integer; cdecl;//Deprecated
    function getWallpaperDesiredMinimumWidth: Integer; cdecl;//Deprecated
    procedure grantUriPermission(toPackage: JString; uri: Jnet_Uri; modeFlags: Integer); cdecl;
    function isRestricted: Boolean; cdecl;
    function obtainStyledAttributes(attrs: TJavaArray<Integer>): JTypedArray; cdecl; overload;
    function obtainStyledAttributes(resid: Integer; attrs: TJavaArray<Integer>): JTypedArray; cdecl; overload;
    function obtainStyledAttributes(set_: JAttributeSet; attrs: TJavaArray<Integer>): JTypedArray; cdecl; overload;
    function obtainStyledAttributes(set_: JAttributeSet; attrs: TJavaArray<Integer>; defStyleAttr: Integer; defStyleRes: Integer): JTypedArray; cdecl; overload;
    function openFileInput(name: JString): JFileInputStream; cdecl;
    function openFileOutput(name: JString; mode: Integer): JFileOutputStream; cdecl;
    function openOrCreateDatabase(name: JString; mode: Integer; factory: JSQLiteDatabase_CursorFactory): JSQLiteDatabase; cdecl; overload;
    function openOrCreateDatabase(name: JString; mode: Integer; factory: JSQLiteDatabase_CursorFactory; errorHandler: JDatabaseErrorHandler): JSQLiteDatabase; cdecl; overload;
    function peekWallpaper: JDrawable; cdecl;//Deprecated
    procedure registerComponentCallbacks(callback: JComponentCallbacks); cdecl;
    function registerReceiver(receiver: JBroadcastReceiver; filter: JIntentFilter): JIntent; cdecl; overload;
    function registerReceiver(receiver: JBroadcastReceiver; filter: JIntentFilter; broadcastPermission: JString; scheduler: JHandler): JIntent; cdecl; overload;
    procedure removeStickyBroadcast(intent: JIntent); cdecl;//Deprecated
    procedure removeStickyBroadcastAsUser(intent: JIntent; user: JUserHandle); cdecl;//Deprecated
    procedure revokeUriPermission(uri: Jnet_Uri; modeFlags: Integer); cdecl;
    procedure sendBroadcast(intent: JIntent); cdecl; overload;
    procedure sendBroadcast(intent: JIntent; receiverPermission: JString); cdecl; overload;
    procedure sendBroadcastAsUser(intent: JIntent; user: JUserHandle); cdecl; overload;
    procedure sendBroadcastAsUser(intent: JIntent; user: JUserHandle; receiverPermission: JString); cdecl; overload;
    procedure sendOrderedBroadcast(intent: JIntent; receiverPermission: JString); cdecl; overload;
    procedure sendOrderedBroadcast(intent: JIntent; receiverPermission: JString; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl; overload;
    procedure sendOrderedBroadcastAsUser(intent: JIntent; user: JUserHandle; receiverPermission: JString; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl;
    procedure sendStickyBroadcast(intent: JIntent); cdecl;//Deprecated
    procedure sendStickyBroadcastAsUser(intent: JIntent; user: JUserHandle); cdecl;//Deprecated
    procedure sendStickyOrderedBroadcast(intent: JIntent; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl;//Deprecated
    procedure sendStickyOrderedBroadcastAsUser(intent: JIntent; user: JUserHandle; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl;//Deprecated
    procedure setTheme(resid: Integer); cdecl;
    procedure setWallpaper(bitmap: JBitmap); cdecl; overload;//Deprecated
    procedure setWallpaper(data: JInputStream); cdecl; overload;//Deprecated
    procedure startActivities(intents: TJavaObjectArray<JIntent>); cdecl; overload;
    procedure startActivities(intents: TJavaObjectArray<JIntent>; options: JBundle); cdecl; overload;
    procedure startActivity(intent: JIntent); cdecl; overload;
    procedure startActivity(intent: JIntent; options: JBundle); cdecl; overload;
    function startInstrumentation(className: JComponentName; profileFile: JString; arguments: JBundle): Boolean; cdecl;
    procedure startIntentSender(intent: JIntentSender; fillInIntent: JIntent; flagsMask: Integer; flagsValues: Integer; extraFlags: Integer); cdecl; overload;
    procedure startIntentSender(intent: JIntentSender; fillInIntent: JIntent; flagsMask: Integer; flagsValues: Integer; extraFlags: Integer; options: JBundle); cdecl; overload;
    function startService(service: JIntent): JComponentName; cdecl;
    function stopService(service: JIntent): Boolean; cdecl;
    procedure unbindService(conn: JServiceConnection); cdecl;
    procedure unregisterComponentCallbacks(callback: JComponentCallbacks); cdecl;
    procedure unregisterReceiver(receiver: JBroadcastReceiver); cdecl;
  end;
  TJContext = class(TJavaGenericImport<JContextClass, JContext>) end;

  JContextWrapperClass = interface(JContextClass)
    ['{EA8706C6-B2D2-41C0-935D-838BB8704209}']
    {class} function init(base: JContext): JContextWrapper; cdecl;
  end;

  [JavaSignature('android/content/ContextWrapper')]
  JContextWrapper = interface(JContext)
    ['{D742A401-5631-42C5-9B65-6F1F46811A40}']
    function bindService(service: JIntent; conn: JServiceConnection; flags: Integer): Boolean; cdecl;
    function checkCallingOrSelfPermission(permission: JString): Integer; cdecl;
    function checkCallingOrSelfUriPermission(uri: Jnet_Uri; modeFlags: Integer): Integer; cdecl;
    function checkCallingPermission(permission: JString): Integer; cdecl;
    function checkCallingUriPermission(uri: Jnet_Uri; modeFlags: Integer): Integer; cdecl;
    function checkPermission(permission: JString; pid: Integer; uid: Integer): Integer; cdecl;
    function checkSelfPermission(permission: JString): Integer; cdecl;
    function checkUriPermission(uri: Jnet_Uri; pid: Integer; uid: Integer; modeFlags: Integer): Integer; cdecl; overload;
    function checkUriPermission(uri: Jnet_Uri; readPermission: JString; writePermission: JString; pid: Integer; uid: Integer; modeFlags: Integer): Integer; cdecl; overload;
    procedure clearWallpaper; cdecl;//Deprecated
    function createConfigurationContext(overrideConfiguration: JConfiguration): JContext; cdecl;
    function createDisplayContext(display: JDisplay): JContext; cdecl;
    function createPackageContext(packageName: JString; flags: Integer): JContext; cdecl;
    function databaseList: TJavaObjectArray<JString>; cdecl;
    function deleteDatabase(name: JString): Boolean; cdecl;
    function deleteFile(name: JString): Boolean; cdecl;
    procedure enforceCallingOrSelfPermission(permission: JString; message: JString); cdecl;
    procedure enforceCallingOrSelfUriPermission(uri: Jnet_Uri; modeFlags: Integer; message: JString); cdecl;
    procedure enforceCallingPermission(permission: JString; message: JString); cdecl;
    procedure enforceCallingUriPermission(uri: Jnet_Uri; modeFlags: Integer; message: JString); cdecl;
    procedure enforcePermission(permission: JString; pid: Integer; uid: Integer; message: JString); cdecl;
    procedure enforceUriPermission(uri: Jnet_Uri; pid: Integer; uid: Integer; modeFlags: Integer; message: JString); cdecl; overload;
    procedure enforceUriPermission(uri: Jnet_Uri; readPermission: JString; writePermission: JString; pid: Integer; uid: Integer; modeFlags: Integer; message: JString); cdecl; overload;
    function fileList: TJavaObjectArray<JString>; cdecl;
    function getApplicationContext: JContext; cdecl;
    function getApplicationInfo: JApplicationInfo; cdecl;
    function getAssets: JAssetManager; cdecl;
    function getBaseContext: JContext; cdecl;
    function getCacheDir: JFile; cdecl;
    function getClassLoader: JClassLoader; cdecl;
    function getCodeCacheDir: JFile; cdecl;
    function getContentResolver: JContentResolver; cdecl;
    function getDatabasePath(name: JString): JFile; cdecl;
    function getDir(name: JString; mode: Integer): JFile; cdecl;
    function getExternalCacheDir: JFile; cdecl;
    function getExternalCacheDirs: TJavaObjectArray<JFile>; cdecl;
    function getExternalFilesDir(type_: JString): JFile; cdecl;
    function getExternalFilesDirs(type_: JString): TJavaObjectArray<JFile>; cdecl;
    function getExternalMediaDirs: TJavaObjectArray<JFile>; cdecl;
    function getFileStreamPath(name: JString): JFile; cdecl;
    function getFilesDir: JFile; cdecl;
    function getMainLooper: JLooper; cdecl;
    function getNoBackupFilesDir: JFile; cdecl;
    function getObbDir: JFile; cdecl;
    function getObbDirs: TJavaObjectArray<JFile>; cdecl;
    function getPackageCodePath: JString; cdecl;
    function getPackageManager: JPackageManager; cdecl;
    function getPackageName: JString; cdecl;
    function getPackageResourcePath: JString; cdecl;
    function getResources: JResources; cdecl;
    function getSharedPreferences(name: JString; mode: Integer): JSharedPreferences; cdecl;
    function getSystemService(name: JString): JObject; cdecl;
    function getSystemServiceName(serviceClass: Jlang_Class): JString; cdecl;
    function getTheme: JResources_Theme; cdecl;
    function getWallpaper: JDrawable; cdecl;//Deprecated
    function getWallpaperDesiredMinimumHeight: Integer; cdecl;//Deprecated
    function getWallpaperDesiredMinimumWidth: Integer; cdecl;//Deprecated
    procedure grantUriPermission(toPackage: JString; uri: Jnet_Uri; modeFlags: Integer); cdecl;
    function isRestricted: Boolean; cdecl;
    function openFileInput(name: JString): JFileInputStream; cdecl;
    function openFileOutput(name: JString; mode: Integer): JFileOutputStream; cdecl;
    function openOrCreateDatabase(name: JString; mode: Integer; factory: JSQLiteDatabase_CursorFactory): JSQLiteDatabase; cdecl; overload;
    function openOrCreateDatabase(name: JString; mode: Integer; factory: JSQLiteDatabase_CursorFactory; errorHandler: JDatabaseErrorHandler): JSQLiteDatabase; cdecl; overload;
    function peekWallpaper: JDrawable; cdecl;//Deprecated
    function registerReceiver(receiver: JBroadcastReceiver; filter: JIntentFilter): JIntent; cdecl; overload;
    function registerReceiver(receiver: JBroadcastReceiver; filter: JIntentFilter; broadcastPermission: JString; scheduler: JHandler): JIntent; cdecl; overload;
    procedure removeStickyBroadcast(intent: JIntent); cdecl;//Deprecated
    procedure removeStickyBroadcastAsUser(intent: JIntent; user: JUserHandle); cdecl;//Deprecated
    procedure revokeUriPermission(uri: Jnet_Uri; modeFlags: Integer); cdecl;
    procedure sendBroadcast(intent: JIntent); cdecl; overload;
    procedure sendBroadcast(intent: JIntent; receiverPermission: JString); cdecl; overload;
    procedure sendBroadcastAsUser(intent: JIntent; user: JUserHandle); cdecl; overload;
    procedure sendBroadcastAsUser(intent: JIntent; user: JUserHandle; receiverPermission: JString); cdecl; overload;
    procedure sendOrderedBroadcast(intent: JIntent; receiverPermission: JString); cdecl; overload;
    procedure sendOrderedBroadcast(intent: JIntent; receiverPermission: JString; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl; overload;
    procedure sendOrderedBroadcastAsUser(intent: JIntent; user: JUserHandle; receiverPermission: JString; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl;
    procedure sendStickyBroadcast(intent: JIntent); cdecl;//Deprecated
    procedure sendStickyBroadcastAsUser(intent: JIntent; user: JUserHandle); cdecl;//Deprecated
    procedure sendStickyOrderedBroadcast(intent: JIntent; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl;//Deprecated
    procedure sendStickyOrderedBroadcastAsUser(intent: JIntent; user: JUserHandle; resultReceiver: JBroadcastReceiver; scheduler: JHandler; initialCode: Integer; initialData: JString; initialExtras: JBundle); cdecl;//Deprecated
    procedure setTheme(resid: Integer); cdecl;
    procedure setWallpaper(bitmap: JBitmap); cdecl; overload;//Deprecated
    procedure setWallpaper(data: JInputStream); cdecl; overload;//Deprecated
    procedure startActivities(intents: TJavaObjectArray<JIntent>); cdecl; overload;
    procedure startActivities(intents: TJavaObjectArray<JIntent>; options: JBundle); cdecl; overload;
    procedure startActivity(intent: JIntent); cdecl; overload;
    procedure startActivity(intent: JIntent; options: JBundle); cdecl; overload;
    function startInstrumentation(className: JComponentName; profileFile: JString; arguments: JBundle): Boolean; cdecl;
    procedure startIntentSender(intent: JIntentSender; fillInIntent: JIntent; flagsMask: Integer; flagsValues: Integer; extraFlags: Integer); cdecl; overload;
    procedure startIntentSender(intent: JIntentSender; fillInIntent: JIntent; flagsMask: Integer; flagsValues: Integer; extraFlags: Integer; options: JBundle); cdecl; overload;
    function startService(service: JIntent): JComponentName; cdecl;
    function stopService(name: JIntent): Boolean; cdecl;
    procedure unbindService(conn: JServiceConnection); cdecl;
    procedure unregisterReceiver(receiver: JBroadcastReceiver); cdecl;
  end;
  TJContextWrapper = class(TJavaGenericImport<JContextWrapperClass, JContextWrapper>) end;

  JCursorLoaderClass = interface(JAsyncTaskLoaderClass)
    ['{C1736040-F484-4E56-9453-35EC4565E16F}']
    {class} function init(context: JContext): JCursorLoader; cdecl; overload;
    {class} function init(context: JContext; uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursorLoader; cdecl; overload;
  end;

  [JavaSignature('android/content/CursorLoader')]
  JCursorLoader = interface(JAsyncTaskLoader)
    ['{BCEB8495-484F-44BA-9048-1D337963C928}']
    procedure cancelLoadInBackground; cdecl;
    procedure deliverResult(cursor: JCursor); cdecl;
    procedure dump(prefix: JString; fd: JFileDescriptor; writer: JPrintWriter; args: TJavaObjectArray<JString>); cdecl;
    function getProjection: TJavaObjectArray<JString>; cdecl;
    function getSelection: JString; cdecl;
    function getSelectionArgs: TJavaObjectArray<JString>; cdecl;
    function getSortOrder: JString; cdecl;
    function getUri: Jnet_Uri; cdecl;
    function loadInBackground: JCursor; cdecl;
    procedure onCanceled(cursor: JCursor); cdecl;
    procedure setProjection(projection: TJavaObjectArray<JString>); cdecl;
    procedure setSelection(selection: JString); cdecl;
    procedure setSelectionArgs(selectionArgs: TJavaObjectArray<JString>); cdecl;
    procedure setSortOrder(sortOrder: JString); cdecl;
    procedure setUri(uri: Jnet_Uri); cdecl;
  end;
  TJCursorLoader = class(TJavaGenericImport<JCursorLoaderClass, JCursorLoader>) end;

  JDialogInterfaceClass = interface(IJavaClass)
    ['{674BCC17-38EE-4151-90EE-AC3AB6DCB0F1}']
    {class} function _GetBUTTON1: Integer; cdecl;
    {class} function _GetBUTTON2: Integer; cdecl;
    {class} function _GetBUTTON3: Integer; cdecl;
    {class} function _GetBUTTON_NEGATIVE: Integer; cdecl;
    {class} function _GetBUTTON_NEUTRAL: Integer; cdecl;
    {class} function _GetBUTTON_POSITIVE: Integer; cdecl;
    {class} property BUTTON1: Integer read _GetBUTTON1;
    {class} property BUTTON2: Integer read _GetBUTTON2;
    {class} property BUTTON3: Integer read _GetBUTTON3;
    {class} property BUTTON_NEGATIVE: Integer read _GetBUTTON_NEGATIVE;
    {class} property BUTTON_NEUTRAL: Integer read _GetBUTTON_NEUTRAL;
    {class} property BUTTON_POSITIVE: Integer read _GetBUTTON_POSITIVE;
  end;

  [JavaSignature('android/content/DialogInterface')]
  JDialogInterface = interface(IJavaInstance)
    ['{91B070BB-6395-468C-8316-A32E4A2AD21A}']
    procedure cancel; cdecl;
    procedure dismiss; cdecl;
  end;
  TJDialogInterface = class(TJavaGenericImport<JDialogInterfaceClass, JDialogInterface>) end;

  JDialogInterface_OnCancelListenerClass = interface(IJavaClass)
    ['{8ADC670B-1399-439A-A691-7CAC7D2550BD}']
  end;

  [JavaSignature('android/content/DialogInterface$OnCancelListener')]
  JDialogInterface_OnCancelListener = interface(IJavaInstance)
    ['{7FB8830E-FACE-4BF7-9D67-B2FBF5D1AF48}']
    procedure onCancel(dialog: JDialogInterface); cdecl;
  end;
  TJDialogInterface_OnCancelListener = class(TJavaGenericImport<JDialogInterface_OnCancelListenerClass, JDialogInterface_OnCancelListener>) end;

  JDialogInterface_OnClickListenerClass = interface(IJavaClass)
    ['{4D55282C-7A9D-43DB-879D-2C1EFC59953E}']
  end;

  [JavaSignature('android/content/DialogInterface$OnClickListener')]
  JDialogInterface_OnClickListener = interface(IJavaInstance)
    ['{060B7391-D53F-4BAD-A491-5D50CED3CF9A}']
    procedure onClick(dialog: JDialogInterface; which: Integer); cdecl;
  end;
  TJDialogInterface_OnClickListener = class(TJavaGenericImport<JDialogInterface_OnClickListenerClass, JDialogInterface_OnClickListener>) end;

  JDialogInterface_OnDismissListenerClass = interface(IJavaClass)
    ['{0B4A6A73-99E6-459A-95A7-C7664815AE0A}']
  end;

  [JavaSignature('android/content/DialogInterface$OnDismissListener')]
  JDialogInterface_OnDismissListener = interface(IJavaInstance)
    ['{C7D62CC4-0CA6-4071-AA11-54CB0F74EB1F}']
    procedure onDismiss(dialog: JDialogInterface); cdecl;
  end;
  TJDialogInterface_OnDismissListener = class(TJavaGenericImport<JDialogInterface_OnDismissListenerClass, JDialogInterface_OnDismissListener>) end;

  JDialogInterface_OnKeyListenerClass = interface(IJavaClass)
    ['{F95ED60A-27E5-4A1C-8081-E4646C4AF61D}']
  end;

  [JavaSignature('android/content/DialogInterface$OnKeyListener')]
  JDialogInterface_OnKeyListener = interface(IJavaInstance)
    ['{597D3989-B3F3-4AE2-8521-1D1141FBE3E3}']
    function onKey(dialog: JDialogInterface; keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
  end;
  TJDialogInterface_OnKeyListener = class(TJavaGenericImport<JDialogInterface_OnKeyListenerClass, JDialogInterface_OnKeyListener>) end;

  JDialogInterface_OnMultiChoiceClickListenerClass = interface(IJavaClass)
    ['{0B3FADA0-DBF9-43B2-BDEC-0B121B4AA408}']
  end;

  [JavaSignature('android/content/DialogInterface$OnMultiChoiceClickListener')]
  JDialogInterface_OnMultiChoiceClickListener = interface(IJavaInstance)
    ['{1BA26A6B-931A-4FC3-AB72-898AD26FC476}']
    procedure onClick(dialog: JDialogInterface; which: Integer; isChecked: Boolean); cdecl;
  end;
  TJDialogInterface_OnMultiChoiceClickListener = class(TJavaGenericImport<JDialogInterface_OnMultiChoiceClickListenerClass, JDialogInterface_OnMultiChoiceClickListener>) end;

  JDialogInterface_OnShowListenerClass = interface(IJavaClass)
    ['{88EC37A6-8599-4E19-8F35-E10A8EEA97E1}']
  end;

  [JavaSignature('android/content/DialogInterface$OnShowListener')]
  JDialogInterface_OnShowListener = interface(IJavaInstance)
    ['{09556630-5FED-493C-A1C0-C42612C7CEDB}']
    procedure onShow(dialog: JDialogInterface); cdecl;
  end;
  TJDialogInterface_OnShowListener = class(TJavaGenericImport<JDialogInterface_OnShowListenerClass, JDialogInterface_OnShowListener>) end;

  Jcontent_EntityClass = interface(JObjectClass)
    ['{9D8D5E64-FE08-490B-857C-AFE5884F7935}']
    {class} function init(values: JContentValues): Jcontent_Entity; cdecl;
  end;

  [JavaSignature('android/content/Entity')]
  Jcontent_Entity = interface(JObject)
    ['{8AE3B991-8A16-4BF0-8828-B2D86DD6D97F}']
    procedure addSubValue(uri: Jnet_Uri; values: JContentValues); cdecl;
    function getEntityValues: JContentValues; cdecl;
    function getSubValues: JArrayList; cdecl;
    function toString: JString; cdecl;
  end;
  TJcontent_Entity = class(TJavaGenericImport<Jcontent_EntityClass, Jcontent_Entity>) end;

  JEntity_NamedContentValuesClass = interface(JObjectClass)
    ['{609C9106-0DD5-4C76-8888-BBBE59539300}']
    {class} function init(uri: Jnet_Uri; values: JContentValues): JEntity_NamedContentValues; cdecl;
  end;

  [JavaSignature('android/content/Entity$NamedContentValues')]
  JEntity_NamedContentValues = interface(JObject)
    ['{F0B1D32C-F188-467C-A379-AD7A356D3C8A}']
    function _Geturi: Jnet_Uri; cdecl;
    function _Getvalues: JContentValues; cdecl;
    property uri: Jnet_Uri read _Geturi;
    property values: JContentValues read _Getvalues;
  end;
  TJEntity_NamedContentValues = class(TJavaGenericImport<JEntity_NamedContentValuesClass, JEntity_NamedContentValues>) end;

  JEntityIteratorClass = interface(JIteratorClass)
    ['{FDF5F378-C146-4798-B825-C95E2259B445}']
  end;

  [JavaSignature('android/content/EntityIterator')]
  JEntityIterator = interface(JIterator)
    ['{55F48181-11CC-4113-9930-C732F26A4814}']
    procedure close; cdecl;
    procedure reset; cdecl;
  end;
  TJEntityIterator = class(TJavaGenericImport<JEntityIteratorClass, JEntityIterator>) end;

  JIntentClass = interface(JObjectClass)
    ['{3FCF8E6F-7E34-46C1-9007-50B8C6479CE9}']
    {class} function _GetACTION_AIRPLANE_MODE_CHANGED: JString; cdecl;
    {class} function _GetACTION_ALL_APPS: JString; cdecl;
    {class} function _GetACTION_ANSWER: JString; cdecl;
    {class} function _GetACTION_APPLICATION_RESTRICTIONS_CHANGED: JString; cdecl;
    {class} function _GetACTION_APP_ERROR: JString; cdecl;
    {class} function _GetACTION_ASSIST: JString; cdecl;
    {class} function _GetACTION_ATTACH_DATA: JString; cdecl;
    {class} function _GetACTION_BATTERY_CHANGED: JString; cdecl;
    {class} function _GetACTION_BATTERY_LOW: JString; cdecl;
    {class} function _GetACTION_BATTERY_OKAY: JString; cdecl;
    {class} function _GetACTION_BOOT_COMPLETED: JString; cdecl;
    {class} function _GetACTION_BUG_REPORT: JString; cdecl;
    {class} function _GetACTION_CALL: JString; cdecl;
    {class} function _GetACTION_CALL_BUTTON: JString; cdecl;
    {class} function _GetACTION_CAMERA_BUTTON: JString; cdecl;
    {class} function _GetACTION_CHOOSER: JString; cdecl;
    {class} function _GetACTION_CLOSE_SYSTEM_DIALOGS: JString; cdecl;
    {class} function _GetACTION_CONFIGURATION_CHANGED: JString; cdecl;
    {class} function _GetACTION_CREATE_DOCUMENT: JString; cdecl;
    {class} function _GetACTION_CREATE_SHORTCUT: JString; cdecl;
    {class} function _GetACTION_DATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_DEFAULT: JString; cdecl;
    {class} function _GetACTION_DELETE: JString; cdecl;
    {class} function _GetACTION_DEVICE_STORAGE_LOW: JString; cdecl;
    {class} function _GetACTION_DEVICE_STORAGE_OK: JString; cdecl;
    {class} function _GetACTION_DIAL: JString; cdecl;
    {class} function _GetACTION_DOCK_EVENT: JString; cdecl;
    {class} function _GetACTION_DREAMING_STARTED: JString; cdecl;
    {class} function _GetACTION_DREAMING_STOPPED: JString; cdecl;
    {class} function _GetACTION_EDIT: JString; cdecl;
    {class} function _GetACTION_EXTERNAL_APPLICATIONS_AVAILABLE: JString; cdecl;
    {class} function _GetACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE: JString; cdecl;
    {class} function _GetACTION_FACTORY_TEST: JString; cdecl;
    {class} function _GetACTION_GET_CONTENT: JString; cdecl;
    {class} function _GetACTION_GET_RESTRICTION_ENTRIES: JString; cdecl;
    {class} function _GetACTION_GTALK_SERVICE_CONNECTED: JString; cdecl;
    {class} function _GetACTION_GTALK_SERVICE_DISCONNECTED: JString; cdecl;
    {class} function _GetACTION_HEADSET_PLUG: JString; cdecl;
    {class} function _GetACTION_INPUT_METHOD_CHANGED: JString; cdecl;
    {class} function _GetACTION_INSERT: JString; cdecl;
    {class} function _GetACTION_INSERT_OR_EDIT: JString; cdecl;
    {class} function _GetACTION_INSTALL_PACKAGE: JString; cdecl;
    {class} function _GetACTION_LOCALE_CHANGED: JString; cdecl;
    {class} function _GetACTION_MAIN: JString; cdecl;
    {class} function _GetACTION_MANAGED_PROFILE_ADDED: JString; cdecl;
    {class} function _GetACTION_MANAGED_PROFILE_REMOVED: JString; cdecl;
    {class} function _GetACTION_MANAGE_NETWORK_USAGE: JString; cdecl;
    {class} function _GetACTION_MANAGE_PACKAGE_STORAGE: JString; cdecl;
    {class} function _GetACTION_MEDIA_BAD_REMOVAL: JString; cdecl;
    {class} function _GetACTION_MEDIA_BUTTON: JString; cdecl;
    {class} function _GetACTION_MEDIA_CHECKING: JString; cdecl;
    {class} function _GetACTION_MEDIA_EJECT: JString; cdecl;
    {class} function _GetACTION_MEDIA_MOUNTED: JString; cdecl;
    {class} function _GetACTION_MEDIA_NOFS: JString; cdecl;
    {class} function _GetACTION_MEDIA_REMOVED: JString; cdecl;
    {class} function _GetACTION_MEDIA_SCANNER_FINISHED: JString; cdecl;
    {class} function _GetACTION_MEDIA_SCANNER_SCAN_FILE: JString; cdecl;
    {class} function _GetACTION_MEDIA_SCANNER_STARTED: JString; cdecl;
    {class} function _GetACTION_MEDIA_SHARED: JString; cdecl;
    {class} function _GetACTION_MEDIA_UNMOUNTABLE: JString; cdecl;
    {class} function _GetACTION_MEDIA_UNMOUNTED: JString; cdecl;
    {class} function _GetACTION_MY_PACKAGE_REPLACED: JString; cdecl;
    {class} function _GetACTION_NEW_OUTGOING_CALL: JString; cdecl;
    {class} function _GetACTION_OPEN_DOCUMENT: JString; cdecl;
    {class} function _GetACTION_OPEN_DOCUMENT_TREE: JString; cdecl;
    {class} function _GetACTION_PACKAGE_ADDED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_CHANGED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_DATA_CLEARED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_FIRST_LAUNCH: JString; cdecl;
    {class} function _GetACTION_PACKAGE_FULLY_REMOVED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_INSTALL: JString; cdecl;
    {class} function _GetACTION_PACKAGE_NEEDS_VERIFICATION: JString; cdecl;
    {class} function _GetACTION_PACKAGE_REMOVED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_REPLACED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_RESTARTED: JString; cdecl;
    {class} function _GetACTION_PACKAGE_VERIFIED: JString; cdecl;
    {class} function _GetACTION_PASTE: JString; cdecl;
    {class} function _GetACTION_PICK: JString; cdecl;
    {class} function _GetACTION_PICK_ACTIVITY: JString; cdecl;
    {class} function _GetACTION_POWER_CONNECTED: JString; cdecl;
    {class} function _GetACTION_POWER_DISCONNECTED: JString; cdecl;
    {class} function _GetACTION_POWER_USAGE_SUMMARY: JString; cdecl;
    {class} function _GetACTION_PROCESS_TEXT: JString; cdecl;
    {class} function _GetACTION_PROVIDER_CHANGED: JString; cdecl;
    {class} function _GetACTION_QUICK_CLOCK: JString; cdecl;
    {class} function _GetACTION_REBOOT: JString; cdecl;
    {class} function _GetACTION_RUN: JString; cdecl;
    {class} function _GetACTION_SCREEN_OFF: JString; cdecl;
    {class} function _GetACTION_SCREEN_ON: JString; cdecl;
    {class} function _GetACTION_SEARCH: JString; cdecl;
    {class} function _GetACTION_SEARCH_LONG_PRESS: JString; cdecl;
    {class} function _GetACTION_SEND: JString; cdecl;
    {class} function _GetACTION_SENDTO: JString; cdecl;
    {class} function _GetACTION_SEND_MULTIPLE: JString; cdecl;
    {class} function _GetACTION_SET_WALLPAPER: JString; cdecl;
    {class} function _GetACTION_SHUTDOWN: JString; cdecl;
    {class} function _GetACTION_SYNC: JString; cdecl;
    {class} function _GetACTION_SYSTEM_TUTORIAL: JString; cdecl;
    {class} function _GetACTION_TIMEZONE_CHANGED: JString; cdecl;
    {class} function _GetACTION_TIME_CHANGED: JString; cdecl;
    {class} function _GetACTION_TIME_TICK: JString; cdecl;
    {class} function _GetACTION_UID_REMOVED: JString; cdecl;
    {class} function _GetACTION_UMS_CONNECTED: JString; cdecl;
    {class} function _GetACTION_UMS_DISCONNECTED: JString; cdecl;
    {class} function _GetACTION_UNINSTALL_PACKAGE: JString; cdecl;
    {class} function _GetACTION_USER_BACKGROUND: JString; cdecl;
    {class} function _GetACTION_USER_FOREGROUND: JString; cdecl;
    {class} function _GetACTION_USER_INITIALIZE: JString; cdecl;
    {class} function _GetACTION_USER_PRESENT: JString; cdecl;
    {class} function _GetACTION_VIEW: JString; cdecl;
    {class} function _GetACTION_VOICE_COMMAND: JString; cdecl;
    {class} function _GetACTION_WALLPAPER_CHANGED: JString; cdecl;
    {class} function _GetACTION_WEB_SEARCH: JString; cdecl;
    {class} function _GetCATEGORY_ALTERNATIVE: JString; cdecl;
    {class} function _GetCATEGORY_APP_BROWSER: JString; cdecl;
    {class} function _GetCATEGORY_APP_CALCULATOR: JString; cdecl;
    {class} function _GetCATEGORY_APP_CALENDAR: JString; cdecl;
    {class} function _GetCATEGORY_APP_CONTACTS: JString; cdecl;
    {class} function _GetCATEGORY_APP_EMAIL: JString; cdecl;
    {class} function _GetCATEGORY_APP_GALLERY: JString; cdecl;
    {class} function _GetCATEGORY_APP_MAPS: JString; cdecl;
    {class} function _GetCATEGORY_APP_MARKET: JString; cdecl;
    {class} function _GetCATEGORY_APP_MESSAGING: JString; cdecl;
    {class} function _GetCATEGORY_APP_MUSIC: JString; cdecl;
    {class} function _GetCATEGORY_BROWSABLE: JString; cdecl;
    {class} function _GetCATEGORY_CAR_DOCK: JString; cdecl;
    {class} function _GetCATEGORY_CAR_MODE: JString; cdecl;
    {class} function _GetCATEGORY_DEFAULT: JString; cdecl;
    {class} function _GetCATEGORY_DESK_DOCK: JString; cdecl;
    {class} function _GetCATEGORY_DEVELOPMENT_PREFERENCE: JString; cdecl;
    {class} function _GetCATEGORY_EMBED: JString; cdecl;
    {class} function _GetCATEGORY_FRAMEWORK_INSTRUMENTATION_TEST: JString; cdecl;
    {class} function _GetCATEGORY_HE_DESK_DOCK: JString; cdecl;
    {class} function _GetCATEGORY_HOME: JString; cdecl;
    {class} function _GetCATEGORY_INFO: JString; cdecl;
    {class} function _GetCATEGORY_LAUNCHER: JString; cdecl;
    {class} function _GetCATEGORY_LEANBACK_LAUNCHER: JString; cdecl;
    {class} function _GetCATEGORY_LE_DESK_DOCK: JString; cdecl;
    {class} function _GetCATEGORY_MONKEY: JString; cdecl;
    {class} function _GetCATEGORY_OPENABLE: JString; cdecl;
    {class} function _GetCATEGORY_PREFERENCE: JString; cdecl;
    {class} function _GetCATEGORY_SAMPLE_CODE: JString; cdecl;
    {class} function _GetCATEGORY_SELECTED_ALTERNATIVE: JString; cdecl;
    {class} function _GetCATEGORY_TAB: JString; cdecl;
    {class} function _GetCATEGORY_TEST: JString; cdecl;
    {class} function _GetCATEGORY_UNIT_TEST: JString; cdecl;
    {class} function _GetCATEGORY_VOICE: JString; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetEXTRA_ALARM_COUNT: JString; cdecl;
    {class} function _GetEXTRA_ALLOW_MULTIPLE: JString; cdecl;
    {class} function _GetEXTRA_ALLOW_REPLACE: JString; cdecl;
    {class} function _GetEXTRA_ALTERNATE_INTENTS: JString; cdecl;
    {class} function _GetEXTRA_ASSIST_CONTEXT: JString; cdecl;
    {class} function _GetEXTRA_ASSIST_INPUT_DEVICE_ID: JString; cdecl;
    {class} function _GetEXTRA_ASSIST_INPUT_HINT_KEYBOARD: JString; cdecl;
    {class} function _GetEXTRA_ASSIST_PACKAGE: JString; cdecl;
    {class} function _GetEXTRA_ASSIST_UID: JString; cdecl;
    {class} function _GetEXTRA_BCC: JString; cdecl;
    {class} function _GetEXTRA_BUG_REPORT: JString; cdecl;
    {class} function _GetEXTRA_CC: JString; cdecl;
    {class} function _GetEXTRA_CHANGED_COMPONENT_NAME: JString; cdecl;
    {class} function _GetEXTRA_CHANGED_COMPONENT_NAME_LIST: JString; cdecl;
    {class} function _GetEXTRA_CHANGED_PACKAGE_LIST: JString; cdecl;
    {class} function _GetEXTRA_CHANGED_UID_LIST: JString; cdecl;
    {class} function _GetEXTRA_CHOOSER_REFINEMENT_INTENT_SENDER: JString; cdecl;
    {class} function _GetEXTRA_CHOSEN_COMPONENT: JString; cdecl;
    {class} function _GetEXTRA_CHOSEN_COMPONENT_INTENT_SENDER: JString; cdecl;
    {class} function _GetEXTRA_DATA_REMOVED: JString; cdecl;
    {class} function _GetEXTRA_DOCK_STATE: JString; cdecl;
    {class} function _GetEXTRA_DOCK_STATE_CAR: Integer; cdecl;
    {class} function _GetEXTRA_DOCK_STATE_DESK: Integer; cdecl;
    {class} function _GetEXTRA_DOCK_STATE_HE_DESK: Integer; cdecl;
    {class} function _GetEXTRA_DOCK_STATE_LE_DESK: Integer; cdecl;
    {class} function _GetEXTRA_DOCK_STATE_UNDOCKED: Integer; cdecl;
    {class} function _GetEXTRA_DONT_KILL_APP: JString; cdecl;
    {class} function _GetEXTRA_EMAIL: JString; cdecl;
    {class} function _GetEXTRA_HTML_TEXT: JString; cdecl;
    {class} function _GetEXTRA_INITIAL_INTENTS: JString; cdecl;
    {class} function _GetEXTRA_INSTALLER_PACKAGE_NAME: JString; cdecl;
    {class} function _GetEXTRA_INTENT: JString; cdecl;
    {class} function _GetEXTRA_KEY_EVENT: JString; cdecl;
    {class} function _GetEXTRA_LOCAL_ONLY: JString; cdecl;
    {class} function _GetEXTRA_MIME_TYPES: JString; cdecl;
    {class} function _GetEXTRA_NOT_UNKNOWN_SOURCE: JString; cdecl;
    {class} function _GetEXTRA_ORIGINATING_URI: JString; cdecl;
    {class} function _GetEXTRA_PHONE_NUMBER: JString; cdecl;
    {class} function _GetEXTRA_PROCESS_TEXT: JString; cdecl;
    {class} function _GetEXTRA_PROCESS_TEXT_READONLY: JString; cdecl;
    {class} function _GetEXTRA_REFERRER: JString; cdecl;
    {class} function _GetEXTRA_REFERRER_NAME: JString; cdecl;
    {class} function _GetEXTRA_REMOTE_INTENT_TOKEN: JString; cdecl;
    {class} function _GetEXTRA_REPLACEMENT_EXTRAS: JString; cdecl;
    {class} function _GetEXTRA_REPLACING: JString; cdecl;
    {class} function _GetEXTRA_RESTRICTIONS_BUNDLE: JString; cdecl;
    {class} function _GetEXTRA_RESTRICTIONS_INTENT: JString; cdecl;
    {class} function _GetEXTRA_RESTRICTIONS_LIST: JString; cdecl;
    {class} function _GetEXTRA_RESULT_RECEIVER: JString; cdecl;
    {class} function _GetEXTRA_RETURN_RESULT: JString; cdecl;
    {class} function _GetEXTRA_SHORTCUT_ICON: JString; cdecl;
    {class} function _GetEXTRA_SHORTCUT_ICON_RESOURCE: JString; cdecl;
    {class} function _GetEXTRA_SHORTCUT_INTENT: JString; cdecl;
    {class} function _GetEXTRA_SHORTCUT_NAME: JString; cdecl;
    {class} function _GetEXTRA_SHUTDOWN_USERSPACE_ONLY: JString; cdecl;
    {class} function _GetEXTRA_STREAM: JString; cdecl;
    {class} function _GetEXTRA_SUBJECT: JString; cdecl;
    {class} function _GetEXTRA_TEMPLATE: JString; cdecl;
    {class} function _GetEXTRA_TEXT: JString; cdecl;
    {class} function _GetEXTRA_TITLE: JString; cdecl;
    {class} function _GetEXTRA_UID: JString; cdecl;
    {class} function _GetEXTRA_USER: JString; cdecl;
    {class} function _GetFILL_IN_ACTION: Integer; cdecl;
    {class} function _GetFILL_IN_CATEGORIES: Integer; cdecl;
    {class} function _GetFILL_IN_CLIP_DATA: Integer; cdecl;
    {class} function _GetFILL_IN_COMPONENT: Integer; cdecl;
    {class} function _GetFILL_IN_DATA: Integer; cdecl;
    {class} function _GetFILL_IN_PACKAGE: Integer; cdecl;
    {class} function _GetFILL_IN_SELECTOR: Integer; cdecl;
    {class} function _GetFILL_IN_SOURCE_BOUNDS: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_BROUGHT_TO_FRONT: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_CLEAR_TASK: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_CLEAR_TOP: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_EXCLUDE_FROM_RECENTS: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_FORWARD_RESULT: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_LAUNCHED_FROM_HISTORY: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_MULTIPLE_TASK: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_NEW_DOCUMENT: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_NEW_TASK: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_NO_ANIMATION: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_NO_HISTORY: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_NO_USER_ACTION: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_PREVIOUS_IS_TOP: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_REORDER_TO_FRONT: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_RESET_TASK_IF_NEEDED: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_RETAIN_IN_RECENTS: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_SINGLE_TOP: Integer; cdecl;
    {class} function _GetFLAG_ACTIVITY_TASK_ON_HOME: Integer; cdecl;
    {class} function _GetFLAG_DEBUG_LOG_RESOLUTION: Integer; cdecl;
    {class} function _GetFLAG_EXCLUDE_STOPPED_PACKAGES: Integer; cdecl;
    {class} function _GetFLAG_FROM_BACKGROUND: Integer; cdecl;
    {class} function _GetFLAG_GRANT_PERSISTABLE_URI_PERMISSION: Integer; cdecl;
    {class} function _GetFLAG_GRANT_PREFIX_URI_PERMISSION: Integer; cdecl;
    {class} function _GetFLAG_GRANT_READ_URI_PERMISSION: Integer; cdecl;
    {class} function _GetFLAG_GRANT_WRITE_URI_PERMISSION: Integer; cdecl;
    {class} function _GetFLAG_INCLUDE_STOPPED_PACKAGES: Integer; cdecl;
    {class} function _GetFLAG_RECEIVER_FOREGROUND: Integer; cdecl;
    {class} function _GetFLAG_RECEIVER_NO_ABORT: Integer; cdecl;
    {class} function _GetFLAG_RECEIVER_REGISTERED_ONLY: Integer; cdecl;
    {class} function _GetFLAG_RECEIVER_REPLACE_PENDING: Integer; cdecl;
    {class} function _GetMETADATA_DOCK_HOME: JString; cdecl;
    {class} function _GetURI_ALLOW_UNSAFE: Integer; cdecl;
    {class} function _GetURI_ANDROID_APP_SCHEME: Integer; cdecl;
    {class} function _GetURI_INTENT_SCHEME: Integer; cdecl;
    {class} function init: JIntent; cdecl; overload;
    {class} function init(o: JIntent): JIntent; cdecl; overload;
    {class} function init(action: JString): JIntent; cdecl; overload;
    {class} function init(action: JString; uri: Jnet_Uri): JIntent; cdecl; overload;
    {class} function init(packageContext: JContext; cls: Jlang_Class): JIntent; cdecl; overload;
    {class} function init(action: JString; uri: Jnet_Uri; packageContext: JContext; cls: Jlang_Class): JIntent; cdecl; overload;
    {class} function createChooser(target: JIntent; title: JCharSequence): JIntent; cdecl; overload;
    {class} function createChooser(target: JIntent; title: JCharSequence; sender: JIntentSender): JIntent; cdecl; overload;
    {class} function getIntent(uri: JString): JIntent; cdecl;//Deprecated
    {class} function getIntentOld(uri: JString): JIntent; cdecl;
    {class} function makeMainActivity(mainActivity: JComponentName): JIntent; cdecl;
    {class} function makeMainSelectorActivity(selectorAction: JString; selectorCategory: JString): JIntent; cdecl;
    {class} function makeRestartActivityTask(mainActivity: JComponentName): JIntent; cdecl;
    {class} function normalizeMimeType(type_: JString): JString; cdecl;
    {class} function parseIntent(resources: JResources; parser: JXmlPullParser; attrs: JAttributeSet): JIntent; cdecl;
    {class} function parseUri(uri: JString; flags: Integer): JIntent; cdecl;
    {class} property ACTION_AIRPLANE_MODE_CHANGED: JString read _GetACTION_AIRPLANE_MODE_CHANGED;
    {class} property ACTION_ALL_APPS: JString read _GetACTION_ALL_APPS;
    {class} property ACTION_ANSWER: JString read _GetACTION_ANSWER;
    {class} property ACTION_APPLICATION_RESTRICTIONS_CHANGED: JString read _GetACTION_APPLICATION_RESTRICTIONS_CHANGED;
    {class} property ACTION_APP_ERROR: JString read _GetACTION_APP_ERROR;
    {class} property ACTION_ASSIST: JString read _GetACTION_ASSIST;
    {class} property ACTION_ATTACH_DATA: JString read _GetACTION_ATTACH_DATA;
    {class} property ACTION_BATTERY_CHANGED: JString read _GetACTION_BATTERY_CHANGED;
    {class} property ACTION_BATTERY_LOW: JString read _GetACTION_BATTERY_LOW;
    {class} property ACTION_BATTERY_OKAY: JString read _GetACTION_BATTERY_OKAY;
    {class} property ACTION_BOOT_COMPLETED: JString read _GetACTION_BOOT_COMPLETED;
    {class} property ACTION_BUG_REPORT: JString read _GetACTION_BUG_REPORT;
    {class} property ACTION_CALL: JString read _GetACTION_CALL;
    {class} property ACTION_CALL_BUTTON: JString read _GetACTION_CALL_BUTTON;
    {class} property ACTION_CAMERA_BUTTON: JString read _GetACTION_CAMERA_BUTTON;
    {class} property ACTION_CHOOSER: JString read _GetACTION_CHOOSER;
    {class} property ACTION_CLOSE_SYSTEM_DIALOGS: JString read _GetACTION_CLOSE_SYSTEM_DIALOGS;
    {class} property ACTION_CONFIGURATION_CHANGED: JString read _GetACTION_CONFIGURATION_CHANGED;
    {class} property ACTION_CREATE_DOCUMENT: JString read _GetACTION_CREATE_DOCUMENT;
    {class} property ACTION_CREATE_SHORTCUT: JString read _GetACTION_CREATE_SHORTCUT;
    {class} property ACTION_DATE_CHANGED: JString read _GetACTION_DATE_CHANGED;
    {class} property ACTION_DEFAULT: JString read _GetACTION_DEFAULT;
    {class} property ACTION_DELETE: JString read _GetACTION_DELETE;
    {class} property ACTION_DEVICE_STORAGE_LOW: JString read _GetACTION_DEVICE_STORAGE_LOW;
    {class} property ACTION_DEVICE_STORAGE_OK: JString read _GetACTION_DEVICE_STORAGE_OK;
    {class} property ACTION_DIAL: JString read _GetACTION_DIAL;
    {class} property ACTION_DOCK_EVENT: JString read _GetACTION_DOCK_EVENT;
    {class} property ACTION_DREAMING_STARTED: JString read _GetACTION_DREAMING_STARTED;
    {class} property ACTION_DREAMING_STOPPED: JString read _GetACTION_DREAMING_STOPPED;
    {class} property ACTION_EDIT: JString read _GetACTION_EDIT;
    {class} property ACTION_EXTERNAL_APPLICATIONS_AVAILABLE: JString read _GetACTION_EXTERNAL_APPLICATIONS_AVAILABLE;
    {class} property ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE: JString read _GetACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE;
    {class} property ACTION_FACTORY_TEST: JString read _GetACTION_FACTORY_TEST;
    {class} property ACTION_GET_CONTENT: JString read _GetACTION_GET_CONTENT;
    {class} property ACTION_GET_RESTRICTION_ENTRIES: JString read _GetACTION_GET_RESTRICTION_ENTRIES;
    {class} property ACTION_GTALK_SERVICE_CONNECTED: JString read _GetACTION_GTALK_SERVICE_CONNECTED;
    {class} property ACTION_GTALK_SERVICE_DISCONNECTED: JString read _GetACTION_GTALK_SERVICE_DISCONNECTED;
    {class} property ACTION_HEADSET_PLUG: JString read _GetACTION_HEADSET_PLUG;
    {class} property ACTION_INPUT_METHOD_CHANGED: JString read _GetACTION_INPUT_METHOD_CHANGED;
    {class} property ACTION_INSERT: JString read _GetACTION_INSERT;
    {class} property ACTION_INSERT_OR_EDIT: JString read _GetACTION_INSERT_OR_EDIT;
    {class} property ACTION_INSTALL_PACKAGE: JString read _GetACTION_INSTALL_PACKAGE;
    {class} property ACTION_LOCALE_CHANGED: JString read _GetACTION_LOCALE_CHANGED;
    {class} property ACTION_MAIN: JString read _GetACTION_MAIN;
    {class} property ACTION_MANAGED_PROFILE_ADDED: JString read _GetACTION_MANAGED_PROFILE_ADDED;
    {class} property ACTION_MANAGED_PROFILE_REMOVED: JString read _GetACTION_MANAGED_PROFILE_REMOVED;
    {class} property ACTION_MANAGE_NETWORK_USAGE: JString read _GetACTION_MANAGE_NETWORK_USAGE;
    {class} property ACTION_MANAGE_PACKAGE_STORAGE: JString read _GetACTION_MANAGE_PACKAGE_STORAGE;
    {class} property ACTION_MEDIA_BAD_REMOVAL: JString read _GetACTION_MEDIA_BAD_REMOVAL;
    {class} property ACTION_MEDIA_BUTTON: JString read _GetACTION_MEDIA_BUTTON;
    {class} property ACTION_MEDIA_CHECKING: JString read _GetACTION_MEDIA_CHECKING;
    {class} property ACTION_MEDIA_EJECT: JString read _GetACTION_MEDIA_EJECT;
    {class} property ACTION_MEDIA_MOUNTED: JString read _GetACTION_MEDIA_MOUNTED;
    {class} property ACTION_MEDIA_NOFS: JString read _GetACTION_MEDIA_NOFS;
    {class} property ACTION_MEDIA_REMOVED: JString read _GetACTION_MEDIA_REMOVED;
    {class} property ACTION_MEDIA_SCANNER_FINISHED: JString read _GetACTION_MEDIA_SCANNER_FINISHED;
    {class} property ACTION_MEDIA_SCANNER_SCAN_FILE: JString read _GetACTION_MEDIA_SCANNER_SCAN_FILE;
    {class} property ACTION_MEDIA_SCANNER_STARTED: JString read _GetACTION_MEDIA_SCANNER_STARTED;
    {class} property ACTION_MEDIA_SHARED: JString read _GetACTION_MEDIA_SHARED;
    {class} property ACTION_MEDIA_UNMOUNTABLE: JString read _GetACTION_MEDIA_UNMOUNTABLE;
    {class} property ACTION_MEDIA_UNMOUNTED: JString read _GetACTION_MEDIA_UNMOUNTED;
    {class} property ACTION_MY_PACKAGE_REPLACED: JString read _GetACTION_MY_PACKAGE_REPLACED;
    {class} property ACTION_NEW_OUTGOING_CALL: JString read _GetACTION_NEW_OUTGOING_CALL;
    {class} property ACTION_OPEN_DOCUMENT: JString read _GetACTION_OPEN_DOCUMENT;
    {class} property ACTION_OPEN_DOCUMENT_TREE: JString read _GetACTION_OPEN_DOCUMENT_TREE;
    {class} property ACTION_PACKAGE_ADDED: JString read _GetACTION_PACKAGE_ADDED;
    {class} property ACTION_PACKAGE_CHANGED: JString read _GetACTION_PACKAGE_CHANGED;
    {class} property ACTION_PACKAGE_DATA_CLEARED: JString read _GetACTION_PACKAGE_DATA_CLEARED;
    {class} property ACTION_PACKAGE_FIRST_LAUNCH: JString read _GetACTION_PACKAGE_FIRST_LAUNCH;
    {class} property ACTION_PACKAGE_FULLY_REMOVED: JString read _GetACTION_PACKAGE_FULLY_REMOVED;
    {class} property ACTION_PACKAGE_INSTALL: JString read _GetACTION_PACKAGE_INSTALL;
    {class} property ACTION_PACKAGE_NEEDS_VERIFICATION: JString read _GetACTION_PACKAGE_NEEDS_VERIFICATION;
    {class} property ACTION_PACKAGE_REMOVED: JString read _GetACTION_PACKAGE_REMOVED;
    {class} property ACTION_PACKAGE_REPLACED: JString read _GetACTION_PACKAGE_REPLACED;
    {class} property ACTION_PACKAGE_RESTARTED: JString read _GetACTION_PACKAGE_RESTARTED;
    {class} property ACTION_PACKAGE_VERIFIED: JString read _GetACTION_PACKAGE_VERIFIED;
    {class} property ACTION_PASTE: JString read _GetACTION_PASTE;
    {class} property ACTION_PICK: JString read _GetACTION_PICK;
    {class} property ACTION_PICK_ACTIVITY: JString read _GetACTION_PICK_ACTIVITY;
    {class} property ACTION_POWER_CONNECTED: JString read _GetACTION_POWER_CONNECTED;
    {class} property ACTION_POWER_DISCONNECTED: JString read _GetACTION_POWER_DISCONNECTED;
    {class} property ACTION_POWER_USAGE_SUMMARY: JString read _GetACTION_POWER_USAGE_SUMMARY;
    {class} property ACTION_PROCESS_TEXT: JString read _GetACTION_PROCESS_TEXT;
    {class} property ACTION_PROVIDER_CHANGED: JString read _GetACTION_PROVIDER_CHANGED;
    {class} property ACTION_QUICK_CLOCK: JString read _GetACTION_QUICK_CLOCK;
    {class} property ACTION_REBOOT: JString read _GetACTION_REBOOT;
    {class} property ACTION_RUN: JString read _GetACTION_RUN;
    {class} property ACTION_SCREEN_OFF: JString read _GetACTION_SCREEN_OFF;
    {class} property ACTION_SCREEN_ON: JString read _GetACTION_SCREEN_ON;
    {class} property ACTION_SEARCH: JString read _GetACTION_SEARCH;
    {class} property ACTION_SEARCH_LONG_PRESS: JString read _GetACTION_SEARCH_LONG_PRESS;
    {class} property ACTION_SEND: JString read _GetACTION_SEND;
    {class} property ACTION_SENDTO: JString read _GetACTION_SENDTO;
    {class} property ACTION_SEND_MULTIPLE: JString read _GetACTION_SEND_MULTIPLE;
    {class} property ACTION_SET_WALLPAPER: JString read _GetACTION_SET_WALLPAPER;
    {class} property ACTION_SHUTDOWN: JString read _GetACTION_SHUTDOWN;
    {class} property ACTION_SYNC: JString read _GetACTION_SYNC;
    {class} property ACTION_SYSTEM_TUTORIAL: JString read _GetACTION_SYSTEM_TUTORIAL;
    {class} property ACTION_TIMEZONE_CHANGED: JString read _GetACTION_TIMEZONE_CHANGED;
    {class} property ACTION_TIME_CHANGED: JString read _GetACTION_TIME_CHANGED;
    {class} property ACTION_TIME_TICK: JString read _GetACTION_TIME_TICK;
    {class} property ACTION_UID_REMOVED: JString read _GetACTION_UID_REMOVED;
    {class} property ACTION_UMS_CONNECTED: JString read _GetACTION_UMS_CONNECTED;
    {class} property ACTION_UMS_DISCONNECTED: JString read _GetACTION_UMS_DISCONNECTED;
    {class} property ACTION_UNINSTALL_PACKAGE: JString read _GetACTION_UNINSTALL_PACKAGE;
    {class} property ACTION_USER_BACKGROUND: JString read _GetACTION_USER_BACKGROUND;
    {class} property ACTION_USER_FOREGROUND: JString read _GetACTION_USER_FOREGROUND;
    {class} property ACTION_USER_INITIALIZE: JString read _GetACTION_USER_INITIALIZE;
    {class} property ACTION_USER_PRESENT: JString read _GetACTION_USER_PRESENT;
    {class} property ACTION_VIEW: JString read _GetACTION_VIEW;
    {class} property ACTION_VOICE_COMMAND: JString read _GetACTION_VOICE_COMMAND;
    {class} property ACTION_WALLPAPER_CHANGED: JString read _GetACTION_WALLPAPER_CHANGED;
    {class} property ACTION_WEB_SEARCH: JString read _GetACTION_WEB_SEARCH;
    {class} property CATEGORY_ALTERNATIVE: JString read _GetCATEGORY_ALTERNATIVE;
    {class} property CATEGORY_APP_BROWSER: JString read _GetCATEGORY_APP_BROWSER;
    {class} property CATEGORY_APP_CALCULATOR: JString read _GetCATEGORY_APP_CALCULATOR;
    {class} property CATEGORY_APP_CALENDAR: JString read _GetCATEGORY_APP_CALENDAR;
    {class} property CATEGORY_APP_CONTACTS: JString read _GetCATEGORY_APP_CONTACTS;
    {class} property CATEGORY_APP_EMAIL: JString read _GetCATEGORY_APP_EMAIL;
    {class} property CATEGORY_APP_GALLERY: JString read _GetCATEGORY_APP_GALLERY;
    {class} property CATEGORY_APP_MAPS: JString read _GetCATEGORY_APP_MAPS;
    {class} property CATEGORY_APP_MARKET: JString read _GetCATEGORY_APP_MARKET;
    {class} property CATEGORY_APP_MESSAGING: JString read _GetCATEGORY_APP_MESSAGING;
    {class} property CATEGORY_APP_MUSIC: JString read _GetCATEGORY_APP_MUSIC;
    {class} property CATEGORY_BROWSABLE: JString read _GetCATEGORY_BROWSABLE;
    {class} property CATEGORY_CAR_DOCK: JString read _GetCATEGORY_CAR_DOCK;
    {class} property CATEGORY_CAR_MODE: JString read _GetCATEGORY_CAR_MODE;
    {class} property CATEGORY_DEFAULT: JString read _GetCATEGORY_DEFAULT;
    {class} property CATEGORY_DESK_DOCK: JString read _GetCATEGORY_DESK_DOCK;
    {class} property CATEGORY_DEVELOPMENT_PREFERENCE: JString read _GetCATEGORY_DEVELOPMENT_PREFERENCE;
    {class} property CATEGORY_EMBED: JString read _GetCATEGORY_EMBED;
    {class} property CATEGORY_FRAMEWORK_INSTRUMENTATION_TEST: JString read _GetCATEGORY_FRAMEWORK_INSTRUMENTATION_TEST;
    {class} property CATEGORY_HE_DESK_DOCK: JString read _GetCATEGORY_HE_DESK_DOCK;
    {class} property CATEGORY_HOME: JString read _GetCATEGORY_HOME;
    {class} property CATEGORY_INFO: JString read _GetCATEGORY_INFO;
    {class} property CATEGORY_LAUNCHER: JString read _GetCATEGORY_LAUNCHER;
    {class} property CATEGORY_LEANBACK_LAUNCHER: JString read _GetCATEGORY_LEANBACK_LAUNCHER;
    {class} property CATEGORY_LE_DESK_DOCK: JString read _GetCATEGORY_LE_DESK_DOCK;
    {class} property CATEGORY_MONKEY: JString read _GetCATEGORY_MONKEY;
    {class} property CATEGORY_OPENABLE: JString read _GetCATEGORY_OPENABLE;
    {class} property CATEGORY_PREFERENCE: JString read _GetCATEGORY_PREFERENCE;
    {class} property CATEGORY_SAMPLE_CODE: JString read _GetCATEGORY_SAMPLE_CODE;
    {class} property CATEGORY_SELECTED_ALTERNATIVE: JString read _GetCATEGORY_SELECTED_ALTERNATIVE;
    {class} property CATEGORY_TAB: JString read _GetCATEGORY_TAB;
    {class} property CATEGORY_TEST: JString read _GetCATEGORY_TEST;
    {class} property CATEGORY_UNIT_TEST: JString read _GetCATEGORY_UNIT_TEST;
    {class} property CATEGORY_VOICE: JString read _GetCATEGORY_VOICE;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property EXTRA_ALARM_COUNT: JString read _GetEXTRA_ALARM_COUNT;
    {class} property EXTRA_ALLOW_MULTIPLE: JString read _GetEXTRA_ALLOW_MULTIPLE;
    {class} property EXTRA_ALLOW_REPLACE: JString read _GetEXTRA_ALLOW_REPLACE;
    {class} property EXTRA_ALTERNATE_INTENTS: JString read _GetEXTRA_ALTERNATE_INTENTS;
    {class} property EXTRA_ASSIST_CONTEXT: JString read _GetEXTRA_ASSIST_CONTEXT;
    {class} property EXTRA_ASSIST_INPUT_DEVICE_ID: JString read _GetEXTRA_ASSIST_INPUT_DEVICE_ID;
    {class} property EXTRA_ASSIST_INPUT_HINT_KEYBOARD: JString read _GetEXTRA_ASSIST_INPUT_HINT_KEYBOARD;
    {class} property EXTRA_ASSIST_PACKAGE: JString read _GetEXTRA_ASSIST_PACKAGE;
    {class} property EXTRA_ASSIST_UID: JString read _GetEXTRA_ASSIST_UID;
    {class} property EXTRA_BCC: JString read _GetEXTRA_BCC;
    {class} property EXTRA_BUG_REPORT: JString read _GetEXTRA_BUG_REPORT;
    {class} property EXTRA_CC: JString read _GetEXTRA_CC;
    {class} property EXTRA_CHANGED_COMPONENT_NAME: JString read _GetEXTRA_CHANGED_COMPONENT_NAME;
    {class} property EXTRA_CHANGED_COMPONENT_NAME_LIST: JString read _GetEXTRA_CHANGED_COMPONENT_NAME_LIST;
    {class} property EXTRA_CHANGED_PACKAGE_LIST: JString read _GetEXTRA_CHANGED_PACKAGE_LIST;
    {class} property EXTRA_CHANGED_UID_LIST: JString read _GetEXTRA_CHANGED_UID_LIST;
    {class} property EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER: JString read _GetEXTRA_CHOOSER_REFINEMENT_INTENT_SENDER;
    {class} property EXTRA_CHOSEN_COMPONENT: JString read _GetEXTRA_CHOSEN_COMPONENT;
    {class} property EXTRA_CHOSEN_COMPONENT_INTENT_SENDER: JString read _GetEXTRA_CHOSEN_COMPONENT_INTENT_SENDER;
    {class} property EXTRA_DATA_REMOVED: JString read _GetEXTRA_DATA_REMOVED;
    {class} property EXTRA_DOCK_STATE: JString read _GetEXTRA_DOCK_STATE;
    {class} property EXTRA_DOCK_STATE_CAR: Integer read _GetEXTRA_DOCK_STATE_CAR;
    {class} property EXTRA_DOCK_STATE_DESK: Integer read _GetEXTRA_DOCK_STATE_DESK;
    {class} property EXTRA_DOCK_STATE_HE_DESK: Integer read _GetEXTRA_DOCK_STATE_HE_DESK;
    {class} property EXTRA_DOCK_STATE_LE_DESK: Integer read _GetEXTRA_DOCK_STATE_LE_DESK;
    {class} property EXTRA_DOCK_STATE_UNDOCKED: Integer read _GetEXTRA_DOCK_STATE_UNDOCKED;
    {class} property EXTRA_DONT_KILL_APP: JString read _GetEXTRA_DONT_KILL_APP;
    {class} property EXTRA_EMAIL: JString read _GetEXTRA_EMAIL;
    {class} property EXTRA_HTML_TEXT: JString read _GetEXTRA_HTML_TEXT;
    {class} property EXTRA_INITIAL_INTENTS: JString read _GetEXTRA_INITIAL_INTENTS;
    {class} property EXTRA_INSTALLER_PACKAGE_NAME: JString read _GetEXTRA_INSTALLER_PACKAGE_NAME;
    {class} property EXTRA_INTENT: JString read _GetEXTRA_INTENT;
    {class} property EXTRA_KEY_EVENT: JString read _GetEXTRA_KEY_EVENT;
    {class} property EXTRA_LOCAL_ONLY: JString read _GetEXTRA_LOCAL_ONLY;
    {class} property EXTRA_MIME_TYPES: JString read _GetEXTRA_MIME_TYPES;
    {class} property EXTRA_NOT_UNKNOWN_SOURCE: JString read _GetEXTRA_NOT_UNKNOWN_SOURCE;
    {class} property EXTRA_ORIGINATING_URI: JString read _GetEXTRA_ORIGINATING_URI;
    {class} property EXTRA_PHONE_NUMBER: JString read _GetEXTRA_PHONE_NUMBER;
    {class} property EXTRA_PROCESS_TEXT: JString read _GetEXTRA_PROCESS_TEXT;
    {class} property EXTRA_PROCESS_TEXT_READONLY: JString read _GetEXTRA_PROCESS_TEXT_READONLY;
    {class} property EXTRA_REFERRER: JString read _GetEXTRA_REFERRER;
    {class} property EXTRA_REFERRER_NAME: JString read _GetEXTRA_REFERRER_NAME;
    {class} property EXTRA_REMOTE_INTENT_TOKEN: JString read _GetEXTRA_REMOTE_INTENT_TOKEN;
    {class} property EXTRA_REPLACEMENT_EXTRAS: JString read _GetEXTRA_REPLACEMENT_EXTRAS;
    {class} property EXTRA_REPLACING: JString read _GetEXTRA_REPLACING;
    {class} property EXTRA_RESTRICTIONS_BUNDLE: JString read _GetEXTRA_RESTRICTIONS_BUNDLE;
    {class} property EXTRA_RESTRICTIONS_INTENT: JString read _GetEXTRA_RESTRICTIONS_INTENT;
    {class} property EXTRA_RESTRICTIONS_LIST: JString read _GetEXTRA_RESTRICTIONS_LIST;
    {class} property EXTRA_RESULT_RECEIVER: JString read _GetEXTRA_RESULT_RECEIVER;
    {class} property EXTRA_RETURN_RESULT: JString read _GetEXTRA_RETURN_RESULT;
    {class} property EXTRA_SHORTCUT_ICON: JString read _GetEXTRA_SHORTCUT_ICON;
    {class} property EXTRA_SHORTCUT_ICON_RESOURCE: JString read _GetEXTRA_SHORTCUT_ICON_RESOURCE;
    {class} property EXTRA_SHORTCUT_INTENT: JString read _GetEXTRA_SHORTCUT_INTENT;
    {class} property EXTRA_SHORTCUT_NAME: JString read _GetEXTRA_SHORTCUT_NAME;
    {class} property EXTRA_SHUTDOWN_USERSPACE_ONLY: JString read _GetEXTRA_SHUTDOWN_USERSPACE_ONLY;
    {class} property EXTRA_STREAM: JString read _GetEXTRA_STREAM;
    {class} property EXTRA_SUBJECT: JString read _GetEXTRA_SUBJECT;
    {class} property EXTRA_TEMPLATE: JString read _GetEXTRA_TEMPLATE;
    {class} property EXTRA_TEXT: JString read _GetEXTRA_TEXT;
    {class} property EXTRA_TITLE: JString read _GetEXTRA_TITLE;
    {class} property EXTRA_UID: JString read _GetEXTRA_UID;
    {class} property EXTRA_USER: JString read _GetEXTRA_USER;
    {class} property FILL_IN_ACTION: Integer read _GetFILL_IN_ACTION;
    {class} property FILL_IN_CATEGORIES: Integer read _GetFILL_IN_CATEGORIES;
    {class} property FILL_IN_CLIP_DATA: Integer read _GetFILL_IN_CLIP_DATA;
    {class} property FILL_IN_COMPONENT: Integer read _GetFILL_IN_COMPONENT;
    {class} property FILL_IN_DATA: Integer read _GetFILL_IN_DATA;
    {class} property FILL_IN_PACKAGE: Integer read _GetFILL_IN_PACKAGE;
    {class} property FILL_IN_SELECTOR: Integer read _GetFILL_IN_SELECTOR;
    {class} property FILL_IN_SOURCE_BOUNDS: Integer read _GetFILL_IN_SOURCE_BOUNDS;
    {class} property FLAG_ACTIVITY_BROUGHT_TO_FRONT: Integer read _GetFLAG_ACTIVITY_BROUGHT_TO_FRONT;
    {class} property FLAG_ACTIVITY_CLEAR_TASK: Integer read _GetFLAG_ACTIVITY_CLEAR_TASK;
    {class} property FLAG_ACTIVITY_CLEAR_TOP: Integer read _GetFLAG_ACTIVITY_CLEAR_TOP;
    {class} property FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET: Integer read _GetFLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET;
    {class} property FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS: Integer read _GetFLAG_ACTIVITY_EXCLUDE_FROM_RECENTS;
    {class} property FLAG_ACTIVITY_FORWARD_RESULT: Integer read _GetFLAG_ACTIVITY_FORWARD_RESULT;
    {class} property FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY: Integer read _GetFLAG_ACTIVITY_LAUNCHED_FROM_HISTORY;
    {class} property FLAG_ACTIVITY_MULTIPLE_TASK: Integer read _GetFLAG_ACTIVITY_MULTIPLE_TASK;
    {class} property FLAG_ACTIVITY_NEW_DOCUMENT: Integer read _GetFLAG_ACTIVITY_NEW_DOCUMENT;
    {class} property FLAG_ACTIVITY_NEW_TASK: Integer read _GetFLAG_ACTIVITY_NEW_TASK;
    {class} property FLAG_ACTIVITY_NO_ANIMATION: Integer read _GetFLAG_ACTIVITY_NO_ANIMATION;
    {class} property FLAG_ACTIVITY_NO_HISTORY: Integer read _GetFLAG_ACTIVITY_NO_HISTORY;
    {class} property FLAG_ACTIVITY_NO_USER_ACTION: Integer read _GetFLAG_ACTIVITY_NO_USER_ACTION;
    {class} property FLAG_ACTIVITY_PREVIOUS_IS_TOP: Integer read _GetFLAG_ACTIVITY_PREVIOUS_IS_TOP;
    {class} property FLAG_ACTIVITY_REORDER_TO_FRONT: Integer read _GetFLAG_ACTIVITY_REORDER_TO_FRONT;
    {class} property FLAG_ACTIVITY_RESET_TASK_IF_NEEDED: Integer read _GetFLAG_ACTIVITY_RESET_TASK_IF_NEEDED;
    {class} property FLAG_ACTIVITY_RETAIN_IN_RECENTS: Integer read _GetFLAG_ACTIVITY_RETAIN_IN_RECENTS;
    {class} property FLAG_ACTIVITY_SINGLE_TOP: Integer read _GetFLAG_ACTIVITY_SINGLE_TOP;
    {class} property FLAG_ACTIVITY_TASK_ON_HOME: Integer read _GetFLAG_ACTIVITY_TASK_ON_HOME;
    {class} property FLAG_DEBUG_LOG_RESOLUTION: Integer read _GetFLAG_DEBUG_LOG_RESOLUTION;
    {class} property FLAG_EXCLUDE_STOPPED_PACKAGES: Integer read _GetFLAG_EXCLUDE_STOPPED_PACKAGES;
    {class} property FLAG_FROM_BACKGROUND: Integer read _GetFLAG_FROM_BACKGROUND;
    {class} property FLAG_GRANT_PERSISTABLE_URI_PERMISSION: Integer read _GetFLAG_GRANT_PERSISTABLE_URI_PERMISSION;
    {class} property FLAG_GRANT_PREFIX_URI_PERMISSION: Integer read _GetFLAG_GRANT_PREFIX_URI_PERMISSION;
    {class} property FLAG_GRANT_READ_URI_PERMISSION: Integer read _GetFLAG_GRANT_READ_URI_PERMISSION;
    {class} property FLAG_GRANT_WRITE_URI_PERMISSION: Integer read _GetFLAG_GRANT_WRITE_URI_PERMISSION;
    {class} property FLAG_INCLUDE_STOPPED_PACKAGES: Integer read _GetFLAG_INCLUDE_STOPPED_PACKAGES;
    {class} property FLAG_RECEIVER_FOREGROUND: Integer read _GetFLAG_RECEIVER_FOREGROUND;
    {class} property FLAG_RECEIVER_NO_ABORT: Integer read _GetFLAG_RECEIVER_NO_ABORT;
    {class} property FLAG_RECEIVER_REGISTERED_ONLY: Integer read _GetFLAG_RECEIVER_REGISTERED_ONLY;
    {class} property FLAG_RECEIVER_REPLACE_PENDING: Integer read _GetFLAG_RECEIVER_REPLACE_PENDING;
    {class} property METADATA_DOCK_HOME: JString read _GetMETADATA_DOCK_HOME;
    {class} property URI_ALLOW_UNSAFE: Integer read _GetURI_ALLOW_UNSAFE;
    {class} property URI_ANDROID_APP_SCHEME: Integer read _GetURI_ANDROID_APP_SCHEME;
    {class} property URI_INTENT_SCHEME: Integer read _GetURI_INTENT_SCHEME;
  end;

  [JavaSignature('android/content/Intent')]
  JIntent = interface(JObject)
    ['{022B0525-86CA-41C8-90D4-3559F098275A}']
    function addCategory(category: JString): JIntent; cdecl;
    function addFlags(flags: Integer): JIntent; cdecl;
    function clone: JObject; cdecl;
    function cloneFilter: JIntent; cdecl;
    function describeContents: Integer; cdecl;
    function fillIn(other: JIntent; flags: Integer): Integer; cdecl;
    function filterEquals(other: JIntent): Boolean; cdecl;
    function filterHashCode: Integer; cdecl;
    function getAction: JString; cdecl;
    function getBooleanArrayExtra(name: JString): TJavaArray<Boolean>; cdecl;
    function getBooleanExtra(name: JString; defaultValue: Boolean): Boolean; cdecl;
    function getBundleExtra(name: JString): JBundle; cdecl;
    function getByteArrayExtra(name: JString): TJavaArray<Byte>; cdecl;
    function getByteExtra(name: JString; defaultValue: Byte): Byte; cdecl;
    function getCategories: JSet; cdecl;
    function getCharArrayExtra(name: JString): TJavaArray<Char>; cdecl;
    function getCharExtra(name: JString; defaultValue: Char): Char; cdecl;
    function getCharSequenceArrayExtra(name: JString): TJavaObjectArray<JCharSequence>; cdecl;
    function getCharSequenceArrayListExtra(name: JString): JArrayList; cdecl;
    function getCharSequenceExtra(name: JString): JCharSequence; cdecl;
    function getClipData: JClipData; cdecl;
    function getComponent: JComponentName; cdecl;
    function getData: Jnet_Uri; cdecl;
    function getDataString: JString; cdecl;
    function getDoubleArrayExtra(name: JString): TJavaArray<Double>; cdecl;
    function getDoubleExtra(name: JString; defaultValue: Double): Double; cdecl;
    function getExtras: JBundle; cdecl;
    function getFlags: Integer; cdecl;
    function getFloatArrayExtra(name: JString): TJavaArray<Single>; cdecl;
    function getFloatExtra(name: JString; defaultValue: Single): Single; cdecl;
    function getIntArrayExtra(name: JString): TJavaArray<Integer>; cdecl;
    function getIntExtra(name: JString; defaultValue: Integer): Integer; cdecl;
    function getIntegerArrayListExtra(name: JString): JArrayList; cdecl;
    function getLongArrayExtra(name: JString): TJavaArray<Int64>; cdecl;
    function getLongExtra(name: JString; defaultValue: Int64): Int64; cdecl;
    function getPackage: JString; cdecl;
    function getParcelableArrayExtra(name: JString): TJavaObjectArray<JParcelable>; cdecl;
    function getParcelableArrayListExtra(name: JString): JArrayList; cdecl;
    function getParcelableExtra(name: JString): JParcelable; cdecl;
    function getScheme: JString; cdecl;
    function getSelector: JIntent; cdecl;
    function getSerializableExtra(name: JString): JSerializable; cdecl;
    function getShortArrayExtra(name: JString): TJavaArray<SmallInt>; cdecl;
    function getShortExtra(name: JString; defaultValue: SmallInt): SmallInt; cdecl;
    function getSourceBounds: JRect; cdecl;
    function getStringArrayExtra(name: JString): TJavaObjectArray<JString>; cdecl;
    function getStringArrayListExtra(name: JString): JArrayList; cdecl;
    function getStringExtra(name: JString): JString; cdecl;
    function getType: JString; cdecl;
    function hasCategory(category: JString): Boolean; cdecl;
    function hasExtra(name: JString): Boolean; cdecl;
    function hasFileDescriptors: Boolean; cdecl;
    function putCharSequenceArrayListExtra(name: JString; value: JArrayList): JIntent; cdecl;
    function putExtra(name: JString; value: Boolean): JIntent; cdecl; overload;
    function putExtra(name: JString; value: Byte): JIntent; cdecl; overload;
    function putExtra(name: JString; value: Char): JIntent; cdecl; overload;
    function putExtra(name: JString; value: SmallInt): JIntent; cdecl; overload;
    function putExtra(name: JString; value: Integer): JIntent; cdecl; overload;
    function putExtra(name: JString; value: Int64): JIntent; cdecl; overload;
    function putExtra(name: JString; value: Single): JIntent; cdecl; overload;
    function putExtra(name: JString; value: Double): JIntent; cdecl; overload;
    function putExtra(name: JString; value: JString): JIntent; cdecl; overload;
    function putExtra(name: JString; value: JCharSequence): JIntent; cdecl; overload;
    function putExtra(name: JString; value: JParcelable): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaObjectArray<JParcelable>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: JSerializable): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Boolean>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Byte>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<SmallInt>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Char>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Integer>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Int64>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Single>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaArray<Double>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaObjectArray<JString>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: TJavaObjectArray<JCharSequence>): JIntent; cdecl; overload;
    function putExtra(name: JString; value: JBundle): JIntent; cdecl; overload;
    function putExtras(src: JIntent): JIntent; cdecl; overload;
    function putExtras(extras: JBundle): JIntent; cdecl; overload;
    function putIntegerArrayListExtra(name: JString; value: JArrayList): JIntent; cdecl;
    function putParcelableArrayListExtra(name: JString; value: JArrayList): JIntent; cdecl;
    function putStringArrayListExtra(name: JString; value: JArrayList): JIntent; cdecl;
    procedure readFromParcel(in_: JParcel); cdecl;
    procedure removeCategory(category: JString); cdecl;
    procedure removeExtra(name: JString); cdecl;
    function replaceExtras(src: JIntent): JIntent; cdecl; overload;
    function replaceExtras(extras: JBundle): JIntent; cdecl; overload;
    function resolveActivity(pm: JPackageManager): JComponentName; cdecl;
    function resolveActivityInfo(pm: JPackageManager; flags: Integer): JActivityInfo; cdecl;
    function resolveType(context: JContext): JString; cdecl; overload;
    function resolveType(resolver: JContentResolver): JString; cdecl; overload;
    function resolveTypeIfNeeded(resolver: JContentResolver): JString; cdecl;
    function setAction(action: JString): JIntent; cdecl;
    function setClass(packageContext: JContext; cls: Jlang_Class): JIntent; cdecl;
    function setClassName(packageContext: JContext; className: JString): JIntent; cdecl; overload;
    function setClassName(packageName: JString; className: JString): JIntent; cdecl; overload;
    procedure setClipData(clip: JClipData); cdecl;
    function setComponent(component: JComponentName): JIntent; cdecl;
    function setData(data: Jnet_Uri): JIntent; cdecl;
    function setDataAndNormalize(data: Jnet_Uri): JIntent; cdecl;
    function setDataAndType(data: Jnet_Uri; type_: JString): JIntent; cdecl;
    function setDataAndTypeAndNormalize(data: Jnet_Uri; type_: JString): JIntent; cdecl;
    procedure setExtrasClassLoader(loader: JClassLoader); cdecl;
    function setFlags(flags: Integer): JIntent; cdecl;
    function setPackage(packageName: JString): JIntent; cdecl;
    procedure setSelector(selector: JIntent); cdecl;
    procedure setSourceBounds(r: JRect); cdecl;
    function setType(type_: JString): JIntent; cdecl;
    function setTypeAndNormalize(type_: JString): JIntent; cdecl;
    function toString: JString; cdecl;
    function toURI: JString; cdecl; overload;//Deprecated
    function toUri(flags: Integer): JString; cdecl; overload;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJIntent = class(TJavaGenericImport<JIntentClass, JIntent>) end;

  JIntent_FilterComparisonClass = interface(JObjectClass)
    ['{F237F4D9-ADB3-4DF5-A8C6-7B6564FF6AE6}']
    {class} function init(intent: JIntent): JIntent_FilterComparison; cdecl;
  end;

  [JavaSignature('android/content/Intent$FilterComparison')]
  JIntent_FilterComparison = interface(JObject)
    ['{C4464353-23E9-45E9-969E-2235202DE321}']
    function equals(obj: JObject): Boolean; cdecl;
    function getIntent: JIntent; cdecl;
    function hashCode: Integer; cdecl;
  end;
  TJIntent_FilterComparison = class(TJavaGenericImport<JIntent_FilterComparisonClass, JIntent_FilterComparison>) end;

  JIntent_ShortcutIconResourceClass = interface(JObjectClass)
    ['{52C2038E-04AB-4165-B2F3-8076C1C7D2B5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JIntent_ShortcutIconResource; cdecl;
    {class} function fromContext(context: JContext; resourceId: Integer): JIntent_ShortcutIconResource; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/Intent$ShortcutIconResource')]
  JIntent_ShortcutIconResource = interface(JObject)
    ['{6269D767-3CD4-4C55-9174-6D90D217F529}']
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function _GetresourceName: JString; cdecl;
    procedure _SetresourceName(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property packageName: JString read _GetpackageName write _SetpackageName;
    property resourceName: JString read _GetresourceName write _SetresourceName;
  end;
  TJIntent_ShortcutIconResource = class(TJavaGenericImport<JIntent_ShortcutIconResourceClass, JIntent_ShortcutIconResource>) end;

  JIntentFilterClass = interface(JObjectClass)
    ['{D8E327D8-DE10-4013-980F-63D2B7E5437B}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetMATCH_ADJUSTMENT_MASK: Integer; cdecl;
    {class} function _GetMATCH_ADJUSTMENT_NORMAL: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_EMPTY: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_HOST: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_MASK: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_PATH: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_PORT: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_SCHEME: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_SCHEME_SPECIFIC_PART: Integer; cdecl;
    {class} function _GetMATCH_CATEGORY_TYPE: Integer; cdecl;
    {class} function _GetNO_MATCH_ACTION: Integer; cdecl;
    {class} function _GetNO_MATCH_CATEGORY: Integer; cdecl;
    {class} function _GetNO_MATCH_DATA: Integer; cdecl;
    {class} function _GetNO_MATCH_TYPE: Integer; cdecl;
    {class} function _GetSYSTEM_HIGH_PRIORITY: Integer; cdecl;
    {class} function _GetSYSTEM_LOW_PRIORITY: Integer; cdecl;
    {class} function init: JIntentFilter; cdecl; overload;
    {class} function init(action: JString): JIntentFilter; cdecl; overload;
    {class} function init(action: JString; dataType: JString): JIntentFilter; cdecl; overload;
    {class} function init(o: JIntentFilter): JIntentFilter; cdecl; overload;
    {class} function create(action: JString; dataType: JString): JIntentFilter; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property MATCH_ADJUSTMENT_MASK: Integer read _GetMATCH_ADJUSTMENT_MASK;
    {class} property MATCH_ADJUSTMENT_NORMAL: Integer read _GetMATCH_ADJUSTMENT_NORMAL;
    {class} property MATCH_CATEGORY_EMPTY: Integer read _GetMATCH_CATEGORY_EMPTY;
    {class} property MATCH_CATEGORY_HOST: Integer read _GetMATCH_CATEGORY_HOST;
    {class} property MATCH_CATEGORY_MASK: Integer read _GetMATCH_CATEGORY_MASK;
    {class} property MATCH_CATEGORY_PATH: Integer read _GetMATCH_CATEGORY_PATH;
    {class} property MATCH_CATEGORY_PORT: Integer read _GetMATCH_CATEGORY_PORT;
    {class} property MATCH_CATEGORY_SCHEME: Integer read _GetMATCH_CATEGORY_SCHEME;
    {class} property MATCH_CATEGORY_SCHEME_SPECIFIC_PART: Integer read _GetMATCH_CATEGORY_SCHEME_SPECIFIC_PART;
    {class} property MATCH_CATEGORY_TYPE: Integer read _GetMATCH_CATEGORY_TYPE;
    {class} property NO_MATCH_ACTION: Integer read _GetNO_MATCH_ACTION;
    {class} property NO_MATCH_CATEGORY: Integer read _GetNO_MATCH_CATEGORY;
    {class} property NO_MATCH_DATA: Integer read _GetNO_MATCH_DATA;
    {class} property NO_MATCH_TYPE: Integer read _GetNO_MATCH_TYPE;
    {class} property SYSTEM_HIGH_PRIORITY: Integer read _GetSYSTEM_HIGH_PRIORITY;
    {class} property SYSTEM_LOW_PRIORITY: Integer read _GetSYSTEM_LOW_PRIORITY;
  end;

  [JavaSignature('android/content/IntentFilter')]
  JIntentFilter = interface(JObject)
    ['{A40FA09B-35DE-4B8E-8E74-89383527F0DF}']
    function actionsIterator: JIterator; cdecl;
    procedure addAction(action: JString); cdecl;
    procedure addCategory(category: JString); cdecl;
    procedure addDataAuthority(host: JString; port: JString); cdecl;
    procedure addDataPath(path: JString; type_: Integer); cdecl;
    procedure addDataScheme(scheme: JString); cdecl;
    procedure addDataSchemeSpecificPart(ssp: JString; type_: Integer); cdecl;
    procedure addDataType(type_: JString); cdecl;
    function authoritiesIterator: JIterator; cdecl;
    function categoriesIterator: JIterator; cdecl;
    function countActions: Integer; cdecl;
    function countCategories: Integer; cdecl;
    function countDataAuthorities: Integer; cdecl;
    function countDataPaths: Integer; cdecl;
    function countDataSchemeSpecificParts: Integer; cdecl;
    function countDataSchemes: Integer; cdecl;
    function countDataTypes: Integer; cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(du: JPrinter; prefix: JString); cdecl;
    function getAction(index: Integer): JString; cdecl;
    function getCategory(index: Integer): JString; cdecl;
    function getDataAuthority(index: Integer): JIntentFilter_AuthorityEntry; cdecl;
    function getDataPath(index: Integer): JPatternMatcher; cdecl;
    function getDataScheme(index: Integer): JString; cdecl;
    function getDataSchemeSpecificPart(index: Integer): JPatternMatcher; cdecl;
    function getDataType(index: Integer): JString; cdecl;
    function getPriority: Integer; cdecl;
    function hasAction(action: JString): Boolean; cdecl;
    function hasCategory(category: JString): Boolean; cdecl;
    function hasDataAuthority(data: Jnet_Uri): Boolean; cdecl;
    function hasDataPath(data: JString): Boolean; cdecl;
    function hasDataScheme(scheme: JString): Boolean; cdecl;
    function hasDataSchemeSpecificPart(data: JString): Boolean; cdecl;
    function hasDataType(type_: JString): Boolean; cdecl;
    function match(resolver: JContentResolver; intent: JIntent; resolve: Boolean; logTag: JString): Integer; cdecl; overload;
    function match(action: JString; type_: JString; scheme: JString; data: Jnet_Uri; categories: JSet; logTag: JString): Integer; cdecl; overload;
    function matchAction(action: JString): Boolean; cdecl;
    function matchCategories(categories: JSet): JString; cdecl;
    function matchData(type_: JString; scheme: JString; data: Jnet_Uri): Integer; cdecl;
    function matchDataAuthority(data: Jnet_Uri): Integer; cdecl;
    function pathsIterator: JIterator; cdecl;
    procedure readFromXml(parser: JXmlPullParser); cdecl;
    function schemeSpecificPartsIterator: JIterator; cdecl;
    function schemesIterator: JIterator; cdecl;
    procedure setPriority(priority: Integer); cdecl;
    function typesIterator: JIterator; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    procedure writeToXml(serializer: JXmlSerializer); cdecl;
  end;
  TJIntentFilter = class(TJavaGenericImport<JIntentFilterClass, JIntentFilter>) end;

  JIntentFilter_AuthorityEntryClass = interface(JObjectClass)
    ['{0B3684C3-E5D3-4DB6-9FE5-E66579E5C4B4}']
    {class} function init(host: JString; port: JString): JIntentFilter_AuthorityEntry; cdecl;
  end;

  [JavaSignature('android/content/IntentFilter$AuthorityEntry')]
  JIntentFilter_AuthorityEntry = interface(JObject)
    ['{25FAFB4D-95BB-4D76-99CC-E995B61B1ED0}']
    function getHost: JString; cdecl;
    function getPort: Integer; cdecl;
    function match(data: Jnet_Uri): Integer; cdecl;
  end;
  TJIntentFilter_AuthorityEntry = class(TJavaGenericImport<JIntentFilter_AuthorityEntryClass, JIntentFilter_AuthorityEntry>) end;

  JIntentFilter_MalformedMimeTypeExceptionClass = interface(JAndroidExceptionClass)
    ['{85A7FAC4-6FD1-4555-8A9F-E38B48725D28}']
    {class} function init: JIntentFilter_MalformedMimeTypeException; cdecl; overload;
    {class} function init(name: JString): JIntentFilter_MalformedMimeTypeException; cdecl; overload;
  end;

  [JavaSignature('android/content/IntentFilter$MalformedMimeTypeException')]
  JIntentFilter_MalformedMimeTypeException = interface(JAndroidException)
    ['{7056624D-AAC5-499A-A953-1230433E9030}']
  end;
  TJIntentFilter_MalformedMimeTypeException = class(TJavaGenericImport<JIntentFilter_MalformedMimeTypeExceptionClass, JIntentFilter_MalformedMimeTypeException>) end;

  JIntentSenderClass = interface(JObjectClass)
    ['{E26CE668-2908-47E1-A8B2-996052142D18}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function readIntentSenderOrNullFromParcel(in_: JParcel): JIntentSender; cdecl;
    {class} procedure writeIntentSenderOrNullToParcel(sender: JIntentSender; out_: JParcel); cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/IntentSender')]
  JIntentSender = interface(JObject)
    ['{3CE39732-EC8A-45C4-BABD-15C936378193}']
    function describeContents: Integer; cdecl;
    function equals(otherObj: JObject): Boolean; cdecl;
    function getCreatorPackage: JString; cdecl;
    function getCreatorUid: Integer; cdecl;
    function getCreatorUserHandle: JUserHandle; cdecl;
    function getTargetPackage: JString; cdecl;//Deprecated
    function hashCode: Integer; cdecl;
    procedure sendIntent(context: JContext; code: Integer; intent: JIntent; onFinished: JIntentSender_OnFinished; handler: JHandler); cdecl; overload;
    procedure sendIntent(context: JContext; code: Integer; intent: JIntent; onFinished: JIntentSender_OnFinished; handler: JHandler; requiredPermission: JString); cdecl; overload;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJIntentSender = class(TJavaGenericImport<JIntentSenderClass, JIntentSender>) end;

  JIntentSender_OnFinishedClass = interface(IJavaClass)
    ['{3812401C-6A82-4684-9C66-70945067ABFD}']
  end;

  [JavaSignature('android/content/IntentSender$OnFinished')]
  JIntentSender_OnFinished = interface(IJavaInstance)
    ['{80F2FB82-F57E-4604-A556-0012FAC55805}']
    procedure onSendFinished(IntentSender: JIntentSender; intent: JIntent; resultCode: Integer; resultData: JString; resultExtras: JBundle); cdecl;
  end;
  TJIntentSender_OnFinished = class(TJavaGenericImport<JIntentSender_OnFinishedClass, JIntentSender_OnFinished>) end;

  JIntentSender_SendIntentExceptionClass = interface(JAndroidExceptionClass)
    ['{B8FD197B-1FA1-4689-9AF0-9CD8F6929CFD}']
    {class} function init: JIntentSender_SendIntentException; cdecl; overload;
    {class} function init(name: JString): JIntentSender_SendIntentException; cdecl; overload;
    {class} function init(cause: JException): JIntentSender_SendIntentException; cdecl; overload;
  end;

  [JavaSignature('android/content/IntentSender$SendIntentException')]
  JIntentSender_SendIntentException = interface(JAndroidException)
    ['{56AA4D1D-E7E5-418B-8507-286B3F66D5A4}']
  end;
  TJIntentSender_SendIntentException = class(TJavaGenericImport<JIntentSender_SendIntentExceptionClass, JIntentSender_SendIntentException>) end;

  JContentObserverClass = interface(JObjectClass)
    ['{B34CFEA3-9391-42D9-9F24-7D8293038099}']
    {class} function init(handler: JHandler): JContentObserver; cdecl;
  end;

  [JavaSignature('android/database/ContentObserver')]
  JContentObserver = interface(JObject)
    ['{7360FA96-2F67-476D-801E-6B99CEA3C281}']
    function deliverSelfNotifications: Boolean; cdecl;
    procedure dispatchChange(selfChange: Boolean); cdecl; overload;//Deprecated
    procedure dispatchChange(selfChange: Boolean; uri: Jnet_Uri); cdecl; overload;
    procedure onChange(selfChange: Boolean); cdecl; overload;
    procedure onChange(selfChange: Boolean; uri: Jnet_Uri); cdecl; overload;
  end;
  TJContentObserver = class(TJavaGenericImport<JContentObserverClass, JContentObserver>) end;

  JLoader_ForceLoadContentObserverClass = interface(JContentObserverClass)
    ['{81D7EA1D-6953-4C18-9426-81E3D1C49210}']
    {class} function init: JLoader_ForceLoadContentObserver; cdecl;
  end;

  [JavaSignature('android/content/Loader$ForceLoadContentObserver')]
  JLoader_ForceLoadContentObserver = interface(JContentObserver)
    ['{5408F796-56EB-481C-97CB-06CBDF53F040}']
    function deliverSelfNotifications: Boolean; cdecl;
    procedure onChange(selfChange: Boolean); cdecl;
  end;
  TJLoader_ForceLoadContentObserver = class(TJavaGenericImport<JLoader_ForceLoadContentObserverClass, JLoader_ForceLoadContentObserver>) end;

  JLoader_OnLoadCanceledListenerClass = interface(IJavaClass)
    ['{769CEFA7-F086-4CDE-8348-66CB478E6CBE}']
  end;

  [JavaSignature('android/content/Loader$OnLoadCanceledListener')]
  JLoader_OnLoadCanceledListener = interface(IJavaInstance)
    ['{4C6C08EE-6DB0-4612-9F99-F36104D7BFCF}']
    procedure onLoadCanceled(loader: JLoader); cdecl;
  end;
  TJLoader_OnLoadCanceledListener = class(TJavaGenericImport<JLoader_OnLoadCanceledListenerClass, JLoader_OnLoadCanceledListener>) end;

  JLoader_OnLoadCompleteListenerClass = interface(IJavaClass)
    ['{B637B683-4104-4A5C-8BB2-961070E40E05}']
  end;

  [JavaSignature('android/content/Loader$OnLoadCompleteListener')]
  JLoader_OnLoadCompleteListener = interface(IJavaInstance)
    ['{16E33371-5A38-4FD1-8B83-58FFE169A785}']
    procedure onLoadComplete(loader: JLoader; data: JObject); cdecl;
  end;
  TJLoader_OnLoadCompleteListener = class(TJavaGenericImport<JLoader_OnLoadCompleteListenerClass, JLoader_OnLoadCompleteListener>) end;

  JMutableContextWrapperClass = interface(JContextWrapperClass)
    ['{06AAE2A0-2502-46EE-9E37-1C7E3E0522A4}']
    {class} function init(base: JContext): JMutableContextWrapper; cdecl;
  end;

  [JavaSignature('android/content/MutableContextWrapper')]
  JMutableContextWrapper = interface(JContextWrapper)
    ['{A350046D-0F6F-41C3-8375-35988DFB1B05}']
    procedure setBaseContext(base: JContext); cdecl;
  end;
  TJMutableContextWrapper = class(TJavaGenericImport<JMutableContextWrapperClass, JMutableContextWrapper>) end;

  JOperationApplicationExceptionClass = interface(JExceptionClass)
    ['{F286AB2B-DD1B-46C2-B241-E70EF02088E6}']
    {class} function init: JOperationApplicationException; cdecl; overload;
    {class} function init(message: JString): JOperationApplicationException; cdecl; overload;
    {class} function init(message: JString; cause: JThrowable): JOperationApplicationException; cdecl; overload;
    {class} function init(cause: JThrowable): JOperationApplicationException; cdecl; overload;
    {class} function init(numSuccessfulYieldPoints: Integer): JOperationApplicationException; cdecl; overload;
    {class} function init(message: JString; numSuccessfulYieldPoints: Integer): JOperationApplicationException; cdecl; overload;
  end;

  [JavaSignature('android/content/OperationApplicationException')]
  JOperationApplicationException = interface(JException)
    ['{929E2751-19CD-4E05-8763-815EAC48443C}']
    function getNumSuccessfulYieldPoints: Integer; cdecl;
  end;
  TJOperationApplicationException = class(TJavaGenericImport<JOperationApplicationExceptionClass, JOperationApplicationException>) end;

  JPeriodicSyncClass = interface(JObjectClass)
    ['{712C0D8C-A539-4529-BCDD-57539C37EE37}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} //function init(account: JAccount; authority: JString; extras: JBundle; periodInSeconds: Int64): JPeriodicSync; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/PeriodicSync')]
  JPeriodicSync = interface(JObject)
    ['{AF79411F-188F-4B28-A1EA-DD369D8C921C}']
    //function _Getaccount: JAccount; cdecl;
    function _Getauthority: JString; cdecl;
    function _Getextras: JBundle; cdecl;
    function _Getperiod: Int64; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    //property account: JAccount read _Getaccount;
    property authority: JString read _Getauthority;
    property extras: JBundle read _Getextras;
    property period: Int64 read _Getperiod;
  end;
  TJPeriodicSync = class(TJavaGenericImport<JPeriodicSyncClass, JPeriodicSync>) end;

  JReceiverCallNotAllowedExceptionClass = interface(JAndroidRuntimeExceptionClass)
    ['{87130490-4CBA-4118-94BB-8357391F1B65}']
    {class} function init(msg: JString): JReceiverCallNotAllowedException; cdecl;
  end;

  [JavaSignature('android/content/ReceiverCallNotAllowedException')]
  JReceiverCallNotAllowedException = interface(JAndroidRuntimeException)
    ['{28E59F90-1B49-4ADA-86A7-5B189CB4410B}']
  end;
  TJReceiverCallNotAllowedException = class(TJavaGenericImport<JReceiverCallNotAllowedExceptionClass, JReceiverCallNotAllowedException>) end;

  JRestrictionEntryClass = interface(JObjectClass)
    ['{D3F258F9-7487-4E49-96D0-FF62B1F5AB18}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetTYPE_BOOLEAN: Integer; cdecl;
    {class} function _GetTYPE_BUNDLE: Integer; cdecl;
    {class} function _GetTYPE_BUNDLE_ARRAY: Integer; cdecl;
    {class} function _GetTYPE_CHOICE: Integer; cdecl;
    {class} function _GetTYPE_INTEGER: Integer; cdecl;
    {class} function _GetTYPE_MULTI_SELECT: Integer; cdecl;
    {class} function _GetTYPE_NULL: Integer; cdecl;
    {class} function _GetTYPE_STRING: Integer; cdecl;
    {class} function init(type_: Integer; key: JString): JRestrictionEntry; cdecl; overload;
    {class} function init(key: JString; selectedString: JString): JRestrictionEntry; cdecl; overload;
    {class} function init(key: JString; selectedState: Boolean): JRestrictionEntry; cdecl; overload;
    {class} function init(key: JString; selectedStrings: TJavaObjectArray<JString>): JRestrictionEntry; cdecl; overload;
    {class} function init(key: JString; selectedInt: Integer): JRestrictionEntry; cdecl; overload;
    {class} function init(in_: JParcel): JRestrictionEntry; cdecl; overload;
    {class} function createBundleArrayEntry(key: JString; restrictionEntries: TJavaObjectArray<JRestrictionEntry>): JRestrictionEntry; cdecl;
    {class} function createBundleEntry(key: JString; restrictionEntries: TJavaObjectArray<JRestrictionEntry>): JRestrictionEntry; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property TYPE_BOOLEAN: Integer read _GetTYPE_BOOLEAN;
    {class} property TYPE_BUNDLE: Integer read _GetTYPE_BUNDLE;
    {class} property TYPE_BUNDLE_ARRAY: Integer read _GetTYPE_BUNDLE_ARRAY;
    {class} property TYPE_CHOICE: Integer read _GetTYPE_CHOICE;
    {class} property TYPE_INTEGER: Integer read _GetTYPE_INTEGER;
    {class} property TYPE_MULTI_SELECT: Integer read _GetTYPE_MULTI_SELECT;
    {class} property TYPE_NULL: Integer read _GetTYPE_NULL;
    {class} property TYPE_STRING: Integer read _GetTYPE_STRING;
  end;

  [JavaSignature('android/content/RestrictionEntry')]
  JRestrictionEntry = interface(JObject)
    ['{79855EF4-4940-4A4E-AAA8-C0C8F5CD5AE0}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAllSelectedStrings: TJavaObjectArray<JString>; cdecl;
    function getChoiceEntries: TJavaObjectArray<JString>; cdecl;
    function getChoiceValues: TJavaObjectArray<JString>; cdecl;
    function getDescription: JString; cdecl;
    function getIntValue: Integer; cdecl;
    function getKey: JString; cdecl;
    function getRestrictions: TJavaObjectArray<JRestrictionEntry>; cdecl;
    function getSelectedState: Boolean; cdecl;
    function getSelectedString: JString; cdecl;
    function getTitle: JString; cdecl;
    function getType: Integer; cdecl;
    function hashCode: Integer; cdecl;
    procedure setAllSelectedStrings(allSelectedStrings: TJavaObjectArray<JString>); cdecl;
    procedure setChoiceEntries(choiceEntries: TJavaObjectArray<JString>); cdecl; overload;
    procedure setChoiceEntries(context: JContext; stringArrayResId: Integer); cdecl; overload;
    procedure setChoiceValues(choiceValues: TJavaObjectArray<JString>); cdecl; overload;
    procedure setChoiceValues(context: JContext; stringArrayResId: Integer); cdecl; overload;
    procedure setDescription(description: JString); cdecl;
    procedure setIntValue(value: Integer); cdecl;
    procedure setRestrictions(restrictions: TJavaObjectArray<JRestrictionEntry>); cdecl;
    procedure setSelectedState(state: Boolean); cdecl;
    procedure setSelectedString(selectedString: JString); cdecl;
    procedure setTitle(title: JString); cdecl;
    procedure setType(type_: Integer); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJRestrictionEntry = class(TJavaGenericImport<JRestrictionEntryClass, JRestrictionEntry>) end;

  JRestrictionsManagerClass = interface(JObjectClass)
    ['{C2765D7C-3FEC-4AA8-A181-B8457EEE4FDE}']
    {class} function _GetACTION_PERMISSION_RESPONSE_RECEIVED: JString; cdecl;
    {class} function _GetACTION_REQUEST_LOCAL_APPROVAL: JString; cdecl;
    {class} function _GetACTION_REQUEST_PERMISSION: JString; cdecl;
    {class} function _GetEXTRA_PACKAGE_NAME: JString; cdecl;
    {class} function _GetEXTRA_REQUEST_BUNDLE: JString; cdecl;
    {class} function _GetEXTRA_REQUEST_ID: JString; cdecl;
    {class} function _GetEXTRA_REQUEST_TYPE: JString; cdecl;
    {class} function _GetEXTRA_RESPONSE_BUNDLE: JString; cdecl;
    {class} function _GetMETA_DATA_APP_RESTRICTIONS: JString; cdecl;
    {class} function _GetREQUEST_KEY_APPROVE_LABEL: JString; cdecl;
    {class} function _GetREQUEST_KEY_DATA: JString; cdecl;
    {class} function _GetREQUEST_KEY_DENY_LABEL: JString; cdecl;
    {class} function _GetREQUEST_KEY_ICON: JString; cdecl;
    {class} function _GetREQUEST_KEY_ID: JString; cdecl;
    {class} function _GetREQUEST_KEY_MESSAGE: JString; cdecl;
    {class} function _GetREQUEST_KEY_NEW_REQUEST: JString; cdecl;
    {class} function _GetREQUEST_KEY_TITLE: JString; cdecl;
    {class} function _GetREQUEST_TYPE_APPROVAL: JString; cdecl;
    {class} function _GetRESPONSE_KEY_ERROR_CODE: JString; cdecl;
    {class} function _GetRESPONSE_KEY_MESSAGE: JString; cdecl;
    {class} function _GetRESPONSE_KEY_RESPONSE_TIMESTAMP: JString; cdecl;
    {class} function _GetRESPONSE_KEY_RESULT: JString; cdecl;
    {class} function _GetRESULT_APPROVED: Integer; cdecl;
    {class} function _GetRESULT_DENIED: Integer; cdecl;
    {class} function _GetRESULT_ERROR: Integer; cdecl;
    {class} function _GetRESULT_ERROR_BAD_REQUEST: Integer; cdecl;
    {class} function _GetRESULT_ERROR_INTERNAL: Integer; cdecl;
    {class} function _GetRESULT_ERROR_NETWORK: Integer; cdecl;
    {class} function _GetRESULT_NO_RESPONSE: Integer; cdecl;
    {class} function _GetRESULT_UNKNOWN_REQUEST: Integer; cdecl;
    {class} function convertRestrictionsToBundle(entries: JList): JBundle; cdecl;
    {class} property ACTION_PERMISSION_RESPONSE_RECEIVED: JString read _GetACTION_PERMISSION_RESPONSE_RECEIVED;
    {class} property ACTION_REQUEST_LOCAL_APPROVAL: JString read _GetACTION_REQUEST_LOCAL_APPROVAL;
    {class} property ACTION_REQUEST_PERMISSION: JString read _GetACTION_REQUEST_PERMISSION;
    {class} property EXTRA_PACKAGE_NAME: JString read _GetEXTRA_PACKAGE_NAME;
    {class} property EXTRA_REQUEST_BUNDLE: JString read _GetEXTRA_REQUEST_BUNDLE;
    {class} property EXTRA_REQUEST_ID: JString read _GetEXTRA_REQUEST_ID;
    {class} property EXTRA_REQUEST_TYPE: JString read _GetEXTRA_REQUEST_TYPE;
    {class} property EXTRA_RESPONSE_BUNDLE: JString read _GetEXTRA_RESPONSE_BUNDLE;
    {class} property META_DATA_APP_RESTRICTIONS: JString read _GetMETA_DATA_APP_RESTRICTIONS;
    {class} property REQUEST_KEY_APPROVE_LABEL: JString read _GetREQUEST_KEY_APPROVE_LABEL;
    {class} property REQUEST_KEY_DATA: JString read _GetREQUEST_KEY_DATA;
    {class} property REQUEST_KEY_DENY_LABEL: JString read _GetREQUEST_KEY_DENY_LABEL;
    {class} property REQUEST_KEY_ICON: JString read _GetREQUEST_KEY_ICON;
    {class} property REQUEST_KEY_ID: JString read _GetREQUEST_KEY_ID;
    {class} property REQUEST_KEY_MESSAGE: JString read _GetREQUEST_KEY_MESSAGE;
    {class} property REQUEST_KEY_NEW_REQUEST: JString read _GetREQUEST_KEY_NEW_REQUEST;
    {class} property REQUEST_KEY_TITLE: JString read _GetREQUEST_KEY_TITLE;
    {class} property REQUEST_TYPE_APPROVAL: JString read _GetREQUEST_TYPE_APPROVAL;
    {class} property RESPONSE_KEY_ERROR_CODE: JString read _GetRESPONSE_KEY_ERROR_CODE;
    {class} property RESPONSE_KEY_MESSAGE: JString read _GetRESPONSE_KEY_MESSAGE;
    {class} property RESPONSE_KEY_RESPONSE_TIMESTAMP: JString read _GetRESPONSE_KEY_RESPONSE_TIMESTAMP;
    {class} property RESPONSE_KEY_RESULT: JString read _GetRESPONSE_KEY_RESULT;
    {class} property RESULT_APPROVED: Integer read _GetRESULT_APPROVED;
    {class} property RESULT_DENIED: Integer read _GetRESULT_DENIED;
    {class} property RESULT_ERROR: Integer read _GetRESULT_ERROR;
    {class} property RESULT_ERROR_BAD_REQUEST: Integer read _GetRESULT_ERROR_BAD_REQUEST;
    {class} property RESULT_ERROR_INTERNAL: Integer read _GetRESULT_ERROR_INTERNAL;
    {class} property RESULT_ERROR_NETWORK: Integer read _GetRESULT_ERROR_NETWORK;
    {class} property RESULT_NO_RESPONSE: Integer read _GetRESULT_NO_RESPONSE;
    {class} property RESULT_UNKNOWN_REQUEST: Integer read _GetRESULT_UNKNOWN_REQUEST;
  end;

  [JavaSignature('android/content/RestrictionsManager')]
  JRestrictionsManager = interface(JObject)
    ['{9978CEB6-939F-4084-93EB-8FE966F9C045}']
    function createLocalApprovalIntent: JIntent; cdecl;
    function getApplicationRestrictions: JBundle; cdecl;
    function getManifestRestrictions(packageName: JString): JList; cdecl;
    function hasRestrictionsProvider: Boolean; cdecl;
    procedure notifyPermissionResponse(packageName: JString; response: JPersistableBundle); cdecl;
    procedure requestPermission(requestType: JString; requestId: JString; request: JPersistableBundle); cdecl;
  end;
  TJRestrictionsManager = class(TJavaGenericImport<JRestrictionsManagerClass, JRestrictionsManager>) end;

  JSearchRecentSuggestionsProviderClass = interface(JContentProviderClass)
    ['{230B5BBC-D00A-4478-9511-F1F99773FAE8}']
    {class} function _GetDATABASE_MODE_2LINES: Integer; cdecl;
    {class} function _GetDATABASE_MODE_QUERIES: Integer; cdecl;
    {class} function init: JSearchRecentSuggestionsProvider; cdecl;
    {class} property DATABASE_MODE_2LINES: Integer read _GetDATABASE_MODE_2LINES;
    {class} property DATABASE_MODE_QUERIES: Integer read _GetDATABASE_MODE_QUERIES;
  end;

  [JavaSignature('android/content/SearchRecentSuggestionsProvider')]
  JSearchRecentSuggestionsProvider = interface(JContentProvider)
    ['{C8FE17D4-9142-4AEC-A486-81E0349B62AC}']
    function delete(uri: Jnet_Uri; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
    function getType(uri: Jnet_Uri): JString; cdecl;
    function insert(uri: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    function onCreate: Boolean; cdecl;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJSearchRecentSuggestionsProvider = class(TJavaGenericImport<JSearchRecentSuggestionsProviderClass, JSearchRecentSuggestionsProvider>) end;

  JServiceConnectionClass = interface(IJavaClass)
    ['{04453C2D-CBBA-4879-A697-6C1C930DA1E4}']
  end;

  [JavaSignature('android/content/ServiceConnection')]
  JServiceConnection = interface(IJavaInstance)
    ['{B1F97308-817B-4AC2-91CA-3C5FF72D4707}']
    procedure onServiceConnected(name: JComponentName; service: JIBinder); cdecl;
    procedure onServiceDisconnected(name: JComponentName); cdecl;
  end;
  TJServiceConnection = class(TJavaGenericImport<JServiceConnectionClass, JServiceConnection>) end;

  JSharedPreferencesClass = interface(IJavaClass)
    ['{C6937724-11B9-468B-9898-5D0C17D64535}']
  end;

  [JavaSignature('android/content/SharedPreferences')]
  JSharedPreferences = interface(IJavaInstance)
    ['{E44179D1-B961-4316-A8B0-45B52A482FA7}']
    function &contains(key: JString): Boolean; cdecl;
    function edit: JSharedPreferences_Editor; cdecl;
    function getAll: JMap; cdecl;
    function getBoolean(key: JString; defValue: Boolean): Boolean; cdecl;
    function getFloat(key: JString; defValue: Single): Single; cdecl;
    function getInt(key: JString; defValue: Integer): Integer; cdecl;
    function getLong(key: JString; defValue: Int64): Int64; cdecl;
    function getString(key: JString; defValue: JString): JString; cdecl;
    function getStringSet(key: JString; defValues: JSet): JSet; cdecl;
    procedure registerOnSharedPreferenceChangeListener(listener: JSharedPreferences_OnSharedPreferenceChangeListener); cdecl;
    procedure unregisterOnSharedPreferenceChangeListener(listener: JSharedPreferences_OnSharedPreferenceChangeListener); cdecl;
  end;
  TJSharedPreferences = class(TJavaGenericImport<JSharedPreferencesClass, JSharedPreferences>) end;

  JSharedPreferences_EditorClass = interface(IJavaClass)
    ['{EF362B32-D6AD-4EC6-BACA-094E25708649}']
  end;

  [JavaSignature('android/content/SharedPreferences$Editor')]
  JSharedPreferences_Editor = interface(IJavaInstance)
    ['{A162AACF-DD6D-466E-838B-363E6B092CA4}']
    procedure apply; cdecl;
    function clear: JSharedPreferences_Editor; cdecl;
    function commit: Boolean; cdecl;
    function putBoolean(key: JString; value: Boolean): JSharedPreferences_Editor; cdecl;
    function putFloat(key: JString; value: Single): JSharedPreferences_Editor; cdecl;
    function putInt(key: JString; value: Integer): JSharedPreferences_Editor; cdecl;
    function putLong(key: JString; value: Int64): JSharedPreferences_Editor; cdecl;
    function putString(key: JString; value: JString): JSharedPreferences_Editor; cdecl;
    function putStringSet(key: JString; values: JSet): JSharedPreferences_Editor; cdecl;
    function remove(key: JString): JSharedPreferences_Editor; cdecl;
  end;
  TJSharedPreferences_Editor = class(TJavaGenericImport<JSharedPreferences_EditorClass, JSharedPreferences_Editor>) end;

  JSharedPreferences_OnSharedPreferenceChangeListenerClass = interface(IJavaClass)
    ['{1780D887-EB33-4DD2-AC0D-E0EC298D520C}']
  end;

  [JavaSignature('android/content/SharedPreferences$OnSharedPreferenceChangeListener')]
  JSharedPreferences_OnSharedPreferenceChangeListener = interface(IJavaInstance)
    ['{9DE5999B-3F66-4CFB-B2BE-7AC79B1730E7}']
    procedure onSharedPreferenceChanged(sharedPreferences: JSharedPreferences; key: JString); cdecl;
  end;
  TJSharedPreferences_OnSharedPreferenceChangeListener = class(TJavaGenericImport<JSharedPreferences_OnSharedPreferenceChangeListenerClass, JSharedPreferences_OnSharedPreferenceChangeListener>) end;

  JSyncAdapterTypeClass = interface(JObjectClass)
    ['{701008C3-9875-4994-908E-0CAD192C047E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(authority: JString; accountType: JString; userVisible: Boolean; supportsUploading: Boolean): JSyncAdapterType; cdecl; overload;
    {class} function init(source: JParcel): JSyncAdapterType; cdecl; overload;
    {class} function newKey(authority: JString; accountType: JString): JSyncAdapterType; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/SyncAdapterType')]
  JSyncAdapterType = interface(JObject)
    ['{42EF06A0-D1AE-412C-B244-BAE8DB567003}']
    function _GetaccountType: JString; cdecl;
    function _Getauthority: JString; cdecl;
    function _GetisKey: Boolean; cdecl;
    function allowParallelSyncs: Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getSettingsActivity: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isAlwaysSyncable: Boolean; cdecl;
    function isUserVisible: Boolean; cdecl;
    function supportsUploading: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property accountType: JString read _GetaccountType;
    property authority: JString read _Getauthority;
    property isKey: Boolean read _GetisKey;
  end;
  TJSyncAdapterType = class(TJavaGenericImport<JSyncAdapterTypeClass, JSyncAdapterType>) end;

  JSyncContextClass = interface(JObjectClass)
    ['{658C6138-474B-427E-8444-E60B1D8BD42C}']
  end;

  [JavaSignature('android/content/SyncContext')]
  JSyncContext = interface(JObject)
    ['{E5C7D653-6BE5-4A63-94E1-1639F17F4FBD}']
    function getSyncContextBinder: JIBinder; cdecl;
    procedure onFinished(result: JSyncResult); cdecl;
  end;
  TJSyncContext = class(TJavaGenericImport<JSyncContextClass, JSyncContext>) end;

  JSyncInfoClass = interface(JObjectClass)
    ['{71459AA9-8F8B-461C-B76E-F236B51008DA}']
  end;

  [JavaSignature('android/content/SyncInfo')]
  JSyncInfo = interface(JObject)
    ['{0212F6E9-4CE7-4BE6-828A-B7275E3BCD33}']
    //function _Getaccount: JAccount; cdecl;
    function _Getauthority: JString; cdecl;
    function _GetstartTime: Int64; cdecl;
    //property account: JAccount read _Getaccount;
    property authority: JString read _Getauthority;
    property startTime: Int64 read _GetstartTime;
  end;
  TJSyncInfo = class(TJavaGenericImport<JSyncInfoClass, JSyncInfo>) end;

  JSyncRequestClass = interface(JObjectClass)
    ['{5284EFC4-9965-4864-A061-5B7CE2275A1E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/SyncRequest')]
  JSyncRequest = interface(JObject)
    ['{FB898E44-9F81-47E5-9BA8-9E552A1C6F16}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJSyncRequest = class(TJavaGenericImport<JSyncRequestClass, JSyncRequest>) end;

  JSyncRequest_BuilderClass = interface(JObjectClass)
    ['{07AAD48B-91D3-4908-B14F-24FC16F43C4A}']
    {class} function init: JSyncRequest_Builder; cdecl;
  end;

  [JavaSignature('android/content/SyncRequest$Builder')]
  JSyncRequest_Builder = interface(JObject)
    ['{D4BA01CC-BA64-4D4D-9F58-9BD5CF9BB330}']
    function build: JSyncRequest; cdecl;
    function setDisallowMetered(disallow: Boolean): JSyncRequest_Builder; cdecl;
    function setExpedited(expedited: Boolean): JSyncRequest_Builder; cdecl;
    function setExtras(bundle: JBundle): JSyncRequest_Builder; cdecl;
    function setIgnoreBackoff(ignoreBackoff: Boolean): JSyncRequest_Builder; cdecl;
    function setIgnoreSettings(ignoreSettings: Boolean): JSyncRequest_Builder; cdecl;
    function setManual(isManual: Boolean): JSyncRequest_Builder; cdecl;
    function setNoRetry(noRetry: Boolean): JSyncRequest_Builder; cdecl;
    //function setSyncAdapter(account: JAccount; authority: JString): JSyncRequest_Builder; cdecl;
    function syncOnce: JSyncRequest_Builder; cdecl;
    function syncPeriodic(pollFrequency: Int64; beforeSeconds: Int64): JSyncRequest_Builder; cdecl;
  end;
  TJSyncRequest_Builder = class(TJavaGenericImport<JSyncRequest_BuilderClass, JSyncRequest_Builder>) end;

  JSyncResultClass = interface(JObjectClass)
    ['{4AB5B7A4-F685-4D10-9E00-DEE5C5FE93C6}']
    {class} function _GetALREADY_IN_PROGRESS: JSyncResult; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JSyncResult; cdecl;
    {class} property ALREADY_IN_PROGRESS: JSyncResult read _GetALREADY_IN_PROGRESS;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/SyncResult')]
  JSyncResult = interface(JObject)
    ['{5A5A4C47-BC5C-409B-8BD3-C8D600D485D9}']
    function _GetdatabaseError: Boolean; cdecl;
    procedure _SetdatabaseError(Value: Boolean); cdecl;
    function _GetdelayUntil: Int64; cdecl;
    procedure _SetdelayUntil(Value: Int64); cdecl;
    function _GetfullSyncRequested: Boolean; cdecl;
    procedure _SetfullSyncRequested(Value: Boolean); cdecl;
    function _GetmoreRecordsToGet: Boolean; cdecl;
    procedure _SetmoreRecordsToGet(Value: Boolean); cdecl;
    function _GetpartialSyncUnavailable: Boolean; cdecl;
    procedure _SetpartialSyncUnavailable(Value: Boolean); cdecl;
    function _Getstats: JSyncStats; cdecl;
    function _GetsyncAlreadyInProgress: Boolean; cdecl;
    function _GettooManyDeletions: Boolean; cdecl;
    procedure _SettooManyDeletions(Value: Boolean); cdecl;
    function _GettooManyRetries: Boolean; cdecl;
    procedure _SettooManyRetries(Value: Boolean); cdecl;
    procedure clear; cdecl;
    function describeContents: Integer; cdecl;
    function hasError: Boolean; cdecl;
    function hasHardError: Boolean; cdecl;
    function hasSoftError: Boolean; cdecl;
    function madeSomeProgress: Boolean; cdecl;
    function toDebugString: JString; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
    property databaseError: Boolean read _GetdatabaseError write _SetdatabaseError;
    property delayUntil: Int64 read _GetdelayUntil write _SetdelayUntil;
    property fullSyncRequested: Boolean read _GetfullSyncRequested write _SetfullSyncRequested;
    property moreRecordsToGet: Boolean read _GetmoreRecordsToGet write _SetmoreRecordsToGet;
    property partialSyncUnavailable: Boolean read _GetpartialSyncUnavailable write _SetpartialSyncUnavailable;
    property stats: JSyncStats read _Getstats;
    property syncAlreadyInProgress: Boolean read _GetsyncAlreadyInProgress;
    property tooManyDeletions: Boolean read _GettooManyDeletions write _SettooManyDeletions;
    property tooManyRetries: Boolean read _GettooManyRetries write _SettooManyRetries;
  end;
  TJSyncResult = class(TJavaGenericImport<JSyncResultClass, JSyncResult>) end;

  JSyncStatsClass = interface(JObjectClass)
    ['{7BA32D0C-16F1-47A6-B318-1229042DC565}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JSyncStats; cdecl; overload;
    {class} function init(in_: JParcel): JSyncStats; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/SyncStats')]
  JSyncStats = interface(JObject)
    ['{9AC3B6F7-3C69-4E3C-9DB6-DAD7E40F2B10}']
    function _GetnumAuthExceptions: Int64; cdecl;
    procedure _SetnumAuthExceptions(Value: Int64); cdecl;
    function _GetnumConflictDetectedExceptions: Int64; cdecl;
    procedure _SetnumConflictDetectedExceptions(Value: Int64); cdecl;
    function _GetnumDeletes: Int64; cdecl;
    procedure _SetnumDeletes(Value: Int64); cdecl;
    function _GetnumEntries: Int64; cdecl;
    procedure _SetnumEntries(Value: Int64); cdecl;
    function _GetnumInserts: Int64; cdecl;
    procedure _SetnumInserts(Value: Int64); cdecl;
    function _GetnumIoExceptions: Int64; cdecl;
    procedure _SetnumIoExceptions(Value: Int64); cdecl;
    function _GetnumParseExceptions: Int64; cdecl;
    procedure _SetnumParseExceptions(Value: Int64); cdecl;
    function _GetnumSkippedEntries: Int64; cdecl;
    procedure _SetnumSkippedEntries(Value: Int64); cdecl;
    function _GetnumUpdates: Int64; cdecl;
    procedure _SetnumUpdates(Value: Int64); cdecl;
    procedure clear; cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property numAuthExceptions: Int64 read _GetnumAuthExceptions write _SetnumAuthExceptions;
    property numConflictDetectedExceptions: Int64 read _GetnumConflictDetectedExceptions write _SetnumConflictDetectedExceptions;
    property numDeletes: Int64 read _GetnumDeletes write _SetnumDeletes;
    property numEntries: Int64 read _GetnumEntries write _SetnumEntries;
    property numInserts: Int64 read _GetnumInserts write _SetnumInserts;
    property numIoExceptions: Int64 read _GetnumIoExceptions write _SetnumIoExceptions;
    property numParseExceptions: Int64 read _GetnumParseExceptions write _SetnumParseExceptions;
    property numSkippedEntries: Int64 read _GetnumSkippedEntries write _SetnumSkippedEntries;
    property numUpdates: Int64 read _GetnumUpdates write _SetnumUpdates;
  end;
  TJSyncStats = class(TJavaGenericImport<JSyncStatsClass, JSyncStats>) end;

  JSyncStatusObserverClass = interface(IJavaClass)
    ['{BD8BC3F1-68C5-4649-B659-1E51F3934376}']
  end;

  [JavaSignature('android/content/SyncStatusObserver')]
  JSyncStatusObserver = interface(IJavaInstance)
    ['{1DFEEAD6-94AE-48B6-AF87-1200CEADAECC}']
    procedure onStatusChanged(which: Integer); cdecl;
  end;
  TJSyncStatusObserver = class(TJavaGenericImport<JSyncStatusObserverClass, JSyncStatusObserver>) end;

  JUriMatcherClass = interface(JObjectClass)
    ['{7E025473-95A2-4F4E-9E78-155BF04C2F74}']
    {class} function _GetNO_MATCH: Integer; cdecl;
    {class} function init(code: Integer): JUriMatcher; cdecl;
    {class} property NO_MATCH: Integer read _GetNO_MATCH;
  end;

  [JavaSignature('android/content/UriMatcher')]
  JUriMatcher = interface(JObject)
    ['{792FE785-2ED6-491E-831F-51E80A0DBEE5}']
    procedure addURI(authority: JString; path: JString; code: Integer); cdecl;
    function match(uri: Jnet_Uri): Integer; cdecl;
  end;
  TJUriMatcher = class(TJavaGenericImport<JUriMatcherClass, JUriMatcher>) end;

  JUriPermissionClass = interface(JObjectClass)
    ['{762434CE-B631-4B5C-AB56-6C5876A404BF}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetINVALID_TIME: Int64; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property INVALID_TIME: Int64 read _GetINVALID_TIME;
  end;

  [JavaSignature('android/content/UriPermission')]
  JUriPermission = interface(JObject)
    ['{3AAB2566-319A-47CF-9423-A61065575F9D}']
    function describeContents: Integer; cdecl;
    function getPersistedTime: Int64; cdecl;
    function getUri: Jnet_Uri; cdecl;
    function isReadPermission: Boolean; cdecl;
    function isWritePermission: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJUriPermission = class(TJavaGenericImport<JUriPermissionClass, JUriPermission>) end;

  JPackageItemInfoClass = interface(JObjectClass)
    ['{8E60F2CA-9F18-4D13-83A5-736AF9200D73}']
    {class} function init: JPackageItemInfo; cdecl; overload;
    {class} function init(orig: JPackageItemInfo): JPackageItemInfo; cdecl; overload;
  end;

  [JavaSignature('android/content/pm/PackageItemInfo')]
  JPackageItemInfo = interface(JObject)
    ['{FB22C7C1-E6FE-49AE-97E9-6CBDC1424263}']
    function _Getbanner: Integer; cdecl;
    procedure _Setbanner(Value: Integer); cdecl;
    function _Geticon: Integer; cdecl;
    procedure _Seticon(Value: Integer); cdecl;
    function _GetlabelRes: Integer; cdecl;
    procedure _SetlabelRes(Value: Integer); cdecl;
    function _Getlogo: Integer; cdecl;
    procedure _Setlogo(Value: Integer); cdecl;
    function _GetmetaData: JBundle; cdecl;
    procedure _SetmetaData(Value: JBundle); cdecl;
    function _Getname: JString; cdecl;
    procedure _Setname(Value: JString); cdecl;
    function _GetnonLocalizedLabel: JCharSequence; cdecl;
    procedure _SetnonLocalizedLabel(Value: JCharSequence); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function loadBanner(pm: JPackageManager): JDrawable; cdecl;
    function loadIcon(pm: JPackageManager): JDrawable; cdecl;
    function loadLabel(pm: JPackageManager): JCharSequence; cdecl;
    function loadLogo(pm: JPackageManager): JDrawable; cdecl;
    function loadUnbadgedIcon(pm: JPackageManager): JDrawable; cdecl;
    function loadXmlMetaData(pm: JPackageManager; name: JString): JXmlResourceParser; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property banner: Integer read _Getbanner write _Setbanner;
    property icon: Integer read _Geticon write _Seticon;
    property labelRes: Integer read _GetlabelRes write _SetlabelRes;
    property logo: Integer read _Getlogo write _Setlogo;
    property metaData: JBundle read _GetmetaData write _SetmetaData;
    property name: JString read _Getname write _Setname;
    property nonLocalizedLabel: JCharSequence read _GetnonLocalizedLabel write _SetnonLocalizedLabel;
    property packageName: JString read _GetpackageName write _SetpackageName;
  end;
  TJPackageItemInfo = class(TJavaGenericImport<JPackageItemInfoClass, JPackageItemInfo>) end;

  JComponentInfoClass = interface(JPackageItemInfoClass)
    ['{637D9B9F-9FEA-410E-B18F-01C9FFB10252}']
    {class} function init: JComponentInfo; cdecl; overload;
    {class} function init(orig: JComponentInfo): JComponentInfo; cdecl; overload;
  end;

  [JavaSignature('android/content/pm/ComponentInfo')]
  JComponentInfo = interface(JPackageItemInfo)
    ['{464FA916-A0D4-4C20-BD6F-DB7D20F36E18}']
    function _GetapplicationInfo: JApplicationInfo; cdecl;
    procedure _SetapplicationInfo(Value: JApplicationInfo); cdecl;
    function _GetdescriptionRes: Integer; cdecl;
    procedure _SetdescriptionRes(Value: Integer); cdecl;
    function _Getenabled: Boolean; cdecl;
    procedure _Setenabled(Value: Boolean); cdecl;
    function _Getexported: Boolean; cdecl;
    procedure _Setexported(Value: Boolean); cdecl;
    function _GetprocessName: JString; cdecl;
    procedure _SetprocessName(Value: JString); cdecl;
    function getBannerResource: Integer; cdecl;
    function getIconResource: Integer; cdecl;
    function getLogoResource: Integer; cdecl;
    function isEnabled: Boolean; cdecl;
    function loadLabel(pm: JPackageManager): JCharSequence; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property applicationInfo: JApplicationInfo read _GetapplicationInfo write _SetapplicationInfo;
    property descriptionRes: Integer read _GetdescriptionRes write _SetdescriptionRes;
    property enabled: Boolean read _Getenabled write _Setenabled;
    property exported: Boolean read _Getexported write _Setexported;
    property processName: JString read _GetprocessName write _SetprocessName;
  end;
  TJComponentInfo = class(TJavaGenericImport<JComponentInfoClass, JComponentInfo>) end;

  JActivityInfoClass = interface(JComponentInfoClass)
    ['{668E9F65-FCB9-44FB-B049-B332B42C8201}']
    {class} function _GetCONFIG_DENSITY: Integer; cdecl;
    {class} function _GetCONFIG_FONT_SCALE: Integer; cdecl;
    {class} function _GetCONFIG_KEYBOARD: Integer; cdecl;
    {class} function _GetCONFIG_KEYBOARD_HIDDEN: Integer; cdecl;
    {class} function _GetCONFIG_LAYOUT_DIRECTION: Integer; cdecl;
    {class} function _GetCONFIG_LOCALE: Integer; cdecl;
    {class} function _GetCONFIG_MCC: Integer; cdecl;
    {class} function _GetCONFIG_MNC: Integer; cdecl;
    {class} function _GetCONFIG_NAVIGATION: Integer; cdecl;
    {class} function _GetCONFIG_ORIENTATION: Integer; cdecl;
    {class} function _GetCONFIG_SCREEN_LAYOUT: Integer; cdecl;
    {class} function _GetCONFIG_SCREEN_SIZE: Integer; cdecl;
    {class} function _GetCONFIG_SMALLEST_SCREEN_SIZE: Integer; cdecl;
    {class} function _GetCONFIG_TOUCHSCREEN: Integer; cdecl;
    {class} function _GetCONFIG_UI_MODE: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDOCUMENT_LAUNCH_ALWAYS: Integer; cdecl;
    {class} function _GetDOCUMENT_LAUNCH_INTO_EXISTING: Integer; cdecl;
    {class} function _GetDOCUMENT_LAUNCH_NEVER: Integer; cdecl;
    {class} function _GetDOCUMENT_LAUNCH_NONE: Integer; cdecl;
    {class} function _GetFLAG_ALLOW_TASK_REPARENTING: Integer; cdecl;
    {class} function _GetFLAG_ALWAYS_RETAIN_TASK_STATE: Integer; cdecl;
    {class} function _GetFLAG_AUTO_REMOVE_FROM_RECENTS: Integer; cdecl;
    {class} function _GetFLAG_CLEAR_TASK_ON_LAUNCH: Integer; cdecl;
    {class} function _GetFLAG_EXCLUDE_FROM_RECENTS: Integer; cdecl;
    {class} function _GetFLAG_FINISH_ON_CLOSE_SYSTEM_DIALOGS: Integer; cdecl;
    {class} function _GetFLAG_FINISH_ON_TASK_LAUNCH: Integer; cdecl;
    {class} function _GetFLAG_HARDWARE_ACCELERATED: Integer; cdecl;
    {class} function _GetFLAG_IMMERSIVE: Integer; cdecl;
    {class} function _GetFLAG_MULTIPROCESS: Integer; cdecl;
    {class} function _GetFLAG_NO_HISTORY: Integer; cdecl;
    {class} function _GetFLAG_RELINQUISH_TASK_IDENTITY: Integer; cdecl;
    {class} function _GetFLAG_RESUME_WHILE_PAUSING: Integer; cdecl;
    {class} function _GetFLAG_SINGLE_USER: Integer; cdecl;
    {class} function _GetFLAG_STATE_NOT_NEEDED: Integer; cdecl;
    {class} function _GetLAUNCH_MULTIPLE: Integer; cdecl;
    {class} function _GetLAUNCH_SINGLE_INSTANCE: Integer; cdecl;
    {class} function _GetLAUNCH_SINGLE_TASK: Integer; cdecl;
    {class} function _GetLAUNCH_SINGLE_TOP: Integer; cdecl;
    {class} function _GetPERSIST_ACROSS_REBOOTS: Integer; cdecl;
    {class} function _GetPERSIST_NEVER: Integer; cdecl;
    {class} function _GetPERSIST_ROOT_ONLY: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_BEHIND: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_FULL_SENSOR: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_FULL_USER: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_LANDSCAPE: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_LOCKED: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_NOSENSOR: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_PORTRAIT: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_REVERSE_LANDSCAPE: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_REVERSE_PORTRAIT: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_SENSOR: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_SENSOR_LANDSCAPE: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_SENSOR_PORTRAIT: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_UNSPECIFIED: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_USER: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_USER_LANDSCAPE: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_USER_PORTRAIT: Integer; cdecl;
    {class} function _GetUIOPTION_SPLIT_ACTION_BAR_WHEN_NARROW: Integer; cdecl;
    {class} function init: JActivityInfo; cdecl; overload;
    {class} function init(orig: JActivityInfo): JActivityInfo; cdecl; overload;
    {class} property CONFIG_DENSITY: Integer read _GetCONFIG_DENSITY;
    {class} property CONFIG_FONT_SCALE: Integer read _GetCONFIG_FONT_SCALE;
    {class} property CONFIG_KEYBOARD: Integer read _GetCONFIG_KEYBOARD;
    {class} property CONFIG_KEYBOARD_HIDDEN: Integer read _GetCONFIG_KEYBOARD_HIDDEN;
    {class} property CONFIG_LAYOUT_DIRECTION: Integer read _GetCONFIG_LAYOUT_DIRECTION;
    {class} property CONFIG_LOCALE: Integer read _GetCONFIG_LOCALE;
    {class} property CONFIG_MCC: Integer read _GetCONFIG_MCC;
    {class} property CONFIG_MNC: Integer read _GetCONFIG_MNC;
    {class} property CONFIG_NAVIGATION: Integer read _GetCONFIG_NAVIGATION;
    {class} property CONFIG_ORIENTATION: Integer read _GetCONFIG_ORIENTATION;
    {class} property CONFIG_SCREEN_LAYOUT: Integer read _GetCONFIG_SCREEN_LAYOUT;
    {class} property CONFIG_SCREEN_SIZE: Integer read _GetCONFIG_SCREEN_SIZE;
    {class} property CONFIG_SMALLEST_SCREEN_SIZE: Integer read _GetCONFIG_SMALLEST_SCREEN_SIZE;
    {class} property CONFIG_TOUCHSCREEN: Integer read _GetCONFIG_TOUCHSCREEN;
    {class} property CONFIG_UI_MODE: Integer read _GetCONFIG_UI_MODE;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DOCUMENT_LAUNCH_ALWAYS: Integer read _GetDOCUMENT_LAUNCH_ALWAYS;
    {class} property DOCUMENT_LAUNCH_INTO_EXISTING: Integer read _GetDOCUMENT_LAUNCH_INTO_EXISTING;
    {class} property DOCUMENT_LAUNCH_NEVER: Integer read _GetDOCUMENT_LAUNCH_NEVER;
    {class} property DOCUMENT_LAUNCH_NONE: Integer read _GetDOCUMENT_LAUNCH_NONE;
    {class} property FLAG_ALLOW_TASK_REPARENTING: Integer read _GetFLAG_ALLOW_TASK_REPARENTING;
    {class} property FLAG_ALWAYS_RETAIN_TASK_STATE: Integer read _GetFLAG_ALWAYS_RETAIN_TASK_STATE;
    {class} property FLAG_AUTO_REMOVE_FROM_RECENTS: Integer read _GetFLAG_AUTO_REMOVE_FROM_RECENTS;
    {class} property FLAG_CLEAR_TASK_ON_LAUNCH: Integer read _GetFLAG_CLEAR_TASK_ON_LAUNCH;
    {class} property FLAG_EXCLUDE_FROM_RECENTS: Integer read _GetFLAG_EXCLUDE_FROM_RECENTS;
    {class} property FLAG_FINISH_ON_CLOSE_SYSTEM_DIALOGS: Integer read _GetFLAG_FINISH_ON_CLOSE_SYSTEM_DIALOGS;
    {class} property FLAG_FINISH_ON_TASK_LAUNCH: Integer read _GetFLAG_FINISH_ON_TASK_LAUNCH;
    {class} property FLAG_HARDWARE_ACCELERATED: Integer read _GetFLAG_HARDWARE_ACCELERATED;
    {class} property FLAG_IMMERSIVE: Integer read _GetFLAG_IMMERSIVE;
    {class} property FLAG_MULTIPROCESS: Integer read _GetFLAG_MULTIPROCESS;
    {class} property FLAG_NO_HISTORY: Integer read _GetFLAG_NO_HISTORY;
    {class} property FLAG_RELINQUISH_TASK_IDENTITY: Integer read _GetFLAG_RELINQUISH_TASK_IDENTITY;
    {class} property FLAG_RESUME_WHILE_PAUSING: Integer read _GetFLAG_RESUME_WHILE_PAUSING;
    {class} property FLAG_SINGLE_USER: Integer read _GetFLAG_SINGLE_USER;
    {class} property FLAG_STATE_NOT_NEEDED: Integer read _GetFLAG_STATE_NOT_NEEDED;
    {class} property LAUNCH_MULTIPLE: Integer read _GetLAUNCH_MULTIPLE;
    {class} property LAUNCH_SINGLE_INSTANCE: Integer read _GetLAUNCH_SINGLE_INSTANCE;
    {class} property LAUNCH_SINGLE_TASK: Integer read _GetLAUNCH_SINGLE_TASK;
    {class} property LAUNCH_SINGLE_TOP: Integer read _GetLAUNCH_SINGLE_TOP;
    {class} property PERSIST_ACROSS_REBOOTS: Integer read _GetPERSIST_ACROSS_REBOOTS;
    {class} property PERSIST_NEVER: Integer read _GetPERSIST_NEVER;
    {class} property PERSIST_ROOT_ONLY: Integer read _GetPERSIST_ROOT_ONLY;
    {class} property SCREEN_ORIENTATION_BEHIND: Integer read _GetSCREEN_ORIENTATION_BEHIND;
    {class} property SCREEN_ORIENTATION_FULL_SENSOR: Integer read _GetSCREEN_ORIENTATION_FULL_SENSOR;
    {class} property SCREEN_ORIENTATION_FULL_USER: Integer read _GetSCREEN_ORIENTATION_FULL_USER;
    {class} property SCREEN_ORIENTATION_LANDSCAPE: Integer read _GetSCREEN_ORIENTATION_LANDSCAPE;
    {class} property SCREEN_ORIENTATION_LOCKED: Integer read _GetSCREEN_ORIENTATION_LOCKED;
    {class} property SCREEN_ORIENTATION_NOSENSOR: Integer read _GetSCREEN_ORIENTATION_NOSENSOR;
    {class} property SCREEN_ORIENTATION_PORTRAIT: Integer read _GetSCREEN_ORIENTATION_PORTRAIT;
    {class} property SCREEN_ORIENTATION_REVERSE_LANDSCAPE: Integer read _GetSCREEN_ORIENTATION_REVERSE_LANDSCAPE;
    {class} property SCREEN_ORIENTATION_REVERSE_PORTRAIT: Integer read _GetSCREEN_ORIENTATION_REVERSE_PORTRAIT;
    {class} property SCREEN_ORIENTATION_SENSOR: Integer read _GetSCREEN_ORIENTATION_SENSOR;
    {class} property SCREEN_ORIENTATION_SENSOR_LANDSCAPE: Integer read _GetSCREEN_ORIENTATION_SENSOR_LANDSCAPE;
    {class} property SCREEN_ORIENTATION_SENSOR_PORTRAIT: Integer read _GetSCREEN_ORIENTATION_SENSOR_PORTRAIT;
    {class} property SCREEN_ORIENTATION_UNSPECIFIED: Integer read _GetSCREEN_ORIENTATION_UNSPECIFIED;
    {class} property SCREEN_ORIENTATION_USER: Integer read _GetSCREEN_ORIENTATION_USER;
    {class} property SCREEN_ORIENTATION_USER_LANDSCAPE: Integer read _GetSCREEN_ORIENTATION_USER_LANDSCAPE;
    {class} property SCREEN_ORIENTATION_USER_PORTRAIT: Integer read _GetSCREEN_ORIENTATION_USER_PORTRAIT;
    {class} property UIOPTION_SPLIT_ACTION_BAR_WHEN_NARROW: Integer read _GetUIOPTION_SPLIT_ACTION_BAR_WHEN_NARROW;
  end;

  [JavaSignature('android/content/pm/ActivityInfo')]
  JActivityInfo = interface(JComponentInfo)
    ['{9C1A2F33-54F9-49B7-8AE1-B3B10008B309}']
    function _GetconfigChanges: Integer; cdecl;
    procedure _SetconfigChanges(Value: Integer); cdecl;
    function _GetdocumentLaunchMode: Integer; cdecl;
    procedure _SetdocumentLaunchMode(Value: Integer); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GetlaunchMode: Integer; cdecl;
    procedure _SetlaunchMode(Value: Integer); cdecl;
    function _GetmaxRecents: Integer; cdecl;
    procedure _SetmaxRecents(Value: Integer); cdecl;
    function _GetparentActivityName: JString; cdecl;
    procedure _SetparentActivityName(Value: JString); cdecl;
    function _Getpermission: JString; cdecl;
    procedure _Setpermission(Value: JString); cdecl;
    function _GetpersistableMode: Integer; cdecl;
    procedure _SetpersistableMode(Value: Integer); cdecl;
    function _GetscreenOrientation: Integer; cdecl;
    procedure _SetscreenOrientation(Value: Integer); cdecl;
    function _GetsoftInputMode: Integer; cdecl;
    procedure _SetsoftInputMode(Value: Integer); cdecl;
    function _GettargetActivity: JString; cdecl;
    procedure _SettargetActivity(Value: JString); cdecl;
    function _GettaskAffinity: JString; cdecl;
    procedure _SettaskAffinity(Value: JString); cdecl;
    function _Gettheme: Integer; cdecl;
    procedure _Settheme(Value: Integer); cdecl;
    function _GetuiOptions: Integer; cdecl;
    procedure _SetuiOptions(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function getThemeResource: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property configChanges: Integer read _GetconfigChanges write _SetconfigChanges;
    property documentLaunchMode: Integer read _GetdocumentLaunchMode write _SetdocumentLaunchMode;
    property flags: Integer read _Getflags write _Setflags;
    property launchMode: Integer read _GetlaunchMode write _SetlaunchMode;
    property maxRecents: Integer read _GetmaxRecents write _SetmaxRecents;
    property parentActivityName: JString read _GetparentActivityName write _SetparentActivityName;
    property permission: JString read _Getpermission write _Setpermission;
    property persistableMode: Integer read _GetpersistableMode write _SetpersistableMode;
    property screenOrientation: Integer read _GetscreenOrientation write _SetscreenOrientation;
    property softInputMode: Integer read _GetsoftInputMode write _SetsoftInputMode;
    property targetActivity: JString read _GettargetActivity write _SettargetActivity;
    property taskAffinity: JString read _GettaskAffinity write _SettaskAffinity;
    property theme: Integer read _Gettheme write _Settheme;
    property uiOptions: Integer read _GetuiOptions write _SetuiOptions;
  end;
  TJActivityInfo = class(TJavaGenericImport<JActivityInfoClass, JActivityInfo>) end;

  JApplicationInfoClass = interface(JPackageItemInfoClass)
    ['{6C1CC199-522E-457E-B714-632058B818A5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_ALLOW_BACKUP: Integer; cdecl;
    {class} function _GetFLAG_ALLOW_CLEAR_USER_DATA: Integer; cdecl;
    {class} function _GetFLAG_ALLOW_TASK_REPARENTING: Integer; cdecl;
    {class} function _GetFLAG_DEBUGGABLE: Integer; cdecl;
    {class} function _GetFLAG_EXTERNAL_STORAGE: Integer; cdecl;
    {class} function _GetFLAG_EXTRACT_NATIVE_LIBS: Integer; cdecl;
    {class} function _GetFLAG_FACTORY_TEST: Integer; cdecl;
    {class} function _GetFLAG_FULL_BACKUP_ONLY: Integer; cdecl;
    {class} function _GetFLAG_HARDWARE_ACCELERATED: Integer; cdecl;
    {class} function _GetFLAG_HAS_CODE: Integer; cdecl;
    {class} function _GetFLAG_INSTALLED: Integer; cdecl;
    {class} function _GetFLAG_IS_DATA_ONLY: Integer; cdecl;
    {class} function _GetFLAG_IS_GAME: Integer; cdecl;
    {class} function _GetFLAG_KILL_AFTER_RESTORE: Integer; cdecl;
    {class} function _GetFLAG_LARGE_HEAP: Integer; cdecl;
    {class} function _GetFLAG_MULTIARCH: Integer; cdecl;
    {class} function _GetFLAG_PERSISTENT: Integer; cdecl;
    {class} function _GetFLAG_RESIZEABLE_FOR_SCREENS: Integer; cdecl;
    {class} function _GetFLAG_RESTORE_ANY_VERSION: Integer; cdecl;
    {class} function _GetFLAG_STOPPED: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_LARGE_SCREENS: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_NORMAL_SCREENS: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_RTL: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_SCREEN_DENSITIES: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_SMALL_SCREENS: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_XLARGE_SCREENS: Integer; cdecl;
    {class} function _GetFLAG_SYSTEM: Integer; cdecl;
    {class} function _GetFLAG_TEST_ONLY: Integer; cdecl;
    {class} function _GetFLAG_UPDATED_SYSTEM_APP: Integer; cdecl;
    {class} function _GetFLAG_USES_CLEARTEXT_TRAFFIC: Integer; cdecl;
    {class} function _GetFLAG_VM_SAFE_MODE: Integer; cdecl;
    {class} function init: JApplicationInfo; cdecl; overload;
    {class} function init(orig: JApplicationInfo): JApplicationInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_ALLOW_BACKUP: Integer read _GetFLAG_ALLOW_BACKUP;
    {class} property FLAG_ALLOW_CLEAR_USER_DATA: Integer read _GetFLAG_ALLOW_CLEAR_USER_DATA;
    {class} property FLAG_ALLOW_TASK_REPARENTING: Integer read _GetFLAG_ALLOW_TASK_REPARENTING;
    {class} property FLAG_DEBUGGABLE: Integer read _GetFLAG_DEBUGGABLE;
    {class} property FLAG_EXTERNAL_STORAGE: Integer read _GetFLAG_EXTERNAL_STORAGE;
    {class} property FLAG_EXTRACT_NATIVE_LIBS: Integer read _GetFLAG_EXTRACT_NATIVE_LIBS;
    {class} property FLAG_FACTORY_TEST: Integer read _GetFLAG_FACTORY_TEST;
    {class} property FLAG_FULL_BACKUP_ONLY: Integer read _GetFLAG_FULL_BACKUP_ONLY;
    {class} property FLAG_HARDWARE_ACCELERATED: Integer read _GetFLAG_HARDWARE_ACCELERATED;
    {class} property FLAG_HAS_CODE: Integer read _GetFLAG_HAS_CODE;
    {class} property FLAG_INSTALLED: Integer read _GetFLAG_INSTALLED;
    {class} property FLAG_IS_DATA_ONLY: Integer read _GetFLAG_IS_DATA_ONLY;
    {class} property FLAG_IS_GAME: Integer read _GetFLAG_IS_GAME;
    {class} property FLAG_KILL_AFTER_RESTORE: Integer read _GetFLAG_KILL_AFTER_RESTORE;
    {class} property FLAG_LARGE_HEAP: Integer read _GetFLAG_LARGE_HEAP;
    {class} property FLAG_MULTIARCH: Integer read _GetFLAG_MULTIARCH;
    {class} property FLAG_PERSISTENT: Integer read _GetFLAG_PERSISTENT;
    {class} property FLAG_RESIZEABLE_FOR_SCREENS: Integer read _GetFLAG_RESIZEABLE_FOR_SCREENS;
    {class} property FLAG_RESTORE_ANY_VERSION: Integer read _GetFLAG_RESTORE_ANY_VERSION;
    {class} property FLAG_STOPPED: Integer read _GetFLAG_STOPPED;
    {class} property FLAG_SUPPORTS_LARGE_SCREENS: Integer read _GetFLAG_SUPPORTS_LARGE_SCREENS;
    {class} property FLAG_SUPPORTS_NORMAL_SCREENS: Integer read _GetFLAG_SUPPORTS_NORMAL_SCREENS;
    {class} property FLAG_SUPPORTS_RTL: Integer read _GetFLAG_SUPPORTS_RTL;
    {class} property FLAG_SUPPORTS_SCREEN_DENSITIES: Integer read _GetFLAG_SUPPORTS_SCREEN_DENSITIES;
    {class} property FLAG_SUPPORTS_SMALL_SCREENS: Integer read _GetFLAG_SUPPORTS_SMALL_SCREENS;
    {class} property FLAG_SUPPORTS_XLARGE_SCREENS: Integer read _GetFLAG_SUPPORTS_XLARGE_SCREENS;
    {class} property FLAG_SYSTEM: Integer read _GetFLAG_SYSTEM;
    {class} property FLAG_TEST_ONLY: Integer read _GetFLAG_TEST_ONLY;
    {class} property FLAG_UPDATED_SYSTEM_APP: Integer read _GetFLAG_UPDATED_SYSTEM_APP;
    {class} property FLAG_USES_CLEARTEXT_TRAFFIC: Integer read _GetFLAG_USES_CLEARTEXT_TRAFFIC;
    {class} property FLAG_VM_SAFE_MODE: Integer read _GetFLAG_VM_SAFE_MODE;
  end;

  [JavaSignature('android/content/pm/ApplicationInfo')]
  JApplicationInfo = interface(JPackageItemInfo)
    ['{821C839E-7C7F-401F-AECD-8C3317518BE9}']
    function _GetbackupAgentName: JString; cdecl;
    procedure _SetbackupAgentName(Value: JString); cdecl;
    function _GetclassName: JString; cdecl;
    procedure _SetclassName(Value: JString); cdecl;
    function _GetcompatibleWidthLimitDp: Integer; cdecl;
    procedure _SetcompatibleWidthLimitDp(Value: Integer); cdecl;
    function _GetdataDir: JString; cdecl;
    procedure _SetdataDir(Value: JString); cdecl;
    function _GetdescriptionRes: Integer; cdecl;
    procedure _SetdescriptionRes(Value: Integer); cdecl;
    function _Getenabled: Boolean; cdecl;
    procedure _Setenabled(Value: Boolean); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GetlargestWidthLimitDp: Integer; cdecl;
    procedure _SetlargestWidthLimitDp(Value: Integer); cdecl;
    function _GetmanageSpaceActivityName: JString; cdecl;
    procedure _SetmanageSpaceActivityName(Value: JString); cdecl;
    function _GetnativeLibraryDir: JString; cdecl;
    procedure _SetnativeLibraryDir(Value: JString); cdecl;
    function _Getpermission: JString; cdecl;
    procedure _Setpermission(Value: JString); cdecl;
    function _GetprocessName: JString; cdecl;
    procedure _SetprocessName(Value: JString); cdecl;
    function _GetpublicSourceDir: JString; cdecl;
    procedure _SetpublicSourceDir(Value: JString); cdecl;
    function _GetrequiresSmallestWidthDp: Integer; cdecl;
    procedure _SetrequiresSmallestWidthDp(Value: Integer); cdecl;
    function _GetsharedLibraryFiles: TJavaObjectArray<JString>; cdecl;
    procedure _SetsharedLibraryFiles(Value: TJavaObjectArray<JString>); cdecl;
    function _GetsourceDir: JString; cdecl;
    procedure _SetsourceDir(Value: JString); cdecl;
    function _GetsplitPublicSourceDirs: TJavaObjectArray<JString>; cdecl;
    procedure _SetsplitPublicSourceDirs(Value: TJavaObjectArray<JString>); cdecl;
    function _GetsplitSourceDirs: TJavaObjectArray<JString>; cdecl;
    procedure _SetsplitSourceDirs(Value: TJavaObjectArray<JString>); cdecl;
    function _GettargetSdkVersion: Integer; cdecl;
    procedure _SettargetSdkVersion(Value: Integer); cdecl;
    function _GettaskAffinity: JString; cdecl;
    procedure _SettaskAffinity(Value: JString); cdecl;
    function _Gettheme: Integer; cdecl;
    procedure _Settheme(Value: Integer); cdecl;
    function _GetuiOptions: Integer; cdecl;
    procedure _SetuiOptions(Value: Integer); cdecl;
    function _Getuid: Integer; cdecl;
    procedure _Setuid(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function loadDescription(pm: JPackageManager): JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property backupAgentName: JString read _GetbackupAgentName write _SetbackupAgentName;
    property className: JString read _GetclassName write _SetclassName;
    property compatibleWidthLimitDp: Integer read _GetcompatibleWidthLimitDp write _SetcompatibleWidthLimitDp;
    property dataDir: JString read _GetdataDir write _SetdataDir;
    property descriptionRes: Integer read _GetdescriptionRes write _SetdescriptionRes;
    property enabled: Boolean read _Getenabled write _Setenabled;
    property flags: Integer read _Getflags write _Setflags;
    property largestWidthLimitDp: Integer read _GetlargestWidthLimitDp write _SetlargestWidthLimitDp;
    property manageSpaceActivityName: JString read _GetmanageSpaceActivityName write _SetmanageSpaceActivityName;
    property nativeLibraryDir: JString read _GetnativeLibraryDir write _SetnativeLibraryDir;
    property permission: JString read _Getpermission write _Setpermission;
    property processName: JString read _GetprocessName write _SetprocessName;
    property publicSourceDir: JString read _GetpublicSourceDir write _SetpublicSourceDir;
    property requiresSmallestWidthDp: Integer read _GetrequiresSmallestWidthDp write _SetrequiresSmallestWidthDp;
    property sharedLibraryFiles: TJavaObjectArray<JString> read _GetsharedLibraryFiles write _SetsharedLibraryFiles;
    property sourceDir: JString read _GetsourceDir write _SetsourceDir;
    property splitPublicSourceDirs: TJavaObjectArray<JString> read _GetsplitPublicSourceDirs write _SetsplitPublicSourceDirs;
    property splitSourceDirs: TJavaObjectArray<JString> read _GetsplitSourceDirs write _SetsplitSourceDirs;
    property targetSdkVersion: Integer read _GettargetSdkVersion write _SettargetSdkVersion;
    property taskAffinity: JString read _GettaskAffinity write _SettaskAffinity;
    property theme: Integer read _Gettheme write _Settheme;
    property uiOptions: Integer read _GetuiOptions write _SetuiOptions;
    property uid: Integer read _Getuid write _Setuid;
  end;
  TJApplicationInfo = class(TJavaGenericImport<JApplicationInfoClass, JApplicationInfo>) end;

  JApplicationInfo_DisplayNameComparatorClass = interface(JObjectClass)
    ['{A2EC6479-49C1-4015-97E5-543F78A4D0B7}']
    {class} function init(pm: JPackageManager): JApplicationInfo_DisplayNameComparator; cdecl;
  end;

  [JavaSignature('android/content/pm/ApplicationInfo$DisplayNameComparator')]
  JApplicationInfo_DisplayNameComparator = interface(JObject)
    ['{D0078998-D2BF-4CD8-866F-8313C5B28069}']
    function compare(aa: JApplicationInfo; ab: JApplicationInfo): Integer; cdecl;
  end;
  TJApplicationInfo_DisplayNameComparator = class(TJavaGenericImport<JApplicationInfo_DisplayNameComparatorClass, JApplicationInfo_DisplayNameComparator>) end;

  JConfigurationInfoClass = interface(JObjectClass)
    ['{45B946FD-0196-413D-A521-2DCEE09FBDF3}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetGL_ES_VERSION_UNDEFINED: Integer; cdecl;
    {class} function _GetINPUT_FEATURE_FIVE_WAY_NAV: Integer; cdecl;
    {class} function _GetINPUT_FEATURE_HARD_KEYBOARD: Integer; cdecl;
    {class} function init: JConfigurationInfo; cdecl; overload;
    {class} function init(orig: JConfigurationInfo): JConfigurationInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property GL_ES_VERSION_UNDEFINED: Integer read _GetGL_ES_VERSION_UNDEFINED;
    {class} property INPUT_FEATURE_FIVE_WAY_NAV: Integer read _GetINPUT_FEATURE_FIVE_WAY_NAV;
    {class} property INPUT_FEATURE_HARD_KEYBOARD: Integer read _GetINPUT_FEATURE_HARD_KEYBOARD;
  end;

  [JavaSignature('android/content/pm/ConfigurationInfo')]
  JConfigurationInfo = interface(JObject)
    ['{7C7C1C86-3575-4631-A168-544AC96685AA}']
    function _GetreqGlEsVersion: Integer; cdecl;
    procedure _SetreqGlEsVersion(Value: Integer); cdecl;
    function _GetreqInputFeatures: Integer; cdecl;
    procedure _SetreqInputFeatures(Value: Integer); cdecl;
    function _GetreqKeyboardType: Integer; cdecl;
    procedure _SetreqKeyboardType(Value: Integer); cdecl;
    function _GetreqNavigation: Integer; cdecl;
    procedure _SetreqNavigation(Value: Integer); cdecl;
    function _GetreqTouchScreen: Integer; cdecl;
    procedure _SetreqTouchScreen(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function getGlEsVersion: JString; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property reqGlEsVersion: Integer read _GetreqGlEsVersion write _SetreqGlEsVersion;
    property reqInputFeatures: Integer read _GetreqInputFeatures write _SetreqInputFeatures;
    property reqKeyboardType: Integer read _GetreqKeyboardType write _SetreqKeyboardType;
    property reqNavigation: Integer read _GetreqNavigation write _SetreqNavigation;
    property reqTouchScreen: Integer read _GetreqTouchScreen write _SetreqTouchScreen;
  end;
  TJConfigurationInfo = class(TJavaGenericImport<JConfigurationInfoClass, JConfigurationInfo>) end;

  JFeatureGroupInfoClass = interface(JObjectClass)
    ['{04322493-8FAF-458A-9F83-38EC28A29498}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JFeatureGroupInfo; cdecl; overload;
    {class} function init(other: JFeatureGroupInfo): JFeatureGroupInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/pm/FeatureGroupInfo')]
  JFeatureGroupInfo = interface(JObject)
    ['{A21FD2B3-EA50-41DE-AE34-63386D3989AC}']
    function _Getfeatures: TJavaObjectArray<JFeatureInfo>; cdecl;
    procedure _Setfeatures(Value: TJavaObjectArray<JFeatureInfo>); cdecl;
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property features: TJavaObjectArray<JFeatureInfo> read _Getfeatures write _Setfeatures;
  end;
  TJFeatureGroupInfo = class(TJavaGenericImport<JFeatureGroupInfoClass, JFeatureGroupInfo>) end;

  JFeatureInfoClass = interface(JObjectClass)
    ['{4F2C5DED-CBE6-4F78-A84C-BEF08B859AC2}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_REQUIRED: Integer; cdecl;
    {class} function _GetGL_ES_VERSION_UNDEFINED: Integer; cdecl;
    {class} function init: JFeatureInfo; cdecl; overload;
    {class} function init(orig: JFeatureInfo): JFeatureInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_REQUIRED: Integer read _GetFLAG_REQUIRED;
    {class} property GL_ES_VERSION_UNDEFINED: Integer read _GetGL_ES_VERSION_UNDEFINED;
  end;

  [JavaSignature('android/content/pm/FeatureInfo')]
  JFeatureInfo = interface(JObject)
    ['{A62531D1-D497-45F3-9845-4E21175295FC}']
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _Getname: JString; cdecl;
    procedure _Setname(Value: JString); cdecl;
    function _GetreqGlEsVersion: Integer; cdecl;
    procedure _SetreqGlEsVersion(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function getGlEsVersion: JString; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property flags: Integer read _Getflags write _Setflags;
    property name: JString read _Getname write _Setname;
    property reqGlEsVersion: Integer read _GetreqGlEsVersion write _SetreqGlEsVersion;
  end;
  TJFeatureInfo = class(TJavaGenericImport<JFeatureInfoClass, JFeatureInfo>) end;

  JInstrumentationInfoClass = interface(JPackageItemInfoClass)
    ['{5335DAE0-A1E4-45D5-B9EE-EE7F60B1E86D}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JInstrumentationInfo; cdecl; overload;
    {class} function init(orig: JInstrumentationInfo): JInstrumentationInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/pm/InstrumentationInfo')]
  JInstrumentationInfo = interface(JPackageItemInfo)
    ['{8F71514D-3E27-4245-832C-AE9959BECD84}']
    function _GetdataDir: JString; cdecl;
    procedure _SetdataDir(Value: JString); cdecl;
    function _GetfunctionalTest: Boolean; cdecl;
    procedure _SetfunctionalTest(Value: Boolean); cdecl;
    function _GethandleProfiling: Boolean; cdecl;
    procedure _SethandleProfiling(Value: Boolean); cdecl;
    function _GetpublicSourceDir: JString; cdecl;
    procedure _SetpublicSourceDir(Value: JString); cdecl;
    function _GetsourceDir: JString; cdecl;
    procedure _SetsourceDir(Value: JString); cdecl;
    function _GetsplitPublicSourceDirs: TJavaObjectArray<JString>; cdecl;
    procedure _SetsplitPublicSourceDirs(Value: TJavaObjectArray<JString>); cdecl;
    function _GetsplitSourceDirs: TJavaObjectArray<JString>; cdecl;
    procedure _SetsplitSourceDirs(Value: TJavaObjectArray<JString>); cdecl;
    function _GettargetPackage: JString; cdecl;
    procedure _SettargetPackage(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property dataDir: JString read _GetdataDir write _SetdataDir;
    property functionalTest: Boolean read _GetfunctionalTest write _SetfunctionalTest;
    property handleProfiling: Boolean read _GethandleProfiling write _SethandleProfiling;
    property publicSourceDir: JString read _GetpublicSourceDir write _SetpublicSourceDir;
    property sourceDir: JString read _GetsourceDir write _SetsourceDir;
    property splitPublicSourceDirs: TJavaObjectArray<JString> read _GetsplitPublicSourceDirs write _SetsplitPublicSourceDirs;
    property splitSourceDirs: TJavaObjectArray<JString> read _GetsplitSourceDirs write _SetsplitSourceDirs;
    property targetPackage: JString read _GettargetPackage write _SettargetPackage;
  end;
  TJInstrumentationInfo = class(TJavaGenericImport<JInstrumentationInfoClass, JInstrumentationInfo>) end;

  JLabeledIntentClass = interface(JIntentClass)
    ['{1A42C952-80B3-4EC9-8C95-4FDE9E0D653F}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(origIntent: JIntent; sourcePackage: JString; labelRes: Integer; icon: Integer): JLabeledIntent; cdecl; overload;
    {class} function init(origIntent: JIntent; sourcePackage: JString; nonLocalizedLabel: JCharSequence; icon: Integer): JLabeledIntent; cdecl; overload;
    {class} function init(sourcePackage: JString; labelRes: Integer; icon: Integer): JLabeledIntent; cdecl; overload;
    {class} function init(sourcePackage: JString; nonLocalizedLabel: JCharSequence; icon: Integer): JLabeledIntent; cdecl; overload;
    {class} //CREATOR is defined in parent interface
  end;

  [JavaSignature('android/content/pm/LabeledIntent')]
  JLabeledIntent = interface(JIntent)
    ['{0127A87D-88DB-493E-AC69-4E00ADC4F08F}']
    function getIconResource: Integer; cdecl;
    function getLabelResource: Integer; cdecl;
    function getNonLocalizedLabel: JCharSequence; cdecl;
    function getSourcePackage: JString; cdecl;
    function loadIcon(pm: JPackageManager): JDrawable; cdecl;
    function loadLabel(pm: JPackageManager): JCharSequence; cdecl;
    procedure readFromParcel(in_: JParcel); cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
  end;
  TJLabeledIntent = class(TJavaGenericImport<JLabeledIntentClass, JLabeledIntent>) end;

  JLauncherActivityInfoClass = interface(JObjectClass)
    ['{566BE7B2-CA15-4C46-A804-69F7AA13E317}']
  end;

  [JavaSignature('android/content/pm/LauncherActivityInfo')]
  JLauncherActivityInfo = interface(JObject)
    ['{12299FFA-922A-4902-880E-D3D688C6B1F1}']
    function getApplicationInfo: JApplicationInfo; cdecl;
    function getBadgedIcon(density: Integer): JDrawable; cdecl;
    function getComponentName: JComponentName; cdecl;
    function getFirstInstallTime: Int64; cdecl;
    function getIcon(density: Integer): JDrawable; cdecl;
    function getLabel: JCharSequence; cdecl;
    function getName: JString; cdecl;
    function getUser: JUserHandle; cdecl;
  end;
  TJLauncherActivityInfo = class(TJavaGenericImport<JLauncherActivityInfoClass, JLauncherActivityInfo>) end;

  JLauncherAppsClass = interface(JObjectClass)
    ['{D20CF976-5DBF-4519-94BA-C5B67CF2BDF2}']
  end;

  [JavaSignature('android/content/pm/LauncherApps')]
  JLauncherApps = interface(JObject)
    ['{B53CB8E0-E3E5-4211-87C4-F57CFE3019D8}']
    function getActivityList(packageName: JString; user: JUserHandle): JList; cdecl;
    function isActivityEnabled(component: JComponentName; user: JUserHandle): Boolean; cdecl;
    function isPackageEnabled(packageName: JString; user: JUserHandle): Boolean; cdecl;
    procedure registerCallback(callback: JLauncherApps_Callback); cdecl; overload;
    procedure registerCallback(callback: JLauncherApps_Callback; handler: JHandler); cdecl; overload;
    function resolveActivity(intent: JIntent; user: JUserHandle): JLauncherActivityInfo; cdecl;
    procedure startAppDetailsActivity(component: JComponentName; user: JUserHandle; sourceBounds: JRect; opts: JBundle); cdecl;
    procedure startMainActivity(component: JComponentName; user: JUserHandle; sourceBounds: JRect; opts: JBundle); cdecl;
    procedure unregisterCallback(callback: JLauncherApps_Callback); cdecl;
  end;
  TJLauncherApps = class(TJavaGenericImport<JLauncherAppsClass, JLauncherApps>) end;

  JLauncherApps_CallbackClass = interface(JObjectClass)
    ['{2E493FBA-2CF0-48C5-8F17-D3861D353A3E}']
    {class} function init: JLauncherApps_Callback; cdecl;
  end;

  [JavaSignature('android/content/pm/LauncherApps$Callback')]
  JLauncherApps_Callback = interface(JObject)
    ['{1A199739-B2CD-4F18-866A-0D889946B751}']
    procedure onPackageAdded(packageName: JString; user: JUserHandle); cdecl;
    procedure onPackageChanged(packageName: JString; user: JUserHandle); cdecl;
    procedure onPackageRemoved(packageName: JString; user: JUserHandle); cdecl;
    procedure onPackagesAvailable(packageNames: TJavaObjectArray<JString>; user: JUserHandle; replacing: Boolean); cdecl;
    procedure onPackagesUnavailable(packageNames: TJavaObjectArray<JString>; user: JUserHandle; replacing: Boolean); cdecl;
  end;
  TJLauncherApps_Callback = class(TJavaGenericImport<JLauncherApps_CallbackClass, JLauncherApps_Callback>) end;

  JPackageInfoClass = interface(JObjectClass)
    ['{113B61F1-7B39-4C59-A2CC-87E301EE94B8}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetINSTALL_LOCATION_AUTO: Integer; cdecl;
    {class} function _GetINSTALL_LOCATION_INTERNAL_ONLY: Integer; cdecl;
    {class} function _GetINSTALL_LOCATION_PREFER_EXTERNAL: Integer; cdecl;
    {class} function _GetREQUESTED_PERMISSION_GRANTED: Integer; cdecl;
    {class} function _GetREQUESTED_PERMISSION_REQUIRED: Integer; cdecl;
    {class} function init: JPackageInfo; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property INSTALL_LOCATION_AUTO: Integer read _GetINSTALL_LOCATION_AUTO;
    {class} property INSTALL_LOCATION_INTERNAL_ONLY: Integer read _GetINSTALL_LOCATION_INTERNAL_ONLY;
    {class} property INSTALL_LOCATION_PREFER_EXTERNAL: Integer read _GetINSTALL_LOCATION_PREFER_EXTERNAL;
    {class} property REQUESTED_PERMISSION_GRANTED: Integer read _GetREQUESTED_PERMISSION_GRANTED;
    {class} property REQUESTED_PERMISSION_REQUIRED: Integer read _GetREQUESTED_PERMISSION_REQUIRED;
  end;

  [JavaSignature('android/content/pm/PackageInfo')]
  JPackageInfo = interface(JObject)
    ['{430E0F0C-5A02-46D7-A50F-2B192576D25E}']
    function _Getactivities: TJavaObjectArray<JActivityInfo>; cdecl;
    procedure _Setactivities(Value: TJavaObjectArray<JActivityInfo>); cdecl;
    function _GetapplicationInfo: JApplicationInfo; cdecl;
    procedure _SetapplicationInfo(Value: JApplicationInfo); cdecl;
    function _GetbaseRevisionCode: Integer; cdecl;
    procedure _SetbaseRevisionCode(Value: Integer); cdecl;
    function _GetconfigPreferences: TJavaObjectArray<JConfigurationInfo>; cdecl;
    procedure _SetconfigPreferences(Value: TJavaObjectArray<JConfigurationInfo>); cdecl;
    function _GetfeatureGroups: TJavaObjectArray<JFeatureGroupInfo>; cdecl;
    procedure _SetfeatureGroups(Value: TJavaObjectArray<JFeatureGroupInfo>); cdecl;
    function _GetfirstInstallTime: Int64; cdecl;
    procedure _SetfirstInstallTime(Value: Int64); cdecl;
    function _Getgids: TJavaArray<Integer>; cdecl;
    procedure _Setgids(Value: TJavaArray<Integer>); cdecl;
    function _GetinstallLocation: Integer; cdecl;
    procedure _SetinstallLocation(Value: Integer); cdecl;
    function _Getinstrumentation: TJavaObjectArray<JInstrumentationInfo>; cdecl;
    procedure _Setinstrumentation(Value: TJavaObjectArray<JInstrumentationInfo>); cdecl;
    function _GetlastUpdateTime: Int64; cdecl;
    procedure _SetlastUpdateTime(Value: Int64); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function _Getpermissions: TJavaObjectArray<JPermissionInfo>; cdecl;
    procedure _Setpermissions(Value: TJavaObjectArray<JPermissionInfo>); cdecl;
    function _Getproviders: TJavaObjectArray<JProviderInfo>; cdecl;
    procedure _Setproviders(Value: TJavaObjectArray<JProviderInfo>); cdecl;
    function _Getreceivers: TJavaObjectArray<JActivityInfo>; cdecl;
    procedure _Setreceivers(Value: TJavaObjectArray<JActivityInfo>); cdecl;
    function _GetreqFeatures: TJavaObjectArray<JFeatureInfo>; cdecl;
    procedure _SetreqFeatures(Value: TJavaObjectArray<JFeatureInfo>); cdecl;
    function _GetrequestedPermissions: TJavaObjectArray<JString>; cdecl;
    procedure _SetrequestedPermissions(Value: TJavaObjectArray<JString>); cdecl;
    function _GetrequestedPermissionsFlags: TJavaArray<Integer>; cdecl;
    procedure _SetrequestedPermissionsFlags(Value: TJavaArray<Integer>); cdecl;
    function _Getservices: TJavaObjectArray<JServiceInfo>; cdecl;
    procedure _Setservices(Value: TJavaObjectArray<JServiceInfo>); cdecl;
    function _GetsharedUserId: JString; cdecl;
    procedure _SetsharedUserId(Value: JString); cdecl;
    function _GetsharedUserLabel: Integer; cdecl;
    procedure _SetsharedUserLabel(Value: Integer); cdecl;
    function _Getsignatures: TJavaObjectArray<JSignature>; cdecl;
    procedure _Setsignatures(Value: TJavaObjectArray<JSignature>); cdecl;
    function _GetsplitNames: TJavaObjectArray<JString>; cdecl;
    procedure _SetsplitNames(Value: TJavaObjectArray<JString>); cdecl;
    function _GetsplitRevisionCodes: TJavaArray<Integer>; cdecl;
    procedure _SetsplitRevisionCodes(Value: TJavaArray<Integer>); cdecl;
    function _GetversionCode: Integer; cdecl;
    procedure _SetversionCode(Value: Integer); cdecl;
    function _GetversionName: JString; cdecl;
    procedure _SetversionName(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property activities: TJavaObjectArray<JActivityInfo> read _Getactivities write _Setactivities;
    property applicationInfo: JApplicationInfo read _GetapplicationInfo write _SetapplicationInfo;
    property baseRevisionCode: Integer read _GetbaseRevisionCode write _SetbaseRevisionCode;
    property configPreferences: TJavaObjectArray<JConfigurationInfo> read _GetconfigPreferences write _SetconfigPreferences;
    property featureGroups: TJavaObjectArray<JFeatureGroupInfo> read _GetfeatureGroups write _SetfeatureGroups;
    property firstInstallTime: Int64 read _GetfirstInstallTime write _SetfirstInstallTime;
    property gids: TJavaArray<Integer> read _Getgids write _Setgids;
    property installLocation: Integer read _GetinstallLocation write _SetinstallLocation;
    property instrumentation: TJavaObjectArray<JInstrumentationInfo> read _Getinstrumentation write _Setinstrumentation;
    property lastUpdateTime: Int64 read _GetlastUpdateTime write _SetlastUpdateTime;
    property packageName: JString read _GetpackageName write _SetpackageName;
    property permissions: TJavaObjectArray<JPermissionInfo> read _Getpermissions write _Setpermissions;
    property providers: TJavaObjectArray<JProviderInfo> read _Getproviders write _Setproviders;
    property receivers: TJavaObjectArray<JActivityInfo> read _Getreceivers write _Setreceivers;
    property reqFeatures: TJavaObjectArray<JFeatureInfo> read _GetreqFeatures write _SetreqFeatures;
    property requestedPermissions: TJavaObjectArray<JString> read _GetrequestedPermissions write _SetrequestedPermissions;
    property requestedPermissionsFlags: TJavaArray<Integer> read _GetrequestedPermissionsFlags write _SetrequestedPermissionsFlags;
    property services: TJavaObjectArray<JServiceInfo> read _Getservices write _Setservices;
    property sharedUserId: JString read _GetsharedUserId write _SetsharedUserId;
    property sharedUserLabel: Integer read _GetsharedUserLabel write _SetsharedUserLabel;
    property signatures: TJavaObjectArray<JSignature> read _Getsignatures write _Setsignatures;
    property splitNames: TJavaObjectArray<JString> read _GetsplitNames write _SetsplitNames;
    property splitRevisionCodes: TJavaArray<Integer> read _GetsplitRevisionCodes write _SetsplitRevisionCodes;
    property versionCode: Integer read _GetversionCode write _SetversionCode;
    property versionName: JString read _GetversionName write _SetversionName;
  end;
  TJPackageInfo = class(TJavaGenericImport<JPackageInfoClass, JPackageInfo>) end;

  JPackageInstallerClass = interface(JObjectClass)
    ['{19F07E3A-789F-40C6-99A1-909120CD4DE9}']
    {class} function _GetACTION_SESSION_DETAILS: JString; cdecl;
    {class} function _GetEXTRA_OTHER_PACKAGE_NAME: JString; cdecl;
    {class} function _GetEXTRA_PACKAGE_NAME: JString; cdecl;
    {class} function _GetEXTRA_SESSION_ID: JString; cdecl;
    {class} function _GetEXTRA_STATUS: JString; cdecl;
    {class} function _GetEXTRA_STATUS_MESSAGE: JString; cdecl;
    {class} function _GetEXTRA_STORAGE_PATH: JString; cdecl;
    {class} function _GetSTATUS_FAILURE: Integer; cdecl;
    {class} function _GetSTATUS_FAILURE_ABORTED: Integer; cdecl;
    {class} function _GetSTATUS_FAILURE_BLOCKED: Integer; cdecl;
    {class} function _GetSTATUS_FAILURE_CONFLICT: Integer; cdecl;
    {class} function _GetSTATUS_FAILURE_INCOMPATIBLE: Integer; cdecl;
    {class} function _GetSTATUS_FAILURE_INVALID: Integer; cdecl;
    {class} function _GetSTATUS_FAILURE_STORAGE: Integer; cdecl;
    {class} function _GetSTATUS_PENDING_USER_ACTION: Integer; cdecl;
    {class} function _GetSTATUS_SUCCESS: Integer; cdecl;
    {class} property ACTION_SESSION_DETAILS: JString read _GetACTION_SESSION_DETAILS;
    {class} property EXTRA_OTHER_PACKAGE_NAME: JString read _GetEXTRA_OTHER_PACKAGE_NAME;
    {class} property EXTRA_PACKAGE_NAME: JString read _GetEXTRA_PACKAGE_NAME;
    {class} property EXTRA_SESSION_ID: JString read _GetEXTRA_SESSION_ID;
    {class} property EXTRA_STATUS: JString read _GetEXTRA_STATUS;
    {class} property EXTRA_STATUS_MESSAGE: JString read _GetEXTRA_STATUS_MESSAGE;
    {class} property EXTRA_STORAGE_PATH: JString read _GetEXTRA_STORAGE_PATH;
    {class} property STATUS_FAILURE: Integer read _GetSTATUS_FAILURE;
    {class} property STATUS_FAILURE_ABORTED: Integer read _GetSTATUS_FAILURE_ABORTED;
    {class} property STATUS_FAILURE_BLOCKED: Integer read _GetSTATUS_FAILURE_BLOCKED;
    {class} property STATUS_FAILURE_CONFLICT: Integer read _GetSTATUS_FAILURE_CONFLICT;
    {class} property STATUS_FAILURE_INCOMPATIBLE: Integer read _GetSTATUS_FAILURE_INCOMPATIBLE;
    {class} property STATUS_FAILURE_INVALID: Integer read _GetSTATUS_FAILURE_INVALID;
    {class} property STATUS_FAILURE_STORAGE: Integer read _GetSTATUS_FAILURE_STORAGE;
    {class} property STATUS_PENDING_USER_ACTION: Integer read _GetSTATUS_PENDING_USER_ACTION;
    {class} property STATUS_SUCCESS: Integer read _GetSTATUS_SUCCESS;
  end;

  [JavaSignature('android/content/pm/PackageInstaller')]
  JPackageInstaller = interface(JObject)
    ['{1BA5FADE-7710-42E1-A199-37A88B826E15}']
    procedure abandonSession(sessionId: Integer); cdecl;
    function createSession(params: JPackageInstaller_SessionParams): Integer; cdecl;
    function getAllSessions: JList; cdecl;
    function getMySessions: JList; cdecl;
    function getSessionInfo(sessionId: Integer): JPackageInstaller_SessionInfo; cdecl;
    function openSession(sessionId: Integer): JPackageInstaller_Session; cdecl;
    procedure registerSessionCallback(callback: JPackageInstaller_SessionCallback); cdecl; overload;
    procedure registerSessionCallback(callback: JPackageInstaller_SessionCallback; handler: JHandler); cdecl; overload;
    procedure uninstall(packageName: JString; statusReceiver: JIntentSender); cdecl;
    procedure unregisterSessionCallback(callback: JPackageInstaller_SessionCallback); cdecl;
    procedure updateSessionAppIcon(sessionId: Integer; appIcon: JBitmap); cdecl;
    procedure updateSessionAppLabel(sessionId: Integer; appLabel: JCharSequence); cdecl;
  end;
  TJPackageInstaller = class(TJavaGenericImport<JPackageInstallerClass, JPackageInstaller>) end;

  JPackageInstaller_SessionClass = interface(JObjectClass)
    ['{015968BD-DBE9-418D-9808-C0DEF25877A5}']
  end;

  [JavaSignature('android/content/pm/PackageInstaller$Session')]
  JPackageInstaller_Session = interface(JObject)
    ['{29F67D42-2AF6-4905-980E-64F2D937C677}']
    procedure abandon; cdecl;
    procedure close; cdecl;
    procedure commit(statusReceiver: JIntentSender); cdecl;
    procedure fsync(out_: JOutputStream); cdecl;
    function getNames: TJavaObjectArray<JString>; cdecl;
    function openRead(name: JString): JInputStream; cdecl;
    function openWrite(name: JString; offsetBytes: Int64; lengthBytes: Int64): JOutputStream; cdecl;
    procedure setStagingProgress(progress: Single); cdecl;
  end;
  TJPackageInstaller_Session = class(TJavaGenericImport<JPackageInstaller_SessionClass, JPackageInstaller_Session>) end;

  JPackageInstaller_SessionCallbackClass = interface(JObjectClass)
    ['{AB57A11F-62EB-452E-AB6C-5F19433F642A}']
    {class} function init: JPackageInstaller_SessionCallback; cdecl;
  end;

  [JavaSignature('android/content/pm/PackageInstaller$SessionCallback')]
  JPackageInstaller_SessionCallback = interface(JObject)
    ['{BD5A32A3-678A-4213-856F-A285996FDC10}']
    procedure onActiveChanged(sessionId: Integer; active: Boolean); cdecl;
    procedure onBadgingChanged(sessionId: Integer); cdecl;
    procedure onCreated(sessionId: Integer); cdecl;
    procedure onFinished(sessionId: Integer; success: Boolean); cdecl;
    procedure onProgressChanged(sessionId: Integer; progress: Single); cdecl;
  end;
  TJPackageInstaller_SessionCallback = class(TJavaGenericImport<JPackageInstaller_SessionCallbackClass, JPackageInstaller_SessionCallback>) end;

  JPackageInstaller_SessionInfoClass = interface(JObjectClass)
    ['{5777B482-8B60-450F-AD1D-A133EA512EA8}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/pm/PackageInstaller$SessionInfo')]
  JPackageInstaller_SessionInfo = interface(JObject)
    ['{4BAD5960-E645-4648-9921-CBA20898BD91}']
    function createDetailsIntent: JIntent; cdecl;
    function describeContents: Integer; cdecl;
    function getAppIcon: JBitmap; cdecl;
    function getAppLabel: JCharSequence; cdecl;
    function getAppPackageName: JString; cdecl;
    function getInstallerPackageName: JString; cdecl;
    function getProgress: Single; cdecl;
    function getSessionId: Integer; cdecl;
    function isActive: Boolean; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJPackageInstaller_SessionInfo = class(TJavaGenericImport<JPackageInstaller_SessionInfoClass, JPackageInstaller_SessionInfo>) end;

  JPackageInstaller_SessionParamsClass = interface(JObjectClass)
    ['{1CBB7728-4DB6-4663-9E05-CC6FAB342AD6}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetMODE_FULL_INSTALL: Integer; cdecl;
    {class} function _GetMODE_INHERIT_EXISTING: Integer; cdecl;
    {class} function init(mode: Integer): JPackageInstaller_SessionParams; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property MODE_FULL_INSTALL: Integer read _GetMODE_FULL_INSTALL;
    {class} property MODE_INHERIT_EXISTING: Integer read _GetMODE_INHERIT_EXISTING;
  end;

  [JavaSignature('android/content/pm/PackageInstaller$SessionParams')]
  JPackageInstaller_SessionParams = interface(JObject)
    ['{6C23E61A-7DC0-455A-82B2-A0BFB8AB9556}']
    function describeContents: Integer; cdecl;
    procedure setAppIcon(appIcon: JBitmap); cdecl;
    procedure setAppLabel(appLabel: JCharSequence); cdecl;
    procedure setAppPackageName(appPackageName: JString); cdecl;
    procedure setInstallLocation(installLocation: Integer); cdecl;
    procedure setOriginatingUri(originatingUri: Jnet_Uri); cdecl;
    procedure setReferrerUri(referrerUri: Jnet_Uri); cdecl;
    procedure setSize(sizeBytes: Int64); cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJPackageInstaller_SessionParams = class(TJavaGenericImport<JPackageInstaller_SessionParamsClass, JPackageInstaller_SessionParams>) end;

  JPackageItemInfo_DisplayNameComparatorClass = interface(JObjectClass)
    ['{D65CE03C-43AB-4F7A-8B76-F9631BC95D98}']
    {class} function init(pm: JPackageManager): JPackageItemInfo_DisplayNameComparator; cdecl;
  end;

  [JavaSignature('android/content/pm/PackageItemInfo$DisplayNameComparator')]
  JPackageItemInfo_DisplayNameComparator = interface(JObject)
    ['{9B9CE437-9EBC-46BB-9334-F138DE5DCD5C}']
    function compare(aa: JPackageItemInfo; ab: JPackageItemInfo): Integer; cdecl;
  end;
  TJPackageItemInfo_DisplayNameComparator = class(TJavaGenericImport<JPackageItemInfo_DisplayNameComparatorClass, JPackageItemInfo_DisplayNameComparator>) end;

  JPackageManagerClass = interface(JObjectClass)
    ['{E911B416-BD2A-4EE5-8F4F-519E086224CC}']
    {class} function _GetCOMPONENT_ENABLED_STATE_DEFAULT: Integer; cdecl;
    {class} function _GetCOMPONENT_ENABLED_STATE_DISABLED: Integer; cdecl;
    {class} function _GetCOMPONENT_ENABLED_STATE_DISABLED_UNTIL_USED: Integer; cdecl;
    {class} function _GetCOMPONENT_ENABLED_STATE_DISABLED_USER: Integer; cdecl;
    {class} function _GetCOMPONENT_ENABLED_STATE_ENABLED: Integer; cdecl;
    {class} function _GetDONT_KILL_APP: Integer; cdecl;
    {class} function _GetEXTRA_VERIFICATION_ID: JString; cdecl;
    {class} function _GetEXTRA_VERIFICATION_RESULT: JString; cdecl;
    {class} function _GetFEATURE_APP_WIDGETS: JString; cdecl;
    {class} function _GetFEATURE_AUDIO_LOW_LATENCY: JString; cdecl;
    {class} function _GetFEATURE_AUDIO_OUTPUT: JString; cdecl;
    {class} function _GetFEATURE_AUDIO_PRO: JString; cdecl;
    {class} function _GetFEATURE_AUTOMOTIVE: JString; cdecl;
    {class} function _GetFEATURE_BACKUP: JString; cdecl;
    {class} function _GetFEATURE_BLUETOOTH: JString; cdecl;
    {class} function _GetFEATURE_BLUETOOTH_LE: JString; cdecl;
    {class} function _GetFEATURE_CAMERA: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_ANY: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_AUTOFOCUS: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_CAPABILITY_MANUAL_POST_PROCESSING: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_CAPABILITY_MANUAL_SENSOR: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_CAPABILITY_RAW: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_EXTERNAL: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_FLASH: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_FRONT: JString; cdecl;
    {class} function _GetFEATURE_CAMERA_LEVEL_FULL: JString; cdecl;
    {class} function _GetFEATURE_CONNECTION_SERVICE: JString; cdecl;
    {class} function _GetFEATURE_CONSUMER_IR: JString; cdecl;
    {class} function _GetFEATURE_DEVICE_ADMIN: JString; cdecl;
    {class} function _GetFEATURE_FAKETOUCH: JString; cdecl;
    {class} function _GetFEATURE_FAKETOUCH_MULTITOUCH_DISTINCT: JString; cdecl;
    {class} function _GetFEATURE_FAKETOUCH_MULTITOUCH_JAZZHAND: JString; cdecl;
    {class} function _GetFEATURE_FINGERPRINT: JString; cdecl;
    {class} function _GetFEATURE_GAMEPAD: JString; cdecl;
    {class} function _GetFEATURE_HIFI_SENSORS: JString; cdecl;
    {class} function _GetFEATURE_HOME_SCREEN: JString; cdecl;
    {class} function _GetFEATURE_INPUT_METHODS: JString; cdecl;
    {class} function _GetFEATURE_LEANBACK: JString; cdecl;
    {class} function _GetFEATURE_LIVE_TV: JString; cdecl;
    {class} function _GetFEATURE_LIVE_WALLPAPER: JString; cdecl;
    {class} function _GetFEATURE_LOCATION: JString; cdecl;
    {class} function _GetFEATURE_LOCATION_GPS: JString; cdecl;
    {class} function _GetFEATURE_LOCATION_NETWORK: JString; cdecl;
    {class} function _GetFEATURE_MANAGED_USERS: JString; cdecl;
    {class} function _GetFEATURE_MICROPHONE: JString; cdecl;
    {class} function _GetFEATURE_MIDI: JString; cdecl;
    {class} function _GetFEATURE_NFC: JString; cdecl;
    {class} function _GetFEATURE_NFC_HOST_CARD_EMULATION: JString; cdecl;
    {class} function _GetFEATURE_OPENGLES_EXTENSION_PACK: JString; cdecl;
    {class} function _GetFEATURE_PRINTING: JString; cdecl;
    {class} function _GetFEATURE_SCREEN_LANDSCAPE: JString; cdecl;
    {class} function _GetFEATURE_SCREEN_PORTRAIT: JString; cdecl;
    {class} function _GetFEATURE_SECURELY_REMOVES_USERS: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_ACCELEROMETER: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_AMBIENT_TEMPERATURE: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_BAROMETER: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_COMPASS: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_GYROSCOPE: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_HEART_RATE: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_HEART_RATE_ECG: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_LIGHT: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_PROXIMITY: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_RELATIVE_HUMIDITY: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_STEP_COUNTER: JString; cdecl;
    {class} function _GetFEATURE_SENSOR_STEP_DETECTOR: JString; cdecl;
    {class} function _GetFEATURE_SIP: JString; cdecl;
    {class} function _GetFEATURE_SIP_VOIP: JString; cdecl;
    {class} function _GetFEATURE_TELEPHONY: JString; cdecl;
    {class} function _GetFEATURE_TELEPHONY_CDMA: JString; cdecl;
    {class} function _GetFEATURE_TELEPHONY_GSM: JString; cdecl;
    {class} function _GetFEATURE_TELEVISION: JString; cdecl;
    {class} function _GetFEATURE_TOUCHSCREEN: JString; cdecl;
    {class} function _GetFEATURE_TOUCHSCREEN_MULTITOUCH: JString; cdecl;
    {class} function _GetFEATURE_TOUCHSCREEN_MULTITOUCH_DISTINCT: JString; cdecl;
    {class} function _GetFEATURE_TOUCHSCREEN_MULTITOUCH_JAZZHAND: JString; cdecl;
    {class} function _GetFEATURE_USB_ACCESSORY: JString; cdecl;
    {class} function _GetFEATURE_USB_HOST: JString; cdecl;
    {class} function _GetFEATURE_VERIFIED_BOOT: JString; cdecl;
    {class} function _GetFEATURE_WATCH: JString; cdecl;
    {class} function _GetFEATURE_WEBVIEW: JString; cdecl;
    {class} function _GetFEATURE_WIFI: JString; cdecl;
    {class} function _GetFEATURE_WIFI_DIRECT: JString; cdecl;
    {class} function _GetGET_ACTIVITIES: Integer; cdecl;
    {class} function _GetGET_CONFIGURATIONS: Integer; cdecl;
    {class} function _GetGET_DISABLED_COMPONENTS: Integer; cdecl;
    {class} function _GetGET_DISABLED_UNTIL_USED_COMPONENTS: Integer; cdecl;
    {class} function _GetGET_GIDS: Integer; cdecl;
    {class} function _GetGET_INSTRUMENTATION: Integer; cdecl;
    {class} function _GetGET_INTENT_FILTERS: Integer; cdecl;
    {class} function _GetGET_META_DATA: Integer; cdecl;
    {class} function _GetGET_PERMISSIONS: Integer; cdecl;
    {class} function _GetGET_PROVIDERS: Integer; cdecl;
    {class} function _GetGET_RECEIVERS: Integer; cdecl;
    {class} function _GetGET_RESOLVED_FILTER: Integer; cdecl;
    {class} function _GetGET_SERVICES: Integer; cdecl;
    {class} function _GetGET_SHARED_LIBRARY_FILES: Integer; cdecl;
    {class} function _GetGET_SIGNATURES: Integer; cdecl;
    {class} function _GetGET_UNINSTALLED_PACKAGES: Integer; cdecl;
    {class} function _GetGET_URI_PERMISSION_PATTERNS: Integer; cdecl;
    {class} function _GetMATCH_ALL: Integer; cdecl;
    {class} function _GetMATCH_DEFAULT_ONLY: Integer; cdecl;
    {class} function _GetMAXIMUM_VERIFICATION_TIMEOUT: Int64; cdecl;
    {class} function _GetPERMISSION_DENIED: Integer; cdecl;
    {class} function _GetPERMISSION_GRANTED: Integer; cdecl;
    {class} function _GetSIGNATURE_FIRST_NOT_SIGNED: Integer; cdecl;
    {class} function _GetSIGNATURE_MATCH: Integer; cdecl;
    {class} function _GetSIGNATURE_NEITHER_SIGNED: Integer; cdecl;
    {class} function _GetSIGNATURE_NO_MATCH: Integer; cdecl;
    {class} function _GetSIGNATURE_SECOND_NOT_SIGNED: Integer; cdecl;
    {class} function _GetSIGNATURE_UNKNOWN_PACKAGE: Integer; cdecl;
    {class} function _GetVERIFICATION_ALLOW: Integer; cdecl;
    {class} function _GetVERIFICATION_REJECT: Integer; cdecl;
    {class} function init: JPackageManager; cdecl;
    {class} property COMPONENT_ENABLED_STATE_DEFAULT: Integer read _GetCOMPONENT_ENABLED_STATE_DEFAULT;
    {class} property COMPONENT_ENABLED_STATE_DISABLED: Integer read _GetCOMPONENT_ENABLED_STATE_DISABLED;
    {class} property COMPONENT_ENABLED_STATE_DISABLED_UNTIL_USED: Integer read _GetCOMPONENT_ENABLED_STATE_DISABLED_UNTIL_USED;
    {class} property COMPONENT_ENABLED_STATE_DISABLED_USER: Integer read _GetCOMPONENT_ENABLED_STATE_DISABLED_USER;
    {class} property COMPONENT_ENABLED_STATE_ENABLED: Integer read _GetCOMPONENT_ENABLED_STATE_ENABLED;
    {class} property DONT_KILL_APP: Integer read _GetDONT_KILL_APP;
    {class} property EXTRA_VERIFICATION_ID: JString read _GetEXTRA_VERIFICATION_ID;
    {class} property EXTRA_VERIFICATION_RESULT: JString read _GetEXTRA_VERIFICATION_RESULT;
    {class} property FEATURE_APP_WIDGETS: JString read _GetFEATURE_APP_WIDGETS;
    {class} property FEATURE_AUDIO_LOW_LATENCY: JString read _GetFEATURE_AUDIO_LOW_LATENCY;
    {class} property FEATURE_AUDIO_OUTPUT: JString read _GetFEATURE_AUDIO_OUTPUT;
    {class} property FEATURE_AUDIO_PRO: JString read _GetFEATURE_AUDIO_PRO;
    {class} property FEATURE_AUTOMOTIVE: JString read _GetFEATURE_AUTOMOTIVE;
    {class} property FEATURE_BACKUP: JString read _GetFEATURE_BACKUP;
    {class} property FEATURE_BLUETOOTH: JString read _GetFEATURE_BLUETOOTH;
    {class} property FEATURE_BLUETOOTH_LE: JString read _GetFEATURE_BLUETOOTH_LE;
    {class} property FEATURE_CAMERA: JString read _GetFEATURE_CAMERA;
    {class} property FEATURE_CAMERA_ANY: JString read _GetFEATURE_CAMERA_ANY;
    {class} property FEATURE_CAMERA_AUTOFOCUS: JString read _GetFEATURE_CAMERA_AUTOFOCUS;
    {class} property FEATURE_CAMERA_CAPABILITY_MANUAL_POST_PROCESSING: JString read _GetFEATURE_CAMERA_CAPABILITY_MANUAL_POST_PROCESSING;
    {class} property FEATURE_CAMERA_CAPABILITY_MANUAL_SENSOR: JString read _GetFEATURE_CAMERA_CAPABILITY_MANUAL_SENSOR;
    {class} property FEATURE_CAMERA_CAPABILITY_RAW: JString read _GetFEATURE_CAMERA_CAPABILITY_RAW;
    {class} property FEATURE_CAMERA_EXTERNAL: JString read _GetFEATURE_CAMERA_EXTERNAL;
    {class} property FEATURE_CAMERA_FLASH: JString read _GetFEATURE_CAMERA_FLASH;
    {class} property FEATURE_CAMERA_FRONT: JString read _GetFEATURE_CAMERA_FRONT;
    {class} property FEATURE_CAMERA_LEVEL_FULL: JString read _GetFEATURE_CAMERA_LEVEL_FULL;
    {class} property FEATURE_CONNECTION_SERVICE: JString read _GetFEATURE_CONNECTION_SERVICE;
    {class} property FEATURE_CONSUMER_IR: JString read _GetFEATURE_CONSUMER_IR;
    {class} property FEATURE_DEVICE_ADMIN: JString read _GetFEATURE_DEVICE_ADMIN;
    {class} property FEATURE_FAKETOUCH: JString read _GetFEATURE_FAKETOUCH;
    {class} property FEATURE_FAKETOUCH_MULTITOUCH_DISTINCT: JString read _GetFEATURE_FAKETOUCH_MULTITOUCH_DISTINCT;
    {class} property FEATURE_FAKETOUCH_MULTITOUCH_JAZZHAND: JString read _GetFEATURE_FAKETOUCH_MULTITOUCH_JAZZHAND;
    {class} property FEATURE_FINGERPRINT: JString read _GetFEATURE_FINGERPRINT;
    {class} property FEATURE_GAMEPAD: JString read _GetFEATURE_GAMEPAD;
    {class} property FEATURE_HIFI_SENSORS: JString read _GetFEATURE_HIFI_SENSORS;
    {class} property FEATURE_HOME_SCREEN: JString read _GetFEATURE_HOME_SCREEN;
    {class} property FEATURE_INPUT_METHODS: JString read _GetFEATURE_INPUT_METHODS;
    {class} property FEATURE_LEANBACK: JString read _GetFEATURE_LEANBACK;
    {class} property FEATURE_LIVE_TV: JString read _GetFEATURE_LIVE_TV;
    {class} property FEATURE_LIVE_WALLPAPER: JString read _GetFEATURE_LIVE_WALLPAPER;
    {class} property FEATURE_LOCATION: JString read _GetFEATURE_LOCATION;
    {class} property FEATURE_LOCATION_GPS: JString read _GetFEATURE_LOCATION_GPS;
    {class} property FEATURE_LOCATION_NETWORK: JString read _GetFEATURE_LOCATION_NETWORK;
    {class} property FEATURE_MANAGED_USERS: JString read _GetFEATURE_MANAGED_USERS;
    {class} property FEATURE_MICROPHONE: JString read _GetFEATURE_MICROPHONE;
    {class} property FEATURE_MIDI: JString read _GetFEATURE_MIDI;
    {class} property FEATURE_NFC: JString read _GetFEATURE_NFC;
    {class} property FEATURE_NFC_HOST_CARD_EMULATION: JString read _GetFEATURE_NFC_HOST_CARD_EMULATION;
    {class} property FEATURE_OPENGLES_EXTENSION_PACK: JString read _GetFEATURE_OPENGLES_EXTENSION_PACK;
    {class} property FEATURE_PRINTING: JString read _GetFEATURE_PRINTING;
    {class} property FEATURE_SCREEN_LANDSCAPE: JString read _GetFEATURE_SCREEN_LANDSCAPE;
    {class} property FEATURE_SCREEN_PORTRAIT: JString read _GetFEATURE_SCREEN_PORTRAIT;
    {class} property FEATURE_SECURELY_REMOVES_USERS: JString read _GetFEATURE_SECURELY_REMOVES_USERS;
    {class} property FEATURE_SENSOR_ACCELEROMETER: JString read _GetFEATURE_SENSOR_ACCELEROMETER;
    {class} property FEATURE_SENSOR_AMBIENT_TEMPERATURE: JString read _GetFEATURE_SENSOR_AMBIENT_TEMPERATURE;
    {class} property FEATURE_SENSOR_BAROMETER: JString read _GetFEATURE_SENSOR_BAROMETER;
    {class} property FEATURE_SENSOR_COMPASS: JString read _GetFEATURE_SENSOR_COMPASS;
    {class} property FEATURE_SENSOR_GYROSCOPE: JString read _GetFEATURE_SENSOR_GYROSCOPE;
    {class} property FEATURE_SENSOR_HEART_RATE: JString read _GetFEATURE_SENSOR_HEART_RATE;
    {class} property FEATURE_SENSOR_HEART_RATE_ECG: JString read _GetFEATURE_SENSOR_HEART_RATE_ECG;
    {class} property FEATURE_SENSOR_LIGHT: JString read _GetFEATURE_SENSOR_LIGHT;
    {class} property FEATURE_SENSOR_PROXIMITY: JString read _GetFEATURE_SENSOR_PROXIMITY;
    {class} property FEATURE_SENSOR_RELATIVE_HUMIDITY: JString read _GetFEATURE_SENSOR_RELATIVE_HUMIDITY;
    {class} property FEATURE_SENSOR_STEP_COUNTER: JString read _GetFEATURE_SENSOR_STEP_COUNTER;
    {class} property FEATURE_SENSOR_STEP_DETECTOR: JString read _GetFEATURE_SENSOR_STEP_DETECTOR;
    {class} property FEATURE_SIP: JString read _GetFEATURE_SIP;
    {class} property FEATURE_SIP_VOIP: JString read _GetFEATURE_SIP_VOIP;
    {class} property FEATURE_TELEPHONY: JString read _GetFEATURE_TELEPHONY;
    {class} property FEATURE_TELEPHONY_CDMA: JString read _GetFEATURE_TELEPHONY_CDMA;
    {class} property FEATURE_TELEPHONY_GSM: JString read _GetFEATURE_TELEPHONY_GSM;
    {class} property FEATURE_TELEVISION: JString read _GetFEATURE_TELEVISION;
    {class} property FEATURE_TOUCHSCREEN: JString read _GetFEATURE_TOUCHSCREEN;
    {class} property FEATURE_TOUCHSCREEN_MULTITOUCH: JString read _GetFEATURE_TOUCHSCREEN_MULTITOUCH;
    {class} property FEATURE_TOUCHSCREEN_MULTITOUCH_DISTINCT: JString read _GetFEATURE_TOUCHSCREEN_MULTITOUCH_DISTINCT;
    {class} property FEATURE_TOUCHSCREEN_MULTITOUCH_JAZZHAND: JString read _GetFEATURE_TOUCHSCREEN_MULTITOUCH_JAZZHAND;
    {class} property FEATURE_USB_ACCESSORY: JString read _GetFEATURE_USB_ACCESSORY;
    {class} property FEATURE_USB_HOST: JString read _GetFEATURE_USB_HOST;
    {class} property FEATURE_VERIFIED_BOOT: JString read _GetFEATURE_VERIFIED_BOOT;
    {class} property FEATURE_WATCH: JString read _GetFEATURE_WATCH;
    {class} property FEATURE_WEBVIEW: JString read _GetFEATURE_WEBVIEW;
    {class} property FEATURE_WIFI: JString read _GetFEATURE_WIFI;
    {class} property FEATURE_WIFI_DIRECT: JString read _GetFEATURE_WIFI_DIRECT;
    {class} property GET_ACTIVITIES: Integer read _GetGET_ACTIVITIES;
    {class} property GET_CONFIGURATIONS: Integer read _GetGET_CONFIGURATIONS;
    {class} property GET_DISABLED_COMPONENTS: Integer read _GetGET_DISABLED_COMPONENTS;
    {class} property GET_DISABLED_UNTIL_USED_COMPONENTS: Integer read _GetGET_DISABLED_UNTIL_USED_COMPONENTS;
    {class} property GET_GIDS: Integer read _GetGET_GIDS;
    {class} property GET_INSTRUMENTATION: Integer read _GetGET_INSTRUMENTATION;
    {class} property GET_INTENT_FILTERS: Integer read _GetGET_INTENT_FILTERS;
    {class} property GET_META_DATA: Integer read _GetGET_META_DATA;
    {class} property GET_PERMISSIONS: Integer read _GetGET_PERMISSIONS;
    {class} property GET_PROVIDERS: Integer read _GetGET_PROVIDERS;
    {class} property GET_RECEIVERS: Integer read _GetGET_RECEIVERS;
    {class} property GET_RESOLVED_FILTER: Integer read _GetGET_RESOLVED_FILTER;
    {class} property GET_SERVICES: Integer read _GetGET_SERVICES;
    {class} property GET_SHARED_LIBRARY_FILES: Integer read _GetGET_SHARED_LIBRARY_FILES;
    {class} property GET_SIGNATURES: Integer read _GetGET_SIGNATURES;
    {class} property GET_UNINSTALLED_PACKAGES: Integer read _GetGET_UNINSTALLED_PACKAGES;
    {class} property GET_URI_PERMISSION_PATTERNS: Integer read _GetGET_URI_PERMISSION_PATTERNS;
    {class} property MATCH_ALL: Integer read _GetMATCH_ALL;
    {class} property MATCH_DEFAULT_ONLY: Integer read _GetMATCH_DEFAULT_ONLY;
    {class} property MAXIMUM_VERIFICATION_TIMEOUT: Int64 read _GetMAXIMUM_VERIFICATION_TIMEOUT;
    {class} property PERMISSION_DENIED: Integer read _GetPERMISSION_DENIED;
    {class} property PERMISSION_GRANTED: Integer read _GetPERMISSION_GRANTED;
    {class} property SIGNATURE_FIRST_NOT_SIGNED: Integer read _GetSIGNATURE_FIRST_NOT_SIGNED;
    {class} property SIGNATURE_MATCH: Integer read _GetSIGNATURE_MATCH;
    {class} property SIGNATURE_NEITHER_SIGNED: Integer read _GetSIGNATURE_NEITHER_SIGNED;
    {class} property SIGNATURE_NO_MATCH: Integer read _GetSIGNATURE_NO_MATCH;
    {class} property SIGNATURE_SECOND_NOT_SIGNED: Integer read _GetSIGNATURE_SECOND_NOT_SIGNED;
    {class} property SIGNATURE_UNKNOWN_PACKAGE: Integer read _GetSIGNATURE_UNKNOWN_PACKAGE;
    {class} property VERIFICATION_ALLOW: Integer read _GetVERIFICATION_ALLOW;
    {class} property VERIFICATION_REJECT: Integer read _GetVERIFICATION_REJECT;
  end;

  [JavaSignature('android/content/pm/PackageManager')]
  JPackageManager = interface(JObject)
    ['{9B00A726-E4BF-49E6-B802-AB17E4A5295F}']
    procedure addPackageToPreferred(packageName: JString); cdecl;//Deprecated
    function addPermission(info: JPermissionInfo): Boolean; cdecl;
    function addPermissionAsync(info: JPermissionInfo): Boolean; cdecl;
    procedure addPreferredActivity(filter: JIntentFilter; match: Integer; set_: TJavaObjectArray<JComponentName>; activity: JComponentName); cdecl;//Deprecated
    function canonicalToCurrentPackageNames(names: TJavaObjectArray<JString>): TJavaObjectArray<JString>; cdecl;
    function checkPermission(permName: JString; pkgName: JString): Integer; cdecl;
    function checkSignatures(pkg1: JString; pkg2: JString): Integer; cdecl; overload;
    function checkSignatures(uid1: Integer; uid2: Integer): Integer; cdecl; overload;
    procedure clearPackagePreferredActivities(packageName: JString); cdecl;
    function currentToCanonicalPackageNames(names: TJavaObjectArray<JString>): TJavaObjectArray<JString>; cdecl;
    procedure extendVerificationTimeout(id: Integer; verificationCodeAtTimeout: Integer; millisecondsToDelay: Int64); cdecl;
    function getActivityBanner(activityName: JComponentName): JDrawable; cdecl; overload;
    function getActivityBanner(intent: JIntent): JDrawable; cdecl; overload;
    function getActivityIcon(activityName: JComponentName): JDrawable; cdecl; overload;
    function getActivityIcon(intent: JIntent): JDrawable; cdecl; overload;
    function getActivityInfo(component: JComponentName; flags: Integer): JActivityInfo; cdecl;
    function getActivityLogo(activityName: JComponentName): JDrawable; cdecl; overload;
    function getActivityLogo(intent: JIntent): JDrawable; cdecl; overload;
    function getAllPermissionGroups(flags: Integer): JList; cdecl;
    function getApplicationBanner(info: JApplicationInfo): JDrawable; cdecl; overload;
    function getApplicationBanner(packageName: JString): JDrawable; cdecl; overload;
    function getApplicationEnabledSetting(packageName: JString): Integer; cdecl;
    function getApplicationIcon(info: JApplicationInfo): JDrawable; cdecl; overload;
    function getApplicationIcon(packageName: JString): JDrawable; cdecl; overload;
    function getApplicationInfo(packageName: JString; flags: Integer): JApplicationInfo; cdecl;
    function getApplicationLabel(info: JApplicationInfo): JCharSequence; cdecl;
    function getApplicationLogo(info: JApplicationInfo): JDrawable; cdecl; overload;
    function getApplicationLogo(packageName: JString): JDrawable; cdecl; overload;
    function getComponentEnabledSetting(componentName: JComponentName): Integer; cdecl;
    function getDefaultActivityIcon: JDrawable; cdecl;
    function getDrawable(packageName: JString; resid: Integer; appInfo: JApplicationInfo): JDrawable; cdecl;
    function getInstalledApplications(flags: Integer): JList; cdecl;
    function getInstalledPackages(flags: Integer): JList; cdecl;
    function getInstallerPackageName(packageName: JString): JString; cdecl;
    function getInstrumentationInfo(className: JComponentName; flags: Integer): JInstrumentationInfo; cdecl;
    function getLaunchIntentForPackage(packageName: JString): JIntent; cdecl;
    function getLeanbackLaunchIntentForPackage(packageName: JString): JIntent; cdecl;
    function getNameForUid(uid: Integer): JString; cdecl;
    function getPackageArchiveInfo(archiveFilePath: JString; flags: Integer): JPackageInfo; cdecl;
    function getPackageGids(packageName: JString): TJavaArray<Integer>; cdecl;
    function getPackageInfo(packageName: JString; flags: Integer): JPackageInfo; cdecl;
    function getPackageInstaller: JPackageInstaller; cdecl;
    function getPackagesForUid(uid: Integer): TJavaObjectArray<JString>; cdecl;
    function getPackagesHoldingPermissions(permissions: TJavaObjectArray<JString>; flags: Integer): JList; cdecl;
    function getPermissionGroupInfo(name: JString; flags: Integer): JPermissionGroupInfo; cdecl;
    function getPermissionInfo(name: JString; flags: Integer): JPermissionInfo; cdecl;
    function getPreferredActivities(outFilters: JList; outActivities: JList; packageName: JString): Integer; cdecl;
    function getPreferredPackages(flags: Integer): JList; cdecl;
    function getProviderInfo(component: JComponentName; flags: Integer): JProviderInfo; cdecl;
    function getReceiverInfo(component: JComponentName; flags: Integer): JActivityInfo; cdecl;
    function getResourcesForActivity(activityName: JComponentName): JResources; cdecl;
    function getResourcesForApplication(app: JApplicationInfo): JResources; cdecl; overload;
    function getResourcesForApplication(appPackageName: JString): JResources; cdecl; overload;
    function getServiceInfo(component: JComponentName; flags: Integer): JServiceInfo; cdecl;
    function getSystemAvailableFeatures: TJavaObjectArray<JFeatureInfo>; cdecl;
    function getSystemSharedLibraryNames: TJavaObjectArray<JString>; cdecl;
    function getText(packageName: JString; resid: Integer; appInfo: JApplicationInfo): JCharSequence; cdecl;
    function getUserBadgedDrawableForDensity(drawable: JDrawable; user: JUserHandle; badgeLocation: JRect; badgeDensity: Integer): JDrawable; cdecl;
    function getUserBadgedIcon(icon: JDrawable; user: JUserHandle): JDrawable; cdecl;
    function getUserBadgedLabel(label_: JCharSequence; user: JUserHandle): JCharSequence; cdecl;
    function getXml(packageName: JString; resid: Integer; appInfo: JApplicationInfo): JXmlResourceParser; cdecl;
    function hasSystemFeature(name: JString): Boolean; cdecl;
    function isPermissionRevokedByPolicy(permName: JString; pkgName: JString): Boolean; cdecl;
    function isSafeMode: Boolean; cdecl;
    function queryBroadcastReceivers(intent: JIntent; flags: Integer): JList; cdecl;
    function queryContentProviders(processName: JString; uid: Integer; flags: Integer): JList; cdecl;
    function queryInstrumentation(targetPackage: JString; flags: Integer): JList; cdecl;
    function queryIntentActivities(intent: JIntent; flags: Integer): JList; cdecl;
    function queryIntentActivityOptions(caller: JComponentName; specifics: TJavaObjectArray<JIntent>; intent: JIntent; flags: Integer): JList; cdecl;
    function queryIntentContentProviders(intent: JIntent; flags: Integer): JList; cdecl;
    function queryIntentServices(intent: JIntent; flags: Integer): JList; cdecl;
    function queryPermissionsByGroup(group: JString; flags: Integer): JList; cdecl;
    procedure removePackageFromPreferred(packageName: JString); cdecl;//Deprecated
    procedure removePermission(name: JString); cdecl;
    function resolveActivity(intent: JIntent; flags: Integer): JResolveInfo; cdecl;
    function resolveContentProvider(name: JString; flags: Integer): JProviderInfo; cdecl;
    function resolveService(intent: JIntent; flags: Integer): JResolveInfo; cdecl;
    procedure setApplicationEnabledSetting(packageName: JString; newState: Integer; flags: Integer); cdecl;
    procedure setComponentEnabledSetting(componentName: JComponentName; newState: Integer; flags: Integer); cdecl;
    procedure setInstallerPackageName(targetPackage: JString; installerPackageName: JString); cdecl;
    procedure verifyPendingInstall(id: Integer; verificationCode: Integer); cdecl;
  end;
  TJPackageManager = class(TJavaGenericImport<JPackageManagerClass, JPackageManager>) end;

  JPackageManager_NameNotFoundExceptionClass = interface(JAndroidExceptionClass)
    ['{88014691-9D44-4E2D-A6E3-EBF4013AB32A}']
    {class} function init: JPackageManager_NameNotFoundException; cdecl; overload;
    {class} function init(name: JString): JPackageManager_NameNotFoundException; cdecl; overload;
  end;

  [JavaSignature('android/content/pm/PackageManager$NameNotFoundException')]
  JPackageManager_NameNotFoundException = interface(JAndroidException)
    ['{1ABD6B0B-50BF-48D1-9597-6B4FAC875BDD}']
  end;
  TJPackageManager_NameNotFoundException = class(TJavaGenericImport<JPackageManager_NameNotFoundExceptionClass, JPackageManager_NameNotFoundException>) end;

  JPackageStatsClass = interface(JObjectClass)
    ['{784B2B42-5752-4326-B07D-233B196D3550}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(pkgName: JString): JPackageStats; cdecl; overload;
    {class} function init(source: JParcel): JPackageStats; cdecl; overload;
    {class} function init(pStats: JPackageStats): JPackageStats; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/pm/PackageStats')]
  JPackageStats = interface(JObject)
    ['{E3C49E36-2C4A-4AFE-A351-36B1439832E8}']
    function _GetcacheSize: Int64; cdecl;
    procedure _SetcacheSize(Value: Int64); cdecl;
    function _GetcodeSize: Int64; cdecl;
    procedure _SetcodeSize(Value: Int64); cdecl;
    function _GetdataSize: Int64; cdecl;
    procedure _SetdataSize(Value: Int64); cdecl;
    function _GetexternalCacheSize: Int64; cdecl;
    procedure _SetexternalCacheSize(Value: Int64); cdecl;
    function _GetexternalCodeSize: Int64; cdecl;
    procedure _SetexternalCodeSize(Value: Int64); cdecl;
    function _GetexternalDataSize: Int64; cdecl;
    procedure _SetexternalDataSize(Value: Int64); cdecl;
    function _GetexternalMediaSize: Int64; cdecl;
    procedure _SetexternalMediaSize(Value: Int64); cdecl;
    function _GetexternalObbSize: Int64; cdecl;
    procedure _SetexternalObbSize(Value: Int64); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property cacheSize: Int64 read _GetcacheSize write _SetcacheSize;
    property codeSize: Int64 read _GetcodeSize write _SetcodeSize;
    property dataSize: Int64 read _GetdataSize write _SetdataSize;
    property externalCacheSize: Int64 read _GetexternalCacheSize write _SetexternalCacheSize;
    property externalCodeSize: Int64 read _GetexternalCodeSize write _SetexternalCodeSize;
    property externalDataSize: Int64 read _GetexternalDataSize write _SetexternalDataSize;
    property externalMediaSize: Int64 read _GetexternalMediaSize write _SetexternalMediaSize;
    property externalObbSize: Int64 read _GetexternalObbSize write _SetexternalObbSize;
    property packageName: JString read _GetpackageName write _SetpackageName;
  end;
  TJPackageStats = class(TJavaGenericImport<JPackageStatsClass, JPackageStats>) end;

  JPathPermissionClass = interface(JPatternMatcherClass)
    ['{DBBBF98A-864E-4D1C-B4EB-CC18420332D6}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(pattern: JString; type_: Integer; readPermission: JString; writePermission: JString): JPathPermission; cdecl; overload;
    {class} function init(src: JParcel): JPathPermission; cdecl; overload;
    {class} //CREATOR is defined in parent interface
  end;

  [JavaSignature('android/content/pm/PathPermission')]
  JPathPermission = interface(JPatternMatcher)
    ['{E7931286-8F93-4F0D-A794-700D7CE7E59D}']
    function getReadPermission: JString; cdecl;
    function getWritePermission: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJPathPermission = class(TJavaGenericImport<JPathPermissionClass, JPathPermission>) end;

  JPermissionGroupInfoClass = interface(JPackageItemInfoClass)
    ['{964923E8-1297-49FE-B34F-0133BBFD0467}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_PERSONAL_INFO: Integer; cdecl;
    {class} function init: JPermissionGroupInfo; cdecl; overload;
    {class} function init(orig: JPermissionGroupInfo): JPermissionGroupInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_PERSONAL_INFO: Integer read _GetFLAG_PERSONAL_INFO;
  end;

  [JavaSignature('android/content/pm/PermissionGroupInfo')]
  JPermissionGroupInfo = interface(JPackageItemInfo)
    ['{1D8E1B26-089D-4458-AAEA-5C4E6179A631}']
    function _GetdescriptionRes: Integer; cdecl;
    procedure _SetdescriptionRes(Value: Integer); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GetnonLocalizedDescription: JCharSequence; cdecl;
    procedure _SetnonLocalizedDescription(Value: JCharSequence); cdecl;
    function _Getpriority: Integer; cdecl;
    procedure _Setpriority(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function loadDescription(pm: JPackageManager): JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property descriptionRes: Integer read _GetdescriptionRes write _SetdescriptionRes;
    property flags: Integer read _Getflags write _Setflags;
    property nonLocalizedDescription: JCharSequence read _GetnonLocalizedDescription write _SetnonLocalizedDescription;
    property priority: Integer read _Getpriority write _Setpriority;
  end;
  TJPermissionGroupInfo = class(TJavaGenericImport<JPermissionGroupInfoClass, JPermissionGroupInfo>) end;

  JPermissionInfoClass = interface(JPackageItemInfoClass)
    ['{E67E88B6-D393-402E-937D-D9EA9313CDCE}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_COSTS_MONEY: Integer; cdecl;
    {class} function _GetFLAG_INSTALLED: Integer; cdecl;
    {class} function _GetPROTECTION_DANGEROUS: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_APPOP: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_DEVELOPMENT: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_INSTALLER: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_PRE23: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_PREINSTALLED: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_PRIVILEGED: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_SYSTEM: Integer; cdecl;
    {class} function _GetPROTECTION_FLAG_VERIFIER: Integer; cdecl;
    {class} function _GetPROTECTION_MASK_BASE: Integer; cdecl;
    {class} function _GetPROTECTION_MASK_FLAGS: Integer; cdecl;
    {class} function _GetPROTECTION_NORMAL: Integer; cdecl;
    {class} function _GetPROTECTION_SIGNATURE: Integer; cdecl;
    {class} function _GetPROTECTION_SIGNATURE_OR_SYSTEM: Integer; cdecl;
    {class} function init: JPermissionInfo; cdecl; overload;
    {class} function init(orig: JPermissionInfo): JPermissionInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_COSTS_MONEY: Integer read _GetFLAG_COSTS_MONEY;
    {class} property FLAG_INSTALLED: Integer read _GetFLAG_INSTALLED;
    {class} property PROTECTION_DANGEROUS: Integer read _GetPROTECTION_DANGEROUS;
    {class} property PROTECTION_FLAG_APPOP: Integer read _GetPROTECTION_FLAG_APPOP;
    {class} property PROTECTION_FLAG_DEVELOPMENT: Integer read _GetPROTECTION_FLAG_DEVELOPMENT;
    {class} property PROTECTION_FLAG_INSTALLER: Integer read _GetPROTECTION_FLAG_INSTALLER;
    {class} property PROTECTION_FLAG_PRE23: Integer read _GetPROTECTION_FLAG_PRE23;
    {class} property PROTECTION_FLAG_PREINSTALLED: Integer read _GetPROTECTION_FLAG_PREINSTALLED;
    {class} property PROTECTION_FLAG_PRIVILEGED: Integer read _GetPROTECTION_FLAG_PRIVILEGED;
    {class} property PROTECTION_FLAG_SYSTEM: Integer read _GetPROTECTION_FLAG_SYSTEM;
    {class} property PROTECTION_FLAG_VERIFIER: Integer read _GetPROTECTION_FLAG_VERIFIER;
    {class} property PROTECTION_MASK_BASE: Integer read _GetPROTECTION_MASK_BASE;
    {class} property PROTECTION_MASK_FLAGS: Integer read _GetPROTECTION_MASK_FLAGS;
    {class} property PROTECTION_NORMAL: Integer read _GetPROTECTION_NORMAL;
    {class} property PROTECTION_SIGNATURE: Integer read _GetPROTECTION_SIGNATURE;
    {class} property PROTECTION_SIGNATURE_OR_SYSTEM: Integer read _GetPROTECTION_SIGNATURE_OR_SYSTEM;
  end;

  [JavaSignature('android/content/pm/PermissionInfo')]
  JPermissionInfo = interface(JPackageItemInfo)
    ['{6023977F-D9A2-4B92-B205-93C747E1D13B}']
    function _GetdescriptionRes: Integer; cdecl;
    procedure _SetdescriptionRes(Value: Integer); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _Getgroup: JString; cdecl;
    procedure _Setgroup(Value: JString); cdecl;
    function _GetnonLocalizedDescription: JCharSequence; cdecl;
    procedure _SetnonLocalizedDescription(Value: JCharSequence); cdecl;
    function _GetprotectionLevel: Integer; cdecl;
    procedure _SetprotectionLevel(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function loadDescription(pm: JPackageManager): JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property descriptionRes: Integer read _GetdescriptionRes write _SetdescriptionRes;
    property flags: Integer read _Getflags write _Setflags;
    property group: JString read _Getgroup write _Setgroup;
    property nonLocalizedDescription: JCharSequence read _GetnonLocalizedDescription write _SetnonLocalizedDescription;
    property protectionLevel: Integer read _GetprotectionLevel write _SetprotectionLevel;
  end;
  TJPermissionInfo = class(TJavaGenericImport<JPermissionInfoClass, JPermissionInfo>) end;

  JProviderInfoClass = interface(JComponentInfoClass)
    ['{65211587-41C0-4B0A-AA07-1BF3120B490A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_SINGLE_USER: Integer; cdecl;
    {class} function init: JProviderInfo; cdecl; overload;
    {class} function init(orig: JProviderInfo): JProviderInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_SINGLE_USER: Integer read _GetFLAG_SINGLE_USER;
  end;

  [JavaSignature('android/content/pm/ProviderInfo')]
  JProviderInfo = interface(JComponentInfo)
    ['{D001C0E5-CD94-4529-ABEF-DE6A6D4CD232}']
    function _Getauthority: JString; cdecl;
    procedure _Setauthority(Value: JString); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GetgrantUriPermissions: Boolean; cdecl;
    procedure _SetgrantUriPermissions(Value: Boolean); cdecl;
    function _GetinitOrder: Integer; cdecl;
    procedure _SetinitOrder(Value: Integer); cdecl;
    function _GetisSyncable: Boolean; cdecl;
    procedure _SetisSyncable(Value: Boolean); cdecl;
    function _Getmultiprocess: Boolean; cdecl;
    procedure _Setmultiprocess(Value: Boolean); cdecl;
    function _GetpathPermissions: TJavaObjectArray<JPathPermission>; cdecl;
    procedure _SetpathPermissions(Value: TJavaObjectArray<JPathPermission>); cdecl;
    function _GetreadPermission: JString; cdecl;
    procedure _SetreadPermission(Value: JString); cdecl;
    function _GeturiPermissionPatterns: TJavaObjectArray<JPatternMatcher>; cdecl;
    procedure _SeturiPermissionPatterns(Value: TJavaObjectArray<JPatternMatcher>); cdecl;
    function _GetwritePermission: JString; cdecl;
    procedure _SetwritePermission(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; parcelableFlags: Integer); cdecl;
    property authority: JString read _Getauthority write _Setauthority;
    property flags: Integer read _Getflags write _Setflags;
    property grantUriPermissions: Boolean read _GetgrantUriPermissions write _SetgrantUriPermissions;
    property initOrder: Integer read _GetinitOrder write _SetinitOrder;
    property isSyncable: Boolean read _GetisSyncable write _SetisSyncable;
    property multiprocess: Boolean read _Getmultiprocess write _Setmultiprocess;
    property pathPermissions: TJavaObjectArray<JPathPermission> read _GetpathPermissions write _SetpathPermissions;
    property readPermission: JString read _GetreadPermission write _SetreadPermission;
    property uriPermissionPatterns: TJavaObjectArray<JPatternMatcher> read _GeturiPermissionPatterns write _SeturiPermissionPatterns;
    property writePermission: JString read _GetwritePermission write _SetwritePermission;
  end;
  TJProviderInfo = class(TJavaGenericImport<JProviderInfoClass, JProviderInfo>) end;

  JResolveInfoClass = interface(JObjectClass)
    ['{4C04EF6B-B5BD-486D-90C1-F7F8AD2902DC}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JResolveInfo; cdecl; overload;
    {class} function init(orig: JResolveInfo): JResolveInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/pm/ResolveInfo')]
  JResolveInfo = interface(JObject)
    ['{467E8989-4CE6-43F0-AB23-FE4FC787F872}']
    function _GetactivityInfo: JActivityInfo; cdecl;
    procedure _SetactivityInfo(Value: JActivityInfo); cdecl;
    function _Getfilter: JIntentFilter; cdecl;
    procedure _Setfilter(Value: JIntentFilter); cdecl;
    function _Geticon: Integer; cdecl;
    procedure _Seticon(Value: Integer); cdecl;
    function _GetisDefault: Boolean; cdecl;
    procedure _SetisDefault(Value: Boolean); cdecl;
    function _GetlabelRes: Integer; cdecl;
    procedure _SetlabelRes(Value: Integer); cdecl;
    function _Getmatch: Integer; cdecl;
    procedure _Setmatch(Value: Integer); cdecl;
    function _GetnonLocalizedLabel: JCharSequence; cdecl;
    procedure _SetnonLocalizedLabel(Value: JCharSequence); cdecl;
    function _GetpreferredOrder: Integer; cdecl;
    procedure _SetpreferredOrder(Value: Integer); cdecl;
    function _Getpriority: Integer; cdecl;
    procedure _Setpriority(Value: Integer); cdecl;
    function _GetproviderInfo: JProviderInfo; cdecl;
    procedure _SetproviderInfo(Value: JProviderInfo); cdecl;
    function _GetresolvePackageName: JString; cdecl;
    procedure _SetresolvePackageName(Value: JString); cdecl;
    function _GetserviceInfo: JServiceInfo; cdecl;
    procedure _SetserviceInfo(Value: JServiceInfo); cdecl;
    function _GetspecificIndex: Integer; cdecl;
    procedure _SetspecificIndex(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function getIconResource: Integer; cdecl;
    function loadIcon(pm: JPackageManager): JDrawable; cdecl;
    function loadLabel(pm: JPackageManager): JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property activityInfo: JActivityInfo read _GetactivityInfo write _SetactivityInfo;
    property filter: JIntentFilter read _Getfilter write _Setfilter;
    property icon: Integer read _Geticon write _Seticon;
    property isDefault: Boolean read _GetisDefault write _SetisDefault;
    property labelRes: Integer read _GetlabelRes write _SetlabelRes;
    property match: Integer read _Getmatch write _Setmatch;
    property nonLocalizedLabel: JCharSequence read _GetnonLocalizedLabel write _SetnonLocalizedLabel;
    property preferredOrder: Integer read _GetpreferredOrder write _SetpreferredOrder;
    property priority: Integer read _Getpriority write _Setpriority;
    property providerInfo: JProviderInfo read _GetproviderInfo write _SetproviderInfo;
    property resolvePackageName: JString read _GetresolvePackageName write _SetresolvePackageName;
    property serviceInfo: JServiceInfo read _GetserviceInfo write _SetserviceInfo;
    property specificIndex: Integer read _GetspecificIndex write _SetspecificIndex;
  end;
  TJResolveInfo = class(TJavaGenericImport<JResolveInfoClass, JResolveInfo>) end;

  JResolveInfo_DisplayNameComparatorClass = interface(JObjectClass)
    ['{1A75CFB1-B2D2-4C6F-9424-71DBF8536869}']
    {class} function init(pm: JPackageManager): JResolveInfo_DisplayNameComparator; cdecl;
  end;

  [JavaSignature('android/content/pm/ResolveInfo$DisplayNameComparator')]
  JResolveInfo_DisplayNameComparator = interface(JObject)
    ['{6D7217A8-3402-4DF8-8DD8-4DB3429194D0}']
    function compare(a: JResolveInfo; b: JResolveInfo): Integer; cdecl;
  end;
  TJResolveInfo_DisplayNameComparator = class(TJavaGenericImport<JResolveInfo_DisplayNameComparatorClass, JResolveInfo_DisplayNameComparator>) end;

  JServiceInfoClass = interface(JComponentInfoClass)
    ['{AC714975-FAB2-45A1-A076-1652016BBEED}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_ISOLATED_PROCESS: Integer; cdecl;
    {class} function _GetFLAG_SINGLE_USER: Integer; cdecl;
    {class} function _GetFLAG_STOP_WITH_TASK: Integer; cdecl;
    {class} function init: JServiceInfo; cdecl; overload;
    {class} function init(orig: JServiceInfo): JServiceInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_ISOLATED_PROCESS: Integer read _GetFLAG_ISOLATED_PROCESS;
    {class} property FLAG_SINGLE_USER: Integer read _GetFLAG_SINGLE_USER;
    {class} property FLAG_STOP_WITH_TASK: Integer read _GetFLAG_STOP_WITH_TASK;
  end;

  [JavaSignature('android/content/pm/ServiceInfo')]
  JServiceInfo = interface(JComponentInfo)
    ['{50AE8F16-96AF-4441-AB34-FEF5038CD7D6}']
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _Getpermission: JString; cdecl;
    procedure _Setpermission(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property flags: Integer read _Getflags write _Setflags;
    property permission: JString read _Getpermission write _Setpermission;
  end;
  TJServiceInfo = class(TJavaGenericImport<JServiceInfoClass, JServiceInfo>) end;

  JSignatureClass = interface(JObjectClass)
    ['{09302121-4635-41A0-A997-7A6D89360D58}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(signature: TJavaArray<Byte>): JSignature; cdecl; overload;
    {class} function init(text: JString): JSignature; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/pm/Signature')]
  JSignature = interface(JObject)
    ['{31FAFA1C-0DB9-4CCD-96BC-332908BF2D01}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toByteArray: TJavaArray<Byte>; cdecl;
    function toChars: TJavaArray<Char>; cdecl; overload;
    function toChars(existingArray: TJavaArray<Char>; outLen: TJavaArray<Integer>): TJavaArray<Char>; cdecl; overload;
    function toCharsString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
  end;
  TJSignature = class(TJavaGenericImport<JSignatureClass, JSignature>) end;

  JAssetFileDescriptorClass = interface(JObjectClass)
    ['{018B7332-9F89-4C15-9916-0A1070375BD4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetUNKNOWN_LENGTH: Int64; cdecl;
    {class} function init(fd: JParcelFileDescriptor; startOffset: Int64; length: Int64): JAssetFileDescriptor; cdecl; overload;
    {class} function init(fd: JParcelFileDescriptor; startOffset: Int64; length: Int64; extras: JBundle): JAssetFileDescriptor; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property UNKNOWN_LENGTH: Int64 read _GetUNKNOWN_LENGTH;
  end;

  [JavaSignature('android/content/res/AssetFileDescriptor')]
  JAssetFileDescriptor = interface(JObject)
    ['{DB464100-96DF-443A-A210-BF6B9937911B}']
    procedure close; cdecl;
    function createInputStream: JFileInputStream; cdecl;
    function createOutputStream: JFileOutputStream; cdecl;
    function describeContents: Integer; cdecl;
    function getDeclaredLength: Int64; cdecl;
    function getExtras: JBundle; cdecl;
    function getFileDescriptor: JFileDescriptor; cdecl;
    function getLength: Int64; cdecl;
    function getParcelFileDescriptor: JParcelFileDescriptor; cdecl;
    function getStartOffset: Int64; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJAssetFileDescriptor = class(TJavaGenericImport<JAssetFileDescriptorClass, JAssetFileDescriptor>) end;

  JAssetFileDescriptor_AutoCloseInputStreamClass = interface(JParcelFileDescriptor_AutoCloseInputStreamClass)
    ['{2B308E42-8E36-4B97-BE28-0D5282CFFFD5}']
    {class} function init(fd: JAssetFileDescriptor): JAssetFileDescriptor_AutoCloseInputStream; cdecl;
  end;

  [JavaSignature('android/content/res/AssetFileDescriptor$AutoCloseInputStream')]
  JAssetFileDescriptor_AutoCloseInputStream = interface(JParcelFileDescriptor_AutoCloseInputStream)
    ['{281E5E4C-402B-4851-A5FC-06F1D53E8600}']
    function available: Integer; cdecl;
    procedure mark(readlimit: Integer); cdecl;
    function markSupported: Boolean; cdecl;
    function read: Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>; offset: Integer; count: Integer): Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>): Integer; cdecl; overload;
    procedure reset; cdecl;
    function skip(count: Int64): Int64; cdecl;
  end;
  TJAssetFileDescriptor_AutoCloseInputStream = class(TJavaGenericImport<JAssetFileDescriptor_AutoCloseInputStreamClass, JAssetFileDescriptor_AutoCloseInputStream>) end;

  JAssetFileDescriptor_AutoCloseOutputStreamClass = interface(JParcelFileDescriptor_AutoCloseOutputStreamClass)
    ['{7AEED44A-DF3A-492F-8BCF-11A2A39E1A9F}']
    {class} function init(fd: JAssetFileDescriptor): JAssetFileDescriptor_AutoCloseOutputStream; cdecl;
  end;

  [JavaSignature('android/content/res/AssetFileDescriptor$AutoCloseOutputStream')]
  JAssetFileDescriptor_AutoCloseOutputStream = interface(JParcelFileDescriptor_AutoCloseOutputStream)
    ['{F0D74178-1D4A-4023-B6C6-EA9E7643CA31}']
    procedure write(buffer: TJavaArray<Byte>; offset: Integer; count: Integer); cdecl; overload;
    procedure write(buffer: TJavaArray<Byte>); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
  end;
  TJAssetFileDescriptor_AutoCloseOutputStream = class(TJavaGenericImport<JAssetFileDescriptor_AutoCloseOutputStreamClass, JAssetFileDescriptor_AutoCloseOutputStream>) end;

  JAssetManagerClass = interface(JObjectClass)
    ['{4DA55E97-38E2-41CC-92DA-2764845B4E5A}']
    {class} function _GetACCESS_BUFFER: Integer; cdecl;
    {class} function _GetACCESS_RANDOM: Integer; cdecl;
    {class} function _GetACCESS_STREAMING: Integer; cdecl;
    {class} function _GetACCESS_UNKNOWN: Integer; cdecl;
    {class} property ACCESS_BUFFER: Integer read _GetACCESS_BUFFER;
    {class} property ACCESS_RANDOM: Integer read _GetACCESS_RANDOM;
    {class} property ACCESS_STREAMING: Integer read _GetACCESS_STREAMING;
    {class} property ACCESS_UNKNOWN: Integer read _GetACCESS_UNKNOWN;
  end;

  [JavaSignature('android/content/res/AssetManager')]
  JAssetManager = interface(JObject)
    ['{319A7832-408F-487B-8EF0-6BA96F232C84}']
    procedure close; cdecl;
    function getLocales: TJavaObjectArray<JString>; cdecl;
    function list(path: JString): TJavaObjectArray<JString>; cdecl;
    function open(fileName: JString): JInputStream; cdecl; overload;
    function open(fileName: JString; accessMode: Integer): JInputStream; cdecl; overload;
    function openFd(fileName: JString): JAssetFileDescriptor; cdecl;
    function openNonAssetFd(fileName: JString): JAssetFileDescriptor; cdecl; overload;
    function openNonAssetFd(cookie: Integer; fileName: JString): JAssetFileDescriptor; cdecl; overload;
    function openXmlResourceParser(fileName: JString): JXmlResourceParser; cdecl; overload;
    function openXmlResourceParser(cookie: Integer; fileName: JString): JXmlResourceParser; cdecl; overload;
  end;
  TJAssetManager = class(TJavaGenericImport<JAssetManagerClass, JAssetManager>) end;

  JAssetManager_AssetInputStreamClass = interface(JInputStreamClass)
    ['{55715557-E5A5-4411-BECA-FAA45DFDDDA3}']
  end;

  [JavaSignature('android/content/res/AssetManager$AssetInputStream')]
  JAssetManager_AssetInputStream = interface(JInputStream)
    ['{6AE63092-7E80-4139-B59B-F4EBE163F1A6}']
    function available: Integer; cdecl;
    procedure close; cdecl;
    procedure mark(readlimit: Integer); cdecl;
    function markSupported: Boolean; cdecl;
    function read: Integer; cdecl; overload;
    function read(b: TJavaArray<Byte>): Integer; cdecl; overload;
    function read(b: TJavaArray<Byte>; off: Integer; len: Integer): Integer; cdecl; overload;
    procedure reset; cdecl;
    function skip(n: Int64): Int64; cdecl;
  end;
  TJAssetManager_AssetInputStream = class(TJavaGenericImport<JAssetManager_AssetInputStreamClass, JAssetManager_AssetInputStream>) end;

  JColorStateListClass = interface(JObjectClass)
    ['{FE6E6803-0FA7-4277-8D1E-2386FAF50392}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(states: TJavaBiArray<Integer>; colors: TJavaArray<Integer>): JColorStateList; cdecl;
    {class} function createFromXml(r: JResources; parser: JXmlPullParser): JColorStateList; cdecl; overload;//Deprecated
    {class} function createFromXml(r: JResources; parser: JXmlPullParser; theme: JResources_Theme): JColorStateList; cdecl; overload;
    {class} function valueOf(color: Integer): JColorStateList; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/content/res/ColorStateList')]
  JColorStateList = interface(JObject)
    ['{63B96C0B-D508-4B27-B84C-48ECF4BA162B}']
    function describeContents: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColorForState(stateSet: TJavaArray<Integer>; defaultColor: Integer): Integer; cdecl;
    function getDefaultColor: Integer; cdecl;
    function isOpaque: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function toString: JString; cdecl;
    function withAlpha(alpha: Integer): JColorStateList; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJColorStateList = class(TJavaGenericImport<JColorStateListClass, JColorStateList>) end;

  JConfigurationClass = interface(JObjectClass)
    ['{ED192161-6D1B-44E2-9CD0-4688E2EE8B4B}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDENSITY_DPI_UNDEFINED: Integer; cdecl;
    {class} function _GetHARDKEYBOARDHIDDEN_NO: Integer; cdecl;
    {class} function _GetHARDKEYBOARDHIDDEN_UNDEFINED: Integer; cdecl;
    {class} function _GetHARDKEYBOARDHIDDEN_YES: Integer; cdecl;
    {class} function _GetKEYBOARDHIDDEN_NO: Integer; cdecl;
    {class} function _GetKEYBOARDHIDDEN_UNDEFINED: Integer; cdecl;
    {class} function _GetKEYBOARDHIDDEN_YES: Integer; cdecl;
    {class} function _GetKEYBOARD_12KEY: Integer; cdecl;
    {class} function _GetKEYBOARD_NOKEYS: Integer; cdecl;
    {class} function _GetKEYBOARD_QWERTY: Integer; cdecl;
    {class} function _GetKEYBOARD_UNDEFINED: Integer; cdecl;
    {class} function _GetMNC_ZERO: Integer; cdecl;
    {class} function _GetNAVIGATIONHIDDEN_NO: Integer; cdecl;
    {class} function _GetNAVIGATIONHIDDEN_UNDEFINED: Integer; cdecl;
    {class} function _GetNAVIGATIONHIDDEN_YES: Integer; cdecl;
    {class} function _GetNAVIGATION_DPAD: Integer; cdecl;
    {class} function _GetNAVIGATION_NONAV: Integer; cdecl;
    {class} function _GetNAVIGATION_TRACKBALL: Integer; cdecl;
    {class} function _GetNAVIGATION_UNDEFINED: Integer; cdecl;
    {class} function _GetNAVIGATION_WHEEL: Integer; cdecl;
    {class} function _GetORIENTATION_LANDSCAPE: Integer; cdecl;
    {class} function _GetORIENTATION_PORTRAIT: Integer; cdecl;
    {class} function _GetORIENTATION_SQUARE: Integer; cdecl;
    {class} function _GetORIENTATION_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LAYOUTDIR_LTR: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LAYOUTDIR_MASK: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LAYOUTDIR_RTL: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LAYOUTDIR_SHIFT: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LAYOUTDIR_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LONG_MASK: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LONG_NO: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LONG_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_LONG_YES: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_ROUND_MASK: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_ROUND_NO: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_ROUND_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_ROUND_YES: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_SIZE_LARGE: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_SIZE_MASK: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_SIZE_NORMAL: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_SIZE_SMALL: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_SIZE_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_SIZE_XLARGE: Integer; cdecl;
    {class} function _GetSCREENLAYOUT_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREEN_HEIGHT_DP_UNDEFINED: Integer; cdecl;
    {class} function _GetSCREEN_WIDTH_DP_UNDEFINED: Integer; cdecl;
    {class} function _GetSMALLEST_SCREEN_WIDTH_DP_UNDEFINED: Integer; cdecl;
    {class} function _GetTOUCHSCREEN_FINGER: Integer; cdecl;
    {class} function _GetTOUCHSCREEN_NOTOUCH: Integer; cdecl;
    {class} function _GetTOUCHSCREEN_STYLUS: Integer; cdecl;
    {class} function _GetTOUCHSCREEN_UNDEFINED: Integer; cdecl;
    {class} function _GetUI_MODE_NIGHT_MASK: Integer; cdecl;
    {class} function _GetUI_MODE_NIGHT_NO: Integer; cdecl;
    {class} function _GetUI_MODE_NIGHT_UNDEFINED: Integer; cdecl;
    {class} function _GetUI_MODE_NIGHT_YES: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_APPLIANCE: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_CAR: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_DESK: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_MASK: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_NORMAL: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_TELEVISION: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_UNDEFINED: Integer; cdecl;
    {class} function _GetUI_MODE_TYPE_WATCH: Integer; cdecl;
    {class} function init: JConfiguration; cdecl; overload;
    {class} function init(o: JConfiguration): JConfiguration; cdecl; overload;
    {class} function needNewResources(configChanges: Integer; interestingChanges: Integer): Boolean; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DENSITY_DPI_UNDEFINED: Integer read _GetDENSITY_DPI_UNDEFINED;
    {class} property HARDKEYBOARDHIDDEN_NO: Integer read _GetHARDKEYBOARDHIDDEN_NO;
    {class} property HARDKEYBOARDHIDDEN_UNDEFINED: Integer read _GetHARDKEYBOARDHIDDEN_UNDEFINED;
    {class} property HARDKEYBOARDHIDDEN_YES: Integer read _GetHARDKEYBOARDHIDDEN_YES;
    {class} property KEYBOARDHIDDEN_NO: Integer read _GetKEYBOARDHIDDEN_NO;
    {class} property KEYBOARDHIDDEN_UNDEFINED: Integer read _GetKEYBOARDHIDDEN_UNDEFINED;
    {class} property KEYBOARDHIDDEN_YES: Integer read _GetKEYBOARDHIDDEN_YES;
    {class} property KEYBOARD_12KEY: Integer read _GetKEYBOARD_12KEY;
    {class} property KEYBOARD_NOKEYS: Integer read _GetKEYBOARD_NOKEYS;
    {class} property KEYBOARD_QWERTY: Integer read _GetKEYBOARD_QWERTY;
    {class} property KEYBOARD_UNDEFINED: Integer read _GetKEYBOARD_UNDEFINED;
    {class} property MNC_ZERO: Integer read _GetMNC_ZERO;
    {class} property NAVIGATIONHIDDEN_NO: Integer read _GetNAVIGATIONHIDDEN_NO;
    {class} property NAVIGATIONHIDDEN_UNDEFINED: Integer read _GetNAVIGATIONHIDDEN_UNDEFINED;
    {class} property NAVIGATIONHIDDEN_YES: Integer read _GetNAVIGATIONHIDDEN_YES;
    {class} property NAVIGATION_DPAD: Integer read _GetNAVIGATION_DPAD;
    {class} property NAVIGATION_NONAV: Integer read _GetNAVIGATION_NONAV;
    {class} property NAVIGATION_TRACKBALL: Integer read _GetNAVIGATION_TRACKBALL;
    {class} property NAVIGATION_UNDEFINED: Integer read _GetNAVIGATION_UNDEFINED;
    {class} property NAVIGATION_WHEEL: Integer read _GetNAVIGATION_WHEEL;
    {class} property ORIENTATION_LANDSCAPE: Integer read _GetORIENTATION_LANDSCAPE;
    {class} property ORIENTATION_PORTRAIT: Integer read _GetORIENTATION_PORTRAIT;
    {class} property ORIENTATION_SQUARE: Integer read _GetORIENTATION_SQUARE;
    {class} property ORIENTATION_UNDEFINED: Integer read _GetORIENTATION_UNDEFINED;
    {class} property SCREENLAYOUT_LAYOUTDIR_LTR: Integer read _GetSCREENLAYOUT_LAYOUTDIR_LTR;
    {class} property SCREENLAYOUT_LAYOUTDIR_MASK: Integer read _GetSCREENLAYOUT_LAYOUTDIR_MASK;
    {class} property SCREENLAYOUT_LAYOUTDIR_RTL: Integer read _GetSCREENLAYOUT_LAYOUTDIR_RTL;
    {class} property SCREENLAYOUT_LAYOUTDIR_SHIFT: Integer read _GetSCREENLAYOUT_LAYOUTDIR_SHIFT;
    {class} property SCREENLAYOUT_LAYOUTDIR_UNDEFINED: Integer read _GetSCREENLAYOUT_LAYOUTDIR_UNDEFINED;
    {class} property SCREENLAYOUT_LONG_MASK: Integer read _GetSCREENLAYOUT_LONG_MASK;
    {class} property SCREENLAYOUT_LONG_NO: Integer read _GetSCREENLAYOUT_LONG_NO;
    {class} property SCREENLAYOUT_LONG_UNDEFINED: Integer read _GetSCREENLAYOUT_LONG_UNDEFINED;
    {class} property SCREENLAYOUT_LONG_YES: Integer read _GetSCREENLAYOUT_LONG_YES;
    {class} property SCREENLAYOUT_ROUND_MASK: Integer read _GetSCREENLAYOUT_ROUND_MASK;
    {class} property SCREENLAYOUT_ROUND_NO: Integer read _GetSCREENLAYOUT_ROUND_NO;
    {class} property SCREENLAYOUT_ROUND_UNDEFINED: Integer read _GetSCREENLAYOUT_ROUND_UNDEFINED;
    {class} property SCREENLAYOUT_ROUND_YES: Integer read _GetSCREENLAYOUT_ROUND_YES;
    {class} property SCREENLAYOUT_SIZE_LARGE: Integer read _GetSCREENLAYOUT_SIZE_LARGE;
    {class} property SCREENLAYOUT_SIZE_MASK: Integer read _GetSCREENLAYOUT_SIZE_MASK;
    {class} property SCREENLAYOUT_SIZE_NORMAL: Integer read _GetSCREENLAYOUT_SIZE_NORMAL;
    {class} property SCREENLAYOUT_SIZE_SMALL: Integer read _GetSCREENLAYOUT_SIZE_SMALL;
    {class} property SCREENLAYOUT_SIZE_UNDEFINED: Integer read _GetSCREENLAYOUT_SIZE_UNDEFINED;
    {class} property SCREENLAYOUT_SIZE_XLARGE: Integer read _GetSCREENLAYOUT_SIZE_XLARGE;
    {class} property SCREENLAYOUT_UNDEFINED: Integer read _GetSCREENLAYOUT_UNDEFINED;
    {class} property SCREEN_HEIGHT_DP_UNDEFINED: Integer read _GetSCREEN_HEIGHT_DP_UNDEFINED;
    {class} property SCREEN_WIDTH_DP_UNDEFINED: Integer read _GetSCREEN_WIDTH_DP_UNDEFINED;
    {class} property SMALLEST_SCREEN_WIDTH_DP_UNDEFINED: Integer read _GetSMALLEST_SCREEN_WIDTH_DP_UNDEFINED;
    {class} property TOUCHSCREEN_FINGER: Integer read _GetTOUCHSCREEN_FINGER;
    {class} property TOUCHSCREEN_NOTOUCH: Integer read _GetTOUCHSCREEN_NOTOUCH;
    {class} property TOUCHSCREEN_STYLUS: Integer read _GetTOUCHSCREEN_STYLUS;
    {class} property TOUCHSCREEN_UNDEFINED: Integer read _GetTOUCHSCREEN_UNDEFINED;
    {class} property UI_MODE_NIGHT_MASK: Integer read _GetUI_MODE_NIGHT_MASK;
    {class} property UI_MODE_NIGHT_NO: Integer read _GetUI_MODE_NIGHT_NO;
    {class} property UI_MODE_NIGHT_UNDEFINED: Integer read _GetUI_MODE_NIGHT_UNDEFINED;
    {class} property UI_MODE_NIGHT_YES: Integer read _GetUI_MODE_NIGHT_YES;
    {class} property UI_MODE_TYPE_APPLIANCE: Integer read _GetUI_MODE_TYPE_APPLIANCE;
    {class} property UI_MODE_TYPE_CAR: Integer read _GetUI_MODE_TYPE_CAR;
    {class} property UI_MODE_TYPE_DESK: Integer read _GetUI_MODE_TYPE_DESK;
    {class} property UI_MODE_TYPE_MASK: Integer read _GetUI_MODE_TYPE_MASK;
    {class} property UI_MODE_TYPE_NORMAL: Integer read _GetUI_MODE_TYPE_NORMAL;
    {class} property UI_MODE_TYPE_TELEVISION: Integer read _GetUI_MODE_TYPE_TELEVISION;
    {class} property UI_MODE_TYPE_UNDEFINED: Integer read _GetUI_MODE_TYPE_UNDEFINED;
    {class} property UI_MODE_TYPE_WATCH: Integer read _GetUI_MODE_TYPE_WATCH;
  end;

  [JavaSignature('android/content/res/Configuration')]
  JConfiguration = interface(JObject)
    ['{1D50A729-D1DD-4424-819B-A2106CC761DB}']
    function _GetdensityDpi: Integer; cdecl;
    procedure _SetdensityDpi(Value: Integer); cdecl;
    function _GetfontScale: Single; cdecl;
    procedure _SetfontScale(Value: Single); cdecl;
    function _GethardKeyboardHidden: Integer; cdecl;
    procedure _SethardKeyboardHidden(Value: Integer); cdecl;
    function _Getkeyboard: Integer; cdecl;
    procedure _Setkeyboard(Value: Integer); cdecl;
    function _GetkeyboardHidden: Integer; cdecl;
    procedure _SetkeyboardHidden(Value: Integer); cdecl;
    function _Getlocale: JLocale; cdecl;
    procedure _Setlocale(Value: JLocale); cdecl;
    function _Getmcc: Integer; cdecl;
    procedure _Setmcc(Value: Integer); cdecl;
    function _Getmnc: Integer; cdecl;
    procedure _Setmnc(Value: Integer); cdecl;
    function _Getnavigation: Integer; cdecl;
    procedure _Setnavigation(Value: Integer); cdecl;
    function _GetnavigationHidden: Integer; cdecl;
    procedure _SetnavigationHidden(Value: Integer); cdecl;
    function _Getorientation: Integer; cdecl;
    procedure _Setorientation(Value: Integer); cdecl;
    function _GetscreenHeightDp: Integer; cdecl;
    procedure _SetscreenHeightDp(Value: Integer); cdecl;
    function _GetscreenLayout: Integer; cdecl;
    procedure _SetscreenLayout(Value: Integer); cdecl;
    function _GetscreenWidthDp: Integer; cdecl;
    procedure _SetscreenWidthDp(Value: Integer); cdecl;
    function _GetsmallestScreenWidthDp: Integer; cdecl;
    procedure _SetsmallestScreenWidthDp(Value: Integer); cdecl;
    function _Gettouchscreen: Integer; cdecl;
    procedure _Settouchscreen(Value: Integer); cdecl;
    function _GetuiMode: Integer; cdecl;
    procedure _SetuiMode(Value: Integer); cdecl;
    function compareTo(that: JConfiguration): Integer; cdecl;
    function describeContents: Integer; cdecl;
    function diff(delta: JConfiguration): Integer; cdecl;
    function equals(that: JConfiguration): Boolean; cdecl; overload;
    function equals(that: JObject): Boolean; cdecl; overload;
    function getLayoutDirection: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isLayoutSizeAtLeast(size: Integer): Boolean; cdecl;
    function isScreenRound: Boolean; cdecl;
    procedure readFromParcel(source: JParcel); cdecl;
    procedure setLayoutDirection(locale: JLocale); cdecl;
    procedure setLocale(loc: JLocale); cdecl;
    procedure setTo(o: JConfiguration); cdecl;
    procedure setToDefaults; cdecl;
    function toString: JString; cdecl;
    function updateFrom(delta: JConfiguration): Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property densityDpi: Integer read _GetdensityDpi write _SetdensityDpi;
    property fontScale: Single read _GetfontScale write _SetfontScale;
    property hardKeyboardHidden: Integer read _GethardKeyboardHidden write _SethardKeyboardHidden;
    property keyboard: Integer read _Getkeyboard write _Setkeyboard;
    property keyboardHidden: Integer read _GetkeyboardHidden write _SetkeyboardHidden;
    property locale: JLocale read _Getlocale write _Setlocale;
    property mcc: Integer read _Getmcc write _Setmcc;
    property mnc: Integer read _Getmnc write _Setmnc;
    property navigation: Integer read _Getnavigation write _Setnavigation;
    property navigationHidden: Integer read _GetnavigationHidden write _SetnavigationHidden;
    property orientation: Integer read _Getorientation write _Setorientation;
    property screenHeightDp: Integer read _GetscreenHeightDp write _SetscreenHeightDp;
    property screenLayout: Integer read _GetscreenLayout write _SetscreenLayout;
    property screenWidthDp: Integer read _GetscreenWidthDp write _SetscreenWidthDp;
    property smallestScreenWidthDp: Integer read _GetsmallestScreenWidthDp write _SetsmallestScreenWidthDp;
    property touchscreen: Integer read _Gettouchscreen write _Settouchscreen;
    property uiMode: Integer read _GetuiMode write _SetuiMode;
  end;
  TJConfiguration = class(TJavaGenericImport<JConfigurationClass, JConfiguration>) end;

  JObbInfoClass = interface(JObjectClass)
    ['{8D534E48-EA84-4A80-8939-E86DAA95E0F5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetOBB_OVERLAY: Integer; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property OBB_OVERLAY: Integer read _GetOBB_OVERLAY;
  end;

  [JavaSignature('android/content/res/ObbInfo')]
  JObbInfo = interface(JObject)
    ['{9CF489E5-747A-454C-AB5E-3755133EF147}']
    function _Getfilename: JString; cdecl;
    procedure _Setfilename(Value: JString); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function _Getversion: Integer; cdecl;
    procedure _Setversion(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
    property filename: JString read _Getfilename write _Setfilename;
    property flags: Integer read _Getflags write _Setflags;
    property packageName: JString read _GetpackageName write _SetpackageName;
    property version: Integer read _Getversion write _Setversion;
  end;
  TJObbInfo = class(TJavaGenericImport<JObbInfoClass, JObbInfo>) end;

  JObbScannerClass = interface(JObjectClass)
    ['{A9E61D74-9F04-4163-9FED-F379826B414D}']
    {class} function getObbInfo(filePath: JString): JObbInfo; cdecl;
  end;

  [JavaSignature('android/content/res/ObbScanner')]
  JObbScanner = interface(JObject)
    ['{7941EFD3-144F-4281-A18A-6327DEAF2EC3}']
  end;
  TJObbScanner = class(TJavaGenericImport<JObbScannerClass, JObbScanner>) end;

  JResourcesClass = interface(JObjectClass)
    ['{FB4A6A0F-8AF6-4EDC-81E8-13B3253D9857}']
    {class} function init(assets: JAssetManager; metrics: JDisplayMetrics; config: JConfiguration): JResources; cdecl;
    {class} function getSystem: JResources; cdecl;
  end;

  [JavaSignature('android/content/res/Resources')]
  JResources = interface(JObject)
    ['{ADD30FF7-D701-41CF-A710-1149B206FCE0}']
    procedure finishPreloading; cdecl;
    procedure flushLayoutCache; cdecl;
    function getAnimation(id: Integer): JXmlResourceParser; cdecl;
    function getAssets: JAssetManager; cdecl;
    function getBoolean(id: Integer): Boolean; cdecl;
    function getColor(id: Integer): Integer; cdecl; overload;//Deprecated
    function getColor(id: Integer; theme: JResources_Theme): Integer; cdecl; overload;
    function getColorStateList(id: Integer): JColorStateList; cdecl; overload;//Deprecated
    function getColorStateList(id: Integer; theme: JResources_Theme): JColorStateList; cdecl; overload;
    function getConfiguration: JConfiguration; cdecl;
    function getDimension(id: Integer): Single; cdecl;
    function getDimensionPixelOffset(id: Integer): Integer; cdecl;
    function getDimensionPixelSize(id: Integer): Integer; cdecl;
    function getDisplayMetrics: JDisplayMetrics; cdecl;
    function getDrawable(id: Integer): JDrawable; cdecl; overload;//Deprecated
    function getDrawable(id: Integer; theme: JResources_Theme): JDrawable; cdecl; overload;
    function getDrawableForDensity(id: Integer; density: Integer): JDrawable; cdecl; overload;//Deprecated
    function getDrawableForDensity(id: Integer; density: Integer; theme: JResources_Theme): JDrawable; cdecl; overload;
    function getFraction(id: Integer; base: Integer; pbase: Integer): Single; cdecl;
    function getIdentifier(name: JString; defType: JString; defPackage: JString): Integer; cdecl;
    function getIntArray(id: Integer): TJavaArray<Integer>; cdecl;
    function getInteger(id: Integer): Integer; cdecl;
    function getLayout(id: Integer): JXmlResourceParser; cdecl;
    function getMovie(id: Integer): JMovie; cdecl;
    function getQuantityString(id: Integer; quantity: Integer): JString; cdecl; overload;
    function getQuantityText(id: Integer; quantity: Integer): JCharSequence; cdecl;
    function getResourceEntryName(resid: Integer): JString; cdecl;
    function getResourceName(resid: Integer): JString; cdecl;
    function getResourcePackageName(resid: Integer): JString; cdecl;
    function getResourceTypeName(resid: Integer): JString; cdecl;
    function getString(id: Integer): JString; cdecl; overload;
    function getStringArray(id: Integer): TJavaObjectArray<JString>; cdecl;
    function getText(id: Integer): JCharSequence; cdecl; overload;
    function getText(id: Integer; def: JCharSequence): JCharSequence; cdecl; overload;
    function getTextArray(id: Integer): TJavaObjectArray<JCharSequence>; cdecl;
    procedure getValue(id: Integer; outValue: JTypedValue; resolveRefs: Boolean); cdecl; overload;
    procedure getValue(name: JString; outValue: JTypedValue; resolveRefs: Boolean); cdecl; overload;
    procedure getValueForDensity(id: Integer; density: Integer; outValue: JTypedValue; resolveRefs: Boolean); cdecl;
    function getXml(id: Integer): JXmlResourceParser; cdecl;
    function newTheme: JResources_Theme; cdecl;
    function obtainAttributes(set_: JAttributeSet; attrs: TJavaArray<Integer>): JTypedArray; cdecl;
    function obtainTypedArray(id: Integer): JTypedArray; cdecl;
    function openRawResource(id: Integer): JInputStream; cdecl; overload;
    function openRawResource(id: Integer; value: JTypedValue): JInputStream; cdecl; overload;
    function openRawResourceFd(id: Integer): JAssetFileDescriptor; cdecl;
    procedure parseBundleExtra(tagName: JString; attrs: JAttributeSet; outBundle: JBundle); cdecl;
    procedure parseBundleExtras(parser: JXmlResourceParser; outBundle: JBundle); cdecl;
    procedure updateConfiguration(config: JConfiguration; metrics: JDisplayMetrics); cdecl;
  end;
  TJResources = class(TJavaGenericImport<JResourcesClass, JResources>) end;

  JResources_NotFoundExceptionClass = interface(JRuntimeExceptionClass)
    ['{67D1B823-0BF2-4DED-8AD0-E383DC53B37F}']
    {class} function init: JResources_NotFoundException; cdecl; overload;
    {class} function init(name: JString): JResources_NotFoundException; cdecl; overload;
  end;

  [JavaSignature('android/content/res/Resources$NotFoundException')]
  JResources_NotFoundException = interface(JRuntimeException)
    ['{A25CA5F9-9E49-4A67-A74A-0650828F8B84}']
  end;
  TJResources_NotFoundException = class(TJavaGenericImport<JResources_NotFoundExceptionClass, JResources_NotFoundException>) end;

  JResources_ThemeClass = interface(JObjectClass)
    ['{967E4A62-EA10-4238-BD59-44F1E821179C}']
  end;

  [JavaSignature('android/content/res/Resources$Theme')]
  JResources_Theme = interface(JObject)
    ['{74665859-1F41-447D-A92E-523CAAEA741D}']
    procedure applyStyle(resId: Integer; force: Boolean); cdecl;
    procedure dump(priority: Integer; tag: JString; prefix: JString); cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getDrawable(id: Integer): JDrawable; cdecl;
    function getResources: JResources; cdecl;
    function obtainStyledAttributes(attrs: TJavaArray<Integer>): JTypedArray; cdecl; overload;
    function obtainStyledAttributes(resid: Integer; attrs: TJavaArray<Integer>): JTypedArray; cdecl; overload;
    function obtainStyledAttributes(set_: JAttributeSet; attrs: TJavaArray<Integer>; defStyleAttr: Integer; defStyleRes: Integer): JTypedArray; cdecl; overload;
    function resolveAttribute(resid: Integer; outValue: JTypedValue; resolveRefs: Boolean): Boolean; cdecl;
    procedure setTo(other: JResources_Theme); cdecl;
  end;
  TJResources_Theme = class(TJavaGenericImport<JResources_ThemeClass, JResources_Theme>) end;

  JTypedArrayClass = interface(JObjectClass)
    ['{9AA420A7-6C38-40EA-876D-DA87109DA825}']
  end;

  [JavaSignature('android/content/res/TypedArray')]
  JTypedArray = interface(JObject)
    ['{CD776189-F421-46B2-BAE5-A66A72F034F7}']
    function getBoolean(index: Integer; defValue: Boolean): Boolean; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColor(index: Integer; defValue: Integer): Integer; cdecl;
    function getColorStateList(index: Integer): JColorStateList; cdecl;
    function getDimension(index: Integer; defValue: Single): Single; cdecl;
    function getDimensionPixelOffset(index: Integer; defValue: Integer): Integer; cdecl;
    function getDimensionPixelSize(index: Integer; defValue: Integer): Integer; cdecl;
    function getDrawable(index: Integer): JDrawable; cdecl;
    function getFloat(index: Integer; defValue: Single): Single; cdecl;
    function getFraction(index: Integer; base: Integer; pbase: Integer; defValue: Single): Single; cdecl;
    function getIndex(at: Integer): Integer; cdecl;
    function getIndexCount: Integer; cdecl;
    function getInt(index: Integer; defValue: Integer): Integer; cdecl;
    function getInteger(index: Integer; defValue: Integer): Integer; cdecl;
    function getLayoutDimension(index: Integer; name: JString): Integer; cdecl; overload;
    function getLayoutDimension(index: Integer; defValue: Integer): Integer; cdecl; overload;
    function getNonResourceString(index: Integer): JString; cdecl;
    function getPositionDescription: JString; cdecl;
    function getResourceId(index: Integer; defValue: Integer): Integer; cdecl;
    function getResources: JResources; cdecl;
    function getString(index: Integer): JString; cdecl;
    function getText(index: Integer): JCharSequence; cdecl;
    function getTextArray(index: Integer): TJavaObjectArray<JCharSequence>; cdecl;
    function getType(index: Integer): Integer; cdecl;
    function getValue(index: Integer; outValue: JTypedValue): Boolean; cdecl;
    function hasValue(index: Integer): Boolean; cdecl;
    function hasValueOrEmpty(index: Integer): Boolean; cdecl;
    function length: Integer; cdecl;
    function peekValue(index: Integer): JTypedValue; cdecl;
    procedure recycle; cdecl;
    function toString: JString; cdecl;
  end;
  TJTypedArray = class(TJavaGenericImport<JTypedArrayClass, JTypedArray>) end;

  JXmlResourceParserClass = interface(JAttributeSetClass)
    ['{E007E94A-8D69-4803-8C66-29C9AC6E1235}']
  end;

  [JavaSignature('android/content/res/XmlResourceParser')]
  JXmlResourceParser = interface(JAttributeSet)
    ['{D808A282-BBE2-4A1D-B909-82ACDFE2A84E}']
    procedure close; cdecl;
  end;
  TJXmlResourceParser = class(TJavaGenericImport<JXmlResourceParserClass, JXmlResourceParser>) end;

  JAbstractCursorClass = interface(JObjectClass)
    ['{D2259E9D-61A9-462B-9451-0203960662CF}']
    {class} function init: JAbstractCursor; cdecl;
  end;

  [JavaSignature('android/database/AbstractCursor')]
  JAbstractCursor = interface(JObject)
    ['{BECBD409-CC01-4E75-800B-DFC95071480C}']
    procedure close; cdecl;
    procedure copyStringToBuffer(columnIndex: Integer; buffer: Jdatabase_CharArrayBuffer); cdecl;
    procedure deactivate; cdecl;
    procedure fillWindow(position: Integer; window: JCursorWindow); cdecl;
    function getBlob(column: Integer): TJavaArray<Byte>; cdecl;
    function getColumnCount: Integer; cdecl;
    function getColumnIndex(columnName: JString): Integer; cdecl;
    function getColumnIndexOrThrow(columnName: JString): Integer; cdecl;
    function getColumnName(columnIndex: Integer): JString; cdecl;
    function getColumnNames: TJavaObjectArray<JString>; cdecl;
    function getCount: Integer; cdecl;
    function getDouble(column: Integer): Double; cdecl;
    function getExtras: JBundle; cdecl;
    function getFloat(column: Integer): Single; cdecl;
    function getInt(column: Integer): Integer; cdecl;
    function getLong(column: Integer): Int64; cdecl;
    function getNotificationUri: Jnet_Uri; cdecl;
    function getPosition: Integer; cdecl;
    function getShort(column: Integer): SmallInt; cdecl;
    function getString(column: Integer): JString; cdecl;
    function getType(column: Integer): Integer; cdecl;
    function getWantsAllOnMoveCalls: Boolean; cdecl;
    function getWindow: JCursorWindow; cdecl;
    function isAfterLast: Boolean; cdecl;
    function isBeforeFirst: Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function isFirst: Boolean; cdecl;
    function isLast: Boolean; cdecl;
    function isNull(column: Integer): Boolean; cdecl;
    function move(offset: Integer): Boolean; cdecl;
    function moveToFirst: Boolean; cdecl;
    function moveToLast: Boolean; cdecl;
    function moveToNext: Boolean; cdecl;
    function moveToPosition(position: Integer): Boolean; cdecl;
    function moveToPrevious: Boolean; cdecl;
    function onMove(oldPosition: Integer; newPosition: Integer): Boolean; cdecl;
    procedure registerContentObserver(observer: JContentObserver); cdecl;
    procedure registerDataSetObserver(observer: JDataSetObserver); cdecl;
    function requery: Boolean; cdecl;
    function respond(extras: JBundle): JBundle; cdecl;
    procedure setExtras(extras: JBundle); cdecl;
    procedure setNotificationUri(cr: JContentResolver; notifyUri: Jnet_Uri); cdecl;
    procedure unregisterContentObserver(observer: JContentObserver); cdecl;
    procedure unregisterDataSetObserver(observer: JDataSetObserver); cdecl;
  end;
  TJAbstractCursor = class(TJavaGenericImport<JAbstractCursorClass, JAbstractCursor>) end;

  JAbstractWindowedCursorClass = interface(JAbstractCursorClass)
    ['{FD0345F4-194C-4279-8D9A-8FE1D29AB7ED}']
    {class} function init: JAbstractWindowedCursor; cdecl;
  end;

  [JavaSignature('android/database/AbstractWindowedCursor')]
  JAbstractWindowedCursor = interface(JAbstractCursor)
    ['{134E53EE-0227-4D5D-AD3D-9ACC02B7ED70}']
    procedure copyStringToBuffer(columnIndex: Integer; buffer: Jdatabase_CharArrayBuffer); cdecl;
    function getBlob(columnIndex: Integer): TJavaArray<Byte>; cdecl;
    function getDouble(columnIndex: Integer): Double; cdecl;
    function getFloat(columnIndex: Integer): Single; cdecl;
    function getInt(columnIndex: Integer): Integer; cdecl;
    function getLong(columnIndex: Integer): Int64; cdecl;
    function getShort(columnIndex: Integer): SmallInt; cdecl;
    function getString(columnIndex: Integer): JString; cdecl;
    function getType(columnIndex: Integer): Integer; cdecl;
    function getWindow: JCursorWindow; cdecl;
    function hasWindow: Boolean; cdecl;
    function isBlob(columnIndex: Integer): Boolean; cdecl;//Deprecated
    function isFloat(columnIndex: Integer): Boolean; cdecl;//Deprecated
    function isLong(columnIndex: Integer): Boolean; cdecl;//Deprecated
    function isNull(columnIndex: Integer): Boolean; cdecl;
    function isString(columnIndex: Integer): Boolean; cdecl;//Deprecated
    procedure setWindow(window: JCursorWindow); cdecl;
  end;
  TJAbstractWindowedCursor = class(TJavaGenericImport<JAbstractWindowedCursorClass, JAbstractWindowedCursor>) end;

  Jdatabase_CharArrayBufferClass = interface(JObjectClass)
    ['{9803A361-150D-4474-8FDC-CB9CC38CFD8E}']
    {class} function init(size: Integer): Jdatabase_CharArrayBuffer; cdecl; overload;
    {class} function init(buf: TJavaArray<Char>): Jdatabase_CharArrayBuffer; cdecl; overload;
  end;

  [JavaSignature('android/database/CharArrayBuffer')]
  Jdatabase_CharArrayBuffer = interface(JObject)
    ['{C8B96698-AB4C-40DD-8075-99AF94766B5D}']
    function _Getdata: TJavaArray<Char>; cdecl;
    procedure _Setdata(Value: TJavaArray<Char>); cdecl;
    function _GetsizeCopied: Integer; cdecl;
    procedure _SetsizeCopied(Value: Integer); cdecl;
    property data: TJavaArray<Char> read _Getdata write _Setdata;
    property sizeCopied: Integer read _GetsizeCopied write _SetsizeCopied;
  end;
  TJdatabase_CharArrayBuffer = class(TJavaGenericImport<Jdatabase_CharArrayBufferClass, Jdatabase_CharArrayBuffer>) end;

  JCursorClass = interface(JCloseableClass)
    ['{BBCDC870-9E56-4704-94E9-B06FA2B6E945}']
    {class} function _GetFIELD_TYPE_BLOB: Integer; cdecl;
    {class} function _GetFIELD_TYPE_FLOAT: Integer; cdecl;
    {class} function _GetFIELD_TYPE_INTEGER: Integer; cdecl;
    {class} function _GetFIELD_TYPE_NULL: Integer; cdecl;
    {class} function _GetFIELD_TYPE_STRING: Integer; cdecl;
    {class} property FIELD_TYPE_BLOB: Integer read _GetFIELD_TYPE_BLOB;
    {class} property FIELD_TYPE_FLOAT: Integer read _GetFIELD_TYPE_FLOAT;
    {class} property FIELD_TYPE_INTEGER: Integer read _GetFIELD_TYPE_INTEGER;
    {class} property FIELD_TYPE_NULL: Integer read _GetFIELD_TYPE_NULL;
    {class} property FIELD_TYPE_STRING: Integer read _GetFIELD_TYPE_STRING;
  end;

  [JavaSignature('android/database/Cursor')]
  JCursor = interface(JCloseable)
    ['{5AAF735F-9251-4E0B-950B-A67F2E27F44C}']
    procedure close; cdecl;
    procedure copyStringToBuffer(columnIndex: Integer; buffer: Jdatabase_CharArrayBuffer); cdecl;
    procedure deactivate; cdecl;//Deprecated
    function getBlob(columnIndex: Integer): TJavaArray<Byte>; cdecl;
    function getColumnCount: Integer; cdecl;
    function getColumnIndex(columnName: JString): Integer; cdecl;
    function getColumnIndexOrThrow(columnName: JString): Integer; cdecl;
    function getColumnName(columnIndex: Integer): JString; cdecl;
    function getColumnNames: TJavaObjectArray<JString>; cdecl;
    function getCount: Integer; cdecl;
    function getDouble(columnIndex: Integer): Double; cdecl;
    function getExtras: JBundle; cdecl;
    function getFloat(columnIndex: Integer): Single; cdecl;
    function getInt(columnIndex: Integer): Integer; cdecl;
    function getLong(columnIndex: Integer): Int64; cdecl;
    function getNotificationUri: Jnet_Uri; cdecl;
    function getPosition: Integer; cdecl;
    function getShort(columnIndex: Integer): SmallInt; cdecl;
    function getString(columnIndex: Integer): JString; cdecl;
    function getType(columnIndex: Integer): Integer; cdecl;
    function getWantsAllOnMoveCalls: Boolean; cdecl;
    function isAfterLast: Boolean; cdecl;
    function isBeforeFirst: Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function isFirst: Boolean; cdecl;
    function isLast: Boolean; cdecl;
    function isNull(columnIndex: Integer): Boolean; cdecl;
    function move(offset: Integer): Boolean; cdecl;
    function moveToFirst: Boolean; cdecl;
    function moveToLast: Boolean; cdecl;
    function moveToNext: Boolean; cdecl;
    function moveToPosition(position: Integer): Boolean; cdecl;
    function moveToPrevious: Boolean; cdecl;
    procedure registerContentObserver(observer: JContentObserver); cdecl;
    procedure registerDataSetObserver(observer: JDataSetObserver); cdecl;
    function requery: Boolean; cdecl;//Deprecated
    function respond(extras: JBundle): JBundle; cdecl;
    procedure setExtras(extras: JBundle); cdecl;
    procedure setNotificationUri(cr: JContentResolver; uri: Jnet_Uri); cdecl;
    procedure unregisterContentObserver(observer: JContentObserver); cdecl;
    procedure unregisterDataSetObserver(observer: JDataSetObserver); cdecl;
  end;
  TJCursor = class(TJavaGenericImport<JCursorClass, JCursor>) end;

  JSQLiteClosableClass = interface(JObjectClass)
    ['{CA8FF629-F608-4D9F-9C8C-24FEBC885043}']
    {class} function init: JSQLiteClosable; cdecl;
  end;

  [JavaSignature('android/database/sqlite/SQLiteClosable')]
  JSQLiteClosable = interface(JObject)
    ['{96B1666D-82B6-4E92-AB43-CF56279857DC}']
    procedure acquireReference; cdecl;
    procedure close; cdecl;
    procedure releaseReference; cdecl;
    procedure releaseReferenceFromContainer; cdecl;//Deprecated
  end;
  TJSQLiteClosable = class(TJavaGenericImport<JSQLiteClosableClass, JSQLiteClosable>) end;

  JCursorWindowClass = interface(JSQLiteClosableClass)
    ['{0A0A1EE3-68E4-4DD9-8E94-83C16E95C14B}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(name: JString): JCursorWindow; cdecl; overload;
    {class} function init(localWindow: Boolean): JCursorWindow; cdecl; overload;//Deprecated
    {class} function newFromParcel(p: JParcel): JCursorWindow; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/database/CursorWindow')]
  JCursorWindow = interface(JSQLiteClosable)
    ['{F16F268C-E8E5-42A1-9709-260ECDA4395B}']
    function allocRow: Boolean; cdecl;
    procedure clear; cdecl;
    procedure copyStringToBuffer(row: Integer; column: Integer; buffer: Jdatabase_CharArrayBuffer); cdecl;
    function describeContents: Integer; cdecl;
    procedure freeLastRow; cdecl;
    function getBlob(row: Integer; column: Integer): TJavaArray<Byte>; cdecl;
    function getDouble(row: Integer; column: Integer): Double; cdecl;
    function getFloat(row: Integer; column: Integer): Single; cdecl;
    function getInt(row: Integer; column: Integer): Integer; cdecl;
    function getLong(row: Integer; column: Integer): Int64; cdecl;
    function getNumRows: Integer; cdecl;
    function getShort(row: Integer; column: Integer): SmallInt; cdecl;
    function getStartPosition: Integer; cdecl;
    function getString(row: Integer; column: Integer): JString; cdecl;
    function getType(row: Integer; column: Integer): Integer; cdecl;
    function isBlob(row: Integer; column: Integer): Boolean; cdecl;//Deprecated
    function isFloat(row: Integer; column: Integer): Boolean; cdecl;//Deprecated
    function isLong(row: Integer; column: Integer): Boolean; cdecl;//Deprecated
    function isNull(row: Integer; column: Integer): Boolean; cdecl;//Deprecated
    function isString(row: Integer; column: Integer): Boolean; cdecl;//Deprecated
    function putBlob(value: TJavaArray<Byte>; row: Integer; column: Integer): Boolean; cdecl;
    function putDouble(value: Double; row: Integer; column: Integer): Boolean; cdecl;
    function putLong(value: Int64; row: Integer; column: Integer): Boolean; cdecl;
    function putNull(row: Integer; column: Integer): Boolean; cdecl;
    function putString(value: JString; row: Integer; column: Integer): Boolean; cdecl;
    function setNumColumns(columnNum: Integer): Boolean; cdecl;
    procedure setStartPosition(pos: Integer); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCursorWindow = class(TJavaGenericImport<JCursorWindowClass, JCursorWindow>) end;

  JDataSetObserverClass = interface(JObjectClass)
    ['{C7C6316A-CC0A-4A2A-A099-107A93295C97}']
    {class} function init: JDataSetObserver; cdecl;
  end;

  [JavaSignature('android/database/DataSetObserver')]
  JDataSetObserver = interface(JObject)
    ['{B204ED4E-691F-440A-9484-9AFCE74EEF86}']
    procedure onChanged; cdecl;
    procedure onInvalidated; cdecl;
  end;
  TJDataSetObserver = class(TJavaGenericImport<JDataSetObserverClass, JDataSetObserver>) end;

  JDatabaseErrorHandlerClass = interface(IJavaClass)
    ['{D41A8571-A0DA-4DEA-A665-9F1F7404A17B}']
  end;

  [JavaSignature('android/database/DatabaseErrorHandler')]
  JDatabaseErrorHandler = interface(IJavaInstance)
    ['{A31F3725-966F-4228-B86A-C8B8A876E3C8}']
    procedure onCorruption(dbObj: JSQLiteDatabase); cdecl;
  end;
  TJDatabaseErrorHandler = class(TJavaGenericImport<JDatabaseErrorHandlerClass, JDatabaseErrorHandler>) end;

  JSQLiteCursorDriverClass = interface(IJavaClass)
    ['{2D28FDEF-35BB-4B78-87FB-8AAFF86DC43B}']
  end;

  [JavaSignature('android/database/sqlite/SQLiteCursorDriver')]
  JSQLiteCursorDriver = interface(IJavaInstance)
    ['{6714A968-83B7-41C7-9657-56ADF0D05F07}']
    procedure cursorClosed; cdecl;
    procedure cursorDeactivated; cdecl;
    procedure cursorRequeried(cursor: JCursor); cdecl;
    function query(factory: JSQLiteDatabase_CursorFactory; bindArgs: TJavaObjectArray<JString>): JCursor; cdecl;
    procedure setBindArguments(bindArgs: TJavaObjectArray<JString>); cdecl;
  end;
  TJSQLiteCursorDriver = class(TJavaGenericImport<JSQLiteCursorDriverClass, JSQLiteCursorDriver>) end;

  JSQLiteDatabaseClass = interface(JSQLiteClosableClass)
    ['{1AF1FB6C-87F2-4815-B50E-BB3838935F27}']
    {class} function _GetCONFLICT_ABORT: Integer; cdecl;
    {class} function _GetCONFLICT_FAIL: Integer; cdecl;
    {class} function _GetCONFLICT_IGNORE: Integer; cdecl;
    {class} function _GetCONFLICT_NONE: Integer; cdecl;
    {class} function _GetCONFLICT_REPLACE: Integer; cdecl;
    {class} function _GetCONFLICT_ROLLBACK: Integer; cdecl;
    {class} function _GetCREATE_IF_NECESSARY: Integer; cdecl;
    {class} function _GetENABLE_WRITE_AHEAD_LOGGING: Integer; cdecl;
    {class} function _GetMAX_SQL_CACHE_SIZE: Integer; cdecl;
    {class} function _GetNO_LOCALIZED_COLLATORS: Integer; cdecl;
    {class} function _GetOPEN_READONLY: Integer; cdecl;
    {class} function _GetOPEN_READWRITE: Integer; cdecl;
    {class} function _GetSQLITE_MAX_LIKE_PATTERN_LENGTH: Integer; cdecl;
    {class} function create(factory: JSQLiteDatabase_CursorFactory): JSQLiteDatabase; cdecl;
    {class} function deleteDatabase(file_: JFile): Boolean; cdecl;
    {class} function findEditTable(tables: JString): JString; cdecl;
    {class} function openDatabase(path: JString; factory: JSQLiteDatabase_CursorFactory; flags: Integer): JSQLiteDatabase; cdecl; overload;
    {class} function openDatabase(path: JString; factory: JSQLiteDatabase_CursorFactory; flags: Integer; errorHandler: JDatabaseErrorHandler): JSQLiteDatabase; cdecl; overload;
    {class} function openOrCreateDatabase(file_: JFile; factory: JSQLiteDatabase_CursorFactory): JSQLiteDatabase; cdecl; overload;
    {class} function openOrCreateDatabase(path: JString; factory: JSQLiteDatabase_CursorFactory): JSQLiteDatabase; cdecl; overload;
    {class} function openOrCreateDatabase(path: JString; factory: JSQLiteDatabase_CursorFactory; errorHandler: JDatabaseErrorHandler): JSQLiteDatabase; cdecl; overload;
    {class} function releaseMemory: Integer; cdecl;
    {class} property CONFLICT_ABORT: Integer read _GetCONFLICT_ABORT;
    {class} property CONFLICT_FAIL: Integer read _GetCONFLICT_FAIL;
    {class} property CONFLICT_IGNORE: Integer read _GetCONFLICT_IGNORE;
    {class} property CONFLICT_NONE: Integer read _GetCONFLICT_NONE;
    {class} property CONFLICT_REPLACE: Integer read _GetCONFLICT_REPLACE;
    {class} property CONFLICT_ROLLBACK: Integer read _GetCONFLICT_ROLLBACK;
    {class} property CREATE_IF_NECESSARY: Integer read _GetCREATE_IF_NECESSARY;
    {class} property ENABLE_WRITE_AHEAD_LOGGING: Integer read _GetENABLE_WRITE_AHEAD_LOGGING;
    {class} property MAX_SQL_CACHE_SIZE: Integer read _GetMAX_SQL_CACHE_SIZE;
    {class} property NO_LOCALIZED_COLLATORS: Integer read _GetNO_LOCALIZED_COLLATORS;
    {class} property OPEN_READONLY: Integer read _GetOPEN_READONLY;
    {class} property OPEN_READWRITE: Integer read _GetOPEN_READWRITE;
    {class} property SQLITE_MAX_LIKE_PATTERN_LENGTH: Integer read _GetSQLITE_MAX_LIKE_PATTERN_LENGTH;
  end;

  [JavaSignature('android/database/sqlite/SQLiteDatabase')]
  JSQLiteDatabase = interface(JSQLiteClosable)
    ['{4721F6D4-E806-4FBB-B2F1-90375EDE6787}']
    procedure beginTransaction; cdecl;
    procedure beginTransactionNonExclusive; cdecl;
    procedure beginTransactionWithListener(transactionListener: JSQLiteTransactionListener); cdecl;
    procedure beginTransactionWithListenerNonExclusive(transactionListener: JSQLiteTransactionListener); cdecl;
    function compileStatement(sql: JString): JSQLiteStatement; cdecl;
    function delete(table: JString; whereClause: JString; whereArgs: TJavaObjectArray<JString>): Integer; cdecl;
    procedure disableWriteAheadLogging; cdecl;
    function enableWriteAheadLogging: Boolean; cdecl;
    procedure endTransaction; cdecl;
    procedure execSQL(sql: JString); cdecl; overload;
    procedure execSQL(sql: JString; bindArgs: TJavaObjectArray<JObject>); cdecl; overload;
    function getAttachedDbs: JList; cdecl;
    function getMaximumSize: Int64; cdecl;
    function getPageSize: Int64; cdecl;
    function getPath: JString; cdecl;
    function getSyncedTables: JMap; cdecl;//Deprecated
    function getVersion: Integer; cdecl;
    function inTransaction: Boolean; cdecl;
    function insert(table: JString; nullColumnHack: JString; values: JContentValues): Int64; cdecl;
    function insertOrThrow(table: JString; nullColumnHack: JString; values: JContentValues): Int64; cdecl;
    function insertWithOnConflict(table: JString; nullColumnHack: JString; initialValues: JContentValues; conflictAlgorithm: Integer): Int64; cdecl;
    function isDatabaseIntegrityOk: Boolean; cdecl;
    function isDbLockedByCurrentThread: Boolean; cdecl;
    function isDbLockedByOtherThreads: Boolean; cdecl;//Deprecated
    function isOpen: Boolean; cdecl;
    function isReadOnly: Boolean; cdecl;
    function isWriteAheadLoggingEnabled: Boolean; cdecl;
    procedure markTableSyncable(table: JString; deletedTable: JString); cdecl; overload;//Deprecated
    procedure markTableSyncable(table: JString; foreignKey: JString; updateTable: JString); cdecl; overload;//Deprecated
    function needUpgrade(newVersion: Integer): Boolean; cdecl;
    function query(distinct: Boolean; table: JString; columns: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; groupBy: JString; having: JString; orderBy: JString; limit: JString): JCursor; cdecl; overload;
    function query(distinct: Boolean; table: JString; columns: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; groupBy: JString; having: JString; orderBy: JString; limit: JString; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    function query(table: JString; columns: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; groupBy: JString; having: JString; orderBy: JString): JCursor; cdecl; overload;
    function query(table: JString; columns: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; groupBy: JString; having: JString; orderBy: JString; limit: JString): JCursor; cdecl; overload;
    function queryWithFactory(cursorFactory: JSQLiteDatabase_CursorFactory; distinct: Boolean; table: JString; columns: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; groupBy: JString; having: JString; orderBy: JString; limit: JString): JCursor; cdecl; overload;
    function queryWithFactory(cursorFactory: JSQLiteDatabase_CursorFactory; distinct: Boolean; table: JString; columns: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; groupBy: JString; having: JString; orderBy: JString; limit: JString; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    function rawQuery(sql: JString; selectionArgs: TJavaObjectArray<JString>): JCursor; cdecl; overload;
    function rawQuery(sql: JString; selectionArgs: TJavaObjectArray<JString>; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    function rawQueryWithFactory(cursorFactory: JSQLiteDatabase_CursorFactory; sql: JString; selectionArgs: TJavaObjectArray<JString>; editTable: JString): JCursor; cdecl; overload;
    function rawQueryWithFactory(cursorFactory: JSQLiteDatabase_CursorFactory; sql: JString; selectionArgs: TJavaObjectArray<JString>; editTable: JString; cancellationSignal: JCancellationSignal): JCursor; cdecl; overload;
    function replace(table: JString; nullColumnHack: JString; initialValues: JContentValues): Int64; cdecl;
    function replaceOrThrow(table: JString; nullColumnHack: JString; initialValues: JContentValues): Int64; cdecl;
    procedure setForeignKeyConstraintsEnabled(enable: Boolean); cdecl;
    procedure setLocale(locale: JLocale); cdecl;
    procedure setLockingEnabled(lockingEnabled: Boolean); cdecl;//Deprecated
    procedure setMaxSqlCacheSize(cacheSize: Integer); cdecl;
    function setMaximumSize(numBytes: Int64): Int64; cdecl;
    procedure setPageSize(numBytes: Int64); cdecl;
    procedure setTransactionSuccessful; cdecl;
    procedure setVersion(version: Integer); cdecl;
    function toString: JString; cdecl;
    function update(table: JString; values: JContentValues; whereClause: JString; whereArgs: TJavaObjectArray<JString>): Integer; cdecl;
    function updateWithOnConflict(table: JString; values: JContentValues; whereClause: JString; whereArgs: TJavaObjectArray<JString>; conflictAlgorithm: Integer): Integer; cdecl;
    function yieldIfContended: Boolean; cdecl;//Deprecated
    function yieldIfContendedSafely: Boolean; cdecl; overload;
    function yieldIfContendedSafely(sleepAfterYieldDelay: Int64): Boolean; cdecl; overload;
  end;
  TJSQLiteDatabase = class(TJavaGenericImport<JSQLiteDatabaseClass, JSQLiteDatabase>) end;

  JSQLiteDatabase_CursorFactoryClass = interface(IJavaClass)
    ['{A427AD75-87E1-4F79-8EC8-C024197EE16F}']
  end;

  [JavaSignature('android/database/sqlite/SQLiteDatabase$CursorFactory')]
  JSQLiteDatabase_CursorFactory = interface(IJavaInstance)
    ['{22266733-082B-4989-8DFF-A4AD8FDA17E2}']
    function newCursor(db: JSQLiteDatabase; masterQuery: JSQLiteCursorDriver; editTable: JString; query: JSQLiteQuery): JCursor; cdecl;
  end;
  TJSQLiteDatabase_CursorFactory = class(TJavaGenericImport<JSQLiteDatabase_CursorFactoryClass, JSQLiteDatabase_CursorFactory>) end;

  JSQLiteProgramClass = interface(JSQLiteClosableClass)
    ['{1CAB352F-57F3-487F-9089-5E038EE18DE8}']
  end;

  [JavaSignature('android/database/sqlite/SQLiteProgram')]
  JSQLiteProgram = interface(JSQLiteClosable)
    ['{0C26AE0C-8368-437A-A879-44DF499D9AD6}']
    procedure bindAllArgsAsStrings(bindArgs: TJavaObjectArray<JString>); cdecl;
    procedure bindBlob(index: Integer; value: TJavaArray<Byte>); cdecl;
    procedure bindDouble(index: Integer; value: Double); cdecl;
    procedure bindLong(index: Integer; value: Int64); cdecl;
    procedure bindNull(index: Integer); cdecl;
    procedure bindString(index: Integer; value: JString); cdecl;
    procedure clearBindings; cdecl;
    function getUniqueId: Integer; cdecl;//Deprecated
  end;
  TJSQLiteProgram = class(TJavaGenericImport<JSQLiteProgramClass, JSQLiteProgram>) end;

  JSQLiteQueryClass = interface(JSQLiteProgramClass)
    ['{54EA3C25-1BC0-4806-8627-66E2B2FACDBE}']
  end;

  [JavaSignature('android/database/sqlite/SQLiteQuery')]
  JSQLiteQuery = interface(JSQLiteProgram)
    ['{0ACE7FC4-DD34-43FE-AF15-498D050DD215}']
    function toString: JString; cdecl;
  end;
  TJSQLiteQuery = class(TJavaGenericImport<JSQLiteQueryClass, JSQLiteQuery>) end;

  JSQLiteStatementClass = interface(JSQLiteProgramClass)
    ['{D290B8D2-21A6-4B7F-A552-A8816B323BAD}']
  end;

  [JavaSignature('android/database/sqlite/SQLiteStatement')]
  JSQLiteStatement = interface(JSQLiteProgram)
    ['{AB3828A0-8DEB-40AD-AE35-EEEFAA60A96B}']
    procedure execute; cdecl;
    function executeInsert: Int64; cdecl;
    function executeUpdateDelete: Integer; cdecl;
    function simpleQueryForBlobFileDescriptor: JParcelFileDescriptor; cdecl;
    function simpleQueryForLong: Int64; cdecl;
    function simpleQueryForString: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJSQLiteStatement = class(TJavaGenericImport<JSQLiteStatementClass, JSQLiteStatement>) end;

  JSQLiteTransactionListenerClass = interface(IJavaClass)
    ['{7B2DA9F0-CA67-454A-92FE-2424DC354414}']
  end;

  [JavaSignature('android/database/sqlite/SQLiteTransactionListener')]
  JSQLiteTransactionListener = interface(IJavaInstance)
    ['{C05E63B7-B5F5-4A6D-8EC1-09973B9CF1A2}']
    procedure onBegin; cdecl;
    procedure onCommit; cdecl;
    procedure onRollback; cdecl;
  end;
  TJSQLiteTransactionListener = class(TJavaGenericImport<JSQLiteTransactionListenerClass, JSQLiteTransactionListener>) end;

  JXfermodeClass = interface(JObjectClass)
    ['{A02A0774-5EEB-461D-9A5A-DE7A410045C1}']
    {class} function init: JXfermode; cdecl;
  end;

  [JavaSignature('android/graphics/Xfermode')]
  JXfermode = interface(JObject)
    ['{2A25D3BB-02D9-4E64-A984-8C3A238DE91B}']
  end;
  TJXfermode = class(TJavaGenericImport<JXfermodeClass, JXfermode>) end;

  JAvoidXfermodeClass = interface(JXfermodeClass)
    ['{59AC62D5-C559-4E2C-A26F-A2AA917DF0AD}']
    {class} function init(opColor: Integer; tolerance: Integer; mode: JAvoidXfermode_Mode): JAvoidXfermode; cdecl;
  end;

  [JavaSignature('android/graphics/AvoidXfermode')]
  JAvoidXfermode = interface(JXfermode)
    ['{A7830284-D6BD-4070-8249-B01D1E29F34D}']
  end;
  TJAvoidXfermode = class(TJavaGenericImport<JAvoidXfermodeClass, JAvoidXfermode>) end;

  JAvoidXfermode_ModeClass = interface(JEnumClass)
    ['{D2330AA6-4011-4DC7-9DEC-9FF8E661EF67}']
    {class} function _GetAVOID: JAvoidXfermode_Mode; cdecl;
    {class} function _GetTARGET: JAvoidXfermode_Mode; cdecl;
    {class} function valueOf(name: JString): JAvoidXfermode_Mode; cdecl;
    {class} function values: TJavaObjectArray<JAvoidXfermode_Mode>; cdecl;
    {class} property AVOID: JAvoidXfermode_Mode read _GetAVOID;
    {class} property TARGET: JAvoidXfermode_Mode read _GetTARGET;
  end;

  [JavaSignature('android/graphics/AvoidXfermode$Mode')]
  JAvoidXfermode_Mode = interface(JEnum)
    ['{555505F5-1421-4ECE-9AAB-BBB62E629B38}']
  end;
  TJAvoidXfermode_Mode = class(TJavaGenericImport<JAvoidXfermode_ModeClass, JAvoidXfermode_Mode>) end;

  JBitmapClass = interface(JObjectClass)
    ['{297AF779-3A6F-4030-A8FB-1E91DEF2C89F}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDENSITY_NONE: Integer; cdecl;
    {class} function createBitmap(src: JBitmap): JBitmap; cdecl; overload;
    {class} function createBitmap(source: JBitmap; x: Integer; y: Integer; width: Integer; height: Integer): JBitmap; cdecl; overload;
    {class} function createBitmap(source: JBitmap; x: Integer; y: Integer; width: Integer; height: Integer; m: JMatrix; filter: Boolean): JBitmap; cdecl; overload;
    {class} function createBitmap(width: Integer; height: Integer; config: JBitmap_Config): JBitmap; cdecl; overload;
    {class} function createBitmap(display: JDisplayMetrics; width: Integer; height: Integer; config: JBitmap_Config): JBitmap; cdecl; overload;
    {class} function createBitmap(colors: TJavaArray<Integer>; offset: Integer; stride: Integer; width: Integer; height: Integer; config: JBitmap_Config): JBitmap; cdecl; overload;
    {class} function createBitmap(display: JDisplayMetrics; colors: TJavaArray<Integer>; offset: Integer; stride: Integer; width: Integer; height: Integer; config: JBitmap_Config): JBitmap; cdecl; overload;
    {class} function createBitmap(colors: TJavaArray<Integer>; width: Integer; height: Integer; config: JBitmap_Config): JBitmap; cdecl; overload;
    {class} function createBitmap(display: JDisplayMetrics; colors: TJavaArray<Integer>; width: Integer; height: Integer; config: JBitmap_Config): JBitmap; cdecl; overload;
    {class} function createScaledBitmap(src: JBitmap; dstWidth: Integer; dstHeight: Integer; filter: Boolean): JBitmap; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DENSITY_NONE: Integer read _GetDENSITY_NONE;
  end;

  [JavaSignature('android/graphics/Bitmap')]
  JBitmap = interface(JObject)
    ['{D248EC72-F7F9-4F71-BBDC-0940D8BAD29E}']
    function compress(format: JBitmap_CompressFormat; quality: Integer; stream: JOutputStream): Boolean; cdecl;
    function copy(config: JBitmap_Config; isMutable: Boolean): JBitmap; cdecl;
    procedure copyPixelsFromBuffer(src: JBuffer); cdecl;
    procedure copyPixelsToBuffer(dst: JBuffer); cdecl;
    function describeContents: Integer; cdecl;
    procedure eraseColor(c: Integer); cdecl;
    function extractAlpha: JBitmap; cdecl; overload;
    function extractAlpha(paint: JPaint; offsetXY: TJavaArray<Integer>): JBitmap; cdecl; overload;
    function getAllocationByteCount: Integer; cdecl;
    function getByteCount: Integer; cdecl;
    function getConfig: JBitmap_Config; cdecl;
    function getDensity: Integer; cdecl;
    function getGenerationId: Integer; cdecl;
    function getHeight: Integer; cdecl;
    function getNinePatchChunk: TJavaArray<Byte>; cdecl;
    function getPixel(x: Integer; y: Integer): Integer; cdecl;
    procedure getPixels(pixels: TJavaArray<Integer>; offset: Integer; stride: Integer; x: Integer; y: Integer; width: Integer; height: Integer); cdecl;
    function getRowBytes: Integer; cdecl;
    function getScaledHeight(canvas: JCanvas): Integer; cdecl; overload;
    function getScaledHeight(metrics: JDisplayMetrics): Integer; cdecl; overload;
    function getScaledHeight(targetDensity: Integer): Integer; cdecl; overload;
    function getScaledWidth(canvas: JCanvas): Integer; cdecl; overload;
    function getScaledWidth(metrics: JDisplayMetrics): Integer; cdecl; overload;
    function getScaledWidth(targetDensity: Integer): Integer; cdecl; overload;
    function getWidth: Integer; cdecl;
    function hasAlpha: Boolean; cdecl;
    function hasMipMap: Boolean; cdecl;
    function isMutable: Boolean; cdecl;
    function isPremultiplied: Boolean; cdecl;
    function isRecycled: Boolean; cdecl;
    procedure prepareToDraw; cdecl;
    procedure reconfigure(width: Integer; height: Integer; config: JBitmap_Config); cdecl;
    procedure recycle; cdecl;
    function sameAs(other: JBitmap): Boolean; cdecl;
    procedure setConfig(config: JBitmap_Config); cdecl;
    procedure setDensity(density: Integer); cdecl;
    procedure setHasAlpha(hasAlpha: Boolean); cdecl;
    procedure setHasMipMap(hasMipMap: Boolean); cdecl;
    procedure setHeight(height: Integer); cdecl;
    procedure setPixel(x: Integer; y: Integer; color: Integer); cdecl;
    procedure setPixels(pixels: TJavaArray<Integer>; offset: Integer; stride: Integer; x: Integer; y: Integer; width: Integer; height: Integer); cdecl;
    procedure setPremultiplied(premultiplied: Boolean); cdecl;
    procedure setWidth(width: Integer); cdecl;
    procedure writeToParcel(p: JParcel; flags: Integer); cdecl;
  end;
  TJBitmap = class(TJavaGenericImport<JBitmapClass, JBitmap>) end;

  JBitmap_CompressFormatClass = interface(JEnumClass)
    ['{6F46CFB7-31A8-480F-9D88-958A1E1B9FF3}']
    {class} function _GetJPEG: JBitmap_CompressFormat; cdecl;
    {class} function _GetPNG: JBitmap_CompressFormat; cdecl;
    {class} function _GetWEBP: JBitmap_CompressFormat; cdecl;
    {class} function valueOf(name: JString): JBitmap_CompressFormat; cdecl;
    {class} function values: TJavaObjectArray<JBitmap_CompressFormat>; cdecl;
    {class} property JPEG: JBitmap_CompressFormat read _GetJPEG;
    {class} property PNG: JBitmap_CompressFormat read _GetPNG;
    {class} property WEBP: JBitmap_CompressFormat read _GetWEBP;
  end;

  [JavaSignature('android/graphics/Bitmap$CompressFormat')]
  JBitmap_CompressFormat = interface(JEnum)
    ['{80D19EC8-AA8B-47D4-BF4A-05E5DC4C5E09}']
  end;
  TJBitmap_CompressFormat = class(TJavaGenericImport<JBitmap_CompressFormatClass, JBitmap_CompressFormat>) end;

  JBitmap_ConfigClass = interface(JEnumClass)
    ['{B0485749-2E7B-4025-AC8A-536956C4AB63}']
    {class} function _GetALPHA_8: JBitmap_Config; cdecl;
    {class} function _GetARGB_4444: JBitmap_Config; cdecl;
    {class} function _GetARGB_8888: JBitmap_Config; cdecl;
    {class} function _GetRGB_565: JBitmap_Config; cdecl;
    {class} function valueOf(name: JString): JBitmap_Config; cdecl;
    {class} function values: TJavaObjectArray<JBitmap_Config>; cdecl;
    {class} property ALPHA_8: JBitmap_Config read _GetALPHA_8;
    {class} property ARGB_4444: JBitmap_Config read _GetARGB_4444;
    {class} property ARGB_8888: JBitmap_Config read _GetARGB_8888;
    {class} property RGB_565: JBitmap_Config read _GetRGB_565;
  end;

  [JavaSignature('android/graphics/Bitmap$Config')]
  JBitmap_Config = interface(JEnum)
    ['{85490287-B946-4DB1-A23C-FA190B2DBDDD}']
  end;
  TJBitmap_Config = class(TJavaGenericImport<JBitmap_ConfigClass, JBitmap_Config>) end;

  JBitmapFactoryClass = interface(JObjectClass)
    ['{B036E322-D1D6-43F7-A4D6-2C8C0BEFCDA6}']
    {class} function init: JBitmapFactory; cdecl;
    {class} function decodeByteArray(data: TJavaArray<Byte>; offset: Integer; length: Integer; opts: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function decodeByteArray(data: TJavaArray<Byte>; offset: Integer; length: Integer): JBitmap; cdecl; overload;
    {class} function decodeFile(pathName: JString; opts: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function decodeFile(pathName: JString): JBitmap; cdecl; overload;
    {class} function decodeFileDescriptor(fd: JFileDescriptor; outPadding: JRect; opts: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function decodeFileDescriptor(fd: JFileDescriptor): JBitmap; cdecl; overload;
    {class} function decodeResource(res: JResources; id: Integer; opts: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function decodeResource(res: JResources; id: Integer): JBitmap; cdecl; overload;
    {class} function decodeResourceStream(res: JResources; value: JTypedValue; is_: JInputStream; pad: JRect; opts: JBitmapFactory_Options): JBitmap; cdecl;
    {class} function decodeStream(is_: JInputStream; outPadding: JRect; opts: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function decodeStream(is_: JInputStream): JBitmap; cdecl; overload;
  end;

  [JavaSignature('android/graphics/BitmapFactory')]
  JBitmapFactory = interface(JObject)
    ['{7D95177F-7BBF-4FBE-BDAF-2DAC213B6591}']
  end;
  TJBitmapFactory = class(TJavaGenericImport<JBitmapFactoryClass, JBitmapFactory>) end;

  JBitmapFactory_OptionsClass = interface(JObjectClass)
    ['{15B209CE-4C2A-4351-8426-8E962B81C428}']
    {class} function init: JBitmapFactory_Options; cdecl;
  end;

  [JavaSignature('android/graphics/BitmapFactory$Options')]
  JBitmapFactory_Options = interface(JObject)
    ['{F255C336-DE61-4A4A-91E6-206BEBE1F9DB}']
    function _GetinBitmap: JBitmap; cdecl;
    procedure _SetinBitmap(Value: JBitmap); cdecl;
    function _GetinDensity: Integer; cdecl;
    procedure _SetinDensity(Value: Integer); cdecl;
    function _GetinDither: Boolean; cdecl;
    procedure _SetinDither(Value: Boolean); cdecl;
    function _GetinInputShareable: Boolean; cdecl;
    procedure _SetinInputShareable(Value: Boolean); cdecl;
    function _GetinJustDecodeBounds: Boolean; cdecl;
    procedure _SetinJustDecodeBounds(Value: Boolean); cdecl;
    function _GetinMutable: Boolean; cdecl;
    procedure _SetinMutable(Value: Boolean); cdecl;
    function _GetinPreferQualityOverSpeed: Boolean; cdecl;
    procedure _SetinPreferQualityOverSpeed(Value: Boolean); cdecl;
    function _GetinPreferredConfig: JBitmap_Config; cdecl;
    procedure _SetinPreferredConfig(Value: JBitmap_Config); cdecl;
    function _GetinPremultiplied: Boolean; cdecl;
    procedure _SetinPremultiplied(Value: Boolean); cdecl;
    function _GetinPurgeable: Boolean; cdecl;
    procedure _SetinPurgeable(Value: Boolean); cdecl;
    function _GetinSampleSize: Integer; cdecl;
    procedure _SetinSampleSize(Value: Integer); cdecl;
    function _GetinScaled: Boolean; cdecl;
    procedure _SetinScaled(Value: Boolean); cdecl;
    function _GetinScreenDensity: Integer; cdecl;
    procedure _SetinScreenDensity(Value: Integer); cdecl;
    function _GetinTargetDensity: Integer; cdecl;
    procedure _SetinTargetDensity(Value: Integer); cdecl;
    function _GetinTempStorage: TJavaArray<Byte>; cdecl;
    procedure _SetinTempStorage(Value: TJavaArray<Byte>); cdecl;
    function _GetmCancel: Boolean; cdecl;
    procedure _SetmCancel(Value: Boolean); cdecl;
    function _GetoutHeight: Integer; cdecl;
    procedure _SetoutHeight(Value: Integer); cdecl;
    function _GetoutMimeType: JString; cdecl;
    procedure _SetoutMimeType(Value: JString); cdecl;
    function _GetoutWidth: Integer; cdecl;
    procedure _SetoutWidth(Value: Integer); cdecl;
    procedure requestCancelDecode; cdecl;
    property inBitmap: JBitmap read _GetinBitmap write _SetinBitmap;
    property inDensity: Integer read _GetinDensity write _SetinDensity;
    property inDither: Boolean read _GetinDither write _SetinDither;
    property inInputShareable: Boolean read _GetinInputShareable write _SetinInputShareable;
    property inJustDecodeBounds: Boolean read _GetinJustDecodeBounds write _SetinJustDecodeBounds;
    property inMutable: Boolean read _GetinMutable write _SetinMutable;
    property inPreferQualityOverSpeed: Boolean read _GetinPreferQualityOverSpeed write _SetinPreferQualityOverSpeed;
    property inPreferredConfig: JBitmap_Config read _GetinPreferredConfig write _SetinPreferredConfig;
    property inPremultiplied: Boolean read _GetinPremultiplied write _SetinPremultiplied;
    property inPurgeable: Boolean read _GetinPurgeable write _SetinPurgeable;
    property inSampleSize: Integer read _GetinSampleSize write _SetinSampleSize;
    property inScaled: Boolean read _GetinScaled write _SetinScaled;
    property inScreenDensity: Integer read _GetinScreenDensity write _SetinScreenDensity;
    property inTargetDensity: Integer read _GetinTargetDensity write _SetinTargetDensity;
    property inTempStorage: TJavaArray<Byte> read _GetinTempStorage write _SetinTempStorage;
    property mCancel: Boolean read _GetmCancel write _SetmCancel;
    property outHeight: Integer read _GetoutHeight write _SetoutHeight;
    property outMimeType: JString read _GetoutMimeType write _SetoutMimeType;
    property outWidth: Integer read _GetoutWidth write _SetoutWidth;
  end;
  TJBitmapFactory_Options = class(TJavaGenericImport<JBitmapFactory_OptionsClass, JBitmapFactory_Options>) end;

  JBitmapRegionDecoderClass = interface(JObjectClass)
    ['{793D0C30-0517-43A8-9749-A93D4ABD7D68}']
    {class} function newInstance(data: TJavaArray<Byte>; offset: Integer; length: Integer; isShareable: Boolean): JBitmapRegionDecoder; cdecl; overload;
    {class} function newInstance(fd: JFileDescriptor; isShareable: Boolean): JBitmapRegionDecoder; cdecl; overload;
    {class} function newInstance(is_: JInputStream; isShareable: Boolean): JBitmapRegionDecoder; cdecl; overload;
    {class} function newInstance(pathName: JString; isShareable: Boolean): JBitmapRegionDecoder; cdecl; overload;
  end;

  [JavaSignature('android/graphics/BitmapRegionDecoder')]
  JBitmapRegionDecoder = interface(JObject)
    ['{C087A6D8-CD30-4D90-9917-5D1D3BE0F9CB}']
    function decodeRegion(rect: JRect; options: JBitmapFactory_Options): JBitmap; cdecl;
    function getHeight: Integer; cdecl;
    function getWidth: Integer; cdecl;
    function isRecycled: Boolean; cdecl;
    procedure recycle; cdecl;
  end;
  TJBitmapRegionDecoder = class(TJavaGenericImport<JBitmapRegionDecoderClass, JBitmapRegionDecoder>) end;

  JShaderClass = interface(JObjectClass)
    ['{E09DAEDF-1831-4180-AD13-6B01F559396E}']
    {class} function init: JShader; cdecl;
  end;

  [JavaSignature('android/graphics/Shader')]
  JShader = interface(JObject)
    ['{300E27ED-093C-4CB5-B18D-C0CEFB899BA5}']
    function getLocalMatrix(localM: JMatrix): Boolean; cdecl;
    procedure setLocalMatrix(localM: JMatrix); cdecl;
  end;
  TJShader = class(TJavaGenericImport<JShaderClass, JShader>) end;

  JBitmapShaderClass = interface(JShaderClass)
    ['{6465A729-9A1A-4295-8CB5-745656392F46}']
    {class} function init(bitmap: JBitmap; tileX: JShader_TileMode; tileY: JShader_TileMode): JBitmapShader; cdecl;
  end;

  [JavaSignature('android/graphics/BitmapShader')]
  JBitmapShader = interface(JShader)
    ['{E4461B90-31BB-4C74-A418-AB0D73850721}']
  end;
  TJBitmapShader = class(TJavaGenericImport<JBitmapShaderClass, JBitmapShader>) end;

  JMaskFilterClass = interface(JObjectClass)
    ['{47DA8E8A-21AC-4DAC-86A8-8908EC5560F9}']
    {class} function init: JMaskFilter; cdecl;
  end;

  [JavaSignature('android/graphics/MaskFilter')]
  JMaskFilter = interface(JObject)
    ['{6DA8DB66-410C-461F-A0D8-BE2D76E78873}']
  end;
  TJMaskFilter = class(TJavaGenericImport<JMaskFilterClass, JMaskFilter>) end;

  JBlurMaskFilterClass = interface(JMaskFilterClass)
    ['{59DC22CE-33D8-4E04-BC54-57C1593511B6}']
    {class} function init(radius: Single; style: JBlurMaskFilter_Blur): JBlurMaskFilter; cdecl;
  end;

  [JavaSignature('android/graphics/BlurMaskFilter')]
  JBlurMaskFilter = interface(JMaskFilter)
    ['{7023099B-9AA8-44C0-879A-28591CC9DF27}']
  end;
  TJBlurMaskFilter = class(TJavaGenericImport<JBlurMaskFilterClass, JBlurMaskFilter>) end;

  JBlurMaskFilter_BlurClass = interface(JEnumClass)
    ['{827ABCE6-A489-4242-A315-4FE5AC73C6B4}']
    {class} function _GetINNER: JBlurMaskFilter_Blur; cdecl;
    {class} function _GetNORMAL: JBlurMaskFilter_Blur; cdecl;
    {class} function _GetOUTER: JBlurMaskFilter_Blur; cdecl;
    {class} function _GetSOLID: JBlurMaskFilter_Blur; cdecl;
    {class} function valueOf(name: JString): JBlurMaskFilter_Blur; cdecl;
    {class} function values: TJavaObjectArray<JBlurMaskFilter_Blur>; cdecl;
    {class} property INNER: JBlurMaskFilter_Blur read _GetINNER;
    {class} property NORMAL: JBlurMaskFilter_Blur read _GetNORMAL;
    {class} property OUTER: JBlurMaskFilter_Blur read _GetOUTER;
    {class} property SOLID: JBlurMaskFilter_Blur read _GetSOLID;
  end;

  [JavaSignature('android/graphics/BlurMaskFilter$Blur')]
  JBlurMaskFilter_Blur = interface(JEnum)
    ['{4A2F89C6-8703-4ECA-B6C3-298F40355435}']
  end;
  TJBlurMaskFilter_Blur = class(TJavaGenericImport<JBlurMaskFilter_BlurClass, JBlurMaskFilter_Blur>) end;

  Jgraphics_CameraClass = interface(JObjectClass)
    ['{D3090283-790D-410F-8BE9-C3AD79AED7FD}']
    {class} function init: Jgraphics_Camera; cdecl;
  end;

  [JavaSignature('android/graphics/Camera')]
  Jgraphics_Camera = interface(JObject)
    ['{C1A83D60-8064-4A14-9854-B70174E37610}']
    procedure applyToCanvas(canvas: JCanvas); cdecl;
    function dotWithNormal(dx: Single; dy: Single; dz: Single): Single; cdecl;
    function getLocationX: Single; cdecl;
    function getLocationY: Single; cdecl;
    function getLocationZ: Single; cdecl;
    procedure getMatrix(matrix: JMatrix); cdecl;
    procedure restore; cdecl;
    procedure rotate(x: Single; y: Single; z: Single); cdecl;
    procedure rotateX(deg: Single); cdecl;
    procedure rotateY(deg: Single); cdecl;
    procedure rotateZ(deg: Single); cdecl;
    procedure save; cdecl;
    procedure setLocation(x: Single; y: Single; z: Single); cdecl;
    procedure translate(x: Single; y: Single; z: Single); cdecl;
  end;
  TJgraphics_Camera = class(TJavaGenericImport<Jgraphics_CameraClass, Jgraphics_Camera>) end;

  JCanvasClass = interface(JObjectClass)
    ['{5C77F1D0-F7A1-4806-8697-EA2A86F66BC1}']
    {class} function _GetALL_SAVE_FLAG: Integer; cdecl;
    {class} function _GetCLIP_SAVE_FLAG: Integer; cdecl;
    {class} function _GetCLIP_TO_LAYER_SAVE_FLAG: Integer; cdecl;
    {class} function _GetFULL_COLOR_LAYER_SAVE_FLAG: Integer; cdecl;
    {class} function _GetHAS_ALPHA_LAYER_SAVE_FLAG: Integer; cdecl;
    {class} function _GetMATRIX_SAVE_FLAG: Integer; cdecl;
    {class} function init: JCanvas; cdecl; overload;
    {class} function init(bitmap: JBitmap): JCanvas; cdecl; overload;
    {class} property ALL_SAVE_FLAG: Integer read _GetALL_SAVE_FLAG;
    {class} property CLIP_SAVE_FLAG: Integer read _GetCLIP_SAVE_FLAG;
    {class} property CLIP_TO_LAYER_SAVE_FLAG: Integer read _GetCLIP_TO_LAYER_SAVE_FLAG;
    {class} property FULL_COLOR_LAYER_SAVE_FLAG: Integer read _GetFULL_COLOR_LAYER_SAVE_FLAG;
    {class} property HAS_ALPHA_LAYER_SAVE_FLAG: Integer read _GetHAS_ALPHA_LAYER_SAVE_FLAG;
    {class} property MATRIX_SAVE_FLAG: Integer read _GetMATRIX_SAVE_FLAG;
  end;

  [JavaSignature('android/graphics/Canvas')]
  JCanvas = interface(JObject)
    ['{00C36DBF-A6AE-4B19-9DC9-0FD6D71823BB}']
    function clipPath(path: JPath; op: JRegion_Op): Boolean; cdecl; overload;
    function clipPath(path: JPath): Boolean; cdecl; overload;
    function clipRect(rect: JRectF; op: JRegion_Op): Boolean; cdecl; overload;
    function clipRect(rect: JRect; op: JRegion_Op): Boolean; cdecl; overload;
    function clipRect(rect: JRectF): Boolean; cdecl; overload;
    function clipRect(rect: JRect): Boolean; cdecl; overload;
    function clipRect(left: Single; top: Single; right: Single; bottom: Single; op: JRegion_Op): Boolean; cdecl; overload;
    function clipRect(left: Single; top: Single; right: Single; bottom: Single): Boolean; cdecl; overload;
    function clipRect(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    function clipRegion(region: JRegion; op: JRegion_Op): Boolean; cdecl; overload;//Deprecated
    function clipRegion(region: JRegion): Boolean; cdecl; overload;//Deprecated
    procedure concat(matrix: JMatrix); cdecl;
    procedure drawARGB(a: Integer; r: Integer; g: Integer; b: Integer); cdecl;
    procedure drawArc(oval: JRectF; startAngle: Single; sweepAngle: Single; useCenter: Boolean; paint: JPaint); cdecl; overload;
    procedure drawArc(left: Single; top: Single; right: Single; bottom: Single; startAngle: Single; sweepAngle: Single; useCenter: Boolean; paint: JPaint); cdecl; overload;
    procedure drawBitmap(bitmap: JBitmap; left: Single; top: Single; paint: JPaint); cdecl; overload;
    procedure drawBitmap(bitmap: JBitmap; src: JRect; dst: JRectF; paint: JPaint); cdecl; overload;
    procedure drawBitmap(bitmap: JBitmap; src: JRect; dst: JRect; paint: JPaint); cdecl; overload;
    procedure drawBitmap(colors: TJavaArray<Integer>; offset: Integer; stride: Integer; x: Single; y: Single; width: Integer; height: Integer; hasAlpha: Boolean; paint: JPaint); cdecl; overload;//Deprecated
    procedure drawBitmap(colors: TJavaArray<Integer>; offset: Integer; stride: Integer; x: Integer; y: Integer; width: Integer; height: Integer; hasAlpha: Boolean; paint: JPaint); cdecl; overload;//Deprecated
    procedure drawBitmap(bitmap: JBitmap; matrix: JMatrix; paint: JPaint); cdecl; overload;
    procedure drawBitmapMesh(bitmap: JBitmap; meshWidth: Integer; meshHeight: Integer; verts: TJavaArray<Single>; vertOffset: Integer; colors: TJavaArray<Integer>; colorOffset: Integer; paint: JPaint); cdecl;
    procedure drawCircle(cx: Single; cy: Single; radius: Single; paint: JPaint); cdecl;
    procedure drawColor(color: Integer); cdecl; overload;
    procedure drawColor(color: Integer; mode: JPorterDuff_Mode); cdecl; overload;
    procedure drawLine(startX: Single; startY: Single; stopX: Single; stopY: Single; paint: JPaint); cdecl;
    procedure drawLines(pts: TJavaArray<Single>; offset: Integer; count: Integer; paint: JPaint); cdecl; overload;
    procedure drawLines(pts: TJavaArray<Single>; paint: JPaint); cdecl; overload;
    procedure drawOval(oval: JRectF; paint: JPaint); cdecl; overload;
    procedure drawOval(left: Single; top: Single; right: Single; bottom: Single; paint: JPaint); cdecl; overload;
    procedure drawPaint(paint: JPaint); cdecl;
    procedure drawPath(path: JPath; paint: JPaint); cdecl;
    procedure drawPicture(picture: JPicture); cdecl; overload;
    procedure drawPicture(picture: JPicture; dst: JRectF); cdecl; overload;
    procedure drawPicture(picture: JPicture; dst: JRect); cdecl; overload;
    procedure drawPoint(x: Single; y: Single; paint: JPaint); cdecl;
    procedure drawPoints(pts: TJavaArray<Single>; offset: Integer; count: Integer; paint: JPaint); cdecl; overload;
    procedure drawPoints(pts: TJavaArray<Single>; paint: JPaint); cdecl; overload;
    procedure drawPosText(text: TJavaArray<Char>; index: Integer; count: Integer; pos: TJavaArray<Single>; paint: JPaint); cdecl; overload;//Deprecated
    procedure drawPosText(text: JString; pos: TJavaArray<Single>; paint: JPaint); cdecl; overload;//Deprecated
    procedure drawRGB(r: Integer; g: Integer; b: Integer); cdecl;
    procedure drawRect(rect: JRectF; paint: JPaint); cdecl; overload;
    procedure drawRect(r: JRect; paint: JPaint); cdecl; overload;
    procedure drawRect(left: Single; top: Single; right: Single; bottom: Single; paint: JPaint); cdecl; overload;
    procedure drawRoundRect(rect: JRectF; rx: Single; ry: Single; paint: JPaint); cdecl; overload;
    procedure drawRoundRect(left: Single; top: Single; right: Single; bottom: Single; rx: Single; ry: Single; paint: JPaint); cdecl; overload;
    procedure drawText(text: TJavaArray<Char>; index: Integer; count: Integer; x: Single; y: Single; paint: JPaint); cdecl; overload;
    procedure drawText(text: JString; x: Single; y: Single; paint: JPaint); cdecl; overload;
    procedure drawText(text: JString; start: Integer; end_: Integer; x: Single; y: Single; paint: JPaint); cdecl; overload;
    procedure drawText(text: JCharSequence; start: Integer; end_: Integer; x: Single; y: Single; paint: JPaint); cdecl; overload;
    procedure drawTextOnPath(text: TJavaArray<Char>; index: Integer; count: Integer; path: JPath; hOffset: Single; vOffset: Single; paint: JPaint); cdecl; overload;
    procedure drawTextOnPath(text: JString; path: JPath; hOffset: Single; vOffset: Single; paint: JPaint); cdecl; overload;
    procedure drawTextRun(text: TJavaArray<Char>; index: Integer; count: Integer; contextIndex: Integer; contextCount: Integer; x: Single; y: Single; isRtl: Boolean; paint: JPaint); cdecl; overload;
    procedure drawTextRun(text: JCharSequence; start: Integer; end_: Integer; contextStart: Integer; contextEnd: Integer; x: Single; y: Single; isRtl: Boolean; paint: JPaint); cdecl; overload;
    procedure drawVertices(mode: JCanvas_VertexMode; vertexCount: Integer; verts: TJavaArray<Single>; vertOffset: Integer; texs: TJavaArray<Single>; texOffset: Integer; colors: TJavaArray<Integer>; colorOffset: Integer; indices: TJavaArray<SmallInt>; indexOffset: Integer; indexCount: Integer; paint: JPaint); cdecl;
    function getClipBounds(bounds: JRect): Boolean; cdecl; overload;
    function getClipBounds: JRect; cdecl; overload;
    function getDensity: Integer; cdecl;
    function getDrawFilter: JDrawFilter; cdecl;
    function getHeight: Integer; cdecl;
    procedure getMatrix(ctm: JMatrix); cdecl; overload;//Deprecated
    function getMatrix: JMatrix; cdecl; overload;//Deprecated
    function getMaximumBitmapHeight: Integer; cdecl;
    function getMaximumBitmapWidth: Integer; cdecl;
    function getSaveCount: Integer; cdecl;
    function getWidth: Integer; cdecl;
    function isHardwareAccelerated: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function quickReject(rect: JRectF; type_: JCanvas_EdgeType): Boolean; cdecl; overload;
    function quickReject(path: JPath; type_: JCanvas_EdgeType): Boolean; cdecl; overload;
    function quickReject(left: Single; top: Single; right: Single; bottom: Single; type_: JCanvas_EdgeType): Boolean; cdecl; overload;
    procedure restore; cdecl;
    procedure restoreToCount(saveCount: Integer); cdecl;
    procedure rotate(degrees: Single); cdecl; overload;
    procedure rotate(degrees: Single; px: Single; py: Single); cdecl; overload;
    function save: Integer; cdecl; overload;
    function save(saveFlags: Integer): Integer; cdecl; overload;
    function saveLayer(bounds: JRectF; paint: JPaint; saveFlags: Integer): Integer; cdecl; overload;
    function saveLayer(bounds: JRectF; paint: JPaint): Integer; cdecl; overload;
    function saveLayer(left: Single; top: Single; right: Single; bottom: Single; paint: JPaint; saveFlags: Integer): Integer; cdecl; overload;
    function saveLayer(left: Single; top: Single; right: Single; bottom: Single; paint: JPaint): Integer; cdecl; overload;
    function saveLayerAlpha(bounds: JRectF; alpha: Integer; saveFlags: Integer): Integer; cdecl; overload;
    function saveLayerAlpha(bounds: JRectF; alpha: Integer): Integer; cdecl; overload;
    function saveLayerAlpha(left: Single; top: Single; right: Single; bottom: Single; alpha: Integer; saveFlags: Integer): Integer; cdecl; overload;
    function saveLayerAlpha(left: Single; top: Single; right: Single; bottom: Single; alpha: Integer): Integer; cdecl; overload;
    procedure scale(sx: Single; sy: Single); cdecl; overload;
    procedure scale(sx: Single; sy: Single; px: Single; py: Single); cdecl; overload;
    procedure setBitmap(bitmap: JBitmap); cdecl;
    procedure setDensity(density: Integer); cdecl;
    procedure setDrawFilter(filter: JDrawFilter); cdecl;
    procedure setMatrix(matrix: JMatrix); cdecl;
    procedure skew(sx: Single; sy: Single); cdecl;
    procedure translate(dx: Single; dy: Single); cdecl;
  end;
  TJCanvas = class(TJavaGenericImport<JCanvasClass, JCanvas>) end;

  JCanvas_EdgeTypeClass = interface(JEnumClass)
    ['{8D1EEE35-A96F-4AF3-9E0A-4DE303F76689}']
    {class} function _GetAA: JCanvas_EdgeType; cdecl;
    {class} function _GetBW: JCanvas_EdgeType; cdecl;
    {class} function valueOf(name: JString): JCanvas_EdgeType; cdecl;
    {class} function values: TJavaObjectArray<JCanvas_EdgeType>; cdecl;
    {class} property AA: JCanvas_EdgeType read _GetAA;
    {class} property BW: JCanvas_EdgeType read _GetBW;
  end;

  [JavaSignature('android/graphics/Canvas$EdgeType')]
  JCanvas_EdgeType = interface(JEnum)
    ['{8D22D842-F814-49A2-ADA9-4F8F8AD97D80}']
  end;
  TJCanvas_EdgeType = class(TJavaGenericImport<JCanvas_EdgeTypeClass, JCanvas_EdgeType>) end;

  JCanvas_VertexModeClass = interface(JEnumClass)
    ['{15C117F4-B2A0-4040-8817-4D58CC105900}']
    {class} function _GetTRIANGLES: JCanvas_VertexMode; cdecl;
    {class} function _GetTRIANGLE_FAN: JCanvas_VertexMode; cdecl;
    {class} function _GetTRIANGLE_STRIP: JCanvas_VertexMode; cdecl;
    {class} function valueOf(name: JString): JCanvas_VertexMode; cdecl;
    {class} function values: TJavaObjectArray<JCanvas_VertexMode>; cdecl;
    {class} property TRIANGLES: JCanvas_VertexMode read _GetTRIANGLES;
    {class} property TRIANGLE_FAN: JCanvas_VertexMode read _GetTRIANGLE_FAN;
    {class} property TRIANGLE_STRIP: JCanvas_VertexMode read _GetTRIANGLE_STRIP;
  end;

  [JavaSignature('android/graphics/Canvas$VertexMode')]
  JCanvas_VertexMode = interface(JEnum)
    ['{F7B3C1F3-EBC6-4078-AD26-E0BF71251EC4}']
  end;
  TJCanvas_VertexMode = class(TJavaGenericImport<JCanvas_VertexModeClass, JCanvas_VertexMode>) end;

  JCanvasPropertyClass = interface(JObjectClass)
    ['{412EF857-D707-4BB3-BACC-4A5E429AC377}']
    {class} function createFloat(initialValue: Single): JCanvasProperty; cdecl;
    {class} function createPaint(initialValue: JPaint): JCanvasProperty; cdecl;
  end;

  [JavaSignature('android/graphics/CanvasProperty')]
  JCanvasProperty = interface(JObject)
    ['{C8153CE6-BE56-4756-8B5E-24EF2D905061}']
  end;
  TJCanvasProperty = class(TJavaGenericImport<JCanvasPropertyClass, JCanvasProperty>) end;

  JColorClass = interface(JObjectClass)
    ['{4A2B6D4E-E3C4-405A-A41F-40F86D1B72E1}']
    {class} function _GetBLACK: Integer; cdecl;
    {class} function _GetBLUE: Integer; cdecl;
    {class} function _GetCYAN: Integer; cdecl;
    {class} function _GetDKGRAY: Integer; cdecl;
    {class} function _GetGRAY: Integer; cdecl;
    {class} function _GetGREEN: Integer; cdecl;
    {class} function _GetLTGRAY: Integer; cdecl;
    {class} function _GetMAGENTA: Integer; cdecl;
    {class} function _GetRED: Integer; cdecl;
    {class} function _GetTRANSPARENT: Integer; cdecl;
    {class} function _GetWHITE: Integer; cdecl;
    {class} function _GetYELLOW: Integer; cdecl;
    {class} function init: JColor; cdecl;
    {class} function HSVToColor(hsv: TJavaArray<Single>): Integer; cdecl; overload;
    {class} function HSVToColor(alpha: Integer; hsv: TJavaArray<Single>): Integer; cdecl; overload;
    {class} procedure RGBToHSV(red: Integer; green: Integer; blue: Integer; hsv: TJavaArray<Single>); cdecl;
    {class} function alpha(color: Integer): Integer; cdecl;
    {class} function argb(alpha: Integer; red: Integer; green: Integer; blue: Integer): Integer; cdecl;
    {class} function blue(color: Integer): Integer; cdecl;
    {class} procedure colorToHSV(color: Integer; hsv: TJavaArray<Single>); cdecl;
    {class} function green(color: Integer): Integer; cdecl;
    {class} function parseColor(colorString: JString): Integer; cdecl;
    {class} function red(color: Integer): Integer; cdecl;
    {class} function rgb(red: Integer; green: Integer; blue: Integer): Integer; cdecl;
    {class} property BLACK: Integer read _GetBLACK;
    {class} property BLUE: Integer read _GetBLUE;
    {class} property CYAN: Integer read _GetCYAN;
    {class} property DKGRAY: Integer read _GetDKGRAY;
    {class} property GRAY: Integer read _GetGRAY;
    {class} property GREEN: Integer read _GetGREEN;
    {class} property LTGRAY: Integer read _GetLTGRAY;
    {class} property MAGENTA: Integer read _GetMAGENTA;
    {class} property RED: Integer read _GetRED;
    {class} property TRANSPARENT: Integer read _GetTRANSPARENT;
    {class} property WHITE: Integer read _GetWHITE;
    {class} property YELLOW: Integer read _GetYELLOW;
  end;

  [JavaSignature('android/graphics/Color')]
  JColor = interface(JObject)
    ['{3CEB6F50-C9D3-458F-81EF-44FB35AB4DA6}']
  end;
  TJColor = class(TJavaGenericImport<JColorClass, JColor>) end;

  JColorFilterClass = interface(JObjectClass)
    ['{CD0422E3-73FA-411C-9DA1-BE5349A34965}']
    {class} function init: JColorFilter; cdecl;
  end;

  [JavaSignature('android/graphics/ColorFilter')]
  JColorFilter = interface(JObject)
    ['{03501DF4-6680-4152-AA2F-231A97E7EB8F}']
  end;
  TJColorFilter = class(TJavaGenericImport<JColorFilterClass, JColorFilter>) end;

  JColorMatrixClass = interface(JObjectClass)
    ['{0DBEAB0A-B522-47CA-9EB9-3D921E7BB22E}']
    {class} function init: JColorMatrix; cdecl; overload;
    {class} function init(src: TJavaArray<Single>): JColorMatrix; cdecl; overload;
    {class} function init(src: JColorMatrix): JColorMatrix; cdecl; overload;
  end;

  [JavaSignature('android/graphics/ColorMatrix')]
  JColorMatrix = interface(JObject)
    ['{F60844E8-C106-410F-9D38-7C1176FF3D59}']
    function getArray: TJavaArray<Single>; cdecl;
    procedure postConcat(postmatrix: JColorMatrix); cdecl;
    procedure preConcat(prematrix: JColorMatrix); cdecl;
    procedure reset; cdecl;
    procedure &set(src: JColorMatrix); cdecl; overload;
    procedure &set(src: TJavaArray<Single>); cdecl; overload;
    procedure setConcat(matA: JColorMatrix; matB: JColorMatrix); cdecl;
    procedure setRGB2YUV; cdecl;
    procedure setRotate(axis: Integer; degrees: Single); cdecl;
    procedure setSaturation(sat: Single); cdecl;
    procedure setScale(rScale: Single; gScale: Single; bScale: Single; aScale: Single); cdecl;
    procedure setYUV2RGB; cdecl;
  end;
  TJColorMatrix = class(TJavaGenericImport<JColorMatrixClass, JColorMatrix>) end;

  JColorMatrixColorFilterClass = interface(JColorFilterClass)
    ['{4385CAF4-3E7F-4798-854D-B2F8F5E1023F}']
    {class} function init(matrix: JColorMatrix): JColorMatrixColorFilter; cdecl; overload;
    {class} function init(array_: TJavaArray<Single>): JColorMatrixColorFilter; cdecl; overload;
  end;

  [JavaSignature('android/graphics/ColorMatrixColorFilter')]
  JColorMatrixColorFilter = interface(JColorFilter)
    ['{73ECD817-E5B6-4BF5-A73A-B1404C746181}']
  end;
  TJColorMatrixColorFilter = class(TJavaGenericImport<JColorMatrixColorFilterClass, JColorMatrixColorFilter>) end;

  JPathEffectClass = interface(JObjectClass)
    ['{914257B7-DE57-4297-93FD-4051CC297EE5}']
    {class} function init: JPathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/PathEffect')]
  JPathEffect = interface(JObject)
    ['{69C98CE4-6442-47CC-990F-EEF2AD4863DF}']
  end;
  TJPathEffect = class(TJavaGenericImport<JPathEffectClass, JPathEffect>) end;

  JComposePathEffectClass = interface(JPathEffectClass)
    ['{46513C14-21C2-4EDF-88D6-6C0A4A3F8CBE}']
    {class} function init(outerpe: JPathEffect; innerpe: JPathEffect): JComposePathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/ComposePathEffect')]
  JComposePathEffect = interface(JPathEffect)
    ['{6E324B1F-E418-40F2-8392-F918AA09D391}']
  end;
  TJComposePathEffect = class(TJavaGenericImport<JComposePathEffectClass, JComposePathEffect>) end;

  JComposeShaderClass = interface(JShaderClass)
    ['{7A61B787-FD33-45CE-87B4-91A1334FCA7B}']
    {class} function init(shaderA: JShader; shaderB: JShader; mode: JXfermode): JComposeShader; cdecl; overload;
    {class} function init(shaderA: JShader; shaderB: JShader; mode: JPorterDuff_Mode): JComposeShader; cdecl; overload;
  end;

  [JavaSignature('android/graphics/ComposeShader')]
  JComposeShader = interface(JShader)
    ['{A42E0489-62B7-4864-BABA-80E4443EC46E}']
  end;
  TJComposeShader = class(TJavaGenericImport<JComposeShaderClass, JComposeShader>) end;

  JCornerPathEffectClass = interface(JPathEffectClass)
    ['{1B66DCB0-AD2E-46F3-B181-50AF35B7E86A}']
    {class} function init(radius: Single): JCornerPathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/CornerPathEffect')]
  JCornerPathEffect = interface(JPathEffect)
    ['{E513FB33-ADA1-48CF-BB5B-58D047DDAA79}']
  end;
  TJCornerPathEffect = class(TJavaGenericImport<JCornerPathEffectClass, JCornerPathEffect>) end;

  JDashPathEffectClass = interface(JPathEffectClass)
    ['{59B6B7FB-43F1-4789-836E-2E77BD324294}']
    {class} function init(intervals: TJavaArray<Single>; phase: Single): JDashPathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/DashPathEffect')]
  JDashPathEffect = interface(JPathEffect)
    ['{62E19601-80A3-479E-8E3F-E6EDB5561BFB}']
  end;
  TJDashPathEffect = class(TJavaGenericImport<JDashPathEffectClass, JDashPathEffect>) end;

  JDiscretePathEffectClass = interface(JPathEffectClass)
    ['{94123CD0-45CB-4A02-A07F-DC8429292802}']
    {class} function init(segmentLength: Single; deviation: Single): JDiscretePathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/DiscretePathEffect')]
  JDiscretePathEffect = interface(JPathEffect)
    ['{D1C123BD-6C32-49F4-AB15-6E20B4BC0B56}']
  end;
  TJDiscretePathEffect = class(TJavaGenericImport<JDiscretePathEffectClass, JDiscretePathEffect>) end;

  JDrawFilterClass = interface(JObjectClass)
    ['{4828BAA5-CA85-4263-86AC-4589594C8468}']
    {class} function init: JDrawFilter; cdecl;
  end;

  [JavaSignature('android/graphics/DrawFilter')]
  JDrawFilter = interface(JObject)
    ['{70F6DBC6-C410-4E64-B6AB-0862C2D94BF1}']
  end;
  TJDrawFilter = class(TJavaGenericImport<JDrawFilterClass, JDrawFilter>) end;

  JEmbossMaskFilterClass = interface(JMaskFilterClass)
    ['{1C7816EE-0FC7-496C-9FE4-4DEB9C813FE1}']
    {class} function init(direction: TJavaArray<Single>; ambient: Single; specular: Single; blurRadius: Single): JEmbossMaskFilter; cdecl;
  end;

  [JavaSignature('android/graphics/EmbossMaskFilter')]
  JEmbossMaskFilter = interface(JMaskFilter)
    ['{B9273A69-52FC-46FF-89F3-6A1C0FEEE5DA}']
  end;
  TJEmbossMaskFilter = class(TJavaGenericImport<JEmbossMaskFilterClass, JEmbossMaskFilter>) end;

  JImageFormatClass = interface(JObjectClass)
    ['{FA5ABF62-CD4C-4308-9E12-4DC09865BA95}']
    {class} function _GetDEPTH16: Integer; cdecl;
    {class} function _GetDEPTH_POINT_CLOUD: Integer; cdecl;
    {class} function _GetFLEX_RGBA_8888: Integer; cdecl;
    {class} function _GetFLEX_RGB_888: Integer; cdecl;
    {class} function _GetJPEG: Integer; cdecl;
    {class} function _GetNV16: Integer; cdecl;
    {class} function _GetNV21: Integer; cdecl;
    {class} function _GetPRIVATE: Integer; cdecl;
    {class} function _GetRAW10: Integer; cdecl;
    {class} function _GetRAW12: Integer; cdecl;
    {class} function _GetRAW_SENSOR: Integer; cdecl;
    {class} function _GetRGB_565: Integer; cdecl;
    {class} function _GetUNKNOWN: Integer; cdecl;
    {class} function _GetYUV_420_888: Integer; cdecl;
    {class} function _GetYUV_422_888: Integer; cdecl;
    {class} function _GetYUV_444_888: Integer; cdecl;
    {class} function _GetYUY2: Integer; cdecl;
    {class} function _GetYV12: Integer; cdecl;
    {class} function init: JImageFormat; cdecl;
    {class} function getBitsPerPixel(format: Integer): Integer; cdecl;
    {class} property DEPTH16: Integer read _GetDEPTH16;
    {class} property DEPTH_POINT_CLOUD: Integer read _GetDEPTH_POINT_CLOUD;
    {class} property FLEX_RGBA_8888: Integer read _GetFLEX_RGBA_8888;
    {class} property FLEX_RGB_888: Integer read _GetFLEX_RGB_888;
    {class} property JPEG: Integer read _GetJPEG;
    {class} property NV16: Integer read _GetNV16;
    {class} property NV21: Integer read _GetNV21;
    {class} property &PRIVATE: Integer read _GetPRIVATE;
    {class} property RAW10: Integer read _GetRAW10;
    {class} property RAW12: Integer read _GetRAW12;
    {class} property RAW_SENSOR: Integer read _GetRAW_SENSOR;
    {class} property RGB_565: Integer read _GetRGB_565;
    {class} property UNKNOWN: Integer read _GetUNKNOWN;
    {class} property YUV_420_888: Integer read _GetYUV_420_888;
    {class} property YUV_422_888: Integer read _GetYUV_422_888;
    {class} property YUV_444_888: Integer read _GetYUV_444_888;
    {class} property YUY2: Integer read _GetYUY2;
    {class} property YV12: Integer read _GetYV12;
  end;

  [JavaSignature('android/graphics/ImageFormat')]
  JImageFormat = interface(JObject)
    ['{0AE078B6-B798-468F-8936-64218ACA689C}']
  end;
  TJImageFormat = class(TJavaGenericImport<JImageFormatClass, JImageFormat>) end;

  Jgraphics_InterpolatorClass = interface(JObjectClass)
    ['{4305ED09-E153-4638-BA91-7EC654E86893}']
    {class} function init(valueCount: Integer): Jgraphics_Interpolator; cdecl; overload;
    {class} function init(valueCount: Integer; frameCount: Integer): Jgraphics_Interpolator; cdecl; overload;
  end;

  [JavaSignature('android/graphics/Interpolator')]
  Jgraphics_Interpolator = interface(JObject)
    ['{25B2099C-5F7F-4F93-98A8-D7563EF5DB2B}']
    function getKeyFrameCount: Integer; cdecl;
    function getValueCount: Integer; cdecl;
    procedure reset(valueCount: Integer); cdecl; overload;
    procedure reset(valueCount: Integer; frameCount: Integer); cdecl; overload;
    procedure setKeyFrame(index: Integer; msec: Integer; values: TJavaArray<Single>); cdecl; overload;
    procedure setKeyFrame(index: Integer; msec: Integer; values: TJavaArray<Single>; blend: TJavaArray<Single>); cdecl; overload;
    procedure setRepeatMirror(repeatCount: Single; mirror: Boolean); cdecl;
    function timeToValues(values: TJavaArray<Single>): JInterpolator_Result; cdecl; overload;
    function timeToValues(msec: Integer; values: TJavaArray<Single>): JInterpolator_Result; cdecl; overload;
  end;
  TJgraphics_Interpolator = class(TJavaGenericImport<Jgraphics_InterpolatorClass, Jgraphics_Interpolator>) end;

  JInterpolator_ResultClass = interface(JEnumClass)
    ['{A131B06A-1B74-44CD-ADFF-B324ABDE3530}']
    {class} function _GetFREEZE_END: JInterpolator_Result; cdecl;
    {class} function _GetFREEZE_START: JInterpolator_Result; cdecl;
    {class} function _GetNORMAL: JInterpolator_Result; cdecl;
    {class} function valueOf(name: JString): JInterpolator_Result; cdecl;
    {class} function values: TJavaObjectArray<JInterpolator_Result>; cdecl;
    {class} property FREEZE_END: JInterpolator_Result read _GetFREEZE_END;
    {class} property FREEZE_START: JInterpolator_Result read _GetFREEZE_START;
    {class} property NORMAL: JInterpolator_Result read _GetNORMAL;
  end;

  [JavaSignature('android/graphics/Interpolator$Result')]
  JInterpolator_Result = interface(JEnum)
    ['{88FFBFD3-0A6B-4CA3-B941-38D7CBC198BB}']
  end;
  TJInterpolator_Result = class(TJavaGenericImport<JInterpolator_ResultClass, JInterpolator_Result>) end;

  JRasterizerClass = interface(JObjectClass)
    ['{5F2AA4C2-9E97-42BF-AE2B-72D004DA4D36}']
    {class} function init: JRasterizer; cdecl;
  end;

  [JavaSignature('android/graphics/Rasterizer')]
  JRasterizer = interface(JObject)
    ['{C1E10C30-32E4-422D-AFB1-6F0A6BFCB38E}']
  end;
  TJRasterizer = class(TJavaGenericImport<JRasterizerClass, JRasterizer>) end;

  JLayerRasterizerClass = interface(JRasterizerClass)
    ['{474E4C95-BB7B-49B1-AE43-35AB2796E8A4}']
    {class} function init: JLayerRasterizer; cdecl;
  end;

  [JavaSignature('android/graphics/LayerRasterizer')]
  JLayerRasterizer = interface(JRasterizer)
    ['{9C8F2CCB-17E7-4588-BFCE-3A3F78B7AC87}']
    procedure addLayer(paint: JPaint; dx: Single; dy: Single); cdecl; overload;
    procedure addLayer(paint: JPaint); cdecl; overload;
  end;
  TJLayerRasterizer = class(TJavaGenericImport<JLayerRasterizerClass, JLayerRasterizer>) end;

  JLightingColorFilterClass = interface(JColorFilterClass)
    ['{2EAA9BD4-23CE-4C6E-BB82-C584956BB5F9}']
    {class} function init(mul: Integer; add: Integer): JLightingColorFilter; cdecl;
  end;

  [JavaSignature('android/graphics/LightingColorFilter')]
  JLightingColorFilter = interface(JColorFilter)
    ['{DE516E75-92A9-4E9C-BAE2-1D4911D5A8A2}']
  end;
  TJLightingColorFilter = class(TJavaGenericImport<JLightingColorFilterClass, JLightingColorFilter>) end;

  JLinearGradientClass = interface(JShaderClass)
    ['{7C2075CF-A281-458B-90E5-3899AF747163}']
    {class} function init(x0: Single; y0: Single; x1: Single; y1: Single; colors: TJavaArray<Integer>; positions: TJavaArray<Single>; tile: JShader_TileMode): JLinearGradient; cdecl; overload;
    {class} function init(x0: Single; y0: Single; x1: Single; y1: Single; color0: Integer; color1: Integer; tile: JShader_TileMode): JLinearGradient; cdecl; overload;
  end;

  [JavaSignature('android/graphics/LinearGradient')]
  JLinearGradient = interface(JShader)
    ['{EEFB1AC5-72CB-4579-B12F-35ACF6A3743D}']
  end;
  TJLinearGradient = class(TJavaGenericImport<JLinearGradientClass, JLinearGradient>) end;

  JMatrixClass = interface(JObjectClass)
    ['{91EA9B3A-8F52-4413-84F4-8B75BDD6EC25}']
    {class} function _GetMPERSP_0: Integer; cdecl;
    {class} function _GetMPERSP_1: Integer; cdecl;
    {class} function _GetMPERSP_2: Integer; cdecl;
    {class} function _GetMSCALE_X: Integer; cdecl;
    {class} function _GetMSCALE_Y: Integer; cdecl;
    {class} function _GetMSKEW_X: Integer; cdecl;
    {class} function _GetMSKEW_Y: Integer; cdecl;
    {class} function _GetMTRANS_X: Integer; cdecl;
    {class} function _GetMTRANS_Y: Integer; cdecl;
    {class} function init: JMatrix; cdecl; overload;
    {class} function init(src: JMatrix): JMatrix; cdecl; overload;
    {class} property MPERSP_0: Integer read _GetMPERSP_0;
    {class} property MPERSP_1: Integer read _GetMPERSP_1;
    {class} property MPERSP_2: Integer read _GetMPERSP_2;
    {class} property MSCALE_X: Integer read _GetMSCALE_X;
    {class} property MSCALE_Y: Integer read _GetMSCALE_Y;
    {class} property MSKEW_X: Integer read _GetMSKEW_X;
    {class} property MSKEW_Y: Integer read _GetMSKEW_Y;
    {class} property MTRANS_X: Integer read _GetMTRANS_X;
    {class} property MTRANS_Y: Integer read _GetMTRANS_Y;
  end;

  [JavaSignature('android/graphics/Matrix')]
  JMatrix = interface(JObject)
    ['{FF273EAF-C0C2-46D0-9D40-356C370EAF43}']
    function equals(obj: JObject): Boolean; cdecl;
    procedure getValues(values: TJavaArray<Single>); cdecl;
    function hashCode: Integer; cdecl;
    function invert(inverse: JMatrix): Boolean; cdecl;
    function isAffine: Boolean; cdecl;
    function isIdentity: Boolean; cdecl;
    procedure mapPoints(dst: TJavaArray<Single>; dstIndex: Integer; src: TJavaArray<Single>; srcIndex: Integer; pointCount: Integer); cdecl; overload;
    procedure mapPoints(dst: TJavaArray<Single>; src: TJavaArray<Single>); cdecl; overload;
    procedure mapPoints(pts: TJavaArray<Single>); cdecl; overload;
    function mapRadius(radius: Single): Single; cdecl;
    function mapRect(dst: JRectF; src: JRectF): Boolean; cdecl; overload;
    function mapRect(rect: JRectF): Boolean; cdecl; overload;
    procedure mapVectors(dst: TJavaArray<Single>; dstIndex: Integer; src: TJavaArray<Single>; srcIndex: Integer; vectorCount: Integer); cdecl; overload;
    procedure mapVectors(dst: TJavaArray<Single>; src: TJavaArray<Single>); cdecl; overload;
    procedure mapVectors(vecs: TJavaArray<Single>); cdecl; overload;
    function postConcat(other: JMatrix): Boolean; cdecl;
    function postRotate(degrees: Single; px: Single; py: Single): Boolean; cdecl; overload;
    function postRotate(degrees: Single): Boolean; cdecl; overload;
    function postScale(sx: Single; sy: Single; px: Single; py: Single): Boolean; cdecl; overload;
    function postScale(sx: Single; sy: Single): Boolean; cdecl; overload;
    function postSkew(kx: Single; ky: Single; px: Single; py: Single): Boolean; cdecl; overload;
    function postSkew(kx: Single; ky: Single): Boolean; cdecl; overload;
    function postTranslate(dx: Single; dy: Single): Boolean; cdecl;
    function preConcat(other: JMatrix): Boolean; cdecl;
    function preRotate(degrees: Single; px: Single; py: Single): Boolean; cdecl; overload;
    function preRotate(degrees: Single): Boolean; cdecl; overload;
    function preScale(sx: Single; sy: Single; px: Single; py: Single): Boolean; cdecl; overload;
    function preScale(sx: Single; sy: Single): Boolean; cdecl; overload;
    function preSkew(kx: Single; ky: Single; px: Single; py: Single): Boolean; cdecl; overload;
    function preSkew(kx: Single; ky: Single): Boolean; cdecl; overload;
    function preTranslate(dx: Single; dy: Single): Boolean; cdecl;
    function rectStaysRect: Boolean; cdecl;
    procedure reset; cdecl;
    procedure &set(src: JMatrix); cdecl;
    function setConcat(a: JMatrix; b: JMatrix): Boolean; cdecl;
    function setPolyToPoly(src: TJavaArray<Single>; srcIndex: Integer; dst: TJavaArray<Single>; dstIndex: Integer; pointCount: Integer): Boolean; cdecl;
    function setRectToRect(src: JRectF; dst: JRectF; stf: JMatrix_ScaleToFit): Boolean; cdecl;
    procedure setRotate(degrees: Single; px: Single; py: Single); cdecl; overload;
    procedure setRotate(degrees: Single); cdecl; overload;
    procedure setScale(sx: Single; sy: Single; px: Single; py: Single); cdecl; overload;
    procedure setScale(sx: Single; sy: Single); cdecl; overload;
    procedure setSinCos(sinValue: Single; cosValue: Single; px: Single; py: Single); cdecl; overload;
    procedure setSinCos(sinValue: Single; cosValue: Single); cdecl; overload;
    procedure setSkew(kx: Single; ky: Single; px: Single; py: Single); cdecl; overload;
    procedure setSkew(kx: Single; ky: Single); cdecl; overload;
    procedure setTranslate(dx: Single; dy: Single); cdecl;
    procedure setValues(values: TJavaArray<Single>); cdecl;
    function toShortString: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJMatrix = class(TJavaGenericImport<JMatrixClass, JMatrix>) end;

  JMatrix_ScaleToFitClass = interface(JEnumClass)
    ['{8FA5BE46-BB7B-4575-B3B5-E34370C2E93F}']
    {class} function _GetCENTER: JMatrix_ScaleToFit; cdecl;
    {class} function _GetEND: JMatrix_ScaleToFit; cdecl;
    {class} function _GetFILL: JMatrix_ScaleToFit; cdecl;
    {class} function _GetSTART: JMatrix_ScaleToFit; cdecl;
    {class} function valueOf(name: JString): JMatrix_ScaleToFit; cdecl;
    {class} function values: TJavaObjectArray<JMatrix_ScaleToFit>; cdecl;
    {class} property CENTER: JMatrix_ScaleToFit read _GetCENTER;
    {class} property &END: JMatrix_ScaleToFit read _GetEND;
    {class} property FILL: JMatrix_ScaleToFit read _GetFILL;
    {class} property START: JMatrix_ScaleToFit read _GetSTART;
  end;

  [JavaSignature('android/graphics/Matrix$ScaleToFit')]
  JMatrix_ScaleToFit = interface(JEnum)
    ['{792A8576-200E-49FE-9A47-C55746C0FD72}']
  end;
  TJMatrix_ScaleToFit = class(TJavaGenericImport<JMatrix_ScaleToFitClass, JMatrix_ScaleToFit>) end;

  JMovieClass = interface(JObjectClass)
    ['{A8B58AED-7BF1-4A1D-872A-B066AF81A108}']
    {class} function decodeByteArray(data: TJavaArray<Byte>; offset: Integer; length: Integer): JMovie; cdecl;
    {class} function decodeFile(pathName: JString): JMovie; cdecl;
    {class} function decodeStream(is_: JInputStream): JMovie; cdecl;
  end;

  [JavaSignature('android/graphics/Movie')]
  JMovie = interface(JObject)
    ['{05A99234-057F-4B23-A52D-07C6C1175265}']
    procedure draw(canvas: JCanvas; x: Single; y: Single; paint: JPaint); cdecl; overload;
    procedure draw(canvas: JCanvas; x: Single; y: Single); cdecl; overload;
    function duration: Integer; cdecl;
    function height: Integer; cdecl;
    function isOpaque: Boolean; cdecl;
    function setTime(relativeMilliseconds: Integer): Boolean; cdecl;
    function width: Integer; cdecl;
  end;
  TJMovie = class(TJavaGenericImport<JMovieClass, JMovie>) end;

  JNinePatchClass = interface(JObjectClass)
    ['{5F4F53E2-09A1-4B53-9C0B-54FA541CF30E}']
    {class} function init(bitmap: JBitmap; chunk: TJavaArray<Byte>): JNinePatch; cdecl; overload;
    {class} function init(bitmap: JBitmap; chunk: TJavaArray<Byte>; srcName: JString): JNinePatch; cdecl; overload;
    {class} function isNinePatchChunk(chunk: TJavaArray<Byte>): Boolean; cdecl;
  end;

  [JavaSignature('android/graphics/NinePatch')]
  JNinePatch = interface(JObject)
    ['{02C8AAEB-2EEC-4ED0-B53D-11E3BF121264}']
    procedure draw(canvas: JCanvas; location: JRectF); cdecl; overload;
    procedure draw(canvas: JCanvas; location: JRect); cdecl; overload;
    procedure draw(canvas: JCanvas; location: JRect; paint: JPaint); cdecl; overload;
    function getBitmap: JBitmap; cdecl;
    function getDensity: Integer; cdecl;
    function getHeight: Integer; cdecl;
    function getName: JString; cdecl;
    function getPaint: JPaint; cdecl;
    function getTransparentRegion(bounds: JRect): JRegion; cdecl;
    function getWidth: Integer; cdecl;
    function hasAlpha: Boolean; cdecl;
    procedure setPaint(p: JPaint); cdecl;
  end;
  TJNinePatch = class(TJavaGenericImport<JNinePatchClass, JNinePatch>) end;

  JOutlineClass = interface(JObjectClass)
    ['{DE80DAC1-60EE-4366-A68E-A35D4EB528C5}']
    {class} function init: JOutline; cdecl; overload;
    {class} function init(src: JOutline): JOutline; cdecl; overload;
  end;

  [JavaSignature('android/graphics/Outline')]
  JOutline = interface(JObject)
    ['{8BAAAD91-A86B-4ACA-97BD-0AC25298A377}']
    function canClip: Boolean; cdecl;
    function getAlpha: Single; cdecl;
    function isEmpty: Boolean; cdecl;
    procedure offset(dx: Integer; dy: Integer); cdecl;
    procedure &set(src: JOutline); cdecl;
    procedure setAlpha(alpha: Single); cdecl;
    procedure setConvexPath(convexPath: JPath); cdecl;
    procedure setEmpty; cdecl;
    procedure setOval(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure setOval(rect: JRect); cdecl; overload;
    procedure setRect(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure setRect(rect: JRect); cdecl; overload;
    procedure setRoundRect(left: Integer; top: Integer; right: Integer; bottom: Integer; radius: Single); cdecl; overload;
    procedure setRoundRect(rect: JRect; radius: Single); cdecl; overload;
  end;
  TJOutline = class(TJavaGenericImport<JOutlineClass, JOutline>) end;

  JPaintClass = interface(JObjectClass)
    ['{51637BF7-79B0-4E30-9A4D-22514020490B}']
    {class} function _GetANTI_ALIAS_FLAG: Integer; cdecl;
    {class} function _GetDEV_KERN_TEXT_FLAG: Integer; cdecl;
    {class} function _GetDITHER_FLAG: Integer; cdecl;
    {class} function _GetEMBEDDED_BITMAP_TEXT_FLAG: Integer; cdecl;
    {class} function _GetFAKE_BOLD_TEXT_FLAG: Integer; cdecl;
    {class} function _GetFILTER_BITMAP_FLAG: Integer; cdecl;
    {class} function _GetHINTING_OFF: Integer; cdecl;
    {class} function _GetHINTING_ON: Integer; cdecl;
    {class} function _GetLINEAR_TEXT_FLAG: Integer; cdecl;
    {class} function _GetSTRIKE_THRU_TEXT_FLAG: Integer; cdecl;
    {class} function _GetSUBPIXEL_TEXT_FLAG: Integer; cdecl;
    {class} function _GetUNDERLINE_TEXT_FLAG: Integer; cdecl;
    {class} function init: JPaint; cdecl; overload;
    {class} function init(flags: Integer): JPaint; cdecl; overload;
    {class} function init(paint: JPaint): JPaint; cdecl; overload;
    {class} property ANTI_ALIAS_FLAG: Integer read _GetANTI_ALIAS_FLAG;
    {class} property DEV_KERN_TEXT_FLAG: Integer read _GetDEV_KERN_TEXT_FLAG;
    {class} property DITHER_FLAG: Integer read _GetDITHER_FLAG;
    {class} property EMBEDDED_BITMAP_TEXT_FLAG: Integer read _GetEMBEDDED_BITMAP_TEXT_FLAG;
    {class} property FAKE_BOLD_TEXT_FLAG: Integer read _GetFAKE_BOLD_TEXT_FLAG;
    {class} property FILTER_BITMAP_FLAG: Integer read _GetFILTER_BITMAP_FLAG;
    {class} property HINTING_OFF: Integer read _GetHINTING_OFF;
    {class} property HINTING_ON: Integer read _GetHINTING_ON;
    {class} property LINEAR_TEXT_FLAG: Integer read _GetLINEAR_TEXT_FLAG;
    {class} property STRIKE_THRU_TEXT_FLAG: Integer read _GetSTRIKE_THRU_TEXT_FLAG;
    {class} property SUBPIXEL_TEXT_FLAG: Integer read _GetSUBPIXEL_TEXT_FLAG;
    {class} property UNDERLINE_TEXT_FLAG: Integer read _GetUNDERLINE_TEXT_FLAG;
  end;

  [JavaSignature('android/graphics/Paint')]
  JPaint = interface(JObject)
    ['{56C76B78-7D6A-47D8-985F-401A64D81FFB}']
    function ascent: Single; cdecl;
    function breakText(text: TJavaArray<Char>; index: Integer; count: Integer; maxWidth: Single; measuredWidth: TJavaArray<Single>): Integer; cdecl; overload;
    function breakText(text: JCharSequence; start: Integer; end_: Integer; measureForwards: Boolean; maxWidth: Single; measuredWidth: TJavaArray<Single>): Integer; cdecl; overload;
    function breakText(text: JString; measureForwards: Boolean; maxWidth: Single; measuredWidth: TJavaArray<Single>): Integer; cdecl; overload;
    procedure clearShadowLayer; cdecl;
    function descent: Single; cdecl;
    function getAlpha: Integer; cdecl;
    function getColor: Integer; cdecl;
    function getColorFilter: JColorFilter; cdecl;
    function getFillPath(src: JPath; dst: JPath): Boolean; cdecl;
    function getFlags: Integer; cdecl;
    function getFontFeatureSettings: JString; cdecl;
    function getFontMetrics(metrics: JPaint_FontMetrics): Single; cdecl; overload;
    function getFontMetrics: JPaint_FontMetrics; cdecl; overload;
    function getFontMetricsInt(fmi: JPaint_FontMetricsInt): Integer; cdecl; overload;
    function getFontMetricsInt: JPaint_FontMetricsInt; cdecl; overload;
    function getFontSpacing: Single; cdecl;
    function getHinting: Integer; cdecl;
    function getLetterSpacing: Single; cdecl;
    function getMaskFilter: JMaskFilter; cdecl;
    function getOffsetForAdvance(text: TJavaArray<Char>; start: Integer; end_: Integer; contextStart: Integer; contextEnd: Integer; isRtl: Boolean; advance: Single): Integer; cdecl; overload;
    function getOffsetForAdvance(text: JCharSequence; start: Integer; end_: Integer; contextStart: Integer; contextEnd: Integer; isRtl: Boolean; advance: Single): Integer; cdecl; overload;
    function getPathEffect: JPathEffect; cdecl;
    function getRasterizer: JRasterizer; cdecl;//Deprecated
    function getRunAdvance(text: TJavaArray<Char>; start: Integer; end_: Integer; contextStart: Integer; contextEnd: Integer; isRtl: Boolean; offset: Integer): Single; cdecl; overload;
    function getRunAdvance(text: JCharSequence; start: Integer; end_: Integer; contextStart: Integer; contextEnd: Integer; isRtl: Boolean; offset: Integer): Single; cdecl; overload;
    function getShader: JShader; cdecl;
    function getStrokeCap: JPaint_Cap; cdecl;
    function getStrokeJoin: JPaint_Join; cdecl;
    function getStrokeMiter: Single; cdecl;
    function getStrokeWidth: Single; cdecl;
    function getStyle: JPaint_Style; cdecl;
    function getTextAlign: JPaint_Align; cdecl;
    procedure getTextBounds(text: JString; start: Integer; end_: Integer; bounds: JRect); cdecl; overload;
    procedure getTextBounds(text: TJavaArray<Char>; index: Integer; count: Integer; bounds: JRect); cdecl; overload;
    function getTextLocale: JLocale; cdecl;
    procedure getTextPath(text: TJavaArray<Char>; index: Integer; count: Integer; x: Single; y: Single; path: JPath); cdecl; overload;
    procedure getTextPath(text: JString; start: Integer; end_: Integer; x: Single; y: Single; path: JPath); cdecl; overload;
    function getTextScaleX: Single; cdecl;
    function getTextSize: Single; cdecl;
    function getTextSkewX: Single; cdecl;
    function getTextWidths(text: TJavaArray<Char>; index: Integer; count: Integer; widths: TJavaArray<Single>): Integer; cdecl; overload;
    function getTextWidths(text: JCharSequence; start: Integer; end_: Integer; widths: TJavaArray<Single>): Integer; cdecl; overload;
    function getTextWidths(text: JString; start: Integer; end_: Integer; widths: TJavaArray<Single>): Integer; cdecl; overload;
    function getTextWidths(text: JString; widths: TJavaArray<Single>): Integer; cdecl; overload;
    function getTypeface: JTypeface; cdecl;
    function getXfermode: JXfermode; cdecl;
    function hasGlyph(string_: JString): Boolean; cdecl;
    function isAntiAlias: Boolean; cdecl;
    function isDither: Boolean; cdecl;
    function isElegantTextHeight: Boolean; cdecl;
    function isFakeBoldText: Boolean; cdecl;
    function isFilterBitmap: Boolean; cdecl;
    function isLinearText: Boolean; cdecl;
    function isStrikeThruText: Boolean; cdecl;
    function isSubpixelText: Boolean; cdecl;
    function isUnderlineText: Boolean; cdecl;
    function measureText(text: TJavaArray<Char>; index: Integer; count: Integer): Single; cdecl; overload;
    function measureText(text: JString; start: Integer; end_: Integer): Single; cdecl; overload;
    function measureText(text: JString): Single; cdecl; overload;
    function measureText(text: JCharSequence; start: Integer; end_: Integer): Single; cdecl; overload;
    procedure reset; cdecl;
    procedure &set(src: JPaint); cdecl;
    procedure setARGB(a: Integer; r: Integer; g: Integer; b: Integer); cdecl;
    procedure setAlpha(a: Integer); cdecl;
    procedure setAntiAlias(aa: Boolean); cdecl;
    procedure setColor(color: Integer); cdecl;
    function setColorFilter(filter: JColorFilter): JColorFilter; cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setElegantTextHeight(elegant: Boolean); cdecl;
    procedure setFakeBoldText(fakeBoldText: Boolean); cdecl;
    procedure setFilterBitmap(filter: Boolean); cdecl;
    procedure setFlags(flags: Integer); cdecl;
    procedure setFontFeatureSettings(settings: JString); cdecl;
    procedure setHinting(mode: Integer); cdecl;
    procedure setLetterSpacing(letterSpacing: Single); cdecl;
    procedure setLinearText(linearText: Boolean); cdecl;
    function setMaskFilter(maskfilter: JMaskFilter): JMaskFilter; cdecl;
    function setPathEffect(effect: JPathEffect): JPathEffect; cdecl;
    function setRasterizer(rasterizer: JRasterizer): JRasterizer; cdecl;//Deprecated
    function setShader(shader: JShader): JShader; cdecl;
    procedure setShadowLayer(radius: Single; dx: Single; dy: Single; shadowColor: Integer); cdecl;
    procedure setStrikeThruText(strikeThruText: Boolean); cdecl;
    procedure setStrokeCap(cap: JPaint_Cap); cdecl;
    procedure setStrokeJoin(join: JPaint_Join); cdecl;
    procedure setStrokeMiter(miter: Single); cdecl;
    procedure setStrokeWidth(width: Single); cdecl;
    procedure setStyle(style: JPaint_Style); cdecl;
    procedure setSubpixelText(subpixelText: Boolean); cdecl;
    procedure setTextAlign(align: JPaint_Align); cdecl;
    procedure setTextLocale(locale: JLocale); cdecl;
    procedure setTextScaleX(scaleX: Single); cdecl;
    procedure setTextSize(textSize: Single); cdecl;
    procedure setTextSkewX(skewX: Single); cdecl;
    function setTypeface(typeface: JTypeface): JTypeface; cdecl;
    procedure setUnderlineText(underlineText: Boolean); cdecl;
    function setXfermode(xfermode: JXfermode): JXfermode; cdecl;
  end;
  TJPaint = class(TJavaGenericImport<JPaintClass, JPaint>) end;

  JPaint_AlignClass = interface(JEnumClass)
    ['{CA524B48-AD2A-4679-8554-9BA634A758A8}']
    {class} function _GetCENTER: JPaint_Align; cdecl;
    {class} function _GetLEFT: JPaint_Align; cdecl;
    {class} function _GetRIGHT: JPaint_Align; cdecl;
    {class} function valueOf(name: JString): JPaint_Align; cdecl;
    {class} function values: TJavaObjectArray<JPaint_Align>; cdecl;
    {class} property CENTER: JPaint_Align read _GetCENTER;
    {class} property LEFT: JPaint_Align read _GetLEFT;
    {class} property RIGHT: JPaint_Align read _GetRIGHT;
  end;

  [JavaSignature('android/graphics/Paint$Align')]
  JPaint_Align = interface(JEnum)
    ['{E5958A36-025D-497A-87AD-4AEE6297BEED}']
  end;
  TJPaint_Align = class(TJavaGenericImport<JPaint_AlignClass, JPaint_Align>) end;

  JPaint_CapClass = interface(JEnumClass)
    ['{1BBB271F-5B0D-408F-95FD-0D4864FCEF3D}']
    {class} function _GetBUTT: JPaint_Cap; cdecl;
    {class} function _GetROUND: JPaint_Cap; cdecl;
    {class} function _GetSQUARE: JPaint_Cap; cdecl;
    {class} function valueOf(name: JString): JPaint_Cap; cdecl;
    {class} function values: TJavaObjectArray<JPaint_Cap>; cdecl;
    {class} property BUTT: JPaint_Cap read _GetBUTT;
    {class} property ROUND: JPaint_Cap read _GetROUND;
    {class} property SQUARE: JPaint_Cap read _GetSQUARE;
  end;

  [JavaSignature('android/graphics/Paint$Cap')]
  JPaint_Cap = interface(JEnum)
    ['{070E3F78-E07E-4030-B63C-CC827D673EF6}']
  end;
  TJPaint_Cap = class(TJavaGenericImport<JPaint_CapClass, JPaint_Cap>) end;

  JPaint_FontMetricsClass = interface(JObjectClass)
    ['{15A2A7FE-09DB-487F-A3A6-4A8B1670412E}']
    {class} function init: JPaint_FontMetrics; cdecl;
  end;

  [JavaSignature('android/graphics/Paint$FontMetrics')]
  JPaint_FontMetrics = interface(JObject)
    ['{91263E0D-1BA1-4DAD-BD30-905C0E7DC043}']
    function _Getascent: Single; cdecl;
    procedure _Setascent(Value: Single); cdecl;
    function _Getbottom: Single; cdecl;
    procedure _Setbottom(Value: Single); cdecl;
    function _Getdescent: Single; cdecl;
    procedure _Setdescent(Value: Single); cdecl;
    function _Getleading: Single; cdecl;
    procedure _Setleading(Value: Single); cdecl;
    function _Gettop: Single; cdecl;
    procedure _Settop(Value: Single); cdecl;
    property ascent: Single read _Getascent write _Setascent;
    property bottom: Single read _Getbottom write _Setbottom;
    property descent: Single read _Getdescent write _Setdescent;
    property leading: Single read _Getleading write _Setleading;
    property top: Single read _Gettop write _Settop;
  end;
  TJPaint_FontMetrics = class(TJavaGenericImport<JPaint_FontMetricsClass, JPaint_FontMetrics>) end;

  JPaint_FontMetricsIntClass = interface(JObjectClass)
    ['{7E299A8C-AB57-48E4-862D-979BC932C3EA}']
    {class} function init: JPaint_FontMetricsInt; cdecl;
  end;

  [JavaSignature('android/graphics/Paint$FontMetricsInt')]
  JPaint_FontMetricsInt = interface(JObject)
    ['{D21F9199-6129-4DF5-8090-9F4E2563AF6C}']
    function _Getascent: Integer; cdecl;
    procedure _Setascent(Value: Integer); cdecl;
    function _Getbottom: Integer; cdecl;
    procedure _Setbottom(Value: Integer); cdecl;
    function _Getdescent: Integer; cdecl;
    procedure _Setdescent(Value: Integer); cdecl;
    function _Getleading: Integer; cdecl;
    procedure _Setleading(Value: Integer); cdecl;
    function _Gettop: Integer; cdecl;
    procedure _Settop(Value: Integer); cdecl;
    function toString: JString; cdecl;
    property ascent: Integer read _Getascent write _Setascent;
    property bottom: Integer read _Getbottom write _Setbottom;
    property descent: Integer read _Getdescent write _Setdescent;
    property leading: Integer read _Getleading write _Setleading;
    property top: Integer read _Gettop write _Settop;
  end;
  TJPaint_FontMetricsInt = class(TJavaGenericImport<JPaint_FontMetricsIntClass, JPaint_FontMetricsInt>) end;

  JPaint_JoinClass = interface(JEnumClass)
    ['{DC90FC45-0EFB-419D-8784-75B944293687}']
    {class} function _GetBEVEL: JPaint_Join; cdecl;
    {class} function _GetMITER: JPaint_Join; cdecl;
    {class} function _GetROUND: JPaint_Join; cdecl;
    {class} function valueOf(name: JString): JPaint_Join; cdecl;
    {class} function values: TJavaObjectArray<JPaint_Join>; cdecl;
    {class} property BEVEL: JPaint_Join read _GetBEVEL;
    {class} property MITER: JPaint_Join read _GetMITER;
    {class} property ROUND: JPaint_Join read _GetROUND;
  end;

  [JavaSignature('android/graphics/Paint$Join')]
  JPaint_Join = interface(JEnum)
    ['{FA5E10E3-0794-4DBF-8197-262F4A8AE178}']
  end;
  TJPaint_Join = class(TJavaGenericImport<JPaint_JoinClass, JPaint_Join>) end;

  JPaint_StyleClass = interface(JEnumClass)
    ['{9868584E-BF88-4BEF-96EA-67323FD4DB5E}']
    {class} function _GetFILL: JPaint_Style; cdecl;
    {class} function _GetFILL_AND_STROKE: JPaint_Style; cdecl;
    {class} function _GetSTROKE: JPaint_Style; cdecl;
    {class} function valueOf(name: JString): JPaint_Style; cdecl;
    {class} function values: TJavaObjectArray<JPaint_Style>; cdecl;
    {class} property FILL: JPaint_Style read _GetFILL;
    {class} property FILL_AND_STROKE: JPaint_Style read _GetFILL_AND_STROKE;
    {class} property STROKE: JPaint_Style read _GetSTROKE;
  end;

  [JavaSignature('android/graphics/Paint$Style')]
  JPaint_Style = interface(JEnum)
    ['{1BB91885-3BDE-4C4F-A7AC-C9C676DEC571}']
  end;
  TJPaint_Style = class(TJavaGenericImport<JPaint_StyleClass, JPaint_Style>) end;

  JPaintFlagsDrawFilterClass = interface(JDrawFilterClass)
    ['{F67C7E88-47B8-4728-8E4E-C8625B550A1F}']
    {class} function init(clearBits: Integer; setBits: Integer): JPaintFlagsDrawFilter; cdecl;
  end;

  [JavaSignature('android/graphics/PaintFlagsDrawFilter')]
  JPaintFlagsDrawFilter = interface(JDrawFilter)
    ['{F5AEA86E-39D9-4735-A157-4223AD7B26E8}']
  end;
  TJPaintFlagsDrawFilter = class(TJavaGenericImport<JPaintFlagsDrawFilterClass, JPaintFlagsDrawFilter>) end;

  JPathClass = interface(JObjectClass)
    ['{15AA69AD-517A-4AD4-BB4E-129E32102F0C}']
    {class} function init: JPath; cdecl; overload;
    {class} function init(src: JPath): JPath; cdecl; overload;
  end;

  [JavaSignature('android/graphics/Path')]
  JPath = interface(JObject)
    ['{0E150B56-1B83-464A-A292-8B9C24E1E14F}']
    procedure addArc(oval: JRectF; startAngle: Single; sweepAngle: Single); cdecl; overload;
    procedure addArc(left: Single; top: Single; right: Single; bottom: Single; startAngle: Single; sweepAngle: Single); cdecl; overload;
    procedure addCircle(x: Single; y: Single; radius: Single; dir: JPath_Direction); cdecl;
    procedure addOval(oval: JRectF; dir: JPath_Direction); cdecl; overload;
    procedure addOval(left: Single; top: Single; right: Single; bottom: Single; dir: JPath_Direction); cdecl; overload;
    procedure addPath(src: JPath; dx: Single; dy: Single); cdecl; overload;
    procedure addPath(src: JPath); cdecl; overload;
    procedure addPath(src: JPath; matrix: JMatrix); cdecl; overload;
    procedure addRect(rect: JRectF; dir: JPath_Direction); cdecl; overload;
    procedure addRect(left: Single; top: Single; right: Single; bottom: Single; dir: JPath_Direction); cdecl; overload;
    procedure addRoundRect(rect: JRectF; rx: Single; ry: Single; dir: JPath_Direction); cdecl; overload;
    procedure addRoundRect(left: Single; top: Single; right: Single; bottom: Single; rx: Single; ry: Single; dir: JPath_Direction); cdecl; overload;
    procedure addRoundRect(rect: JRectF; radii: TJavaArray<Single>; dir: JPath_Direction); cdecl; overload;
    procedure addRoundRect(left: Single; top: Single; right: Single; bottom: Single; radii: TJavaArray<Single>; dir: JPath_Direction); cdecl; overload;
    procedure arcTo(oval: JRectF; startAngle: Single; sweepAngle: Single; forceMoveTo: Boolean); cdecl; overload;
    procedure arcTo(oval: JRectF; startAngle: Single; sweepAngle: Single); cdecl; overload;
    procedure arcTo(left: Single; top: Single; right: Single; bottom: Single; startAngle: Single; sweepAngle: Single; forceMoveTo: Boolean); cdecl; overload;
    procedure close; cdecl;
    procedure computeBounds(bounds: JRectF; exact: Boolean); cdecl;
    procedure cubicTo(x1: Single; y1: Single; x2: Single; y2: Single; x3: Single; y3: Single); cdecl;
    function getFillType: JPath_FillType; cdecl;
    procedure incReserve(extraPtCount: Integer); cdecl;
    function isConvex: Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function isInverseFillType: Boolean; cdecl;
    function isRect(rect: JRectF): Boolean; cdecl;
    procedure lineTo(x: Single; y: Single); cdecl;
    procedure moveTo(x: Single; y: Single); cdecl;
    procedure offset(dx: Single; dy: Single; dst: JPath); cdecl; overload;
    procedure offset(dx: Single; dy: Single); cdecl; overload;
    function op(path: JPath; op: JPath_Op): Boolean; cdecl; overload;
    function op(path1: JPath; path2: JPath; op: JPath_Op): Boolean; cdecl; overload;
    procedure quadTo(x1: Single; y1: Single; x2: Single; y2: Single); cdecl;
    procedure rCubicTo(x1: Single; y1: Single; x2: Single; y2: Single; x3: Single; y3: Single); cdecl;
    procedure rLineTo(dx: Single; dy: Single); cdecl;
    procedure rMoveTo(dx: Single; dy: Single); cdecl;
    procedure rQuadTo(dx1: Single; dy1: Single; dx2: Single; dy2: Single); cdecl;
    procedure reset; cdecl;
    procedure rewind; cdecl;
    procedure &set(src: JPath); cdecl;
    procedure setFillType(ft: JPath_FillType); cdecl;
    procedure setLastPoint(dx: Single; dy: Single); cdecl;
    procedure toggleInverseFillType; cdecl;
    procedure transform(matrix: JMatrix; dst: JPath); cdecl; overload;
    procedure transform(matrix: JMatrix); cdecl; overload;
  end;
  TJPath = class(TJavaGenericImport<JPathClass, JPath>) end;

  JPath_DirectionClass = interface(JEnumClass)
    ['{378CF43B-67A5-4193-946C-27B290D70734}']
    {class} function _GetCCW: JPath_Direction; cdecl;
    {class} function _GetCW: JPath_Direction; cdecl;
    {class} function valueOf(name: JString): JPath_Direction; cdecl;
    {class} function values: TJavaObjectArray<JPath_Direction>; cdecl;
    {class} property CCW: JPath_Direction read _GetCCW;
    {class} property CW: JPath_Direction read _GetCW;
  end;

  [JavaSignature('android/graphics/Path$Direction')]
  JPath_Direction = interface(JEnum)
    ['{74028FFA-4405-47D1-BB35-89BE6503E395}']
  end;
  TJPath_Direction = class(TJavaGenericImport<JPath_DirectionClass, JPath_Direction>) end;

  JPath_FillTypeClass = interface(JEnumClass)
    ['{73B4E1B8-E73B-4DBC-ADBF-BBF72F7FA7B3}']
    {class} function _GetEVEN_ODD: JPath_FillType; cdecl;
    {class} function _GetINVERSE_EVEN_ODD: JPath_FillType; cdecl;
    {class} function _GetINVERSE_WINDING: JPath_FillType; cdecl;
    {class} function _GetWINDING: JPath_FillType; cdecl;
    {class} function valueOf(name: JString): JPath_FillType; cdecl;
    {class} function values: TJavaObjectArray<JPath_FillType>; cdecl;
    {class} property EVEN_ODD: JPath_FillType read _GetEVEN_ODD;
    {class} property INVERSE_EVEN_ODD: JPath_FillType read _GetINVERSE_EVEN_ODD;
    {class} property INVERSE_WINDING: JPath_FillType read _GetINVERSE_WINDING;
    {class} property WINDING: JPath_FillType read _GetWINDING;
  end;

  [JavaSignature('android/graphics/Path$FillType')]
  JPath_FillType = interface(JEnum)
    ['{ECD8A84E-F5C5-4E25-83C2-A5A1BB932D65}']
  end;
  TJPath_FillType = class(TJavaGenericImport<JPath_FillTypeClass, JPath_FillType>) end;

  JPath_OpClass = interface(JEnumClass)
    ['{4F4971D8-621A-4135-8E8C-6288AC34F313}']
    {class} function _GetDIFFERENCE: JPath_Op; cdecl;
    {class} function _GetINTERSECT: JPath_Op; cdecl;
    {class} function _GetREVERSE_DIFFERENCE: JPath_Op; cdecl;
    {class} function _GetUNION: JPath_Op; cdecl;
    {class} function _GetXOR: JPath_Op; cdecl;
    {class} function valueOf(name: JString): JPath_Op; cdecl;
    {class} function values: TJavaObjectArray<JPath_Op>; cdecl;
    {class} property DIFFERENCE: JPath_Op read _GetDIFFERENCE;
    {class} property INTERSECT: JPath_Op read _GetINTERSECT;
    {class} property REVERSE_DIFFERENCE: JPath_Op read _GetREVERSE_DIFFERENCE;
    {class} property UNION: JPath_Op read _GetUNION;
    {class} property &XOR: JPath_Op read _GetXOR;
  end;

  [JavaSignature('android/graphics/Path$Op')]
  JPath_Op = interface(JEnum)
    ['{F6B58E66-CB67-4CF6-AD42-86274E35C59D}']
  end;
  TJPath_Op = class(TJavaGenericImport<JPath_OpClass, JPath_Op>) end;

  JPathDashPathEffectClass = interface(JPathEffectClass)
    ['{4AD7DE02-F54C-4AEE-A162-AFDF4C6E220C}']
    {class} function init(shape: JPath; advance: Single; phase: Single; style: JPathDashPathEffect_Style): JPathDashPathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/PathDashPathEffect')]
  JPathDashPathEffect = interface(JPathEffect)
    ['{411DA0F4-339D-41FF-95AB-8CF6B41115F5}']
  end;
  TJPathDashPathEffect = class(TJavaGenericImport<JPathDashPathEffectClass, JPathDashPathEffect>) end;

  JPathDashPathEffect_StyleClass = interface(JEnumClass)
    ['{F8000283-837E-4D79-AC7B-84BF67F48E7F}']
    {class} function _GetMORPH: JPathDashPathEffect_Style; cdecl;
    {class} function _GetROTATE: JPathDashPathEffect_Style; cdecl;
    {class} function _GetTRANSLATE: JPathDashPathEffect_Style; cdecl;
    {class} function valueOf(name: JString): JPathDashPathEffect_Style; cdecl;
    {class} function values: TJavaObjectArray<JPathDashPathEffect_Style>; cdecl;
    {class} property MORPH: JPathDashPathEffect_Style read _GetMORPH;
    {class} property ROTATE: JPathDashPathEffect_Style read _GetROTATE;
    {class} property TRANSLATE: JPathDashPathEffect_Style read _GetTRANSLATE;
  end;

  [JavaSignature('android/graphics/PathDashPathEffect$Style')]
  JPathDashPathEffect_Style = interface(JEnum)
    ['{60D9C29F-F11E-4325-9A20-F2403693B759}']
  end;
  TJPathDashPathEffect_Style = class(TJavaGenericImport<JPathDashPathEffect_StyleClass, JPathDashPathEffect_Style>) end;

  JPathMeasureClass = interface(JObjectClass)
    ['{405F5AC9-D234-4E67-A4FB-70917551A76C}']
    {class} function _GetPOSITION_MATRIX_FLAG: Integer; cdecl;
    {class} function _GetTANGENT_MATRIX_FLAG: Integer; cdecl;
    {class} function init: JPathMeasure; cdecl; overload;
    {class} function init(path: JPath; forceClosed: Boolean): JPathMeasure; cdecl; overload;
    {class} property POSITION_MATRIX_FLAG: Integer read _GetPOSITION_MATRIX_FLAG;
    {class} property TANGENT_MATRIX_FLAG: Integer read _GetTANGENT_MATRIX_FLAG;
  end;

  [JavaSignature('android/graphics/PathMeasure')]
  JPathMeasure = interface(JObject)
    ['{87A613BB-686A-44EB-BB91-D4D92576384A}']
    function getLength: Single; cdecl;
    function getMatrix(distance: Single; matrix: JMatrix; flags: Integer): Boolean; cdecl;
    function getPosTan(distance: Single; pos: TJavaArray<Single>; tan: TJavaArray<Single>): Boolean; cdecl;
    function getSegment(startD: Single; stopD: Single; dst: JPath; startWithMoveTo: Boolean): Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function nextContour: Boolean; cdecl;
    procedure setPath(path: JPath; forceClosed: Boolean); cdecl;
  end;
  TJPathMeasure = class(TJavaGenericImport<JPathMeasureClass, JPathMeasure>) end;

  JPictureClass = interface(JObjectClass)
    ['{61779B05-9E01-4AD7-A7B4-2B5EC8AF1FB5}']
    {class} function init: JPicture; cdecl; overload;
    {class} function init(src: JPicture): JPicture; cdecl; overload;
    {class} function createFromStream(stream: JInputStream): JPicture; cdecl;//Deprecated
  end;

  [JavaSignature('android/graphics/Picture')]
  JPicture = interface(JObject)
    ['{BE8841B4-DE7A-4399-ACBE-184B6C2F75AC}']
    function beginRecording(width: Integer; height: Integer): JCanvas; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    procedure endRecording; cdecl;
    function getHeight: Integer; cdecl;
    function getWidth: Integer; cdecl;
    procedure writeToStream(stream: JOutputStream); cdecl;//Deprecated
  end;
  TJPicture = class(TJavaGenericImport<JPictureClass, JPicture>) end;

  JPixelFormatClass = interface(JObjectClass)
    ['{3A069AE1-5A8C-4294-A6A9-AAB87656677C}']
    {class} function _GetA_8: Integer; cdecl;
    {class} function _GetJPEG: Integer; cdecl;
    {class} function _GetLA_88: Integer; cdecl;
    {class} function _GetL_8: Integer; cdecl;
    {class} function _GetOPAQUE: Integer; cdecl;
    {class} function _GetRGBA_4444: Integer; cdecl;
    {class} function _GetRGBA_5551: Integer; cdecl;
    {class} function _GetRGBA_8888: Integer; cdecl;
    {class} function _GetRGBX_8888: Integer; cdecl;
    {class} function _GetRGB_332: Integer; cdecl;
    {class} function _GetRGB_565: Integer; cdecl;
    {class} function _GetRGB_888: Integer; cdecl;
    {class} function _GetTRANSLUCENT: Integer; cdecl;
    {class} function _GetTRANSPARENT: Integer; cdecl;
    {class} function _GetUNKNOWN: Integer; cdecl;
    {class} function _GetYCbCr_420_SP: Integer; cdecl;
    {class} function _GetYCbCr_422_I: Integer; cdecl;
    {class} function _GetYCbCr_422_SP: Integer; cdecl;
    {class} function init: JPixelFormat; cdecl;
    {class} function formatHasAlpha(format: Integer): Boolean; cdecl;
    {class} procedure getPixelFormatInfo(format: Integer; info: JPixelFormat); cdecl;
    {class} property A_8: Integer read _GetA_8;
    {class} property JPEG: Integer read _GetJPEG;
    {class} property LA_88: Integer read _GetLA_88;
    {class} property L_8: Integer read _GetL_8;
    {class} property OPAQUE: Integer read _GetOPAQUE;
    {class} property RGBA_4444: Integer read _GetRGBA_4444;
    {class} property RGBA_5551: Integer read _GetRGBA_5551;
    {class} property RGBA_8888: Integer read _GetRGBA_8888;
    {class} property RGBX_8888: Integer read _GetRGBX_8888;
    {class} property RGB_332: Integer read _GetRGB_332;
    {class} property RGB_565: Integer read _GetRGB_565;
    {class} property RGB_888: Integer read _GetRGB_888;
    {class} property TRANSLUCENT: Integer read _GetTRANSLUCENT;
    {class} property TRANSPARENT: Integer read _GetTRANSPARENT;
    {class} property UNKNOWN: Integer read _GetUNKNOWN;
    {class} property YCbCr_420_SP: Integer read _GetYCbCr_420_SP;
    {class} property YCbCr_422_I: Integer read _GetYCbCr_422_I;
    {class} property YCbCr_422_SP: Integer read _GetYCbCr_422_SP;
  end;

  [JavaSignature('android/graphics/PixelFormat')]
  JPixelFormat = interface(JObject)
    ['{09E8682B-A994-438B-BB64-F3C0F54C84AC}']
    function _GetbitsPerPixel: Integer; cdecl;
    procedure _SetbitsPerPixel(Value: Integer); cdecl;
    function _GetbytesPerPixel: Integer; cdecl;
    procedure _SetbytesPerPixel(Value: Integer); cdecl;
    property bitsPerPixel: Integer read _GetbitsPerPixel write _SetbitsPerPixel;
    property bytesPerPixel: Integer read _GetbytesPerPixel write _SetbytesPerPixel;
  end;
  TJPixelFormat = class(TJavaGenericImport<JPixelFormatClass, JPixelFormat>) end;

  JPixelXorXfermodeClass = interface(JXfermodeClass)
    ['{72F979E0-EC9B-4387-95A1-BA245CDE4310}']
    {class} function init(opColor: Integer): JPixelXorXfermode; cdecl;
  end;

  [JavaSignature('android/graphics/PixelXorXfermode')]
  JPixelXorXfermode = interface(JXfermode)
    ['{8BA08395-74DA-486A-9B9B-F76894D1EBDE}']
  end;
  TJPixelXorXfermode = class(TJavaGenericImport<JPixelXorXfermodeClass, JPixelXorXfermode>) end;

  JPointClass = interface(JObjectClass)
    ['{61361EC3-509A-4566-BB60-B66834DB7612}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JPoint; cdecl; overload;
    {class} function init(x: Integer; y: Integer): JPoint; cdecl; overload;
    {class} function init(src: JPoint): JPoint; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/graphics/Point')]
  JPoint = interface(JObject)
    ['{E85805BB-5295-4924-A804-07D93814DD1E}']
    function _Getx: Integer; cdecl;
    procedure _Setx(Value: Integer); cdecl;
    function _Gety: Integer; cdecl;
    procedure _Sety(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function equals(x: Integer; y: Integer): Boolean; cdecl; overload;
    function equals(o: JObject): Boolean; cdecl; overload;
    function hashCode: Integer; cdecl;
    procedure negate; cdecl;
    procedure offset(dx: Integer; dy: Integer); cdecl;
    procedure readFromParcel(in_: JParcel); cdecl;
    procedure &set(x: Integer; y: Integer); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property x: Integer read _Getx write _Setx;
    property y: Integer read _Gety write _Sety;
  end;
  TJPoint = class(TJavaGenericImport<JPointClass, JPoint>) end;

  JPointFClass = interface(JObjectClass)
    ['{24275084-F838-4B34-9608-C8B50B17EE8C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JPointF; cdecl; overload;
    {class} function init(x: Single; y: Single): JPointF; cdecl; overload;
    {class} function init(p: JPoint): JPointF; cdecl; overload;
    {class} function length(x: Single; y: Single): Single; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/graphics/PointF')]
  JPointF = interface(JObject)
    ['{73BB8B8D-2F0D-45A3-8D1F-2513B931C282}']
    function _Getx: Single; cdecl;
    procedure _Setx(Value: Single); cdecl;
    function _Gety: Single; cdecl;
    procedure _Sety(Value: Single); cdecl;
    function describeContents: Integer; cdecl;
    function equals(x: Single; y: Single): Boolean; cdecl; overload;
    function equals(o: JObject): Boolean; cdecl; overload;
    function hashCode: Integer; cdecl;
    function length: Single; cdecl; overload;
    procedure negate; cdecl;
    procedure offset(dx: Single; dy: Single); cdecl;
    procedure readFromParcel(in_: JParcel); cdecl;
    procedure &set(x: Single; y: Single); cdecl; overload;
    procedure &set(p: JPointF); cdecl; overload;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property x: Single read _Getx write _Setx;
    property y: Single read _Gety write _Sety;
  end;
  TJPointF = class(TJavaGenericImport<JPointFClass, JPointF>) end;

  JPorterDuffClass = interface(JObjectClass)
    ['{D017DF20-908A-468F-86FB-FCEC628BE8CB}']
    {class} function init: JPorterDuff; cdecl;
  end;

  [JavaSignature('android/graphics/PorterDuff')]
  JPorterDuff = interface(JObject)
    ['{1E3AFE84-D0AA-4365-A719-D53CE6E9D8EC}']
  end;
  TJPorterDuff = class(TJavaGenericImport<JPorterDuffClass, JPorterDuff>) end;

  JPorterDuff_ModeClass = interface(JEnumClass)
    ['{AF28263D-7D2E-4F7D-8E23-7DBACB480EB5}']
    {class} function _GetADD: JPorterDuff_Mode; cdecl;
    {class} function _GetCLEAR: JPorterDuff_Mode; cdecl;
    {class} function _GetDARKEN: JPorterDuff_Mode; cdecl;
    {class} function _GetDST: JPorterDuff_Mode; cdecl;
    {class} function _GetDST_ATOP: JPorterDuff_Mode; cdecl;
    {class} function _GetDST_IN: JPorterDuff_Mode; cdecl;
    {class} function _GetDST_OUT: JPorterDuff_Mode; cdecl;
    {class} function _GetDST_OVER: JPorterDuff_Mode; cdecl;
    {class} function _GetLIGHTEN: JPorterDuff_Mode; cdecl;
    {class} function _GetMULTIPLY: JPorterDuff_Mode; cdecl;
    {class} function _GetOVERLAY: JPorterDuff_Mode; cdecl;
    {class} function _GetSCREEN: JPorterDuff_Mode; cdecl;
    {class} function _GetSRC: JPorterDuff_Mode; cdecl;
    {class} function _GetSRC_ATOP: JPorterDuff_Mode; cdecl;
    {class} function _GetSRC_IN: JPorterDuff_Mode; cdecl;
    {class} function _GetSRC_OUT: JPorterDuff_Mode; cdecl;
    {class} function _GetSRC_OVER: JPorterDuff_Mode; cdecl;
    {class} function _GetXOR: JPorterDuff_Mode; cdecl;
    {class} function valueOf(name: JString): JPorterDuff_Mode; cdecl;
    {class} function values: TJavaObjectArray<JPorterDuff_Mode>; cdecl;
    {class} property ADD: JPorterDuff_Mode read _GetADD;
    {class} property CLEAR: JPorterDuff_Mode read _GetCLEAR;
    {class} property DARKEN: JPorterDuff_Mode read _GetDARKEN;
    {class} property DST: JPorterDuff_Mode read _GetDST;
    {class} property DST_ATOP: JPorterDuff_Mode read _GetDST_ATOP;
    {class} property DST_IN: JPorterDuff_Mode read _GetDST_IN;
    {class} property DST_OUT: JPorterDuff_Mode read _GetDST_OUT;
    {class} property DST_OVER: JPorterDuff_Mode read _GetDST_OVER;
    {class} property LIGHTEN: JPorterDuff_Mode read _GetLIGHTEN;
    {class} property MULTIPLY: JPorterDuff_Mode read _GetMULTIPLY;
    {class} property OVERLAY: JPorterDuff_Mode read _GetOVERLAY;
    {class} property SCREEN: JPorterDuff_Mode read _GetSCREEN;
    {class} property SRC: JPorterDuff_Mode read _GetSRC;
    {class} property SRC_ATOP: JPorterDuff_Mode read _GetSRC_ATOP;
    {class} property SRC_IN: JPorterDuff_Mode read _GetSRC_IN;
    {class} property SRC_OUT: JPorterDuff_Mode read _GetSRC_OUT;
    {class} property SRC_OVER: JPorterDuff_Mode read _GetSRC_OVER;
    {class} property &XOR: JPorterDuff_Mode read _GetXOR;
  end;

  [JavaSignature('android/graphics/PorterDuff$Mode')]
  JPorterDuff_Mode = interface(JEnum)
    ['{BB12CE91-1F0C-4B3B-9910-ACF2BDB39B4A}']
  end;
  TJPorterDuff_Mode = class(TJavaGenericImport<JPorterDuff_ModeClass, JPorterDuff_Mode>) end;

  JPorterDuffColorFilterClass = interface(JColorFilterClass)
    ['{60E5736C-B182-400C-942B-D86A7231FB74}']
    {class} function init(color: Integer; mode: JPorterDuff_Mode): JPorterDuffColorFilter; cdecl;
  end;

  [JavaSignature('android/graphics/PorterDuffColorFilter')]
  JPorterDuffColorFilter = interface(JColorFilter)
    ['{EDDC13E8-0D20-4AEA-9CC9-2E4CED3384CD}']
    function equals(object_: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
  end;
  TJPorterDuffColorFilter = class(TJavaGenericImport<JPorterDuffColorFilterClass, JPorterDuffColorFilter>) end;

  JPorterDuffXfermodeClass = interface(JXfermodeClass)
    ['{7D0DA4F2-299C-4A9A-96D5-D8739FE0CC20}']
    {class} function init(mode: JPorterDuff_Mode): JPorterDuffXfermode; cdecl;
  end;

  [JavaSignature('android/graphics/PorterDuffXfermode')]
  JPorterDuffXfermode = interface(JXfermode)
    ['{3BC0F433-1C7A-4E85-9246-89F54356FABD}']
  end;
  TJPorterDuffXfermode = class(TJavaGenericImport<JPorterDuffXfermodeClass, JPorterDuffXfermode>) end;

  JRadialGradientClass = interface(JShaderClass)
    ['{CB0B2E63-9E6F-41E5-88F9-1816ECAC7A71}']
    {class} function init(centerX: Single; centerY: Single; radius: Single; colors: TJavaArray<Integer>; stops: TJavaArray<Single>; tileMode: JShader_TileMode): JRadialGradient; cdecl; overload;
    {class} function init(centerX: Single; centerY: Single; radius: Single; centerColor: Integer; edgeColor: Integer; tileMode: JShader_TileMode): JRadialGradient; cdecl; overload;
  end;

  [JavaSignature('android/graphics/RadialGradient')]
  JRadialGradient = interface(JShader)
    ['{17F8C6B7-F5BA-420C-8966-E92CD280D66A}']
  end;
  TJRadialGradient = class(TJavaGenericImport<JRadialGradientClass, JRadialGradient>) end;

  JRectClass = interface(JObjectClass)
    ['{8D5B11EB-2267-4991-A011-298C12EE0B34}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JRect; cdecl; overload;
    {class} function init(left: Integer; top: Integer; right: Integer; bottom: Integer): JRect; cdecl; overload;
    {class} function init(r: JRect): JRect; cdecl; overload;
    {class} function intersects(a: JRect; b: JRect): Boolean; cdecl; overload;
    {class} function unflattenFromString(str: JString): JRect; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/graphics/Rect')]
  JRect = interface(JObject)
    ['{E5D89D45-DCA4-4805-BF55-B6BE7CE968C0}']
    function _Getbottom: Integer; cdecl;
    procedure _Setbottom(Value: Integer); cdecl;
    function _Getleft: Integer; cdecl;
    procedure _Setleft(Value: Integer); cdecl;
    function _Getright: Integer; cdecl;
    procedure _Setright(Value: Integer); cdecl;
    function _Gettop: Integer; cdecl;
    procedure _Settop(Value: Integer); cdecl;
    function centerX: Integer; cdecl;
    function centerY: Integer; cdecl;
    function &contains(x: Integer; y: Integer): Boolean; cdecl; overload;
    function &contains(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    function &contains(r: JRect): Boolean; cdecl; overload;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function exactCenterX: Single; cdecl;
    function exactCenterY: Single; cdecl;
    function flattenToString: JString; cdecl;
    function hashCode: Integer; cdecl;
    function height: Integer; cdecl;
    procedure inset(dx: Integer; dy: Integer); cdecl;
    function intersect(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    function intersect(r: JRect): Boolean; cdecl; overload;
    function intersects(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    function isEmpty: Boolean; cdecl;
    procedure offset(dx: Integer; dy: Integer); cdecl;
    procedure offsetTo(newLeft: Integer; newTop: Integer); cdecl;
    procedure readFromParcel(in_: JParcel); cdecl;
    procedure &set(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure &set(src: JRect); cdecl; overload;
    procedure setEmpty; cdecl;
    function setIntersect(a: JRect; b: JRect): Boolean; cdecl;
    procedure sort; cdecl;
    function toShortString: JString; cdecl;
    function toString: JString; cdecl;
    procedure union(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure union(r: JRect); cdecl; overload;
    procedure union(x: Integer; y: Integer); cdecl; overload;
    function width: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property bottom: Integer read _Getbottom write _Setbottom;
    property left: Integer read _Getleft write _Setleft;
    property right: Integer read _Getright write _Setright;
    property top: Integer read _Gettop write _Settop;
  end;
  TJRect = class(TJavaGenericImport<JRectClass, JRect>) end;

  JRectFClass = interface(JObjectClass)
    ['{70E49C38-BAB4-4BDA-9B00-03F5C269F3A5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JRectF; cdecl; overload;
    {class} function init(left: Single; top: Single; right: Single; bottom: Single): JRectF; cdecl; overload;
    {class} function init(r: JRectF): JRectF; cdecl; overload;
    {class} function init(r: JRect): JRectF; cdecl; overload;
    {class} function intersects(a: JRectF; b: JRectF): Boolean; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/graphics/RectF')]
  JRectF = interface(JObject)
    ['{44C699AF-A015-4109-B6F0-30F2F7A54410}']
    function _Getbottom: Single; cdecl;
    procedure _Setbottom(Value: Single); cdecl;
    function _Getleft: Single; cdecl;
    procedure _Setleft(Value: Single); cdecl;
    function _Getright: Single; cdecl;
    procedure _Setright(Value: Single); cdecl;
    function _Gettop: Single; cdecl;
    procedure _Settop(Value: Single); cdecl;
    function centerX: Single; cdecl;
    function centerY: Single; cdecl;
    function &contains(x: Single; y: Single): Boolean; cdecl; overload;
    function &contains(left: Single; top: Single; right: Single; bottom: Single): Boolean; cdecl; overload;
    function &contains(r: JRectF): Boolean; cdecl; overload;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function height: Single; cdecl;
    procedure inset(dx: Single; dy: Single); cdecl;
    function intersect(left: Single; top: Single; right: Single; bottom: Single): Boolean; cdecl; overload;
    function intersect(r: JRectF): Boolean; cdecl; overload;
    function intersects(left: Single; top: Single; right: Single; bottom: Single): Boolean; cdecl; overload;
    function isEmpty: Boolean; cdecl;
    procedure offset(dx: Single; dy: Single); cdecl;
    procedure offsetTo(newLeft: Single; newTop: Single); cdecl;
    procedure readFromParcel(in_: JParcel); cdecl;
    procedure round(dst: JRect); cdecl;
    procedure roundOut(dst: JRect); cdecl;
    procedure &set(left: Single; top: Single; right: Single; bottom: Single); cdecl; overload;
    procedure &set(src: JRectF); cdecl; overload;
    procedure &set(src: JRect); cdecl; overload;
    procedure setEmpty; cdecl;
    function setIntersect(a: JRectF; b: JRectF): Boolean; cdecl;
    procedure sort; cdecl;
    function toShortString: JString; cdecl;
    function toString: JString; cdecl;
    procedure union(left: Single; top: Single; right: Single; bottom: Single); cdecl; overload;
    procedure union(r: JRectF); cdecl; overload;
    procedure union(x: Single; y: Single); cdecl; overload;
    function width: Single; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property bottom: Single read _Getbottom write _Setbottom;
    property left: Single read _Getleft write _Setleft;
    property right: Single read _Getright write _Setright;
    property top: Single read _Gettop write _Settop;
  end;
  TJRectF = class(TJavaGenericImport<JRectFClass, JRectF>) end;

  JRegionClass = interface(JObjectClass)
    ['{53503A08-DB57-45F2-8DEB-C728DC2749AD}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JRegion; cdecl; overload;
    {class} function init(region: JRegion): JRegion; cdecl; overload;
    {class} function init(r: JRect): JRegion; cdecl; overload;
    {class} function init(left: Integer; top: Integer; right: Integer; bottom: Integer): JRegion; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/graphics/Region')]
  JRegion = interface(JObject)
    ['{7CEA0E0F-4559-48D7-8C5F-9528722D5E7D}']
    function &contains(x: Integer; y: Integer): Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getBoundaryPath: JPath; cdecl; overload;
    function getBoundaryPath(path: JPath): Boolean; cdecl; overload;
    function getBounds: JRect; cdecl; overload;
    function getBounds(r: JRect): Boolean; cdecl; overload;
    function isComplex: Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function isRect: Boolean; cdecl;
    function op(r: JRect; op: JRegion_Op): Boolean; cdecl; overload;
    function op(left: Integer; top: Integer; right: Integer; bottom: Integer; op: JRegion_Op): Boolean; cdecl; overload;
    function op(region: JRegion; op: JRegion_Op): Boolean; cdecl; overload;
    function op(rect: JRect; region: JRegion; op: JRegion_Op): Boolean; cdecl; overload;
    function op(region1: JRegion; region2: JRegion; op: JRegion_Op): Boolean; cdecl; overload;
    function quickContains(r: JRect): Boolean; cdecl; overload;
    function quickContains(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    function quickReject(r: JRect): Boolean; cdecl; overload;
    function quickReject(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    function quickReject(rgn: JRegion): Boolean; cdecl; overload;
    function &set(region: JRegion): Boolean; cdecl; overload;
    function &set(r: JRect): Boolean; cdecl; overload;
    function &set(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl; overload;
    procedure setEmpty; cdecl;
    function setPath(path: JPath; clip: JRegion): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure translate(dx: Integer; dy: Integer); cdecl; overload;
    procedure translate(dx: Integer; dy: Integer; dst: JRegion); cdecl; overload;
    function union(r: JRect): Boolean; cdecl;
    procedure writeToParcel(p: JParcel; flags: Integer); cdecl;
  end;
  TJRegion = class(TJavaGenericImport<JRegionClass, JRegion>) end;

  JRegion_OpClass = interface(JEnumClass)
    ['{D3BC078B-CC50-4546-8ADD-DD1DA8DF5B7B}']
    {class} function _GetDIFFERENCE: JRegion_Op; cdecl;
    {class} function _GetINTERSECT: JRegion_Op; cdecl;
    {class} function _GetREPLACE: JRegion_Op; cdecl;
    {class} function _GetREVERSE_DIFFERENCE: JRegion_Op; cdecl;
    {class} function _GetUNION: JRegion_Op; cdecl;
    {class} function _GetXOR: JRegion_Op; cdecl;
    {class} function valueOf(name: JString): JRegion_Op; cdecl;
    {class} function values: TJavaObjectArray<JRegion_Op>; cdecl;
    {class} property DIFFERENCE: JRegion_Op read _GetDIFFERENCE;
    {class} property INTERSECT: JRegion_Op read _GetINTERSECT;
    {class} property REPLACE: JRegion_Op read _GetREPLACE;
    {class} property REVERSE_DIFFERENCE: JRegion_Op read _GetREVERSE_DIFFERENCE;
    {class} property UNION: JRegion_Op read _GetUNION;
    {class} property &XOR: JRegion_Op read _GetXOR;
  end;

  [JavaSignature('android/graphics/Region$Op')]
  JRegion_Op = interface(JEnum)
    ['{47159EE4-0384-467B-9F11-04DF089D9431}']
  end;
  TJRegion_Op = class(TJavaGenericImport<JRegion_OpClass, JRegion_Op>) end;

  JRegionIteratorClass = interface(JObjectClass)
    ['{A98F661A-961F-43E5-9B0D-B2D9ADD717AA}']
    {class} function init(region: JRegion): JRegionIterator; cdecl;
  end;

  [JavaSignature('android/graphics/RegionIterator')]
  JRegionIterator = interface(JObject)
    ['{D48A2745-3ECF-4FC9-B6E8-EF93534C98BB}']
    function next(r: JRect): Boolean; cdecl;
  end;
  TJRegionIterator = class(TJavaGenericImport<JRegionIteratorClass, JRegionIterator>) end;

  JShader_TileModeClass = interface(JEnumClass)
    ['{79478EFD-F336-4317-9E61-102DBBA54973}']
    {class} function _GetCLAMP: JShader_TileMode; cdecl;
    {class} function _GetMIRROR: JShader_TileMode; cdecl;
    {class} function _GetREPEAT: JShader_TileMode; cdecl;
    {class} function valueOf(name: JString): JShader_TileMode; cdecl;
    {class} function values: TJavaObjectArray<JShader_TileMode>; cdecl;
    {class} property CLAMP: JShader_TileMode read _GetCLAMP;
    {class} property MIRROR: JShader_TileMode read _GetMIRROR;
    {class} property &REPEAT: JShader_TileMode read _GetREPEAT;
  end;

  [JavaSignature('android/graphics/Shader$TileMode')]
  JShader_TileMode = interface(JEnum)
    ['{A98BD682-AE2D-4FFB-8971-C1239E5779BC}']
  end;
  TJShader_TileMode = class(TJavaGenericImport<JShader_TileModeClass, JShader_TileMode>) end;

  JSumPathEffectClass = interface(JPathEffectClass)
    ['{71F21540-5C34-4BF7-BD0A-3751401D0E7A}']
    {class} function init(first: JPathEffect; second: JPathEffect): JSumPathEffect; cdecl;
  end;

  [JavaSignature('android/graphics/SumPathEffect')]
  JSumPathEffect = interface(JPathEffect)
    ['{5E43867D-8903-47C9-A653-CE79CD40E9B9}']
  end;
  TJSumPathEffect = class(TJavaGenericImport<JSumPathEffectClass, JSumPathEffect>) end;

  JSurfaceTextureClass = interface(JObjectClass)
    ['{E65AB583-F23C-4A17-8246-3B30FE16F300}']
    {class} function init(texName: Integer): JSurfaceTexture; cdecl; overload;
    {class} function init(texName: Integer; singleBufferMode: Boolean): JSurfaceTexture; cdecl; overload;
  end;

  [JavaSignature('android/graphics/SurfaceTexture')]
  JSurfaceTexture = interface(JObject)
    ['{270948EE-C26E-49F4-835E-BB7A23613999}']
    procedure attachToGLContext(texName: Integer); cdecl;
    procedure detachFromGLContext; cdecl;
    function getTimestamp: Int64; cdecl;
    procedure getTransformMatrix(mtx: TJavaArray<Single>); cdecl;
    procedure release; cdecl;
    procedure releaseTexImage; cdecl;
    procedure setDefaultBufferSize(width: Integer; height: Integer); cdecl;
    procedure setOnFrameAvailableListener(listener: JSurfaceTexture_OnFrameAvailableListener); cdecl; overload;
    procedure setOnFrameAvailableListener(listener: JSurfaceTexture_OnFrameAvailableListener; handler: JHandler); cdecl; overload;
    procedure updateTexImage; cdecl;
  end;
  TJSurfaceTexture = class(TJavaGenericImport<JSurfaceTextureClass, JSurfaceTexture>) end;

  JSurfaceTexture_OnFrameAvailableListenerClass = interface(IJavaClass)
    ['{DC4394C7-850D-48C7-8C48-3A69DADB3F4E}']
  end;

  [JavaSignature('android/graphics/SurfaceTexture$OnFrameAvailableListener')]
  JSurfaceTexture_OnFrameAvailableListener = interface(IJavaInstance)
    ['{7C82FB69-874D-4DA8-A789-E78F0AB4F4DA}']
    procedure onFrameAvailable(surfaceTexture: JSurfaceTexture); cdecl;
  end;
  TJSurfaceTexture_OnFrameAvailableListener = class(TJavaGenericImport<JSurfaceTexture_OnFrameAvailableListenerClass, JSurfaceTexture_OnFrameAvailableListener>) end;

  JSurfaceTexture_OutOfResourcesExceptionClass = interface(JExceptionClass)
    ['{115BC5D2-1F30-4911-A0AD-F2F62EF96551}']
    {class} function init: JSurfaceTexture_OutOfResourcesException; cdecl; overload;
    {class} function init(name: JString): JSurfaceTexture_OutOfResourcesException; cdecl; overload;
  end;

  [JavaSignature('android/graphics/SurfaceTexture$OutOfResourcesException')]
  JSurfaceTexture_OutOfResourcesException = interface(JException)
    ['{76C8E3F6-A92E-435E-A016-27C43EE8D73F}']
  end;
  TJSurfaceTexture_OutOfResourcesException = class(TJavaGenericImport<JSurfaceTexture_OutOfResourcesExceptionClass, JSurfaceTexture_OutOfResourcesException>) end;

  JSweepGradientClass = interface(JShaderClass)
    ['{13878C2C-C9DC-4A09-AD53-0383CA0A482A}']
    {class} function init(cx: Single; cy: Single; colors: TJavaArray<Integer>; positions: TJavaArray<Single>): JSweepGradient; cdecl; overload;
    {class} function init(cx: Single; cy: Single; color0: Integer; color1: Integer): JSweepGradient; cdecl; overload;
  end;

  [JavaSignature('android/graphics/SweepGradient')]
  JSweepGradient = interface(JShader)
    ['{177E973D-2CF6-4583-A666-84297F17604D}']
  end;
  TJSweepGradient = class(TJavaGenericImport<JSweepGradientClass, JSweepGradient>) end;

  JTypefaceClass = interface(JObjectClass)
    ['{4F012009-BA52-43D2-9B95-18833CF3F090}']
    {class} function _GetBOLD: Integer; cdecl;
    {class} function _GetBOLD_ITALIC: Integer; cdecl;
    {class} function _GetDEFAULT: JTypeface; cdecl;
    {class} function _GetDEFAULT_BOLD: JTypeface; cdecl;
    {class} function _GetITALIC: Integer; cdecl;
    {class} function _GetMONOSPACE: JTypeface; cdecl;
    {class} function _GetNORMAL: Integer; cdecl;
    {class} function _GetSANS_SERIF: JTypeface; cdecl;
    {class} function _GetSERIF: JTypeface; cdecl;
    {class} function create(familyName: JString; style: Integer): JTypeface; cdecl; overload;
    {class} function create(family: JTypeface; style: Integer): JTypeface; cdecl; overload;
    {class} function createFromAsset(mgr: JAssetManager; path: JString): JTypeface; cdecl;
    {class} function createFromFile(path: JFile): JTypeface; cdecl; overload;
    {class} function createFromFile(path: JString): JTypeface; cdecl; overload;
    {class} function defaultFromStyle(style: Integer): JTypeface; cdecl;
    {class} property BOLD: Integer read _GetBOLD;
    {class} property BOLD_ITALIC: Integer read _GetBOLD_ITALIC;
    {class} property DEFAULT: JTypeface read _GetDEFAULT;
    {class} property DEFAULT_BOLD: JTypeface read _GetDEFAULT_BOLD;
    {class} property ITALIC: Integer read _GetITALIC;
    {class} property MONOSPACE: JTypeface read _GetMONOSPACE;
    {class} property NORMAL: Integer read _GetNORMAL;
    {class} property SANS_SERIF: JTypeface read _GetSANS_SERIF;
    {class} property SERIF: JTypeface read _GetSERIF;
  end;

  [JavaSignature('android/graphics/Typeface')]
  JTypeface = interface(JObject)
    ['{7D5C8025-19B6-46B1-A86D-3539C26F7D11}']
    function equals(o: JObject): Boolean; cdecl;
    function getStyle: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isBold: Boolean; cdecl;
    function isItalic: Boolean; cdecl;
  end;
  TJTypeface = class(TJavaGenericImport<JTypefaceClass, JTypeface>) end;

  JYuvImageClass = interface(JObjectClass)
    ['{55F960E0-1DB5-40BA-B289-389C8EBC820D}']
    {class} function init(yuv: TJavaArray<Byte>; format: Integer; width: Integer; height: Integer; strides: TJavaArray<Integer>): JYuvImage; cdecl;
  end;

  [JavaSignature('android/graphics/YuvImage')]
  JYuvImage = interface(JObject)
    ['{5A3F0577-3F67-4ABF-94EF-3438EEAE8720}']
    function compressToJpeg(rectangle: JRect; quality: Integer; stream: JOutputStream): Boolean; cdecl;
    function getHeight: Integer; cdecl;
    function getStrides: TJavaArray<Integer>; cdecl;
    function getWidth: Integer; cdecl;
    function getYuvData: TJavaArray<Byte>; cdecl;
    function getYuvFormat: Integer; cdecl;
  end;
  TJYuvImage = class(TJavaGenericImport<JYuvImageClass, JYuvImage>) end;

  JAnimatableClass = interface(IJavaClass)
    ['{BC82CC78-6570-4A20-A902-78659365B695}']
  end;

  [JavaSignature('android/graphics/drawable/Animatable')]
  JAnimatable = interface(IJavaInstance)
    ['{FA61E2CC-0AC9-44D8-A303-8646A8305230}']
    function isRunning: Boolean; cdecl;
    procedure start; cdecl;
    procedure stop; cdecl;
  end;
  TJAnimatable = class(TJavaGenericImport<JAnimatableClass, JAnimatable>) end;

  JAnimatable2Class = interface(JAnimatableClass)
    ['{D281BEB5-9456-49A0-8F5C-F4D0715346EA}']
  end;

  [JavaSignature('android/graphics/drawable/Animatable2')]
  JAnimatable2 = interface(JAnimatable)
    ['{E933B642-B990-4ADE-ACD6-205348E5A81E}']
    procedure clearAnimationCallbacks; cdecl;
    procedure registerAnimationCallback(callback: JAnimatable2_AnimationCallback); cdecl;
    function unregisterAnimationCallback(callback: JAnimatable2_AnimationCallback): Boolean; cdecl;
  end;
  TJAnimatable2 = class(TJavaGenericImport<JAnimatable2Class, JAnimatable2>) end;

  JAnimatable2_AnimationCallbackClass = interface(JObjectClass)
    ['{35788A42-19C5-4A9B-AA29-D0941EC87664}']
    {class} function init: JAnimatable2_AnimationCallback; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/Animatable2$AnimationCallback')]
  JAnimatable2_AnimationCallback = interface(JObject)
    ['{D9E0B433-C938-404A-89CF-62B3D55E2AFC}']
    procedure onAnimationEnd(drawable: JDrawable); cdecl;
    procedure onAnimationStart(drawable: JDrawable); cdecl;
  end;
  TJAnimatable2_AnimationCallback = class(TJavaGenericImport<JAnimatable2_AnimationCallbackClass, JAnimatable2_AnimationCallback>) end;

  JDrawableClass = interface(JObjectClass)
    ['{65629D6B-EE84-4012-8A99-80CA18343BE7}']
    {class} function init: JDrawable; cdecl;
    {class} function createFromPath(pathName: JString): JDrawable; cdecl;
    {class} function createFromResourceStream(res: JResources; value: JTypedValue; is_: JInputStream; srcName: JString): JDrawable; cdecl; overload;
    {class} function createFromResourceStream(res: JResources; value: JTypedValue; is_: JInputStream; srcName: JString; opts: JBitmapFactory_Options): JDrawable; cdecl; overload;
    {class} function createFromStream(is_: JInputStream; srcName: JString): JDrawable; cdecl;
    {class} function createFromXml(r: JResources; parser: JXmlPullParser): JDrawable; cdecl; overload;
    {class} function createFromXml(r: JResources; parser: JXmlPullParser; theme: JResources_Theme): JDrawable; cdecl; overload;
    {class} function createFromXmlInner(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet): JDrawable; cdecl; overload;
    {class} function createFromXmlInner(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme): JDrawable; cdecl; overload;
    {class} function resolveOpacity(op1: Integer; op2: Integer): Integer; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/Drawable')]
  JDrawable = interface(JObject)
    ['{063DF683-9F17-4BA2-96C8-B98246BDB114}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure clearColorFilter; cdecl;
    procedure copyBounds(bounds: JRect); cdecl; overload;
    function copyBounds: JRect; cdecl; overload;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getBounds: JRect; cdecl;
    function getCallback: JDrawable_Callback; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColorFilter: JColorFilter; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getCurrent: JDrawable; cdecl;
    function getDirtyBounds: JRect; cdecl;
    procedure getHotspotBounds(outRect: JRect); cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getLayoutDirection: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function getMinimumHeight: Integer; cdecl;
    function getMinimumWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    function getState: TJavaArray<Integer>; cdecl;
    function getTransparentRegion: JRegion; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet); cdecl; overload;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl; overload;
    procedure invalidateSelf; cdecl;
    function isAutoMirrored: Boolean; cdecl;
    function isFilterBitmap: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    procedure jumpToCurrentState; cdecl;
    function mutate: JDrawable; cdecl;
    function onLayoutDirectionChanged(layoutDirection: Integer): Boolean; cdecl;
    procedure scheduleSelf(what: JRunnable; when: Int64); cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setAutoMirrored(mirrored: Boolean); cdecl;
    procedure setBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure setBounds(bounds: JRect); cdecl; overload;
    procedure setCallback(cb: JDrawable_Callback); cdecl;
    procedure setChangingConfigurations(configs: Integer); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl; overload;
    procedure setColorFilter(color: Integer; mode: JPorterDuff_Mode); cdecl; overload;
    procedure setDither(dither: Boolean); cdecl;//Deprecated
    procedure setFilterBitmap(filter: Boolean); cdecl;
    procedure setHotspot(x: Single; y: Single); cdecl;
    procedure setHotspotBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    function setLayoutDirection(layoutDirection: Integer): Boolean; cdecl;
    function setLevel(level: Integer): Boolean; cdecl;
    function setState(stateSet: TJavaArray<Integer>): Boolean; cdecl;
    procedure setTint(tintColor: Integer); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
    procedure unscheduleSelf(what: JRunnable); cdecl;
  end;
  TJDrawable = class(TJavaGenericImport<JDrawableClass, JDrawable>) end;

  JDrawableContainerClass = interface(JDrawableClass)
    ['{DA9B07EB-62A2-42BC-A734-B8353978095A}']
    {class} function init: JDrawableContainer; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/DrawableContainer')]
  JDrawableContainer = interface(JDrawable)
    ['{69501A34-A3A1-4738-BF7E-756C55E465EA}']
    procedure applyTheme(theme: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getCurrent: JDrawable; cdecl;
    procedure getHotspotBounds(outRect: JRect); cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getMinimumHeight: Integer; cdecl;
    function getMinimumWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    procedure invalidateDrawable(who: JDrawable); cdecl;
    function isAutoMirrored: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    procedure jumpToCurrentState; cdecl;
    function mutate: JDrawable; cdecl;
    function onLayoutDirectionChanged(layoutDirection: Integer): Boolean; cdecl;
    procedure scheduleDrawable(who: JDrawable; what: JRunnable; when: Int64); cdecl;
    function selectDrawable(idx: Integer): Boolean; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setAutoMirrored(mirrored: Boolean); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setEnterFadeDuration(ms: Integer); cdecl;
    procedure setExitFadeDuration(ms: Integer); cdecl;
    procedure setHotspot(x: Single; y: Single); cdecl;
    procedure setHotspotBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
    procedure unscheduleDrawable(who: JDrawable; what: JRunnable); cdecl;
  end;
  TJDrawableContainer = class(TJavaGenericImport<JDrawableContainerClass, JDrawableContainer>) end;

  JStateListDrawableClass = interface(JDrawableContainerClass)
    ['{800AF89B-2C59-45AE-A25F-85A4EDFCAC3F}']
    {class} function init: JStateListDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/StateListDrawable')]
  JStateListDrawable = interface(JDrawableContainer)
    ['{70C240CA-58E2-4A9A-8706-05754EF39D22}']
    procedure addState(stateSet: TJavaArray<Integer>; drawable: JDrawable); cdecl;
    procedure applyTheme(theme: JResources_Theme); cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
  end;
  TJStateListDrawable = class(TJavaGenericImport<JStateListDrawableClass, JStateListDrawable>) end;

  JAnimatedStateListDrawableClass = interface(JStateListDrawableClass)
    ['{B7659349-6B4C-4F87-B979-5AAB3A965AC6}']
    {class} function init: JAnimatedStateListDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/AnimatedStateListDrawable')]
  JAnimatedStateListDrawable = interface(JStateListDrawable)
    ['{E4B0FAA6-1B76-4B0F-91AA-C211DA88C4B0}']
    procedure addState(stateSet: TJavaArray<Integer>; drawable: JDrawable; id: Integer); cdecl;
    procedure addTransition(fromId: Integer; toId: Integer; transition: JDrawable; reversible: Boolean); cdecl;
    procedure applyTheme(theme: JResources_Theme); cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isStateful: Boolean; cdecl;
    procedure jumpToCurrentState; cdecl;
    function mutate: JDrawable; cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
  end;
  TJAnimatedStateListDrawable = class(TJavaGenericImport<JAnimatedStateListDrawableClass, JAnimatedStateListDrawable>) end;

  JAnimatedVectorDrawableClass = interface(JDrawableClass)
    ['{B921915E-A5CB-4BCE-89EE-33BD118B1A33}']
    {class} function init: JAnimatedVectorDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/AnimatedVectorDrawable')]
  JAnimatedVectorDrawable = interface(JDrawable)
    ['{27E03D8E-10AD-494D-B328-9E47D5B1246F}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure clearAnimationCallbacks; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    procedure inflate(res: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isRunning: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    function onLayoutDirectionChanged(layoutDirection: Integer): Boolean; cdecl;
    procedure registerAnimationCallback(callback: JAnimatable2_AnimationCallback); cdecl;
    procedure reset; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setHotspot(x: Single; y: Single); cdecl;
    procedure setHotspotBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
    procedure start; cdecl;
    procedure stop; cdecl;
    function unregisterAnimationCallback(callback: JAnimatable2_AnimationCallback): Boolean; cdecl;
  end;
  TJAnimatedVectorDrawable = class(TJavaGenericImport<JAnimatedVectorDrawableClass, JAnimatedVectorDrawable>) end;

  JAnimationDrawableClass = interface(JDrawableContainerClass)
    ['{5ADA9FF7-EF36-40DF-B080-295545E7A42F}']
    {class} function init: JAnimationDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/AnimationDrawable')]
  JAnimationDrawable = interface(JDrawableContainer)
    ['{89D46091-A136-4579-886D-0F5F99695146}']
    procedure addFrame(frame: JDrawable; duration: Integer); cdecl;
    function getDuration(i: Integer): Integer; cdecl;
    function getFrame(index: Integer): JDrawable; cdecl;
    function getNumberOfFrames: Integer; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isOneShot: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure run; cdecl;
    procedure setOneShot(oneShot: Boolean); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
    procedure start; cdecl;
    procedure stop; cdecl;
    procedure unscheduleSelf(what: JRunnable); cdecl;
  end;
  TJAnimationDrawable = class(TJavaGenericImport<JAnimationDrawableClass, JAnimationDrawable>) end;

  JBitmapDrawableClass = interface(JDrawableClass)
    ['{8DD36F5B-B87C-45AA-A897-6740ED35CFFC}']
    {class} function init: JBitmapDrawable; cdecl; overload;//Deprecated
    {class} function init(res: JResources): JBitmapDrawable; cdecl; overload;//Deprecated
    {class} function init(bitmap: JBitmap): JBitmapDrawable; cdecl; overload;//Deprecated
    {class} function init(res: JResources; bitmap: JBitmap): JBitmapDrawable; cdecl; overload;
    {class} function init(filepath: JString): JBitmapDrawable; cdecl; overload;//Deprecated
    {class} function init(res: JResources; filepath: JString): JBitmapDrawable; cdecl; overload;
    {class} function init(is_: JInputStream): JBitmapDrawable; cdecl; overload;//Deprecated
    {class} function init(res: JResources; is_: JInputStream): JBitmapDrawable; cdecl; overload;
  end;

  [JavaSignature('android/graphics/drawable/BitmapDrawable')]
  JBitmapDrawable = interface(JDrawable)
    ['{D04741C7-39A6-454D-B77D-4E90CCB79D47}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getBitmap: JBitmap; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColorFilter: JColorFilter; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getGravity: Integer; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPaint: JPaint; cdecl;
    function getTileModeX: JShader_TileMode; cdecl;
    function getTileModeY: JShader_TileMode; cdecl;
    function hasAntiAlias: Boolean; cdecl;
    function hasMipMap: Boolean; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isAutoMirrored: Boolean; cdecl;
    function isFilterBitmap: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setAntiAlias(aa: Boolean); cdecl;
    procedure setAutoMirrored(mirrored: Boolean); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setFilterBitmap(filter: Boolean); cdecl;
    procedure setGravity(gravity: Integer); cdecl;
    procedure setMipMap(mipMap: Boolean); cdecl;
    procedure setTargetDensity(canvas: JCanvas); cdecl; overload;
    procedure setTargetDensity(metrics: JDisplayMetrics); cdecl; overload;
    procedure setTargetDensity(density: Integer); cdecl; overload;
    procedure setTileModeX(mode: JShader_TileMode); cdecl;
    procedure setTileModeXY(xmode: JShader_TileMode; ymode: JShader_TileMode); cdecl;
    procedure setTileModeY(mode: JShader_TileMode); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
  end;
  TJBitmapDrawable = class(TJavaGenericImport<JBitmapDrawableClass, JBitmapDrawable>) end;

  JDrawableWrapperClass = interface(JDrawableClass)
    ['{BD355B54-86A9-43A9-86E0-79074977CB10}']
    {class} function init(dr: JDrawable): JDrawableWrapper; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/DrawableWrapper')]
  JDrawableWrapper = interface(JDrawable)
    ['{B2D09EEE-1D6F-43A2-8C75-5D2A6AB575BE}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getDrawable: JDrawable; cdecl;
    procedure getHotspotBounds(outRect: JRect); cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    procedure invalidateDrawable(who: JDrawable); cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    function onLayoutDirectionChanged(layoutDirection: Integer): Boolean; cdecl;
    procedure scheduleDrawable(who: JDrawable; what: JRunnable; when: Int64); cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setDrawable(dr: JDrawable); cdecl;
    procedure setHotspot(x: Single; y: Single); cdecl;
    procedure setHotspotBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
    procedure unscheduleDrawable(who: JDrawable; what: JRunnable); cdecl;
  end;
  TJDrawableWrapper = class(TJavaGenericImport<JDrawableWrapperClass, JDrawableWrapper>) end;

  JClipDrawableClass = interface(JDrawableWrapperClass)
    ['{D574B655-BF43-42DC-BFB2-F0B97B32484A}']
    {class} function _GetHORIZONTAL: Integer; cdecl;
    {class} function _GetVERTICAL: Integer; cdecl;
    {class} function init(drawable: JDrawable; gravity: Integer; orientation: Integer): JClipDrawable; cdecl;
    {class} property HORIZONTAL: Integer read _GetHORIZONTAL;
    {class} property VERTICAL: Integer read _GetVERTICAL;
  end;

  [JavaSignature('android/graphics/drawable/ClipDrawable')]
  JClipDrawable = interface(JDrawableWrapper)
    ['{2BDDA0C4-28C8-42DE-8B80-842AD3DEB5A8}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getOpacity: Integer; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
  end;
  TJClipDrawable = class(TJavaGenericImport<JClipDrawableClass, JClipDrawable>) end;

  JColorDrawableClass = interface(JDrawableClass)
    ['{C48FA944-8DB5-4626-BF46-E264FDFA6137}']
    {class} function init: JColorDrawable; cdecl; overload;
    {class} function init(color: Integer): JColorDrawable; cdecl; overload;
  end;

  [JavaSignature('android/graphics/drawable/ColorDrawable')]
  JColorDrawable = interface(JDrawable)
    ['{BF6A29E7-9693-4FFB-AD3E-92F3B7BDC9CF}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColor: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setColor(color: Integer); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
  end;
  TJColorDrawable = class(TJavaGenericImport<JColorDrawableClass, JColorDrawable>) end;

  JDrawable_CallbackClass = interface(IJavaClass)
    ['{9CC689FA-7A85-45BF-9177-B3AD29D31FE9}']
  end;

  [JavaSignature('android/graphics/drawable/Drawable$Callback')]
  JDrawable_Callback = interface(IJavaInstance)
    ['{B41BB3DD-4E4B-4771-9D5A-FADE128DBFDA}']
    procedure invalidateDrawable(who: JDrawable); cdecl;
    procedure scheduleDrawable(who: JDrawable; what: JRunnable; when: Int64); cdecl;
    procedure unscheduleDrawable(who: JDrawable; what: JRunnable); cdecl;
  end;
  TJDrawable_Callback = class(TJavaGenericImport<JDrawable_CallbackClass, JDrawable_Callback>) end;

  JDrawable_ConstantStateClass = interface(JObjectClass)
    ['{897FEAC3-7E54-4684-98E0-E4EA096D3FD0}']
    {class} function init: JDrawable_ConstantState; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/Drawable$ConstantState')]
  JDrawable_ConstantState = interface(JObject)
    ['{A56FEC85-8E9B-4879-AE79-FA588A0702C0}']
    function canApplyTheme: Boolean; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function newDrawable: JDrawable; cdecl; overload;
    function newDrawable(res: JResources): JDrawable; cdecl; overload;
    function newDrawable(res: JResources; theme: JResources_Theme): JDrawable; cdecl; overload;
  end;
  TJDrawable_ConstantState = class(TJavaGenericImport<JDrawable_ConstantStateClass, JDrawable_ConstantState>) end;

  JDrawableContainer_DrawableContainerStateClass = interface(JDrawable_ConstantStateClass)
    ['{4ADDD2D1-BDBC-4DBC-87D6-85DE34C2EBCF}']
  end;

  [JavaSignature('android/graphics/drawable/DrawableContainer$DrawableContainerState')]
  JDrawableContainer_DrawableContainerState = interface(JDrawable_ConstantState)
    ['{10EB3DB2-2579-43CD-9330-E9B6C36B1AB8}']
    function addChild(dr: JDrawable): Integer; cdecl;
    function canApplyTheme: Boolean; cdecl;
    function canConstantState: Boolean; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getChild(index: Integer): JDrawable; cdecl;
    function getChildCount: Integer; cdecl;
    function getChildren: TJavaObjectArray<JDrawable>; cdecl;
    function getConstantHeight: Integer; cdecl;
    function getConstantMinimumHeight: Integer; cdecl;
    function getConstantMinimumWidth: Integer; cdecl;
    function getConstantPadding: JRect; cdecl;
    function getConstantWidth: Integer; cdecl;
    function getEnterFadeDuration: Integer; cdecl;
    function getExitFadeDuration: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure growArray(oldSize: Integer; newSize: Integer); cdecl;
    function isConstantSize: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    procedure setConstantSize(constant: Boolean); cdecl;
    procedure setEnterFadeDuration(duration: Integer); cdecl;
    procedure setExitFadeDuration(duration: Integer); cdecl;
    procedure setVariablePadding(variable: Boolean); cdecl;
  end;
  TJDrawableContainer_DrawableContainerState = class(TJavaGenericImport<JDrawableContainer_DrawableContainerStateClass, JDrawableContainer_DrawableContainerState>) end;

  JGradientDrawableClass = interface(JDrawableClass)
    ['{C04CD531-461A-464B-B3D0-25F633D2E1B4}']
    {class} function _GetLINE: Integer; cdecl;
    {class} function _GetLINEAR_GRADIENT: Integer; cdecl;
    {class} function _GetOVAL: Integer; cdecl;
    {class} function _GetRADIAL_GRADIENT: Integer; cdecl;
    {class} function _GetRECTANGLE: Integer; cdecl;
    {class} function _GetRING: Integer; cdecl;
    {class} function _GetSWEEP_GRADIENT: Integer; cdecl;
    {class} function init: JGradientDrawable; cdecl; overload;
    {class} function init(orientation: JGradientDrawable_Orientation; colors: TJavaArray<Integer>): JGradientDrawable; cdecl; overload;
    {class} property LINE: Integer read _GetLINE;
    {class} property LINEAR_GRADIENT: Integer read _GetLINEAR_GRADIENT;
    {class} property OVAL: Integer read _GetOVAL;
    {class} property RADIAL_GRADIENT: Integer read _GetRADIAL_GRADIENT;
    {class} property RECTANGLE: Integer read _GetRECTANGLE;
    {class} property RING: Integer read _GetRING;
    {class} property SWEEP_GRADIENT: Integer read _GetSWEEP_GRADIENT;
  end;

  [JavaSignature('android/graphics/drawable/GradientDrawable')]
  JGradientDrawable = interface(JDrawable)
    ['{8573D42B-D225-4021-98B4-92385AF6777B}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColorFilter: JColorFilter; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getGradientRadius: Single; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    function getOrientation: JGradientDrawable_Orientation; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setColor(argb: Integer); cdecl; overload;
    procedure setColor(colorStateList: JColorStateList); cdecl; overload;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setColors(colors: TJavaArray<Integer>); cdecl;
    procedure setCornerRadii(radii: TJavaArray<Single>); cdecl;
    procedure setCornerRadius(radius: Single); cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setGradientCenter(x: Single; y: Single); cdecl;
    procedure setGradientRadius(gradientRadius: Single); cdecl;
    procedure setGradientType(gradient: Integer); cdecl;
    procedure setOrientation(orientation: JGradientDrawable_Orientation); cdecl;
    procedure setShape(shape: Integer); cdecl;
    procedure setSize(width: Integer; height: Integer); cdecl;
    procedure setStroke(width: Integer; color: Integer); cdecl; overload;
    procedure setStroke(width: Integer; colorStateList: JColorStateList); cdecl; overload;
    procedure setStroke(width: Integer; color: Integer; dashWidth: Single; dashGap: Single); cdecl; overload;
    procedure setStroke(width: Integer; colorStateList: JColorStateList; dashWidth: Single; dashGap: Single); cdecl; overload;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
    procedure setUseLevel(useLevel: Boolean); cdecl;
  end;
  TJGradientDrawable = class(TJavaGenericImport<JGradientDrawableClass, JGradientDrawable>) end;

  JGradientDrawable_OrientationClass = interface(JEnumClass)
    ['{F2C32A94-FD6D-4247-861B-4D895928E1AE}']
    {class} function _GetBL_TR: JGradientDrawable_Orientation; cdecl;
    {class} function _GetBOTTOM_TOP: JGradientDrawable_Orientation; cdecl;
    {class} function _GetBR_TL: JGradientDrawable_Orientation; cdecl;
    {class} function _GetLEFT_RIGHT: JGradientDrawable_Orientation; cdecl;
    {class} function _GetRIGHT_LEFT: JGradientDrawable_Orientation; cdecl;
    {class} function _GetTL_BR: JGradientDrawable_Orientation; cdecl;
    {class} function _GetTOP_BOTTOM: JGradientDrawable_Orientation; cdecl;
    {class} function _GetTR_BL: JGradientDrawable_Orientation; cdecl;
    {class} function valueOf(name: JString): JGradientDrawable_Orientation; cdecl;
    {class} function values: TJavaObjectArray<JGradientDrawable_Orientation>; cdecl;
    {class} property BL_TR: JGradientDrawable_Orientation read _GetBL_TR;
    {class} property BOTTOM_TOP: JGradientDrawable_Orientation read _GetBOTTOM_TOP;
    {class} property BR_TL: JGradientDrawable_Orientation read _GetBR_TL;
    {class} property LEFT_RIGHT: JGradientDrawable_Orientation read _GetLEFT_RIGHT;
    {class} property RIGHT_LEFT: JGradientDrawable_Orientation read _GetRIGHT_LEFT;
    {class} property TL_BR: JGradientDrawable_Orientation read _GetTL_BR;
    {class} property TOP_BOTTOM: JGradientDrawable_Orientation read _GetTOP_BOTTOM;
    {class} property TR_BL: JGradientDrawable_Orientation read _GetTR_BL;
  end;

  [JavaSignature('android/graphics/drawable/GradientDrawable$Orientation')]
  JGradientDrawable_Orientation = interface(JEnum)
    ['{7DC952FB-E023-4DDB-BB16-88E784289B12}']
  end;
  TJGradientDrawable_Orientation = class(TJavaGenericImport<JGradientDrawable_OrientationClass, JGradientDrawable_Orientation>) end;

  JIconClass = interface(JObjectClass)
    ['{BBB5D656-D611-49D4-9AE3-8D73F2054295}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function createWithBitmap(bits: JBitmap): JIcon; cdecl;
    {class} function createWithContentUri(uri: JString): JIcon; cdecl; overload;
    {class} function createWithContentUri(uri: Jnet_Uri): JIcon; cdecl; overload;
    {class} function createWithData(data: TJavaArray<Byte>; offset: Integer; length: Integer): JIcon; cdecl;
    {class} function createWithFilePath(path: JString): JIcon; cdecl;
    {class} function createWithResource(context: JContext; resId: Integer): JIcon; cdecl; overload;
    {class} function createWithResource(resPackage: JString; resId: Integer): JIcon; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/graphics/drawable/Icon')]
  JIcon = interface(JObject)
    ['{7A5966F9-6412-4EB6-A2AD-1A996A9D8DB2}']
    function describeContents: Integer; cdecl;
    function loadDrawable(context: JContext): JDrawable; cdecl;
    procedure loadDrawableAsync(context: JContext; andThen: JMessage); cdecl; overload;
    procedure loadDrawableAsync(context: JContext; listener: JIcon_OnDrawableLoadedListener; handler: JHandler); cdecl; overload;
    function setTint(tint: Integer): JIcon; cdecl;
    function setTintList(tintList: JColorStateList): JIcon; cdecl;
    function setTintMode(mode: JPorterDuff_Mode): JIcon; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJIcon = class(TJavaGenericImport<JIconClass, JIcon>) end;

  JIcon_OnDrawableLoadedListenerClass = interface(IJavaClass)
    ['{AFE568DE-0B69-4156-93CF-21DBC74F82F8}']
  end;

  [JavaSignature('android/graphics/drawable/Icon$OnDrawableLoadedListener')]
  JIcon_OnDrawableLoadedListener = interface(IJavaInstance)
    ['{346A8445-C368-44F9-981F-6EAD6339D20F}']
    procedure onDrawableLoaded(d: JDrawable); cdecl;
  end;
  TJIcon_OnDrawableLoadedListener = class(TJavaGenericImport<JIcon_OnDrawableLoadedListenerClass, JIcon_OnDrawableLoadedListener>) end;

  JInsetDrawableClass = interface(JDrawableWrapperClass)
    ['{F5DBFF6F-2A58-4EAA-B193-3886578E6BCA}']
    {class} function init(drawable: JDrawable; inset: Integer): JInsetDrawable; cdecl; overload;
    {class} function init(drawable: JDrawable; insetLeft: Integer; insetTop: Integer; insetRight: Integer; insetBottom: Integer): JInsetDrawable; cdecl; overload;
  end;

  [JavaSignature('android/graphics/drawable/InsetDrawable')]
  JInsetDrawable = interface(JDrawableWrapper)
    ['{AD1B3CB1-5EFC-46B4-A58E-FC28A37A77DE}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
  end;
  TJInsetDrawable = class(TJavaGenericImport<JInsetDrawableClass, JInsetDrawable>) end;

  JLayerDrawableClass = interface(JDrawableClass)
    ['{83EA2827-F626-4F02-94BA-A44DDB32A062}']
    {class} function _GetPADDING_MODE_NEST: Integer; cdecl;
    {class} function _GetPADDING_MODE_STACK: Integer; cdecl;
    {class} function init(layers: TJavaObjectArray<JDrawable>): JLayerDrawable; cdecl;
    {class} property PADDING_MODE_NEST: Integer read _GetPADDING_MODE_NEST;
    {class} property PADDING_MODE_STACK: Integer read _GetPADDING_MODE_STACK;
  end;

  [JavaSignature('android/graphics/drawable/LayerDrawable')]
  JLayerDrawable = interface(JDrawable)
    ['{9CF5C6FE-7799-4439-853C-E39B0A9CE04A}']
    function addLayer(dr: JDrawable): Integer; cdecl;
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function findDrawableByLayerId(id: Integer): JDrawable; cdecl;
    function findIndexByLayerId(id: Integer): Integer; cdecl;
    function getAlpha: Integer; cdecl;
    function getBottomPadding: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getDrawable(index: Integer): JDrawable; cdecl;
    function getEndPadding: Integer; cdecl;
    procedure getHotspotBounds(outRect: JRect); cdecl;
    function getId(index: Integer): Integer; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getLayerGravity(index: Integer): Integer; cdecl;
    function getLayerHeight(index: Integer): Integer; cdecl;
    function getLayerInsetBottom(index: Integer): Integer; cdecl;
    function getLayerInsetEnd(index: Integer): Integer; cdecl;
    function getLayerInsetLeft(index: Integer): Integer; cdecl;
    function getLayerInsetRight(index: Integer): Integer; cdecl;
    function getLayerInsetStart(index: Integer): Integer; cdecl;
    function getLayerInsetTop(index: Integer): Integer; cdecl;
    function getLayerWidth(index: Integer): Integer; cdecl;
    function getLeftPadding: Integer; cdecl;
    function getNumberOfLayers: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    function getPaddingMode: Integer; cdecl;
    function getRightPadding: Integer; cdecl;
    function getStartPadding: Integer; cdecl;
    function getTopPadding: Integer; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    procedure invalidateDrawable(who: JDrawable); cdecl;
    function isAutoMirrored: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    function onLayoutDirectionChanged(layoutDirection: Integer): Boolean; cdecl;
    procedure scheduleDrawable(who: JDrawable; what: JRunnable; when: Int64); cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setAutoMirrored(mirrored: Boolean); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setDrawable(index: Integer; drawable: JDrawable); cdecl;
    function setDrawableByLayerId(id: Integer; drawable: JDrawable): Boolean; cdecl;
    procedure setHotspot(x: Single; y: Single); cdecl;
    procedure setHotspotBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setId(index: Integer; id: Integer); cdecl;
    procedure setLayerGravity(index: Integer; gravity: Integer); cdecl;
    procedure setLayerHeight(index: Integer; h: Integer); cdecl;
    procedure setLayerInset(index: Integer; l: Integer; t: Integer; r: Integer; b: Integer); cdecl;
    procedure setLayerInsetBottom(index: Integer; b: Integer); cdecl;
    procedure setLayerInsetEnd(index: Integer; e: Integer); cdecl;
    procedure setLayerInsetLeft(index: Integer; l: Integer); cdecl;
    procedure setLayerInsetRelative(index: Integer; s: Integer; t: Integer; e: Integer; b: Integer); cdecl;
    procedure setLayerInsetRight(index: Integer; r: Integer); cdecl;
    procedure setLayerInsetStart(index: Integer; s: Integer); cdecl;
    procedure setLayerInsetTop(index: Integer; t: Integer); cdecl;
    procedure setLayerSize(index: Integer; w: Integer; h: Integer); cdecl;
    procedure setLayerWidth(index: Integer; w: Integer); cdecl;
    procedure setOpacity(opacity: Integer); cdecl;
    procedure setPadding(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setPaddingMode(mode: Integer); cdecl;
    procedure setPaddingRelative(start: Integer; top: Integer; end_: Integer; bottom: Integer); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
    procedure unscheduleDrawable(who: JDrawable; what: JRunnable); cdecl;
  end;
  TJLayerDrawable = class(TJavaGenericImport<JLayerDrawableClass, JLayerDrawable>) end;

  JLevelListDrawableClass = interface(JDrawableContainerClass)
    ['{AD8A4554-441D-4FC1-A800-1194C2724EB5}']
    {class} function init: JLevelListDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/LevelListDrawable')]
  JLevelListDrawable = interface(JDrawableContainer)
    ['{7D90BA12-2370-49F8-8CC9-6ED6D7773F0D}']
    procedure addLevel(low: Integer; high: Integer; drawable: JDrawable); cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function mutate: JDrawable; cdecl;
  end;
  TJLevelListDrawable = class(TJavaGenericImport<JLevelListDrawableClass, JLevelListDrawable>) end;

  JNinePatchDrawableClass = interface(JDrawableClass)
    ['{73FA6785-B351-441A-A494-E362EA82B6AE}']
    {class} function init(bitmap: JBitmap; chunk: TJavaArray<Byte>; padding: JRect; srcName: JString): JNinePatchDrawable; cdecl; overload;//Deprecated
    {class} function init(res: JResources; bitmap: JBitmap; chunk: TJavaArray<Byte>; padding: JRect; srcName: JString): JNinePatchDrawable; cdecl; overload;
    {class} function init(patch: JNinePatch): JNinePatchDrawable; cdecl; overload;//Deprecated
    {class} function init(res: JResources; patch: JNinePatch): JNinePatchDrawable; cdecl; overload;
  end;

  [JavaSignature('android/graphics/drawable/NinePatchDrawable')]
  JNinePatchDrawable = interface(JDrawable)
    ['{42C8A806-41A1-4B9F-BDE2-0FB9FAF6FB6F}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getMinimumHeight: Integer; cdecl;
    function getMinimumWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    function getPaint: JPaint; cdecl;
    function getTransparentRegion: JRegion; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isAutoMirrored: Boolean; cdecl;
    function isFilterBitmap: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setAutoMirrored(mirrored: Boolean); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setFilterBitmap(filter: Boolean); cdecl;
    procedure setTargetDensity(canvas: JCanvas); cdecl; overload;
    procedure setTargetDensity(metrics: JDisplayMetrics); cdecl; overload;
    procedure setTargetDensity(density: Integer); cdecl; overload;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
  end;
  TJNinePatchDrawable = class(TJavaGenericImport<JNinePatchDrawableClass, JNinePatchDrawable>) end;

  JShapeDrawableClass = interface(JDrawableClass)
    ['{127DBE9F-4758-471F-9874-CA5C349BBCFD}']
    {class} function init: JShapeDrawable; cdecl; overload;
    {class} function init(s: JShape): JShapeDrawable; cdecl; overload;
  end;

  [JavaSignature('android/graphics/drawable/ShapeDrawable')]
  JShapeDrawable = interface(JDrawable)
    ['{4FEC3B0A-E214-4AF5-8143-93CCC01803EF}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getPadding(padding: JRect): Boolean; cdecl;
    function getPaint: JPaint; cdecl;
    function getShaderFactory: JShapeDrawable_ShaderFactory; cdecl;
    function getShape: JShape; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setDither(dither: Boolean); cdecl;
    procedure setIntrinsicHeight(height: Integer); cdecl;
    procedure setIntrinsicWidth(width: Integer); cdecl;
    procedure setPadding(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure setPadding(padding: JRect); cdecl; overload;
    procedure setShaderFactory(fact: JShapeDrawable_ShaderFactory); cdecl;
    procedure setShape(s: JShape); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
  end;
  TJShapeDrawable = class(TJavaGenericImport<JShapeDrawableClass, JShapeDrawable>) end;

  JPaintDrawableClass = interface(JShapeDrawableClass)
    ['{B3EA2085-D3A1-4D2B-88ED-1143599C8DD5}']
    {class} function init: JPaintDrawable; cdecl; overload;
    {class} function init(color: Integer): JPaintDrawable; cdecl; overload;
  end;

  [JavaSignature('android/graphics/drawable/PaintDrawable')]
  JPaintDrawable = interface(JShapeDrawable)
    ['{1C57A0BD-E491-49A1-A0A5-46DE37267AC5}']
    procedure setCornerRadii(radii: TJavaArray<Single>); cdecl;
    procedure setCornerRadius(radius: Single); cdecl;
  end;
  TJPaintDrawable = class(TJavaGenericImport<JPaintDrawableClass, JPaintDrawable>) end;

  JPictureDrawableClass = interface(JDrawableClass)
    ['{34008001-5539-415F-89C7-138E7B48FFE1}']
    {class} function init(picture: JPicture): JPictureDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/PictureDrawable')]
  JPictureDrawable = interface(JDrawable)
    ['{71D3B28F-EB0A-4446-ABDF-8CFFB82240D6}']
    procedure draw(canvas: JCanvas); cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    function getPicture: JPicture; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setPicture(picture: JPicture); cdecl;
  end;
  TJPictureDrawable = class(TJavaGenericImport<JPictureDrawableClass, JPictureDrawable>) end;

  JRippleComponent_RenderNodeAnimatorSetClass = interface(JObjectClass)
    ['{EBAA1F6C-3E93-48CC-A699-43CC260E1773}']
    {class} function init: JRippleComponent_RenderNodeAnimatorSet; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/RippleComponent$RenderNodeAnimatorSet')]
  JRippleComponent_RenderNodeAnimatorSet = interface(JObject)
    ['{9D2F73BD-2EE2-421F-9808-2156A766C446}']
    //procedure add(anim: JRenderNodeAnimator); cdecl;
    procedure cancel; cdecl;
    procedure clear; cdecl;
    procedure &end; cdecl;
    function isRunning: Boolean; cdecl;
    procedure start(target: JDisplayListCanvas); cdecl;
  end;
  TJRippleComponent_RenderNodeAnimatorSet = class(TJavaGenericImport<JRippleComponent_RenderNodeAnimatorSetClass, JRippleComponent_RenderNodeAnimatorSet>) end;

  JRippleDrawableClass = interface(JLayerDrawableClass)
    ['{90CB3505-6CF1-474F-BE1B-73205CD21143}']
    {class} function _GetRADIUS_AUTO: Integer; cdecl;
    {class} function init(color: JColorStateList; content: JDrawable; mask: JDrawable): JRippleDrawable; cdecl;
    {class} property RADIUS_AUTO: Integer read _GetRADIUS_AUTO;
  end;

  [JavaSignature('android/graphics/drawable/RippleDrawable')]
  JRippleDrawable = interface(JLayerDrawable)
    ['{5BFFCFF7-E5F4-499C-9A10-52D9AAEE2DDE}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getDirtyBounds: JRect; cdecl;
    procedure getHotspotBounds(outRect: JRect); cdecl;
    function getOpacity: Integer; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getRadius: Integer; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    procedure invalidateSelf; cdecl;
    function isStateful: Boolean; cdecl;
    procedure jumpToCurrentState; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setColor(color: JColorStateList); cdecl;
    function setDrawableByLayerId(id: Integer; drawable: JDrawable): Boolean; cdecl;
    procedure setHotspot(x: Single; y: Single); cdecl;
    procedure setHotspotBounds(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setPaddingMode(mode: Integer); cdecl;
    procedure setRadius(radius: Integer); cdecl;
    function setVisible(visible: Boolean; restart: Boolean): Boolean; cdecl;
  end;
  TJRippleDrawable = class(TJavaGenericImport<JRippleDrawableClass, JRippleDrawable>) end;

  JRotateDrawableClass = interface(JDrawableWrapperClass)
    ['{58ABB7B5-8AA0-4972-A206-1E70423AEA6A}']
    {class} function init: JRotateDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/RotateDrawable')]
  JRotateDrawable = interface(JDrawableWrapper)
    ['{B64FF7BE-FFDC-47C5-9160-85503034A331}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getFromDegrees: Single; cdecl;
    function getPivotX: Single; cdecl;
    function getPivotY: Single; cdecl;
    function getToDegrees: Single; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isPivotXRelative: Boolean; cdecl;
    function isPivotYRelative: Boolean; cdecl;
    procedure setFromDegrees(fromDegrees: Single); cdecl;
    procedure setPivotX(pivotX: Single); cdecl;
    procedure setPivotXRelative(relative: Boolean); cdecl;
    procedure setPivotY(pivotY: Single); cdecl;
    procedure setPivotYRelative(relative: Boolean); cdecl;
    procedure setToDegrees(toDegrees: Single); cdecl;
  end;
  TJRotateDrawable = class(TJavaGenericImport<JRotateDrawableClass, JRotateDrawable>) end;

  JScaleDrawableClass = interface(JDrawableWrapperClass)
    ['{C722EF4C-58E6-4510-A19C-E43032F02344}']
    {class} function init(drawable: JDrawable; gravity: Integer; scaleWidth: Single; scaleHeight: Single): JScaleDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/ScaleDrawable')]
  JScaleDrawable = interface(JDrawableWrapper)
    ['{2915F20F-256D-4428-8424-34412F11AAF2}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getOpacity: Integer; cdecl;
    procedure inflate(r: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
  end;
  TJScaleDrawable = class(TJavaGenericImport<JScaleDrawableClass, JScaleDrawable>) end;

  JShapeDrawable_ShaderFactoryClass = interface(JObjectClass)
    ['{1169F195-175A-4AAC-B8B5-F300F63591A2}']
    {class} function init: JShapeDrawable_ShaderFactory; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/ShapeDrawable$ShaderFactory')]
  JShapeDrawable_ShaderFactory = interface(JObject)
    ['{F4735750-5E22-4BC1-8F4E-235457EFD9EB}']
    function resize(width: Integer; height: Integer): JShader; cdecl;
  end;
  TJShapeDrawable_ShaderFactory = class(TJavaGenericImport<JShapeDrawable_ShaderFactoryClass, JShapeDrawable_ShaderFactory>) end;

  JTransitionDrawableClass = interface(JLayerDrawableClass)
    ['{72B55F6D-A42D-4ABE-9654-9A515758F752}']
    {class} function init(layers: TJavaObjectArray<JDrawable>): JTransitionDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/TransitionDrawable')]
  JTransitionDrawable = interface(JLayerDrawable)
    ['{CFEC20FD-AF1F-40CC-AC70-C2543FB5AF24}']
    procedure draw(canvas: JCanvas); cdecl;
    function isCrossFadeEnabled: Boolean; cdecl;
    procedure resetTransition; cdecl;
    procedure reverseTransition(duration: Integer); cdecl;
    procedure setCrossFadeEnabled(enabled: Boolean); cdecl;
    procedure startTransition(durationMillis: Integer); cdecl;
  end;
  TJTransitionDrawable = class(TJavaGenericImport<JTransitionDrawableClass, JTransitionDrawable>) end;

  JVectorDrawableClass = interface(JDrawableClass)
    ['{D1B2E80C-6953-4F70-B127-47617CFB3AD9}']
    {class} function init: JVectorDrawable; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/VectorDrawable')]
  JVectorDrawable = interface(JDrawable)
    ['{FC5EB18E-5EB2-4874-A916-3A22E87CD274}']
    procedure applyTheme(t: JResources_Theme); cdecl;
    function canApplyTheme: Boolean; cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    function getAlpha: Integer; cdecl;
    function getChangingConfigurations: Integer; cdecl;
    function getColorFilter: JColorFilter; cdecl;
    function getConstantState: JDrawable_ConstantState; cdecl;
    function getIntrinsicHeight: Integer; cdecl;
    function getIntrinsicWidth: Integer; cdecl;
    function getOpacity: Integer; cdecl;
    procedure inflate(res: JResources; parser: JXmlPullParser; attrs: JAttributeSet; theme: JResources_Theme); cdecl;
    function isAutoMirrored: Boolean; cdecl;
    function isStateful: Boolean; cdecl;
    function mutate: JDrawable; cdecl;
    procedure setAlpha(alpha: Integer); cdecl;
    procedure setAutoMirrored(mirrored: Boolean); cdecl;
    procedure setColorFilter(colorFilter: JColorFilter); cdecl;
    procedure setTintList(tint: JColorStateList); cdecl;
    procedure setTintMode(tintMode: JPorterDuff_Mode); cdecl;
  end;
  TJVectorDrawable = class(TJavaGenericImport<JVectorDrawableClass, JVectorDrawable>) end;

  JShapeClass = interface(JObjectClass)
    ['{7C5B6760-DDFD-4D27-BF6A-13320A247039}']
    {class} function init: JShape; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/shapes/Shape')]
  JShape = interface(JObject)
    ['{2FE9999A-9388-45DF-BFB9-0ED2F659EB9B}']
    function clone: JShape; cdecl;
    procedure draw(canvas: JCanvas; paint: JPaint); cdecl;
    function getHeight: Single; cdecl;
    procedure getOutline(outline: JOutline); cdecl;
    function getWidth: Single; cdecl;
    function hasAlpha: Boolean; cdecl;
    procedure resize(width: Single; height: Single); cdecl;
  end;
  TJShape = class(TJavaGenericImport<JShapeClass, JShape>) end;

  JRectShapeClass = interface(JShapeClass)
    ['{78A92C31-C06A-4152-A353-B7D617A18387}']
    {class} function init: JRectShape; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/shapes/RectShape')]
  JRectShape = interface(JShape)
    ['{41677A83-E028-401E-BB0D-F1D563D58F57}']
    function clone: JRectShape; cdecl;
    procedure draw(canvas: JCanvas; paint: JPaint); cdecl;
    procedure getOutline(outline: JOutline); cdecl;
  end;
  TJRectShape = class(TJavaGenericImport<JRectShapeClass, JRectShape>) end;

  JArcShapeClass = interface(JRectShapeClass)
    ['{29DCA278-564D-48F8-962C-142CCBA009CD}']
    {class} function init(startAngle: Single; sweepAngle: Single): JArcShape; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/shapes/ArcShape')]
  JArcShape = interface(JRectShape)
    ['{498B495C-A330-42D8-B5A8-09706EB738E0}']
    procedure draw(canvas: JCanvas; paint: JPaint); cdecl;
  end;
  TJArcShape = class(TJavaGenericImport<JArcShapeClass, JArcShape>) end;

  JOvalShapeClass = interface(JRectShapeClass)
    ['{4260F618-8D5F-4E41-B386-E8FA3F22C4EB}']
    {class} function init: JOvalShape; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/shapes/OvalShape')]
  JOvalShape = interface(JRectShape)
    ['{B80FDC7B-88DF-4C06-90A6-9E8A5F1EB4B3}']
    procedure draw(canvas: JCanvas; paint: JPaint); cdecl;
    procedure getOutline(outline: JOutline); cdecl;
  end;
  TJOvalShape = class(TJavaGenericImport<JOvalShapeClass, JOvalShape>) end;

  JPathShapeClass = interface(JShapeClass)
    ['{AC049327-80D1-4F2E-BD60-BFED7EF9D2C5}']
    {class} function init(path: JPath; stdWidth: Single; stdHeight: Single): JPathShape; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/shapes/PathShape')]
  JPathShape = interface(JShape)
    ['{DEDE18ED-0466-4F1B-8EC8-465B59FF0D09}']
    function clone: JPathShape; cdecl;
    procedure draw(canvas: JCanvas; paint: JPaint); cdecl;
  end;
  TJPathShape = class(TJavaGenericImport<JPathShapeClass, JPathShape>) end;

  JRoundRectShapeClass = interface(JRectShapeClass)
    ['{F5B46D75-F12C-484A-A89C-86B47F84F3EA}']
    {class} function init(outerRadii: TJavaArray<Single>; inset: JRectF; innerRadii: TJavaArray<Single>): JRoundRectShape; cdecl;
  end;

  [JavaSignature('android/graphics/drawable/shapes/RoundRectShape')]
  JRoundRectShape = interface(JRectShape)
    ['{8642D3BE-B527-4A7C-96F5-A20B5AC67A8D}']
    function clone: JRoundRectShape; cdecl;
    procedure draw(canvas: JCanvas; paint: JPaint); cdecl;
    procedure getOutline(outline: JOutline); cdecl;
  end;
  TJRoundRectShape = class(TJavaGenericImport<JRoundRectShapeClass, JRoundRectShape>) end;

  JPdfDocumentClass = interface(JObjectClass)
    ['{23CCAB1D-69A8-447D-AE4D-C8DBE5A4A421}']
    {class} function init: JPdfDocument; cdecl;
  end;

  [JavaSignature('android/graphics/pdf/PdfDocument')]
  JPdfDocument = interface(JObject)
    ['{AFF21641-98BA-402E-9AF9-D586B3A31879}']
    procedure close; cdecl;
    procedure finishPage(page: JPdfDocument_Page); cdecl;
    function getPages: JList; cdecl;
    function startPage(pageInfo: JPdfDocument_PageInfo): JPdfDocument_Page; cdecl;
    procedure writeTo(out_: JOutputStream); cdecl;
  end;
  TJPdfDocument = class(TJavaGenericImport<JPdfDocumentClass, JPdfDocument>) end;

  JPdfDocument_PageClass = interface(JObjectClass)
    ['{273BBC2C-BFDC-4373-84E5-FD4B34F408B9}']
  end;

  [JavaSignature('android/graphics/pdf/PdfDocument$Page')]
  JPdfDocument_Page = interface(JObject)
    ['{EF2B539A-8531-4D0F-9046-479EB7A92518}']
    function getCanvas: JCanvas; cdecl;
    function getInfo: JPdfDocument_PageInfo; cdecl;
  end;
  TJPdfDocument_Page = class(TJavaGenericImport<JPdfDocument_PageClass, JPdfDocument_Page>) end;

  JPdfDocument_PageInfoClass = interface(JObjectClass)
    ['{8B3EA9E0-F8C6-4249-BBFB-9412F998BA64}']
  end;

  [JavaSignature('android/graphics/pdf/PdfDocument$PageInfo')]
  JPdfDocument_PageInfo = interface(JObject)
    ['{F4D244BB-819A-4C76-9881-1AA8FF4280E7}']
    function getContentRect: JRect; cdecl;
    function getPageHeight: Integer; cdecl;
    function getPageNumber: Integer; cdecl;
    function getPageWidth: Integer; cdecl;
  end;
  TJPdfDocument_PageInfo = class(TJavaGenericImport<JPdfDocument_PageInfoClass, JPdfDocument_PageInfo>) end;

  JPageInfo_BuilderClass = interface(JObjectClass)
    ['{9FDDF4AF-7323-48E8-A50D-7B3A9D463259}']
    {class} function init(pageWidth: Integer; pageHeight: Integer; pageNumber: Integer): JPageInfo_Builder; cdecl;
  end;

  [JavaSignature('android/graphics/pdf/PdfDocument$PageInfo$Builder')]
  JPageInfo_Builder = interface(JObject)
    ['{88F15A6D-F673-4263-A067-5ED5B282E5BA}']
    function create: JPdfDocument_PageInfo; cdecl;
    function setContentRect(contentRect: JRect): JPageInfo_Builder; cdecl;
  end;
  TJPageInfo_Builder = class(TJavaGenericImport<JPageInfo_BuilderClass, JPageInfo_Builder>) end;

  JPdfRendererClass = interface(JObjectClass)
    ['{0CFF3A9C-3DD8-4B39-882D-40081461A0A7}']
    {class} function init(input: JParcelFileDescriptor): JPdfRenderer; cdecl;
  end;

  [JavaSignature('android/graphics/pdf/PdfRenderer')]
  JPdfRenderer = interface(JObject)
    ['{320F5661-C0C1-4960-9D43-02F33D994EAD}']
    procedure close; cdecl;
    function getPageCount: Integer; cdecl;
    function openPage(index: Integer): JPdfRenderer_Page; cdecl;
    function shouldScaleForPrinting: Boolean; cdecl;
  end;
  TJPdfRenderer = class(TJavaGenericImport<JPdfRendererClass, JPdfRenderer>) end;

  JPdfRenderer_PageClass = interface(JObjectClass)
    ['{ECA4068B-D1DA-44B4-8083-C32D60F01110}']
    {class} function _GetRENDER_MODE_FOR_DISPLAY: Integer; cdecl;
    {class} function _GetRENDER_MODE_FOR_PRINT: Integer; cdecl;
    {class} property RENDER_MODE_FOR_DISPLAY: Integer read _GetRENDER_MODE_FOR_DISPLAY;
    {class} property RENDER_MODE_FOR_PRINT: Integer read _GetRENDER_MODE_FOR_PRINT;
  end;

  [JavaSignature('android/graphics/pdf/PdfRenderer$Page')]
  JPdfRenderer_Page = interface(JObject)
    ['{0F3BA4F3-C093-4E13-94FD-798177CFB9BC}']
    procedure close; cdecl;
    function getHeight: Integer; cdecl;
    function getIndex: Integer; cdecl;
    function getWidth: Integer; cdecl;
    procedure render(destination: JBitmap; destClip: JRect; transform: JMatrix; renderMode: Integer); cdecl;
  end;
  TJPdfRenderer_Page = class(TJavaGenericImport<JPdfRenderer_PageClass, JPdfRenderer_Page>) end;

  JEditableClass = interface(JCharSequenceClass)
    ['{4DF3A8C1-D180-4B93-80D6-3B57236FB3B9}']
  end;

  [JavaSignature('android/text/Editable')]
  JEditable = interface(JCharSequence)
    ['{A8BBE246-26EE-44F1-A467-779D080957A0}']
    function append(text: JCharSequence): JEditable; cdecl; overload;
    function append(text: JCharSequence; start: Integer; end_: Integer): JEditable; cdecl; overload;
    function append(text: Char): JEditable; cdecl; overload;
    procedure clear; cdecl;
    procedure clearSpans; cdecl;
    function delete(st: Integer; en: Integer): JEditable; cdecl;
    function getFilters: TJavaObjectArray<JInputFilter>; cdecl;
    function insert(where: Integer; text: JCharSequence; start: Integer; end_: Integer): JEditable; cdecl; overload;
    function insert(where: Integer; text: JCharSequence): JEditable; cdecl; overload;
    function replace(st: Integer; en: Integer; source: JCharSequence; start: Integer; end_: Integer): JEditable; cdecl; overload;
    function replace(st: Integer; en: Integer; text: JCharSequence): JEditable; cdecl; overload;
    procedure setFilters(filters: TJavaObjectArray<JInputFilter>); cdecl;
  end;
  TJEditable = class(TJavaGenericImport<JEditableClass, JEditable>) end;

  JEditable_FactoryClass = interface(JObjectClass)
    ['{638B498B-C0BF-4778-BA84-BA1C20F8C197}']
    {class} function init: JEditable_Factory; cdecl;
    {class} function getInstance: JEditable_Factory; cdecl;
  end;

  [JavaSignature('android/text/Editable$Factory')]
  JEditable_Factory = interface(JObject)
    ['{C5E77FBA-6429-4997-A8BB-56D758B07E3A}']
    function newEditable(source: JCharSequence): JEditable; cdecl;
  end;
  TJEditable_Factory = class(TJavaGenericImport<JEditable_FactoryClass, JEditable_Factory>) end;

  JInputFilterClass = interface(IJavaClass)
    ['{A71F6CCA-A2D4-4557-A1AB-8DBC3A519936}']
  end;

  [JavaSignature('android/text/InputFilter')]
  JInputFilter = interface(IJavaInstance)
    ['{B6E265A5-32DE-4AA1-BD61-93217E5B53DB}']
    function filter(source: JCharSequence; start: Integer; end_: Integer; dest: JSpanned; dstart: Integer; dend: Integer): JCharSequence; cdecl;
  end;
  TJInputFilter = class(TJavaGenericImport<JInputFilterClass, JInputFilter>) end;

  JInputTypeClass = interface(IJavaClass)
    ['{2704D6AD-D90D-4CA7-838F-AD766525083E}']
    {class} function _GetTYPE_CLASS_DATETIME: Integer; cdecl;
    {class} function _GetTYPE_CLASS_NUMBER: Integer; cdecl;
    {class} function _GetTYPE_CLASS_PHONE: Integer; cdecl;
    {class} function _GetTYPE_CLASS_TEXT: Integer; cdecl;
    {class} function _GetTYPE_DATETIME_VARIATION_DATE: Integer; cdecl;
    {class} function _GetTYPE_DATETIME_VARIATION_NORMAL: Integer; cdecl;
    {class} function _GetTYPE_DATETIME_VARIATION_TIME: Integer; cdecl;
    {class} function _GetTYPE_MASK_CLASS: Integer; cdecl;
    {class} function _GetTYPE_MASK_FLAGS: Integer; cdecl;
    {class} function _GetTYPE_MASK_VARIATION: Integer; cdecl;
    {class} function _GetTYPE_NULL: Integer; cdecl;
    {class} function _GetTYPE_NUMBER_FLAG_DECIMAL: Integer; cdecl;
    {class} function _GetTYPE_NUMBER_FLAG_SIGNED: Integer; cdecl;
    {class} function _GetTYPE_NUMBER_VARIATION_NORMAL: Integer; cdecl;
    {class} function _GetTYPE_NUMBER_VARIATION_PASSWORD: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_AUTO_COMPLETE: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_AUTO_CORRECT: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_CAP_CHARACTERS: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_CAP_SENTENCES: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_CAP_WORDS: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_IME_MULTI_LINE: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_MULTI_LINE: Integer; cdecl;
    {class} function _GetTYPE_TEXT_FLAG_NO_SUGGESTIONS: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_EMAIL_ADDRESS: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_EMAIL_SUBJECT: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_FILTER: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_LONG_MESSAGE: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_NORMAL: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_PASSWORD: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_PERSON_NAME: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_PHONETIC: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_POSTAL_ADDRESS: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_SHORT_MESSAGE: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_URI: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_VISIBLE_PASSWORD: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_WEB_EDIT_TEXT: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS: Integer; cdecl;
    {class} function _GetTYPE_TEXT_VARIATION_WEB_PASSWORD: Integer; cdecl;
    {class} property TYPE_CLASS_DATETIME: Integer read _GetTYPE_CLASS_DATETIME;
    {class} property TYPE_CLASS_NUMBER: Integer read _GetTYPE_CLASS_NUMBER;
    {class} property TYPE_CLASS_PHONE: Integer read _GetTYPE_CLASS_PHONE;
    {class} property TYPE_CLASS_TEXT: Integer read _GetTYPE_CLASS_TEXT;
    {class} property TYPE_DATETIME_VARIATION_DATE: Integer read _GetTYPE_DATETIME_VARIATION_DATE;
    {class} property TYPE_DATETIME_VARIATION_NORMAL: Integer read _GetTYPE_DATETIME_VARIATION_NORMAL;
    {class} property TYPE_DATETIME_VARIATION_TIME: Integer read _GetTYPE_DATETIME_VARIATION_TIME;
    {class} property TYPE_MASK_CLASS: Integer read _GetTYPE_MASK_CLASS;
    {class} property TYPE_MASK_FLAGS: Integer read _GetTYPE_MASK_FLAGS;
    {class} property TYPE_MASK_VARIATION: Integer read _GetTYPE_MASK_VARIATION;
    {class} property TYPE_NULL: Integer read _GetTYPE_NULL;
    {class} property TYPE_NUMBER_FLAG_DECIMAL: Integer read _GetTYPE_NUMBER_FLAG_DECIMAL;
    {class} property TYPE_NUMBER_FLAG_SIGNED: Integer read _GetTYPE_NUMBER_FLAG_SIGNED;
    {class} property TYPE_NUMBER_VARIATION_NORMAL: Integer read _GetTYPE_NUMBER_VARIATION_NORMAL;
    {class} property TYPE_NUMBER_VARIATION_PASSWORD: Integer read _GetTYPE_NUMBER_VARIATION_PASSWORD;
    {class} property TYPE_TEXT_FLAG_AUTO_COMPLETE: Integer read _GetTYPE_TEXT_FLAG_AUTO_COMPLETE;
    {class} property TYPE_TEXT_FLAG_AUTO_CORRECT: Integer read _GetTYPE_TEXT_FLAG_AUTO_CORRECT;
    {class} property TYPE_TEXT_FLAG_CAP_CHARACTERS: Integer read _GetTYPE_TEXT_FLAG_CAP_CHARACTERS;
    {class} property TYPE_TEXT_FLAG_CAP_SENTENCES: Integer read _GetTYPE_TEXT_FLAG_CAP_SENTENCES;
    {class} property TYPE_TEXT_FLAG_CAP_WORDS: Integer read _GetTYPE_TEXT_FLAG_CAP_WORDS;
    {class} property TYPE_TEXT_FLAG_IME_MULTI_LINE: Integer read _GetTYPE_TEXT_FLAG_IME_MULTI_LINE;
    {class} property TYPE_TEXT_FLAG_MULTI_LINE: Integer read _GetTYPE_TEXT_FLAG_MULTI_LINE;
    {class} property TYPE_TEXT_FLAG_NO_SUGGESTIONS: Integer read _GetTYPE_TEXT_FLAG_NO_SUGGESTIONS;
    {class} property TYPE_TEXT_VARIATION_EMAIL_ADDRESS: Integer read _GetTYPE_TEXT_VARIATION_EMAIL_ADDRESS;
    {class} property TYPE_TEXT_VARIATION_EMAIL_SUBJECT: Integer read _GetTYPE_TEXT_VARIATION_EMAIL_SUBJECT;
    {class} property TYPE_TEXT_VARIATION_FILTER: Integer read _GetTYPE_TEXT_VARIATION_FILTER;
    {class} property TYPE_TEXT_VARIATION_LONG_MESSAGE: Integer read _GetTYPE_TEXT_VARIATION_LONG_MESSAGE;
    {class} property TYPE_TEXT_VARIATION_NORMAL: Integer read _GetTYPE_TEXT_VARIATION_NORMAL;
    {class} property TYPE_TEXT_VARIATION_PASSWORD: Integer read _GetTYPE_TEXT_VARIATION_PASSWORD;
    {class} property TYPE_TEXT_VARIATION_PERSON_NAME: Integer read _GetTYPE_TEXT_VARIATION_PERSON_NAME;
    {class} property TYPE_TEXT_VARIATION_PHONETIC: Integer read _GetTYPE_TEXT_VARIATION_PHONETIC;
    {class} property TYPE_TEXT_VARIATION_POSTAL_ADDRESS: Integer read _GetTYPE_TEXT_VARIATION_POSTAL_ADDRESS;
    {class} property TYPE_TEXT_VARIATION_SHORT_MESSAGE: Integer read _GetTYPE_TEXT_VARIATION_SHORT_MESSAGE;
    {class} property TYPE_TEXT_VARIATION_URI: Integer read _GetTYPE_TEXT_VARIATION_URI;
    {class} property TYPE_TEXT_VARIATION_VISIBLE_PASSWORD: Integer read _GetTYPE_TEXT_VARIATION_VISIBLE_PASSWORD;
    {class} property TYPE_TEXT_VARIATION_WEB_EDIT_TEXT: Integer read _GetTYPE_TEXT_VARIATION_WEB_EDIT_TEXT;
    {class} property TYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS: Integer read _GetTYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS;
    {class} property TYPE_TEXT_VARIATION_WEB_PASSWORD: Integer read _GetTYPE_TEXT_VARIATION_WEB_PASSWORD;
  end;

  [JavaSignature('android/text/InputType')]
  JInputType = interface(IJavaInstance)
    ['{6FC86E96-FCF0-4BDB-9815-162E3696871D}']
  end;
  TJInputType = class(TJavaGenericImport<JInputTypeClass, JInputType>) end;

  JLayoutClass = interface(JObjectClass)
    ['{56DBEDE9-766B-47BD-97F5-9DB7136FFAA3}']
    {class} function _GetBREAK_STRATEGY_BALANCED: Integer; cdecl;
    {class} function _GetBREAK_STRATEGY_HIGH_QUALITY: Integer; cdecl;
    {class} function _GetBREAK_STRATEGY_SIMPLE: Integer; cdecl;
    {class} function _GetDIR_LEFT_TO_RIGHT: Integer; cdecl;
    {class} function _GetDIR_RIGHT_TO_LEFT: Integer; cdecl;
    {class} function _GetHYPHENATION_FREQUENCY_FULL: Integer; cdecl;
    {class} function _GetHYPHENATION_FREQUENCY_NONE: Integer; cdecl;
    {class} function _GetHYPHENATION_FREQUENCY_NORMAL: Integer; cdecl;
    {class} function getDesiredWidth(source: JCharSequence; paint: JTextPaint): Single; cdecl; overload;
    {class} function getDesiredWidth(source: JCharSequence; start: Integer; end_: Integer; paint: JTextPaint): Single; cdecl; overload;
    {class} property BREAK_STRATEGY_BALANCED: Integer read _GetBREAK_STRATEGY_BALANCED;
    {class} property BREAK_STRATEGY_HIGH_QUALITY: Integer read _GetBREAK_STRATEGY_HIGH_QUALITY;
    {class} property BREAK_STRATEGY_SIMPLE: Integer read _GetBREAK_STRATEGY_SIMPLE;
    {class} property DIR_LEFT_TO_RIGHT: Integer read _GetDIR_LEFT_TO_RIGHT;
    {class} property DIR_RIGHT_TO_LEFT: Integer read _GetDIR_RIGHT_TO_LEFT;
    {class} property HYPHENATION_FREQUENCY_FULL: Integer read _GetHYPHENATION_FREQUENCY_FULL;
    {class} property HYPHENATION_FREQUENCY_NONE: Integer read _GetHYPHENATION_FREQUENCY_NONE;
    {class} property HYPHENATION_FREQUENCY_NORMAL: Integer read _GetHYPHENATION_FREQUENCY_NORMAL;
  end;

  [JavaSignature('android/text/Layout')]
  JLayout = interface(JObject)
    ['{606D9AE7-D751-4FC9-A68F-B30C347B5CD4}']
    procedure draw(c: JCanvas); cdecl; overload;
    procedure draw(canvas: JCanvas; highlight: JPath; highlightPaint: JPaint; cursorOffsetVertical: Integer); cdecl; overload;
    function getAlignment: JLayout_Alignment; cdecl;
    function getBottomPadding: Integer; cdecl;
    procedure getCursorPath(point: Integer; dest: JPath; editingBuffer: JCharSequence); cdecl;
    function getEllipsisCount(line: Integer): Integer; cdecl;
    function getEllipsisStart(line: Integer): Integer; cdecl;
    function getEllipsizedWidth: Integer; cdecl;
    function getHeight: Integer; cdecl;
    function getLineAscent(line: Integer): Integer; cdecl;
    function getLineBaseline(line: Integer): Integer; cdecl;
    function getLineBottom(line: Integer): Integer; cdecl;
    function getLineBounds(line: Integer; bounds: JRect): Integer; cdecl;
    function getLineContainsTab(line: Integer): Boolean; cdecl;
    function getLineCount: Integer; cdecl;
    function getLineDescent(line: Integer): Integer; cdecl;
    function getLineDirections(line: Integer): JLayout_Directions; cdecl;
    function getLineEnd(line: Integer): Integer; cdecl;
    function getLineForOffset(offset: Integer): Integer; cdecl;
    function getLineForVertical(vertical: Integer): Integer; cdecl;
    function getLineLeft(line: Integer): Single; cdecl;
    function getLineMax(line: Integer): Single; cdecl;
    function getLineRight(line: Integer): Single; cdecl;
    function getLineStart(line: Integer): Integer; cdecl;
    function getLineTop(line: Integer): Integer; cdecl;
    function getLineVisibleEnd(line: Integer): Integer; cdecl;
    function getLineWidth(line: Integer): Single; cdecl;
    function getOffsetForHorizontal(line: Integer; horiz: Single): Integer; cdecl;
    function getOffsetToLeftOf(offset: Integer): Integer; cdecl;
    function getOffsetToRightOf(offset: Integer): Integer; cdecl;
    function getPaint: JTextPaint; cdecl;
    function getParagraphAlignment(line: Integer): JLayout_Alignment; cdecl;
    function getParagraphDirection(line: Integer): Integer; cdecl;
    function getParagraphLeft(line: Integer): Integer; cdecl;
    function getParagraphRight(line: Integer): Integer; cdecl;
    function getPrimaryHorizontal(offset: Integer): Single; cdecl;
    function getSecondaryHorizontal(offset: Integer): Single; cdecl;
    procedure getSelectionPath(start: Integer; end_: Integer; dest: JPath); cdecl;
    function getSpacingAdd: Single; cdecl;
    function getSpacingMultiplier: Single; cdecl;
    function getText: JCharSequence; cdecl;
    function getTopPadding: Integer; cdecl;
    function getWidth: Integer; cdecl;
    procedure increaseWidthTo(wid: Integer); cdecl;
    function isRtlCharAt(offset: Integer): Boolean; cdecl;
  end;
  TJLayout = class(TJavaGenericImport<JLayoutClass, JLayout>) end;

  JLayout_AlignmentClass = interface(JEnumClass)
    ['{9C9DD4F5-EF2D-4920-8C97-F5BA540F393D}']
    {class} function _GetALIGN_CENTER: JLayout_Alignment; cdecl;
    {class} function _GetALIGN_NORMAL: JLayout_Alignment; cdecl;
    {class} function _GetALIGN_OPPOSITE: JLayout_Alignment; cdecl;
    {class} function valueOf(name: JString): JLayout_Alignment; cdecl;
    {class} function values: TJavaObjectArray<JLayout_Alignment>; cdecl;
    {class} property ALIGN_CENTER: JLayout_Alignment read _GetALIGN_CENTER;
    {class} property ALIGN_NORMAL: JLayout_Alignment read _GetALIGN_NORMAL;
    {class} property ALIGN_OPPOSITE: JLayout_Alignment read _GetALIGN_OPPOSITE;
  end;

  [JavaSignature('android/text/Layout$Alignment')]
  JLayout_Alignment = interface(JEnum)
    ['{93E74BAF-E0DC-4F08-8E4D-C58CA4EAB0AE}']
  end;
  TJLayout_Alignment = class(TJavaGenericImport<JLayout_AlignmentClass, JLayout_Alignment>) end;

  JLayout_DirectionsClass = interface(JObjectClass)
    ['{2956EB3F-0228-4359-93CD-12038DA23E7E}']
  end;

  [JavaSignature('android/text/Layout$Directions')]
  JLayout_Directions = interface(JObject)
    ['{C170D193-15D6-4B26-AAB2-979CC7FBA049}']
  end;
  TJLayout_Directions = class(TJavaGenericImport<JLayout_DirectionsClass, JLayout_Directions>) end;

  JNoCopySpanClass = interface(IJavaClass)
    ['{2C00BEC5-5ECB-44BC-ABC4-1C5EB4986AA8}']
  end;

  [JavaSignature('android/text/NoCopySpan')]
  JNoCopySpan = interface(IJavaInstance)
    ['{E9CC4E75-A421-457C-89E1-7B76557934D7}']
  end;
  TJNoCopySpan = class(TJavaGenericImport<JNoCopySpanClass, JNoCopySpan>) end;

  JSpannedClass = interface(JCharSequenceClass)
    ['{9F00483B-3D41-4307-A016-4CCC278AAB57}']
    {class} function _GetSPAN_COMPOSING: Integer; cdecl;
    {class} function _GetSPAN_EXCLUSIVE_EXCLUSIVE: Integer; cdecl;
    {class} function _GetSPAN_EXCLUSIVE_INCLUSIVE: Integer; cdecl;
    {class} function _GetSPAN_INCLUSIVE_EXCLUSIVE: Integer; cdecl;
    {class} function _GetSPAN_INCLUSIVE_INCLUSIVE: Integer; cdecl;
    {class} function _GetSPAN_INTERMEDIATE: Integer; cdecl;
    {class} function _GetSPAN_MARK_MARK: Integer; cdecl;
    {class} function _GetSPAN_MARK_POINT: Integer; cdecl;
    {class} function _GetSPAN_PARAGRAPH: Integer; cdecl;
    {class} function _GetSPAN_POINT_MARK: Integer; cdecl;
    {class} function _GetSPAN_POINT_MARK_MASK: Integer; cdecl;
    {class} function _GetSPAN_POINT_POINT: Integer; cdecl;
    {class} function _GetSPAN_PRIORITY: Integer; cdecl;
    {class} function _GetSPAN_PRIORITY_SHIFT: Integer; cdecl;
    {class} function _GetSPAN_USER: Integer; cdecl;
    {class} function _GetSPAN_USER_SHIFT: Integer; cdecl;
    {class} property SPAN_COMPOSING: Integer read _GetSPAN_COMPOSING;
    {class} property SPAN_EXCLUSIVE_EXCLUSIVE: Integer read _GetSPAN_EXCLUSIVE_EXCLUSIVE;
    {class} property SPAN_EXCLUSIVE_INCLUSIVE: Integer read _GetSPAN_EXCLUSIVE_INCLUSIVE;
    {class} property SPAN_INCLUSIVE_EXCLUSIVE: Integer read _GetSPAN_INCLUSIVE_EXCLUSIVE;
    {class} property SPAN_INCLUSIVE_INCLUSIVE: Integer read _GetSPAN_INCLUSIVE_INCLUSIVE;
    {class} property SPAN_INTERMEDIATE: Integer read _GetSPAN_INTERMEDIATE;
    {class} property SPAN_MARK_MARK: Integer read _GetSPAN_MARK_MARK;
    {class} property SPAN_MARK_POINT: Integer read _GetSPAN_MARK_POINT;
    {class} property SPAN_PARAGRAPH: Integer read _GetSPAN_PARAGRAPH;
    {class} property SPAN_POINT_MARK: Integer read _GetSPAN_POINT_MARK;
    {class} property SPAN_POINT_MARK_MASK: Integer read _GetSPAN_POINT_MARK_MASK;
    {class} property SPAN_POINT_POINT: Integer read _GetSPAN_POINT_POINT;
    {class} property SPAN_PRIORITY: Integer read _GetSPAN_PRIORITY;
    {class} property SPAN_PRIORITY_SHIFT: Integer read _GetSPAN_PRIORITY_SHIFT;
    {class} property SPAN_USER: Integer read _GetSPAN_USER;
    {class} property SPAN_USER_SHIFT: Integer read _GetSPAN_USER_SHIFT;
  end;

  [JavaSignature('android/text/Spanned')]
  JSpanned = interface(JCharSequence)
    ['{534DAF98-ED56-41E4-8CCC-74687680B667}']
    function getSpanEnd(tag: JObject): Integer; cdecl;
    function getSpanFlags(tag: JObject): Integer; cdecl;
    function getSpanStart(tag: JObject): Integer; cdecl;
    function getSpans(start: Integer; end_: Integer; type_: Jlang_Class): TJavaObjectArray<JObject>; cdecl;
    function nextSpanTransition(start: Integer; limit: Integer; type_: Jlang_Class): Integer; cdecl;
  end;
  TJSpanned = class(TJavaGenericImport<JSpannedClass, JSpanned>) end;

  JSpannableClass = interface(JSpannedClass)
    ['{5FAF8DF3-F895-499D-9C35-1F4F5575A22C}']
  end;

  [JavaSignature('android/text/Spannable')]
  JSpannable = interface(JSpanned)
    ['{D9F023CA-ADC4-4C2F-A7F7-8B44324183B2}']
    procedure removeSpan(what: JObject); cdecl;
    procedure setSpan(what: JObject; start: Integer; end_: Integer; flags: Integer); cdecl;
  end;
  TJSpannable = class(TJavaGenericImport<JSpannableClass, JSpannable>) end;

  JSpannable_FactoryClass = interface(JObjectClass)
    ['{D715DAF0-9891-4F6A-8625-FEB82A2EB8F5}']
    {class} function init: JSpannable_Factory; cdecl;
    {class} function getInstance: JSpannable_Factory; cdecl;
  end;

  [JavaSignature('android/text/Spannable$Factory')]
  JSpannable_Factory = interface(JObject)
    ['{C7DCC285-BA5B-4B63-B003-5DC3FB9791FC}']
    function newSpannable(source: JCharSequence): JSpannable; cdecl;
  end;
  TJSpannable_Factory = class(TJavaGenericImport<JSpannable_FactoryClass, JSpannable_Factory>) end;

  JTextPaintClass = interface(JPaintClass)
    ['{A0A7AA51-6729-4C37-8256-B45690967C11}']
    {class} function init: JTextPaint; cdecl; overload;
    {class} function init(flags: Integer): JTextPaint; cdecl; overload;
    {class} function init(p: JPaint): JTextPaint; cdecl; overload;
  end;

  [JavaSignature('android/text/TextPaint')]
  JTextPaint = interface(JPaint)
    ['{790B2C3F-B6A0-43D9-9CD7-6312133D19F4}']
    function _GetbaselineShift: Integer; cdecl;
    procedure _SetbaselineShift(Value: Integer); cdecl;
    function _GetbgColor: Integer; cdecl;
    procedure _SetbgColor(Value: Integer); cdecl;
    function _Getdensity: Single; cdecl;
    procedure _Setdensity(Value: Single); cdecl;
    function _GetdrawableState: TJavaArray<Integer>; cdecl;
    procedure _SetdrawableState(Value: TJavaArray<Integer>); cdecl;
    function _GetlinkColor: Integer; cdecl;
    procedure _SetlinkColor(Value: Integer); cdecl;
    procedure &set(tp: JTextPaint); cdecl;
    property baselineShift: Integer read _GetbaselineShift write _SetbaselineShift;
    property bgColor: Integer read _GetbgColor write _SetbgColor;
    property density: Single read _Getdensity write _Setdensity;
    property drawableState: TJavaArray<Integer> read _GetdrawableState write _SetdrawableState;
    property linkColor: Integer read _GetlinkColor write _SetlinkColor;
  end;
  TJTextPaint = class(TJavaGenericImport<JTextPaintClass, JTextPaint>) end;

  JTextUtils_TruncateAtClass = interface(JEnumClass)
    ['{9339BF23-272E-4F60-B4A3-99F66622C905}']
    {class} function _GetEND: JTextUtils_TruncateAt; cdecl;
    {class} function _GetMARQUEE: JTextUtils_TruncateAt; cdecl;
    {class} function _GetMIDDLE: JTextUtils_TruncateAt; cdecl;
    {class} function _GetSTART: JTextUtils_TruncateAt; cdecl;
    {class} function valueOf(name: JString): JTextUtils_TruncateAt; cdecl;
    {class} function values: TJavaObjectArray<JTextUtils_TruncateAt>; cdecl;
    {class} property &END: JTextUtils_TruncateAt read _GetEND;
    {class} property MARQUEE: JTextUtils_TruncateAt read _GetMARQUEE;
    {class} property MIDDLE: JTextUtils_TruncateAt read _GetMIDDLE;
    {class} property START: JTextUtils_TruncateAt read _GetSTART;
  end;

  [JavaSignature('android/text/TextUtils$TruncateAt')]
  JTextUtils_TruncateAt = interface(JEnum)
    ['{96820C13-A2B2-48F2-B37E-E86918C45DA8}']
  end;
  TJTextUtils_TruncateAt = class(TJavaGenericImport<JTextUtils_TruncateAtClass, JTextUtils_TruncateAt>) end;

  JTextWatcherClass = interface(JNoCopySpanClass)
    ['{68D3C86E-F1BC-44A3-BBD3-7AB0FD9439D5}']
  end;

  [JavaSignature('android/text/TextWatcher')]
  JTextWatcher = interface(JNoCopySpan)
    ['{63D741B9-2232-4298-97E0-098F283B7BB6}']
    procedure afterTextChanged(s: JEditable); cdecl;
    procedure beforeTextChanged(s: JCharSequence; start: Integer; count: Integer; after: Integer); cdecl;
    procedure onTextChanged(s: JCharSequence; start: Integer; before: Integer; count: Integer); cdecl;
  end;
  TJTextWatcher = class(TJavaGenericImport<JTextWatcherClass, JTextWatcher>) end;

  JKeyListenerClass = interface(IJavaClass)
    ['{1CD6D223-B165-472F-B0EF-654B16926EF0}']
  end;

  [JavaSignature('android/text/method/KeyListener')]
  JKeyListener = interface(IJavaInstance)
    ['{C007FF58-EB56-423A-831C-AD7EC2052127}']
    procedure clearMetaKeyState(view: JView; content: JEditable; states: Integer); cdecl;
    function getInputType: Integer; cdecl;
    function onKeyDown(view: JView; text: JEditable; keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyOther(view: JView; text: JEditable; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(view: JView; text: JEditable; keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
  end;
  TJKeyListener = class(TJavaGenericImport<JKeyListenerClass, JKeyListener>) end;

  JMovementMethodClass = interface(IJavaClass)
    ['{21F834F1-0829-4581-9FEA-E2216D381318}']
  end;

  [JavaSignature('android/text/method/MovementMethod')]
  JMovementMethod = interface(IJavaInstance)
    ['{EFED977D-0439-48A4-B9EF-2AC4C3017AB8}']
    function canSelectArbitrarily: Boolean; cdecl;
    //procedure initialize(widget: JTextView; text: JSpannable); cdecl;
    //function onGenericMotionEvent(widget: JTextView; text: JSpannable; event: JMotionEvent): Boolean; cdecl;
    //function onKeyDown(widget: JTextView; text: JSpannable; keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    //function onKeyOther(view: JTextView; text: JSpannable; event: JKeyEvent): Boolean; cdecl;
    //function onKeyUp(widget: JTextView; text: JSpannable; keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    //procedure onTakeFocus(widget: JTextView; text: JSpannable; direction: Integer); cdecl;
    //function onTouchEvent(widget: JTextView; text: JSpannable; event: JMotionEvent): Boolean; cdecl;
    //function onTrackballEvent(widget: JTextView; text: JSpannable; event: JMotionEvent): Boolean; cdecl;
  end;
  TJMovementMethod = class(TJavaGenericImport<JMovementMethodClass, JMovementMethod>) end;

  JTransformationMethodClass = interface(IJavaClass)
    ['{D5A74199-7E85-4AFB-B4AF-6DEC7C41766D}']
  end;

  [JavaSignature('android/text/method/TransformationMethod')]
  JTransformationMethod = interface(IJavaInstance)
    ['{C442A623-FB0B-43A9-A8CD-AD423AEEE451}']
    function getTransformation(source: JCharSequence; view: JView): JCharSequence; cdecl;
    procedure onFocusChanged(view: JView; sourceText: JCharSequence; focused: Boolean; direction: Integer; previouslyFocusedRect: JRect); cdecl;
  end;
  TJTransformationMethod = class(TJavaGenericImport<JTransformationMethodClass, JTransformationMethod>) end;

  JCharacterStyleClass = interface(JObjectClass)
    ['{CDC00A8A-001E-4012-9B1A-E2B8A5EA13EB}']
    {class} function init: JCharacterStyle; cdecl;
    {class} function wrap(cs: JCharacterStyle): JCharacterStyle; cdecl;
  end;

  [JavaSignature('android/text/style/CharacterStyle')]
  JCharacterStyle = interface(JObject)
    ['{9785229B-10B2-435D-AF2C-2A02622EEAA6}']
    function getUnderlying: JCharacterStyle; cdecl;
    procedure updateDrawState(tp: JTextPaint); cdecl;
  end;
  TJCharacterStyle = class(TJavaGenericImport<JCharacterStyleClass, JCharacterStyle>) end;

  JClickableSpanClass = interface(JCharacterStyleClass)
    ['{A2958C1E-9CF3-48BC-84C1-404992C708E7}']
    {class} function init: JClickableSpan; cdecl;
  end;

  [JavaSignature('android/text/style/ClickableSpan')]
  JClickableSpan = interface(JCharacterStyle)
    ['{7749B988-4ADD-4E17-9F64-BA50060D2BCA}']
    procedure onClick(widget: JView); cdecl;
    procedure updateDrawState(ds: JTextPaint); cdecl;
  end;
  TJClickableSpan = class(TJavaGenericImport<JClickableSpanClass, JClickableSpan>) end;

  JTtsSpanClass = interface(JObjectClass)
    ['{D5A409A5-7613-4D51-ACAE-B325B616474C}']
    {class} function _GetANIMACY_ANIMATE: JString; cdecl;
    {class} function _GetANIMACY_INANIMATE: JString; cdecl;
    {class} function _GetARG_ANIMACY: JString; cdecl;
    {class} function _GetARG_CASE: JString; cdecl;
    {class} function _GetARG_COUNTRY_CODE: JString; cdecl;
    {class} function _GetARG_CURRENCY: JString; cdecl;
    {class} function _GetARG_DAY: JString; cdecl;
    {class} function _GetARG_DENOMINATOR: JString; cdecl;
    {class} function _GetARG_DIGITS: JString; cdecl;
    {class} function _GetARG_DOMAIN: JString; cdecl;
    {class} function _GetARG_EXTENSION: JString; cdecl;
    {class} function _GetARG_FRACTIONAL_PART: JString; cdecl;
    {class} function _GetARG_FRAGMENT_ID: JString; cdecl;
    {class} function _GetARG_GENDER: JString; cdecl;
    {class} function _GetARG_HOURS: JString; cdecl;
    {class} function _GetARG_INTEGER_PART: JString; cdecl;
    {class} function _GetARG_MINUTES: JString; cdecl;
    {class} function _GetARG_MONTH: JString; cdecl;
    {class} function _GetARG_MULTIPLICITY: JString; cdecl;
    {class} function _GetARG_NUMBER: JString; cdecl;
    {class} function _GetARG_NUMBER_PARTS: JString; cdecl;
    {class} function _GetARG_NUMERATOR: JString; cdecl;
    {class} function _GetARG_PASSWORD: JString; cdecl;
    {class} function _GetARG_PATH: JString; cdecl;
    {class} function _GetARG_PORT: JString; cdecl;
    {class} function _GetARG_PROTOCOL: JString; cdecl;
    {class} function _GetARG_QUANTITY: JString; cdecl;
    {class} function _GetARG_QUERY_STRING: JString; cdecl;
    {class} function _GetARG_TEXT: JString; cdecl;
    {class} function _GetARG_UNIT: JString; cdecl;
    {class} function _GetARG_USERNAME: JString; cdecl;
    {class} function _GetARG_VERBATIM: JString; cdecl;
    {class} function _GetARG_WEEKDAY: JString; cdecl;
    {class} function _GetARG_YEAR: JString; cdecl;
    {class} function _GetCASE_ABLATIVE: JString; cdecl;
    {class} function _GetCASE_ACCUSATIVE: JString; cdecl;
    {class} function _GetCASE_DATIVE: JString; cdecl;
    {class} function _GetCASE_GENITIVE: JString; cdecl;
    {class} function _GetCASE_INSTRUMENTAL: JString; cdecl;
    {class} function _GetCASE_LOCATIVE: JString; cdecl;
    {class} function _GetCASE_NOMINATIVE: JString; cdecl;
    {class} function _GetCASE_VOCATIVE: JString; cdecl;
    {class} function _GetGENDER_FEMALE: JString; cdecl;
    {class} function _GetGENDER_MALE: JString; cdecl;
    {class} function _GetGENDER_NEUTRAL: JString; cdecl;
    {class} function _GetMONTH_APRIL: Integer; cdecl;
    {class} function _GetMONTH_AUGUST: Integer; cdecl;
    {class} function _GetMONTH_DECEMBER: Integer; cdecl;
    {class} function _GetMONTH_FEBRUARY: Integer; cdecl;
    {class} function _GetMONTH_JANUARY: Integer; cdecl;
    {class} function _GetMONTH_JULY: Integer; cdecl;
    {class} function _GetMONTH_JUNE: Integer; cdecl;
    {class} function _GetMONTH_MARCH: Integer; cdecl;
    {class} function _GetMONTH_MAY: Integer; cdecl;
    {class} function _GetMONTH_NOVEMBER: Integer; cdecl;
    {class} function _GetMONTH_OCTOBER: Integer; cdecl;
    {class} function _GetMONTH_SEPTEMBER: Integer; cdecl;
    {class} function _GetMULTIPLICITY_DUAL: JString; cdecl;
    {class} function _GetMULTIPLICITY_PLURAL: JString; cdecl;
    {class} function _GetMULTIPLICITY_SINGLE: JString; cdecl;
    {class} function _GetTYPE_CARDINAL: JString; cdecl;
    {class} function _GetTYPE_DATE: JString; cdecl;
    {class} function _GetTYPE_DECIMAL: JString; cdecl;
    {class} function _GetTYPE_DIGITS: JString; cdecl;
    {class} function _GetTYPE_ELECTRONIC: JString; cdecl;
    {class} function _GetTYPE_FRACTION: JString; cdecl;
    {class} function _GetTYPE_MEASURE: JString; cdecl;
    {class} function _GetTYPE_MONEY: JString; cdecl;
    {class} function _GetTYPE_ORDINAL: JString; cdecl;
    {class} function _GetTYPE_TELEPHONE: JString; cdecl;
    {class} function _GetTYPE_TEXT: JString; cdecl;
    {class} function _GetTYPE_TIME: JString; cdecl;
    {class} function _GetTYPE_VERBATIM: JString; cdecl;
    {class} function _GetWEEKDAY_FRIDAY: Integer; cdecl;
    {class} function _GetWEEKDAY_MONDAY: Integer; cdecl;
    {class} function _GetWEEKDAY_SATURDAY: Integer; cdecl;
    {class} function _GetWEEKDAY_SUNDAY: Integer; cdecl;
    {class} function _GetWEEKDAY_THURSDAY: Integer; cdecl;
    {class} function _GetWEEKDAY_TUESDAY: Integer; cdecl;
    {class} function _GetWEEKDAY_WEDNESDAY: Integer; cdecl;
    {class} function init(type_: JString; args: JPersistableBundle): JTtsSpan; cdecl; overload;
    {class} function init(src: JParcel): JTtsSpan; cdecl; overload;
    {class} property ANIMACY_ANIMATE: JString read _GetANIMACY_ANIMATE;
    {class} property ANIMACY_INANIMATE: JString read _GetANIMACY_INANIMATE;
    {class} property ARG_ANIMACY: JString read _GetARG_ANIMACY;
    {class} property ARG_CASE: JString read _GetARG_CASE;
    {class} property ARG_COUNTRY_CODE: JString read _GetARG_COUNTRY_CODE;
    {class} property ARG_CURRENCY: JString read _GetARG_CURRENCY;
    {class} property ARG_DAY: JString read _GetARG_DAY;
    {class} property ARG_DENOMINATOR: JString read _GetARG_DENOMINATOR;
    {class} property ARG_DIGITS: JString read _GetARG_DIGITS;
    {class} property ARG_DOMAIN: JString read _GetARG_DOMAIN;
    {class} property ARG_EXTENSION: JString read _GetARG_EXTENSION;
    {class} property ARG_FRACTIONAL_PART: JString read _GetARG_FRACTIONAL_PART;
    {class} property ARG_FRAGMENT_ID: JString read _GetARG_FRAGMENT_ID;
    {class} property ARG_GENDER: JString read _GetARG_GENDER;
    {class} property ARG_HOURS: JString read _GetARG_HOURS;
    {class} property ARG_INTEGER_PART: JString read _GetARG_INTEGER_PART;
    {class} property ARG_MINUTES: JString read _GetARG_MINUTES;
    {class} property ARG_MONTH: JString read _GetARG_MONTH;
    {class} property ARG_MULTIPLICITY: JString read _GetARG_MULTIPLICITY;
    {class} property ARG_NUMBER: JString read _GetARG_NUMBER;
    {class} property ARG_NUMBER_PARTS: JString read _GetARG_NUMBER_PARTS;
    {class} property ARG_NUMERATOR: JString read _GetARG_NUMERATOR;
    {class} property ARG_PASSWORD: JString read _GetARG_PASSWORD;
    {class} property ARG_PATH: JString read _GetARG_PATH;
    {class} property ARG_PORT: JString read _GetARG_PORT;
    {class} property ARG_PROTOCOL: JString read _GetARG_PROTOCOL;
    {class} property ARG_QUANTITY: JString read _GetARG_QUANTITY;
    {class} property ARG_QUERY_STRING: JString read _GetARG_QUERY_STRING;
    {class} property ARG_TEXT: JString read _GetARG_TEXT;
    {class} property ARG_UNIT: JString read _GetARG_UNIT;
    {class} property ARG_USERNAME: JString read _GetARG_USERNAME;
    {class} property ARG_VERBATIM: JString read _GetARG_VERBATIM;
    {class} property ARG_WEEKDAY: JString read _GetARG_WEEKDAY;
    {class} property ARG_YEAR: JString read _GetARG_YEAR;
    {class} property CASE_ABLATIVE: JString read _GetCASE_ABLATIVE;
    {class} property CASE_ACCUSATIVE: JString read _GetCASE_ACCUSATIVE;
    {class} property CASE_DATIVE: JString read _GetCASE_DATIVE;
    {class} property CASE_GENITIVE: JString read _GetCASE_GENITIVE;
    {class} property CASE_INSTRUMENTAL: JString read _GetCASE_INSTRUMENTAL;
    {class} property CASE_LOCATIVE: JString read _GetCASE_LOCATIVE;
    {class} property CASE_NOMINATIVE: JString read _GetCASE_NOMINATIVE;
    {class} property CASE_VOCATIVE: JString read _GetCASE_VOCATIVE;
    {class} property GENDER_FEMALE: JString read _GetGENDER_FEMALE;
    {class} property GENDER_MALE: JString read _GetGENDER_MALE;
    {class} property GENDER_NEUTRAL: JString read _GetGENDER_NEUTRAL;
    {class} property MONTH_APRIL: Integer read _GetMONTH_APRIL;
    {class} property MONTH_AUGUST: Integer read _GetMONTH_AUGUST;
    {class} property MONTH_DECEMBER: Integer read _GetMONTH_DECEMBER;
    {class} property MONTH_FEBRUARY: Integer read _GetMONTH_FEBRUARY;
    {class} property MONTH_JANUARY: Integer read _GetMONTH_JANUARY;
    {class} property MONTH_JULY: Integer read _GetMONTH_JULY;
    {class} property MONTH_JUNE: Integer read _GetMONTH_JUNE;
    {class} property MONTH_MARCH: Integer read _GetMONTH_MARCH;
    {class} property MONTH_MAY: Integer read _GetMONTH_MAY;
    {class} property MONTH_NOVEMBER: Integer read _GetMONTH_NOVEMBER;
    {class} property MONTH_OCTOBER: Integer read _GetMONTH_OCTOBER;
    {class} property MONTH_SEPTEMBER: Integer read _GetMONTH_SEPTEMBER;
    {class} property MULTIPLICITY_DUAL: JString read _GetMULTIPLICITY_DUAL;
    {class} property MULTIPLICITY_PLURAL: JString read _GetMULTIPLICITY_PLURAL;
    {class} property MULTIPLICITY_SINGLE: JString read _GetMULTIPLICITY_SINGLE;
    {class} property TYPE_CARDINAL: JString read _GetTYPE_CARDINAL;
    {class} property TYPE_DATE: JString read _GetTYPE_DATE;
    {class} property TYPE_DECIMAL: JString read _GetTYPE_DECIMAL;
    {class} property TYPE_DIGITS: JString read _GetTYPE_DIGITS;
    {class} property TYPE_ELECTRONIC: JString read _GetTYPE_ELECTRONIC;
    {class} property TYPE_FRACTION: JString read _GetTYPE_FRACTION;
    {class} property TYPE_MEASURE: JString read _GetTYPE_MEASURE;
    {class} property TYPE_MONEY: JString read _GetTYPE_MONEY;
    {class} property TYPE_ORDINAL: JString read _GetTYPE_ORDINAL;
    {class} property TYPE_TELEPHONE: JString read _GetTYPE_TELEPHONE;
    {class} property TYPE_TEXT: JString read _GetTYPE_TEXT;
    {class} property TYPE_TIME: JString read _GetTYPE_TIME;
    {class} property TYPE_VERBATIM: JString read _GetTYPE_VERBATIM;
    {class} property WEEKDAY_FRIDAY: Integer read _GetWEEKDAY_FRIDAY;
    {class} property WEEKDAY_MONDAY: Integer read _GetWEEKDAY_MONDAY;
    {class} property WEEKDAY_SATURDAY: Integer read _GetWEEKDAY_SATURDAY;
    {class} property WEEKDAY_SUNDAY: Integer read _GetWEEKDAY_SUNDAY;
    {class} property WEEKDAY_THURSDAY: Integer read _GetWEEKDAY_THURSDAY;
    {class} property WEEKDAY_TUESDAY: Integer read _GetWEEKDAY_TUESDAY;
    {class} property WEEKDAY_WEDNESDAY: Integer read _GetWEEKDAY_WEDNESDAY;
  end;

  [JavaSignature('android/text/style/TtsSpan')]
  JTtsSpan = interface(JObject)
    ['{7752098C-A5FF-4F67-85F1-79FAB92ECCC6}']
    function describeContents: Integer; cdecl;
    function getArgs: JPersistableBundle; cdecl;
    function getSpanTypeId: Integer; cdecl;
    function getType: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJTtsSpan = class(TJavaGenericImport<JTtsSpanClass, JTtsSpan>) end;

  JURLSpanClass = interface(JClickableSpanClass)
    ['{F6F51E82-0AB4-4832-B8E7-24612C1154BA}']
    {class} function init(url: JString): JURLSpan; cdecl; overload;
    {class} function init(src: JParcel): JURLSpan; cdecl; overload;
  end;

  [JavaSignature('android/text/style/URLSpan')]
  JURLSpan = interface(JClickableSpan)
    ['{A18D08F1-4B56-4594-8680-1A0ABE57807C}']
    function describeContents: Integer; cdecl;
    function getSpanTypeId: Integer; cdecl;
    function getURL: JString; cdecl;
    procedure onClick(widget: JView); cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJURLSpan = class(TJavaGenericImport<JURLSpanClass, JURLSpan>) end;

  JActionModeClass = interface(JObjectClass)
    ['{71825176-284A-429E-8391-FB39774F4500}']
    {class} function _GetDEFAULT_HIDE_DURATION: Integer; cdecl;
    {class} function _GetTYPE_FLOATING: Integer; cdecl;
    {class} function _GetTYPE_PRIMARY: Integer; cdecl;
    {class} function init: JActionMode; cdecl;
    {class} property DEFAULT_HIDE_DURATION: Integer read _GetDEFAULT_HIDE_DURATION;
    {class} property TYPE_FLOATING: Integer read _GetTYPE_FLOATING;
    {class} property TYPE_PRIMARY: Integer read _GetTYPE_PRIMARY;
  end;

  [JavaSignature('android/view/ActionMode')]
  JActionMode = interface(JObject)
    ['{2D0091FA-DF79-4640-BA1D-FACF25666C4B}']
    procedure finish; cdecl;
    function getCustomView: JView; cdecl;
    function getMenu: JMenu; cdecl;
    function getMenuInflater: JMenuInflater; cdecl;
    function getSubtitle: JCharSequence; cdecl;
    function getTag: JObject; cdecl;
    function getTitle: JCharSequence; cdecl;
    function getTitleOptionalHint: Boolean; cdecl;
    function getType: Integer; cdecl;
    procedure hide(duration: Int64); cdecl;
    procedure invalidate; cdecl;
    procedure invalidateContentRect; cdecl;
    function isTitleOptional: Boolean; cdecl;
    procedure onWindowFocusChanged(hasWindowFocus: Boolean); cdecl;
    procedure setCustomView(view: JView); cdecl;
    procedure setSubtitle(subtitle: JCharSequence); cdecl; overload;
    procedure setSubtitle(resId: Integer); cdecl; overload;
    procedure setTag(tag: JObject); cdecl;
    procedure setTitle(title: JCharSequence); cdecl; overload;
    procedure setTitle(resId: Integer); cdecl; overload;
    procedure setTitleOptionalHint(titleOptional: Boolean); cdecl;
    procedure setType(type_: Integer); cdecl;
  end;
  TJActionMode = class(TJavaGenericImport<JActionModeClass, JActionMode>) end;

  JActionMode_CallbackClass = interface(IJavaClass)
    ['{A3D54DA6-C258-4990-AD71-B6BF8FBD5608}']
  end;

  [JavaSignature('android/view/ActionMode$Callback')]
  JActionMode_Callback = interface(IJavaInstance)
    ['{792BF4FC-1F34-4F60-8FA4-B86B8F14EBFF}']
    function onActionItemClicked(mode: JActionMode; item: JMenuItem): Boolean; cdecl;
    function onCreateActionMode(mode: JActionMode; menu: JMenu): Boolean; cdecl;
    procedure onDestroyActionMode(mode: JActionMode); cdecl;
    function onPrepareActionMode(mode: JActionMode; menu: JMenu): Boolean; cdecl;
  end;
  TJActionMode_Callback = class(TJavaGenericImport<JActionMode_CallbackClass, JActionMode_Callback>) end;

  JActionProviderClass = interface(JObjectClass)
    ['{9D317490-3FE1-4DFA-88A0-4C16C5CBF881}']
    {class} function init(context: JContext): JActionProvider; cdecl;
  end;

  [JavaSignature('android/view/ActionProvider')]
  JActionProvider = interface(JObject)
    ['{ABB5DE02-6FEB-49A1-881C-90A35AA8E477}']
    function hasSubMenu: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    function onCreateActionView: JView; cdecl; overload;//Deprecated
    function onCreateActionView(forItem: JMenuItem): JView; cdecl; overload;
    function onPerformDefaultAction: Boolean; cdecl;
    procedure onPrepareSubMenu(subMenu: JSubMenu); cdecl;
    function overridesItemVisibility: Boolean; cdecl;
    procedure refreshVisibility; cdecl;
    procedure setVisibilityListener(listener: JActionProvider_VisibilityListener); cdecl;
  end;
  TJActionProvider = class(TJavaGenericImport<JActionProviderClass, JActionProvider>) end;

  JActionProvider_VisibilityListenerClass = interface(IJavaClass)
    ['{DA44FA03-BC67-4E62-9F6F-6F6065A24844}']
  end;

  [JavaSignature('android/view/ActionProvider$VisibilityListener')]
  JActionProvider_VisibilityListener = interface(IJavaInstance)
    ['{C7394E05-61E3-4463-B618-DA0802949CFD}']
    procedure onActionProviderVisibilityChanged(isVisible: Boolean); cdecl;
  end;
  TJActionProvider_VisibilityListener = class(TJavaGenericImport<JActionProvider_VisibilityListenerClass, JActionProvider_VisibilityListener>) end;

  JMenuClass = interface(IJavaClass)
    ['{DB3A723B-6B18-407D-942F-D801B1260750}']
    {class} function _GetCATEGORY_ALTERNATIVE: Integer; cdecl;
    {class} function _GetCATEGORY_CONTAINER: Integer; cdecl;
    {class} function _GetCATEGORY_SECONDARY: Integer; cdecl;
    {class} function _GetCATEGORY_SYSTEM: Integer; cdecl;
    {class} function _GetFIRST: Integer; cdecl;
    {class} function _GetFLAG_ALWAYS_PERFORM_CLOSE: Integer; cdecl;
    {class} function _GetFLAG_APPEND_TO_GROUP: Integer; cdecl;
    {class} function _GetFLAG_PERFORM_NO_CLOSE: Integer; cdecl;
    {class} function _GetNONE: Integer; cdecl;
    {class} property CATEGORY_ALTERNATIVE: Integer read _GetCATEGORY_ALTERNATIVE;
    {class} property CATEGORY_CONTAINER: Integer read _GetCATEGORY_CONTAINER;
    {class} property CATEGORY_SECONDARY: Integer read _GetCATEGORY_SECONDARY;
    {class} property CATEGORY_SYSTEM: Integer read _GetCATEGORY_SYSTEM;
    {class} property FIRST: Integer read _GetFIRST;
    {class} property FLAG_ALWAYS_PERFORM_CLOSE: Integer read _GetFLAG_ALWAYS_PERFORM_CLOSE;
    {class} property FLAG_APPEND_TO_GROUP: Integer read _GetFLAG_APPEND_TO_GROUP;
    {class} property FLAG_PERFORM_NO_CLOSE: Integer read _GetFLAG_PERFORM_NO_CLOSE;
    {class} property NONE: Integer read _GetNONE;
  end;

  [JavaSignature('android/view/Menu')]
  JMenu = interface(IJavaInstance)
    ['{DECE608E-FA87-43AF-A7CE-2223FCD5BD3E}']
    function add(title: JCharSequence): JMenuItem; cdecl; overload;
    function add(titleRes: Integer): JMenuItem; cdecl; overload;
    function add(groupId: Integer; itemId: Integer; order: Integer; title: JCharSequence): JMenuItem; cdecl; overload;
    function add(groupId: Integer; itemId: Integer; order: Integer; titleRes: Integer): JMenuItem; cdecl; overload;
    function addIntentOptions(groupId: Integer; itemId: Integer; order: Integer; caller: JComponentName; specifics: TJavaObjectArray<JIntent>; intent: JIntent; flags: Integer; outSpecificItems: TJavaObjectArray<JMenuItem>): Integer; cdecl;
    function addSubMenu(title: JCharSequence): JSubMenu; cdecl; overload;
    function addSubMenu(titleRes: Integer): JSubMenu; cdecl; overload;
    function addSubMenu(groupId: Integer; itemId: Integer; order: Integer; title: JCharSequence): JSubMenu; cdecl; overload;
    function addSubMenu(groupId: Integer; itemId: Integer; order: Integer; titleRes: Integer): JSubMenu; cdecl; overload;
    procedure clear; cdecl;
    procedure close; cdecl;
    function findItem(id: Integer): JMenuItem; cdecl;
    function getItem(index: Integer): JMenuItem; cdecl;
    function hasVisibleItems: Boolean; cdecl;
    function isShortcutKey(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function performIdentifierAction(id: Integer; flags: Integer): Boolean; cdecl;
    function performShortcut(keyCode: Integer; event: JKeyEvent; flags: Integer): Boolean; cdecl;
    procedure removeGroup(groupId: Integer); cdecl;
    procedure removeItem(id: Integer); cdecl;
    procedure setGroupCheckable(group: Integer; checkable: Boolean; exclusive: Boolean); cdecl;
    procedure setGroupEnabled(group: Integer; enabled: Boolean); cdecl;
    procedure setGroupVisible(group: Integer; visible: Boolean); cdecl;
    procedure setQwertyMode(isQwerty: Boolean); cdecl;
    function size: Integer; cdecl;
  end;
  TJMenu = class(TJavaGenericImport<JMenuClass, JMenu>) end;

  JContextMenuClass = interface(JMenuClass)
    ['{620B70D9-BD29-4FFF-B9D6-22DEF53FF3CB}']
  end;

  [JavaSignature('android/view/ContextMenu')]
  JContextMenu = interface(JMenu)
    ['{31A13877-FC0E-46C5-BF67-FC2A7624CC60}']
    procedure clearHeader; cdecl;
    function setHeaderIcon(iconRes: Integer): JContextMenu; cdecl; overload;
    function setHeaderIcon(icon: JDrawable): JContextMenu; cdecl; overload;
    function setHeaderTitle(titleRes: Integer): JContextMenu; cdecl; overload;
    function setHeaderTitle(title: JCharSequence): JContextMenu; cdecl; overload;
    function setHeaderView(view: JView): JContextMenu; cdecl;
  end;
  TJContextMenu = class(TJavaGenericImport<JContextMenuClass, JContextMenu>) end;

  JContextMenu_ContextMenuInfoClass = interface(IJavaClass)
    ['{6F3CD3B3-B391-4929-AD4E-366A60F4385C}']
  end;

  [JavaSignature('android/view/ContextMenu$ContextMenuInfo')]
  JContextMenu_ContextMenuInfo = interface(IJavaInstance)
    ['{2DC4CB20-2CDD-41BD-89B3-E8FE8AEEA852}']
  end;
  TJContextMenu_ContextMenuInfo = class(TJavaGenericImport<JContextMenu_ContextMenuInfoClass, JContextMenu_ContextMenuInfo>) end;

  JContextThemeWrapperClass = interface(JContextWrapperClass)
    ['{E4B006F8-E355-4D54-B94B-D17758D93102}']
    {class} function init: JContextThemeWrapper; cdecl; overload;
    {class} function init(base: JContext; themeResId: Integer): JContextThemeWrapper; cdecl; overload;
    {class} function init(base: JContext; theme: JResources_Theme): JContextThemeWrapper; cdecl; overload;
  end;

  [JavaSignature('android/view/ContextThemeWrapper')]
  JContextThemeWrapper = interface(JContextWrapper)
    ['{68840867-EC00-40D8-9130-022454F26948}']
    procedure applyOverrideConfiguration(overrideConfiguration: JConfiguration); cdecl;
    function getResources: JResources; cdecl;
    function getSystemService(name: JString): JObject; cdecl;
    function getTheme: JResources_Theme; cdecl;
    procedure setTheme(resid: Integer); cdecl;
  end;
  TJContextThemeWrapper = class(TJavaGenericImport<JContextThemeWrapperClass, JContextThemeWrapper>) end;

  JDisplayClass = interface(JObjectClass)
    ['{E130072D-1414-44D4-85B6-A9041E73BA9B}']
    {class} function _GetDEFAULT_DISPLAY: Integer; cdecl;
    {class} function _GetFLAG_PRESENTATION: Integer; cdecl;
    {class} function _GetFLAG_PRIVATE: Integer; cdecl;
    {class} function _GetFLAG_ROUND: Integer; cdecl;
    {class} function _GetFLAG_SECURE: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_PROTECTED_BUFFERS: Integer; cdecl;
    {class} function _GetINVALID_DISPLAY: Integer; cdecl;
    {class} function _GetSTATE_DOZE: Integer; cdecl;
    {class} function _GetSTATE_DOZE_SUSPEND: Integer; cdecl;
    {class} function _GetSTATE_OFF: Integer; cdecl;
    {class} function _GetSTATE_ON: Integer; cdecl;
    {class} function _GetSTATE_UNKNOWN: Integer; cdecl;
    {class} property DEFAULT_DISPLAY: Integer read _GetDEFAULT_DISPLAY;
    {class} property FLAG_PRESENTATION: Integer read _GetFLAG_PRESENTATION;
    {class} property FLAG_PRIVATE: Integer read _GetFLAG_PRIVATE;
    {class} property FLAG_ROUND: Integer read _GetFLAG_ROUND;
    {class} property FLAG_SECURE: Integer read _GetFLAG_SECURE;
    {class} property FLAG_SUPPORTS_PROTECTED_BUFFERS: Integer read _GetFLAG_SUPPORTS_PROTECTED_BUFFERS;
    {class} property INVALID_DISPLAY: Integer read _GetINVALID_DISPLAY;
    {class} property STATE_DOZE: Integer read _GetSTATE_DOZE;
    {class} property STATE_DOZE_SUSPEND: Integer read _GetSTATE_DOZE_SUSPEND;
    {class} property STATE_OFF: Integer read _GetSTATE_OFF;
    {class} property STATE_ON: Integer read _GetSTATE_ON;
    {class} property STATE_UNKNOWN: Integer read _GetSTATE_UNKNOWN;
  end;

  [JavaSignature('android/view/Display')]
  JDisplay = interface(JObject)
    ['{53A1E800-9C93-4F4D-B5B4-2DDE6DF3859E}']
    function getAppVsyncOffsetNanos: Int64; cdecl;
    procedure getCurrentSizeRange(outSmallestSize: JPoint; outLargestSize: JPoint); cdecl;
    function getDisplayId: Integer; cdecl;
    function getFlags: Integer; cdecl;
    function getHeight: Integer; cdecl;//Deprecated
    procedure getMetrics(outMetrics: JDisplayMetrics); cdecl;
    function getMode: JDisplay_Mode; cdecl;
    function getName: JString; cdecl;
    function getOrientation: Integer; cdecl;//Deprecated
    function getPixelFormat: Integer; cdecl;//Deprecated
    function getPresentationDeadlineNanos: Int64; cdecl;
    procedure getRealMetrics(outMetrics: JDisplayMetrics); cdecl;
    procedure getRealSize(outSize: JPoint); cdecl;
    procedure getRectSize(outSize: JRect); cdecl;
    function getRefreshRate: Single; cdecl;
    function getRotation: Integer; cdecl;
    procedure getSize(outSize: JPoint); cdecl;
    function getState: Integer; cdecl;
    function getSupportedModes: TJavaObjectArray<JDisplay_Mode>; cdecl;
    function getSupportedRefreshRates: TJavaArray<Single>; cdecl;//Deprecated
    function getWidth: Integer; cdecl;//Deprecated
    function isValid: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJDisplay = class(TJavaGenericImport<JDisplayClass, JDisplay>) end;

  JDisplay_ModeClass = interface(JObjectClass)
    ['{BAD06762-45B0-410C-B351-71CFA9A0DF2E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/Display$Mode')]
  JDisplay_Mode = interface(JObject)
    ['{445338AD-D805-4823-B7AF-0A981C0CA8DE}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getModeId: Integer; cdecl;
    function getPhysicalHeight: Integer; cdecl;
    function getPhysicalWidth: Integer; cdecl;
    function getRefreshRate: Single; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; parcelableFlags: Integer); cdecl;
  end;
  TJDisplay_Mode = class(TJavaGenericImport<JDisplay_ModeClass, JDisplay_Mode>) end;

  JDisplayListCanvasClass = interface(JCanvasClass)
    ['{6776AEB5-01D5-48F3-865F-0B44B449B959}']
  end;

  [JavaSignature('android/view/DisplayListCanvas')]
  JDisplayListCanvas = interface(JCanvas)
    ['{50DBD782-B789-4B51-811B-20FD7DFCE412}']
    procedure callDrawGLFunction2(drawGLFunction: Int64); cdecl;
    procedure drawCircle(cx: JCanvasProperty; cy: JCanvasProperty; radius: JCanvasProperty; paint: JCanvasProperty); cdecl;
    procedure drawPatch(patch: JNinePatch; dst: JRect; paint: JPaint); cdecl; overload;
    procedure drawPatch(patch: JNinePatch; dst: JRectF; paint: JPaint); cdecl; overload;
    procedure drawPath(path: JPath; paint: JPaint); cdecl;
    procedure drawRenderNode(renderNode: JRenderNode); cdecl;
    procedure drawRoundRect(left: JCanvasProperty; top: JCanvasProperty; right: JCanvasProperty; bottom: JCanvasProperty; rx: JCanvasProperty; ry: JCanvasProperty; paint: JCanvasProperty); cdecl;
    function getHeight: Integer; cdecl;
    function getMaximumBitmapHeight: Integer; cdecl;
    function getMaximumBitmapWidth: Integer; cdecl;
    function getWidth: Integer; cdecl;
    procedure insertInorderBarrier; cdecl;
    procedure insertReorderBarrier; cdecl;
    function isHardwareAccelerated: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isRecordingFor(o: JObject): Boolean; cdecl;
    procedure onPostDraw; cdecl;
    procedure onPreDraw(dirty: JRect); cdecl;
    procedure setBitmap(bitmap: JBitmap); cdecl;
    procedure setDensity(density: Integer); cdecl;
    procedure setHighContrastText(highContrastText: Boolean); cdecl;
    procedure setViewport(width: Integer; height: Integer); cdecl;
  end;
  TJDisplayListCanvas = class(TJavaGenericImport<JDisplayListCanvasClass, JDisplayListCanvas>) end;

  JDragEventClass = interface(JObjectClass)
    ['{942CCCAD-2F23-4A86-A7DB-C63D200CEB0F}']
    {class} function _GetACTION_DRAG_ENDED: Integer; cdecl;
    {class} function _GetACTION_DRAG_ENTERED: Integer; cdecl;
    {class} function _GetACTION_DRAG_EXITED: Integer; cdecl;
    {class} function _GetACTION_DRAG_LOCATION: Integer; cdecl;
    {class} function _GetACTION_DRAG_STARTED: Integer; cdecl;
    {class} function _GetACTION_DROP: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property ACTION_DRAG_ENDED: Integer read _GetACTION_DRAG_ENDED;
    {class} property ACTION_DRAG_ENTERED: Integer read _GetACTION_DRAG_ENTERED;
    {class} property ACTION_DRAG_EXITED: Integer read _GetACTION_DRAG_EXITED;
    {class} property ACTION_DRAG_LOCATION: Integer read _GetACTION_DRAG_LOCATION;
    {class} property ACTION_DRAG_STARTED: Integer read _GetACTION_DRAG_STARTED;
    {class} property ACTION_DROP: Integer read _GetACTION_DROP;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/DragEvent')]
  JDragEvent = interface(JObject)
    ['{058D88CB-DB10-477F-BE28-36295CA6507A}']
    function describeContents: Integer; cdecl;
    function getAction: Integer; cdecl;
    function getClipData: JClipData; cdecl;
    function getClipDescription: JClipDescription; cdecl;
    function getLocalState: JObject; cdecl;
    function getResult: Boolean; cdecl;
    function getX: Single; cdecl;
    function getY: Single; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJDragEvent = class(TJavaGenericImport<JDragEventClass, JDragEvent>) end;

  JGestureDetectorClass = interface(JObjectClass)
    ['{4CF183C0-64F2-4604-A7B5-0AA713A2F86E}']
    {class} function init(listener: JGestureDetector_OnGestureListener; handler: JHandler): JGestureDetector; cdecl; overload;//Deprecated
    {class} function init(listener: JGestureDetector_OnGestureListener): JGestureDetector; cdecl; overload;//Deprecated
    {class} function init(context: JContext; listener: JGestureDetector_OnGestureListener): JGestureDetector; cdecl; overload;
    {class} function init(context: JContext; listener: JGestureDetector_OnGestureListener; handler: JHandler): JGestureDetector; cdecl; overload;
    {class} function init(context: JContext; listener: JGestureDetector_OnGestureListener; handler: JHandler; unused: Boolean): JGestureDetector; cdecl; overload;
  end;

  [JavaSignature('android/view/GestureDetector')]
  JGestureDetector = interface(JObject)
    ['{4897CF85-CC0C-4A98-BB19-E55262ECE992}']
    function isLongpressEnabled: Boolean; cdecl;
    function onGenericMotionEvent(ev: JMotionEvent): Boolean; cdecl;
    function onTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    procedure setContextClickListener(onContextClickListener: JGestureDetector_OnContextClickListener); cdecl;
    procedure setIsLongpressEnabled(isLongpressEnabled: Boolean); cdecl;
    procedure setOnDoubleTapListener(onDoubleTapListener: JGestureDetector_OnDoubleTapListener); cdecl;
  end;
  TJGestureDetector = class(TJavaGenericImport<JGestureDetectorClass, JGestureDetector>) end;

  JGestureDetector_OnContextClickListenerClass = interface(IJavaClass)
    ['{01FE4F26-2B5D-41A8-8B24-4637BE20C22D}']
  end;

  [JavaSignature('android/view/GestureDetector$OnContextClickListener')]
  JGestureDetector_OnContextClickListener = interface(IJavaInstance)
    ['{91D11C08-CBED-4B5C-8F70-1C9EED3A2C8A}']
    function onContextClick(e: JMotionEvent): Boolean; cdecl;
  end;
  TJGestureDetector_OnContextClickListener = class(TJavaGenericImport<JGestureDetector_OnContextClickListenerClass, JGestureDetector_OnContextClickListener>) end;

  JGestureDetector_OnDoubleTapListenerClass = interface(IJavaClass)
    ['{219C5FEA-C7A3-42D6-9634-7F7EA908EB99}']
  end;

  [JavaSignature('android/view/GestureDetector$OnDoubleTapListener')]
  JGestureDetector_OnDoubleTapListener = interface(IJavaInstance)
    ['{759D27FB-6DD3-4C4C-BA8D-3814CB8278A2}']
    function onDoubleTap(e: JMotionEvent): Boolean; cdecl;
    function onDoubleTapEvent(e: JMotionEvent): Boolean; cdecl;
    function onSingleTapConfirmed(e: JMotionEvent): Boolean; cdecl;
  end;
  TJGestureDetector_OnDoubleTapListener = class(TJavaGenericImport<JGestureDetector_OnDoubleTapListenerClass, JGestureDetector_OnDoubleTapListener>) end;

  JGestureDetector_OnGestureListenerClass = interface(IJavaClass)
    ['{F2B6E4EF-66AB-4548-AB15-4253FDC78CD1}']
  end;

  [JavaSignature('android/view/GestureDetector$OnGestureListener')]
  JGestureDetector_OnGestureListener = interface(IJavaInstance)
    ['{A72C80A3-7E4C-4FDD-98FC-99B328D6BFDD}']
    function onDown(e: JMotionEvent): Boolean; cdecl;
    function onFling(e1: JMotionEvent; e2: JMotionEvent; velocityX: Single; velocityY: Single): Boolean; cdecl;
    procedure onLongPress(e: JMotionEvent); cdecl;
    function onScroll(e1: JMotionEvent; e2: JMotionEvent; distanceX: Single; distanceY: Single): Boolean; cdecl;
    procedure onShowPress(e: JMotionEvent); cdecl;
    function onSingleTapUp(e: JMotionEvent): Boolean; cdecl;
  end;
  TJGestureDetector_OnGestureListener = class(TJavaGenericImport<JGestureDetector_OnGestureListenerClass, JGestureDetector_OnGestureListener>) end;

  JGestureDetector_SimpleOnGestureListenerClass = interface(JObjectClass)
    ['{1E226D50-6D5B-42A1-8178-20CF72CDE156}']
    {class} function init: JGestureDetector_SimpleOnGestureListener; cdecl;
  end;

  [JavaSignature('android/view/GestureDetector$SimpleOnGestureListener')]
  JGestureDetector_SimpleOnGestureListener = interface(JObject)
    ['{0C4A6AE9-8E3A-4325-9393-2A71A6AFEC8D}']
    function onContextClick(e: JMotionEvent): Boolean; cdecl;
    function onDoubleTap(e: JMotionEvent): Boolean; cdecl;
    function onDoubleTapEvent(e: JMotionEvent): Boolean; cdecl;
    function onDown(e: JMotionEvent): Boolean; cdecl;
    function onFling(e1: JMotionEvent; e2: JMotionEvent; velocityX: Single; velocityY: Single): Boolean; cdecl;
    procedure onLongPress(e: JMotionEvent); cdecl;
    function onScroll(e1: JMotionEvent; e2: JMotionEvent; distanceX: Single; distanceY: Single): Boolean; cdecl;
    procedure onShowPress(e: JMotionEvent); cdecl;
    function onSingleTapConfirmed(e: JMotionEvent): Boolean; cdecl;
    function onSingleTapUp(e: JMotionEvent): Boolean; cdecl;
  end;
  TJGestureDetector_SimpleOnGestureListener = class(TJavaGenericImport<JGestureDetector_SimpleOnGestureListenerClass, JGestureDetector_SimpleOnGestureListener>) end;

  JInputDeviceClass = interface(JObjectClass)
    ['{E0E16597-3285-468E-8687-2CE588147240}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetKEYBOARD_TYPE_ALPHABETIC: Integer; cdecl;
    {class} function _GetKEYBOARD_TYPE_NONE: Integer; cdecl;
    {class} function _GetKEYBOARD_TYPE_NON_ALPHABETIC: Integer; cdecl;
    {class} function _GetMOTION_RANGE_ORIENTATION: Integer; cdecl;
    {class} function _GetMOTION_RANGE_PRESSURE: Integer; cdecl;
    {class} function _GetMOTION_RANGE_SIZE: Integer; cdecl;
    {class} function _GetMOTION_RANGE_TOOL_MAJOR: Integer; cdecl;
    {class} function _GetMOTION_RANGE_TOOL_MINOR: Integer; cdecl;
    {class} function _GetMOTION_RANGE_TOUCH_MAJOR: Integer; cdecl;
    {class} function _GetMOTION_RANGE_TOUCH_MINOR: Integer; cdecl;
    {class} function _GetMOTION_RANGE_X: Integer; cdecl;
    {class} function _GetMOTION_RANGE_Y: Integer; cdecl;
    {class} function _GetSOURCE_ANY: Integer; cdecl;
    {class} function _GetSOURCE_BLUETOOTH_STYLUS: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_BUTTON: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_JOYSTICK: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_MASK: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_NONE: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_POINTER: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_POSITION: Integer; cdecl;
    {class} function _GetSOURCE_CLASS_TRACKBALL: Integer; cdecl;
    {class} function _GetSOURCE_DPAD: Integer; cdecl;
    {class} function _GetSOURCE_GAMEPAD: Integer; cdecl;
    {class} function _GetSOURCE_HDMI: Integer; cdecl;
    {class} function _GetSOURCE_JOYSTICK: Integer; cdecl;
    {class} function _GetSOURCE_KEYBOARD: Integer; cdecl;
    {class} function _GetSOURCE_MOUSE: Integer; cdecl;
    {class} function _GetSOURCE_STYLUS: Integer; cdecl;
    {class} function _GetSOURCE_TOUCHPAD: Integer; cdecl;
    {class} function _GetSOURCE_TOUCHSCREEN: Integer; cdecl;
    {class} function _GetSOURCE_TOUCH_NAVIGATION: Integer; cdecl;
    {class} function _GetSOURCE_TRACKBALL: Integer; cdecl;
    {class} function _GetSOURCE_UNKNOWN: Integer; cdecl;
    {class} function getDevice(id: Integer): JInputDevice; cdecl;
    {class} function getDeviceIds: TJavaArray<Integer>; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property KEYBOARD_TYPE_ALPHABETIC: Integer read _GetKEYBOARD_TYPE_ALPHABETIC;
    {class} property KEYBOARD_TYPE_NONE: Integer read _GetKEYBOARD_TYPE_NONE;
    {class} property KEYBOARD_TYPE_NON_ALPHABETIC: Integer read _GetKEYBOARD_TYPE_NON_ALPHABETIC;
    {class} property MOTION_RANGE_ORIENTATION: Integer read _GetMOTION_RANGE_ORIENTATION;
    {class} property MOTION_RANGE_PRESSURE: Integer read _GetMOTION_RANGE_PRESSURE;
    {class} property MOTION_RANGE_SIZE: Integer read _GetMOTION_RANGE_SIZE;
    {class} property MOTION_RANGE_TOOL_MAJOR: Integer read _GetMOTION_RANGE_TOOL_MAJOR;
    {class} property MOTION_RANGE_TOOL_MINOR: Integer read _GetMOTION_RANGE_TOOL_MINOR;
    {class} property MOTION_RANGE_TOUCH_MAJOR: Integer read _GetMOTION_RANGE_TOUCH_MAJOR;
    {class} property MOTION_RANGE_TOUCH_MINOR: Integer read _GetMOTION_RANGE_TOUCH_MINOR;
    {class} property MOTION_RANGE_X: Integer read _GetMOTION_RANGE_X;
    {class} property MOTION_RANGE_Y: Integer read _GetMOTION_RANGE_Y;
    {class} property SOURCE_ANY: Integer read _GetSOURCE_ANY;
    {class} property SOURCE_BLUETOOTH_STYLUS: Integer read _GetSOURCE_BLUETOOTH_STYLUS;
    {class} property SOURCE_CLASS_BUTTON: Integer read _GetSOURCE_CLASS_BUTTON;
    {class} property SOURCE_CLASS_JOYSTICK: Integer read _GetSOURCE_CLASS_JOYSTICK;
    {class} property SOURCE_CLASS_MASK: Integer read _GetSOURCE_CLASS_MASK;
    {class} property SOURCE_CLASS_NONE: Integer read _GetSOURCE_CLASS_NONE;
    {class} property SOURCE_CLASS_POINTER: Integer read _GetSOURCE_CLASS_POINTER;
    {class} property SOURCE_CLASS_POSITION: Integer read _GetSOURCE_CLASS_POSITION;
    {class} property SOURCE_CLASS_TRACKBALL: Integer read _GetSOURCE_CLASS_TRACKBALL;
    {class} property SOURCE_DPAD: Integer read _GetSOURCE_DPAD;
    {class} property SOURCE_GAMEPAD: Integer read _GetSOURCE_GAMEPAD;
    {class} property SOURCE_HDMI: Integer read _GetSOURCE_HDMI;
    {class} property SOURCE_JOYSTICK: Integer read _GetSOURCE_JOYSTICK;
    {class} property SOURCE_KEYBOARD: Integer read _GetSOURCE_KEYBOARD;
    {class} property SOURCE_MOUSE: Integer read _GetSOURCE_MOUSE;
    {class} property SOURCE_STYLUS: Integer read _GetSOURCE_STYLUS;
    {class} property SOURCE_TOUCHPAD: Integer read _GetSOURCE_TOUCHPAD;
    {class} property SOURCE_TOUCHSCREEN: Integer read _GetSOURCE_TOUCHSCREEN;
    {class} property SOURCE_TOUCH_NAVIGATION: Integer read _GetSOURCE_TOUCH_NAVIGATION;
    {class} property SOURCE_TRACKBALL: Integer read _GetSOURCE_TRACKBALL;
    {class} property SOURCE_UNKNOWN: Integer read _GetSOURCE_UNKNOWN;
  end;

  [JavaSignature('android/view/InputDevice')]
  JInputDevice = interface(JObject)
    ['{6E91CB04-A6A7-4C2B-B90E-4D6B321E18C0}']
    function describeContents: Integer; cdecl;
    function getControllerNumber: Integer; cdecl;
    function getDescriptor: JString; cdecl;
    function getId: Integer; cdecl;
    function getKeyCharacterMap: JKeyCharacterMap; cdecl;
    function getKeyboardType: Integer; cdecl;
    function getMotionRange(axis: Integer): JInputDevice_MotionRange; cdecl; overload;
    function getMotionRange(axis: Integer; source: Integer): JInputDevice_MotionRange; cdecl; overload;
    function getMotionRanges: JList; cdecl;
    function getName: JString; cdecl;
    function getProductId: Integer; cdecl;
    function getSources: Integer; cdecl;
    function getVendorId: Integer; cdecl;
    function getVibrator: JVibrator; cdecl;
    function hasMicrophone: Boolean; cdecl;
    function isVirtual: Boolean; cdecl;
    function supportsSource(source: Integer): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJInputDevice = class(TJavaGenericImport<JInputDeviceClass, JInputDevice>) end;

  JInputDevice_MotionRangeClass = interface(JObjectClass)
    ['{8BDD8CA8-236A-4693-9E0A-B4F81831B6EB}']
  end;

  [JavaSignature('android/view/InputDevice$MotionRange')]
  JInputDevice_MotionRange = interface(JObject)
    ['{9F1D1FF9-EAF0-4877-BB6E-9D91EB287CF9}']
    function getAxis: Integer; cdecl;
    function getFlat: Single; cdecl;
    function getFuzz: Single; cdecl;
    function getMax: Single; cdecl;
    function getMin: Single; cdecl;
    function getRange: Single; cdecl;
    function getResolution: Single; cdecl;
    function getSource: Integer; cdecl;
    function isFromSource(source: Integer): Boolean; cdecl;
  end;
  TJInputDevice_MotionRange = class(TJavaGenericImport<JInputDevice_MotionRangeClass, JInputDevice_MotionRange>) end;

  JInputEventClass = interface(JObjectClass)
    ['{2144AA86-B47F-4D38-844A-F4E2B7EA242E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/InputEvent')]
  JInputEvent = interface(JObject)
    ['{8E25F546-E8FF-4C54-BCAA-733E5AF3523C}']
    function describeContents: Integer; cdecl;
    function getDevice: JInputDevice; cdecl;
    function getDeviceId: Integer; cdecl;
    function getEventTime: Int64; cdecl;
    function getSource: Integer; cdecl;
    function isFromSource(source: Integer): Boolean; cdecl;
  end;
  TJInputEvent = class(TJavaGenericImport<JInputEventClass, JInputEvent>) end;

  JInputQueueClass = interface(JObjectClass)
    ['{D864DFE2-C91F-469A-954F-01F887676348}']
  end;

  [JavaSignature('android/view/InputQueue')]
  JInputQueue = interface(JObject)
    ['{514AF3EE-764E-4F6F-8774-5D0DB3F9F761}']
  end;
  TJInputQueue = class(TJavaGenericImport<JInputQueueClass, JInputQueue>) end;

  JInputQueue_CallbackClass = interface(IJavaClass)
    ['{3C12E67D-2387-44D7-B467-359188FB2BC4}']
  end;

  [JavaSignature('android/view/InputQueue$Callback')]
  JInputQueue_Callback = interface(IJavaInstance)
    ['{EE832599-49D1-406A-9A6C-7293ED164F84}']
    procedure onInputQueueCreated(queue: JInputQueue); cdecl;
    procedure onInputQueueDestroyed(queue: JInputQueue); cdecl;
  end;
  TJInputQueue_Callback = class(TJavaGenericImport<JInputQueue_CallbackClass, JInputQueue_Callback>) end;

  JKeyCharacterMapClass = interface(JObjectClass)
    ['{76935FF1-DC3D-4EB8-84A2-45875FA8F3C3}']
    {class} function _GetALPHA: Integer; cdecl;
    {class} function _GetBUILT_IN_KEYBOARD: Integer; cdecl;
    {class} function _GetCOMBINING_ACCENT: Integer; cdecl;
    {class} function _GetCOMBINING_ACCENT_MASK: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFULL: Integer; cdecl;
    {class} function _GetHEX_INPUT: Char; cdecl;
    {class} function _GetMODIFIER_BEHAVIOR_CHORDED: Integer; cdecl;
    {class} function _GetMODIFIER_BEHAVIOR_CHORDED_OR_TOGGLED: Integer; cdecl;
    {class} function _GetNUMERIC: Integer; cdecl;
    {class} function _GetPICKER_DIALOG_INPUT: Char; cdecl;
    {class} function _GetPREDICTIVE: Integer; cdecl;
    {class} function _GetSPECIAL_FUNCTION: Integer; cdecl;
    {class} function _GetVIRTUAL_KEYBOARD: Integer; cdecl;
    {class} function deviceHasKey(keyCode: Integer): Boolean; cdecl;
    {class} function deviceHasKeys(keyCodes: TJavaArray<Integer>): TJavaArray<Boolean>; cdecl;
    {class} function getDeadChar(accent: Integer; c: Integer): Integer; cdecl;
    {class} function load(deviceId: Integer): JKeyCharacterMap; cdecl;
    {class} property ALPHA: Integer read _GetALPHA;
    {class} property BUILT_IN_KEYBOARD: Integer read _GetBUILT_IN_KEYBOARD;
    {class} property COMBINING_ACCENT: Integer read _GetCOMBINING_ACCENT;
    {class} property COMBINING_ACCENT_MASK: Integer read _GetCOMBINING_ACCENT_MASK;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FULL: Integer read _GetFULL;
    {class} property HEX_INPUT: Char read _GetHEX_INPUT;
    {class} property MODIFIER_BEHAVIOR_CHORDED: Integer read _GetMODIFIER_BEHAVIOR_CHORDED;
    {class} property MODIFIER_BEHAVIOR_CHORDED_OR_TOGGLED: Integer read _GetMODIFIER_BEHAVIOR_CHORDED_OR_TOGGLED;
    {class} property NUMERIC: Integer read _GetNUMERIC;
    {class} property PICKER_DIALOG_INPUT: Char read _GetPICKER_DIALOG_INPUT;
    {class} property PREDICTIVE: Integer read _GetPREDICTIVE;
    {class} property SPECIAL_FUNCTION: Integer read _GetSPECIAL_FUNCTION;
    {class} property VIRTUAL_KEYBOARD: Integer read _GetVIRTUAL_KEYBOARD;
  end;

  [JavaSignature('android/view/KeyCharacterMap')]
  JKeyCharacterMap = interface(JObject)
    ['{9C009DB9-CC5F-400E-8930-72BB0811F110}']
    function describeContents: Integer; cdecl;
    function &get(keyCode: Integer; metaState: Integer): Integer; cdecl;
    function getDisplayLabel(keyCode: Integer): Char; cdecl;
    function getEvents(chars: TJavaArray<Char>): TJavaObjectArray<JKeyEvent>; cdecl;
    function getKeyData(keyCode: Integer; results: JKeyCharacterMap_KeyData): Boolean; cdecl;//Deprecated
    function getKeyboardType: Integer; cdecl;
    function getMatch(keyCode: Integer; chars: TJavaArray<Char>): Char; cdecl; overload;
    function getMatch(keyCode: Integer; chars: TJavaArray<Char>; metaState: Integer): Char; cdecl; overload;
    function getModifierBehavior: Integer; cdecl;
    function getNumber(keyCode: Integer): Char; cdecl;
    function isPrintingKey(keyCode: Integer): Boolean; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJKeyCharacterMap = class(TJavaGenericImport<JKeyCharacterMapClass, JKeyCharacterMap>) end;

  JKeyCharacterMap_KeyDataClass = interface(JObjectClass)
    ['{6C0CB530-CBCE-408E-B83B-214BC758AE6A}']
    {class} function _GetMETA_LENGTH: Integer; cdecl;
    {class} function init: JKeyCharacterMap_KeyData; cdecl;
    {class} property META_LENGTH: Integer read _GetMETA_LENGTH;
  end;

  [JavaSignature('android/view/KeyCharacterMap$KeyData')]
  JKeyCharacterMap_KeyData = interface(JObject)
    ['{A4AE82F8-F493-4B07-A979-E148E550ACC4}']
    function _GetdisplayLabel: Char; cdecl;
    procedure _SetdisplayLabel(Value: Char); cdecl;
    function _Getmeta: TJavaArray<Char>; cdecl;
    procedure _Setmeta(Value: TJavaArray<Char>); cdecl;
    function _Getnumber: Char; cdecl;
    procedure _Setnumber(Value: Char); cdecl;
    property displayLabel: Char read _GetdisplayLabel write _SetdisplayLabel;
    property meta: TJavaArray<Char> read _Getmeta write _Setmeta;
    property number: Char read _Getnumber write _Setnumber;
  end;
  TJKeyCharacterMap_KeyData = class(TJavaGenericImport<JKeyCharacterMap_KeyDataClass, JKeyCharacterMap_KeyData>) end;

  JKeyEventClass = interface(JInputEventClass)
    ['{BF382776-AD45-47D2-BDDE-CEFE64BBE44A}']
    {class} function _GetACTION_DOWN: Integer; cdecl;
    {class} function _GetACTION_MULTIPLE: Integer; cdecl;
    {class} function _GetACTION_UP: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_CANCELED: Integer; cdecl;
    {class} function _GetFLAG_CANCELED_LONG_PRESS: Integer; cdecl;
    {class} function _GetFLAG_EDITOR_ACTION: Integer; cdecl;
    {class} function _GetFLAG_FALLBACK: Integer; cdecl;
    {class} function _GetFLAG_FROM_SYSTEM: Integer; cdecl;
    {class} function _GetFLAG_KEEP_TOUCH_MODE: Integer; cdecl;
    {class} function _GetFLAG_LONG_PRESS: Integer; cdecl;
    {class} function _GetFLAG_SOFT_KEYBOARD: Integer; cdecl;
    {class} function _GetFLAG_TRACKING: Integer; cdecl;
    {class} function _GetFLAG_VIRTUAL_HARD_KEY: Integer; cdecl;
    {class} function _GetFLAG_WOKE_HERE: Integer; cdecl;
    {class} function _GetKEYCODE_0: Integer; cdecl;
    {class} function _GetKEYCODE_1: Integer; cdecl;
    {class} function _GetKEYCODE_11: Integer; cdecl;
    {class} function _GetKEYCODE_12: Integer; cdecl;
    {class} function _GetKEYCODE_2: Integer; cdecl;
    {class} function _GetKEYCODE_3: Integer; cdecl;
    {class} function _GetKEYCODE_3D_MODE: Integer; cdecl;
    {class} function _GetKEYCODE_4: Integer; cdecl;
    {class} function _GetKEYCODE_5: Integer; cdecl;
    {class} function _GetKEYCODE_6: Integer; cdecl;
    {class} function _GetKEYCODE_7: Integer; cdecl;
    {class} function _GetKEYCODE_8: Integer; cdecl;
    {class} function _GetKEYCODE_9: Integer; cdecl;
    {class} function _GetKEYCODE_A: Integer; cdecl;
    {class} function _GetKEYCODE_ALT_LEFT: Integer; cdecl;
    {class} function _GetKEYCODE_ALT_RIGHT: Integer; cdecl;
    {class} function _GetKEYCODE_APOSTROPHE: Integer; cdecl;
    {class} function _GetKEYCODE_APP_SWITCH: Integer; cdecl;
    {class} function _GetKEYCODE_ASSIST: Integer; cdecl;
    {class} function _GetKEYCODE_AT: Integer; cdecl;
    {class} function _GetKEYCODE_AVR_INPUT: Integer; cdecl;
    {class} function _GetKEYCODE_AVR_POWER: Integer; cdecl;
    {class} function _GetKEYCODE_B: Integer; cdecl;
    {class} function _GetKEYCODE_BACK: Integer; cdecl;
    {class} function _GetKEYCODE_BACKSLASH: Integer; cdecl;
    {class} function _GetKEYCODE_BOOKMARK: Integer; cdecl;
    {class} function _GetKEYCODE_BREAK: Integer; cdecl;
    {class} function _GetKEYCODE_BRIGHTNESS_DOWN: Integer; cdecl;
    {class} function _GetKEYCODE_BRIGHTNESS_UP: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_1: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_10: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_11: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_12: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_13: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_14: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_15: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_16: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_2: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_3: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_4: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_5: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_6: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_7: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_8: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_9: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_A: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_B: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_C: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_L1: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_L2: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_MODE: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_R1: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_R2: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_SELECT: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_START: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_THUMBL: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_THUMBR: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_X: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_Y: Integer; cdecl;
    {class} function _GetKEYCODE_BUTTON_Z: Integer; cdecl;
    {class} function _GetKEYCODE_C: Integer; cdecl;
    {class} function _GetKEYCODE_CALCULATOR: Integer; cdecl;
    {class} function _GetKEYCODE_CALENDAR: Integer; cdecl;
    {class} function _GetKEYCODE_CALL: Integer; cdecl;
    {class} function _GetKEYCODE_CAMERA: Integer; cdecl;
    {class} function _GetKEYCODE_CAPS_LOCK: Integer; cdecl;
    {class} function _GetKEYCODE_CAPTIONS: Integer; cdecl;
    {class} function _GetKEYCODE_CHANNEL_DOWN: Integer; cdecl;
    {class} function _GetKEYCODE_CHANNEL_UP: Integer; cdecl;
    {class} function _GetKEYCODE_CLEAR: Integer; cdecl;
    {class} function _GetKEYCODE_COMMA: Integer; cdecl;
    {class} function _GetKEYCODE_CONTACTS: Integer; cdecl;
    {class} function _GetKEYCODE_CTRL_LEFT: Integer; cdecl;
    {class} function _GetKEYCODE_CTRL_RIGHT: Integer; cdecl;
    {class} function _GetKEYCODE_D: Integer; cdecl;
    {class} function _GetKEYCODE_DEL: Integer; cdecl;
    {class} function _GetKEYCODE_DPAD_CENTER: Integer; cdecl;
    {class} function _GetKEYCODE_DPAD_DOWN: Integer; cdecl;
    {class} function _GetKEYCODE_DPAD_LEFT: Integer; cdecl;
    {class} function _GetKEYCODE_DPAD_RIGHT: Integer; cdecl;
    {class} function _GetKEYCODE_DPAD_UP: Integer; cdecl;
    {class} function _GetKEYCODE_DVR: Integer; cdecl;
    {class} function _GetKEYCODE_E: Integer; cdecl;
    {class} function _GetKEYCODE_EISU: Integer; cdecl;
    {class} function _GetKEYCODE_ENDCALL: Integer; cdecl;
    {class} function _GetKEYCODE_ENTER: Integer; cdecl;
    {class} function _GetKEYCODE_ENVELOPE: Integer; cdecl;
    {class} function _GetKEYCODE_EQUALS: Integer; cdecl;
    {class} function _GetKEYCODE_ESCAPE: Integer; cdecl;
    {class} function _GetKEYCODE_EXPLORER: Integer; cdecl;
    {class} function _GetKEYCODE_F: Integer; cdecl;
    {class} function _GetKEYCODE_F1: Integer; cdecl;
    {class} function _GetKEYCODE_F10: Integer; cdecl;
    {class} function _GetKEYCODE_F11: Integer; cdecl;
    {class} function _GetKEYCODE_F12: Integer; cdecl;
    {class} function _GetKEYCODE_F2: Integer; cdecl;
    {class} function _GetKEYCODE_F3: Integer; cdecl;
    {class} function _GetKEYCODE_F4: Integer; cdecl;
    {class} function _GetKEYCODE_F5: Integer; cdecl;
    {class} function _GetKEYCODE_F6: Integer; cdecl;
    {class} function _GetKEYCODE_F7: Integer; cdecl;
    {class} function _GetKEYCODE_F8: Integer; cdecl;
    {class} function _GetKEYCODE_F9: Integer; cdecl;
    {class} function _GetKEYCODE_FOCUS: Integer; cdecl;
    {class} function _GetKEYCODE_FORWARD: Integer; cdecl;
    {class} function _GetKEYCODE_FORWARD_DEL: Integer; cdecl;
    {class} function _GetKEYCODE_FUNCTION: Integer; cdecl;
    {class} function _GetKEYCODE_G: Integer; cdecl;
    {class} function _GetKEYCODE_GRAVE: Integer; cdecl;
    {class} function _GetKEYCODE_GUIDE: Integer; cdecl;
    {class} function _GetKEYCODE_H: Integer; cdecl;
    {class} function _GetKEYCODE_HEADSETHOOK: Integer; cdecl;
    {class} function _GetKEYCODE_HELP: Integer; cdecl;
    {class} function _GetKEYCODE_HENKAN: Integer; cdecl;
    {class} function _GetKEYCODE_HOME: Integer; cdecl;
    {class} function _GetKEYCODE_I: Integer; cdecl;
    {class} function _GetKEYCODE_INFO: Integer; cdecl;
    {class} function _GetKEYCODE_INSERT: Integer; cdecl;
    {class} function _GetKEYCODE_J: Integer; cdecl;
    {class} function _GetKEYCODE_K: Integer; cdecl;
    {class} function _GetKEYCODE_KANA: Integer; cdecl;
    {class} function _GetKEYCODE_KATAKANA_HIRAGANA: Integer; cdecl;
    {class} function _GetKEYCODE_L: Integer; cdecl;
    {class} function _GetKEYCODE_LANGUAGE_SWITCH: Integer; cdecl;
    {class} function _GetKEYCODE_LAST_CHANNEL: Integer; cdecl;
    {class} function _GetKEYCODE_LEFT_BRACKET: Integer; cdecl;
    {class} function _GetKEYCODE_M: Integer; cdecl;
    {class} function _GetKEYCODE_MANNER_MODE: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_AUDIO_TRACK: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_CLOSE: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_EJECT: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_FAST_FORWARD: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_NEXT: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_PAUSE: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_PLAY: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_PLAY_PAUSE: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_PREVIOUS: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_RECORD: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_REWIND: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_SKIP_BACKWARD: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_SKIP_FORWARD: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_STEP_BACKWARD: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_STEP_FORWARD: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_STOP: Integer; cdecl;
    {class} function _GetKEYCODE_MEDIA_TOP_MENU: Integer; cdecl;
    {class} function _GetKEYCODE_MENU: Integer; cdecl;
    {class} function _GetKEYCODE_META_LEFT: Integer; cdecl;
    {class} function _GetKEYCODE_META_RIGHT: Integer; cdecl;
    {class} function _GetKEYCODE_MINUS: Integer; cdecl;
    {class} function _GetKEYCODE_MOVE_END: Integer; cdecl;
    {class} function _GetKEYCODE_MOVE_HOME: Integer; cdecl;
    {class} function _GetKEYCODE_MUHENKAN: Integer; cdecl;
    {class} function _GetKEYCODE_MUSIC: Integer; cdecl;
    {class} function _GetKEYCODE_MUTE: Integer; cdecl;
    {class} function _GetKEYCODE_N: Integer; cdecl;
    {class} function _GetKEYCODE_NAVIGATE_IN: Integer; cdecl;
    {class} function _GetKEYCODE_NAVIGATE_NEXT: Integer; cdecl;
    {class} function _GetKEYCODE_NAVIGATE_OUT: Integer; cdecl;
    {class} function _GetKEYCODE_NAVIGATE_PREVIOUS: Integer; cdecl;
    {class} function _GetKEYCODE_NOTIFICATION: Integer; cdecl;
    {class} function _GetKEYCODE_NUM: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_0: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_1: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_2: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_3: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_4: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_5: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_6: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_7: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_8: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_9: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_ADD: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_COMMA: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_DIVIDE: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_DOT: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_ENTER: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_EQUALS: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_LEFT_PAREN: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_MULTIPLY: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_RIGHT_PAREN: Integer; cdecl;
    {class} function _GetKEYCODE_NUMPAD_SUBTRACT: Integer; cdecl;
    {class} function _GetKEYCODE_NUM_LOCK: Integer; cdecl;
    {class} function _GetKEYCODE_O: Integer; cdecl;
    {class} function _GetKEYCODE_P: Integer; cdecl;
    {class} function _GetKEYCODE_PAGE_DOWN: Integer; cdecl;
    {class} function _GetKEYCODE_PAGE_UP: Integer; cdecl;
    {class} function _GetKEYCODE_PAIRING: Integer; cdecl;
    {class} function _GetKEYCODE_PERIOD: Integer; cdecl;
    {class} function _GetKEYCODE_PICTSYMBOLS: Integer; cdecl;
    {class} function _GetKEYCODE_PLUS: Integer; cdecl;
    {class} function _GetKEYCODE_POUND: Integer; cdecl;
    {class} function _GetKEYCODE_POWER: Integer; cdecl;
    {class} function _GetKEYCODE_PROG_BLUE: Integer; cdecl;
    {class} function _GetKEYCODE_PROG_GREEN: Integer; cdecl;
    {class} function _GetKEYCODE_PROG_RED: Integer; cdecl;
    {class} function _GetKEYCODE_PROG_YELLOW: Integer; cdecl;
    {class} function _GetKEYCODE_Q: Integer; cdecl;
    {class} function _GetKEYCODE_R: Integer; cdecl;
    {class} function _GetKEYCODE_RIGHT_BRACKET: Integer; cdecl;
    {class} function _GetKEYCODE_RO: Integer; cdecl;
    {class} function _GetKEYCODE_S: Integer; cdecl;
    {class} function _GetKEYCODE_SCROLL_LOCK: Integer; cdecl;
    {class} function _GetKEYCODE_SEARCH: Integer; cdecl;
    {class} function _GetKEYCODE_SEMICOLON: Integer; cdecl;
    {class} function _GetKEYCODE_SETTINGS: Integer; cdecl;
    {class} function _GetKEYCODE_SHIFT_LEFT: Integer; cdecl;
    {class} function _GetKEYCODE_SHIFT_RIGHT: Integer; cdecl;
    {class} function _GetKEYCODE_SLASH: Integer; cdecl;
    {class} function _GetKEYCODE_SLEEP: Integer; cdecl;
    {class} function _GetKEYCODE_SOFT_LEFT: Integer; cdecl;
    {class} function _GetKEYCODE_SOFT_RIGHT: Integer; cdecl;
    {class} function _GetKEYCODE_SPACE: Integer; cdecl;
    {class} function _GetKEYCODE_STAR: Integer; cdecl;
    {class} function _GetKEYCODE_STB_INPUT: Integer; cdecl;
    {class} function _GetKEYCODE_STB_POWER: Integer; cdecl;
    {class} function _GetKEYCODE_SWITCH_CHARSET: Integer; cdecl;
    {class} function _GetKEYCODE_SYM: Integer; cdecl;
    {class} function _GetKEYCODE_SYSRQ: Integer; cdecl;
    {class} function _GetKEYCODE_T: Integer; cdecl;
    {class} function _GetKEYCODE_TAB: Integer; cdecl;
    {class} function _GetKEYCODE_TV: Integer; cdecl;
    {class} function _GetKEYCODE_TV_ANTENNA_CABLE: Integer; cdecl;
    {class} function _GetKEYCODE_TV_AUDIO_DESCRIPTION: Integer; cdecl;
    {class} function _GetKEYCODE_TV_AUDIO_DESCRIPTION_MIX_DOWN: Integer; cdecl;
    {class} function _GetKEYCODE_TV_AUDIO_DESCRIPTION_MIX_UP: Integer; cdecl;
    {class} function _GetKEYCODE_TV_CONTENTS_MENU: Integer; cdecl;
    {class} function _GetKEYCODE_TV_DATA_SERVICE: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_COMPONENT_1: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_COMPONENT_2: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_COMPOSITE_1: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_COMPOSITE_2: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_HDMI_1: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_HDMI_2: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_HDMI_3: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_HDMI_4: Integer; cdecl;
    {class} function _GetKEYCODE_TV_INPUT_VGA_1: Integer; cdecl;
    {class} function _GetKEYCODE_TV_MEDIA_CONTEXT_MENU: Integer; cdecl;
    {class} function _GetKEYCODE_TV_NETWORK: Integer; cdecl;
    {class} function _GetKEYCODE_TV_NUMBER_ENTRY: Integer; cdecl;
    {class} function _GetKEYCODE_TV_POWER: Integer; cdecl;
    {class} function _GetKEYCODE_TV_RADIO_SERVICE: Integer; cdecl;
    {class} function _GetKEYCODE_TV_SATELLITE: Integer; cdecl;
    {class} function _GetKEYCODE_TV_SATELLITE_BS: Integer; cdecl;
    {class} function _GetKEYCODE_TV_SATELLITE_CS: Integer; cdecl;
    {class} function _GetKEYCODE_TV_SATELLITE_SERVICE: Integer; cdecl;
    {class} function _GetKEYCODE_TV_TELETEXT: Integer; cdecl;
    {class} function _GetKEYCODE_TV_TERRESTRIAL_ANALOG: Integer; cdecl;
    {class} function _GetKEYCODE_TV_TERRESTRIAL_DIGITAL: Integer; cdecl;
    {class} function _GetKEYCODE_TV_TIMER_PROGRAMMING: Integer; cdecl;
    {class} function _GetKEYCODE_TV_ZOOM_MODE: Integer; cdecl;
    {class} function _GetKEYCODE_U: Integer; cdecl;
    {class} function _GetKEYCODE_UNKNOWN: Integer; cdecl;
    {class} function _GetKEYCODE_V: Integer; cdecl;
    {class} function _GetKEYCODE_VOICE_ASSIST: Integer; cdecl;
    {class} function _GetKEYCODE_VOLUME_DOWN: Integer; cdecl;
    {class} function _GetKEYCODE_VOLUME_MUTE: Integer; cdecl;
    {class} function _GetKEYCODE_VOLUME_UP: Integer; cdecl;
    {class} function _GetKEYCODE_W: Integer; cdecl;
    {class} function _GetKEYCODE_WAKEUP: Integer; cdecl;
    {class} function _GetKEYCODE_WINDOW: Integer; cdecl;
    {class} function _GetKEYCODE_X: Integer; cdecl;
    {class} function _GetKEYCODE_Y: Integer; cdecl;
    {class} function _GetKEYCODE_YEN: Integer; cdecl;
    {class} function _GetKEYCODE_Z: Integer; cdecl;
    {class} function _GetKEYCODE_ZENKAKU_HANKAKU: Integer; cdecl;
    {class} function _GetKEYCODE_ZOOM_IN: Integer; cdecl;
    {class} function _GetKEYCODE_ZOOM_OUT: Integer; cdecl;
    {class} function _GetMAX_KEYCODE: Integer; cdecl;
    {class} function _GetMETA_ALT_LEFT_ON: Integer; cdecl;
    {class} function _GetMETA_ALT_MASK: Integer; cdecl;
    {class} function _GetMETA_ALT_ON: Integer; cdecl;
    {class} function _GetMETA_ALT_RIGHT_ON: Integer; cdecl;
    {class} function _GetMETA_CAPS_LOCK_ON: Integer; cdecl;
    {class} function _GetMETA_CTRL_LEFT_ON: Integer; cdecl;
    {class} function _GetMETA_CTRL_MASK: Integer; cdecl;
    {class} function _GetMETA_CTRL_ON: Integer; cdecl;
    {class} function _GetMETA_CTRL_RIGHT_ON: Integer; cdecl;
    {class} function _GetMETA_FUNCTION_ON: Integer; cdecl;
    {class} function _GetMETA_META_LEFT_ON: Integer; cdecl;
    {class} function _GetMETA_META_MASK: Integer; cdecl;
    {class} function _GetMETA_META_ON: Integer; cdecl;
    {class} function _GetMETA_META_RIGHT_ON: Integer; cdecl;
    {class} function _GetMETA_NUM_LOCK_ON: Integer; cdecl;
    {class} function _GetMETA_SCROLL_LOCK_ON: Integer; cdecl;
    {class} function _GetMETA_SHIFT_LEFT_ON: Integer; cdecl;
    {class} function _GetMETA_SHIFT_MASK: Integer; cdecl;
    {class} function _GetMETA_SHIFT_ON: Integer; cdecl;
    {class} function _GetMETA_SHIFT_RIGHT_ON: Integer; cdecl;
    {class} function _GetMETA_SYM_ON: Integer; cdecl;
    {class} function init(action: Integer; code: Integer): JKeyEvent; cdecl; overload;
    {class} function init(downTime: Int64; eventTime: Int64; action: Integer; code: Integer; repeat_: Integer): JKeyEvent; cdecl; overload;
    {class} function init(downTime: Int64; eventTime: Int64; action: Integer; code: Integer; repeat_: Integer; metaState: Integer): JKeyEvent; cdecl; overload;
    {class} function init(downTime: Int64; eventTime: Int64; action: Integer; code: Integer; repeat_: Integer; metaState: Integer; deviceId: Integer; scancode: Integer): JKeyEvent; cdecl; overload;
    {class} function init(downTime: Int64; eventTime: Int64; action: Integer; code: Integer; repeat_: Integer; metaState: Integer; deviceId: Integer; scancode: Integer; flags: Integer): JKeyEvent; cdecl; overload;
    {class} function init(downTime: Int64; eventTime: Int64; action: Integer; code: Integer; repeat_: Integer; metaState: Integer; deviceId: Integer; scancode: Integer; flags: Integer; source: Integer): JKeyEvent; cdecl; overload;
    {class} function init(time: Int64; characters: JString; deviceId: Integer; flags: Integer): JKeyEvent; cdecl; overload;
    {class} function init(origEvent: JKeyEvent): JKeyEvent; cdecl; overload;
    {class} function init(origEvent: JKeyEvent; eventTime: Int64; newRepeat: Integer): JKeyEvent; cdecl; overload;//Deprecated
    {class} function changeAction(event: JKeyEvent; action: Integer): JKeyEvent; cdecl;
    {class} function changeFlags(event: JKeyEvent; flags: Integer): JKeyEvent; cdecl;
    {class} function changeTimeRepeat(event: JKeyEvent; eventTime: Int64; newRepeat: Integer): JKeyEvent; cdecl; overload;
    {class} function changeTimeRepeat(event: JKeyEvent; eventTime: Int64; newRepeat: Integer; newFlags: Integer): JKeyEvent; cdecl; overload;
    {class} function getDeadChar(accent: Integer; c: Integer): Integer; cdecl;
    {class} function getMaxKeyCode: Integer; cdecl;
    {class} function getModifierMetaStateMask: Integer; cdecl;
    {class} function isGamepadButton(keyCode: Integer): Boolean; cdecl;
    {class} function isModifierKey(keyCode: Integer): Boolean; cdecl;
    {class} function keyCodeFromString(symbolicName: JString): Integer; cdecl;
    {class} function keyCodeToString(keyCode: Integer): JString; cdecl;
    {class} function metaStateHasModifiers(metaState: Integer; modifiers: Integer): Boolean; cdecl;
    {class} function metaStateHasNoModifiers(metaState: Integer): Boolean; cdecl;
    {class} function normalizeMetaState(metaState: Integer): Integer; cdecl;
    {class} property ACTION_DOWN: Integer read _GetACTION_DOWN;
    {class} property ACTION_MULTIPLE: Integer read _GetACTION_MULTIPLE;
    {class} property ACTION_UP: Integer read _GetACTION_UP;
    {class} //CREATOR is defined in parent interface
    {class} property FLAG_CANCELED: Integer read _GetFLAG_CANCELED;
    {class} property FLAG_CANCELED_LONG_PRESS: Integer read _GetFLAG_CANCELED_LONG_PRESS;
    {class} property FLAG_EDITOR_ACTION: Integer read _GetFLAG_EDITOR_ACTION;
    {class} property FLAG_FALLBACK: Integer read _GetFLAG_FALLBACK;
    {class} property FLAG_FROM_SYSTEM: Integer read _GetFLAG_FROM_SYSTEM;
    {class} property FLAG_KEEP_TOUCH_MODE: Integer read _GetFLAG_KEEP_TOUCH_MODE;
    {class} property FLAG_LONG_PRESS: Integer read _GetFLAG_LONG_PRESS;
    {class} property FLAG_SOFT_KEYBOARD: Integer read _GetFLAG_SOFT_KEYBOARD;
    {class} property FLAG_TRACKING: Integer read _GetFLAG_TRACKING;
    {class} property FLAG_VIRTUAL_HARD_KEY: Integer read _GetFLAG_VIRTUAL_HARD_KEY;
    {class} property FLAG_WOKE_HERE: Integer read _GetFLAG_WOKE_HERE;
    {class} property KEYCODE_0: Integer read _GetKEYCODE_0;
    {class} property KEYCODE_1: Integer read _GetKEYCODE_1;
    {class} property KEYCODE_11: Integer read _GetKEYCODE_11;
    {class} property KEYCODE_12: Integer read _GetKEYCODE_12;
    {class} property KEYCODE_2: Integer read _GetKEYCODE_2;
    {class} property KEYCODE_3: Integer read _GetKEYCODE_3;
    {class} property KEYCODE_3D_MODE: Integer read _GetKEYCODE_3D_MODE;
    {class} property KEYCODE_4: Integer read _GetKEYCODE_4;
    {class} property KEYCODE_5: Integer read _GetKEYCODE_5;
    {class} property KEYCODE_6: Integer read _GetKEYCODE_6;
    {class} property KEYCODE_7: Integer read _GetKEYCODE_7;
    {class} property KEYCODE_8: Integer read _GetKEYCODE_8;
    {class} property KEYCODE_9: Integer read _GetKEYCODE_9;
    {class} property KEYCODE_A: Integer read _GetKEYCODE_A;
    {class} property KEYCODE_ALT_LEFT: Integer read _GetKEYCODE_ALT_LEFT;
    {class} property KEYCODE_ALT_RIGHT: Integer read _GetKEYCODE_ALT_RIGHT;
    {class} property KEYCODE_APOSTROPHE: Integer read _GetKEYCODE_APOSTROPHE;
    {class} property KEYCODE_APP_SWITCH: Integer read _GetKEYCODE_APP_SWITCH;
    {class} property KEYCODE_ASSIST: Integer read _GetKEYCODE_ASSIST;
    {class} property KEYCODE_AT: Integer read _GetKEYCODE_AT;
    {class} property KEYCODE_AVR_INPUT: Integer read _GetKEYCODE_AVR_INPUT;
    {class} property KEYCODE_AVR_POWER: Integer read _GetKEYCODE_AVR_POWER;
    {class} property KEYCODE_B: Integer read _GetKEYCODE_B;
    {class} property KEYCODE_BACK: Integer read _GetKEYCODE_BACK;
    {class} property KEYCODE_BACKSLASH: Integer read _GetKEYCODE_BACKSLASH;
    {class} property KEYCODE_BOOKMARK: Integer read _GetKEYCODE_BOOKMARK;
    {class} property KEYCODE_BREAK: Integer read _GetKEYCODE_BREAK;
    {class} property KEYCODE_BRIGHTNESS_DOWN: Integer read _GetKEYCODE_BRIGHTNESS_DOWN;
    {class} property KEYCODE_BRIGHTNESS_UP: Integer read _GetKEYCODE_BRIGHTNESS_UP;
    {class} property KEYCODE_BUTTON_1: Integer read _GetKEYCODE_BUTTON_1;
    {class} property KEYCODE_BUTTON_10: Integer read _GetKEYCODE_BUTTON_10;
    {class} property KEYCODE_BUTTON_11: Integer read _GetKEYCODE_BUTTON_11;
    {class} property KEYCODE_BUTTON_12: Integer read _GetKEYCODE_BUTTON_12;
    {class} property KEYCODE_BUTTON_13: Integer read _GetKEYCODE_BUTTON_13;
    {class} property KEYCODE_BUTTON_14: Integer read _GetKEYCODE_BUTTON_14;
    {class} property KEYCODE_BUTTON_15: Integer read _GetKEYCODE_BUTTON_15;
    {class} property KEYCODE_BUTTON_16: Integer read _GetKEYCODE_BUTTON_16;
    {class} property KEYCODE_BUTTON_2: Integer read _GetKEYCODE_BUTTON_2;
    {class} property KEYCODE_BUTTON_3: Integer read _GetKEYCODE_BUTTON_3;
    {class} property KEYCODE_BUTTON_4: Integer read _GetKEYCODE_BUTTON_4;
    {class} property KEYCODE_BUTTON_5: Integer read _GetKEYCODE_BUTTON_5;
    {class} property KEYCODE_BUTTON_6: Integer read _GetKEYCODE_BUTTON_6;
    {class} property KEYCODE_BUTTON_7: Integer read _GetKEYCODE_BUTTON_7;
    {class} property KEYCODE_BUTTON_8: Integer read _GetKEYCODE_BUTTON_8;
    {class} property KEYCODE_BUTTON_9: Integer read _GetKEYCODE_BUTTON_9;
    {class} property KEYCODE_BUTTON_A: Integer read _GetKEYCODE_BUTTON_A;
    {class} property KEYCODE_BUTTON_B: Integer read _GetKEYCODE_BUTTON_B;
    {class} property KEYCODE_BUTTON_C: Integer read _GetKEYCODE_BUTTON_C;
    {class} property KEYCODE_BUTTON_L1: Integer read _GetKEYCODE_BUTTON_L1;
    {class} property KEYCODE_BUTTON_L2: Integer read _GetKEYCODE_BUTTON_L2;
    {class} property KEYCODE_BUTTON_MODE: Integer read _GetKEYCODE_BUTTON_MODE;
    {class} property KEYCODE_BUTTON_R1: Integer read _GetKEYCODE_BUTTON_R1;
    {class} property KEYCODE_BUTTON_R2: Integer read _GetKEYCODE_BUTTON_R2;
    {class} property KEYCODE_BUTTON_SELECT: Integer read _GetKEYCODE_BUTTON_SELECT;
    {class} property KEYCODE_BUTTON_START: Integer read _GetKEYCODE_BUTTON_START;
    {class} property KEYCODE_BUTTON_THUMBL: Integer read _GetKEYCODE_BUTTON_THUMBL;
    {class} property KEYCODE_BUTTON_THUMBR: Integer read _GetKEYCODE_BUTTON_THUMBR;
    {class} property KEYCODE_BUTTON_X: Integer read _GetKEYCODE_BUTTON_X;
    {class} property KEYCODE_BUTTON_Y: Integer read _GetKEYCODE_BUTTON_Y;
    {class} property KEYCODE_BUTTON_Z: Integer read _GetKEYCODE_BUTTON_Z;
    {class} property KEYCODE_C: Integer read _GetKEYCODE_C;
    {class} property KEYCODE_CALCULATOR: Integer read _GetKEYCODE_CALCULATOR;
    {class} property KEYCODE_CALENDAR: Integer read _GetKEYCODE_CALENDAR;
    {class} property KEYCODE_CALL: Integer read _GetKEYCODE_CALL;
    {class} property KEYCODE_CAMERA: Integer read _GetKEYCODE_CAMERA;
    {class} property KEYCODE_CAPS_LOCK: Integer read _GetKEYCODE_CAPS_LOCK;
    {class} property KEYCODE_CAPTIONS: Integer read _GetKEYCODE_CAPTIONS;
    {class} property KEYCODE_CHANNEL_DOWN: Integer read _GetKEYCODE_CHANNEL_DOWN;
    {class} property KEYCODE_CHANNEL_UP: Integer read _GetKEYCODE_CHANNEL_UP;
    {class} property KEYCODE_CLEAR: Integer read _GetKEYCODE_CLEAR;
    {class} property KEYCODE_COMMA: Integer read _GetKEYCODE_COMMA;
    {class} property KEYCODE_CONTACTS: Integer read _GetKEYCODE_CONTACTS;
    {class} property KEYCODE_CTRL_LEFT: Integer read _GetKEYCODE_CTRL_LEFT;
    {class} property KEYCODE_CTRL_RIGHT: Integer read _GetKEYCODE_CTRL_RIGHT;
    {class} property KEYCODE_D: Integer read _GetKEYCODE_D;
    {class} property KEYCODE_DEL: Integer read _GetKEYCODE_DEL;
    {class} property KEYCODE_DPAD_CENTER: Integer read _GetKEYCODE_DPAD_CENTER;
    {class} property KEYCODE_DPAD_DOWN: Integer read _GetKEYCODE_DPAD_DOWN;
    {class} property KEYCODE_DPAD_LEFT: Integer read _GetKEYCODE_DPAD_LEFT;
    {class} property KEYCODE_DPAD_RIGHT: Integer read _GetKEYCODE_DPAD_RIGHT;
    {class} property KEYCODE_DPAD_UP: Integer read _GetKEYCODE_DPAD_UP;
    {class} property KEYCODE_DVR: Integer read _GetKEYCODE_DVR;
    {class} property KEYCODE_E: Integer read _GetKEYCODE_E;
    {class} property KEYCODE_EISU: Integer read _GetKEYCODE_EISU;
    {class} property KEYCODE_ENDCALL: Integer read _GetKEYCODE_ENDCALL;
    {class} property KEYCODE_ENTER: Integer read _GetKEYCODE_ENTER;
    {class} property KEYCODE_ENVELOPE: Integer read _GetKEYCODE_ENVELOPE;
    {class} property KEYCODE_EQUALS: Integer read _GetKEYCODE_EQUALS;
    {class} property KEYCODE_ESCAPE: Integer read _GetKEYCODE_ESCAPE;
    {class} property KEYCODE_EXPLORER: Integer read _GetKEYCODE_EXPLORER;
    {class} property KEYCODE_F: Integer read _GetKEYCODE_F;
    {class} property KEYCODE_F1: Integer read _GetKEYCODE_F1;
    {class} property KEYCODE_F10: Integer read _GetKEYCODE_F10;
    {class} property KEYCODE_F11: Integer read _GetKEYCODE_F11;
    {class} property KEYCODE_F12: Integer read _GetKEYCODE_F12;
    {class} property KEYCODE_F2: Integer read _GetKEYCODE_F2;
    {class} property KEYCODE_F3: Integer read _GetKEYCODE_F3;
    {class} property KEYCODE_F4: Integer read _GetKEYCODE_F4;
    {class} property KEYCODE_F5: Integer read _GetKEYCODE_F5;
    {class} property KEYCODE_F6: Integer read _GetKEYCODE_F6;
    {class} property KEYCODE_F7: Integer read _GetKEYCODE_F7;
    {class} property KEYCODE_F8: Integer read _GetKEYCODE_F8;
    {class} property KEYCODE_F9: Integer read _GetKEYCODE_F9;
    {class} property KEYCODE_FOCUS: Integer read _GetKEYCODE_FOCUS;
    {class} property KEYCODE_FORWARD: Integer read _GetKEYCODE_FORWARD;
    {class} property KEYCODE_FORWARD_DEL: Integer read _GetKEYCODE_FORWARD_DEL;
    {class} property KEYCODE_FUNCTION: Integer read _GetKEYCODE_FUNCTION;
    {class} property KEYCODE_G: Integer read _GetKEYCODE_G;
    {class} property KEYCODE_GRAVE: Integer read _GetKEYCODE_GRAVE;
    {class} property KEYCODE_GUIDE: Integer read _GetKEYCODE_GUIDE;
    {class} property KEYCODE_H: Integer read _GetKEYCODE_H;
    {class} property KEYCODE_HEADSETHOOK: Integer read _GetKEYCODE_HEADSETHOOK;
    {class} property KEYCODE_HELP: Integer read _GetKEYCODE_HELP;
    {class} property KEYCODE_HENKAN: Integer read _GetKEYCODE_HENKAN;
    {class} property KEYCODE_HOME: Integer read _GetKEYCODE_HOME;
    {class} property KEYCODE_I: Integer read _GetKEYCODE_I;
    {class} property KEYCODE_INFO: Integer read _GetKEYCODE_INFO;
    {class} property KEYCODE_INSERT: Integer read _GetKEYCODE_INSERT;
    {class} property KEYCODE_J: Integer read _GetKEYCODE_J;
    {class} property KEYCODE_K: Integer read _GetKEYCODE_K;
    {class} property KEYCODE_KANA: Integer read _GetKEYCODE_KANA;
    {class} property KEYCODE_KATAKANA_HIRAGANA: Integer read _GetKEYCODE_KATAKANA_HIRAGANA;
    {class} property KEYCODE_L: Integer read _GetKEYCODE_L;
    {class} property KEYCODE_LANGUAGE_SWITCH: Integer read _GetKEYCODE_LANGUAGE_SWITCH;
    {class} property KEYCODE_LAST_CHANNEL: Integer read _GetKEYCODE_LAST_CHANNEL;
    {class} property KEYCODE_LEFT_BRACKET: Integer read _GetKEYCODE_LEFT_BRACKET;
    {class} property KEYCODE_M: Integer read _GetKEYCODE_M;
    {class} property KEYCODE_MANNER_MODE: Integer read _GetKEYCODE_MANNER_MODE;
    {class} property KEYCODE_MEDIA_AUDIO_TRACK: Integer read _GetKEYCODE_MEDIA_AUDIO_TRACK;
    {class} property KEYCODE_MEDIA_CLOSE: Integer read _GetKEYCODE_MEDIA_CLOSE;
    {class} property KEYCODE_MEDIA_EJECT: Integer read _GetKEYCODE_MEDIA_EJECT;
    {class} property KEYCODE_MEDIA_FAST_FORWARD: Integer read _GetKEYCODE_MEDIA_FAST_FORWARD;
    {class} property KEYCODE_MEDIA_NEXT: Integer read _GetKEYCODE_MEDIA_NEXT;
    {class} property KEYCODE_MEDIA_PAUSE: Integer read _GetKEYCODE_MEDIA_PAUSE;
    {class} property KEYCODE_MEDIA_PLAY: Integer read _GetKEYCODE_MEDIA_PLAY;
    {class} property KEYCODE_MEDIA_PLAY_PAUSE: Integer read _GetKEYCODE_MEDIA_PLAY_PAUSE;
    {class} property KEYCODE_MEDIA_PREVIOUS: Integer read _GetKEYCODE_MEDIA_PREVIOUS;
    {class} property KEYCODE_MEDIA_RECORD: Integer read _GetKEYCODE_MEDIA_RECORD;
    {class} property KEYCODE_MEDIA_REWIND: Integer read _GetKEYCODE_MEDIA_REWIND;
    {class} property KEYCODE_MEDIA_SKIP_BACKWARD: Integer read _GetKEYCODE_MEDIA_SKIP_BACKWARD;
    {class} property KEYCODE_MEDIA_SKIP_FORWARD: Integer read _GetKEYCODE_MEDIA_SKIP_FORWARD;
    {class} property KEYCODE_MEDIA_STEP_BACKWARD: Integer read _GetKEYCODE_MEDIA_STEP_BACKWARD;
    {class} property KEYCODE_MEDIA_STEP_FORWARD: Integer read _GetKEYCODE_MEDIA_STEP_FORWARD;
    {class} property KEYCODE_MEDIA_STOP: Integer read _GetKEYCODE_MEDIA_STOP;
    {class} property KEYCODE_MEDIA_TOP_MENU: Integer read _GetKEYCODE_MEDIA_TOP_MENU;
    {class} property KEYCODE_MENU: Integer read _GetKEYCODE_MENU;
    {class} property KEYCODE_META_LEFT: Integer read _GetKEYCODE_META_LEFT;
    {class} property KEYCODE_META_RIGHT: Integer read _GetKEYCODE_META_RIGHT;
    {class} property KEYCODE_MINUS: Integer read _GetKEYCODE_MINUS;
    {class} property KEYCODE_MOVE_END: Integer read _GetKEYCODE_MOVE_END;
    {class} property KEYCODE_MOVE_HOME: Integer read _GetKEYCODE_MOVE_HOME;
    {class} property KEYCODE_MUHENKAN: Integer read _GetKEYCODE_MUHENKAN;
    {class} property KEYCODE_MUSIC: Integer read _GetKEYCODE_MUSIC;
    {class} property KEYCODE_MUTE: Integer read _GetKEYCODE_MUTE;
    {class} property KEYCODE_N: Integer read _GetKEYCODE_N;
    {class} property KEYCODE_NAVIGATE_IN: Integer read _GetKEYCODE_NAVIGATE_IN;
    {class} property KEYCODE_NAVIGATE_NEXT: Integer read _GetKEYCODE_NAVIGATE_NEXT;
    {class} property KEYCODE_NAVIGATE_OUT: Integer read _GetKEYCODE_NAVIGATE_OUT;
    {class} property KEYCODE_NAVIGATE_PREVIOUS: Integer read _GetKEYCODE_NAVIGATE_PREVIOUS;
    {class} property KEYCODE_NOTIFICATION: Integer read _GetKEYCODE_NOTIFICATION;
    {class} property KEYCODE_NUM: Integer read _GetKEYCODE_NUM;
    {class} property KEYCODE_NUMPAD_0: Integer read _GetKEYCODE_NUMPAD_0;
    {class} property KEYCODE_NUMPAD_1: Integer read _GetKEYCODE_NUMPAD_1;
    {class} property KEYCODE_NUMPAD_2: Integer read _GetKEYCODE_NUMPAD_2;
    {class} property KEYCODE_NUMPAD_3: Integer read _GetKEYCODE_NUMPAD_3;
    {class} property KEYCODE_NUMPAD_4: Integer read _GetKEYCODE_NUMPAD_4;
    {class} property KEYCODE_NUMPAD_5: Integer read _GetKEYCODE_NUMPAD_5;
    {class} property KEYCODE_NUMPAD_6: Integer read _GetKEYCODE_NUMPAD_6;
    {class} property KEYCODE_NUMPAD_7: Integer read _GetKEYCODE_NUMPAD_7;
    {class} property KEYCODE_NUMPAD_8: Integer read _GetKEYCODE_NUMPAD_8;
    {class} property KEYCODE_NUMPAD_9: Integer read _GetKEYCODE_NUMPAD_9;
    {class} property KEYCODE_NUMPAD_ADD: Integer read _GetKEYCODE_NUMPAD_ADD;
    {class} property KEYCODE_NUMPAD_COMMA: Integer read _GetKEYCODE_NUMPAD_COMMA;
    {class} property KEYCODE_NUMPAD_DIVIDE: Integer read _GetKEYCODE_NUMPAD_DIVIDE;
    {class} property KEYCODE_NUMPAD_DOT: Integer read _GetKEYCODE_NUMPAD_DOT;
    {class} property KEYCODE_NUMPAD_ENTER: Integer read _GetKEYCODE_NUMPAD_ENTER;
    {class} property KEYCODE_NUMPAD_EQUALS: Integer read _GetKEYCODE_NUMPAD_EQUALS;
    {class} property KEYCODE_NUMPAD_LEFT_PAREN: Integer read _GetKEYCODE_NUMPAD_LEFT_PAREN;
    {class} property KEYCODE_NUMPAD_MULTIPLY: Integer read _GetKEYCODE_NUMPAD_MULTIPLY;
    {class} property KEYCODE_NUMPAD_RIGHT_PAREN: Integer read _GetKEYCODE_NUMPAD_RIGHT_PAREN;
    {class} property KEYCODE_NUMPAD_SUBTRACT: Integer read _GetKEYCODE_NUMPAD_SUBTRACT;
    {class} property KEYCODE_NUM_LOCK: Integer read _GetKEYCODE_NUM_LOCK;
    {class} property KEYCODE_O: Integer read _GetKEYCODE_O;
    {class} property KEYCODE_P: Integer read _GetKEYCODE_P;
    {class} property KEYCODE_PAGE_DOWN: Integer read _GetKEYCODE_PAGE_DOWN;
    {class} property KEYCODE_PAGE_UP: Integer read _GetKEYCODE_PAGE_UP;
    {class} property KEYCODE_PAIRING: Integer read _GetKEYCODE_PAIRING;
    {class} property KEYCODE_PERIOD: Integer read _GetKEYCODE_PERIOD;
    {class} property KEYCODE_PICTSYMBOLS: Integer read _GetKEYCODE_PICTSYMBOLS;
    {class} property KEYCODE_PLUS: Integer read _GetKEYCODE_PLUS;
    {class} property KEYCODE_POUND: Integer read _GetKEYCODE_POUND;
    {class} property KEYCODE_POWER: Integer read _GetKEYCODE_POWER;
    {class} property KEYCODE_PROG_BLUE: Integer read _GetKEYCODE_PROG_BLUE;
    {class} property KEYCODE_PROG_GREEN: Integer read _GetKEYCODE_PROG_GREEN;
    {class} property KEYCODE_PROG_RED: Integer read _GetKEYCODE_PROG_RED;
    {class} property KEYCODE_PROG_YELLOW: Integer read _GetKEYCODE_PROG_YELLOW;
    {class} property KEYCODE_Q: Integer read _GetKEYCODE_Q;
    {class} property KEYCODE_R: Integer read _GetKEYCODE_R;
    {class} property KEYCODE_RIGHT_BRACKET: Integer read _GetKEYCODE_RIGHT_BRACKET;
    {class} property KEYCODE_RO: Integer read _GetKEYCODE_RO;
    {class} property KEYCODE_S: Integer read _GetKEYCODE_S;
    {class} property KEYCODE_SCROLL_LOCK: Integer read _GetKEYCODE_SCROLL_LOCK;
    {class} property KEYCODE_SEARCH: Integer read _GetKEYCODE_SEARCH;
    {class} property KEYCODE_SEMICOLON: Integer read _GetKEYCODE_SEMICOLON;
    {class} property KEYCODE_SETTINGS: Integer read _GetKEYCODE_SETTINGS;
    {class} property KEYCODE_SHIFT_LEFT: Integer read _GetKEYCODE_SHIFT_LEFT;
    {class} property KEYCODE_SHIFT_RIGHT: Integer read _GetKEYCODE_SHIFT_RIGHT;
    {class} property KEYCODE_SLASH: Integer read _GetKEYCODE_SLASH;
    {class} property KEYCODE_SLEEP: Integer read _GetKEYCODE_SLEEP;
    {class} property KEYCODE_SOFT_LEFT: Integer read _GetKEYCODE_SOFT_LEFT;
    {class} property KEYCODE_SOFT_RIGHT: Integer read _GetKEYCODE_SOFT_RIGHT;
    {class} property KEYCODE_SPACE: Integer read _GetKEYCODE_SPACE;
    {class} property KEYCODE_STAR: Integer read _GetKEYCODE_STAR;
    {class} property KEYCODE_STB_INPUT: Integer read _GetKEYCODE_STB_INPUT;
    {class} property KEYCODE_STB_POWER: Integer read _GetKEYCODE_STB_POWER;
    {class} property KEYCODE_SWITCH_CHARSET: Integer read _GetKEYCODE_SWITCH_CHARSET;
    {class} property KEYCODE_SYM: Integer read _GetKEYCODE_SYM;
    {class} property KEYCODE_SYSRQ: Integer read _GetKEYCODE_SYSRQ;
    {class} property KEYCODE_T: Integer read _GetKEYCODE_T;
    {class} property KEYCODE_TAB: Integer read _GetKEYCODE_TAB;
    {class} property KEYCODE_TV: Integer read _GetKEYCODE_TV;
    {class} property KEYCODE_TV_ANTENNA_CABLE: Integer read _GetKEYCODE_TV_ANTENNA_CABLE;
    {class} property KEYCODE_TV_AUDIO_DESCRIPTION: Integer read _GetKEYCODE_TV_AUDIO_DESCRIPTION;
    {class} property KEYCODE_TV_AUDIO_DESCRIPTION_MIX_DOWN: Integer read _GetKEYCODE_TV_AUDIO_DESCRIPTION_MIX_DOWN;
    {class} property KEYCODE_TV_AUDIO_DESCRIPTION_MIX_UP: Integer read _GetKEYCODE_TV_AUDIO_DESCRIPTION_MIX_UP;
    {class} property KEYCODE_TV_CONTENTS_MENU: Integer read _GetKEYCODE_TV_CONTENTS_MENU;
    {class} property KEYCODE_TV_DATA_SERVICE: Integer read _GetKEYCODE_TV_DATA_SERVICE;
    {class} property KEYCODE_TV_INPUT: Integer read _GetKEYCODE_TV_INPUT;
    {class} property KEYCODE_TV_INPUT_COMPONENT_1: Integer read _GetKEYCODE_TV_INPUT_COMPONENT_1;
    {class} property KEYCODE_TV_INPUT_COMPONENT_2: Integer read _GetKEYCODE_TV_INPUT_COMPONENT_2;
    {class} property KEYCODE_TV_INPUT_COMPOSITE_1: Integer read _GetKEYCODE_TV_INPUT_COMPOSITE_1;
    {class} property KEYCODE_TV_INPUT_COMPOSITE_2: Integer read _GetKEYCODE_TV_INPUT_COMPOSITE_2;
    {class} property KEYCODE_TV_INPUT_HDMI_1: Integer read _GetKEYCODE_TV_INPUT_HDMI_1;
    {class} property KEYCODE_TV_INPUT_HDMI_2: Integer read _GetKEYCODE_TV_INPUT_HDMI_2;
    {class} property KEYCODE_TV_INPUT_HDMI_3: Integer read _GetKEYCODE_TV_INPUT_HDMI_3;
    {class} property KEYCODE_TV_INPUT_HDMI_4: Integer read _GetKEYCODE_TV_INPUT_HDMI_4;
    {class} property KEYCODE_TV_INPUT_VGA_1: Integer read _GetKEYCODE_TV_INPUT_VGA_1;
    {class} property KEYCODE_TV_MEDIA_CONTEXT_MENU: Integer read _GetKEYCODE_TV_MEDIA_CONTEXT_MENU;
    {class} property KEYCODE_TV_NETWORK: Integer read _GetKEYCODE_TV_NETWORK;
    {class} property KEYCODE_TV_NUMBER_ENTRY: Integer read _GetKEYCODE_TV_NUMBER_ENTRY;
    {class} property KEYCODE_TV_POWER: Integer read _GetKEYCODE_TV_POWER;
    {class} property KEYCODE_TV_RADIO_SERVICE: Integer read _GetKEYCODE_TV_RADIO_SERVICE;
    {class} property KEYCODE_TV_SATELLITE: Integer read _GetKEYCODE_TV_SATELLITE;
    {class} property KEYCODE_TV_SATELLITE_BS: Integer read _GetKEYCODE_TV_SATELLITE_BS;
    {class} property KEYCODE_TV_SATELLITE_CS: Integer read _GetKEYCODE_TV_SATELLITE_CS;
    {class} property KEYCODE_TV_SATELLITE_SERVICE: Integer read _GetKEYCODE_TV_SATELLITE_SERVICE;
    {class} property KEYCODE_TV_TELETEXT: Integer read _GetKEYCODE_TV_TELETEXT;
    {class} property KEYCODE_TV_TERRESTRIAL_ANALOG: Integer read _GetKEYCODE_TV_TERRESTRIAL_ANALOG;
    {class} property KEYCODE_TV_TERRESTRIAL_DIGITAL: Integer read _GetKEYCODE_TV_TERRESTRIAL_DIGITAL;
    {class} property KEYCODE_TV_TIMER_PROGRAMMING: Integer read _GetKEYCODE_TV_TIMER_PROGRAMMING;
    {class} property KEYCODE_TV_ZOOM_MODE: Integer read _GetKEYCODE_TV_ZOOM_MODE;
    {class} property KEYCODE_U: Integer read _GetKEYCODE_U;
    {class} property KEYCODE_UNKNOWN: Integer read _GetKEYCODE_UNKNOWN;
    {class} property KEYCODE_V: Integer read _GetKEYCODE_V;
    {class} property KEYCODE_VOICE_ASSIST: Integer read _GetKEYCODE_VOICE_ASSIST;
    {class} property KEYCODE_VOLUME_DOWN: Integer read _GetKEYCODE_VOLUME_DOWN;
    {class} property KEYCODE_VOLUME_MUTE: Integer read _GetKEYCODE_VOLUME_MUTE;
    {class} property KEYCODE_VOLUME_UP: Integer read _GetKEYCODE_VOLUME_UP;
    {class} property KEYCODE_W: Integer read _GetKEYCODE_W;
    {class} property KEYCODE_WAKEUP: Integer read _GetKEYCODE_WAKEUP;
    {class} property KEYCODE_WINDOW: Integer read _GetKEYCODE_WINDOW;
    {class} property KEYCODE_X: Integer read _GetKEYCODE_X;
    {class} property KEYCODE_Y: Integer read _GetKEYCODE_Y;
    {class} property KEYCODE_YEN: Integer read _GetKEYCODE_YEN;
    {class} property KEYCODE_Z: Integer read _GetKEYCODE_Z;
    {class} property KEYCODE_ZENKAKU_HANKAKU: Integer read _GetKEYCODE_ZENKAKU_HANKAKU;
    {class} property KEYCODE_ZOOM_IN: Integer read _GetKEYCODE_ZOOM_IN;
    {class} property KEYCODE_ZOOM_OUT: Integer read _GetKEYCODE_ZOOM_OUT;
    {class} property MAX_KEYCODE: Integer read _GetMAX_KEYCODE;
    {class} property META_ALT_LEFT_ON: Integer read _GetMETA_ALT_LEFT_ON;
    {class} property META_ALT_MASK: Integer read _GetMETA_ALT_MASK;
    {class} property META_ALT_ON: Integer read _GetMETA_ALT_ON;
    {class} property META_ALT_RIGHT_ON: Integer read _GetMETA_ALT_RIGHT_ON;
    {class} property META_CAPS_LOCK_ON: Integer read _GetMETA_CAPS_LOCK_ON;
    {class} property META_CTRL_LEFT_ON: Integer read _GetMETA_CTRL_LEFT_ON;
    {class} property META_CTRL_MASK: Integer read _GetMETA_CTRL_MASK;
    {class} property META_CTRL_ON: Integer read _GetMETA_CTRL_ON;
    {class} property META_CTRL_RIGHT_ON: Integer read _GetMETA_CTRL_RIGHT_ON;
    {class} property META_FUNCTION_ON: Integer read _GetMETA_FUNCTION_ON;
    {class} property META_META_LEFT_ON: Integer read _GetMETA_META_LEFT_ON;
    {class} property META_META_MASK: Integer read _GetMETA_META_MASK;
    {class} property META_META_ON: Integer read _GetMETA_META_ON;
    {class} property META_META_RIGHT_ON: Integer read _GetMETA_META_RIGHT_ON;
    {class} property META_NUM_LOCK_ON: Integer read _GetMETA_NUM_LOCK_ON;
    {class} property META_SCROLL_LOCK_ON: Integer read _GetMETA_SCROLL_LOCK_ON;
    {class} property META_SHIFT_LEFT_ON: Integer read _GetMETA_SHIFT_LEFT_ON;
    {class} property META_SHIFT_MASK: Integer read _GetMETA_SHIFT_MASK;
    {class} property META_SHIFT_ON: Integer read _GetMETA_SHIFT_ON;
    {class} property META_SHIFT_RIGHT_ON: Integer read _GetMETA_SHIFT_RIGHT_ON;
    {class} property META_SYM_ON: Integer read _GetMETA_SYM_ON;
  end;

  [JavaSignature('android/view/KeyEvent')]
  JKeyEvent = interface(JInputEvent)
    ['{EB2AEB24-3B12-4FA3-8D94-636EE7A15435}']
    function dispatch(receiver: JKeyEvent_Callback): Boolean; cdecl; overload;//Deprecated
    function dispatch(receiver: JKeyEvent_Callback; state: JKeyEvent_DispatcherState; target: JObject): Boolean; cdecl; overload;
    function getAction: Integer; cdecl;
    function getCharacters: JString; cdecl;
    function getDeviceId: Integer; cdecl;
    function getDisplayLabel: Char; cdecl;
    function getDownTime: Int64; cdecl;
    function getEventTime: Int64; cdecl;
    function getFlags: Integer; cdecl;
    function getKeyCharacterMap: JKeyCharacterMap; cdecl;
    function getKeyCode: Integer; cdecl;
    function getKeyData(results: JKeyCharacterMap_KeyData): Boolean; cdecl;//Deprecated
    function getMatch(chars: TJavaArray<Char>): Char; cdecl; overload;
    function getMatch(chars: TJavaArray<Char>; metaState: Integer): Char; cdecl; overload;
    function getMetaState: Integer; cdecl;
    function getModifiers: Integer; cdecl;
    function getNumber: Char; cdecl;
    function getRepeatCount: Integer; cdecl;
    function getScanCode: Integer; cdecl;
    function getSource: Integer; cdecl;
    function getUnicodeChar: Integer; cdecl; overload;
    function getUnicodeChar(metaState: Integer): Integer; cdecl; overload;
    function hasModifiers(modifiers: Integer): Boolean; cdecl;
    function hasNoModifiers: Boolean; cdecl;
    function isAltPressed: Boolean; cdecl;
    function isCanceled: Boolean; cdecl;
    function isCapsLockOn: Boolean; cdecl;
    function isCtrlPressed: Boolean; cdecl;
    function isFunctionPressed: Boolean; cdecl;
    function isLongPress: Boolean; cdecl;
    function isMetaPressed: Boolean; cdecl;
    function isNumLockOn: Boolean; cdecl;
    function isPrintingKey: Boolean; cdecl;
    function isScrollLockOn: Boolean; cdecl;
    function isShiftPressed: Boolean; cdecl;
    function isSymPressed: Boolean; cdecl;
    function isSystem: Boolean; cdecl;
    function isTracking: Boolean; cdecl;
    procedure setSource(source: Integer); cdecl;
    procedure startTracking; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJKeyEvent = class(TJavaGenericImport<JKeyEventClass, JKeyEvent>) end;

  JKeyEvent_CallbackClass = interface(IJavaClass)
    ['{681049BD-1FD0-428D-8B0B-B5A7A4A25103}']
  end;

  [JavaSignature('android/view/KeyEvent$Callback')]
  JKeyEvent_Callback = interface(IJavaInstance)
    ['{DE393309-B906-4BEB-80A7-9285BDDD9BA9}']
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyLongPress(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyMultiple(keyCode: Integer; count: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
  end;
  TJKeyEvent_Callback = class(TJavaGenericImport<JKeyEvent_CallbackClass, JKeyEvent_Callback>) end;

  JKeyEvent_DispatcherStateClass = interface(JObjectClass)
    ['{177CF315-60C0-49F2-B775-6402E70AFA6C}']
    {class} function init: JKeyEvent_DispatcherState; cdecl;
  end;

  [JavaSignature('android/view/KeyEvent$DispatcherState')]
  JKeyEvent_DispatcherState = interface(JObject)
    ['{A8C80695-5C72-4B34-91F0-F4FADF05FEBA}']
    procedure handleUpEvent(event: JKeyEvent); cdecl;
    function isTracking(event: JKeyEvent): Boolean; cdecl;
    procedure performedLongPress(event: JKeyEvent); cdecl;
    procedure reset; cdecl; overload;
    procedure reset(target: JObject); cdecl; overload;
    procedure startTracking(event: JKeyEvent; target: JObject); cdecl;
  end;
  TJKeyEvent_DispatcherState = class(TJavaGenericImport<JKeyEvent_DispatcherStateClass, JKeyEvent_DispatcherState>) end;

  JLayoutInflaterClass = interface(JObjectClass)
    ['{FD7AD6DE-7D47-48E0-9E0E-EF34B5CC6720}']
    {class} function from(context: JContext): JLayoutInflater; cdecl;
  end;

  [JavaSignature('android/view/LayoutInflater')]
  JLayoutInflater = interface(JObject)
    ['{F65EBB1F-25CF-4A00-92E4-B16D40BF4299}']
    function cloneInContext(newContext: JContext): JLayoutInflater; cdecl;
    function createView(name: JString; prefix: JString; attrs: JAttributeSet): JView; cdecl;
    function getContext: JContext; cdecl;
    function getFactory: JLayoutInflater_Factory; cdecl;
    function getFactory2: JLayoutInflater_Factory2; cdecl;
    function getFilter: JLayoutInflater_Filter; cdecl;
    function inflate(resource: Integer; root: JViewGroup): JView; cdecl; overload;
    function inflate(parser: JXmlPullParser; root: JViewGroup): JView; cdecl; overload;
    function inflate(resource: Integer; root: JViewGroup; attachToRoot: Boolean): JView; cdecl; overload;
    function inflate(parser: JXmlPullParser; root: JViewGroup; attachToRoot: Boolean): JView; cdecl; overload;
    procedure setFactory(factory: JLayoutInflater_Factory); cdecl;
    procedure setFactory2(factory: JLayoutInflater_Factory2); cdecl;
    procedure setFilter(filter: JLayoutInflater_Filter); cdecl;
  end;
  TJLayoutInflater = class(TJavaGenericImport<JLayoutInflaterClass, JLayoutInflater>) end;

  JLayoutInflater_FactoryClass = interface(IJavaClass)
    ['{B778AAF7-E1CD-4A08-9330-31E71A823B3E}']
  end;

  [JavaSignature('android/view/LayoutInflater$Factory')]
  JLayoutInflater_Factory = interface(IJavaInstance)
    ['{4F826237-FA2E-4392-A26B-5F7C6ACB48E3}']
    function onCreateView(name: JString; context: JContext; attrs: JAttributeSet): JView; cdecl;
  end;
  TJLayoutInflater_Factory = class(TJavaGenericImport<JLayoutInflater_FactoryClass, JLayoutInflater_Factory>) end;

  JLayoutInflater_Factory2Class = interface(JLayoutInflater_FactoryClass)
    ['{E157E921-555A-4D25-82AF-60CB4AED982C}']
  end;

  [JavaSignature('android/view/LayoutInflater$Factory2')]
  JLayoutInflater_Factory2 = interface(JLayoutInflater_Factory)
    ['{FF951177-1917-41A4-99C0-8B707393FACF}']
    function onCreateView(parent: JView; name: JString; context: JContext; attrs: JAttributeSet): JView; cdecl;
  end;
  TJLayoutInflater_Factory2 = class(TJavaGenericImport<JLayoutInflater_Factory2Class, JLayoutInflater_Factory2>) end;

  JLayoutInflater_FilterClass = interface(IJavaClass)
    ['{504748F4-5E9F-480B-8779-1622CA371CA7}']
  end;

  [JavaSignature('android/view/LayoutInflater$Filter')]
  JLayoutInflater_Filter = interface(IJavaInstance)
    ['{89E43521-AEEE-4746-95F9-732DA680FA75}']
    function onLoadClass(clazz: Jlang_Class): Boolean; cdecl;
  end;
  TJLayoutInflater_Filter = class(TJavaGenericImport<JLayoutInflater_FilterClass, JLayoutInflater_Filter>) end;

  JMenuInflaterClass = interface(JObjectClass)
    ['{0B821491-17EC-4FA7-9BD8-A52F15EBA066}']
    {class} function init(context: JContext): JMenuInflater; cdecl;
  end;

  [JavaSignature('android/view/MenuInflater')]
  JMenuInflater = interface(JObject)
    ['{D8483B67-5688-41FE-98D1-4FE7765FCE12}']
    procedure inflate(menuRes: Integer; menu: JMenu); cdecl;
  end;
  TJMenuInflater = class(TJavaGenericImport<JMenuInflaterClass, JMenuInflater>) end;

  JMenuItemClass = interface(IJavaClass)
    ['{211E0ADC-2FE6-4521-8B8E-1BA046C7795D}']
    {class} function _GetSHOW_AS_ACTION_ALWAYS: Integer; cdecl;
    {class} function _GetSHOW_AS_ACTION_COLLAPSE_ACTION_VIEW: Integer; cdecl;
    {class} function _GetSHOW_AS_ACTION_IF_ROOM: Integer; cdecl;
    {class} function _GetSHOW_AS_ACTION_NEVER: Integer; cdecl;
    {class} function _GetSHOW_AS_ACTION_WITH_TEXT: Integer; cdecl;
    {class} property SHOW_AS_ACTION_ALWAYS: Integer read _GetSHOW_AS_ACTION_ALWAYS;
    {class} property SHOW_AS_ACTION_COLLAPSE_ACTION_VIEW: Integer read _GetSHOW_AS_ACTION_COLLAPSE_ACTION_VIEW;
    {class} property SHOW_AS_ACTION_IF_ROOM: Integer read _GetSHOW_AS_ACTION_IF_ROOM;
    {class} property SHOW_AS_ACTION_NEVER: Integer read _GetSHOW_AS_ACTION_NEVER;
    {class} property SHOW_AS_ACTION_WITH_TEXT: Integer read _GetSHOW_AS_ACTION_WITH_TEXT;
  end;

  [JavaSignature('android/view/MenuItem')]
  JMenuItem = interface(IJavaInstance)
    ['{C8611D60-549B-49E7-A560-1D25F0294587}']
    function collapseActionView: Boolean; cdecl;
    function expandActionView: Boolean; cdecl;
    function getActionProvider: JActionProvider; cdecl;
    function getActionView: JView; cdecl;
    function getAlphabeticShortcut: Char; cdecl;
    function getGroupId: Integer; cdecl;
    function getIcon: JDrawable; cdecl;
    function getIntent: JIntent; cdecl;
    function getItemId: Integer; cdecl;
    function getMenuInfo: JContextMenu_ContextMenuInfo; cdecl;
    function getNumericShortcut: Char; cdecl;
    function getOrder: Integer; cdecl;
    function getSubMenu: JSubMenu; cdecl;
    function getTitle: JCharSequence; cdecl;
    function getTitleCondensed: JCharSequence; cdecl;
    function hasSubMenu: Boolean; cdecl;
    function isActionViewExpanded: Boolean; cdecl;
    function isCheckable: Boolean; cdecl;
    function isChecked: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    function setActionProvider(actionProvider: JActionProvider): JMenuItem; cdecl;
    function setActionView(view: JView): JMenuItem; cdecl; overload;
    function setActionView(resId: Integer): JMenuItem; cdecl; overload;
    function setAlphabeticShortcut(alphaChar: Char): JMenuItem; cdecl;
    function setCheckable(checkable: Boolean): JMenuItem; cdecl;
    function setChecked(checked: Boolean): JMenuItem; cdecl;
    function setEnabled(enabled: Boolean): JMenuItem; cdecl;
    function setIcon(icon: JDrawable): JMenuItem; cdecl; overload;
    function setIcon(iconRes: Integer): JMenuItem; cdecl; overload;
    function setIntent(intent: JIntent): JMenuItem; cdecl;
    function setNumericShortcut(numericChar: Char): JMenuItem; cdecl;
    function setOnActionExpandListener(listener: JMenuItem_OnActionExpandListener): JMenuItem; cdecl;
    function setOnMenuItemClickListener(menuItemClickListener: JMenuItem_OnMenuItemClickListener): JMenuItem; cdecl;
    function setShortcut(numericChar: Char; alphaChar: Char): JMenuItem; cdecl;
    procedure setShowAsAction(actionEnum: Integer); cdecl;
    function setShowAsActionFlags(actionEnum: Integer): JMenuItem; cdecl;
    function setTitle(title: JCharSequence): JMenuItem; cdecl; overload;
    function setTitle(title: Integer): JMenuItem; cdecl; overload;
    function setTitleCondensed(title: JCharSequence): JMenuItem; cdecl;
    function setVisible(visible: Boolean): JMenuItem; cdecl;
  end;
  TJMenuItem = class(TJavaGenericImport<JMenuItemClass, JMenuItem>) end;

  JMenuItem_OnActionExpandListenerClass = interface(IJavaClass)
    ['{5F3450A9-E2F3-4DD3-8734-A2698A227231}']
  end;

  [JavaSignature('android/view/MenuItem$OnActionExpandListener')]
  JMenuItem_OnActionExpandListener = interface(IJavaInstance)
    ['{D0287E3E-BC17-476D-8936-96A6BF0E34AB}']
    function onMenuItemActionCollapse(item: JMenuItem): Boolean; cdecl;
    function onMenuItemActionExpand(item: JMenuItem): Boolean; cdecl;
  end;
  TJMenuItem_OnActionExpandListener = class(TJavaGenericImport<JMenuItem_OnActionExpandListenerClass, JMenuItem_OnActionExpandListener>) end;

  JMenuItem_OnMenuItemClickListenerClass = interface(IJavaClass)
    ['{5D80AB8B-B86B-4B92-91CE-B0928D17937F}']
  end;

  [JavaSignature('android/view/MenuItem$OnMenuItemClickListener')]
  JMenuItem_OnMenuItemClickListener = interface(IJavaInstance)
    ['{D9AEABD0-0126-4F9E-B7F0-EB4C0F6477BC}']
    function onMenuItemClick(item: JMenuItem): Boolean; cdecl;
  end;
  TJMenuItem_OnMenuItemClickListener = class(TJavaGenericImport<JMenuItem_OnMenuItemClickListenerClass, JMenuItem_OnMenuItemClickListener>) end;

  JMotionEventClass = interface(JInputEventClass)
    ['{1923D7DE-9206-4376-829C-20D14334553B}']
    {class} function _GetACTION_BUTTON_PRESS: Integer; cdecl;
    {class} function _GetACTION_BUTTON_RELEASE: Integer; cdecl;
    {class} function _GetACTION_CANCEL: Integer; cdecl;
    {class} function _GetACTION_DOWN: Integer; cdecl;
    {class} function _GetACTION_HOVER_ENTER: Integer; cdecl;
    {class} function _GetACTION_HOVER_EXIT: Integer; cdecl;
    {class} function _GetACTION_HOVER_MOVE: Integer; cdecl;
    {class} function _GetACTION_MASK: Integer; cdecl;
    {class} function _GetACTION_MOVE: Integer; cdecl;
    {class} function _GetACTION_OUTSIDE: Integer; cdecl;
    {class} function _GetACTION_POINTER_1_DOWN: Integer; cdecl;
    {class} function _GetACTION_POINTER_1_UP: Integer; cdecl;
    {class} function _GetACTION_POINTER_2_DOWN: Integer; cdecl;
    {class} function _GetACTION_POINTER_2_UP: Integer; cdecl;
    {class} function _GetACTION_POINTER_3_DOWN: Integer; cdecl;
    {class} function _GetACTION_POINTER_3_UP: Integer; cdecl;
    {class} function _GetACTION_POINTER_DOWN: Integer; cdecl;
    {class} function _GetACTION_POINTER_ID_MASK: Integer; cdecl;
    {class} function _GetACTION_POINTER_ID_SHIFT: Integer; cdecl;
    {class} function _GetACTION_POINTER_INDEX_MASK: Integer; cdecl;
    {class} function _GetACTION_POINTER_INDEX_SHIFT: Integer; cdecl;
    {class} function _GetACTION_POINTER_UP: Integer; cdecl;
    {class} function _GetACTION_SCROLL: Integer; cdecl;
    {class} function _GetACTION_UP: Integer; cdecl;
    {class} function _GetAXIS_BRAKE: Integer; cdecl;
    {class} function _GetAXIS_DISTANCE: Integer; cdecl;
    {class} function _GetAXIS_GAS: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_1: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_10: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_11: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_12: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_13: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_14: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_15: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_16: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_2: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_3: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_4: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_5: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_6: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_7: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_8: Integer; cdecl;
    {class} function _GetAXIS_GENERIC_9: Integer; cdecl;
    {class} function _GetAXIS_HAT_X: Integer; cdecl;
    {class} function _GetAXIS_HAT_Y: Integer; cdecl;
    {class} function _GetAXIS_HSCROLL: Integer; cdecl;
    {class} function _GetAXIS_LTRIGGER: Integer; cdecl;
    {class} function _GetAXIS_ORIENTATION: Integer; cdecl;
    {class} function _GetAXIS_PRESSURE: Integer; cdecl;
    {class} function _GetAXIS_RTRIGGER: Integer; cdecl;
    {class} function _GetAXIS_RUDDER: Integer; cdecl;
    {class} function _GetAXIS_RX: Integer; cdecl;
    {class} function _GetAXIS_RY: Integer; cdecl;
    {class} function _GetAXIS_RZ: Integer; cdecl;
    {class} function _GetAXIS_SIZE: Integer; cdecl;
    {class} function _GetAXIS_THROTTLE: Integer; cdecl;
    {class} function _GetAXIS_TILT: Integer; cdecl;
    {class} function _GetAXIS_TOOL_MAJOR: Integer; cdecl;
    {class} function _GetAXIS_TOOL_MINOR: Integer; cdecl;
    {class} function _GetAXIS_TOUCH_MAJOR: Integer; cdecl;
    {class} function _GetAXIS_TOUCH_MINOR: Integer; cdecl;
    {class} function _GetAXIS_VSCROLL: Integer; cdecl;
    {class} function _GetAXIS_WHEEL: Integer; cdecl;
    {class} function _GetAXIS_X: Integer; cdecl;
    {class} function _GetAXIS_Y: Integer; cdecl;
    {class} function _GetAXIS_Z: Integer; cdecl;
    {class} function _GetBUTTON_BACK: Integer; cdecl;
    {class} function _GetBUTTON_FORWARD: Integer; cdecl;
    {class} function _GetBUTTON_PRIMARY: Integer; cdecl;
    {class} function _GetBUTTON_SECONDARY: Integer; cdecl;
    {class} function _GetBUTTON_STYLUS_PRIMARY: Integer; cdecl;
    {class} function _GetBUTTON_STYLUS_SECONDARY: Integer; cdecl;
    {class} function _GetBUTTON_TERTIARY: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetEDGE_BOTTOM: Integer; cdecl;
    {class} function _GetEDGE_LEFT: Integer; cdecl;
    {class} function _GetEDGE_RIGHT: Integer; cdecl;
    {class} function _GetEDGE_TOP: Integer; cdecl;
    {class} function _GetFLAG_WINDOW_IS_OBSCURED: Integer; cdecl;
    {class} function _GetINVALID_POINTER_ID: Integer; cdecl;
    {class} function _GetTOOL_TYPE_ERASER: Integer; cdecl;
    {class} function _GetTOOL_TYPE_FINGER: Integer; cdecl;
    {class} function _GetTOOL_TYPE_MOUSE: Integer; cdecl;
    {class} function _GetTOOL_TYPE_STYLUS: Integer; cdecl;
    {class} function _GetTOOL_TYPE_UNKNOWN: Integer; cdecl;
    {class} function actionToString(action: Integer): JString; cdecl;
    {class} function axisFromString(symbolicName: JString): Integer; cdecl;
    {class} function axisToString(axis: Integer): JString; cdecl;
    {class} function obtain(downTime: Int64; eventTime: Int64; action: Integer; pointerCount: Integer; pointerProperties: TJavaObjectArray<JMotionEvent_PointerProperties>; pointerCoords: TJavaObjectArray<JMotionEvent_PointerCoords>; metaState: Integer; buttonState: Integer; xPrecision: Single; yPrecision: Single; deviceId: Integer; edgeFlags: Integer; source: Integer; flags: Integer): JMotionEvent; cdecl; overload;
    {class} function obtain(downTime: Int64; eventTime: Int64; action: Integer; pointerCount: Integer; pointerIds: TJavaArray<Integer>; pointerCoords: TJavaObjectArray<JMotionEvent_PointerCoords>; metaState: Integer; xPrecision: Single; yPrecision: Single; deviceId: Integer; edgeFlags: Integer; source: Integer; flags: Integer): JMotionEvent; cdecl; overload;//Deprecated
    {class} function obtain(downTime: Int64; eventTime: Int64; action: Integer; x: Single; y: Single; pressure: Single; size: Single; metaState: Integer; xPrecision: Single; yPrecision: Single; deviceId: Integer; edgeFlags: Integer): JMotionEvent; cdecl; overload;
    {class} function obtain(downTime: Int64; eventTime: Int64; action: Integer; pointerCount: Integer; x: Single; y: Single; pressure: Single; size: Single; metaState: Integer; xPrecision: Single; yPrecision: Single; deviceId: Integer; edgeFlags: Integer): JMotionEvent; cdecl; overload;//Deprecated
    {class} function obtain(downTime: Int64; eventTime: Int64; action: Integer; x: Single; y: Single; metaState: Integer): JMotionEvent; cdecl; overload;
    {class} function obtain(other: JMotionEvent): JMotionEvent; cdecl; overload;
    {class} function obtainNoHistory(other: JMotionEvent): JMotionEvent; cdecl;
    {class} property ACTION_BUTTON_PRESS: Integer read _GetACTION_BUTTON_PRESS;
    {class} property ACTION_BUTTON_RELEASE: Integer read _GetACTION_BUTTON_RELEASE;
    {class} property ACTION_CANCEL: Integer read _GetACTION_CANCEL;
    {class} property ACTION_DOWN: Integer read _GetACTION_DOWN;
    {class} property ACTION_HOVER_ENTER: Integer read _GetACTION_HOVER_ENTER;
    {class} property ACTION_HOVER_EXIT: Integer read _GetACTION_HOVER_EXIT;
    {class} property ACTION_HOVER_MOVE: Integer read _GetACTION_HOVER_MOVE;
    {class} property ACTION_MASK: Integer read _GetACTION_MASK;
    {class} property ACTION_MOVE: Integer read _GetACTION_MOVE;
    {class} property ACTION_OUTSIDE: Integer read _GetACTION_OUTSIDE;
    {class} property ACTION_POINTER_1_DOWN: Integer read _GetACTION_POINTER_1_DOWN;
    {class} property ACTION_POINTER_1_UP: Integer read _GetACTION_POINTER_1_UP;
    {class} property ACTION_POINTER_2_DOWN: Integer read _GetACTION_POINTER_2_DOWN;
    {class} property ACTION_POINTER_2_UP: Integer read _GetACTION_POINTER_2_UP;
    {class} property ACTION_POINTER_3_DOWN: Integer read _GetACTION_POINTER_3_DOWN;
    {class} property ACTION_POINTER_3_UP: Integer read _GetACTION_POINTER_3_UP;
    {class} property ACTION_POINTER_DOWN: Integer read _GetACTION_POINTER_DOWN;
    {class} property ACTION_POINTER_ID_MASK: Integer read _GetACTION_POINTER_ID_MASK;
    {class} property ACTION_POINTER_ID_SHIFT: Integer read _GetACTION_POINTER_ID_SHIFT;
    {class} property ACTION_POINTER_INDEX_MASK: Integer read _GetACTION_POINTER_INDEX_MASK;
    {class} property ACTION_POINTER_INDEX_SHIFT: Integer read _GetACTION_POINTER_INDEX_SHIFT;
    {class} property ACTION_POINTER_UP: Integer read _GetACTION_POINTER_UP;
    {class} property ACTION_SCROLL: Integer read _GetACTION_SCROLL;
    {class} property ACTION_UP: Integer read _GetACTION_UP;
    {class} property AXIS_BRAKE: Integer read _GetAXIS_BRAKE;
    {class} property AXIS_DISTANCE: Integer read _GetAXIS_DISTANCE;
    {class} property AXIS_GAS: Integer read _GetAXIS_GAS;
    {class} property AXIS_GENERIC_1: Integer read _GetAXIS_GENERIC_1;
    {class} property AXIS_GENERIC_10: Integer read _GetAXIS_GENERIC_10;
    {class} property AXIS_GENERIC_11: Integer read _GetAXIS_GENERIC_11;
    {class} property AXIS_GENERIC_12: Integer read _GetAXIS_GENERIC_12;
    {class} property AXIS_GENERIC_13: Integer read _GetAXIS_GENERIC_13;
    {class} property AXIS_GENERIC_14: Integer read _GetAXIS_GENERIC_14;
    {class} property AXIS_GENERIC_15: Integer read _GetAXIS_GENERIC_15;
    {class} property AXIS_GENERIC_16: Integer read _GetAXIS_GENERIC_16;
    {class} property AXIS_GENERIC_2: Integer read _GetAXIS_GENERIC_2;
    {class} property AXIS_GENERIC_3: Integer read _GetAXIS_GENERIC_3;
    {class} property AXIS_GENERIC_4: Integer read _GetAXIS_GENERIC_4;
    {class} property AXIS_GENERIC_5: Integer read _GetAXIS_GENERIC_5;
    {class} property AXIS_GENERIC_6: Integer read _GetAXIS_GENERIC_6;
    {class} property AXIS_GENERIC_7: Integer read _GetAXIS_GENERIC_7;
    {class} property AXIS_GENERIC_8: Integer read _GetAXIS_GENERIC_8;
    {class} property AXIS_GENERIC_9: Integer read _GetAXIS_GENERIC_9;
    {class} property AXIS_HAT_X: Integer read _GetAXIS_HAT_X;
    {class} property AXIS_HAT_Y: Integer read _GetAXIS_HAT_Y;
    {class} property AXIS_HSCROLL: Integer read _GetAXIS_HSCROLL;
    {class} property AXIS_LTRIGGER: Integer read _GetAXIS_LTRIGGER;
    {class} property AXIS_ORIENTATION: Integer read _GetAXIS_ORIENTATION;
    {class} property AXIS_PRESSURE: Integer read _GetAXIS_PRESSURE;
    {class} property AXIS_RTRIGGER: Integer read _GetAXIS_RTRIGGER;
    {class} property AXIS_RUDDER: Integer read _GetAXIS_RUDDER;
    {class} property AXIS_RX: Integer read _GetAXIS_RX;
    {class} property AXIS_RY: Integer read _GetAXIS_RY;
    {class} property AXIS_RZ: Integer read _GetAXIS_RZ;
    {class} property AXIS_SIZE: Integer read _GetAXIS_SIZE;
    {class} property AXIS_THROTTLE: Integer read _GetAXIS_THROTTLE;
    {class} property AXIS_TILT: Integer read _GetAXIS_TILT;
    {class} property AXIS_TOOL_MAJOR: Integer read _GetAXIS_TOOL_MAJOR;
    {class} property AXIS_TOOL_MINOR: Integer read _GetAXIS_TOOL_MINOR;
    {class} property AXIS_TOUCH_MAJOR: Integer read _GetAXIS_TOUCH_MAJOR;
    {class} property AXIS_TOUCH_MINOR: Integer read _GetAXIS_TOUCH_MINOR;
    {class} property AXIS_VSCROLL: Integer read _GetAXIS_VSCROLL;
    {class} property AXIS_WHEEL: Integer read _GetAXIS_WHEEL;
    {class} property AXIS_X: Integer read _GetAXIS_X;
    {class} property AXIS_Y: Integer read _GetAXIS_Y;
    {class} property AXIS_Z: Integer read _GetAXIS_Z;
    {class} property BUTTON_BACK: Integer read _GetBUTTON_BACK;
    {class} property BUTTON_FORWARD: Integer read _GetBUTTON_FORWARD;
    {class} property BUTTON_PRIMARY: Integer read _GetBUTTON_PRIMARY;
    {class} property BUTTON_SECONDARY: Integer read _GetBUTTON_SECONDARY;
    {class} property BUTTON_STYLUS_PRIMARY: Integer read _GetBUTTON_STYLUS_PRIMARY;
    {class} property BUTTON_STYLUS_SECONDARY: Integer read _GetBUTTON_STYLUS_SECONDARY;
    {class} property BUTTON_TERTIARY: Integer read _GetBUTTON_TERTIARY;
    {class} //CREATOR is defined in parent interface
    {class} property EDGE_BOTTOM: Integer read _GetEDGE_BOTTOM;
    {class} property EDGE_LEFT: Integer read _GetEDGE_LEFT;
    {class} property EDGE_RIGHT: Integer read _GetEDGE_RIGHT;
    {class} property EDGE_TOP: Integer read _GetEDGE_TOP;
    {class} property FLAG_WINDOW_IS_OBSCURED: Integer read _GetFLAG_WINDOW_IS_OBSCURED;
    {class} property INVALID_POINTER_ID: Integer read _GetINVALID_POINTER_ID;
    {class} property TOOL_TYPE_ERASER: Integer read _GetTOOL_TYPE_ERASER;
    {class} property TOOL_TYPE_FINGER: Integer read _GetTOOL_TYPE_FINGER;
    {class} property TOOL_TYPE_MOUSE: Integer read _GetTOOL_TYPE_MOUSE;
    {class} property TOOL_TYPE_STYLUS: Integer read _GetTOOL_TYPE_STYLUS;
    {class} property TOOL_TYPE_UNKNOWN: Integer read _GetTOOL_TYPE_UNKNOWN;
  end;

  [JavaSignature('android/view/MotionEvent')]
  JMotionEvent = interface(JInputEvent)
    ['{0EC8B7D2-BB97-467E-B225-EF2DBA06BB34}']
    procedure addBatch(eventTime: Int64; x: Single; y: Single; pressure: Single; size: Single; metaState: Integer); cdecl; overload;
    procedure addBatch(eventTime: Int64; pointerCoords: TJavaObjectArray<JMotionEvent_PointerCoords>; metaState: Integer); cdecl; overload;
    function findPointerIndex(pointerId: Integer): Integer; cdecl;
    function getAction: Integer; cdecl;
    function getActionButton: Integer; cdecl;
    function getActionIndex: Integer; cdecl;
    function getActionMasked: Integer; cdecl;
    function getAxisValue(axis: Integer): Single; cdecl; overload;
    function getAxisValue(axis: Integer; pointerIndex: Integer): Single; cdecl; overload;
    function getButtonState: Integer; cdecl;
    function getDeviceId: Integer; cdecl;
    function getDownTime: Int64; cdecl;
    function getEdgeFlags: Integer; cdecl;
    function getEventTime: Int64; cdecl;
    function getFlags: Integer; cdecl;
    function getHistoricalAxisValue(axis: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalAxisValue(axis: Integer; pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalEventTime(pos: Integer): Int64; cdecl;
    function getHistoricalOrientation(pos: Integer): Single; cdecl; overload;
    function getHistoricalOrientation(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    procedure getHistoricalPointerCoords(pointerIndex: Integer; pos: Integer; outPointerCoords: JMotionEvent_PointerCoords); cdecl;
    function getHistoricalPressure(pos: Integer): Single; cdecl; overload;
    function getHistoricalPressure(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalSize(pos: Integer): Single; cdecl; overload;
    function getHistoricalSize(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalToolMajor(pos: Integer): Single; cdecl; overload;
    function getHistoricalToolMajor(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalToolMinor(pos: Integer): Single; cdecl; overload;
    function getHistoricalToolMinor(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalTouchMajor(pos: Integer): Single; cdecl; overload;
    function getHistoricalTouchMajor(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalTouchMinor(pos: Integer): Single; cdecl; overload;
    function getHistoricalTouchMinor(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalX(pos: Integer): Single; cdecl; overload;
    function getHistoricalX(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistoricalY(pos: Integer): Single; cdecl; overload;
    function getHistoricalY(pointerIndex: Integer; pos: Integer): Single; cdecl; overload;
    function getHistorySize: Integer; cdecl;
    function getMetaState: Integer; cdecl;
    function getOrientation: Single; cdecl; overload;
    function getOrientation(pointerIndex: Integer): Single; cdecl; overload;
    procedure getPointerCoords(pointerIndex: Integer; outPointerCoords: JMotionEvent_PointerCoords); cdecl;
    function getPointerCount: Integer; cdecl;
    function getPointerId(pointerIndex: Integer): Integer; cdecl;
    procedure getPointerProperties(pointerIndex: Integer; outPointerProperties: JMotionEvent_PointerProperties); cdecl;
    function getPressure: Single; cdecl; overload;
    function getPressure(pointerIndex: Integer): Single; cdecl; overload;
    function getRawX: Single; cdecl;
    function getRawY: Single; cdecl;
    function getSize: Single; cdecl; overload;
    function getSize(pointerIndex: Integer): Single; cdecl; overload;
    function getSource: Integer; cdecl;
    function getToolMajor: Single; cdecl; overload;
    function getToolMajor(pointerIndex: Integer): Single; cdecl; overload;
    function getToolMinor: Single; cdecl; overload;
    function getToolMinor(pointerIndex: Integer): Single; cdecl; overload;
    function getToolType(pointerIndex: Integer): Integer; cdecl;
    function getTouchMajor: Single; cdecl; overload;
    function getTouchMajor(pointerIndex: Integer): Single; cdecl; overload;
    function getTouchMinor: Single; cdecl; overload;
    function getTouchMinor(pointerIndex: Integer): Single; cdecl; overload;
    function getX: Single; cdecl; overload;
    function getX(pointerIndex: Integer): Single; cdecl; overload;
    function getXPrecision: Single; cdecl;
    function getY: Single; cdecl; overload;
    function getY(pointerIndex: Integer): Single; cdecl; overload;
    function getYPrecision: Single; cdecl;
    function isButtonPressed(button: Integer): Boolean; cdecl;
    procedure offsetLocation(deltaX: Single; deltaY: Single); cdecl;
    procedure recycle; cdecl;
    procedure setAction(action: Integer); cdecl;
    procedure setEdgeFlags(flags: Integer); cdecl;
    procedure setLocation(x: Single; y: Single); cdecl;
    procedure setSource(source: Integer); cdecl;
    function toString: JString; cdecl;
    procedure transform(matrix: JMatrix); cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJMotionEvent = class(TJavaGenericImport<JMotionEventClass, JMotionEvent>) end;

  JMotionEvent_PointerCoordsClass = interface(JObjectClass)
    ['{96AEAF72-A3A1-4A43-8580-AA88344C5B90}']
    {class} function init: JMotionEvent_PointerCoords; cdecl; overload;
    {class} function init(other: JMotionEvent_PointerCoords): JMotionEvent_PointerCoords; cdecl; overload;
  end;

  [JavaSignature('android/view/MotionEvent$PointerCoords')]
  JMotionEvent_PointerCoords = interface(JObject)
    ['{D776B0D6-547F-4086-B381-B1059548BCAC}']
    function _Getorientation: Single; cdecl;
    procedure _Setorientation(Value: Single); cdecl;
    function _Getpressure: Single; cdecl;
    procedure _Setpressure(Value: Single); cdecl;
    function _Getsize: Single; cdecl;
    procedure _Setsize(Value: Single); cdecl;
    function _GettoolMajor: Single; cdecl;
    procedure _SettoolMajor(Value: Single); cdecl;
    function _GettoolMinor: Single; cdecl;
    procedure _SettoolMinor(Value: Single); cdecl;
    function _GettouchMajor: Single; cdecl;
    procedure _SettouchMajor(Value: Single); cdecl;
    function _GettouchMinor: Single; cdecl;
    procedure _SettouchMinor(Value: Single); cdecl;
    function _Getx: Single; cdecl;
    procedure _Setx(Value: Single); cdecl;
    function _Gety: Single; cdecl;
    procedure _Sety(Value: Single); cdecl;
    procedure clear; cdecl;
    procedure copyFrom(other: JMotionEvent_PointerCoords); cdecl;
    function getAxisValue(axis: Integer): Single; cdecl;
    procedure setAxisValue(axis: Integer; value: Single); cdecl;
    property orientation: Single read _Getorientation write _Setorientation;
    property pressure: Single read _Getpressure write _Setpressure;
    property size: Single read _Getsize write _Setsize;
    property toolMajor: Single read _GettoolMajor write _SettoolMajor;
    property toolMinor: Single read _GettoolMinor write _SettoolMinor;
    property touchMajor: Single read _GettouchMajor write _SettouchMajor;
    property touchMinor: Single read _GettouchMinor write _SettouchMinor;
    property x: Single read _Getx write _Setx;
    property y: Single read _Gety write _Sety;
  end;
  TJMotionEvent_PointerCoords = class(TJavaGenericImport<JMotionEvent_PointerCoordsClass, JMotionEvent_PointerCoords>) end;

  JMotionEvent_PointerPropertiesClass = interface(JObjectClass)
    ['{3885DB03-50CF-4125-B949-90B9AC8D261E}']
    {class} function init: JMotionEvent_PointerProperties; cdecl; overload;
    {class} function init(other: JMotionEvent_PointerProperties): JMotionEvent_PointerProperties; cdecl; overload;
  end;

  [JavaSignature('android/view/MotionEvent$PointerProperties')]
  JMotionEvent_PointerProperties = interface(JObject)
    ['{BB01C136-9C2A-4E2E-B223-979E167FAA79}']
    function _Getid: Integer; cdecl;
    procedure _Setid(Value: Integer); cdecl;
    function _GettoolType: Integer; cdecl;
    procedure _SettoolType(Value: Integer); cdecl;
    procedure clear; cdecl;
    procedure copyFrom(other: JMotionEvent_PointerProperties); cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    property id: Integer read _Getid write _Setid;
    property toolType: Integer read _GettoolType write _SettoolType;
  end;
  TJMotionEvent_PointerProperties = class(TJavaGenericImport<JMotionEvent_PointerPropertiesClass, JMotionEvent_PointerProperties>) end;

  JRenderNodeClass = interface(JObjectClass)
    ['{45C27E57-DFBA-4976-8E28-BD57FCE32E83}']
    {class} function _GetFLAG_CLIP_CHILDREN: Integer; cdecl;
    {class} function _GetSTATUS_DONE: Integer; cdecl;
    {class} function _GetSTATUS_DRAW: Integer; cdecl;
    {class} function _GetSTATUS_DREW: Integer; cdecl;
    {class} function _GetSTATUS_INVOKE: Integer; cdecl;
    {class} function adopt(nativePtr: Int64): JRenderNode; cdecl;
    {class} function create(name: JString; owningView: JView): JRenderNode; cdecl;
    {class} property FLAG_CLIP_CHILDREN: Integer read _GetFLAG_CLIP_CHILDREN;
    {class} property STATUS_DONE: Integer read _GetSTATUS_DONE;
    {class} property STATUS_DRAW: Integer read _GetSTATUS_DRAW;
    {class} property STATUS_DREW: Integer read _GetSTATUS_DREW;
    {class} property STATUS_INVOKE: Integer read _GetSTATUS_INVOKE;
  end;

  [JavaSignature('android/view/RenderNode')]
  JRenderNode = interface(JObject)
    ['{487C55AE-9922-4A7D-BA54-E2C0AE91AF3C}']
    //procedure addAnimator(animator: JRenderNodeAnimator); cdecl;
    procedure destroyDisplayListData; cdecl;
    procedure &end(canvas: JDisplayListCanvas); cdecl;
    procedure endAllAnimators; cdecl;
    function getAlpha: Single; cdecl;
    function getCameraDistance: Single; cdecl;
    function getClipToOutline: Boolean; cdecl;
    function getDebugSize: Integer; cdecl;
    function getElevation: Single; cdecl;
    procedure getInverseMatrix(outMatrix: JMatrix); cdecl;
    procedure getMatrix(outMatrix: JMatrix); cdecl;
    function getPivotX: Single; cdecl;
    function getPivotY: Single; cdecl;
    function getRotation: Single; cdecl;
    function getRotationX: Single; cdecl;
    function getRotationY: Single; cdecl;
    function getScaleX: Single; cdecl;
    function getScaleY: Single; cdecl;
    function getTranslationX: Single; cdecl;
    function getTranslationY: Single; cdecl;
    function getTranslationZ: Single; cdecl;
    function hasIdentityMatrix: Boolean; cdecl;
    function hasOverlappingRendering: Boolean; cdecl;
    function hasShadow: Boolean; cdecl;
    function isPivotExplicitlySet: Boolean; cdecl;
    function isValid: Boolean; cdecl;
    function offsetLeftAndRight(offset: Integer): Boolean; cdecl;
    function offsetTopAndBottom(offset: Integer): Boolean; cdecl;
    procedure output; cdecl;
    function setAlpha(alpha: Single): Boolean; cdecl;
    function setAnimationMatrix(matrix: JMatrix): Boolean; cdecl;
    function setBottom(bottom: Integer): Boolean; cdecl;
    function setCameraDistance(distance: Single): Boolean; cdecl;
    function setClipBounds(rect: JRect): Boolean; cdecl;
    function setClipToBounds(clipToBounds: Boolean): Boolean; cdecl;
    function setClipToOutline(clipToOutline: Boolean): Boolean; cdecl;
    function setElevation(lift: Single): Boolean; cdecl;
    function setHasOverlappingRendering(hasOverlappingRendering: Boolean): Boolean; cdecl;
    function setLayerPaint(paint: JPaint): Boolean; cdecl;
    function setLayerType(layerType: Integer): Boolean; cdecl;
    function setLeft(left: Integer): Boolean; cdecl;
    function setLeftTopRightBottom(left: Integer; top: Integer; right: Integer; bottom: Integer): Boolean; cdecl;
    function setOutline(outline: JOutline): Boolean; cdecl;
    function setPivotX(pivotX: Single): Boolean; cdecl;
    function setPivotY(pivotY: Single): Boolean; cdecl;
    function setProjectBackwards(shouldProject: Boolean): Boolean; cdecl;
    function setProjectionReceiver(shouldRecieve: Boolean): Boolean; cdecl;
    function setRevealClip(shouldClip: Boolean; x: Single; y: Single; radius: Single): Boolean; cdecl;
    function setRight(right: Integer): Boolean; cdecl;
    function setRotation(rotation: Single): Boolean; cdecl;
    function setRotationX(rotationX: Single): Boolean; cdecl;
    function setRotationY(rotationY: Single): Boolean; cdecl;
    function setScaleX(scaleX: Single): Boolean; cdecl;
    function setScaleY(scaleY: Single): Boolean; cdecl;
    function setStaticMatrix(matrix: JMatrix): Boolean; cdecl;
    function setTop(top: Integer): Boolean; cdecl;
    function setTranslationX(translationX: Single): Boolean; cdecl;
    function setTranslationY(translationY: Single): Boolean; cdecl;
    function setTranslationZ(translationZ: Single): Boolean; cdecl;
    function start(width: Integer; height: Integer): JDisplayListCanvas; cdecl;
  end;
  TJRenderNode = class(TJavaGenericImport<JRenderNodeClass, JRenderNode>) end;

  // android.view.RenderNodeAnimator
  JScaleGestureDetectorClass = interface(JObjectClass)
    ['{E1C3BFB3-676A-4844-A4C5-35BB02B14F37}']
    {class} function init(context: JContext; listener: JScaleGestureDetector_OnScaleGestureListener): JScaleGestureDetector; cdecl; overload;
    {class} function init(context: JContext; listener: JScaleGestureDetector_OnScaleGestureListener; handler: JHandler): JScaleGestureDetector; cdecl; overload;
  end;

  [JavaSignature('android/view/ScaleGestureDetector')]
  JScaleGestureDetector = interface(JObject)
    ['{A074A59C-6357-46C5-93AB-EB9978E6F817}']
    function getCurrentSpan: Single; cdecl;
    function getCurrentSpanX: Single; cdecl;
    function getCurrentSpanY: Single; cdecl;
    function getEventTime: Int64; cdecl;
    function getFocusX: Single; cdecl;
    function getFocusY: Single; cdecl;
    function getPreviousSpan: Single; cdecl;
    function getPreviousSpanX: Single; cdecl;
    function getPreviousSpanY: Single; cdecl;
    function getScaleFactor: Single; cdecl;
    function getTimeDelta: Int64; cdecl;
    function isInProgress: Boolean; cdecl;
    function isQuickScaleEnabled: Boolean; cdecl;
    function isStylusScaleEnabled: Boolean; cdecl;
    function onTouchEvent(event: JMotionEvent): Boolean; cdecl;
    procedure setQuickScaleEnabled(scales: Boolean); cdecl;
    procedure setStylusScaleEnabled(scales: Boolean); cdecl;
  end;
  TJScaleGestureDetector = class(TJavaGenericImport<JScaleGestureDetectorClass, JScaleGestureDetector>) end;

  JScaleGestureDetector_OnScaleGestureListenerClass = interface(IJavaClass)
    ['{6FE82996-5BDB-4CF3-AB1E-E42DA3FDFD2F}']
  end;

  [JavaSignature('android/view/ScaleGestureDetector$OnScaleGestureListener')]
  JScaleGestureDetector_OnScaleGestureListener = interface(IJavaInstance)
    ['{17BA86A8-F7BA-45D9-BEFE-67F92E6F034A}']
    function onScale(detector: JScaleGestureDetector): Boolean; cdecl;
    function onScaleBegin(detector: JScaleGestureDetector): Boolean; cdecl;
    procedure onScaleEnd(detector: JScaleGestureDetector); cdecl;
  end;
  TJScaleGestureDetector_OnScaleGestureListener = class(TJavaGenericImport<JScaleGestureDetector_OnScaleGestureListenerClass, JScaleGestureDetector_OnScaleGestureListener>) end;

  JScaleGestureDetector_SimpleOnScaleGestureListenerClass = interface(JObjectClass)
    ['{A4E5B6F6-A03A-4582-9F07-4613FA7F0EC4}']
    {class} function init: JScaleGestureDetector_SimpleOnScaleGestureListener; cdecl;
  end;

  [JavaSignature('android/view/ScaleGestureDetector$SimpleOnScaleGestureListener')]
  JScaleGestureDetector_SimpleOnScaleGestureListener = interface(JObject)
    ['{11B14F37-7112-4CC6-AE48-D54F81CC19E0}']
    function onScale(detector: JScaleGestureDetector): Boolean; cdecl;
    function onScaleBegin(detector: JScaleGestureDetector): Boolean; cdecl;
    procedure onScaleEnd(detector: JScaleGestureDetector); cdecl;
  end;
  TJScaleGestureDetector_SimpleOnScaleGestureListener = class(TJavaGenericImport<JScaleGestureDetector_SimpleOnScaleGestureListenerClass, JScaleGestureDetector_SimpleOnScaleGestureListener>) end;

  JSearchEventClass = interface(JObjectClass)
    ['{E87FAE8B-D3C7-4784-8611-6CFAD5001BA7}']
    {class} function init(inputDevice: JInputDevice): JSearchEvent; cdecl;
  end;

  [JavaSignature('android/view/SearchEvent')]
  JSearchEvent = interface(JObject)
    ['{B782C967-9F20-4E5B-81BC-A199D082F121}']
    function getInputDevice: JInputDevice; cdecl;
  end;
  TJSearchEvent = class(TJavaGenericImport<JSearchEventClass, JSearchEvent>) end;

  JSubMenuClass = interface(JMenuClass)
    ['{F9A030D2-EE0B-4CA1-BE38-82DD815A6573}']
  end;

  [JavaSignature('android/view/SubMenu')]
  JSubMenu = interface(JMenu)
    ['{F9C533A8-5B94-4DD4-BFFE-9313E4A362B4}']
    procedure clearHeader; cdecl;
    function getItem: JMenuItem; cdecl;
    function setHeaderIcon(iconRes: Integer): JSubMenu; cdecl; overload;
    function setHeaderIcon(icon: JDrawable): JSubMenu; cdecl; overload;
    function setHeaderTitle(titleRes: Integer): JSubMenu; cdecl; overload;
    function setHeaderTitle(title: JCharSequence): JSubMenu; cdecl; overload;
    function setHeaderView(view: JView): JSubMenu; cdecl;
    function setIcon(iconRes: Integer): JSubMenu; cdecl; overload;
    function setIcon(icon: JDrawable): JSubMenu; cdecl; overload;
  end;
  TJSubMenu = class(TJavaGenericImport<JSubMenuClass, JSubMenu>) end;

  JSurfaceClass = interface(JObjectClass)
    ['{2C926B05-29F6-4EDC-92D6-222B6D030BB4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetROTATION_0: Integer; cdecl;
    {class} function _GetROTATION_180: Integer; cdecl;
    {class} function _GetROTATION_270: Integer; cdecl;
    {class} function _GetROTATION_90: Integer; cdecl;
    {class} function init(surfaceTexture: JSurfaceTexture): JSurface; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property ROTATION_0: Integer read _GetROTATION_0;
    {class} property ROTATION_180: Integer read _GetROTATION_180;
    {class} property ROTATION_270: Integer read _GetROTATION_270;
    {class} property ROTATION_90: Integer read _GetROTATION_90;
  end;

  [JavaSignature('android/view/Surface')]
  JSurface = interface(JObject)
    ['{87E788EF-EE5D-4CC8-BA6A-528B8B0A7EA5}']
    function describeContents: Integer; cdecl;
    function isValid: Boolean; cdecl;
    function lockCanvas(inOutDirty: JRect): JCanvas; cdecl;
    function lockHardwareCanvas: JCanvas; cdecl;
    procedure readFromParcel(source: JParcel); cdecl;
    procedure release; cdecl;
    function toString: JString; cdecl;
    procedure unlockCanvas(canvas: JCanvas); cdecl;//Deprecated
    procedure unlockCanvasAndPost(canvas: JCanvas); cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJSurface = class(TJavaGenericImport<JSurfaceClass, JSurface>) end;

  JSurfaceHolderClass = interface(IJavaClass)
    ['{0FBCFD81-0142-402E-A67D-66F8BF2B1DF5}']
    {class} function _GetSURFACE_TYPE_GPU: Integer; cdecl;
    {class} function _GetSURFACE_TYPE_HARDWARE: Integer; cdecl;
    {class} function _GetSURFACE_TYPE_NORMAL: Integer; cdecl;
    {class} function _GetSURFACE_TYPE_PUSH_BUFFERS: Integer; cdecl;
    {class} property SURFACE_TYPE_GPU: Integer read _GetSURFACE_TYPE_GPU;
    {class} property SURFACE_TYPE_HARDWARE: Integer read _GetSURFACE_TYPE_HARDWARE;
    {class} property SURFACE_TYPE_NORMAL: Integer read _GetSURFACE_TYPE_NORMAL;
    {class} property SURFACE_TYPE_PUSH_BUFFERS: Integer read _GetSURFACE_TYPE_PUSH_BUFFERS;
  end;

  [JavaSignature('android/view/SurfaceHolder')]
  JSurfaceHolder = interface(IJavaInstance)
    ['{EAA969D0-D517-49C8-8A09-17DB28B2EA91}']
    procedure addCallback(callback: JSurfaceHolder_Callback); cdecl;
    function getSurface: JSurface; cdecl;
    function getSurfaceFrame: JRect; cdecl;
    function isCreating: Boolean; cdecl;
    function lockCanvas: JCanvas; cdecl; overload;
    function lockCanvas(dirty: JRect): JCanvas; cdecl; overload;
    procedure removeCallback(callback: JSurfaceHolder_Callback); cdecl;
    procedure setFixedSize(width: Integer; height: Integer); cdecl;
    procedure setFormat(format: Integer); cdecl;
    procedure setKeepScreenOn(screenOn: Boolean); cdecl;
    procedure setSizeFromLayout; cdecl;
    procedure setType(type_: Integer); cdecl;//Deprecated
    procedure unlockCanvasAndPost(canvas: JCanvas); cdecl;
  end;
  TJSurfaceHolder = class(TJavaGenericImport<JSurfaceHolderClass, JSurfaceHolder>) end;

  JSurfaceHolder_CallbackClass = interface(IJavaClass)
    ['{97AD9204-F7F7-4094-9AF1-0C9426C9FFC4}']
  end;

  [JavaSignature('android/view/SurfaceHolder$Callback')]
  JSurfaceHolder_Callback = interface(IJavaInstance)
    ['{A126B8BF-D9CA-4D5B-95A5-5ADC0EAAC38B}']
    procedure surfaceChanged(holder: JSurfaceHolder; format: Integer; width: Integer; height: Integer); cdecl;
    procedure surfaceCreated(holder: JSurfaceHolder); cdecl;
    procedure surfaceDestroyed(holder: JSurfaceHolder); cdecl;
  end;
  TJSurfaceHolder_Callback = class(TJavaGenericImport<JSurfaceHolder_CallbackClass, JSurfaceHolder_Callback>) end;

  JSurfaceHolder_Callback2Class = interface(JSurfaceHolder_CallbackClass)
    ['{5396FDAA-D490-4AE6-B8CA-1D9B332A93D9}']
  end;

  [JavaSignature('android/view/SurfaceHolder$Callback2')]
  JSurfaceHolder_Callback2 = interface(JSurfaceHolder_Callback)
    ['{6D51F2B2-F52C-47D0-ABDC-1469F1C3EB42}']
    procedure surfaceRedrawNeeded(holder: JSurfaceHolder); cdecl;
  end;
  TJSurfaceHolder_Callback2 = class(TJavaGenericImport<JSurfaceHolder_Callback2Class, JSurfaceHolder_Callback2>) end;

  JViewClass = interface(JObjectClass)
    ['{FB6C1483-BDE7-423F-97F9-76A8D785EF36}']
    {class} function _GetACCESSIBILITY_LIVE_REGION_ASSERTIVE: Integer; cdecl;
    {class} function _GetACCESSIBILITY_LIVE_REGION_NONE: Integer; cdecl;
    {class} function _GetACCESSIBILITY_LIVE_REGION_POLITE: Integer; cdecl;
    {class} function _GetALPHA: JProperty; cdecl;
    {class} function _GetDRAWING_CACHE_QUALITY_AUTO: Integer; cdecl;
    {class} function _GetDRAWING_CACHE_QUALITY_HIGH: Integer; cdecl;
    {class} function _GetDRAWING_CACHE_QUALITY_LOW: Integer; cdecl;
    {class} function _GetFIND_VIEWS_WITH_CONTENT_DESCRIPTION: Integer; cdecl;
    {class} function _GetFIND_VIEWS_WITH_TEXT: Integer; cdecl;
    {class} function _GetFOCUSABLES_ALL: Integer; cdecl;
    {class} function _GetFOCUSABLES_TOUCH_MODE: Integer; cdecl;
    {class} function _GetFOCUS_BACKWARD: Integer; cdecl;
    {class} function _GetFOCUS_DOWN: Integer; cdecl;
    {class} function _GetFOCUS_FORWARD: Integer; cdecl;
    {class} function _GetFOCUS_LEFT: Integer; cdecl;
    {class} function _GetFOCUS_RIGHT: Integer; cdecl;
    {class} function _GetFOCUS_UP: Integer; cdecl;
    {class} function _GetGONE: Integer; cdecl;
    {class} function _GetHAPTIC_FEEDBACK_ENABLED: Integer; cdecl;
    {class} function _GetIMPORTANT_FOR_ACCESSIBILITY_AUTO: Integer; cdecl;
    {class} function _GetIMPORTANT_FOR_ACCESSIBILITY_NO: Integer; cdecl;
    {class} function _GetIMPORTANT_FOR_ACCESSIBILITY_NO_HIDE_DESCENDANTS: Integer; cdecl;
    {class} function _GetIMPORTANT_FOR_ACCESSIBILITY_YES: Integer; cdecl;
    {class} function _GetINVISIBLE: Integer; cdecl;
    {class} function _GetKEEP_SCREEN_ON: Integer; cdecl;
    {class} function _GetLAYER_TYPE_HARDWARE: Integer; cdecl;
    {class} function _GetLAYER_TYPE_NONE: Integer; cdecl;
    {class} function _GetLAYER_TYPE_SOFTWARE: Integer; cdecl;
    {class} function _GetLAYOUT_DIRECTION_INHERIT: Integer; cdecl;
    {class} function _GetLAYOUT_DIRECTION_LOCALE: Integer; cdecl;
    {class} function _GetLAYOUT_DIRECTION_LTR: Integer; cdecl;
    {class} function _GetLAYOUT_DIRECTION_RTL: Integer; cdecl;
    {class} function _GetMEASURED_HEIGHT_STATE_SHIFT: Integer; cdecl;
    {class} function _GetMEASURED_SIZE_MASK: Integer; cdecl;
    {class} function _GetMEASURED_STATE_MASK: Integer; cdecl;
    {class} function _GetMEASURED_STATE_TOO_SMALL: Integer; cdecl;
    {class} function _GetNO_ID: Integer; cdecl;
    {class} function _GetOVER_SCROLL_ALWAYS: Integer; cdecl;
    {class} function _GetOVER_SCROLL_IF_CONTENT_SCROLLS: Integer; cdecl;
    {class} function _GetOVER_SCROLL_NEVER: Integer; cdecl;
    {class} function _GetROTATION: JProperty; cdecl;
    {class} function _GetROTATION_X: JProperty; cdecl;
    {class} function _GetROTATION_Y: JProperty; cdecl;
    {class} function _GetSCALE_X: JProperty; cdecl;
    {class} function _GetSCALE_Y: JProperty; cdecl;
    {class} function _GetSCREEN_STATE_OFF: Integer; cdecl;
    {class} function _GetSCREEN_STATE_ON: Integer; cdecl;
    {class} function _GetSCROLLBARS_INSIDE_INSET: Integer; cdecl;
    {class} function _GetSCROLLBARS_INSIDE_OVERLAY: Integer; cdecl;
    {class} function _GetSCROLLBARS_OUTSIDE_INSET: Integer; cdecl;
    {class} function _GetSCROLLBARS_OUTSIDE_OVERLAY: Integer; cdecl;
    {class} function _GetSCROLLBAR_POSITION_DEFAULT: Integer; cdecl;
    {class} function _GetSCROLLBAR_POSITION_LEFT: Integer; cdecl;
    {class} function _GetSCROLLBAR_POSITION_RIGHT: Integer; cdecl;
    {class} function _GetSCROLL_AXIS_HORIZONTAL: Integer; cdecl;
    {class} function _GetSCROLL_AXIS_NONE: Integer; cdecl;
    {class} function _GetSCROLL_AXIS_VERTICAL: Integer; cdecl;
    {class} function _GetSCROLL_INDICATOR_BOTTOM: Integer; cdecl;
    {class} function _GetSCROLL_INDICATOR_END: Integer; cdecl;
    {class} function _GetSCROLL_INDICATOR_LEFT: Integer; cdecl;
    {class} function _GetSCROLL_INDICATOR_RIGHT: Integer; cdecl;
    {class} function _GetSCROLL_INDICATOR_START: Integer; cdecl;
    {class} function _GetSCROLL_INDICATOR_TOP: Integer; cdecl;
    {class} function _GetSOUND_EFFECTS_ENABLED: Integer; cdecl;
    {class} function _GetSTATUS_BAR_HIDDEN: Integer; cdecl;
    {class} function _GetSTATUS_BAR_VISIBLE: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_FULLSCREEN: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_HIDE_NAVIGATION: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_IMMERSIVE: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_IMMERSIVE_STICKY: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_LAYOUT_FULLSCREEN: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_LAYOUT_STABLE: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_LIGHT_STATUS_BAR: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_LOW_PROFILE: Integer; cdecl;
    {class} function _GetSYSTEM_UI_FLAG_VISIBLE: Integer; cdecl;
    {class} function _GetSYSTEM_UI_LAYOUT_FLAGS: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_CENTER: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_GRAVITY: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_INHERIT: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_TEXT_END: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_TEXT_START: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_VIEW_END: Integer; cdecl;
    {class} function _GetTEXT_ALIGNMENT_VIEW_START: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_ANY_RTL: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_FIRST_STRONG: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_FIRST_STRONG_LTR: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_FIRST_STRONG_RTL: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_INHERIT: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_LOCALE: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_LTR: Integer; cdecl;
    {class} function _GetTEXT_DIRECTION_RTL: Integer; cdecl;
    {class} function _GetTRANSLATION_X: JProperty; cdecl;
    {class} function _GetTRANSLATION_Y: JProperty; cdecl;
    {class} function _GetTRANSLATION_Z: JProperty; cdecl;
    {class} function _GetVISIBLE: Integer; cdecl;
    {class} function _GetX: JProperty; cdecl;
    {class} function _GetY: JProperty; cdecl;
    {class} function _GetZ: JProperty; cdecl;
    {class} function init(context: JContext): JView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JView; cdecl; overload;
    {class} function combineMeasuredStates(curState: Integer; newState: Integer): Integer; cdecl;
    {class} function generateViewId: Integer; cdecl;
    {class} function getDefaultSize(size: Integer; measureSpec: Integer): Integer; cdecl;
    {class} function inflate(context: JContext; resource: Integer; root: JViewGroup): JView; cdecl;
    {class} function resolveSize(size: Integer; measureSpec: Integer): Integer; cdecl;
    {class} function resolveSizeAndState(size: Integer; measureSpec: Integer; childMeasuredState: Integer): Integer; cdecl;
    {class} property ACCESSIBILITY_LIVE_REGION_ASSERTIVE: Integer read _GetACCESSIBILITY_LIVE_REGION_ASSERTIVE;
    {class} property ACCESSIBILITY_LIVE_REGION_NONE: Integer read _GetACCESSIBILITY_LIVE_REGION_NONE;
    {class} property ACCESSIBILITY_LIVE_REGION_POLITE: Integer read _GetACCESSIBILITY_LIVE_REGION_POLITE;
    {class} property ALPHA: JProperty read _GetALPHA;
    {class} property DRAWING_CACHE_QUALITY_AUTO: Integer read _GetDRAWING_CACHE_QUALITY_AUTO;
    {class} property DRAWING_CACHE_QUALITY_HIGH: Integer read _GetDRAWING_CACHE_QUALITY_HIGH;
    {class} property DRAWING_CACHE_QUALITY_LOW: Integer read _GetDRAWING_CACHE_QUALITY_LOW;
    {class} property FIND_VIEWS_WITH_CONTENT_DESCRIPTION: Integer read _GetFIND_VIEWS_WITH_CONTENT_DESCRIPTION;
    {class} property FIND_VIEWS_WITH_TEXT: Integer read _GetFIND_VIEWS_WITH_TEXT;
    {class} property FOCUSABLES_ALL: Integer read _GetFOCUSABLES_ALL;
    {class} property FOCUSABLES_TOUCH_MODE: Integer read _GetFOCUSABLES_TOUCH_MODE;
    {class} property FOCUS_BACKWARD: Integer read _GetFOCUS_BACKWARD;
    {class} property FOCUS_DOWN: Integer read _GetFOCUS_DOWN;
    {class} property FOCUS_FORWARD: Integer read _GetFOCUS_FORWARD;
    {class} property FOCUS_LEFT: Integer read _GetFOCUS_LEFT;
    {class} property FOCUS_RIGHT: Integer read _GetFOCUS_RIGHT;
    {class} property FOCUS_UP: Integer read _GetFOCUS_UP;
    {class} property GONE: Integer read _GetGONE;
    {class} property HAPTIC_FEEDBACK_ENABLED: Integer read _GetHAPTIC_FEEDBACK_ENABLED;
    {class} property IMPORTANT_FOR_ACCESSIBILITY_AUTO: Integer read _GetIMPORTANT_FOR_ACCESSIBILITY_AUTO;
    {class} property IMPORTANT_FOR_ACCESSIBILITY_NO: Integer read _GetIMPORTANT_FOR_ACCESSIBILITY_NO;
    {class} property IMPORTANT_FOR_ACCESSIBILITY_NO_HIDE_DESCENDANTS: Integer read _GetIMPORTANT_FOR_ACCESSIBILITY_NO_HIDE_DESCENDANTS;
    {class} property IMPORTANT_FOR_ACCESSIBILITY_YES: Integer read _GetIMPORTANT_FOR_ACCESSIBILITY_YES;
    {class} property INVISIBLE: Integer read _GetINVISIBLE;
    {class} property KEEP_SCREEN_ON: Integer read _GetKEEP_SCREEN_ON;
    {class} property LAYER_TYPE_HARDWARE: Integer read _GetLAYER_TYPE_HARDWARE;
    {class} property LAYER_TYPE_NONE: Integer read _GetLAYER_TYPE_NONE;
    {class} property LAYER_TYPE_SOFTWARE: Integer read _GetLAYER_TYPE_SOFTWARE;
    {class} property LAYOUT_DIRECTION_INHERIT: Integer read _GetLAYOUT_DIRECTION_INHERIT;
    {class} property LAYOUT_DIRECTION_LOCALE: Integer read _GetLAYOUT_DIRECTION_LOCALE;
    {class} property LAYOUT_DIRECTION_LTR: Integer read _GetLAYOUT_DIRECTION_LTR;
    {class} property LAYOUT_DIRECTION_RTL: Integer read _GetLAYOUT_DIRECTION_RTL;
    {class} property MEASURED_HEIGHT_STATE_SHIFT: Integer read _GetMEASURED_HEIGHT_STATE_SHIFT;
    {class} property MEASURED_SIZE_MASK: Integer read _GetMEASURED_SIZE_MASK;
    {class} property MEASURED_STATE_MASK: Integer read _GetMEASURED_STATE_MASK;
    {class} property MEASURED_STATE_TOO_SMALL: Integer read _GetMEASURED_STATE_TOO_SMALL;
    {class} property NO_ID: Integer read _GetNO_ID;
    {class} property OVER_SCROLL_ALWAYS: Integer read _GetOVER_SCROLL_ALWAYS;
    {class} property OVER_SCROLL_IF_CONTENT_SCROLLS: Integer read _GetOVER_SCROLL_IF_CONTENT_SCROLLS;
    {class} property OVER_SCROLL_NEVER: Integer read _GetOVER_SCROLL_NEVER;
    {class} property ROTATION: JProperty read _GetROTATION;
    {class} property ROTATION_X: JProperty read _GetROTATION_X;
    {class} property ROTATION_Y: JProperty read _GetROTATION_Y;
    {class} property SCALE_X: JProperty read _GetSCALE_X;
    {class} property SCALE_Y: JProperty read _GetSCALE_Y;
    {class} property SCREEN_STATE_OFF: Integer read _GetSCREEN_STATE_OFF;
    {class} property SCREEN_STATE_ON: Integer read _GetSCREEN_STATE_ON;
    {class} property SCROLLBARS_INSIDE_INSET: Integer read _GetSCROLLBARS_INSIDE_INSET;
    {class} property SCROLLBARS_INSIDE_OVERLAY: Integer read _GetSCROLLBARS_INSIDE_OVERLAY;
    {class} property SCROLLBARS_OUTSIDE_INSET: Integer read _GetSCROLLBARS_OUTSIDE_INSET;
    {class} property SCROLLBARS_OUTSIDE_OVERLAY: Integer read _GetSCROLLBARS_OUTSIDE_OVERLAY;
    {class} property SCROLLBAR_POSITION_DEFAULT: Integer read _GetSCROLLBAR_POSITION_DEFAULT;
    {class} property SCROLLBAR_POSITION_LEFT: Integer read _GetSCROLLBAR_POSITION_LEFT;
    {class} property SCROLLBAR_POSITION_RIGHT: Integer read _GetSCROLLBAR_POSITION_RIGHT;
    {class} property SCROLL_AXIS_HORIZONTAL: Integer read _GetSCROLL_AXIS_HORIZONTAL;
    {class} property SCROLL_AXIS_NONE: Integer read _GetSCROLL_AXIS_NONE;
    {class} property SCROLL_AXIS_VERTICAL: Integer read _GetSCROLL_AXIS_VERTICAL;
    {class} property SCROLL_INDICATOR_BOTTOM: Integer read _GetSCROLL_INDICATOR_BOTTOM;
    {class} property SCROLL_INDICATOR_END: Integer read _GetSCROLL_INDICATOR_END;
    {class} property SCROLL_INDICATOR_LEFT: Integer read _GetSCROLL_INDICATOR_LEFT;
    {class} property SCROLL_INDICATOR_RIGHT: Integer read _GetSCROLL_INDICATOR_RIGHT;
    {class} property SCROLL_INDICATOR_START: Integer read _GetSCROLL_INDICATOR_START;
    {class} property SCROLL_INDICATOR_TOP: Integer read _GetSCROLL_INDICATOR_TOP;
    {class} property SOUND_EFFECTS_ENABLED: Integer read _GetSOUND_EFFECTS_ENABLED;
    {class} property STATUS_BAR_HIDDEN: Integer read _GetSTATUS_BAR_HIDDEN;
    {class} property STATUS_BAR_VISIBLE: Integer read _GetSTATUS_BAR_VISIBLE;
    {class} property SYSTEM_UI_FLAG_FULLSCREEN: Integer read _GetSYSTEM_UI_FLAG_FULLSCREEN;
    {class} property SYSTEM_UI_FLAG_HIDE_NAVIGATION: Integer read _GetSYSTEM_UI_FLAG_HIDE_NAVIGATION;
    {class} property SYSTEM_UI_FLAG_IMMERSIVE: Integer read _GetSYSTEM_UI_FLAG_IMMERSIVE;
    {class} property SYSTEM_UI_FLAG_IMMERSIVE_STICKY: Integer read _GetSYSTEM_UI_FLAG_IMMERSIVE_STICKY;
    {class} property SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN: Integer read _GetSYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
    {class} property SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION: Integer read _GetSYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION;
    {class} property SYSTEM_UI_FLAG_LAYOUT_STABLE: Integer read _GetSYSTEM_UI_FLAG_LAYOUT_STABLE;
    {class} property SYSTEM_UI_FLAG_LIGHT_STATUS_BAR: Integer read _GetSYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
    {class} property SYSTEM_UI_FLAG_LOW_PROFILE: Integer read _GetSYSTEM_UI_FLAG_LOW_PROFILE;
    {class} property SYSTEM_UI_FLAG_VISIBLE: Integer read _GetSYSTEM_UI_FLAG_VISIBLE;
    {class} property SYSTEM_UI_LAYOUT_FLAGS: Integer read _GetSYSTEM_UI_LAYOUT_FLAGS;
    {class} property TEXT_ALIGNMENT_CENTER: Integer read _GetTEXT_ALIGNMENT_CENTER;
    {class} property TEXT_ALIGNMENT_GRAVITY: Integer read _GetTEXT_ALIGNMENT_GRAVITY;
    {class} property TEXT_ALIGNMENT_INHERIT: Integer read _GetTEXT_ALIGNMENT_INHERIT;
    {class} property TEXT_ALIGNMENT_TEXT_END: Integer read _GetTEXT_ALIGNMENT_TEXT_END;
    {class} property TEXT_ALIGNMENT_TEXT_START: Integer read _GetTEXT_ALIGNMENT_TEXT_START;
    {class} property TEXT_ALIGNMENT_VIEW_END: Integer read _GetTEXT_ALIGNMENT_VIEW_END;
    {class} property TEXT_ALIGNMENT_VIEW_START: Integer read _GetTEXT_ALIGNMENT_VIEW_START;
    {class} property TEXT_DIRECTION_ANY_RTL: Integer read _GetTEXT_DIRECTION_ANY_RTL;
    {class} property TEXT_DIRECTION_FIRST_STRONG: Integer read _GetTEXT_DIRECTION_FIRST_STRONG;
    {class} property TEXT_DIRECTION_FIRST_STRONG_LTR: Integer read _GetTEXT_DIRECTION_FIRST_STRONG_LTR;
    {class} property TEXT_DIRECTION_FIRST_STRONG_RTL: Integer read _GetTEXT_DIRECTION_FIRST_STRONG_RTL;
    {class} property TEXT_DIRECTION_INHERIT: Integer read _GetTEXT_DIRECTION_INHERIT;
    {class} property TEXT_DIRECTION_LOCALE: Integer read _GetTEXT_DIRECTION_LOCALE;
    {class} property TEXT_DIRECTION_LTR: Integer read _GetTEXT_DIRECTION_LTR;
    {class} property TEXT_DIRECTION_RTL: Integer read _GetTEXT_DIRECTION_RTL;
    {class} property TRANSLATION_X: JProperty read _GetTRANSLATION_X;
    {class} property TRANSLATION_Y: JProperty read _GetTRANSLATION_Y;
    {class} property TRANSLATION_Z: JProperty read _GetTRANSLATION_Z;
    {class} property VISIBLE: Integer read _GetVISIBLE;
    {class} property X: JProperty read _GetX;
    {class} property Y: JProperty read _GetY;
    {class} property Z: JProperty read _GetZ;
  end;

  [JavaSignature('android/view/View')]
  JView = interface(JObject)
    ['{DC3C5B70-7559-4AFB-9FAC-0DBAE311F8BF}']
    procedure addChildrenForAccessibility(outChildren: JArrayList); cdecl;
    procedure addFocusables(views: JArrayList; direction: Integer); cdecl; overload;
    procedure addFocusables(views: JArrayList; direction: Integer; focusableMode: Integer); cdecl; overload;
    procedure addOnAttachStateChangeListener(listener: JView_OnAttachStateChangeListener); cdecl;
    procedure addOnLayoutChangeListener(listener: JView_OnLayoutChangeListener); cdecl;
    procedure addTouchables(views: JArrayList); cdecl;
    function animate: JViewPropertyAnimator; cdecl;
    procedure announceForAccessibility(text: JCharSequence); cdecl;
    procedure bringToFront; cdecl;
    procedure buildDrawingCache; cdecl; overload;
    procedure buildDrawingCache(autoScale: Boolean); cdecl; overload;
    procedure buildLayer; cdecl;
    function callOnClick: Boolean; cdecl;
    function canResolveLayoutDirection: Boolean; cdecl;
    function canResolveTextAlignment: Boolean; cdecl;
    function canResolveTextDirection: Boolean; cdecl;
    function canScrollHorizontally(direction: Integer): Boolean; cdecl;
    function canScrollVertically(direction: Integer): Boolean; cdecl;
    procedure cancelLongPress; cdecl;
    procedure cancelPendingInputEvents; cdecl;
    function checkInputConnectionProxy(view: JView): Boolean; cdecl;
    procedure clearAnimation; cdecl;
    procedure clearFocus; cdecl;
    procedure computeScroll; cdecl;
    function computeSystemWindowInsets(in_: JWindowInsets; outLocalInsets: JRect): JWindowInsets; cdecl;
    function createAccessibilityNodeInfo: JAccessibilityNodeInfo; cdecl;
    procedure createContextMenu(menu: JContextMenu); cdecl;
    procedure destroyDrawingCache; cdecl;
    function dispatchApplyWindowInsets(insets: JWindowInsets): JWindowInsets; cdecl;
    procedure dispatchConfigurationChanged(newConfig: JConfiguration); cdecl;
    procedure dispatchDisplayHint(hint: Integer); cdecl;
    function dispatchDragEvent(event: JDragEvent): Boolean; cdecl;
    procedure dispatchDrawableHotspotChanged(x: Single; y: Single); cdecl;
    function dispatchGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function dispatchKeyEventPreIme(event: JKeyEvent): Boolean; cdecl;
    function dispatchKeyShortcutEvent(event: JKeyEvent): Boolean; cdecl;
    function dispatchNestedFling(velocityX: Single; velocityY: Single; consumed: Boolean): Boolean; cdecl;
    function dispatchNestedPreFling(velocityX: Single; velocityY: Single): Boolean; cdecl;
    function dispatchNestedPrePerformAccessibilityAction(action: Integer; arguments: JBundle): Boolean; cdecl;
    function dispatchNestedPreScroll(dx: Integer; dy: Integer; consumed: TJavaArray<Integer>; offsetInWindow: TJavaArray<Integer>): Boolean; cdecl;
    function dispatchNestedScroll(dxConsumed: Integer; dyConsumed: Integer; dxUnconsumed: Integer; dyUnconsumed: Integer; offsetInWindow: TJavaArray<Integer>): Boolean; cdecl;
    function dispatchPopulateAccessibilityEvent(event: JAccessibilityEvent): Boolean; cdecl;
    procedure dispatchProvideStructure(structure: JViewStructure); cdecl;
    procedure dispatchSystemUiVisibilityChanged(visibility: Integer); cdecl;
    function dispatchTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function dispatchTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    function dispatchUnhandledMove(focused: JView; direction: Integer): Boolean; cdecl;
    procedure dispatchWindowFocusChanged(hasFocus: Boolean); cdecl;
    procedure dispatchWindowSystemUiVisiblityChanged(visible: Integer); cdecl;
    procedure dispatchWindowVisibilityChanged(visibility: Integer); cdecl;
    procedure draw(canvas: JCanvas); cdecl;
    procedure drawableHotspotChanged(x: Single; y: Single); cdecl;
    function findFocus: JView; cdecl;
    function findViewById(id: Integer): JView; cdecl;
    function findViewWithTag(tag: JObject): JView; cdecl;
    procedure findViewsWithText(outViews: JArrayList; searched: JCharSequence; flags: Integer); cdecl;
    function focusSearch(direction: Integer): JView; cdecl;
    procedure forceLayout; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAccessibilityLiveRegion: Integer; cdecl;
    function getAccessibilityNodeProvider: JAccessibilityNodeProvider; cdecl;
    function getAccessibilityTraversalAfter: Integer; cdecl;
    function getAccessibilityTraversalBefore: Integer; cdecl;
    function getAlpha: Single; cdecl;
    function getAnimation: JAnimation; cdecl;
    function getApplicationWindowToken: JIBinder; cdecl;
    function getBackground: JDrawable; cdecl;
    function getBackgroundTintList: JColorStateList; cdecl;
    function getBackgroundTintMode: JPorterDuff_Mode; cdecl;
    function getBaseline: Integer; cdecl;
    function getBottom: Integer; cdecl;
    function getCameraDistance: Single; cdecl;
    function getClipBounds: JRect; cdecl; overload;
    function getClipBounds(outRect: JRect): Boolean; cdecl; overload;
    function getClipToOutline: Boolean; cdecl;
    function getContentDescription: JCharSequence; cdecl;
    function getContext: JContext; cdecl;
    function getDisplay: JDisplay; cdecl;
    function getDrawableState: TJavaArray<Integer>; cdecl;
    function getDrawingCache: JBitmap; cdecl; overload;
    function getDrawingCache(autoScale: Boolean): JBitmap; cdecl; overload;
    function getDrawingCacheBackgroundColor: Integer; cdecl;
    function getDrawingCacheQuality: Integer; cdecl;
    procedure getDrawingRect(outRect: JRect); cdecl;
    function getDrawingTime: Int64; cdecl;
    function getElevation: Single; cdecl;
    function getFilterTouchesWhenObscured: Boolean; cdecl;
    function getFitsSystemWindows: Boolean; cdecl;
    function getFocusables(direction: Integer): JArrayList; cdecl;
    procedure getFocusedRect(r: JRect); cdecl;
    function getForeground: JDrawable; cdecl;
    function getForegroundGravity: Integer; cdecl;
    function getForegroundTintList: JColorStateList; cdecl;
    function getForegroundTintMode: JPorterDuff_Mode; cdecl;
    function getGlobalVisibleRect(r: JRect; globalOffset: JPoint): Boolean; cdecl; overload;
    function getGlobalVisibleRect(r: JRect): Boolean; cdecl; overload;
    function getHandler: JHandler; cdecl;
    function getHeight: Integer; cdecl;
    procedure getHitRect(outRect: JRect); cdecl;
    function getHorizontalFadingEdgeLength: Integer; cdecl;
    function getId: Integer; cdecl;
    function getImportantForAccessibility: Integer; cdecl;
    function getKeepScreenOn: Boolean; cdecl;
    function getKeyDispatcherState: JKeyEvent_DispatcherState; cdecl;
    function getLabelFor: Integer; cdecl;
    function getLayerType: Integer; cdecl;
    function getLayoutDirection: Integer; cdecl;
    function getLayoutParams: JViewGroup_LayoutParams; cdecl;
    function getLeft: Integer; cdecl;
    function getLocalVisibleRect(r: JRect): Boolean; cdecl;
    procedure getLocationInWindow(location: TJavaArray<Integer>); cdecl;
    procedure getLocationOnScreen(location: TJavaArray<Integer>); cdecl;
    function getMatrix: JMatrix; cdecl;
    function getMeasuredHeight: Integer; cdecl;
    function getMeasuredHeightAndState: Integer; cdecl;
    function getMeasuredState: Integer; cdecl;
    function getMeasuredWidth: Integer; cdecl;
    function getMeasuredWidthAndState: Integer; cdecl;
    function getMinimumHeight: Integer; cdecl;
    function getMinimumWidth: Integer; cdecl;
    function getNextFocusDownId: Integer; cdecl;
    function getNextFocusForwardId: Integer; cdecl;
    function getNextFocusLeftId: Integer; cdecl;
    function getNextFocusRightId: Integer; cdecl;
    function getNextFocusUpId: Integer; cdecl;
    function getOnFocusChangeListener: JView_OnFocusChangeListener; cdecl;
    function getOutlineProvider: JViewOutlineProvider; cdecl;
    function getOverScrollMode: Integer; cdecl;
    function getOverlay: JViewOverlay; cdecl;
    function getPaddingBottom: Integer; cdecl;
    function getPaddingEnd: Integer; cdecl;
    function getPaddingLeft: Integer; cdecl;
    function getPaddingRight: Integer; cdecl;
    function getPaddingStart: Integer; cdecl;
    function getPaddingTop: Integer; cdecl;
    function getParent: JViewParent; cdecl;
    function getParentForAccessibility: JViewParent; cdecl;
    function getPivotX: Single; cdecl;
    function getPivotY: Single; cdecl;
    function getResources: JResources; cdecl;
    function getRight: Integer; cdecl;
    function getRootView: JView; cdecl;
    function getRootWindowInsets: JWindowInsets; cdecl;
    function getRotation: Single; cdecl;
    function getRotationX: Single; cdecl;
    function getRotationY: Single; cdecl;
    function getScaleX: Single; cdecl;
    function getScaleY: Single; cdecl;
    function getScrollBarDefaultDelayBeforeFade: Integer; cdecl;
    function getScrollBarFadeDuration: Integer; cdecl;
    function getScrollBarSize: Integer; cdecl;
    function getScrollBarStyle: Integer; cdecl;
    function getScrollIndicators: Integer; cdecl;
    function getScrollX: Integer; cdecl;
    function getScrollY: Integer; cdecl;
    function getSolidColor: Integer; cdecl;
    //function getStateListAnimator: JStateListAnimator; cdecl;
    function getSystemUiVisibility: Integer; cdecl;
    function getTag: JObject; cdecl; overload;
    function getTag(key: Integer): JObject; cdecl; overload;
    function getTextAlignment: Integer; cdecl;
    function getTextDirection: Integer; cdecl;
    function getTop: Integer; cdecl;
    function getTouchDelegate: JTouchDelegate; cdecl;
    function getTouchables: JArrayList; cdecl;
    function getTransitionName: JString; cdecl;
    function getTranslationX: Single; cdecl;
    function getTranslationY: Single; cdecl;
    function getTranslationZ: Single; cdecl;
    function getVerticalFadingEdgeLength: Integer; cdecl;
    function getVerticalScrollbarPosition: Integer; cdecl;
    function getVerticalScrollbarWidth: Integer; cdecl;
    function getViewTreeObserver: JViewTreeObserver; cdecl;
    function getVisibility: Integer; cdecl;
    function getWidth: Integer; cdecl;
    function getWindowId: JWindowId; cdecl;
    function getWindowSystemUiVisibility: Integer; cdecl;
    function getWindowToken: JIBinder; cdecl;
    function getWindowVisibility: Integer; cdecl;
    procedure getWindowVisibleDisplayFrame(outRect: JRect); cdecl;
    function getX: Single; cdecl;
    function getY: Single; cdecl;
    function getZ: Single; cdecl;
    function hasFocus: Boolean; cdecl;
    function hasFocusable: Boolean; cdecl;
    function hasNestedScrollingParent: Boolean; cdecl;
    function hasOnClickListeners: Boolean; cdecl;
    function hasOverlappingRendering: Boolean; cdecl;
    function hasTransientState: Boolean; cdecl;
    function hasWindowFocus: Boolean; cdecl;
    procedure invalidate(dirty: JRect); cdecl; overload;
    procedure invalidate(l: Integer; t: Integer; r: Integer; b: Integer); cdecl; overload;
    procedure invalidate; cdecl; overload;
    procedure invalidateDrawable(drawable: JDrawable); cdecl;
    procedure invalidateOutline; cdecl;
    function isAccessibilityFocused: Boolean; cdecl;
    function isActivated: Boolean; cdecl;
    function isAttachedToWindow: Boolean; cdecl;
    function isClickable: Boolean; cdecl;
    function isContextClickable: Boolean; cdecl;
    function isDirty: Boolean; cdecl;
    function isDrawingCacheEnabled: Boolean; cdecl;
    function isDuplicateParentStateEnabled: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isFocusable: Boolean; cdecl;
    function isFocusableInTouchMode: Boolean; cdecl;
    function isFocused: Boolean; cdecl;
    function isHapticFeedbackEnabled: Boolean; cdecl;
    function isHardwareAccelerated: Boolean; cdecl;
    function isHorizontalFadingEdgeEnabled: Boolean; cdecl;
    function isHorizontalScrollBarEnabled: Boolean; cdecl;
    function isHovered: Boolean; cdecl;
    function isImportantForAccessibility: Boolean; cdecl;
    function isInEditMode: Boolean; cdecl;
    function isInLayout: Boolean; cdecl;
    function isInTouchMode: Boolean; cdecl;
    function isLaidOut: Boolean; cdecl;
    function isLayoutDirectionResolved: Boolean; cdecl;
    function isLayoutRequested: Boolean; cdecl;
    function isLongClickable: Boolean; cdecl;
    function isNestedScrollingEnabled: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isPaddingRelative: Boolean; cdecl;
    function isPressed: Boolean; cdecl;
    function isSaveEnabled: Boolean; cdecl;
    function isSaveFromParentEnabled: Boolean; cdecl;
    function isScrollContainer: Boolean; cdecl;
    function isScrollbarFadingEnabled: Boolean; cdecl;
    function isSelected: Boolean; cdecl;
    function isShown: Boolean; cdecl;
    function isSoundEffectsEnabled: Boolean; cdecl;
    function isTextAlignmentResolved: Boolean; cdecl;
    function isTextDirectionResolved: Boolean; cdecl;
    function isVerticalFadingEdgeEnabled: Boolean; cdecl;
    function isVerticalScrollBarEnabled: Boolean; cdecl;
    procedure jumpDrawablesToCurrentState; cdecl;
    procedure layout(l: Integer; t: Integer; r: Integer; b: Integer); cdecl;
    procedure measure(widthMeasureSpec: Integer; heightMeasureSpec: Integer); cdecl;
    procedure offsetLeftAndRight(offset: Integer); cdecl;
    procedure offsetTopAndBottom(offset: Integer); cdecl;
    function onApplyWindowInsets(insets: JWindowInsets): JWindowInsets; cdecl;
    procedure onCancelPendingInputEvents; cdecl;
    function onCheckIsTextEditor: Boolean; cdecl;
    function onCreateInputConnection(outAttrs: JEditorInfo): JInputConnection; cdecl;
    function onDragEvent(event: JDragEvent): Boolean; cdecl;
    procedure onDrawForeground(canvas: JCanvas); cdecl;
    function onFilterTouchEventForSecurity(event: JMotionEvent): Boolean; cdecl;
    procedure onFinishTemporaryDetach; cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onHoverChanged(hovered: Boolean); cdecl;
    function onHoverEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onInitializeAccessibilityEvent(event: JAccessibilityEvent); cdecl;
    procedure onInitializeAccessibilityNodeInfo(info: JAccessibilityNodeInfo); cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyLongPress(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyMultiple(keyCode: Integer; repeatCount: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyPreIme(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyShortcut(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    procedure onPopulateAccessibilityEvent(event: JAccessibilityEvent); cdecl;
    procedure onProvideStructure(structure: JViewStructure); cdecl;
    procedure onProvideVirtualStructure(structure: JViewStructure); cdecl;
    procedure onRtlPropertiesChanged(layoutDirection: Integer); cdecl;
    procedure onScreenStateChanged(screenState: Integer); cdecl;
    procedure onStartTemporaryDetach; cdecl;
    function onTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function onTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onWindowFocusChanged(hasWindowFocus: Boolean); cdecl;
    procedure onWindowSystemUiVisibilityChanged(visible: Integer); cdecl;
    function performAccessibilityAction(action: Integer; arguments: JBundle): Boolean; cdecl;
    function performClick: Boolean; cdecl;
    function performContextClick: Boolean; cdecl;
    function performHapticFeedback(feedbackConstant: Integer): Boolean; cdecl; overload;
    function performHapticFeedback(feedbackConstant: Integer; flags: Integer): Boolean; cdecl; overload;
    function performLongClick: Boolean; cdecl;
    procedure playSoundEffect(soundConstant: Integer); cdecl;
    function post(action: JRunnable): Boolean; cdecl;
    function postDelayed(action: JRunnable; delayMillis: Int64): Boolean; cdecl;
    procedure postInvalidate; cdecl; overload;
    procedure postInvalidate(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure postInvalidateDelayed(delayMilliseconds: Int64); cdecl; overload;
    procedure postInvalidateDelayed(delayMilliseconds: Int64; left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure postInvalidateOnAnimation; cdecl; overload;
    procedure postInvalidateOnAnimation(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl; overload;
    procedure postOnAnimation(action: JRunnable); cdecl;
    procedure postOnAnimationDelayed(action: JRunnable; delayMillis: Int64); cdecl;
    procedure refreshDrawableState; cdecl;
    function removeCallbacks(action: JRunnable): Boolean; cdecl;
    procedure removeOnAttachStateChangeListener(listener: JView_OnAttachStateChangeListener); cdecl;
    procedure removeOnLayoutChangeListener(listener: JView_OnLayoutChangeListener); cdecl;
    procedure requestApplyInsets; cdecl;
    procedure requestFitSystemWindows; cdecl;//Deprecated
    function requestFocus: Boolean; cdecl; overload;
    function requestFocus(direction: Integer): Boolean; cdecl; overload;
    function requestFocus(direction: Integer; previouslyFocusedRect: JRect): Boolean; cdecl; overload;
    function requestFocusFromTouch: Boolean; cdecl;
    procedure requestLayout; cdecl;
    function requestRectangleOnScreen(rectangle: JRect): Boolean; cdecl; overload;
    function requestRectangleOnScreen(rectangle: JRect; immediate: Boolean): Boolean; cdecl; overload;
    procedure requestUnbufferedDispatch(event: JMotionEvent); cdecl;
    procedure restoreHierarchyState(container: JSparseArray); cdecl;
    procedure saveHierarchyState(container: JSparseArray); cdecl;
    procedure scheduleDrawable(who: JDrawable; what: JRunnable; when: Int64); cdecl;
    procedure scrollBy(x: Integer; y: Integer); cdecl;
    procedure scrollTo(x: Integer; y: Integer); cdecl;
    procedure sendAccessibilityEvent(eventType: Integer); cdecl;
    procedure sendAccessibilityEventUnchecked(event: JAccessibilityEvent); cdecl;
    procedure setAccessibilityDelegate(delegate: JView_AccessibilityDelegate); cdecl;
    procedure setAccessibilityLiveRegion(mode: Integer); cdecl;
    procedure setAccessibilityTraversalAfter(afterId: Integer); cdecl;
    procedure setAccessibilityTraversalBefore(beforeId: Integer); cdecl;
    procedure setActivated(activated: Boolean); cdecl;
    procedure setAlpha(alpha: Single); cdecl;
    procedure setAnimation(animation: JAnimation); cdecl;
    procedure setBackground(background: JDrawable); cdecl;
    procedure setBackgroundColor(color: Integer); cdecl;
    procedure setBackgroundDrawable(background: JDrawable); cdecl;//Deprecated
    procedure setBackgroundResource(resid: Integer); cdecl;
    procedure setBackgroundTintList(tint: JColorStateList); cdecl;
    procedure setBackgroundTintMode(tintMode: JPorterDuff_Mode); cdecl;
    procedure setBottom(bottom: Integer); cdecl;
    procedure setCameraDistance(distance: Single); cdecl;
    procedure setClickable(clickable: Boolean); cdecl;
    procedure setClipBounds(clipBounds: JRect); cdecl;
    procedure setClipToOutline(clipToOutline: Boolean); cdecl;
    procedure setContentDescription(contentDescription: JCharSequence); cdecl;
    procedure setContextClickable(contextClickable: Boolean); cdecl;
    procedure setDrawingCacheBackgroundColor(color: Integer); cdecl;
    procedure setDrawingCacheEnabled(enabled: Boolean); cdecl;
    procedure setDrawingCacheQuality(quality: Integer); cdecl;
    procedure setDuplicateParentStateEnabled(enabled: Boolean); cdecl;
    procedure setElevation(elevation: Single); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setFadingEdgeLength(length: Integer); cdecl;
    procedure setFilterTouchesWhenObscured(enabled: Boolean); cdecl;
    procedure setFitsSystemWindows(fitSystemWindows: Boolean); cdecl;
    procedure setFocusable(focusable: Boolean); cdecl;
    procedure setFocusableInTouchMode(focusableInTouchMode: Boolean); cdecl;
    procedure setForeground(foreground: JDrawable); cdecl;
    procedure setForegroundGravity(gravity: Integer); cdecl;
    procedure setForegroundTintList(tint: JColorStateList); cdecl;
    procedure setForegroundTintMode(tintMode: JPorterDuff_Mode); cdecl;
    procedure setHapticFeedbackEnabled(hapticFeedbackEnabled: Boolean); cdecl;
    procedure setHasTransientState(hasTransientState: Boolean); cdecl;
    procedure setHorizontalFadingEdgeEnabled(horizontalFadingEdgeEnabled: Boolean); cdecl;
    procedure setHorizontalScrollBarEnabled(horizontalScrollBarEnabled: Boolean); cdecl;
    procedure setHovered(hovered: Boolean); cdecl;
    procedure setId(id: Integer); cdecl;
    procedure setImportantForAccessibility(mode: Integer); cdecl;
    procedure setKeepScreenOn(keepScreenOn: Boolean); cdecl;
    procedure setLabelFor(id: Integer); cdecl;
    procedure setLayerPaint(paint: JPaint); cdecl;
    procedure setLayerType(layerType: Integer; paint: JPaint); cdecl;
    procedure setLayoutDirection(layoutDirection: Integer); cdecl;
    procedure setLayoutParams(params: JViewGroup_LayoutParams); cdecl;
    procedure setLeft(left: Integer); cdecl;
    procedure setLongClickable(longClickable: Boolean); cdecl;
    procedure setMinimumHeight(minHeight: Integer); cdecl;
    procedure setMinimumWidth(minWidth: Integer); cdecl;
    procedure setNestedScrollingEnabled(enabled: Boolean); cdecl;
    procedure setNextFocusDownId(nextFocusDownId: Integer); cdecl;
    procedure setNextFocusForwardId(nextFocusForwardId: Integer); cdecl;
    procedure setNextFocusLeftId(nextFocusLeftId: Integer); cdecl;
    procedure setNextFocusRightId(nextFocusRightId: Integer); cdecl;
    procedure setNextFocusUpId(nextFocusUpId: Integer); cdecl;
    procedure setOnApplyWindowInsetsListener(listener: JView_OnApplyWindowInsetsListener); cdecl;
    procedure setOnClickListener(l: JView_OnClickListener); cdecl;
    procedure setOnContextClickListener(l: JView_OnContextClickListener); cdecl;
    procedure setOnCreateContextMenuListener(l: JView_OnCreateContextMenuListener); cdecl;
    procedure setOnDragListener(l: JView_OnDragListener); cdecl;
    procedure setOnFocusChangeListener(l: JView_OnFocusChangeListener); cdecl;
    procedure setOnGenericMotionListener(l: JView_OnGenericMotionListener); cdecl;
    procedure setOnHoverListener(l: JView_OnHoverListener); cdecl;
    procedure setOnKeyListener(l: JView_OnKeyListener); cdecl;
    procedure setOnLongClickListener(l: JView_OnLongClickListener); cdecl;
    procedure setOnScrollChangeListener(l: JView_OnScrollChangeListener); cdecl;
    procedure setOnSystemUiVisibilityChangeListener(l: JView_OnSystemUiVisibilityChangeListener); cdecl;
    procedure setOnTouchListener(l: JView_OnTouchListener); cdecl;
    procedure setOutlineProvider(provider: JViewOutlineProvider); cdecl;
    procedure setOverScrollMode(overScrollMode: Integer); cdecl;
    procedure setPadding(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setPaddingRelative(start: Integer; top: Integer; end_: Integer; bottom: Integer); cdecl;
    procedure setPivotX(pivotX: Single); cdecl;
    procedure setPivotY(pivotY: Single); cdecl;
    procedure setPressed(pressed: Boolean); cdecl;
    procedure setRight(right: Integer); cdecl;
    procedure setRotation(rotation: Single); cdecl;
    procedure setRotationX(rotationX: Single); cdecl;
    procedure setRotationY(rotationY: Single); cdecl;
    procedure setSaveEnabled(enabled: Boolean); cdecl;
    procedure setSaveFromParentEnabled(enabled: Boolean); cdecl;
    procedure setScaleX(scaleX: Single); cdecl;
    procedure setScaleY(scaleY: Single); cdecl;
    procedure setScrollBarDefaultDelayBeforeFade(scrollBarDefaultDelayBeforeFade: Integer); cdecl;
    procedure setScrollBarFadeDuration(scrollBarFadeDuration: Integer); cdecl;
    procedure setScrollBarSize(scrollBarSize: Integer); cdecl;
    procedure setScrollBarStyle(style: Integer); cdecl;
    procedure setScrollContainer(isScrollContainer: Boolean); cdecl;
    procedure setScrollIndicators(indicators: Integer); cdecl; overload;
    procedure setScrollIndicators(indicators: Integer; mask: Integer); cdecl; overload;
    procedure setScrollX(value: Integer); cdecl;
    procedure setScrollY(value: Integer); cdecl;
    procedure setScrollbarFadingEnabled(fadeScrollbars: Boolean); cdecl;
    procedure setSelected(selected: Boolean); cdecl;
    procedure setSoundEffectsEnabled(soundEffectsEnabled: Boolean); cdecl;
    //procedure setStateListAnimator(stateListAnimator: JStateListAnimator); cdecl;
    procedure setSystemUiVisibility(visibility: Integer); cdecl;
    procedure setTag(tag: JObject); cdecl; overload;
    procedure setTag(key: Integer; tag: JObject); cdecl; overload;
    procedure setTextAlignment(textAlignment: Integer); cdecl;
    procedure setTextDirection(textDirection: Integer); cdecl;
    procedure setTop(top: Integer); cdecl;
    procedure setTouchDelegate(delegate: JTouchDelegate); cdecl;
    procedure setTransitionName(transitionName: JString); cdecl;
    procedure setTranslationX(translationX: Single); cdecl;
    procedure setTranslationY(translationY: Single); cdecl;
    procedure setTranslationZ(translationZ: Single); cdecl;
    procedure setVerticalFadingEdgeEnabled(verticalFadingEdgeEnabled: Boolean); cdecl;
    procedure setVerticalScrollBarEnabled(verticalScrollBarEnabled: Boolean); cdecl;
    procedure setVerticalScrollbarPosition(position: Integer); cdecl;
    procedure setVisibility(visibility: Integer); cdecl;
    procedure setWillNotCacheDrawing(willNotCacheDrawing: Boolean); cdecl;
    procedure setWillNotDraw(willNotDraw: Boolean); cdecl;
    procedure setX(x: Single); cdecl;
    procedure setY(y: Single); cdecl;
    procedure setZ(z: Single); cdecl;
    function showContextMenu: Boolean; cdecl;
    function startActionMode(callback: JActionMode_Callback): JActionMode; cdecl; overload;
    function startActionMode(callback: JActionMode_Callback; type_: Integer): JActionMode; cdecl; overload;
    procedure startAnimation(animation: JAnimation); cdecl;
    function startDrag(data: JClipData; shadowBuilder: JView_DragShadowBuilder; myLocalState: JObject; flags: Integer): Boolean; cdecl;
    function startNestedScroll(axes: Integer): Boolean; cdecl;
    procedure stopNestedScroll; cdecl;
    function toString: JString; cdecl;
    procedure unscheduleDrawable(who: JDrawable; what: JRunnable); cdecl; overload;
    procedure unscheduleDrawable(who: JDrawable); cdecl; overload;
    function willNotCacheDrawing: Boolean; cdecl;
    function willNotDraw: Boolean; cdecl;
  end;
  TJView = class(TJavaGenericImport<JViewClass, JView>) end;

  JSurfaceViewClass = interface(JViewClass)
    ['{C67B60CB-6C82-4920-BA7F-C504D331FBA5}']
    {class} function init(context: JContext): JSurfaceView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JSurfaceView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JSurfaceView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JSurfaceView; cdecl; overload;
  end;

  [JavaSignature('android/view/SurfaceView')]
  JSurfaceView = interface(JView)
    ['{1A9C1F1D-C888-47F7-AB78-C3D1AB5533D6}']
    procedure draw(canvas: JCanvas); cdecl;
    function gatherTransparentRegion(region: JRegion): Boolean; cdecl;
    function getHolder: JSurfaceHolder; cdecl;
    procedure setSecure(isSecure: Boolean); cdecl;
    procedure setVisibility(visibility: Integer); cdecl;
    procedure setZOrderMediaOverlay(isMediaOverlay: Boolean); cdecl;
    procedure setZOrderOnTop(onTop: Boolean); cdecl;
  end;
  TJSurfaceView = class(TJavaGenericImport<JSurfaceViewClass, JSurfaceView>) end;

  JTouchDelegateClass = interface(JObjectClass)
    ['{923E77FA-AC43-4168-B866-7645C259C17F}']
    {class} function _GetABOVE: Integer; cdecl;
    {class} function _GetBELOW: Integer; cdecl;
    {class} function _GetTO_LEFT: Integer; cdecl;
    {class} function _GetTO_RIGHT: Integer; cdecl;
    {class} function init(bounds: JRect; delegateView: JView): JTouchDelegate; cdecl;
    {class} property ABOVE: Integer read _GetABOVE;
    {class} property BELOW: Integer read _GetBELOW;
    {class} property TO_LEFT: Integer read _GetTO_LEFT;
    {class} property TO_RIGHT: Integer read _GetTO_RIGHT;
  end;

  [JavaSignature('android/view/TouchDelegate')]
  JTouchDelegate = interface(JObject)
    ['{1575B097-6A88-40F9-B95A-5ACDDA6F26BE}']
    function onTouchEvent(event: JMotionEvent): Boolean; cdecl;
  end;
  TJTouchDelegate = class(TJavaGenericImport<JTouchDelegateClass, JTouchDelegate>) end;

  JView_AccessibilityDelegateClass = interface(JObjectClass)
    ['{DC7776BF-CA33-4BBF-964E-77C7037A82CD}']
    {class} function init: JView_AccessibilityDelegate; cdecl;
  end;

  [JavaSignature('android/view/View$AccessibilityDelegate')]
  JView_AccessibilityDelegate = interface(JObject)
    ['{88C63CE9-94D4-4DE8-B74D-1EC6F8DCF8E5}']
    function dispatchPopulateAccessibilityEvent(host: JView; event: JAccessibilityEvent): Boolean; cdecl;
    function getAccessibilityNodeProvider(host: JView): JAccessibilityNodeProvider; cdecl;
    procedure onInitializeAccessibilityEvent(host: JView; event: JAccessibilityEvent); cdecl;
    procedure onInitializeAccessibilityNodeInfo(host: JView; info: JAccessibilityNodeInfo); cdecl;
    procedure onPopulateAccessibilityEvent(host: JView; event: JAccessibilityEvent); cdecl;
    function onRequestSendAccessibilityEvent(host: JViewGroup; child: JView; event: JAccessibilityEvent): Boolean; cdecl;
    function performAccessibilityAction(host: JView; action: Integer; args: JBundle): Boolean; cdecl;
    procedure sendAccessibilityEvent(host: JView; eventType: Integer); cdecl;
    procedure sendAccessibilityEventUnchecked(host: JView; event: JAccessibilityEvent); cdecl;
  end;
  TJView_AccessibilityDelegate = class(TJavaGenericImport<JView_AccessibilityDelegateClass, JView_AccessibilityDelegate>) end;

  JView_DragShadowBuilderClass = interface(JObjectClass)
    ['{1E9C9A18-F23F-4938-A011-EA78BF5F2AC0}']
    {class} function init(view: JView): JView_DragShadowBuilder; cdecl; overload;
    {class} function init: JView_DragShadowBuilder; cdecl; overload;
  end;

  [JavaSignature('android/view/View$DragShadowBuilder')]
  JView_DragShadowBuilder = interface(JObject)
    ['{383BA36F-4F18-4AB3-9E63-AD32EF5DFEA5}']
    function getView: JView; cdecl;
    procedure onDrawShadow(canvas: JCanvas); cdecl;
    procedure onProvideShadowMetrics(shadowSize: JPoint; shadowTouchPoint: JPoint); cdecl;
  end;
  TJView_DragShadowBuilder = class(TJavaGenericImport<JView_DragShadowBuilderClass, JView_DragShadowBuilder>) end;

  JView_OnApplyWindowInsetsListenerClass = interface(IJavaClass)
    ['{63836AF6-819E-40DC-AB73-063BDA5C92C1}']
  end;

  [JavaSignature('android/view/View$OnApplyWindowInsetsListener')]
  JView_OnApplyWindowInsetsListener = interface(IJavaInstance)
    ['{2809C1EC-5CF9-45DB-86DC-0EDB590BB877}']
    function onApplyWindowInsets(v: JView; insets: JWindowInsets): JWindowInsets; cdecl;
  end;
  TJView_OnApplyWindowInsetsListener = class(TJavaGenericImport<JView_OnApplyWindowInsetsListenerClass, JView_OnApplyWindowInsetsListener>) end;

  JView_OnAttachStateChangeListenerClass = interface(IJavaClass)
    ['{47D8E055-F47A-4A64-BB5B-EF33D445C77F}']
  end;

  [JavaSignature('android/view/View$OnAttachStateChangeListener')]
  JView_OnAttachStateChangeListener = interface(IJavaInstance)
    ['{EC79895D-7F69-4EAE-9213-CF41D73EFF91}']
    procedure onViewAttachedToWindow(v: JView); cdecl;
    procedure onViewDetachedFromWindow(v: JView); cdecl;
  end;
  TJView_OnAttachStateChangeListener = class(TJavaGenericImport<JView_OnAttachStateChangeListenerClass, JView_OnAttachStateChangeListener>) end;

  JView_OnClickListenerClass = interface(IJavaClass)
    ['{D4FE7E96-D2E9-4720-890E-0B03CBBFCB1B}']
  end;

  [JavaSignature('android/view/View$OnClickListener')]
  JView_OnClickListener = interface(IJavaInstance)
    ['{7603153E-EEF8-4F60-9882-FF5490A5AF28}']
    procedure onClick(v: JView); cdecl;
  end;
  TJView_OnClickListener = class(TJavaGenericImport<JView_OnClickListenerClass, JView_OnClickListener>) end;

  JView_OnContextClickListenerClass = interface(IJavaClass)
    ['{0002AE67-B132-45E5-8DF8-84A3290EFB4D}']
  end;

  [JavaSignature('android/view/View$OnContextClickListener')]
  JView_OnContextClickListener = interface(IJavaInstance)
    ['{771A7A18-6714-449B-86A2-7AA02F8B59F9}']
    function onContextClick(v: JView): Boolean; cdecl;
  end;
  TJView_OnContextClickListener = class(TJavaGenericImport<JView_OnContextClickListenerClass, JView_OnContextClickListener>) end;

  JView_OnCreateContextMenuListenerClass = interface(IJavaClass)
    ['{3AA65EA5-116C-4AB1-9793-A1280304879E}']
  end;

  [JavaSignature('android/view/View$OnCreateContextMenuListener')]
  JView_OnCreateContextMenuListener = interface(IJavaInstance)
    ['{03A19F11-8D70-4543-87C7-BD792FF23925}']
    procedure onCreateContextMenu(menu: JContextMenu; v: JView; menuInfo: JContextMenu_ContextMenuInfo); cdecl;
  end;
  TJView_OnCreateContextMenuListener = class(TJavaGenericImport<JView_OnCreateContextMenuListenerClass, JView_OnCreateContextMenuListener>) end;

  JView_OnDragListenerClass = interface(IJavaClass)
    ['{C23EC70C-39DC-4E2B-A0E2-84587D8A47B1}']
  end;

  [JavaSignature('android/view/View$OnDragListener')]
  JView_OnDragListener = interface(IJavaInstance)
    ['{78BD5F37-B6DF-4ABA-9F5B-CCA3401D91F1}']
    function onDrag(v: JView; event: JDragEvent): Boolean; cdecl;
  end;
  TJView_OnDragListener = class(TJavaGenericImport<JView_OnDragListenerClass, JView_OnDragListener>) end;

  JView_OnFocusChangeListenerClass = interface(IJavaClass)
    ['{4530BDF1-6C95-4EFC-B728-AAC8A1231FA3}']
  end;

  [JavaSignature('android/view/View$OnFocusChangeListener')]
  JView_OnFocusChangeListener = interface(IJavaInstance)
    ['{5FFFED8A-78CC-4E8C-BD41-8F7DBC6DF4AC}']
    procedure onFocusChange(v: JView; hasFocus: Boolean); cdecl;
  end;
  TJView_OnFocusChangeListener = class(TJavaGenericImport<JView_OnFocusChangeListenerClass, JView_OnFocusChangeListener>) end;

  JView_OnGenericMotionListenerClass = interface(IJavaClass)
    ['{CCA433E3-85AD-48F7-BF53-67E534A399A8}']
  end;

  [JavaSignature('android/view/View$OnGenericMotionListener')]
  JView_OnGenericMotionListener = interface(IJavaInstance)
    ['{EFD680B0-26A6-46B9-819C-AC7BAFE0B661}']
    function onGenericMotion(v: JView; event: JMotionEvent): Boolean; cdecl;
  end;
  TJView_OnGenericMotionListener = class(TJavaGenericImport<JView_OnGenericMotionListenerClass, JView_OnGenericMotionListener>) end;

  JView_OnHoverListenerClass = interface(IJavaClass)
    ['{D535C463-652A-4EEC-9BE9-AA6BC7EF4D5F}']
  end;

  [JavaSignature('android/view/View$OnHoverListener')]
  JView_OnHoverListener = interface(IJavaInstance)
    ['{D74EF222-6CD6-4D9F-BF49-9E0AF7B33EB7}']
    function onHover(v: JView; event: JMotionEvent): Boolean; cdecl;
  end;
  TJView_OnHoverListener = class(TJavaGenericImport<JView_OnHoverListenerClass, JView_OnHoverListener>) end;

  JView_OnKeyListenerClass = interface(IJavaClass)
    ['{53AEAB4F-2C34-494D-9C5D-E98026DBFF9A}']
  end;

  [JavaSignature('android/view/View$OnKeyListener')]
  JView_OnKeyListener = interface(IJavaInstance)
    ['{4E271738-0766-458B-883B-721CFD9F1DE6}']
    function onKey(v: JView; keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
  end;
  TJView_OnKeyListener = class(TJavaGenericImport<JView_OnKeyListenerClass, JView_OnKeyListener>) end;

  JView_OnLayoutChangeListenerClass = interface(IJavaClass)
    ['{BCD1B297-4D8D-4762-8F4B-3DACFF2BFFC0}']
  end;

  [JavaSignature('android/view/View$OnLayoutChangeListener')]
  JView_OnLayoutChangeListener = interface(IJavaInstance)
    ['{2F6FD289-4AD3-4E28-B71F-306D24A3DC58}']
    procedure onLayoutChange(v: JView; left: Integer; top: Integer; right: Integer; bottom: Integer; oldLeft: Integer; oldTop: Integer; oldRight: Integer; oldBottom: Integer); cdecl;
  end;
  TJView_OnLayoutChangeListener = class(TJavaGenericImport<JView_OnLayoutChangeListenerClass, JView_OnLayoutChangeListener>) end;

  JView_OnLongClickListenerClass = interface(IJavaClass)
    ['{15319AED-FAAF-43BF-841B-757694000752}']
  end;

  [JavaSignature('android/view/View$OnLongClickListener')]
  JView_OnLongClickListener = interface(IJavaInstance)
    ['{0895EAD0-05FE-4EFA-ACDF-199A50D2E2BC}']
    function onLongClick(v: JView): Boolean; cdecl;
  end;
  TJView_OnLongClickListener = class(TJavaGenericImport<JView_OnLongClickListenerClass, JView_OnLongClickListener>) end;

  JView_OnScrollChangeListenerClass = interface(IJavaClass)
    ['{8F912310-04BC-456A-9052-688E58708C2A}']
  end;

  [JavaSignature('android/view/View$OnScrollChangeListener')]
  JView_OnScrollChangeListener = interface(IJavaInstance)
    ['{4BA1BDA9-B55C-4E31-BEDE-93927B17DF63}']
    procedure onScrollChange(v: JView; scrollX: Integer; scrollY: Integer; oldScrollX: Integer; oldScrollY: Integer); cdecl;
  end;
  TJView_OnScrollChangeListener = class(TJavaGenericImport<JView_OnScrollChangeListenerClass, JView_OnScrollChangeListener>) end;

  JView_OnSystemUiVisibilityChangeListenerClass = interface(IJavaClass)
    ['{2C9D51FB-FF3B-4FCE-A737-88A2111FC420}']
  end;

  [JavaSignature('android/view/View$OnSystemUiVisibilityChangeListener')]
  JView_OnSystemUiVisibilityChangeListener = interface(IJavaInstance)
    ['{852870F3-99B1-4EF9-B1F8-6F2ED7749D45}']
    procedure onSystemUiVisibilityChange(visibility: Integer); cdecl;
  end;
  TJView_OnSystemUiVisibilityChangeListener = class(TJavaGenericImport<JView_OnSystemUiVisibilityChangeListenerClass, JView_OnSystemUiVisibilityChangeListener>) end;

  JView_OnTouchListenerClass = interface(IJavaClass)
    ['{C7C4B1E0-BBE6-464C-BF96-54DF9750D103}']
  end;

  [JavaSignature('android/view/View$OnTouchListener')]
  JView_OnTouchListener = interface(IJavaInstance)
    ['{CE4A1789-BAF5-4C37-9A87-54BF5842504B}']
    function onTouch(v: JView; event: JMotionEvent): Boolean; cdecl;
  end;
  TJView_OnTouchListener = class(TJavaGenericImport<JView_OnTouchListenerClass, JView_OnTouchListener>) end;

  JViewGroupClass = interface(JViewClass)
    ['{249ABD79-A894-4B68-A005-F798FC9D670F}']
    {class} function _GetFOCUS_AFTER_DESCENDANTS: Integer; cdecl;
    {class} function _GetFOCUS_BEFORE_DESCENDANTS: Integer; cdecl;
    {class} function _GetFOCUS_BLOCK_DESCENDANTS: Integer; cdecl;
    {class} function _GetLAYOUT_MODE_CLIP_BOUNDS: Integer; cdecl;
    {class} function _GetLAYOUT_MODE_OPTICAL_BOUNDS: Integer; cdecl;
    {class} function _GetPERSISTENT_ALL_CACHES: Integer; cdecl;
    {class} function _GetPERSISTENT_ANIMATION_CACHE: Integer; cdecl;
    {class} function _GetPERSISTENT_NO_CACHE: Integer; cdecl;
    {class} function _GetPERSISTENT_SCROLLING_CACHE: Integer; cdecl;
    {class} function init(context: JContext): JViewGroup; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JViewGroup; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JViewGroup; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JViewGroup; cdecl; overload;
    {class} function getChildMeasureSpec(spec: Integer; padding: Integer; childDimension: Integer): Integer; cdecl;
    {class} property FOCUS_AFTER_DESCENDANTS: Integer read _GetFOCUS_AFTER_DESCENDANTS;
    {class} property FOCUS_BEFORE_DESCENDANTS: Integer read _GetFOCUS_BEFORE_DESCENDANTS;
    {class} property FOCUS_BLOCK_DESCENDANTS: Integer read _GetFOCUS_BLOCK_DESCENDANTS;
    {class} property LAYOUT_MODE_CLIP_BOUNDS: Integer read _GetLAYOUT_MODE_CLIP_BOUNDS;
    {class} property LAYOUT_MODE_OPTICAL_BOUNDS: Integer read _GetLAYOUT_MODE_OPTICAL_BOUNDS;
    {class} property PERSISTENT_ALL_CACHES: Integer read _GetPERSISTENT_ALL_CACHES;
    {class} property PERSISTENT_ANIMATION_CACHE: Integer read _GetPERSISTENT_ANIMATION_CACHE;
    {class} property PERSISTENT_NO_CACHE: Integer read _GetPERSISTENT_NO_CACHE;
    {class} property PERSISTENT_SCROLLING_CACHE: Integer read _GetPERSISTENT_SCROLLING_CACHE;
  end;

  [JavaSignature('android/view/ViewGroup')]
  JViewGroup = interface(JView)
    ['{DA84626B-CF12-4552-9CD8-EA843FE6C878}']
    procedure addChildrenForAccessibility(outChildren: JArrayList); cdecl;
    procedure addFocusables(views: JArrayList; direction: Integer; focusableMode: Integer); cdecl;
    function addStatesFromChildren: Boolean; cdecl;
    procedure addTouchables(views: JArrayList); cdecl;
    procedure addView(child: JView); cdecl; overload;
    procedure addView(child: JView; index: Integer); cdecl; overload;
    procedure addView(child: JView; width: Integer; height: Integer); cdecl; overload;
    procedure addView(child: JView; params: JViewGroup_LayoutParams); cdecl; overload;
    procedure addView(child: JView; index: Integer; params: JViewGroup_LayoutParams); cdecl; overload;
    procedure bringChildToFront(child: JView); cdecl;
    procedure childDrawableStateChanged(child: JView); cdecl;
    procedure childHasTransientStateChanged(child: JView; childHasTransientState: Boolean); cdecl;
    procedure clearChildFocus(child: JView); cdecl;
    procedure clearDisappearingChildren; cdecl;
    procedure clearFocus; cdecl;
    function dispatchApplyWindowInsets(insets: JWindowInsets): JWindowInsets; cdecl;
    procedure dispatchConfigurationChanged(newConfig: JConfiguration); cdecl;
    procedure dispatchDisplayHint(hint: Integer); cdecl;
    function dispatchDragEvent(event: JDragEvent): Boolean; cdecl;
    procedure dispatchDrawableHotspotChanged(x: Single; y: Single); cdecl;
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function dispatchKeyEventPreIme(event: JKeyEvent): Boolean; cdecl;
    function dispatchKeyShortcutEvent(event: JKeyEvent): Boolean; cdecl;
    procedure dispatchProvideStructure(structure: JViewStructure); cdecl;
    procedure dispatchSetActivated(activated: Boolean); cdecl;
    procedure dispatchSetSelected(selected: Boolean); cdecl;
    procedure dispatchSystemUiVisibilityChanged(visible: Integer); cdecl;
    function dispatchTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    function dispatchTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    function dispatchUnhandledMove(focused: JView; direction: Integer): Boolean; cdecl;
    procedure dispatchWindowFocusChanged(hasFocus: Boolean); cdecl;
    procedure dispatchWindowSystemUiVisiblityChanged(visible: Integer); cdecl;
    procedure dispatchWindowVisibilityChanged(visibility: Integer); cdecl;
    procedure endViewTransition(view: JView); cdecl;
    function findFocus: JView; cdecl;
    procedure findViewsWithText(outViews: JArrayList; text: JCharSequence; flags: Integer); cdecl;
    function focusSearch(focused: JView; direction: Integer): JView; cdecl;
    procedure focusableViewAvailable(v: JView); cdecl;
    function gatherTransparentRegion(region: JRegion): Boolean; cdecl;
    function generateLayoutParams(attrs: JAttributeSet): JViewGroup_LayoutParams; cdecl;
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getChildAt(index: Integer): JView; cdecl;
    function getChildCount: Integer; cdecl;
    function getChildVisibleRect(child: JView; r: JRect; offset: JPoint): Boolean; cdecl;
    function getClipChildren: Boolean; cdecl;
    function getClipToPadding: Boolean; cdecl;
    function getDescendantFocusability: Integer; cdecl;
    function getFocusedChild: JView; cdecl;
    function getLayoutAnimation: JLayoutAnimationController; cdecl;
    function getLayoutAnimationListener: JAnimation_AnimationListener; cdecl;
    function getLayoutMode: Integer; cdecl;
    //function getLayoutTransition: JLayoutTransition; cdecl;
    function getNestedScrollAxes: Integer; cdecl;
    function getOverlay: JViewGroupOverlay; cdecl;
    function getPersistentDrawingCache: Integer; cdecl;
    function getTouchscreenBlocksFocus: Boolean; cdecl;
    function hasFocus: Boolean; cdecl;
    function hasFocusable: Boolean; cdecl;
    function hasTransientState: Boolean; cdecl;
    function indexOfChild(child: JView): Integer; cdecl;
    procedure invalidateChild(child: JView; dirty: JRect); cdecl;
    function invalidateChildInParent(location: TJavaArray<Integer>; dirty: JRect): JViewParent; cdecl;
    function isAlwaysDrawnWithCacheEnabled: Boolean; cdecl;//Deprecated
    function isAnimationCacheEnabled: Boolean; cdecl;//Deprecated
    function isMotionEventSplittingEnabled: Boolean; cdecl;
    function isTransitionGroup: Boolean; cdecl;
    procedure jumpDrawablesToCurrentState; cdecl;
    procedure layout(l: Integer; t: Integer; r: Integer; b: Integer); cdecl;
    procedure notifySubtreeAccessibilityStateChanged(child: JView; source: JView; changeType: Integer); cdecl;
    procedure offsetDescendantRectToMyCoords(descendant: JView; rect: JRect); cdecl;
    procedure offsetRectIntoDescendantCoords(descendant: JView; rect: JRect); cdecl;
    function onInterceptHoverEvent(event: JMotionEvent): Boolean; cdecl;
    function onInterceptTouchEvent(ev: JMotionEvent): Boolean; cdecl;
    function onNestedFling(target: JView; velocityX: Single; velocityY: Single; consumed: Boolean): Boolean; cdecl;
    function onNestedPreFling(target: JView; velocityX: Single; velocityY: Single): Boolean; cdecl;
    function onNestedPrePerformAccessibilityAction(target: JView; action: Integer; args: JBundle): Boolean; cdecl;
    procedure onNestedPreScroll(target: JView; dx: Integer; dy: Integer; consumed: TJavaArray<Integer>); cdecl;
    procedure onNestedScroll(target: JView; dxConsumed: Integer; dyConsumed: Integer; dxUnconsumed: Integer; dyUnconsumed: Integer); cdecl;
    procedure onNestedScrollAccepted(child: JView; target: JView; axes: Integer); cdecl;
    function onRequestSendAccessibilityEvent(child: JView; event: JAccessibilityEvent): Boolean; cdecl;
    function onStartNestedScroll(child: JView; target: JView; nestedScrollAxes: Integer): Boolean; cdecl;
    procedure onStopNestedScroll(child: JView); cdecl;
    procedure onViewAdded(child: JView); cdecl;
    procedure onViewRemoved(child: JView); cdecl;
    procedure recomputeViewAttributes(child: JView); cdecl;
    procedure removeAllViews; cdecl;
    procedure removeAllViewsInLayout; cdecl;
    procedure removeView(view: JView); cdecl;
    procedure removeViewAt(index: Integer); cdecl;
    procedure removeViewInLayout(view: JView); cdecl;
    procedure removeViews(start: Integer; count: Integer); cdecl;
    procedure removeViewsInLayout(start: Integer; count: Integer); cdecl;
    procedure requestChildFocus(child: JView; focused: JView); cdecl;
    function requestChildRectangleOnScreen(child: JView; rectangle: JRect; immediate: Boolean): Boolean; cdecl;
    procedure requestDisallowInterceptTouchEvent(disallowIntercept: Boolean); cdecl;
    function requestFocus(direction: Integer; previouslyFocusedRect: JRect): Boolean; cdecl;
    function requestSendAccessibilityEvent(child: JView; event: JAccessibilityEvent): Boolean; cdecl;
    procedure requestTransparentRegion(child: JView); cdecl;
    procedure scheduleLayoutAnimation; cdecl;
    procedure setAddStatesFromChildren(addsStates: Boolean); cdecl;
    procedure setAlwaysDrawnWithCacheEnabled(always: Boolean); cdecl;//Deprecated
    procedure setAnimationCacheEnabled(enabled: Boolean); cdecl;//Deprecated
    procedure setClipChildren(clipChildren: Boolean); cdecl;
    procedure setClipToPadding(clipToPadding: Boolean); cdecl;
    procedure setDescendantFocusability(focusability: Integer); cdecl;
    procedure setLayoutAnimation(controller: JLayoutAnimationController); cdecl;
    procedure setLayoutAnimationListener(animationListener: JAnimation_AnimationListener); cdecl;
    procedure setLayoutMode(layoutMode: Integer); cdecl;
    //procedure setLayoutTransition(transition: JLayoutTransition); cdecl;
    procedure setMotionEventSplittingEnabled(split: Boolean); cdecl;
    procedure setOnHierarchyChangeListener(listener: JViewGroup_OnHierarchyChangeListener); cdecl;
    procedure setPersistentDrawingCache(drawingCacheToKeep: Integer); cdecl;
    procedure setTouchscreenBlocksFocus(touchscreenBlocksFocus: Boolean); cdecl;
    procedure setTransitionGroup(isTransitionGroup: Boolean); cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;
    function showContextMenuForChild(originalView: JView): Boolean; cdecl;
    function startActionModeForChild(originalView: JView; callback: JActionMode_Callback): JActionMode; cdecl; overload;
    function startActionModeForChild(originalView: JView; callback: JActionMode_Callback; type_: Integer): JActionMode; cdecl; overload;
    procedure startLayoutAnimation; cdecl;
    procedure startViewTransition(view: JView); cdecl;
    procedure updateViewLayout(view: JView; params: JViewGroup_LayoutParams); cdecl;
  end;
  TJViewGroup = class(TJavaGenericImport<JViewGroupClass, JViewGroup>) end;

  JViewGroup_LayoutParamsClass = interface(JObjectClass)
    ['{D6F81CA0-279D-4335-8440-AFCDBF07CFC5}']
    {class} function _GetFILL_PARENT: Integer; cdecl;
    {class} function _GetMATCH_PARENT: Integer; cdecl;
    {class} function _GetWRAP_CONTENT: Integer; cdecl;
    {class} function init(c: JContext; attrs: JAttributeSet): JViewGroup_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer): JViewGroup_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_LayoutParams): JViewGroup_LayoutParams; cdecl; overload;
    {class} property FILL_PARENT: Integer read _GetFILL_PARENT;
    {class} property MATCH_PARENT: Integer read _GetMATCH_PARENT;
    {class} property WRAP_CONTENT: Integer read _GetWRAP_CONTENT;
  end;

  [JavaSignature('android/view/ViewGroup$LayoutParams')]
  JViewGroup_LayoutParams = interface(JObject)
    ['{81AC5483-A2B0-497B-9441-7866C9ACCBAC}']
    function _Getheight: Integer; cdecl;
    procedure _Setheight(Value: Integer); cdecl;
    function _GetlayoutAnimationParameters: JLayoutAnimationController_AnimationParameters; cdecl;
    procedure _SetlayoutAnimationParameters(Value: JLayoutAnimationController_AnimationParameters); cdecl;
    function _Getwidth: Integer; cdecl;
    procedure _Setwidth(Value: Integer); cdecl;
    procedure resolveLayoutDirection(layoutDirection: Integer); cdecl;
    property height: Integer read _Getheight write _Setheight;
    property layoutAnimationParameters: JLayoutAnimationController_AnimationParameters read _GetlayoutAnimationParameters write _SetlayoutAnimationParameters;
    property width: Integer read _Getwidth write _Setwidth;
  end;
  TJViewGroup_LayoutParams = class(TJavaGenericImport<JViewGroup_LayoutParamsClass, JViewGroup_LayoutParams>) end;

  JViewGroup_MarginLayoutParamsClass = interface(JViewGroup_LayoutParamsClass)
    ['{5BE0EE58-1162-4C87-BE61-BAB657F8557D}']
    {class} function init(c: JContext; attrs: JAttributeSet): JViewGroup_MarginLayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer): JViewGroup_MarginLayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_MarginLayoutParams): JViewGroup_MarginLayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_LayoutParams): JViewGroup_MarginLayoutParams; cdecl; overload;
  end;

  [JavaSignature('android/view/ViewGroup$MarginLayoutParams')]
  JViewGroup_MarginLayoutParams = interface(JViewGroup_LayoutParams)
    ['{ABE3DE12-48CD-4B1D-996E-6DE619E74BE4}']
    function _GetbottomMargin: Integer; cdecl;
    procedure _SetbottomMargin(Value: Integer); cdecl;
    function _GetleftMargin: Integer; cdecl;
    procedure _SetleftMargin(Value: Integer); cdecl;
    function _GetrightMargin: Integer; cdecl;
    procedure _SetrightMargin(Value: Integer); cdecl;
    function _GettopMargin: Integer; cdecl;
    procedure _SettopMargin(Value: Integer); cdecl;
    function getLayoutDirection: Integer; cdecl;
    function getMarginEnd: Integer; cdecl;
    function getMarginStart: Integer; cdecl;
    function isMarginRelative: Boolean; cdecl;
    procedure resolveLayoutDirection(layoutDirection: Integer); cdecl;
    procedure setLayoutDirection(layoutDirection: Integer); cdecl;
    procedure setMarginEnd(end_: Integer); cdecl;
    procedure setMarginStart(start: Integer); cdecl;
    procedure setMargins(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    property bottomMargin: Integer read _GetbottomMargin write _SetbottomMargin;
    property leftMargin: Integer read _GetleftMargin write _SetleftMargin;
    property rightMargin: Integer read _GetrightMargin write _SetrightMargin;
    property topMargin: Integer read _GettopMargin write _SettopMargin;
  end;
  TJViewGroup_MarginLayoutParams = class(TJavaGenericImport<JViewGroup_MarginLayoutParamsClass, JViewGroup_MarginLayoutParams>) end;

  JViewGroup_OnHierarchyChangeListenerClass = interface(IJavaClass)
    ['{D41768BD-020D-4CDE-B0EC-D21B49128F1E}']
  end;

  [JavaSignature('android/view/ViewGroup$OnHierarchyChangeListener')]
  JViewGroup_OnHierarchyChangeListener = interface(IJavaInstance)
    ['{0844FBF9-D751-4DB6-994B-FF5A30264A07}']
    procedure onChildViewAdded(parent: JView; child: JView); cdecl;
    procedure onChildViewRemoved(parent: JView; child: JView); cdecl;
  end;
  TJViewGroup_OnHierarchyChangeListener = class(TJavaGenericImport<JViewGroup_OnHierarchyChangeListenerClass, JViewGroup_OnHierarchyChangeListener>) end;

  JViewOverlayClass = interface(JObjectClass)
    ['{4471E7A0-ED45-40E1-BC6E-EE23B03138EB}']
  end;

  [JavaSignature('android/view/ViewOverlay')]
  JViewOverlay = interface(JObject)
    ['{BFFF11FF-F146-4FDC-AF20-BE7777E9DBBA}']
    procedure add(drawable: JDrawable); cdecl;
    procedure clear; cdecl;
    procedure remove(drawable: JDrawable); cdecl;
  end;
  TJViewOverlay = class(TJavaGenericImport<JViewOverlayClass, JViewOverlay>) end;

  JViewGroupOverlayClass = interface(JViewOverlayClass)
    ['{BA488AC6-745C-42AD-9A98-6F5562D787DD}']
  end;

  [JavaSignature('android/view/ViewGroupOverlay')]
  JViewGroupOverlay = interface(JViewOverlay)
    ['{913B0A25-9FEC-4C1F-807D-5D2D9BF6ABD6}']
    procedure add(view: JView); cdecl;
    procedure remove(view: JView); cdecl;
  end;
  TJViewGroupOverlay = class(TJavaGenericImport<JViewGroupOverlayClass, JViewGroupOverlay>) end;

  JViewManagerClass = interface(IJavaClass)
    ['{1E5DFC6A-2F4C-4D78-8556-F1D28EE0F0A4}']
  end;

  [JavaSignature('android/view/ViewManager')]
  JViewManager = interface(IJavaInstance)
    ['{8A913606-3A14-4346-A93B-4F6FF646A0F8}']
    procedure addView(view: JView; params: JViewGroup_LayoutParams); cdecl;
    procedure removeView(view: JView); cdecl;
    procedure updateViewLayout(view: JView; params: JViewGroup_LayoutParams); cdecl;
  end;
  TJViewManager = class(TJavaGenericImport<JViewManagerClass, JViewManager>) end;

  JViewOutlineProviderClass = interface(JObjectClass)
    ['{B4BE5A5F-CBE7-4021-A8DC-4B788A67ECB6}']
    {class} function _GetBACKGROUND: JViewOutlineProvider; cdecl;
    {class} function _GetBOUNDS: JViewOutlineProvider; cdecl;
    {class} function _GetPADDED_BOUNDS: JViewOutlineProvider; cdecl;
    {class} function init: JViewOutlineProvider; cdecl;
    {class} property BACKGROUND: JViewOutlineProvider read _GetBACKGROUND;
    {class} property BOUNDS: JViewOutlineProvider read _GetBOUNDS;
    {class} property PADDED_BOUNDS: JViewOutlineProvider read _GetPADDED_BOUNDS;
  end;

  [JavaSignature('android/view/ViewOutlineProvider')]
  JViewOutlineProvider = interface(JObject)
    ['{D3AEA225-8DA4-42DE-8CDE-9E7E91F37CF6}']
    procedure getOutline(view: JView; outline: JOutline); cdecl;
  end;
  TJViewOutlineProvider = class(TJavaGenericImport<JViewOutlineProviderClass, JViewOutlineProvider>) end;

  JViewParentClass = interface(IJavaClass)
    ['{A91CFAFD-3CE9-4096-9EE7-00EC7828023D}']
  end;

  [JavaSignature('android/view/ViewParent')]
  JViewParent = interface(IJavaInstance)
    ['{910F6769-C189-4CF1-90B6-6FD45516718D}']
    procedure bringChildToFront(child: JView); cdecl;
    function canResolveLayoutDirection: Boolean; cdecl;
    function canResolveTextAlignment: Boolean; cdecl;
    function canResolveTextDirection: Boolean; cdecl;
    procedure childDrawableStateChanged(child: JView); cdecl;
    procedure childHasTransientStateChanged(child: JView; hasTransientState: Boolean); cdecl;
    procedure clearChildFocus(child: JView); cdecl;
    procedure createContextMenu(menu: JContextMenu); cdecl;
    function focusSearch(v: JView; direction: Integer): JView; cdecl;
    procedure focusableViewAvailable(v: JView); cdecl;
    function getChildVisibleRect(child: JView; r: JRect; offset: JPoint): Boolean; cdecl;
    function getLayoutDirection: Integer; cdecl;
    function getParent: JViewParent; cdecl;
    function getParentForAccessibility: JViewParent; cdecl;
    function getTextAlignment: Integer; cdecl;
    function getTextDirection: Integer; cdecl;
    procedure invalidateChild(child: JView; r: JRect); cdecl;
    function invalidateChildInParent(location: TJavaArray<Integer>; r: JRect): JViewParent; cdecl;
    function isLayoutDirectionResolved: Boolean; cdecl;
    function isLayoutRequested: Boolean; cdecl;
    function isTextAlignmentResolved: Boolean; cdecl;
    function isTextDirectionResolved: Boolean; cdecl;
    procedure notifySubtreeAccessibilityStateChanged(child: JView; source: JView; changeType: Integer); cdecl;
    function onNestedFling(target: JView; velocityX: Single; velocityY: Single; consumed: Boolean): Boolean; cdecl;
    function onNestedPreFling(target: JView; velocityX: Single; velocityY: Single): Boolean; cdecl;
    function onNestedPrePerformAccessibilityAction(target: JView; action: Integer; arguments: JBundle): Boolean; cdecl;
    procedure onNestedPreScroll(target: JView; dx: Integer; dy: Integer; consumed: TJavaArray<Integer>); cdecl;
    procedure onNestedScroll(target: JView; dxConsumed: Integer; dyConsumed: Integer; dxUnconsumed: Integer; dyUnconsumed: Integer); cdecl;
    procedure onNestedScrollAccepted(child: JView; target: JView; nestedScrollAxes: Integer); cdecl;
    function onStartNestedScroll(child: JView; target: JView; nestedScrollAxes: Integer): Boolean; cdecl;
    procedure onStopNestedScroll(target: JView); cdecl;
    procedure recomputeViewAttributes(child: JView); cdecl;
    procedure requestChildFocus(child: JView; focused: JView); cdecl;
    function requestChildRectangleOnScreen(child: JView; rectangle: JRect; immediate: Boolean): Boolean; cdecl;
    procedure requestDisallowInterceptTouchEvent(disallowIntercept: Boolean); cdecl;
    procedure requestFitSystemWindows; cdecl;
    procedure requestLayout; cdecl;
    function requestSendAccessibilityEvent(child: JView; event: JAccessibilityEvent): Boolean; cdecl;
    procedure requestTransparentRegion(child: JView); cdecl;
    function showContextMenuForChild(originalView: JView): Boolean; cdecl;
    function startActionModeForChild(originalView: JView; callback: JActionMode_Callback): JActionMode; cdecl; overload;
    function startActionModeForChild(originalView: JView; callback: JActionMode_Callback; type_: Integer): JActionMode; cdecl; overload;
  end;
  TJViewParent = class(TJavaGenericImport<JViewParentClass, JViewParent>) end;

  JViewPropertyAnimatorClass = interface(JObjectClass)
    ['{66D7DA64-ED33-4831-9C30-02F8C0D2ABA7}']
  end;

  [JavaSignature('android/view/ViewPropertyAnimator')]
  JViewPropertyAnimator = interface(JObject)
    ['{5766E8F5-FDF6-490F-9544-8238274F7EAA}']
    function alpha(value: Single): JViewPropertyAnimator; cdecl;
    function alphaBy(value: Single): JViewPropertyAnimator; cdecl;
    procedure cancel; cdecl;
    function getDuration: Int64; cdecl;
    //function getInterpolator: JTimeInterpolator; cdecl;
    function getStartDelay: Int64; cdecl;
    function rotation(value: Single): JViewPropertyAnimator; cdecl;
    function rotationBy(value: Single): JViewPropertyAnimator; cdecl;
    function rotationX(value: Single): JViewPropertyAnimator; cdecl;
    function rotationXBy(value: Single): JViewPropertyAnimator; cdecl;
    function rotationY(value: Single): JViewPropertyAnimator; cdecl;
    function rotationYBy(value: Single): JViewPropertyAnimator; cdecl;
    function scaleX(value: Single): JViewPropertyAnimator; cdecl;
    function scaleXBy(value: Single): JViewPropertyAnimator; cdecl;
    function scaleY(value: Single): JViewPropertyAnimator; cdecl;
    function scaleYBy(value: Single): JViewPropertyAnimator; cdecl;
    function setDuration(duration: Int64): JViewPropertyAnimator; cdecl;
    //function setInterpolator(interpolator: JTimeInterpolator): JViewPropertyAnimator; cdecl;
    //function setListener(listener: JAnimator_AnimatorListener): JViewPropertyAnimator; cdecl;
    function setStartDelay(startDelay: Int64): JViewPropertyAnimator; cdecl;
    //function setUpdateListener(listener: JValueAnimator_AnimatorUpdateListener): JViewPropertyAnimator; cdecl;
    procedure start; cdecl;
    function translationX(value: Single): JViewPropertyAnimator; cdecl;
    function translationXBy(value: Single): JViewPropertyAnimator; cdecl;
    function translationY(value: Single): JViewPropertyAnimator; cdecl;
    function translationYBy(value: Single): JViewPropertyAnimator; cdecl;
    function translationZ(value: Single): JViewPropertyAnimator; cdecl;
    function translationZBy(value: Single): JViewPropertyAnimator; cdecl;
    function withEndAction(runnable: JRunnable): JViewPropertyAnimator; cdecl;
    function withLayer: JViewPropertyAnimator; cdecl;
    function withStartAction(runnable: JRunnable): JViewPropertyAnimator; cdecl;
    function x(value: Single): JViewPropertyAnimator; cdecl;
    function xBy(value: Single): JViewPropertyAnimator; cdecl;
    function y(value: Single): JViewPropertyAnimator; cdecl;
    function yBy(value: Single): JViewPropertyAnimator; cdecl;
    function z(value: Single): JViewPropertyAnimator; cdecl;
    function zBy(value: Single): JViewPropertyAnimator; cdecl;
  end;
  TJViewPropertyAnimator = class(TJavaGenericImport<JViewPropertyAnimatorClass, JViewPropertyAnimator>) end;

  JViewStructureClass = interface(JObjectClass)
    ['{E05BF62A-530B-4B83-9822-C34CF3912DBF}']
    {class} function init: JViewStructure; cdecl;
  end;

  [JavaSignature('android/view/ViewStructure')]
  JViewStructure = interface(JObject)
    ['{A25054E9-8C54-4444-941D-FA7A00B2942F}']
    function addChildCount(num: Integer): Integer; cdecl;
    procedure asyncCommit; cdecl;
    function asyncNewChild(index: Integer): JViewStructure; cdecl;
    function getChildCount: Integer; cdecl;
    function getExtras: JBundle; cdecl;
    function getHint: JCharSequence; cdecl;
    function getText: JCharSequence; cdecl;
    function getTextSelectionEnd: Integer; cdecl;
    function getTextSelectionStart: Integer; cdecl;
    function hasExtras: Boolean; cdecl;
    function newChild(index: Integer): JViewStructure; cdecl;
    procedure setAccessibilityFocused(state: Boolean); cdecl;
    procedure setActivated(state: Boolean); cdecl;
    procedure setAlpha(alpha: Single); cdecl;
    procedure setCheckable(state: Boolean); cdecl;
    procedure setChecked(state: Boolean); cdecl;
    procedure setChildCount(num: Integer); cdecl;
    procedure setClassName(className: JString); cdecl;
    procedure setClickable(state: Boolean); cdecl;
    procedure setContentDescription(contentDescription: JCharSequence); cdecl;
    procedure setContextClickable(state: Boolean); cdecl;
    procedure setDimens(left: Integer; top: Integer; scrollX: Integer; scrollY: Integer; width: Integer; height: Integer); cdecl;
    procedure setElevation(elevation: Single); cdecl;
    procedure setEnabled(state: Boolean); cdecl;
    procedure setFocusable(state: Boolean); cdecl;
    procedure setFocused(state: Boolean); cdecl;
    procedure setHint(hint: JCharSequence); cdecl;
    procedure setId(id: Integer; packageName: JString; typeName: JString; entryName: JString); cdecl;
    procedure setLongClickable(state: Boolean); cdecl;
    procedure setSelected(state: Boolean); cdecl;
    procedure setText(text: JCharSequence); cdecl; overload;
    procedure setText(text: JCharSequence; selectionStart: Integer; selectionEnd: Integer); cdecl; overload;
    procedure setTextLines(charOffsets: TJavaArray<Integer>; baselines: TJavaArray<Integer>); cdecl;
    procedure setTextStyle(size: Single; fgColor: Integer; bgColor: Integer; style: Integer); cdecl;
    procedure setTransformation(matrix: JMatrix); cdecl;
    procedure setVisibility(visibility: Integer); cdecl;
  end;
  TJViewStructure = class(TJavaGenericImport<JViewStructureClass, JViewStructure>) end;

  JViewTreeObserverClass = interface(JObjectClass)
    ['{8221B758-DDD2-423B-8A5F-4E4C641AA1C2}']
  end;

  [JavaSignature('android/view/ViewTreeObserver')]
  JViewTreeObserver = interface(JObject)
    ['{970260A4-CEA0-498B-93FD-426F280764AA}']
    procedure addOnDrawListener(listener: JViewTreeObserver_OnDrawListener); cdecl;
    procedure addOnGlobalFocusChangeListener(listener: JViewTreeObserver_OnGlobalFocusChangeListener); cdecl;
    procedure addOnGlobalLayoutListener(listener: JViewTreeObserver_OnGlobalLayoutListener); cdecl;
    procedure addOnPreDrawListener(listener: JViewTreeObserver_OnPreDrawListener); cdecl;
    procedure addOnScrollChangedListener(listener: JViewTreeObserver_OnScrollChangedListener); cdecl;
    procedure addOnTouchModeChangeListener(listener: JViewTreeObserver_OnTouchModeChangeListener); cdecl;
    procedure addOnWindowAttachListener(listener: JViewTreeObserver_OnWindowAttachListener); cdecl;
    procedure addOnWindowFocusChangeListener(listener: JViewTreeObserver_OnWindowFocusChangeListener); cdecl;
    procedure dispatchOnDraw; cdecl;
    procedure dispatchOnGlobalLayout; cdecl;
    function dispatchOnPreDraw: Boolean; cdecl;
    function isAlive: Boolean; cdecl;
    procedure removeGlobalOnLayoutListener(victim: JViewTreeObserver_OnGlobalLayoutListener); cdecl;//Deprecated
    procedure removeOnDrawListener(victim: JViewTreeObserver_OnDrawListener); cdecl;
    procedure removeOnGlobalFocusChangeListener(victim: JViewTreeObserver_OnGlobalFocusChangeListener); cdecl;
    procedure removeOnGlobalLayoutListener(victim: JViewTreeObserver_OnGlobalLayoutListener); cdecl;
    procedure removeOnPreDrawListener(victim: JViewTreeObserver_OnPreDrawListener); cdecl;
    procedure removeOnScrollChangedListener(victim: JViewTreeObserver_OnScrollChangedListener); cdecl;
    procedure removeOnTouchModeChangeListener(victim: JViewTreeObserver_OnTouchModeChangeListener); cdecl;
    procedure removeOnWindowAttachListener(victim: JViewTreeObserver_OnWindowAttachListener); cdecl;
    procedure removeOnWindowFocusChangeListener(victim: JViewTreeObserver_OnWindowFocusChangeListener); cdecl;
  end;
  TJViewTreeObserver = class(TJavaGenericImport<JViewTreeObserverClass, JViewTreeObserver>) end;

  JViewTreeObserver_OnDrawListenerClass = interface(IJavaClass)
    ['{77519968-B2FC-485D-A508-0BA6B6EB04EB}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnDrawListener')]
  JViewTreeObserver_OnDrawListener = interface(IJavaInstance)
    ['{D7DD6757-C930-4347-896B-49771A88B68C}']
    procedure onDraw; cdecl;
  end;
  TJViewTreeObserver_OnDrawListener = class(TJavaGenericImport<JViewTreeObserver_OnDrawListenerClass, JViewTreeObserver_OnDrawListener>) end;

  JViewTreeObserver_OnGlobalFocusChangeListenerClass = interface(IJavaClass)
    ['{0A2FBF59-F932-4639-844E-1B27BA4C7DE3}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnGlobalFocusChangeListener')]
  JViewTreeObserver_OnGlobalFocusChangeListener = interface(IJavaInstance)
    ['{003C4EF4-A75A-4B41-8D70-053F31AD13E3}']
    procedure onGlobalFocusChanged(oldFocus: JView; newFocus: JView); cdecl;
  end;
  TJViewTreeObserver_OnGlobalFocusChangeListener = class(TJavaGenericImport<JViewTreeObserver_OnGlobalFocusChangeListenerClass, JViewTreeObserver_OnGlobalFocusChangeListener>) end;

  JViewTreeObserver_OnGlobalLayoutListenerClass = interface(IJavaClass)
    ['{FCAAD8E4-B4C8-4FEE-BEED-3F3668AE33E7}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnGlobalLayoutListener')]
  JViewTreeObserver_OnGlobalLayoutListener = interface(IJavaInstance)
    ['{BF64D09F-8760-4651-AB66-675EEF7D73C4}']
    procedure onGlobalLayout; cdecl;
  end;
  TJViewTreeObserver_OnGlobalLayoutListener = class(TJavaGenericImport<JViewTreeObserver_OnGlobalLayoutListenerClass, JViewTreeObserver_OnGlobalLayoutListener>) end;

  JViewTreeObserver_OnPreDrawListenerClass = interface(IJavaClass)
    ['{7C6C84FC-8B94-4BAF-8A45-719D67BF6156}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnPreDrawListener')]
  JViewTreeObserver_OnPreDrawListener = interface(IJavaInstance)
    ['{D9958504-8A29-450B-AF99-9711FE18D731}']
    function onPreDraw: Boolean; cdecl;
  end;
  TJViewTreeObserver_OnPreDrawListener = class(TJavaGenericImport<JViewTreeObserver_OnPreDrawListenerClass, JViewTreeObserver_OnPreDrawListener>) end;

  JViewTreeObserver_OnScrollChangedListenerClass = interface(IJavaClass)
    ['{47F7F111-5E81-4E3C-9DEF-5EB15E1338D7}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnScrollChangedListener')]
  JViewTreeObserver_OnScrollChangedListener = interface(IJavaInstance)
    ['{61DC96EE-2F56-4621-BA41-48FE4C367744}']
    procedure onScrollChanged; cdecl;
  end;
  TJViewTreeObserver_OnScrollChangedListener = class(TJavaGenericImport<JViewTreeObserver_OnScrollChangedListenerClass, JViewTreeObserver_OnScrollChangedListener>) end;

  JViewTreeObserver_OnTouchModeChangeListenerClass = interface(IJavaClass)
    ['{343F033E-028A-4613-AF32-92B5F78C7D0A}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnTouchModeChangeListener')]
  JViewTreeObserver_OnTouchModeChangeListener = interface(IJavaInstance)
    ['{6C910F27-8837-49F4-86F4-7AFC7AA5BED1}']
    procedure onTouchModeChanged(isInTouchMode: Boolean); cdecl;
  end;
  TJViewTreeObserver_OnTouchModeChangeListener = class(TJavaGenericImport<JViewTreeObserver_OnTouchModeChangeListenerClass, JViewTreeObserver_OnTouchModeChangeListener>) end;

  JViewTreeObserver_OnWindowAttachListenerClass = interface(IJavaClass)
    ['{A758E48B-B74B-40CC-95F3-50924510593A}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnWindowAttachListener')]
  JViewTreeObserver_OnWindowAttachListener = interface(IJavaInstance)
    ['{362525DC-82D6-4055-AFAA-A94C051E2052}']
    procedure onWindowAttached; cdecl;
    procedure onWindowDetached; cdecl;
  end;
  TJViewTreeObserver_OnWindowAttachListener = class(TJavaGenericImport<JViewTreeObserver_OnWindowAttachListenerClass, JViewTreeObserver_OnWindowAttachListener>) end;

  JViewTreeObserver_OnWindowFocusChangeListenerClass = interface(IJavaClass)
    ['{E4E3EE70-E290-4054-BCE8-43DF6E969E26}']
  end;

  [JavaSignature('android/view/ViewTreeObserver$OnWindowFocusChangeListener')]
  JViewTreeObserver_OnWindowFocusChangeListener = interface(IJavaInstance)
    ['{3534870C-E8BF-47B8-961B-CF919EECB35D}']
    procedure onWindowFocusChanged(hasFocus: Boolean); cdecl;
  end;
  TJViewTreeObserver_OnWindowFocusChangeListener = class(TJavaGenericImport<JViewTreeObserver_OnWindowFocusChangeListenerClass, JViewTreeObserver_OnWindowFocusChangeListener>) end;

  JWindowClass = interface(JObjectClass)
    ['{C2183A64-1ACD-4D95-8E51-7063E03D9E71}']
    {class} function _GetFEATURE_ACTION_BAR: Integer; cdecl;
    {class} function _GetFEATURE_ACTION_BAR_OVERLAY: Integer; cdecl;
    {class} function _GetFEATURE_ACTION_MODE_OVERLAY: Integer; cdecl;
    {class} function _GetFEATURE_ACTIVITY_TRANSITIONS: Integer; cdecl;
    {class} function _GetFEATURE_CONTENT_TRANSITIONS: Integer; cdecl;
    {class} function _GetFEATURE_CONTEXT_MENU: Integer; cdecl;
    {class} function _GetFEATURE_CUSTOM_TITLE: Integer; cdecl;
    {class} function _GetFEATURE_INDETERMINATE_PROGRESS: Integer; cdecl;
    {class} function _GetFEATURE_LEFT_ICON: Integer; cdecl;
    {class} function _GetFEATURE_NO_TITLE: Integer; cdecl;
    {class} function _GetFEATURE_OPTIONS_PANEL: Integer; cdecl;
    {class} function _GetFEATURE_PROGRESS: Integer; cdecl;
    {class} function _GetFEATURE_RIGHT_ICON: Integer; cdecl;
    {class} function _GetFEATURE_SWIPE_TO_DISMISS: Integer; cdecl;
    {class} function _GetID_ANDROID_CONTENT: Integer; cdecl;
    {class} function _GetNAVIGATION_BAR_BACKGROUND_TRANSITION_NAME: JString; cdecl;
    {class} function _GetPROGRESS_END: Integer; cdecl;
    {class} function _GetPROGRESS_INDETERMINATE_OFF: Integer; cdecl;
    {class} function _GetPROGRESS_INDETERMINATE_ON: Integer; cdecl;
    {class} function _GetPROGRESS_SECONDARY_END: Integer; cdecl;
    {class} function _GetPROGRESS_SECONDARY_START: Integer; cdecl;
    {class} function _GetPROGRESS_START: Integer; cdecl;
    {class} function _GetPROGRESS_VISIBILITY_OFF: Integer; cdecl;
    {class} function _GetPROGRESS_VISIBILITY_ON: Integer; cdecl;
    {class} function _GetSTATUS_BAR_BACKGROUND_TRANSITION_NAME: JString; cdecl;
    {class} function init(context: JContext): JWindow; cdecl;
    {class} function getDefaultFeatures(context: JContext): Integer; cdecl;
    {class} property FEATURE_ACTION_BAR: Integer read _GetFEATURE_ACTION_BAR;
    {class} property FEATURE_ACTION_BAR_OVERLAY: Integer read _GetFEATURE_ACTION_BAR_OVERLAY;
    {class} property FEATURE_ACTION_MODE_OVERLAY: Integer read _GetFEATURE_ACTION_MODE_OVERLAY;
    {class} property FEATURE_ACTIVITY_TRANSITIONS: Integer read _GetFEATURE_ACTIVITY_TRANSITIONS;
    {class} property FEATURE_CONTENT_TRANSITIONS: Integer read _GetFEATURE_CONTENT_TRANSITIONS;
    {class} property FEATURE_CONTEXT_MENU: Integer read _GetFEATURE_CONTEXT_MENU;
    {class} property FEATURE_CUSTOM_TITLE: Integer read _GetFEATURE_CUSTOM_TITLE;
    {class} property FEATURE_INDETERMINATE_PROGRESS: Integer read _GetFEATURE_INDETERMINATE_PROGRESS;
    {class} property FEATURE_LEFT_ICON: Integer read _GetFEATURE_LEFT_ICON;
    {class} property FEATURE_NO_TITLE: Integer read _GetFEATURE_NO_TITLE;
    {class} property FEATURE_OPTIONS_PANEL: Integer read _GetFEATURE_OPTIONS_PANEL;
    {class} property FEATURE_PROGRESS: Integer read _GetFEATURE_PROGRESS;
    {class} property FEATURE_RIGHT_ICON: Integer read _GetFEATURE_RIGHT_ICON;
    {class} property FEATURE_SWIPE_TO_DISMISS: Integer read _GetFEATURE_SWIPE_TO_DISMISS;
    {class} property ID_ANDROID_CONTENT: Integer read _GetID_ANDROID_CONTENT;
    {class} property NAVIGATION_BAR_BACKGROUND_TRANSITION_NAME: JString read _GetNAVIGATION_BAR_BACKGROUND_TRANSITION_NAME;
    {class} property PROGRESS_END: Integer read _GetPROGRESS_END;
    {class} property PROGRESS_INDETERMINATE_OFF: Integer read _GetPROGRESS_INDETERMINATE_OFF;
    {class} property PROGRESS_INDETERMINATE_ON: Integer read _GetPROGRESS_INDETERMINATE_ON;
    {class} property PROGRESS_SECONDARY_END: Integer read _GetPROGRESS_SECONDARY_END;
    {class} property PROGRESS_SECONDARY_START: Integer read _GetPROGRESS_SECONDARY_START;
    {class} property PROGRESS_START: Integer read _GetPROGRESS_START;
    {class} property PROGRESS_VISIBILITY_OFF: Integer read _GetPROGRESS_VISIBILITY_OFF;
    {class} property PROGRESS_VISIBILITY_ON: Integer read _GetPROGRESS_VISIBILITY_ON;
    {class} property STATUS_BAR_BACKGROUND_TRANSITION_NAME: JString read _GetSTATUS_BAR_BACKGROUND_TRANSITION_NAME;
  end;

  [JavaSignature('android/view/Window')]
  JWindow = interface(JObject)
    ['{A9AC44DA-219C-41C4-AD29-88B01254819E}']
    procedure addContentView(view: JView; params: JViewGroup_LayoutParams); cdecl;
    procedure addFlags(flags: Integer); cdecl;
    procedure clearFlags(flags: Integer); cdecl;
    procedure closeAllPanels; cdecl;
    procedure closePanel(featureId: Integer); cdecl;
    function findViewById(id: Integer): JView; cdecl;
    function getAllowEnterTransitionOverlap: Boolean; cdecl;
    function getAllowReturnTransitionOverlap: Boolean; cdecl;
    function getAttributes: JWindowManager_LayoutParams; cdecl;
    function getCallback: JWindow_Callback; cdecl;
    function getContainer: JWindow; cdecl;
    //function getContentScene: JScene; cdecl;
    function getContext: JContext; cdecl;
    function getCurrentFocus: JView; cdecl;
    function getDecorView: JView; cdecl;
    //function getEnterTransition: JTransition; cdecl;
    //function getExitTransition: JTransition; cdecl;
    function getLayoutInflater: JLayoutInflater; cdecl;
    //function getMediaController: Jsession_MediaController; cdecl;
    function getNavigationBarColor: Integer; cdecl;
    //function getReenterTransition: JTransition; cdecl;
    //function getReturnTransition: JTransition; cdecl;
    //function getSharedElementEnterTransition: JTransition; cdecl;
    //function getSharedElementExitTransition: JTransition; cdecl;
    //function getSharedElementReenterTransition: JTransition; cdecl;
    //function getSharedElementReturnTransition: JTransition; cdecl;
    function getSharedElementsUseOverlay: Boolean; cdecl;
    function getStatusBarColor: Integer; cdecl;
    function getTransitionBackgroundFadeDuration: Int64; cdecl;
    //function getTransitionManager: JTransitionManager; cdecl;
    function getVolumeControlStream: Integer; cdecl;
    function getWindowManager: JWindowManager; cdecl;
    function getWindowStyle: JTypedArray; cdecl;
    function hasChildren: Boolean; cdecl;
    function hasFeature(feature: Integer): Boolean; cdecl;
    procedure injectInputEvent(event: JInputEvent); cdecl;
    procedure invalidatePanelMenu(featureId: Integer); cdecl;
    function isActive: Boolean; cdecl;
    function isFloating: Boolean; cdecl;
    function isShortcutKey(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    procedure makeActive; cdecl;
    procedure onConfigurationChanged(newConfig: JConfiguration); cdecl;
    procedure openPanel(featureId: Integer; event: JKeyEvent); cdecl;
    function peekDecorView: JView; cdecl;
    function performContextMenuIdentifierAction(id: Integer; flags: Integer): Boolean; cdecl;
    function performPanelIdentifierAction(featureId: Integer; id: Integer; flags: Integer): Boolean; cdecl;
    function performPanelShortcut(featureId: Integer; keyCode: Integer; event: JKeyEvent; flags: Integer): Boolean; cdecl;
    function requestFeature(featureId: Integer): Boolean; cdecl;
    procedure restoreHierarchyState(savedInstanceState: JBundle); cdecl;
    function saveHierarchyState: JBundle; cdecl;
    procedure setAllowEnterTransitionOverlap(allow: Boolean); cdecl;
    procedure setAllowReturnTransitionOverlap(allow: Boolean); cdecl;
    procedure setAttributes(a: JWindowManager_LayoutParams); cdecl;
    procedure setBackgroundDrawable(drawable: JDrawable); cdecl;
    procedure setBackgroundDrawableResource(resId: Integer); cdecl;
    procedure setCallback(callback: JWindow_Callback); cdecl;
    procedure setChildDrawable(featureId: Integer; drawable: JDrawable); cdecl;
    procedure setChildInt(featureId: Integer; value: Integer); cdecl;
    procedure setClipToOutline(clipToOutline: Boolean); cdecl;
    procedure setContainer(container: JWindow); cdecl;
    procedure setContentView(layoutResID: Integer); cdecl; overload;
    procedure setContentView(view: JView); cdecl; overload;
    procedure setContentView(view: JView; params: JViewGroup_LayoutParams); cdecl; overload;
    procedure setDimAmount(amount: Single); cdecl;
    procedure setElevation(elevation: Single); cdecl;
    //procedure setEnterTransition(transition: JTransition); cdecl;
    //procedure setExitTransition(transition: JTransition); cdecl;
    procedure setFeatureDrawable(featureId: Integer; drawable: JDrawable); cdecl;
    procedure setFeatureDrawableAlpha(featureId: Integer; alpha: Integer); cdecl;
    procedure setFeatureDrawableResource(featureId: Integer; resId: Integer); cdecl;
    procedure setFeatureDrawableUri(featureId: Integer; uri: Jnet_Uri); cdecl;
    procedure setFeatureInt(featureId: Integer; value: Integer); cdecl;
    procedure setFlags(flags: Integer; mask: Integer); cdecl;
    procedure setFormat(format: Integer); cdecl;
    procedure setGravity(gravity: Integer); cdecl;
    procedure setIcon(resId: Integer); cdecl;
    procedure setLayout(width: Integer; height: Integer); cdecl;
    procedure setLocalFocus(hasFocus: Boolean; inTouchMode: Boolean); cdecl;
    procedure setLogo(resId: Integer); cdecl;
    //procedure setMediaController(controller: Jsession_MediaController); cdecl;
    procedure setNavigationBarColor(color: Integer); cdecl;
    //procedure setReenterTransition(transition: JTransition); cdecl;
    //procedure setReturnTransition(transition: JTransition); cdecl;
    //procedure setSharedElementEnterTransition(transition: JTransition); cdecl;
    //procedure setSharedElementExitTransition(transition: JTransition); cdecl;
    //procedure setSharedElementReenterTransition(transition: JTransition); cdecl;
    //procedure setSharedElementReturnTransition(transition: JTransition); cdecl;
    procedure setSharedElementsUseOverlay(sharedElementsUseOverlay: Boolean); cdecl;
    procedure setSoftInputMode(mode: Integer); cdecl;
    procedure setStatusBarColor(color: Integer); cdecl;
    procedure setTitle(title: JCharSequence); cdecl;
    procedure setTitleColor(textColor: Integer); cdecl;//Deprecated
    procedure setTransitionBackgroundFadeDuration(fadeDurationMillis: Int64); cdecl;
    //procedure setTransitionManager(tm: JTransitionManager); cdecl;
    procedure setType(type_: Integer); cdecl;
    procedure setUiOptions(uiOptions: Integer); cdecl; overload;
    procedure setUiOptions(uiOptions: Integer; mask: Integer); cdecl; overload;
    procedure setVolumeControlStream(streamType: Integer); cdecl;
    procedure setWindowAnimations(resId: Integer); cdecl;
    procedure setWindowManager(wm: JWindowManager; appToken: JIBinder; appName: JString); cdecl; overload;
    procedure setWindowManager(wm: JWindowManager; appToken: JIBinder; appName: JString; hardwareAccelerated: Boolean); cdecl; overload;
    function superDispatchGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    function superDispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function superDispatchKeyShortcutEvent(event: JKeyEvent): Boolean; cdecl;
    function superDispatchTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function superDispatchTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    procedure takeInputQueue(callback: JInputQueue_Callback); cdecl;
    procedure takeKeyEvents(get_: Boolean); cdecl;
    procedure takeSurface(callback: JSurfaceHolder_Callback2); cdecl;
    procedure togglePanel(featureId: Integer; event: JKeyEvent); cdecl;
  end;
  TJWindow = class(TJavaGenericImport<JWindowClass, JWindow>) end;

  JWindow_CallbackClass = interface(IJavaClass)
    ['{772DBA67-C77A-4EBE-9D06-7E6E737CDC41}']
  end;

  [JavaSignature('android/view/Window$Callback')]
  JWindow_Callback = interface(IJavaInstance)
    ['{0ABD51F1-DC48-4EE0-9459-7EC39345F8BA}']
    function dispatchGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function dispatchKeyShortcutEvent(event: JKeyEvent): Boolean; cdecl;
    function dispatchPopulateAccessibilityEvent(event: JAccessibilityEvent): Boolean; cdecl;
    function dispatchTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function dispatchTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onActionModeFinished(mode: JActionMode); cdecl;
    procedure onActionModeStarted(mode: JActionMode); cdecl;
    procedure onAttachedToWindow; cdecl;
    procedure onContentChanged; cdecl;
    function onCreatePanelMenu(featureId: Integer; menu: JMenu): Boolean; cdecl;
    function onCreatePanelView(featureId: Integer): JView; cdecl;
    procedure onDetachedFromWindow; cdecl;
    function onMenuItemSelected(featureId: Integer; item: JMenuItem): Boolean; cdecl;
    function onMenuOpened(featureId: Integer; menu: JMenu): Boolean; cdecl;
    procedure onPanelClosed(featureId: Integer; menu: JMenu); cdecl;
    function onPreparePanel(featureId: Integer; view: JView; menu: JMenu): Boolean; cdecl;
    function onSearchRequested: Boolean; cdecl; overload;
    function onSearchRequested(searchEvent: JSearchEvent): Boolean; cdecl; overload;
    procedure onWindowAttributesChanged(attrs: JWindowManager_LayoutParams); cdecl;
    procedure onWindowFocusChanged(hasFocus: Boolean); cdecl;
    function onWindowStartingActionMode(callback: JActionMode_Callback): JActionMode; cdecl; overload;
    function onWindowStartingActionMode(callback: JActionMode_Callback; type_: Integer): JActionMode; cdecl; overload;
  end;
  TJWindow_Callback = class(TJavaGenericImport<JWindow_CallbackClass, JWindow_Callback>) end;

  JWindowIdClass = interface(JObjectClass)
    ['{5C4CC131-C432-414D-8924-16C3BF1E5BEA}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/WindowId')]
  JWindowId = interface(JObject)
    ['{647C7377-2F4A-4D37-9514-212CBE4C8604}']
    function describeContents: Integer; cdecl;
    function equals(otherObj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isFocused: Boolean; cdecl;
    procedure registerFocusObserver(observer: JWindowId_FocusObserver); cdecl;
    function toString: JString; cdecl;
    procedure unregisterFocusObserver(observer: JWindowId_FocusObserver); cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJWindowId = class(TJavaGenericImport<JWindowIdClass, JWindowId>) end;

  JWindowId_FocusObserverClass = interface(JObjectClass)
    ['{1D1FE64F-FA6E-4BF1-81F1-BC9B7196C34F}']
    {class} function init: JWindowId_FocusObserver; cdecl;
  end;

  [JavaSignature('android/view/WindowId$FocusObserver')]
  JWindowId_FocusObserver = interface(JObject)
    ['{9877CB82-620F-43E1-A8BE-490758CDD3DC}']
    procedure onFocusGained(token: JWindowId); cdecl;
    procedure onFocusLost(token: JWindowId); cdecl;
  end;
  TJWindowId_FocusObserver = class(TJavaGenericImport<JWindowId_FocusObserverClass, JWindowId_FocusObserver>) end;

  JWindowInsetsClass = interface(JObjectClass)
    ['{A16F9B57-77F6-400B-8DEF-C54083F62B89}']
    {class} function init(src: JWindowInsets): JWindowInsets; cdecl;
  end;

  [JavaSignature('android/view/WindowInsets')]
  JWindowInsets = interface(JObject)
    ['{91D24EE6-AFE9-4F79-A3FA-B177B25729C4}']
    function consumeStableInsets: JWindowInsets; cdecl;
    function consumeSystemWindowInsets: JWindowInsets; cdecl;
    function getStableInsetBottom: Integer; cdecl;
    function getStableInsetLeft: Integer; cdecl;
    function getStableInsetRight: Integer; cdecl;
    function getStableInsetTop: Integer; cdecl;
    function getSystemWindowInsetBottom: Integer; cdecl;
    function getSystemWindowInsetLeft: Integer; cdecl;
    function getSystemWindowInsetRight: Integer; cdecl;
    function getSystemWindowInsetTop: Integer; cdecl;
    function hasInsets: Boolean; cdecl;
    function hasStableInsets: Boolean; cdecl;
    function hasSystemWindowInsets: Boolean; cdecl;
    function isConsumed: Boolean; cdecl;
    function isRound: Boolean; cdecl;
    function replaceSystemWindowInsets(left: Integer; top: Integer; right: Integer; bottom: Integer): JWindowInsets; cdecl; overload;
    function replaceSystemWindowInsets(systemWindowInsets: JRect): JWindowInsets; cdecl; overload;
    function toString: JString; cdecl;
  end;
  TJWindowInsets = class(TJavaGenericImport<JWindowInsetsClass, JWindowInsets>) end;

  JWindowManagerClass = interface(JViewManagerClass)
    ['{13B7F7E9-A84B-4290-8C2E-3DB6C817A9C9}']
  end;

  [JavaSignature('android/view/WindowManager')]
  JWindowManager = interface(JViewManager)
    ['{CE046C1F-687D-4438-B364-573A7FF59B26}']
    function getDefaultDisplay: JDisplay; cdecl;
    procedure removeViewImmediate(view: JView); cdecl;
  end;
  TJWindowManager = class(TJavaGenericImport<JWindowManagerClass, JWindowManager>) end;

  JWindowManager_LayoutParamsClass = interface(JViewGroup_LayoutParamsClass)
    ['{677013A8-C0C6-4ED2-83EA-188BF4D1331A}']
    {class} function _GetALPHA_CHANGED: Integer; cdecl;
    {class} function _GetANIMATION_CHANGED: Integer; cdecl;
    {class} function _GetBRIGHTNESS_OVERRIDE_FULL: Single; cdecl;
    {class} function _GetBRIGHTNESS_OVERRIDE_NONE: Single; cdecl;
    {class} function _GetBRIGHTNESS_OVERRIDE_OFF: Single; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDIM_AMOUNT_CHANGED: Integer; cdecl;
    {class} function _GetFIRST_APPLICATION_WINDOW: Integer; cdecl;
    {class} function _GetFIRST_SUB_WINDOW: Integer; cdecl;
    {class} function _GetFIRST_SYSTEM_WINDOW: Integer; cdecl;
    {class} function _GetFLAGS_CHANGED: Integer; cdecl;
    {class} function _GetFLAG_ALLOW_LOCK_WHILE_SCREEN_ON: Integer; cdecl;
    {class} function _GetFLAG_ALT_FOCUSABLE_IM: Integer; cdecl;
    {class} function _GetFLAG_BLUR_BEHIND: Integer; cdecl;
    {class} function _GetFLAG_DIM_BEHIND: Integer; cdecl;
    {class} function _GetFLAG_DISMISS_KEYGUARD: Integer; cdecl;
    {class} function _GetFLAG_DITHER: Integer; cdecl;
    {class} function _GetFLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS: Integer; cdecl;
    {class} function _GetFLAG_FORCE_NOT_FULLSCREEN: Integer; cdecl;
    {class} function _GetFLAG_FULLSCREEN: Integer; cdecl;
    {class} function _GetFLAG_HARDWARE_ACCELERATED: Integer; cdecl;
    {class} function _GetFLAG_IGNORE_CHEEK_PRESSES: Integer; cdecl;
    {class} function _GetFLAG_KEEP_SCREEN_ON: Integer; cdecl;
    {class} function _GetFLAG_LAYOUT_ATTACHED_IN_DECOR: Integer; cdecl;
    {class} function _GetFLAG_LAYOUT_INSET_DECOR: Integer; cdecl;
    {class} function _GetFLAG_LAYOUT_IN_OVERSCAN: Integer; cdecl;
    {class} function _GetFLAG_LAYOUT_IN_SCREEN: Integer; cdecl;
    {class} function _GetFLAG_LAYOUT_NO_LIMITS: Integer; cdecl;
    {class} function _GetFLAG_LOCAL_FOCUS_MODE: Integer; cdecl;
    {class} function _GetFLAG_NOT_FOCUSABLE: Integer; cdecl;
    {class} function _GetFLAG_NOT_TOUCHABLE: Integer; cdecl;
    {class} function _GetFLAG_NOT_TOUCH_MODAL: Integer; cdecl;
    {class} function _GetFLAG_SCALED: Integer; cdecl;
    {class} function _GetFLAG_SECURE: Integer; cdecl;
    {class} function _GetFLAG_SHOW_WALLPAPER: Integer; cdecl;
    {class} function _GetFLAG_SHOW_WHEN_LOCKED: Integer; cdecl;
    {class} function _GetFLAG_SPLIT_TOUCH: Integer; cdecl;
    {class} function _GetFLAG_TOUCHABLE_WHEN_WAKING: Integer; cdecl;
    {class} function _GetFLAG_TRANSLUCENT_NAVIGATION: Integer; cdecl;
    {class} function _GetFLAG_TRANSLUCENT_STATUS: Integer; cdecl;
    {class} function _GetFLAG_TURN_SCREEN_ON: Integer; cdecl;
    {class} function _GetFLAG_WATCH_OUTSIDE_TOUCH: Integer; cdecl;
    {class} function _GetFORMAT_CHANGED: Integer; cdecl;
    {class} function _GetLAST_APPLICATION_WINDOW: Integer; cdecl;
    {class} function _GetLAST_SUB_WINDOW: Integer; cdecl;
    {class} function _GetLAST_SYSTEM_WINDOW: Integer; cdecl;
    {class} function _GetLAYOUT_CHANGED: Integer; cdecl;
    {class} function _GetMEMORY_TYPE_CHANGED: Integer; cdecl;
    {class} function _GetMEMORY_TYPE_GPU: Integer; cdecl;
    {class} function _GetMEMORY_TYPE_HARDWARE: Integer; cdecl;
    {class} function _GetMEMORY_TYPE_NORMAL: Integer; cdecl;
    {class} function _GetMEMORY_TYPE_PUSH_BUFFERS: Integer; cdecl;
    {class} function _GetROTATION_ANIMATION_CHANGED: Integer; cdecl;
    {class} function _GetROTATION_ANIMATION_CROSSFADE: Integer; cdecl;
    {class} function _GetROTATION_ANIMATION_JUMPCUT: Integer; cdecl;
    {class} function _GetROTATION_ANIMATION_ROTATE: Integer; cdecl;
    {class} function _GetSCREEN_BRIGHTNESS_CHANGED: Integer; cdecl;
    {class} function _GetSCREEN_ORIENTATION_CHANGED: Integer; cdecl;
    {class} function _GetSOFT_INPUT_ADJUST_NOTHING: Integer; cdecl;
    {class} function _GetSOFT_INPUT_ADJUST_PAN: Integer; cdecl;
    {class} function _GetSOFT_INPUT_ADJUST_RESIZE: Integer; cdecl;
    {class} function _GetSOFT_INPUT_ADJUST_UNSPECIFIED: Integer; cdecl;
    {class} function _GetSOFT_INPUT_IS_FORWARD_NAVIGATION: Integer; cdecl;
    {class} function _GetSOFT_INPUT_MASK_ADJUST: Integer; cdecl;
    {class} function _GetSOFT_INPUT_MASK_STATE: Integer; cdecl;
    {class} function _GetSOFT_INPUT_MODE_CHANGED: Integer; cdecl;
    {class} function _GetSOFT_INPUT_STATE_ALWAYS_HIDDEN: Integer; cdecl;
    {class} function _GetSOFT_INPUT_STATE_ALWAYS_VISIBLE: Integer; cdecl;
    {class} function _GetSOFT_INPUT_STATE_HIDDEN: Integer; cdecl;
    {class} function _GetSOFT_INPUT_STATE_UNCHANGED: Integer; cdecl;
    {class} function _GetSOFT_INPUT_STATE_UNSPECIFIED: Integer; cdecl;
    {class} function _GetSOFT_INPUT_STATE_VISIBLE: Integer; cdecl;
    {class} function _GetTITLE_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_ACCESSIBILITY_OVERLAY: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION_ATTACHED_DIALOG: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION_MEDIA: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION_PANEL: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION_STARTING: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION_SUB_PANEL: Integer; cdecl;
    {class} function _GetTYPE_BASE_APPLICATION: Integer; cdecl;
    {class} function _GetTYPE_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_INPUT_METHOD: Integer; cdecl;
    {class} function _GetTYPE_INPUT_METHOD_DIALOG: Integer; cdecl;
    {class} function _GetTYPE_KEYGUARD: Integer; cdecl;
    {class} function _GetTYPE_KEYGUARD_DIALOG: Integer; cdecl;
    {class} function _GetTYPE_PHONE: Integer; cdecl;
    {class} function _GetTYPE_PRIORITY_PHONE: Integer; cdecl;
    {class} function _GetTYPE_PRIVATE_PRESENTATION: Integer; cdecl;
    {class} function _GetTYPE_SEARCH_BAR: Integer; cdecl;
    {class} function _GetTYPE_STATUS_BAR: Integer; cdecl;
    {class} function _GetTYPE_STATUS_BAR_PANEL: Integer; cdecl;
    {class} function _GetTYPE_SYSTEM_ALERT: Integer; cdecl;
    {class} function _GetTYPE_SYSTEM_DIALOG: Integer; cdecl;
    {class} function _GetTYPE_SYSTEM_ERROR: Integer; cdecl;
    {class} function _GetTYPE_SYSTEM_OVERLAY: Integer; cdecl;
    {class} function _GetTYPE_TOAST: Integer; cdecl;
    {class} function _GetTYPE_WALLPAPER: Integer; cdecl;
    {class} function init: JWindowManager_LayoutParams; cdecl; overload;
    {class} function init(_type: Integer): JWindowManager_LayoutParams; cdecl; overload;
    {class} function init(_type: Integer; _flags: Integer): JWindowManager_LayoutParams; cdecl; overload;
    {class} function init(_type: Integer; _flags: Integer; _format: Integer): JWindowManager_LayoutParams; cdecl; overload;
    {class} function init(w: Integer; h: Integer; _type: Integer; _flags: Integer; _format: Integer): JWindowManager_LayoutParams; cdecl; overload;
    {class} function init(w: Integer; h: Integer; xpos: Integer; ypos: Integer; _type: Integer; _flags: Integer; _format: Integer): JWindowManager_LayoutParams; cdecl; overload;
    {class} function init(in_: JParcel): JWindowManager_LayoutParams; cdecl; overload;
    {class} function mayUseInputMethod(flags: Integer): Boolean; cdecl;
    {class} property ALPHA_CHANGED: Integer read _GetALPHA_CHANGED;
    {class} property ANIMATION_CHANGED: Integer read _GetANIMATION_CHANGED;
    {class} property BRIGHTNESS_OVERRIDE_FULL: Single read _GetBRIGHTNESS_OVERRIDE_FULL;
    {class} property BRIGHTNESS_OVERRIDE_NONE: Single read _GetBRIGHTNESS_OVERRIDE_NONE;
    {class} property BRIGHTNESS_OVERRIDE_OFF: Single read _GetBRIGHTNESS_OVERRIDE_OFF;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DIM_AMOUNT_CHANGED: Integer read _GetDIM_AMOUNT_CHANGED;
    {class} property FIRST_APPLICATION_WINDOW: Integer read _GetFIRST_APPLICATION_WINDOW;
    {class} property FIRST_SUB_WINDOW: Integer read _GetFIRST_SUB_WINDOW;
    {class} property FIRST_SYSTEM_WINDOW: Integer read _GetFIRST_SYSTEM_WINDOW;
    {class} property FLAGS_CHANGED: Integer read _GetFLAGS_CHANGED;
    {class} property FLAG_ALLOW_LOCK_WHILE_SCREEN_ON: Integer read _GetFLAG_ALLOW_LOCK_WHILE_SCREEN_ON;
    {class} property FLAG_ALT_FOCUSABLE_IM: Integer read _GetFLAG_ALT_FOCUSABLE_IM;
    {class} property FLAG_BLUR_BEHIND: Integer read _GetFLAG_BLUR_BEHIND;
    {class} property FLAG_DIM_BEHIND: Integer read _GetFLAG_DIM_BEHIND;
    {class} property FLAG_DISMISS_KEYGUARD: Integer read _GetFLAG_DISMISS_KEYGUARD;
    {class} property FLAG_DITHER: Integer read _GetFLAG_DITHER;
    {class} property FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS: Integer read _GetFLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS;
    {class} property FLAG_FORCE_NOT_FULLSCREEN: Integer read _GetFLAG_FORCE_NOT_FULLSCREEN;
    {class} property FLAG_FULLSCREEN: Integer read _GetFLAG_FULLSCREEN;
    {class} property FLAG_HARDWARE_ACCELERATED: Integer read _GetFLAG_HARDWARE_ACCELERATED;
    {class} property FLAG_IGNORE_CHEEK_PRESSES: Integer read _GetFLAG_IGNORE_CHEEK_PRESSES;
    {class} property FLAG_KEEP_SCREEN_ON: Integer read _GetFLAG_KEEP_SCREEN_ON;
    {class} property FLAG_LAYOUT_ATTACHED_IN_DECOR: Integer read _GetFLAG_LAYOUT_ATTACHED_IN_DECOR;
    {class} property FLAG_LAYOUT_INSET_DECOR: Integer read _GetFLAG_LAYOUT_INSET_DECOR;
    {class} property FLAG_LAYOUT_IN_OVERSCAN: Integer read _GetFLAG_LAYOUT_IN_OVERSCAN;
    {class} property FLAG_LAYOUT_IN_SCREEN: Integer read _GetFLAG_LAYOUT_IN_SCREEN;
    {class} property FLAG_LAYOUT_NO_LIMITS: Integer read _GetFLAG_LAYOUT_NO_LIMITS;
    {class} property FLAG_LOCAL_FOCUS_MODE: Integer read _GetFLAG_LOCAL_FOCUS_MODE;
    {class} property FLAG_NOT_FOCUSABLE: Integer read _GetFLAG_NOT_FOCUSABLE;
    {class} property FLAG_NOT_TOUCHABLE: Integer read _GetFLAG_NOT_TOUCHABLE;
    {class} property FLAG_NOT_TOUCH_MODAL: Integer read _GetFLAG_NOT_TOUCH_MODAL;
    {class} property FLAG_SCALED: Integer read _GetFLAG_SCALED;
    {class} property FLAG_SECURE: Integer read _GetFLAG_SECURE;
    {class} property FLAG_SHOW_WALLPAPER: Integer read _GetFLAG_SHOW_WALLPAPER;
    {class} property FLAG_SHOW_WHEN_LOCKED: Integer read _GetFLAG_SHOW_WHEN_LOCKED;
    {class} property FLAG_SPLIT_TOUCH: Integer read _GetFLAG_SPLIT_TOUCH;
    {class} property FLAG_TOUCHABLE_WHEN_WAKING: Integer read _GetFLAG_TOUCHABLE_WHEN_WAKING;
    {class} property FLAG_TRANSLUCENT_NAVIGATION: Integer read _GetFLAG_TRANSLUCENT_NAVIGATION;
    {class} property FLAG_TRANSLUCENT_STATUS: Integer read _GetFLAG_TRANSLUCENT_STATUS;
    {class} property FLAG_TURN_SCREEN_ON: Integer read _GetFLAG_TURN_SCREEN_ON;
    {class} property FLAG_WATCH_OUTSIDE_TOUCH: Integer read _GetFLAG_WATCH_OUTSIDE_TOUCH;
    {class} property FORMAT_CHANGED: Integer read _GetFORMAT_CHANGED;
    {class} property LAST_APPLICATION_WINDOW: Integer read _GetLAST_APPLICATION_WINDOW;
    {class} property LAST_SUB_WINDOW: Integer read _GetLAST_SUB_WINDOW;
    {class} property LAST_SYSTEM_WINDOW: Integer read _GetLAST_SYSTEM_WINDOW;
    {class} property LAYOUT_CHANGED: Integer read _GetLAYOUT_CHANGED;
    {class} property MEMORY_TYPE_CHANGED: Integer read _GetMEMORY_TYPE_CHANGED;
    {class} property MEMORY_TYPE_GPU: Integer read _GetMEMORY_TYPE_GPU;
    {class} property MEMORY_TYPE_HARDWARE: Integer read _GetMEMORY_TYPE_HARDWARE;
    {class} property MEMORY_TYPE_NORMAL: Integer read _GetMEMORY_TYPE_NORMAL;
    {class} property MEMORY_TYPE_PUSH_BUFFERS: Integer read _GetMEMORY_TYPE_PUSH_BUFFERS;
    {class} property ROTATION_ANIMATION_CHANGED: Integer read _GetROTATION_ANIMATION_CHANGED;
    {class} property ROTATION_ANIMATION_CROSSFADE: Integer read _GetROTATION_ANIMATION_CROSSFADE;
    {class} property ROTATION_ANIMATION_JUMPCUT: Integer read _GetROTATION_ANIMATION_JUMPCUT;
    {class} property ROTATION_ANIMATION_ROTATE: Integer read _GetROTATION_ANIMATION_ROTATE;
    {class} property SCREEN_BRIGHTNESS_CHANGED: Integer read _GetSCREEN_BRIGHTNESS_CHANGED;
    {class} property SCREEN_ORIENTATION_CHANGED: Integer read _GetSCREEN_ORIENTATION_CHANGED;
    {class} property SOFT_INPUT_ADJUST_NOTHING: Integer read _GetSOFT_INPUT_ADJUST_NOTHING;
    {class} property SOFT_INPUT_ADJUST_PAN: Integer read _GetSOFT_INPUT_ADJUST_PAN;
    {class} property SOFT_INPUT_ADJUST_RESIZE: Integer read _GetSOFT_INPUT_ADJUST_RESIZE;
    {class} property SOFT_INPUT_ADJUST_UNSPECIFIED: Integer read _GetSOFT_INPUT_ADJUST_UNSPECIFIED;
    {class} property SOFT_INPUT_IS_FORWARD_NAVIGATION: Integer read _GetSOFT_INPUT_IS_FORWARD_NAVIGATION;
    {class} property SOFT_INPUT_MASK_ADJUST: Integer read _GetSOFT_INPUT_MASK_ADJUST;
    {class} property SOFT_INPUT_MASK_STATE: Integer read _GetSOFT_INPUT_MASK_STATE;
    {class} property SOFT_INPUT_MODE_CHANGED: Integer read _GetSOFT_INPUT_MODE_CHANGED;
    {class} property SOFT_INPUT_STATE_ALWAYS_HIDDEN: Integer read _GetSOFT_INPUT_STATE_ALWAYS_HIDDEN;
    {class} property SOFT_INPUT_STATE_ALWAYS_VISIBLE: Integer read _GetSOFT_INPUT_STATE_ALWAYS_VISIBLE;
    {class} property SOFT_INPUT_STATE_HIDDEN: Integer read _GetSOFT_INPUT_STATE_HIDDEN;
    {class} property SOFT_INPUT_STATE_UNCHANGED: Integer read _GetSOFT_INPUT_STATE_UNCHANGED;
    {class} property SOFT_INPUT_STATE_UNSPECIFIED: Integer read _GetSOFT_INPUT_STATE_UNSPECIFIED;
    {class} property SOFT_INPUT_STATE_VISIBLE: Integer read _GetSOFT_INPUT_STATE_VISIBLE;
    {class} property TITLE_CHANGED: Integer read _GetTITLE_CHANGED;
    {class} property TYPE_ACCESSIBILITY_OVERLAY: Integer read _GetTYPE_ACCESSIBILITY_OVERLAY;
    {class} property TYPE_APPLICATION: Integer read _GetTYPE_APPLICATION;
    {class} property TYPE_APPLICATION_ATTACHED_DIALOG: Integer read _GetTYPE_APPLICATION_ATTACHED_DIALOG;
    {class} property TYPE_APPLICATION_MEDIA: Integer read _GetTYPE_APPLICATION_MEDIA;
    {class} property TYPE_APPLICATION_PANEL: Integer read _GetTYPE_APPLICATION_PANEL;
    {class} property TYPE_APPLICATION_STARTING: Integer read _GetTYPE_APPLICATION_STARTING;
    {class} property TYPE_APPLICATION_SUB_PANEL: Integer read _GetTYPE_APPLICATION_SUB_PANEL;
    {class} property TYPE_BASE_APPLICATION: Integer read _GetTYPE_BASE_APPLICATION;
    {class} property TYPE_CHANGED: Integer read _GetTYPE_CHANGED;
    {class} property TYPE_INPUT_METHOD: Integer read _GetTYPE_INPUT_METHOD;
    {class} property TYPE_INPUT_METHOD_DIALOG: Integer read _GetTYPE_INPUT_METHOD_DIALOG;
    {class} property TYPE_KEYGUARD: Integer read _GetTYPE_KEYGUARD;
    {class} property TYPE_KEYGUARD_DIALOG: Integer read _GetTYPE_KEYGUARD_DIALOG;
    {class} property TYPE_PHONE: Integer read _GetTYPE_PHONE;
    {class} property TYPE_PRIORITY_PHONE: Integer read _GetTYPE_PRIORITY_PHONE;
    {class} property TYPE_PRIVATE_PRESENTATION: Integer read _GetTYPE_PRIVATE_PRESENTATION;
    {class} property TYPE_SEARCH_BAR: Integer read _GetTYPE_SEARCH_BAR;
    {class} property TYPE_STATUS_BAR: Integer read _GetTYPE_STATUS_BAR;
    {class} property TYPE_STATUS_BAR_PANEL: Integer read _GetTYPE_STATUS_BAR_PANEL;
    {class} property TYPE_SYSTEM_ALERT: Integer read _GetTYPE_SYSTEM_ALERT;
    {class} property TYPE_SYSTEM_DIALOG: Integer read _GetTYPE_SYSTEM_DIALOG;
    {class} property TYPE_SYSTEM_ERROR: Integer read _GetTYPE_SYSTEM_ERROR;
    {class} property TYPE_SYSTEM_OVERLAY: Integer read _GetTYPE_SYSTEM_OVERLAY;
    {class} property TYPE_TOAST: Integer read _GetTYPE_TOAST;
    {class} property TYPE_WALLPAPER: Integer read _GetTYPE_WALLPAPER;
  end;

  [JavaSignature('android/view/WindowManager$LayoutParams')]
  JWindowManager_LayoutParams = interface(JViewGroup_LayoutParams)
    ['{12E0B6C8-78BE-4565-B79D-BBD5D7BB8086}']
    function _Getalpha: Single; cdecl;
    procedure _Setalpha(Value: Single); cdecl;
    function _GetbuttonBrightness: Single; cdecl;
    procedure _SetbuttonBrightness(Value: Single); cdecl;
    function _GetdimAmount: Single; cdecl;
    procedure _SetdimAmount(Value: Single); cdecl;
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _Getformat: Integer; cdecl;
    procedure _Setformat(Value: Integer); cdecl;
    function _Getgravity: Integer; cdecl;
    procedure _Setgravity(Value: Integer); cdecl;
    function _GethorizontalMargin: Single; cdecl;
    procedure _SethorizontalMargin(Value: Single); cdecl;
    function _GethorizontalWeight: Single; cdecl;
    procedure _SethorizontalWeight(Value: Single); cdecl;
    function _GetmemoryType: Integer; cdecl;
    procedure _SetmemoryType(Value: Integer); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function _GetpreferredDisplayModeId: Integer; cdecl;
    procedure _SetpreferredDisplayModeId(Value: Integer); cdecl;
    function _GetpreferredRefreshRate: Single; cdecl;
    procedure _SetpreferredRefreshRate(Value: Single); cdecl;
    function _GetrotationAnimation: Integer; cdecl;
    procedure _SetrotationAnimation(Value: Integer); cdecl;
    function _GetscreenBrightness: Single; cdecl;
    procedure _SetscreenBrightness(Value: Single); cdecl;
    function _GetscreenOrientation: Integer; cdecl;
    procedure _SetscreenOrientation(Value: Integer); cdecl;
    function _GetsoftInputMode: Integer; cdecl;
    procedure _SetsoftInputMode(Value: Integer); cdecl;
    function _GetsystemUiVisibility: Integer; cdecl;
    procedure _SetsystemUiVisibility(Value: Integer); cdecl;
    function _Gettoken: JIBinder; cdecl;
    procedure _Settoken(Value: JIBinder); cdecl;
    function _Gettype: Integer; cdecl;
    procedure _Settype(Value: Integer); cdecl;
    function _GetverticalMargin: Single; cdecl;
    procedure _SetverticalMargin(Value: Single); cdecl;
    function _GetverticalWeight: Single; cdecl;
    procedure _SetverticalWeight(Value: Single); cdecl;
    function _GetwindowAnimations: Integer; cdecl;
    procedure _SetwindowAnimations(Value: Integer); cdecl;
    function _Getx: Integer; cdecl;
    procedure _Setx(Value: Integer); cdecl;
    function _Gety: Integer; cdecl;
    procedure _Sety(Value: Integer); cdecl;
    function copyFrom(o: JWindowManager_LayoutParams): Integer; cdecl;
    function debug(output: JString): JString; cdecl;
    function describeContents: Integer; cdecl;
    function getTitle: JCharSequence; cdecl;
    procedure setTitle(title: JCharSequence); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; parcelableFlags: Integer); cdecl;
    property alpha: Single read _Getalpha write _Setalpha;
    property buttonBrightness: Single read _GetbuttonBrightness write _SetbuttonBrightness;
    property dimAmount: Single read _GetdimAmount write _SetdimAmount;
    property flags: Integer read _Getflags write _Setflags;
    property format: Integer read _Getformat write _Setformat;
    property gravity: Integer read _Getgravity write _Setgravity;
    property horizontalMargin: Single read _GethorizontalMargin write _SethorizontalMargin;
    property horizontalWeight: Single read _GethorizontalWeight write _SethorizontalWeight;
    property memoryType: Integer read _GetmemoryType write _SetmemoryType;
    property packageName: JString read _GetpackageName write _SetpackageName;
    property preferredDisplayModeId: Integer read _GetpreferredDisplayModeId write _SetpreferredDisplayModeId;
    property preferredRefreshRate: Single read _GetpreferredRefreshRate write _SetpreferredRefreshRate;
    property rotationAnimation: Integer read _GetrotationAnimation write _SetrotationAnimation;
    property screenBrightness: Single read _GetscreenBrightness write _SetscreenBrightness;
    property screenOrientation: Integer read _GetscreenOrientation write _SetscreenOrientation;
    property softInputMode: Integer read _GetsoftInputMode write _SetsoftInputMode;
    property systemUiVisibility: Integer read _GetsystemUiVisibility write _SetsystemUiVisibility;
    property token: JIBinder read _Gettoken write _Settoken;
    property &type: Integer read _Gettype write _Settype;
    property verticalMargin: Single read _GetverticalMargin write _SetverticalMargin;
    property verticalWeight: Single read _GetverticalWeight write _SetverticalWeight;
    property windowAnimations: Integer read _GetwindowAnimations write _SetwindowAnimations;
    property x: Integer read _Getx write _Setx;
    property y: Integer read _Gety write _Sety;
  end;
  TJWindowManager_LayoutParams = class(TJavaGenericImport<JWindowManager_LayoutParamsClass, JWindowManager_LayoutParams>) end;

  JAccessibilityRecordClass = interface(JObjectClass)
    ['{FE6CDF00-7CC8-4963-96A4-F7B344B22D65}']
    {class} function obtain(record_: JAccessibilityRecord): JAccessibilityRecord; cdecl; overload;
    {class} function obtain: JAccessibilityRecord; cdecl; overload;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityRecord')]
  JAccessibilityRecord = interface(JObject)
    ['{682FB1AE-B028-4EFF-A9D0-43894E6ECEF0}']
    function getAddedCount: Integer; cdecl;
    function getBeforeText: JCharSequence; cdecl;
    function getClassName: JCharSequence; cdecl;
    function getContentDescription: JCharSequence; cdecl;
    function getCurrentItemIndex: Integer; cdecl;
    function getFromIndex: Integer; cdecl;
    function getItemCount: Integer; cdecl;
    function getMaxScrollX: Integer; cdecl;
    function getMaxScrollY: Integer; cdecl;
    function getParcelableData: JParcelable; cdecl;
    function getRemovedCount: Integer; cdecl;
    function getScrollX: Integer; cdecl;
    function getScrollY: Integer; cdecl;
    function getSource: JAccessibilityNodeInfo; cdecl;
    function getText: JList; cdecl;
    function getToIndex: Integer; cdecl;
    function getWindowId: Integer; cdecl;
    function isChecked: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isFullScreen: Boolean; cdecl;
    function isPassword: Boolean; cdecl;
    function isScrollable: Boolean; cdecl;
    procedure recycle; cdecl;
    procedure setAddedCount(addedCount: Integer); cdecl;
    procedure setBeforeText(beforeText: JCharSequence); cdecl;
    procedure setChecked(isChecked: Boolean); cdecl;
    procedure setClassName(className: JCharSequence); cdecl;
    procedure setContentDescription(contentDescription: JCharSequence); cdecl;
    procedure setCurrentItemIndex(currentItemIndex: Integer); cdecl;
    procedure setEnabled(isEnabled: Boolean); cdecl;
    procedure setFromIndex(fromIndex: Integer); cdecl;
    procedure setFullScreen(isFullScreen: Boolean); cdecl;
    procedure setItemCount(itemCount: Integer); cdecl;
    procedure setMaxScrollX(maxScrollX: Integer); cdecl;
    procedure setMaxScrollY(maxScrollY: Integer); cdecl;
    procedure setParcelableData(parcelableData: JParcelable); cdecl;
    procedure setPassword(isPassword: Boolean); cdecl;
    procedure setRemovedCount(removedCount: Integer); cdecl;
    procedure setScrollX(scrollX: Integer); cdecl;
    procedure setScrollY(scrollY: Integer); cdecl;
    procedure setScrollable(scrollable: Boolean); cdecl;
    procedure setSource(source: JView); cdecl; overload;
    procedure setSource(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setToIndex(toIndex: Integer); cdecl;
    function toString: JString; cdecl;
  end;
  TJAccessibilityRecord = class(TJavaGenericImport<JAccessibilityRecordClass, JAccessibilityRecord>) end;

  JAccessibilityEventClass = interface(JAccessibilityRecordClass)
    ['{F88D04C7-FB7F-4C0C-A5E7-62ECC255DF96}']
    {class} function _GetCONTENT_CHANGE_TYPE_CONTENT_DESCRIPTION: Integer; cdecl;
    {class} function _GetCONTENT_CHANGE_TYPE_SUBTREE: Integer; cdecl;
    {class} function _GetCONTENT_CHANGE_TYPE_TEXT: Integer; cdecl;
    {class} function _GetCONTENT_CHANGE_TYPE_UNDEFINED: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetINVALID_POSITION: Integer; cdecl;
    {class} function _GetMAX_TEXT_LENGTH: Integer; cdecl;
    {class} function _GetTYPES_ALL_MASK: Integer; cdecl;
    {class} function _GetTYPE_ANNOUNCEMENT: Integer; cdecl;
    {class} function _GetTYPE_ASSIST_READING_CONTEXT: Integer; cdecl;
    {class} function _GetTYPE_GESTURE_DETECTION_END: Integer; cdecl;
    {class} function _GetTYPE_GESTURE_DETECTION_START: Integer; cdecl;
    {class} function _GetTYPE_NOTIFICATION_STATE_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_TOUCH_EXPLORATION_GESTURE_END: Integer; cdecl;
    {class} function _GetTYPE_TOUCH_EXPLORATION_GESTURE_START: Integer; cdecl;
    {class} function _GetTYPE_TOUCH_INTERACTION_END: Integer; cdecl;
    {class} function _GetTYPE_TOUCH_INTERACTION_START: Integer; cdecl;
    {class} function _GetTYPE_VIEW_ACCESSIBILITY_FOCUSED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_CLICKED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_CONTEXT_CLICKED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_FOCUSED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_HOVER_ENTER: Integer; cdecl;
    {class} function _GetTYPE_VIEW_HOVER_EXIT: Integer; cdecl;
    {class} function _GetTYPE_VIEW_LONG_CLICKED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_SCROLLED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_SELECTED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_TEXT_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_TEXT_SELECTION_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_VIEW_TEXT_TRAVERSED_AT_MOVEMENT_GRANULARITY: Integer; cdecl;
    {class} function _GetTYPE_WINDOWS_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_WINDOW_CONTENT_CHANGED: Integer; cdecl;
    {class} function _GetTYPE_WINDOW_STATE_CHANGED: Integer; cdecl;
    {class} function eventTypeToString(eventType: Integer): JString; cdecl;
    {class} function obtain(eventType: Integer): JAccessibilityEvent; cdecl; overload;
    {class} function obtain(event: JAccessibilityEvent): JAccessibilityEvent; cdecl; overload;
    {class} function obtain: JAccessibilityEvent; cdecl; overload;
    {class} property CONTENT_CHANGE_TYPE_CONTENT_DESCRIPTION: Integer read _GetCONTENT_CHANGE_TYPE_CONTENT_DESCRIPTION;
    {class} property CONTENT_CHANGE_TYPE_SUBTREE: Integer read _GetCONTENT_CHANGE_TYPE_SUBTREE;
    {class} property CONTENT_CHANGE_TYPE_TEXT: Integer read _GetCONTENT_CHANGE_TYPE_TEXT;
    {class} property CONTENT_CHANGE_TYPE_UNDEFINED: Integer read _GetCONTENT_CHANGE_TYPE_UNDEFINED;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property INVALID_POSITION: Integer read _GetINVALID_POSITION;
    {class} property MAX_TEXT_LENGTH: Integer read _GetMAX_TEXT_LENGTH;
    {class} property TYPES_ALL_MASK: Integer read _GetTYPES_ALL_MASK;
    {class} property TYPE_ANNOUNCEMENT: Integer read _GetTYPE_ANNOUNCEMENT;
    {class} property TYPE_ASSIST_READING_CONTEXT: Integer read _GetTYPE_ASSIST_READING_CONTEXT;
    {class} property TYPE_GESTURE_DETECTION_END: Integer read _GetTYPE_GESTURE_DETECTION_END;
    {class} property TYPE_GESTURE_DETECTION_START: Integer read _GetTYPE_GESTURE_DETECTION_START;
    {class} property TYPE_NOTIFICATION_STATE_CHANGED: Integer read _GetTYPE_NOTIFICATION_STATE_CHANGED;
    {class} property TYPE_TOUCH_EXPLORATION_GESTURE_END: Integer read _GetTYPE_TOUCH_EXPLORATION_GESTURE_END;
    {class} property TYPE_TOUCH_EXPLORATION_GESTURE_START: Integer read _GetTYPE_TOUCH_EXPLORATION_GESTURE_START;
    {class} property TYPE_TOUCH_INTERACTION_END: Integer read _GetTYPE_TOUCH_INTERACTION_END;
    {class} property TYPE_TOUCH_INTERACTION_START: Integer read _GetTYPE_TOUCH_INTERACTION_START;
    {class} property TYPE_VIEW_ACCESSIBILITY_FOCUSED: Integer read _GetTYPE_VIEW_ACCESSIBILITY_FOCUSED;
    {class} property TYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED: Integer read _GetTYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED;
    {class} property TYPE_VIEW_CLICKED: Integer read _GetTYPE_VIEW_CLICKED;
    {class} property TYPE_VIEW_CONTEXT_CLICKED: Integer read _GetTYPE_VIEW_CONTEXT_CLICKED;
    {class} property TYPE_VIEW_FOCUSED: Integer read _GetTYPE_VIEW_FOCUSED;
    {class} property TYPE_VIEW_HOVER_ENTER: Integer read _GetTYPE_VIEW_HOVER_ENTER;
    {class} property TYPE_VIEW_HOVER_EXIT: Integer read _GetTYPE_VIEW_HOVER_EXIT;
    {class} property TYPE_VIEW_LONG_CLICKED: Integer read _GetTYPE_VIEW_LONG_CLICKED;
    {class} property TYPE_VIEW_SCROLLED: Integer read _GetTYPE_VIEW_SCROLLED;
    {class} property TYPE_VIEW_SELECTED: Integer read _GetTYPE_VIEW_SELECTED;
    {class} property TYPE_VIEW_TEXT_CHANGED: Integer read _GetTYPE_VIEW_TEXT_CHANGED;
    {class} property TYPE_VIEW_TEXT_SELECTION_CHANGED: Integer read _GetTYPE_VIEW_TEXT_SELECTION_CHANGED;
    {class} property TYPE_VIEW_TEXT_TRAVERSED_AT_MOVEMENT_GRANULARITY: Integer read _GetTYPE_VIEW_TEXT_TRAVERSED_AT_MOVEMENT_GRANULARITY;
    {class} property TYPE_WINDOWS_CHANGED: Integer read _GetTYPE_WINDOWS_CHANGED;
    {class} property TYPE_WINDOW_CONTENT_CHANGED: Integer read _GetTYPE_WINDOW_CONTENT_CHANGED;
    {class} property TYPE_WINDOW_STATE_CHANGED: Integer read _GetTYPE_WINDOW_STATE_CHANGED;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityEvent')]
  JAccessibilityEvent = interface(JAccessibilityRecord)
    ['{854E9884-87E7-4537-8964-1F4E46C6AE7B}']
    procedure appendRecord(record_: JAccessibilityRecord); cdecl;
    function describeContents: Integer; cdecl;
    function getAction: Integer; cdecl;
    function getContentChangeTypes: Integer; cdecl;
    function getEventTime: Int64; cdecl;
    function getEventType: Integer; cdecl;
    function getMovementGranularity: Integer; cdecl;
    function getPackageName: JCharSequence; cdecl;
    function getRecord(index: Integer): JAccessibilityRecord; cdecl;
    function getRecordCount: Integer; cdecl;
    procedure initFromParcel(parcel: JParcel); cdecl;
    procedure recycle; cdecl;
    procedure setAction(action: Integer); cdecl;
    procedure setContentChangeTypes(changeTypes: Integer); cdecl;
    procedure setEventTime(eventTime: Int64); cdecl;
    procedure setEventType(eventType: Integer); cdecl;
    procedure setMovementGranularity(granularity: Integer); cdecl;
    procedure setPackageName(packageName: JCharSequence); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJAccessibilityEvent = class(TJavaGenericImport<JAccessibilityEventClass, JAccessibilityEvent>) end;

  JAccessibilityNodeInfoClass = interface(JObjectClass)
    ['{DAF94093-CDDB-471C-8987-F87B44261F97}']
    {class} function _GetACTION_ACCESSIBILITY_FOCUS: Integer; cdecl;
    {class} function _GetACTION_ARGUMENT_COLUMN_INT: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_EXTEND_SELECTION_BOOLEAN: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_HTML_ELEMENT_STRING: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_MOVEMENT_GRANULARITY_INT: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_ROW_INT: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_SELECTION_END_INT: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_SELECTION_START_INT: JString; cdecl;
    {class} function _GetACTION_ARGUMENT_SET_TEXT_CHARSEQUENCE: JString; cdecl;
    {class} function _GetACTION_CLEAR_ACCESSIBILITY_FOCUS: Integer; cdecl;
    {class} function _GetACTION_CLEAR_FOCUS: Integer; cdecl;
    {class} function _GetACTION_CLEAR_SELECTION: Integer; cdecl;
    {class} function _GetACTION_CLICK: Integer; cdecl;
    {class} function _GetACTION_COLLAPSE: Integer; cdecl;
    {class} function _GetACTION_COPY: Integer; cdecl;
    {class} function _GetACTION_CUT: Integer; cdecl;
    {class} function _GetACTION_DISMISS: Integer; cdecl;
    {class} function _GetACTION_EXPAND: Integer; cdecl;
    {class} function _GetACTION_FOCUS: Integer; cdecl;
    {class} function _GetACTION_LONG_CLICK: Integer; cdecl;
    {class} function _GetACTION_NEXT_AT_MOVEMENT_GRANULARITY: Integer; cdecl;
    {class} function _GetACTION_NEXT_HTML_ELEMENT: Integer; cdecl;
    {class} function _GetACTION_PASTE: Integer; cdecl;
    {class} function _GetACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY: Integer; cdecl;
    {class} function _GetACTION_PREVIOUS_HTML_ELEMENT: Integer; cdecl;
    {class} function _GetACTION_SCROLL_BACKWARD: Integer; cdecl;
    {class} function _GetACTION_SCROLL_FORWARD: Integer; cdecl;
    {class} function _GetACTION_SELECT: Integer; cdecl;
    {class} function _GetACTION_SET_SELECTION: Integer; cdecl;
    {class} function _GetACTION_SET_TEXT: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFOCUS_ACCESSIBILITY: Integer; cdecl;
    {class} function _GetFOCUS_INPUT: Integer; cdecl;
    {class} function _GetMOVEMENT_GRANULARITY_CHARACTER: Integer; cdecl;
    {class} function _GetMOVEMENT_GRANULARITY_LINE: Integer; cdecl;
    {class} function _GetMOVEMENT_GRANULARITY_PAGE: Integer; cdecl;
    {class} function _GetMOVEMENT_GRANULARITY_PARAGRAPH: Integer; cdecl;
    {class} function _GetMOVEMENT_GRANULARITY_WORD: Integer; cdecl;
    {class} function obtain(source: JView): JAccessibilityNodeInfo; cdecl; overload;
    {class} function obtain(root: JView; virtualDescendantId: Integer): JAccessibilityNodeInfo; cdecl; overload;
    {class} function obtain: JAccessibilityNodeInfo; cdecl; overload;
    {class} function obtain(info: JAccessibilityNodeInfo): JAccessibilityNodeInfo; cdecl; overload;
    {class} property ACTION_ACCESSIBILITY_FOCUS: Integer read _GetACTION_ACCESSIBILITY_FOCUS;
    {class} property ACTION_ARGUMENT_COLUMN_INT: JString read _GetACTION_ARGUMENT_COLUMN_INT;
    {class} property ACTION_ARGUMENT_EXTEND_SELECTION_BOOLEAN: JString read _GetACTION_ARGUMENT_EXTEND_SELECTION_BOOLEAN;
    {class} property ACTION_ARGUMENT_HTML_ELEMENT_STRING: JString read _GetACTION_ARGUMENT_HTML_ELEMENT_STRING;
    {class} property ACTION_ARGUMENT_MOVEMENT_GRANULARITY_INT: JString read _GetACTION_ARGUMENT_MOVEMENT_GRANULARITY_INT;
    {class} property ACTION_ARGUMENT_ROW_INT: JString read _GetACTION_ARGUMENT_ROW_INT;
    {class} property ACTION_ARGUMENT_SELECTION_END_INT: JString read _GetACTION_ARGUMENT_SELECTION_END_INT;
    {class} property ACTION_ARGUMENT_SELECTION_START_INT: JString read _GetACTION_ARGUMENT_SELECTION_START_INT;
    {class} property ACTION_ARGUMENT_SET_TEXT_CHARSEQUENCE: JString read _GetACTION_ARGUMENT_SET_TEXT_CHARSEQUENCE;
    {class} property ACTION_CLEAR_ACCESSIBILITY_FOCUS: Integer read _GetACTION_CLEAR_ACCESSIBILITY_FOCUS;
    {class} property ACTION_CLEAR_FOCUS: Integer read _GetACTION_CLEAR_FOCUS;
    {class} property ACTION_CLEAR_SELECTION: Integer read _GetACTION_CLEAR_SELECTION;
    {class} property ACTION_CLICK: Integer read _GetACTION_CLICK;
    {class} property ACTION_COLLAPSE: Integer read _GetACTION_COLLAPSE;
    {class} property ACTION_COPY: Integer read _GetACTION_COPY;
    {class} property ACTION_CUT: Integer read _GetACTION_CUT;
    {class} property ACTION_DISMISS: Integer read _GetACTION_DISMISS;
    {class} property ACTION_EXPAND: Integer read _GetACTION_EXPAND;
    {class} property ACTION_FOCUS: Integer read _GetACTION_FOCUS;
    {class} property ACTION_LONG_CLICK: Integer read _GetACTION_LONG_CLICK;
    {class} property ACTION_NEXT_AT_MOVEMENT_GRANULARITY: Integer read _GetACTION_NEXT_AT_MOVEMENT_GRANULARITY;
    {class} property ACTION_NEXT_HTML_ELEMENT: Integer read _GetACTION_NEXT_HTML_ELEMENT;
    {class} property ACTION_PASTE: Integer read _GetACTION_PASTE;
    {class} property ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY: Integer read _GetACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY;
    {class} property ACTION_PREVIOUS_HTML_ELEMENT: Integer read _GetACTION_PREVIOUS_HTML_ELEMENT;
    {class} property ACTION_SCROLL_BACKWARD: Integer read _GetACTION_SCROLL_BACKWARD;
    {class} property ACTION_SCROLL_FORWARD: Integer read _GetACTION_SCROLL_FORWARD;
    {class} property ACTION_SELECT: Integer read _GetACTION_SELECT;
    {class} property ACTION_SET_SELECTION: Integer read _GetACTION_SET_SELECTION;
    {class} property ACTION_SET_TEXT: Integer read _GetACTION_SET_TEXT;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FOCUS_ACCESSIBILITY: Integer read _GetFOCUS_ACCESSIBILITY;
    {class} property FOCUS_INPUT: Integer read _GetFOCUS_INPUT;
    {class} property MOVEMENT_GRANULARITY_CHARACTER: Integer read _GetMOVEMENT_GRANULARITY_CHARACTER;
    {class} property MOVEMENT_GRANULARITY_LINE: Integer read _GetMOVEMENT_GRANULARITY_LINE;
    {class} property MOVEMENT_GRANULARITY_PAGE: Integer read _GetMOVEMENT_GRANULARITY_PAGE;
    {class} property MOVEMENT_GRANULARITY_PARAGRAPH: Integer read _GetMOVEMENT_GRANULARITY_PARAGRAPH;
    {class} property MOVEMENT_GRANULARITY_WORD: Integer read _GetMOVEMENT_GRANULARITY_WORD;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityNodeInfo')]
  JAccessibilityNodeInfo = interface(JObject)
    ['{E90FAE2C-BFBA-46B2-81ED-BCDA42A7DF4D}']
    procedure addAction(action: JAccessibilityNodeInfo_AccessibilityAction); cdecl; overload;
    procedure addAction(action: Integer); cdecl; overload;//Deprecated
    procedure addChild(child: JView); cdecl; overload;
    procedure addChild(root: JView; virtualDescendantId: Integer); cdecl; overload;
    function canOpenPopup: Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function findAccessibilityNodeInfosByText(text: JString): JList; cdecl;
    function findAccessibilityNodeInfosByViewId(viewId: JString): JList; cdecl;
    function findFocus(focus: Integer): JAccessibilityNodeInfo; cdecl;
    function focusSearch(direction: Integer): JAccessibilityNodeInfo; cdecl;
    function getActionList: JList; cdecl;
    function getActions: Integer; cdecl;//Deprecated
    procedure getBoundsInParent(outBounds: JRect); cdecl;
    procedure getBoundsInScreen(outBounds: JRect); cdecl;
    function getChild(index: Integer): JAccessibilityNodeInfo; cdecl;
    function getChildCount: Integer; cdecl;
    function getClassName: JCharSequence; cdecl;
    function getCollectionInfo: JAccessibilityNodeInfo_CollectionInfo; cdecl;
    function getCollectionItemInfo: JAccessibilityNodeInfo_CollectionItemInfo; cdecl;
    function getContentDescription: JCharSequence; cdecl;
    function getError: JCharSequence; cdecl;
    function getExtras: JBundle; cdecl;
    function getInputType: Integer; cdecl;
    function getLabelFor: JAccessibilityNodeInfo; cdecl;
    function getLabeledBy: JAccessibilityNodeInfo; cdecl;
    function getLiveRegion: Integer; cdecl;
    function getMaxTextLength: Integer; cdecl;
    function getMovementGranularities: Integer; cdecl;
    function getPackageName: JCharSequence; cdecl;
    function getParent: JAccessibilityNodeInfo; cdecl;
    function getRangeInfo: JAccessibilityNodeInfo_RangeInfo; cdecl;
    function getText: JCharSequence; cdecl;
    function getTextSelectionEnd: Integer; cdecl;
    function getTextSelectionStart: Integer; cdecl;
    function getTraversalAfter: JAccessibilityNodeInfo; cdecl;
    function getTraversalBefore: JAccessibilityNodeInfo; cdecl;
    function getViewIdResourceName: JString; cdecl;
    function getWindow: JAccessibilityWindowInfo; cdecl;
    function getWindowId: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isAccessibilityFocused: Boolean; cdecl;
    function isCheckable: Boolean; cdecl;
    function isChecked: Boolean; cdecl;
    function isClickable: Boolean; cdecl;
    function isContentInvalid: Boolean; cdecl;
    function isContextClickable: Boolean; cdecl;
    function isDismissable: Boolean; cdecl;
    function isEditable: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isFocusable: Boolean; cdecl;
    function isFocused: Boolean; cdecl;
    function isLongClickable: Boolean; cdecl;
    function isMultiLine: Boolean; cdecl;
    function isPassword: Boolean; cdecl;
    function isScrollable: Boolean; cdecl;
    function isSelected: Boolean; cdecl;
    function isVisibleToUser: Boolean; cdecl;
    function performAction(action: Integer): Boolean; cdecl; overload;
    function performAction(action: Integer; arguments: JBundle): Boolean; cdecl; overload;
    procedure recycle; cdecl;
    function refresh: Boolean; cdecl;
    procedure removeAction(action: Integer); cdecl; overload;//Deprecated
    function removeAction(action: JAccessibilityNodeInfo_AccessibilityAction): Boolean; cdecl; overload;
    function removeChild(child: JView): Boolean; cdecl; overload;
    function removeChild(root: JView; virtualDescendantId: Integer): Boolean; cdecl; overload;
    procedure setAccessibilityFocused(focused: Boolean); cdecl;
    procedure setBoundsInParent(bounds: JRect); cdecl;
    procedure setBoundsInScreen(bounds: JRect); cdecl;
    procedure setCanOpenPopup(opensPopup: Boolean); cdecl;
    procedure setCheckable(checkable: Boolean); cdecl;
    procedure setChecked(checked: Boolean); cdecl;
    procedure setClassName(className: JCharSequence); cdecl;
    procedure setClickable(clickable: Boolean); cdecl;
    procedure setCollectionInfo(collectionInfo: JAccessibilityNodeInfo_CollectionInfo); cdecl;
    procedure setCollectionItemInfo(collectionItemInfo: JAccessibilityNodeInfo_CollectionItemInfo); cdecl;
    procedure setContentDescription(contentDescription: JCharSequence); cdecl;
    procedure setContentInvalid(contentInvalid: Boolean); cdecl;
    procedure setContextClickable(contextClickable: Boolean); cdecl;
    procedure setDismissable(dismissable: Boolean); cdecl;
    procedure setEditable(editable: Boolean); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setError(error: JCharSequence); cdecl;
    procedure setFocusable(focusable: Boolean); cdecl;
    procedure setFocused(focused: Boolean); cdecl;
    procedure setInputType(inputType: Integer); cdecl;
    procedure setLabelFor(labeled: JView); cdecl; overload;
    procedure setLabelFor(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setLabeledBy(label_: JView); cdecl; overload;
    procedure setLabeledBy(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setLiveRegion(mode: Integer); cdecl;
    procedure setLongClickable(longClickable: Boolean); cdecl;
    procedure setMaxTextLength(max: Integer); cdecl;
    procedure setMovementGranularities(granularities: Integer); cdecl;
    procedure setMultiLine(multiLine: Boolean); cdecl;
    procedure setPackageName(packageName: JCharSequence); cdecl;
    procedure setParent(parent: JView); cdecl; overload;
    procedure setParent(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setPassword(password: Boolean); cdecl;
    procedure setRangeInfo(rangeInfo: JAccessibilityNodeInfo_RangeInfo); cdecl;
    procedure setScrollable(scrollable: Boolean); cdecl;
    procedure setSelected(selected: Boolean); cdecl;
    procedure setSource(source: JView); cdecl; overload;
    procedure setSource(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setText(text: JCharSequence); cdecl;
    procedure setTextSelection(start: Integer; end_: Integer); cdecl;
    procedure setTraversalAfter(view: JView); cdecl; overload;
    procedure setTraversalAfter(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setTraversalBefore(view: JView); cdecl; overload;
    procedure setTraversalBefore(root: JView; virtualDescendantId: Integer); cdecl; overload;
    procedure setViewIdResourceName(viewIdResName: JString); cdecl;
    procedure setVisibleToUser(visibleToUser: Boolean); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJAccessibilityNodeInfo = class(TJavaGenericImport<JAccessibilityNodeInfoClass, JAccessibilityNodeInfo>) end;

  JAccessibilityNodeInfo_AccessibilityActionClass = interface(JObjectClass)
    ['{07F9A370-F5D3-48E8-955B-9D284886AA69}']
    {class} function _GetACTION_ACCESSIBILITY_FOCUS: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_CLEAR_ACCESSIBILITY_FOCUS: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_CLEAR_FOCUS: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_CLEAR_SELECTION: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_CLICK: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_COLLAPSE: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_CONTEXT_CLICK: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_COPY: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_CUT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_DISMISS: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_EXPAND: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_FOCUS: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_LONG_CLICK: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_NEXT_AT_MOVEMENT_GRANULARITY: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_NEXT_HTML_ELEMENT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_PASTE: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_PREVIOUS_HTML_ELEMENT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_BACKWARD: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_DOWN: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_FORWARD: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_LEFT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_RIGHT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_TO_POSITION: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SCROLL_UP: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SELECT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SET_SELECTION: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SET_TEXT: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function _GetACTION_SHOW_ON_SCREEN: JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} function init(actionId: Integer; label_: JCharSequence): JAccessibilityNodeInfo_AccessibilityAction; cdecl;
    {class} property ACTION_ACCESSIBILITY_FOCUS: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_ACCESSIBILITY_FOCUS;
    {class} property ACTION_CLEAR_ACCESSIBILITY_FOCUS: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_CLEAR_ACCESSIBILITY_FOCUS;
    {class} property ACTION_CLEAR_FOCUS: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_CLEAR_FOCUS;
    {class} property ACTION_CLEAR_SELECTION: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_CLEAR_SELECTION;
    {class} property ACTION_CLICK: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_CLICK;
    {class} property ACTION_COLLAPSE: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_COLLAPSE;
    {class} property ACTION_CONTEXT_CLICK: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_CONTEXT_CLICK;
    {class} property ACTION_COPY: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_COPY;
    {class} property ACTION_CUT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_CUT;
    {class} property ACTION_DISMISS: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_DISMISS;
    {class} property ACTION_EXPAND: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_EXPAND;
    {class} property ACTION_FOCUS: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_FOCUS;
    {class} property ACTION_LONG_CLICK: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_LONG_CLICK;
    {class} property ACTION_NEXT_AT_MOVEMENT_GRANULARITY: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_NEXT_AT_MOVEMENT_GRANULARITY;
    {class} property ACTION_NEXT_HTML_ELEMENT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_NEXT_HTML_ELEMENT;
    {class} property ACTION_PASTE: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_PASTE;
    {class} property ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY;
    {class} property ACTION_PREVIOUS_HTML_ELEMENT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_PREVIOUS_HTML_ELEMENT;
    {class} property ACTION_SCROLL_BACKWARD: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_BACKWARD;
    {class} property ACTION_SCROLL_DOWN: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_DOWN;
    {class} property ACTION_SCROLL_FORWARD: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_FORWARD;
    {class} property ACTION_SCROLL_LEFT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_LEFT;
    {class} property ACTION_SCROLL_RIGHT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_RIGHT;
    {class} property ACTION_SCROLL_TO_POSITION: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_TO_POSITION;
    {class} property ACTION_SCROLL_UP: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SCROLL_UP;
    {class} property ACTION_SELECT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SELECT;
    {class} property ACTION_SET_SELECTION: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SET_SELECTION;
    {class} property ACTION_SET_TEXT: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SET_TEXT;
    {class} property ACTION_SHOW_ON_SCREEN: JAccessibilityNodeInfo_AccessibilityAction read _GetACTION_SHOW_ON_SCREEN;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityNodeInfo$AccessibilityAction')]
  JAccessibilityNodeInfo_AccessibilityAction = interface(JObject)
    ['{5AFDEE9E-75FD-47CF-9B0A-A5A9C60FB261}']
    function equals(other: JObject): Boolean; cdecl;
    function getId: Integer; cdecl;
    function getLabel: JCharSequence; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJAccessibilityNodeInfo_AccessibilityAction = class(TJavaGenericImport<JAccessibilityNodeInfo_AccessibilityActionClass, JAccessibilityNodeInfo_AccessibilityAction>) end;

  JAccessibilityNodeInfo_CollectionInfoClass = interface(JObjectClass)
    ['{A10C2DA8-BDAB-48A3-8726-68EB2A9B09C5}']
    {class} function _GetSELECTION_MODE_MULTIPLE: Integer; cdecl;
    {class} function _GetSELECTION_MODE_NONE: Integer; cdecl;
    {class} function _GetSELECTION_MODE_SINGLE: Integer; cdecl;
    {class} function obtain(rowCount: Integer; columnCount: Integer; hierarchical: Boolean): JAccessibilityNodeInfo_CollectionInfo; cdecl; overload;
    {class} function obtain(rowCount: Integer; columnCount: Integer; hierarchical: Boolean; selectionMode: Integer): JAccessibilityNodeInfo_CollectionInfo; cdecl; overload;
    {class} property SELECTION_MODE_MULTIPLE: Integer read _GetSELECTION_MODE_MULTIPLE;
    {class} property SELECTION_MODE_NONE: Integer read _GetSELECTION_MODE_NONE;
    {class} property SELECTION_MODE_SINGLE: Integer read _GetSELECTION_MODE_SINGLE;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityNodeInfo$CollectionInfo')]
  JAccessibilityNodeInfo_CollectionInfo = interface(JObject)
    ['{1F8A41A4-9A45-4D11-94D7-CAF86EA1F60B}']
    function getColumnCount: Integer; cdecl;
    function getRowCount: Integer; cdecl;
    function getSelectionMode: Integer; cdecl;
    function isHierarchical: Boolean; cdecl;
  end;
  TJAccessibilityNodeInfo_CollectionInfo = class(TJavaGenericImport<JAccessibilityNodeInfo_CollectionInfoClass, JAccessibilityNodeInfo_CollectionInfo>) end;

  JAccessibilityNodeInfo_CollectionItemInfoClass = interface(JObjectClass)
    ['{791C94B5-C123-4EF3-985F-E95432462159}']
    {class} function obtain(rowIndex: Integer; rowSpan: Integer; columnIndex: Integer; columnSpan: Integer; heading: Boolean): JAccessibilityNodeInfo_CollectionItemInfo; cdecl; overload;
    {class} function obtain(rowIndex: Integer; rowSpan: Integer; columnIndex: Integer; columnSpan: Integer; heading: Boolean; selected: Boolean): JAccessibilityNodeInfo_CollectionItemInfo; cdecl; overload;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityNodeInfo$CollectionItemInfo')]
  JAccessibilityNodeInfo_CollectionItemInfo = interface(JObject)
    ['{9BDF6B63-6876-4D3E-B0B8-57BD431B50CC}']
    function getColumnIndex: Integer; cdecl;
    function getColumnSpan: Integer; cdecl;
    function getRowIndex: Integer; cdecl;
    function getRowSpan: Integer; cdecl;
    function isHeading: Boolean; cdecl;
    function isSelected: Boolean; cdecl;
  end;
  TJAccessibilityNodeInfo_CollectionItemInfo = class(TJavaGenericImport<JAccessibilityNodeInfo_CollectionItemInfoClass, JAccessibilityNodeInfo_CollectionItemInfo>) end;

  JAccessibilityNodeInfo_RangeInfoClass = interface(JObjectClass)
    ['{88784398-9713-404C-9C1F-09374BD9C5C2}']
    {class} function _GetRANGE_TYPE_FLOAT: Integer; cdecl;
    {class} function _GetRANGE_TYPE_INT: Integer; cdecl;
    {class} function _GetRANGE_TYPE_PERCENT: Integer; cdecl;
    {class} function obtain(type_: Integer; min: Single; max: Single; current: Single): JAccessibilityNodeInfo_RangeInfo; cdecl;
    {class} property RANGE_TYPE_FLOAT: Integer read _GetRANGE_TYPE_FLOAT;
    {class} property RANGE_TYPE_INT: Integer read _GetRANGE_TYPE_INT;
    {class} property RANGE_TYPE_PERCENT: Integer read _GetRANGE_TYPE_PERCENT;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityNodeInfo$RangeInfo')]
  JAccessibilityNodeInfo_RangeInfo = interface(JObject)
    ['{B8DD31DF-2133-4A47-9024-9A9BC42131ED}']
    function getCurrent: Single; cdecl;
    function getMax: Single; cdecl;
    function getMin: Single; cdecl;
    function getType: Integer; cdecl;
  end;
  TJAccessibilityNodeInfo_RangeInfo = class(TJavaGenericImport<JAccessibilityNodeInfo_RangeInfoClass, JAccessibilityNodeInfo_RangeInfo>) end;

  JAccessibilityNodeProviderClass = interface(JObjectClass)
    ['{61C6FA4F-00E7-4771-94E8-8C72FE8E6A35}']
    {class} function _GetHOST_VIEW_ID: Integer; cdecl;
    {class} function init: JAccessibilityNodeProvider; cdecl;
    {class} property HOST_VIEW_ID: Integer read _GetHOST_VIEW_ID;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityNodeProvider')]
  JAccessibilityNodeProvider = interface(JObject)
    ['{25F2F96C-9B2E-427E-BFFA-13A3E4D7B2CC}']
    function createAccessibilityNodeInfo(virtualViewId: Integer): JAccessibilityNodeInfo; cdecl;
    function findAccessibilityNodeInfosByText(text: JString; virtualViewId: Integer): JList; cdecl;
    function findFocus(focus: Integer): JAccessibilityNodeInfo; cdecl;
    function performAction(virtualViewId: Integer; action: Integer; arguments: JBundle): Boolean; cdecl;
  end;
  TJAccessibilityNodeProvider = class(TJavaGenericImport<JAccessibilityNodeProviderClass, JAccessibilityNodeProvider>) end;

  JAccessibilityWindowInfoClass = interface(JObjectClass)
    ['{565F20D7-E7E2-4537-81EA-D66B230A83BF}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetTYPE_ACCESSIBILITY_OVERLAY: Integer; cdecl;
    {class} function _GetTYPE_APPLICATION: Integer; cdecl;
    {class} function _GetTYPE_INPUT_METHOD: Integer; cdecl;
    {class} function _GetTYPE_SYSTEM: Integer; cdecl;
    {class} function obtain: JAccessibilityWindowInfo; cdecl; overload;
    {class} function obtain(info: JAccessibilityWindowInfo): JAccessibilityWindowInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property TYPE_ACCESSIBILITY_OVERLAY: Integer read _GetTYPE_ACCESSIBILITY_OVERLAY;
    {class} property TYPE_APPLICATION: Integer read _GetTYPE_APPLICATION;
    {class} property TYPE_INPUT_METHOD: Integer read _GetTYPE_INPUT_METHOD;
    {class} property TYPE_SYSTEM: Integer read _GetTYPE_SYSTEM;
  end;

  [JavaSignature('android/view/accessibility/AccessibilityWindowInfo')]
  JAccessibilityWindowInfo = interface(JObject)
    ['{AC040AD9-F151-4873-9E70-FA72019DDC28}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    procedure getBoundsInScreen(outBounds: JRect); cdecl;
    function getChild(index: Integer): JAccessibilityWindowInfo; cdecl;
    function getChildCount: Integer; cdecl;
    function getId: Integer; cdecl;
    function getLayer: Integer; cdecl;
    function getParent: JAccessibilityWindowInfo; cdecl;
    function getRoot: JAccessibilityNodeInfo; cdecl;
    function getType: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isAccessibilityFocused: Boolean; cdecl;
    function isActive: Boolean; cdecl;
    function isFocused: Boolean; cdecl;
    procedure recycle; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJAccessibilityWindowInfo = class(TJavaGenericImport<JAccessibilityWindowInfoClass, JAccessibilityWindowInfo>) end;

  JAnimationClass = interface(JObjectClass)
    ['{350A849D-B9B6-4849-B771-243C11CF4E90}']
    {class} function _GetABSOLUTE: Integer; cdecl;
    {class} function _GetINFINITE: Integer; cdecl;
    {class} function _GetRELATIVE_TO_PARENT: Integer; cdecl;
    {class} function _GetRELATIVE_TO_SELF: Integer; cdecl;
    {class} function _GetRESTART: Integer; cdecl;
    {class} function _GetREVERSE: Integer; cdecl;
    {class} function _GetSTART_ON_FIRST_FRAME: Integer; cdecl;
    {class} function _GetZORDER_BOTTOM: Integer; cdecl;
    {class} function _GetZORDER_NORMAL: Integer; cdecl;
    {class} function _GetZORDER_TOP: Integer; cdecl;
    {class} function init: JAnimation; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JAnimation; cdecl; overload;
    {class} property ABSOLUTE: Integer read _GetABSOLUTE;
    {class} property INFINITE: Integer read _GetINFINITE;
    {class} property RELATIVE_TO_PARENT: Integer read _GetRELATIVE_TO_PARENT;
    {class} property RELATIVE_TO_SELF: Integer read _GetRELATIVE_TO_SELF;
    {class} property RESTART: Integer read _GetRESTART;
    {class} property REVERSE: Integer read _GetREVERSE;
    {class} property START_ON_FIRST_FRAME: Integer read _GetSTART_ON_FIRST_FRAME;
    {class} property ZORDER_BOTTOM: Integer read _GetZORDER_BOTTOM;
    {class} property ZORDER_NORMAL: Integer read _GetZORDER_NORMAL;
    {class} property ZORDER_TOP: Integer read _GetZORDER_TOP;
  end;

  [JavaSignature('android/view/animation/Animation')]
  JAnimation = interface(JObject)
    ['{2B2DEDA7-2B53-4A74-ADFD-729D72E85A1B}']
    procedure cancel; cdecl;
    function computeDurationHint: Int64; cdecl;
    function getBackgroundColor: Integer; cdecl;
    function getDetachWallpaper: Boolean; cdecl;
    function getDuration: Int64; cdecl;
    function getFillAfter: Boolean; cdecl;
    function getFillBefore: Boolean; cdecl;
    //function getInterpolator: JInterpolator; cdecl;
    function getRepeatCount: Integer; cdecl;
    function getRepeatMode: Integer; cdecl;
    function getStartOffset: Int64; cdecl;
    function getStartTime: Int64; cdecl;
    function getTransformation(currentTime: Int64; outTransformation: JTransformation): Boolean; cdecl; overload;
    function getTransformation(currentTime: Int64; outTransformation: JTransformation; scale: Single): Boolean; cdecl; overload;
    function getZAdjustment: Integer; cdecl;
    function hasEnded: Boolean; cdecl;
    function hasStarted: Boolean; cdecl;
    procedure initialize(width: Integer; height: Integer; parentWidth: Integer; parentHeight: Integer); cdecl;
    function isFillEnabled: Boolean; cdecl;
    function isInitialized: Boolean; cdecl;
    procedure reset; cdecl;
    procedure restrictDuration(durationMillis: Int64); cdecl;
    procedure scaleCurrentDuration(scale: Single); cdecl;
    procedure setAnimationListener(listener: JAnimation_AnimationListener); cdecl;
    procedure setBackgroundColor(bg: Integer); cdecl;
    procedure setDetachWallpaper(detachWallpaper: Boolean); cdecl;
    procedure setDuration(durationMillis: Int64); cdecl;
    procedure setFillAfter(fillAfter: Boolean); cdecl;
    procedure setFillBefore(fillBefore: Boolean); cdecl;
    procedure setFillEnabled(fillEnabled: Boolean); cdecl;
    procedure setInterpolator(context: JContext; resID: Integer); cdecl; overload;
    //procedure setInterpolator(i: JInterpolator); cdecl; overload;
    procedure setRepeatCount(repeatCount: Integer); cdecl;
    procedure setRepeatMode(repeatMode: Integer); cdecl;
    procedure setStartOffset(startOffset: Int64); cdecl;
    procedure setStartTime(startTimeMillis: Int64); cdecl;
    procedure setZAdjustment(zAdjustment: Integer); cdecl;
    procedure start; cdecl;
    procedure startNow; cdecl;
    function willChangeBounds: Boolean; cdecl;
    function willChangeTransformationMatrix: Boolean; cdecl;
  end;
  TJAnimation = class(TJavaGenericImport<JAnimationClass, JAnimation>) end;

  JAnimation_AnimationListenerClass = interface(IJavaClass)
    ['{9316A9E6-09E2-4019-A0A7-BD59FBA8F827}']
  end;

  [JavaSignature('android/view/animation/Animation$AnimationListener')]
  JAnimation_AnimationListener = interface(IJavaInstance)
    ['{321B409A-7601-449C-A101-D1DC5A134771}']
    procedure onAnimationEnd(animation: JAnimation); cdecl;
    procedure onAnimationRepeat(animation: JAnimation); cdecl;
    procedure onAnimationStart(animation: JAnimation); cdecl;
  end;
  TJAnimation_AnimationListener = class(TJavaGenericImport<JAnimation_AnimationListenerClass, JAnimation_AnimationListener>) end;

  // android.view.animation.Interpolator
  JLayoutAnimationControllerClass = interface(JObjectClass)
    ['{20F75DC1-5192-49A1-80BE-7C9B7A3A9517}']
    {class} function _GetORDER_NORMAL: Integer; cdecl;
    {class} function _GetORDER_RANDOM: Integer; cdecl;
    {class} function _GetORDER_REVERSE: Integer; cdecl;
    {class} function init(context: JContext; attrs: JAttributeSet): JLayoutAnimationController; cdecl; overload;
    {class} function init(animation: JAnimation): JLayoutAnimationController; cdecl; overload;
    {class} function init(animation: JAnimation; delay: Single): JLayoutAnimationController; cdecl; overload;
    {class} property ORDER_NORMAL: Integer read _GetORDER_NORMAL;
    {class} property ORDER_RANDOM: Integer read _GetORDER_RANDOM;
    {class} property ORDER_REVERSE: Integer read _GetORDER_REVERSE;
  end;

  [JavaSignature('android/view/animation/LayoutAnimationController')]
  JLayoutAnimationController = interface(JObject)
    ['{325F2D61-065D-4FAA-9C45-838CE2CEC78F}']
    function getAnimation: JAnimation; cdecl;
    function getAnimationForView(view: JView): JAnimation; cdecl;
    function getDelay: Single; cdecl;
    //function getInterpolator: JInterpolator; cdecl;
    function getOrder: Integer; cdecl;
    function isDone: Boolean; cdecl;
    procedure setAnimation(context: JContext; resourceID: Integer); cdecl; overload;
    procedure setAnimation(animation: JAnimation); cdecl; overload;
    procedure setDelay(delay: Single); cdecl;
    procedure setInterpolator(context: JContext; resourceID: Integer); cdecl; overload;
    //procedure setInterpolator(interpolator: JInterpolator); cdecl; overload;
    procedure setOrder(order: Integer); cdecl;
    procedure start; cdecl;
    function willOverlap: Boolean; cdecl;
  end;
  TJLayoutAnimationController = class(TJavaGenericImport<JLayoutAnimationControllerClass, JLayoutAnimationController>) end;

  JLayoutAnimationController_AnimationParametersClass = interface(JObjectClass)
    ['{A40635A7-0878-4AE8-AA2C-8CE92BBBAE48}']
    {class} function init: JLayoutAnimationController_AnimationParameters; cdecl;
  end;

  [JavaSignature('android/view/animation/LayoutAnimationController$AnimationParameters')]
  JLayoutAnimationController_AnimationParameters = interface(JObject)
    ['{4210B534-F422-4FE8-B3C6-9F873034264C}']
    function _Getcount: Integer; cdecl;
    procedure _Setcount(Value: Integer); cdecl;
    function _Getindex: Integer; cdecl;
    procedure _Setindex(Value: Integer); cdecl;
    property count: Integer read _Getcount write _Setcount;
    property index: Integer read _Getindex write _Setindex;
  end;
  TJLayoutAnimationController_AnimationParameters = class(TJavaGenericImport<JLayoutAnimationController_AnimationParametersClass, JLayoutAnimationController_AnimationParameters>) end;

  JTransformationClass = interface(JObjectClass)
    ['{DC41D16A-D391-4DD2-8ABE-4528BE916E4C}']
    {class} function _GetTYPE_ALPHA: Integer; cdecl;
    {class} function _GetTYPE_BOTH: Integer; cdecl;
    {class} function _GetTYPE_IDENTITY: Integer; cdecl;
    {class} function _GetTYPE_MATRIX: Integer; cdecl;
    {class} function init: JTransformation; cdecl;
    {class} property TYPE_ALPHA: Integer read _GetTYPE_ALPHA;
    {class} property TYPE_BOTH: Integer read _GetTYPE_BOTH;
    {class} property TYPE_IDENTITY: Integer read _GetTYPE_IDENTITY;
    {class} property TYPE_MATRIX: Integer read _GetTYPE_MATRIX;
  end;

  [JavaSignature('android/view/animation/Transformation')]
  JTransformation = interface(JObject)
    ['{33DB14F1-DBA3-4C32-B8D8-8FCCC92E75DC}']
    procedure clear; cdecl;
    procedure compose(t: JTransformation); cdecl;
    function getAlpha: Single; cdecl;
    function getMatrix: JMatrix; cdecl;
    function getTransformationType: Integer; cdecl;
    procedure &set(t: JTransformation); cdecl;
    procedure setAlpha(alpha: Single); cdecl;
    procedure setTransformationType(transformationType: Integer); cdecl;
    function toShortString: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJTransformation = class(TJavaGenericImport<JTransformationClass, JTransformation>) end;

  JBaseInputConnectionClass = interface(JObjectClass)
    ['{2DA1840F-A45E-49FE-A74B-A2F601B6A32D}']
    {class} function init(targetView: JView; fullEditor: Boolean): JBaseInputConnection; cdecl;
    {class} function getComposingSpanEnd(text: JSpannable): Integer; cdecl;
    {class} function getComposingSpanStart(text: JSpannable): Integer; cdecl;
    {class} procedure removeComposingSpans(text: JSpannable); cdecl;
    {class} procedure setComposingSpans(text: JSpannable); cdecl;
  end;

  [JavaSignature('android/view/inputmethod/BaseInputConnection')]
  JBaseInputConnection = interface(JObject)
    ['{7EDEBBAC-690B-4400-B285-190FA17DC215}']
    function beginBatchEdit: Boolean; cdecl;
    function clearMetaKeyStates(states: Integer): Boolean; cdecl;
    function commitCompletion(text: JCompletionInfo): Boolean; cdecl;
    function commitCorrection(correctionInfo: JCorrectionInfo): Boolean; cdecl;
    function commitText(text: JCharSequence; newCursorPosition: Integer): Boolean; cdecl;
    function deleteSurroundingText(beforeLength: Integer; afterLength: Integer): Boolean; cdecl;
    function endBatchEdit: Boolean; cdecl;
    function finishComposingText: Boolean; cdecl;
    function getCursorCapsMode(reqModes: Integer): Integer; cdecl;
    function getEditable: JEditable; cdecl;
    function getExtractedText(request: JExtractedTextRequest; flags: Integer): JExtractedText; cdecl;
    function getSelectedText(flags: Integer): JCharSequence; cdecl;
    function getTextAfterCursor(length: Integer; flags: Integer): JCharSequence; cdecl;
    function getTextBeforeCursor(length: Integer; flags: Integer): JCharSequence; cdecl;
    function performContextMenuAction(id: Integer): Boolean; cdecl;
    function performEditorAction(actionCode: Integer): Boolean; cdecl;
    function performPrivateCommand(action: JString; data: JBundle): Boolean; cdecl;
    function reportFullscreenMode(enabled: Boolean): Boolean; cdecl;
    function requestCursorUpdates(cursorUpdateMode: Integer): Boolean; cdecl;
    function sendKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function setComposingRegion(start: Integer; end_: Integer): Boolean; cdecl;
    function setComposingText(text: JCharSequence; newCursorPosition: Integer): Boolean; cdecl;
    function setSelection(start: Integer; end_: Integer): Boolean; cdecl;
  end;
  TJBaseInputConnection = class(TJavaGenericImport<JBaseInputConnectionClass, JBaseInputConnection>) end;

  JCompletionInfoClass = interface(JObjectClass)
    ['{9720ED4C-1222-4EBD-A4B3-7806D9E5BA79}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: Int64; index: Integer; text: JCharSequence): JCompletionInfo; cdecl; overload;
    {class} function init(id: Int64; index: Integer; text: JCharSequence; label_: JCharSequence): JCompletionInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/inputmethod/CompletionInfo')]
  JCompletionInfo = interface(JObject)
    ['{3B9797AB-1BDC-4C21-A88E-741E865398A4}']
    function describeContents: Integer; cdecl;
    function getId: Int64; cdecl;
    function getLabel: JCharSequence; cdecl;
    function getPosition: Integer; cdecl;
    function getText: JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCompletionInfo = class(TJavaGenericImport<JCompletionInfoClass, JCompletionInfo>) end;

  JCorrectionInfoClass = interface(JObjectClass)
    ['{34F793B9-F218-4224-89AC-20EEA48F830C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(offset: Integer; oldText: JCharSequence; newText: JCharSequence): JCorrectionInfo; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/inputmethod/CorrectionInfo')]
  JCorrectionInfo = interface(JObject)
    ['{8C4FD364-59EB-486A-AD7F-0C10204A5115}']
    function describeContents: Integer; cdecl;
    function getNewText: JCharSequence; cdecl;
    function getOffset: Integer; cdecl;
    function getOldText: JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCorrectionInfo = class(TJavaGenericImport<JCorrectionInfoClass, JCorrectionInfo>) end;

  JCursorAnchorInfoClass = interface(JObjectClass)
    ['{5CD9CCE5-5B41-4A42-B141-1AC742578F1C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_HAS_INVISIBLE_REGION: Integer; cdecl;
    {class} function _GetFLAG_HAS_VISIBLE_REGION: Integer; cdecl;
    {class} function _GetFLAG_IS_RTL: Integer; cdecl;
    {class} function init(source: JParcel): JCursorAnchorInfo; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_HAS_INVISIBLE_REGION: Integer read _GetFLAG_HAS_INVISIBLE_REGION;
    {class} property FLAG_HAS_VISIBLE_REGION: Integer read _GetFLAG_HAS_VISIBLE_REGION;
    {class} property FLAG_IS_RTL: Integer read _GetFLAG_IS_RTL;
  end;

  [JavaSignature('android/view/inputmethod/CursorAnchorInfo')]
  JCursorAnchorInfo = interface(JObject)
    ['{D3BDD98A-DD05-447F-AA02-6265038ADE9E}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getCharacterBounds(index: Integer): JRectF; cdecl;
    function getCharacterBoundsFlags(index: Integer): Integer; cdecl;
    function getComposingText: JCharSequence; cdecl;
    function getComposingTextStart: Integer; cdecl;
    function getInsertionMarkerBaseline: Single; cdecl;
    function getInsertionMarkerBottom: Single; cdecl;
    function getInsertionMarkerFlags: Integer; cdecl;
    function getInsertionMarkerHorizontal: Single; cdecl;
    function getInsertionMarkerTop: Single; cdecl;
    function getMatrix: JMatrix; cdecl;
    function getSelectionEnd: Integer; cdecl;
    function getSelectionStart: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCursorAnchorInfo = class(TJavaGenericImport<JCursorAnchorInfoClass, JCursorAnchorInfo>) end;

  JCursorAnchorInfo_BuilderClass = interface(JObjectClass)
    ['{D1ED88CB-8228-4F49-AA71-AD48B2BED160}']
    {class} function init: JCursorAnchorInfo_Builder; cdecl;
  end;

  [JavaSignature('android/view/inputmethod/CursorAnchorInfo$Builder')]
  JCursorAnchorInfo_Builder = interface(JObject)
    ['{C7544419-B8EF-4DA9-B6DB-849C9E622B8E}']
    function addCharacterBounds(index: Integer; left: Single; top: Single; right: Single; bottom: Single; flags: Integer): JCursorAnchorInfo_Builder; cdecl;
    function build: JCursorAnchorInfo; cdecl;
    procedure reset; cdecl;
    function setComposingText(composingTextStart: Integer; composingText: JCharSequence): JCursorAnchorInfo_Builder; cdecl;
    function setInsertionMarkerLocation(horizontalPosition: Single; lineTop: Single; lineBaseline: Single; lineBottom: Single; flags: Integer): JCursorAnchorInfo_Builder; cdecl;
    function setMatrix(matrix: JMatrix): JCursorAnchorInfo_Builder; cdecl;
    function setSelectionRange(newStart: Integer; newEnd: Integer): JCursorAnchorInfo_Builder; cdecl;
  end;
  TJCursorAnchorInfo_Builder = class(TJavaGenericImport<JCursorAnchorInfo_BuilderClass, JCursorAnchorInfo_Builder>) end;

  JEditorInfoClass = interface(JObjectClass)
    ['{86A3770F-C28B-4553-8DD5-3BE7E4DBD2BF}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetIME_ACTION_DONE: Integer; cdecl;
    {class} function _GetIME_ACTION_GO: Integer; cdecl;
    {class} function _GetIME_ACTION_NEXT: Integer; cdecl;
    {class} function _GetIME_ACTION_NONE: Integer; cdecl;
    {class} function _GetIME_ACTION_PREVIOUS: Integer; cdecl;
    {class} function _GetIME_ACTION_SEARCH: Integer; cdecl;
    {class} function _GetIME_ACTION_SEND: Integer; cdecl;
    {class} function _GetIME_ACTION_UNSPECIFIED: Integer; cdecl;
    {class} function _GetIME_FLAG_FORCE_ASCII: Integer; cdecl;
    {class} function _GetIME_FLAG_NAVIGATE_NEXT: Integer; cdecl;
    {class} function _GetIME_FLAG_NAVIGATE_PREVIOUS: Integer; cdecl;
    {class} function _GetIME_FLAG_NO_ACCESSORY_ACTION: Integer; cdecl;
    {class} function _GetIME_FLAG_NO_ENTER_ACTION: Integer; cdecl;
    {class} function _GetIME_FLAG_NO_EXTRACT_UI: Integer; cdecl;
    {class} function _GetIME_FLAG_NO_FULLSCREEN: Integer; cdecl;
    {class} function _GetIME_MASK_ACTION: Integer; cdecl;
    {class} function _GetIME_NULL: Integer; cdecl;
    {class} function init: JEditorInfo; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property IME_ACTION_DONE: Integer read _GetIME_ACTION_DONE;
    {class} property IME_ACTION_GO: Integer read _GetIME_ACTION_GO;
    {class} property IME_ACTION_NEXT: Integer read _GetIME_ACTION_NEXT;
    {class} property IME_ACTION_NONE: Integer read _GetIME_ACTION_NONE;
    {class} property IME_ACTION_PREVIOUS: Integer read _GetIME_ACTION_PREVIOUS;
    {class} property IME_ACTION_SEARCH: Integer read _GetIME_ACTION_SEARCH;
    {class} property IME_ACTION_SEND: Integer read _GetIME_ACTION_SEND;
    {class} property IME_ACTION_UNSPECIFIED: Integer read _GetIME_ACTION_UNSPECIFIED;
    {class} property IME_FLAG_FORCE_ASCII: Integer read _GetIME_FLAG_FORCE_ASCII;
    {class} property IME_FLAG_NAVIGATE_NEXT: Integer read _GetIME_FLAG_NAVIGATE_NEXT;
    {class} property IME_FLAG_NAVIGATE_PREVIOUS: Integer read _GetIME_FLAG_NAVIGATE_PREVIOUS;
    {class} property IME_FLAG_NO_ACCESSORY_ACTION: Integer read _GetIME_FLAG_NO_ACCESSORY_ACTION;
    {class} property IME_FLAG_NO_ENTER_ACTION: Integer read _GetIME_FLAG_NO_ENTER_ACTION;
    {class} property IME_FLAG_NO_EXTRACT_UI: Integer read _GetIME_FLAG_NO_EXTRACT_UI;
    {class} property IME_FLAG_NO_FULLSCREEN: Integer read _GetIME_FLAG_NO_FULLSCREEN;
    {class} property IME_MASK_ACTION: Integer read _GetIME_MASK_ACTION;
    {class} property IME_NULL: Integer read _GetIME_NULL;
  end;

  [JavaSignature('android/view/inputmethod/EditorInfo')]
  JEditorInfo = interface(JObject)
    ['{9D8B3117-5784-44CF-85A8-1845595D4A2C}']
    function _GetactionId: Integer; cdecl;
    procedure _SetactionId(Value: Integer); cdecl;
    function _GetactionLabel: JCharSequence; cdecl;
    procedure _SetactionLabel(Value: JCharSequence); cdecl;
    function _Getextras: JBundle; cdecl;
    procedure _Setextras(Value: JBundle); cdecl;
    function _GetfieldId: Integer; cdecl;
    procedure _SetfieldId(Value: Integer); cdecl;
    function _GetfieldName: JString; cdecl;
    procedure _SetfieldName(Value: JString); cdecl;
    function _GethintText: JCharSequence; cdecl;
    procedure _SethintText(Value: JCharSequence); cdecl;
    function _GetimeOptions: Integer; cdecl;
    procedure _SetimeOptions(Value: Integer); cdecl;
    function _GetinitialCapsMode: Integer; cdecl;
    procedure _SetinitialCapsMode(Value: Integer); cdecl;
    function _GetinitialSelEnd: Integer; cdecl;
    procedure _SetinitialSelEnd(Value: Integer); cdecl;
    function _GetinitialSelStart: Integer; cdecl;
    procedure _SetinitialSelStart(Value: Integer); cdecl;
    function _GetinputType: Integer; cdecl;
    procedure _SetinputType(Value: Integer); cdecl;
    function _Getlabel: JCharSequence; cdecl;
    procedure _Setlabel(Value: JCharSequence); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function _GetprivateImeOptions: JString; cdecl;
    procedure _SetprivateImeOptions(Value: JString); cdecl;
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    procedure makeCompatible(targetSdkVersion: Integer); cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property actionId: Integer read _GetactionId write _SetactionId;
    property actionLabel: JCharSequence read _GetactionLabel write _SetactionLabel;
    property extras: JBundle read _Getextras write _Setextras;
    property fieldId: Integer read _GetfieldId write _SetfieldId;
    property fieldName: JString read _GetfieldName write _SetfieldName;
    property hintText: JCharSequence read _GethintText write _SethintText;
    property imeOptions: Integer read _GetimeOptions write _SetimeOptions;
    property initialCapsMode: Integer read _GetinitialCapsMode write _SetinitialCapsMode;
    property initialSelEnd: Integer read _GetinitialSelEnd write _SetinitialSelEnd;
    property initialSelStart: Integer read _GetinitialSelStart write _SetinitialSelStart;
    property inputType: Integer read _GetinputType write _SetinputType;
    property &label: JCharSequence read _Getlabel write _Setlabel;
    property packageName: JString read _GetpackageName write _SetpackageName;
    property privateImeOptions: JString read _GetprivateImeOptions write _SetprivateImeOptions;
  end;
  TJEditorInfo = class(TJavaGenericImport<JEditorInfoClass, JEditorInfo>) end;

  JExtractedTextClass = interface(JObjectClass)
    ['{D8A18C24-B8D8-499D-B2D7-1A4B41EBF674}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFLAG_SELECTING: Integer; cdecl;
    {class} function _GetFLAG_SINGLE_LINE: Integer; cdecl;
    {class} function init: JExtractedText; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FLAG_SELECTING: Integer read _GetFLAG_SELECTING;
    {class} property FLAG_SINGLE_LINE: Integer read _GetFLAG_SINGLE_LINE;
  end;

  [JavaSignature('android/view/inputmethod/ExtractedText')]
  JExtractedText = interface(JObject)
    ['{53D94752-ABC7-45F2-85F8-D4517C7452C5}']
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GetpartialEndOffset: Integer; cdecl;
    procedure _SetpartialEndOffset(Value: Integer); cdecl;
    function _GetpartialStartOffset: Integer; cdecl;
    procedure _SetpartialStartOffset(Value: Integer); cdecl;
    function _GetselectionEnd: Integer; cdecl;
    procedure _SetselectionEnd(Value: Integer); cdecl;
    function _GetselectionStart: Integer; cdecl;
    procedure _SetselectionStart(Value: Integer); cdecl;
    function _GetstartOffset: Integer; cdecl;
    procedure _SetstartOffset(Value: Integer); cdecl;
    function _Gettext: JCharSequence; cdecl;
    procedure _Settext(Value: JCharSequence); cdecl;
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property flags: Integer read _Getflags write _Setflags;
    property partialEndOffset: Integer read _GetpartialEndOffset write _SetpartialEndOffset;
    property partialStartOffset: Integer read _GetpartialStartOffset write _SetpartialStartOffset;
    property selectionEnd: Integer read _GetselectionEnd write _SetselectionEnd;
    property selectionStart: Integer read _GetselectionStart write _SetselectionStart;
    property startOffset: Integer read _GetstartOffset write _SetstartOffset;
    property text: JCharSequence read _Gettext write _Settext;
  end;
  TJExtractedText = class(TJavaGenericImport<JExtractedTextClass, JExtractedText>) end;

  JExtractedTextRequestClass = interface(JObjectClass)
    ['{440AAAA9-C797-4705-B105-0782D243E191}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JExtractedTextRequest; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/inputmethod/ExtractedTextRequest')]
  JExtractedTextRequest = interface(JObject)
    ['{F26402AD-9FFC-428F-9FAB-2445588990AB}']
    function _Getflags: Integer; cdecl;
    procedure _Setflags(Value: Integer); cdecl;
    function _GethintMaxChars: Integer; cdecl;
    procedure _SethintMaxChars(Value: Integer); cdecl;
    function _GethintMaxLines: Integer; cdecl;
    procedure _SethintMaxLines(Value: Integer); cdecl;
    function _Gettoken: Integer; cdecl;
    procedure _Settoken(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property flags: Integer read _Getflags write _Setflags;
    property hintMaxChars: Integer read _GethintMaxChars write _SethintMaxChars;
    property hintMaxLines: Integer read _GethintMaxLines write _SethintMaxLines;
    property token: Integer read _Gettoken write _Settoken;
  end;
  TJExtractedTextRequest = class(TJavaGenericImport<JExtractedTextRequestClass, JExtractedTextRequest>) end;

  JInputBindingClass = interface(JObjectClass)
    ['{743151AD-B779-42A1-99B0-24965834D4D9}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(conn: JInputConnection; connToken: JIBinder; uid: Integer; pid: Integer): JInputBinding; cdecl; overload;
    {class} function init(conn: JInputConnection; binding: JInputBinding): JInputBinding; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/inputmethod/InputBinding')]
  JInputBinding = interface(JObject)
    ['{53198C86-E9C0-4F14-A6BC-B1C54246355F}']
    function describeContents: Integer; cdecl;
    function getConnection: JInputConnection; cdecl;
    function getConnectionToken: JIBinder; cdecl;
    function getPid: Integer; cdecl;
    function getUid: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJInputBinding = class(TJavaGenericImport<JInputBindingClass, JInputBinding>) end;

  JInputConnectionClass = interface(IJavaClass)
    ['{0A80826B-3A89-47EE-9F02-2F2D8793B30E}']
    {class} function _GetCURSOR_UPDATE_IMMEDIATE: Integer; cdecl;
    {class} function _GetCURSOR_UPDATE_MONITOR: Integer; cdecl;
    {class} function _GetGET_EXTRACTED_TEXT_MONITOR: Integer; cdecl;
    {class} function _GetGET_TEXT_WITH_STYLES: Integer; cdecl;
    {class} property CURSOR_UPDATE_IMMEDIATE: Integer read _GetCURSOR_UPDATE_IMMEDIATE;
    {class} property CURSOR_UPDATE_MONITOR: Integer read _GetCURSOR_UPDATE_MONITOR;
    {class} property GET_EXTRACTED_TEXT_MONITOR: Integer read _GetGET_EXTRACTED_TEXT_MONITOR;
    {class} property GET_TEXT_WITH_STYLES: Integer read _GetGET_TEXT_WITH_STYLES;
  end;

  [JavaSignature('android/view/inputmethod/InputConnection')]
  JInputConnection = interface(IJavaInstance)
    ['{4C729CD3-F58A-4053-94E1-7F280F3B42EF}']
    function beginBatchEdit: Boolean; cdecl;
    function clearMetaKeyStates(states: Integer): Boolean; cdecl;
    function commitCompletion(text: JCompletionInfo): Boolean; cdecl;
    function commitCorrection(correctionInfo: JCorrectionInfo): Boolean; cdecl;
    function commitText(text: JCharSequence; newCursorPosition: Integer): Boolean; cdecl;
    function deleteSurroundingText(beforeLength: Integer; afterLength: Integer): Boolean; cdecl;
    function endBatchEdit: Boolean; cdecl;
    function finishComposingText: Boolean; cdecl;
    function getCursorCapsMode(reqModes: Integer): Integer; cdecl;
    function getExtractedText(request: JExtractedTextRequest; flags: Integer): JExtractedText; cdecl;
    function getSelectedText(flags: Integer): JCharSequence; cdecl;
    function getTextAfterCursor(n: Integer; flags: Integer): JCharSequence; cdecl;
    function getTextBeforeCursor(n: Integer; flags: Integer): JCharSequence; cdecl;
    function performContextMenuAction(id: Integer): Boolean; cdecl;
    function performEditorAction(editorAction: Integer): Boolean; cdecl;
    function performPrivateCommand(action: JString; data: JBundle): Boolean; cdecl;
    function reportFullscreenMode(enabled: Boolean): Boolean; cdecl;
    function requestCursorUpdates(cursorUpdateMode: Integer): Boolean; cdecl;
    function sendKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function setComposingRegion(start: Integer; end_: Integer): Boolean; cdecl;
    function setComposingText(text: JCharSequence; newCursorPosition: Integer): Boolean; cdecl;
    function setSelection(start: Integer; end_: Integer): Boolean; cdecl;
  end;
  TJInputConnection = class(TJavaGenericImport<JInputConnectionClass, JInputConnection>) end;

  JInputConnectionWrapperClass = interface(JObjectClass)
    ['{3BA5DB87-DFF3-481E-80E4-C77B379A7302}']
    {class} function init(target: JInputConnection; mutable: Boolean): JInputConnectionWrapper; cdecl;
  end;

  [JavaSignature('android/view/inputmethod/InputConnectionWrapper')]
  JInputConnectionWrapper = interface(JObject)
    ['{E5C3C7C9-8428-4ED4-B92C-058B1017500B}']
    function beginBatchEdit: Boolean; cdecl;
    function clearMetaKeyStates(states: Integer): Boolean; cdecl;
    function commitCompletion(text: JCompletionInfo): Boolean; cdecl;
    function commitCorrection(correctionInfo: JCorrectionInfo): Boolean; cdecl;
    function commitText(text: JCharSequence; newCursorPosition: Integer): Boolean; cdecl;
    function deleteSurroundingText(beforeLength: Integer; afterLength: Integer): Boolean; cdecl;
    function endBatchEdit: Boolean; cdecl;
    function finishComposingText: Boolean; cdecl;
    function getCursorCapsMode(reqModes: Integer): Integer; cdecl;
    function getExtractedText(request: JExtractedTextRequest; flags: Integer): JExtractedText; cdecl;
    function getSelectedText(flags: Integer): JCharSequence; cdecl;
    function getTextAfterCursor(n: Integer; flags: Integer): JCharSequence; cdecl;
    function getTextBeforeCursor(n: Integer; flags: Integer): JCharSequence; cdecl;
    function performContextMenuAction(id: Integer): Boolean; cdecl;
    function performEditorAction(editorAction: Integer): Boolean; cdecl;
    function performPrivateCommand(action: JString; data: JBundle): Boolean; cdecl;
    function reportFullscreenMode(enabled: Boolean): Boolean; cdecl;
    function requestCursorUpdates(cursorUpdateMode: Integer): Boolean; cdecl;
    function sendKeyEvent(event: JKeyEvent): Boolean; cdecl;
    function setComposingRegion(start: Integer; end_: Integer): Boolean; cdecl;
    function setComposingText(text: JCharSequence; newCursorPosition: Integer): Boolean; cdecl;
    function setSelection(start: Integer; end_: Integer): Boolean; cdecl;
    procedure setTarget(target: JInputConnection); cdecl;
  end;
  TJInputConnectionWrapper = class(TJavaGenericImport<JInputConnectionWrapperClass, JInputConnectionWrapper>) end;

  JInputMethodClass = interface(IJavaClass)
    ['{A413E3D4-C4F1-487F-90E7-C066E4C38802}']
    {class} function _GetSERVICE_INTERFACE: JString; cdecl;
    {class} function _GetSERVICE_META_DATA: JString; cdecl;
    {class} function _GetSHOW_EXPLICIT: Integer; cdecl;
    {class} function _GetSHOW_FORCED: Integer; cdecl;
    {class} property SERVICE_INTERFACE: JString read _GetSERVICE_INTERFACE;
    {class} property SERVICE_META_DATA: JString read _GetSERVICE_META_DATA;
    {class} property SHOW_EXPLICIT: Integer read _GetSHOW_EXPLICIT;
    {class} property SHOW_FORCED: Integer read _GetSHOW_FORCED;
  end;

  [JavaSignature('android/view/inputmethod/InputMethod')]
  JInputMethod = interface(IJavaInstance)
    ['{072935DE-7CB2-43CA-A3F5-024BA6FC5F04}']
    procedure attachToken(token: JIBinder); cdecl;
    procedure bindInput(binding: JInputBinding); cdecl;
    procedure changeInputMethodSubtype(subtype: JInputMethodSubtype); cdecl;
    procedure createSession(callback: JInputMethod_SessionCallback); cdecl;
    procedure hideSoftInput(flags: Integer; resultReceiver: JResultReceiver); cdecl;
    procedure restartInput(inputConnection: JInputConnection; attribute: JEditorInfo); cdecl;
    procedure revokeSession(session: JInputMethodSession); cdecl;
    procedure setSessionEnabled(session: JInputMethodSession; enabled: Boolean); cdecl;
    procedure showSoftInput(flags: Integer; resultReceiver: JResultReceiver); cdecl;
    procedure startInput(inputConnection: JInputConnection; info: JEditorInfo); cdecl;
    procedure unbindInput; cdecl;
  end;
  TJInputMethod = class(TJavaGenericImport<JInputMethodClass, JInputMethod>) end;

  JInputMethod_SessionCallbackClass = interface(IJavaClass)
    ['{493EE3FA-B9E7-4212-840C-BB207BFDEA2C}']
  end;

  [JavaSignature('android/view/inputmethod/InputMethod$SessionCallback')]
  JInputMethod_SessionCallback = interface(IJavaInstance)
    ['{FA9324BD-9C4F-4C26-9765-1604AF615B5F}']
    procedure sessionCreated(session: JInputMethodSession); cdecl;
  end;
  TJInputMethod_SessionCallback = class(TJavaGenericImport<JInputMethod_SessionCallbackClass, JInputMethod_SessionCallback>) end;

  JInputMethodInfoClass = interface(JObjectClass)
    ['{FBCAFC39-0F74-488C-9502-0C83FB8860CE}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(context: JContext; service: JResolveInfo): JInputMethodInfo; cdecl; overload;
    {class} function init(packageName: JString; className: JString; label_: JCharSequence; settingsActivity: JString): JInputMethodInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/inputmethod/InputMethodInfo')]
  JInputMethodInfo = interface(JObject)
    ['{F8FE6EFB-8F51-4BB7-B76F-E0F8BFF93CE6}']
    function describeContents: Integer; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getComponent: JComponentName; cdecl;
    function getId: JString; cdecl;
    function getIsDefaultResourceId: Integer; cdecl;
    function getPackageName: JString; cdecl;
    function getServiceInfo: JServiceInfo; cdecl;
    function getServiceName: JString; cdecl;
    function getSettingsActivity: JString; cdecl;
    function getSubtypeAt(index: Integer): JInputMethodSubtype; cdecl;
    function getSubtypeCount: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function loadIcon(pm: JPackageManager): JDrawable; cdecl;
    function loadLabel(pm: JPackageManager): JCharSequence; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJInputMethodInfo = class(TJavaGenericImport<JInputMethodInfoClass, JInputMethodInfo>) end;

  JInputMethodManagerClass = interface(JObjectClass)
    ['{EBEE74C0-AA6B-4588-92FC-18172558D880}']
    {class} function _GetHIDE_IMPLICIT_ONLY: Integer; cdecl;
    {class} function _GetHIDE_NOT_ALWAYS: Integer; cdecl;
    {class} function _GetRESULT_HIDDEN: Integer; cdecl;
    {class} function _GetRESULT_SHOWN: Integer; cdecl;
    {class} function _GetRESULT_UNCHANGED_HIDDEN: Integer; cdecl;
    {class} function _GetRESULT_UNCHANGED_SHOWN: Integer; cdecl;
    {class} function _GetSHOW_FORCED: Integer; cdecl;
    {class} function _GetSHOW_IMPLICIT: Integer; cdecl;
    {class} property HIDE_IMPLICIT_ONLY: Integer read _GetHIDE_IMPLICIT_ONLY;
    {class} property HIDE_NOT_ALWAYS: Integer read _GetHIDE_NOT_ALWAYS;
    {class} property RESULT_HIDDEN: Integer read _GetRESULT_HIDDEN;
    {class} property RESULT_SHOWN: Integer read _GetRESULT_SHOWN;
    {class} property RESULT_UNCHANGED_HIDDEN: Integer read _GetRESULT_UNCHANGED_HIDDEN;
    {class} property RESULT_UNCHANGED_SHOWN: Integer read _GetRESULT_UNCHANGED_SHOWN;
    {class} property SHOW_FORCED: Integer read _GetSHOW_FORCED;
    {class} property SHOW_IMPLICIT: Integer read _GetSHOW_IMPLICIT;
  end;

  [JavaSignature('android/view/inputmethod/InputMethodManager')]
  JInputMethodManager = interface(JObject)
    ['{D2C04F98-0614-4251-B7A7-5479A0EFDFE2}']
    procedure displayCompletions(view: JView; completions: TJavaObjectArray<JCompletionInfo>); cdecl;
    function getCurrentInputMethodSubtype: JInputMethodSubtype; cdecl;
    function getEnabledInputMethodList: JList; cdecl;
    function getEnabledInputMethodSubtypeList(imi: JInputMethodInfo; allowsImplicitlySelectedSubtypes: Boolean): JList; cdecl;
    function getInputMethodList: JList; cdecl;
    function getLastInputMethodSubtype: JInputMethodSubtype; cdecl;
    function getShortcutInputMethodsAndSubtypes: JMap; cdecl;
    procedure hideSoftInputFromInputMethod(token: JIBinder; flags: Integer); cdecl;
    function hideSoftInputFromWindow(windowToken: JIBinder; flags: Integer): Boolean; cdecl; overload;
    function hideSoftInputFromWindow(windowToken: JIBinder; flags: Integer; resultReceiver: JResultReceiver): Boolean; cdecl; overload;
    procedure hideStatusIcon(imeToken: JIBinder); cdecl;
    function isAcceptingText: Boolean; cdecl;
    function isActive(view: JView): Boolean; cdecl; overload;
    function isActive: Boolean; cdecl; overload;
    function isFullscreenMode: Boolean; cdecl;
    function isWatchingCursor(view: JView): Boolean; cdecl;//Deprecated
    procedure restartInput(view: JView); cdecl;
    procedure sendAppPrivateCommand(view: JView; action: JString; data: JBundle); cdecl;
    procedure setAdditionalInputMethodSubtypes(imiId: JString; subtypes: TJavaObjectArray<JInputMethodSubtype>); cdecl;
    function setCurrentInputMethodSubtype(subtype: JInputMethodSubtype): Boolean; cdecl;
    procedure setInputMethod(token: JIBinder; id: JString); cdecl;
    procedure setInputMethodAndSubtype(token: JIBinder; id: JString; subtype: JInputMethodSubtype); cdecl;
    function shouldOfferSwitchingToNextInputMethod(imeToken: JIBinder): Boolean; cdecl;
    procedure showInputMethodAndSubtypeEnabler(imiId: JString); cdecl;
    procedure showInputMethodPicker; cdecl;
    function showSoftInput(view: JView; flags: Integer): Boolean; cdecl; overload;
    function showSoftInput(view: JView; flags: Integer; resultReceiver: JResultReceiver): Boolean; cdecl; overload;
    procedure showSoftInputFromInputMethod(token: JIBinder; flags: Integer); cdecl;
    procedure showStatusIcon(imeToken: JIBinder; packageName: JString; iconId: Integer); cdecl;
    function switchToLastInputMethod(imeToken: JIBinder): Boolean; cdecl;
    function switchToNextInputMethod(imeToken: JIBinder; onlyCurrentIme: Boolean): Boolean; cdecl;
    procedure toggleSoftInput(showFlags: Integer; hideFlags: Integer); cdecl;
    procedure toggleSoftInputFromWindow(windowToken: JIBinder; showFlags: Integer; hideFlags: Integer); cdecl;
    procedure updateCursor(view: JView; left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;//Deprecated
    procedure updateCursorAnchorInfo(view: JView; cursorAnchorInfo: JCursorAnchorInfo); cdecl;
    procedure updateExtractedText(view: JView; token: Integer; text: JExtractedText); cdecl;
    procedure updateSelection(view: JView; selStart: Integer; selEnd: Integer; candidatesStart: Integer; candidatesEnd: Integer); cdecl;
    procedure viewClicked(view: JView); cdecl;
  end;
  TJInputMethodManager = class(TJavaGenericImport<JInputMethodManagerClass, JInputMethodManager>) end;

  JInputMethodSessionClass = interface(IJavaClass)
    ['{AB35CFBC-A6CC-4235-84A0-848A44DC9A9E}']
  end;

  [JavaSignature('android/view/inputmethod/InputMethodSession')]
  JInputMethodSession = interface(IJavaInstance)
    ['{7F038217-AC6A-4F44-B0DC-4C9D564BBE06}']
    procedure appPrivateCommand(action: JString; data: JBundle); cdecl;
    procedure dispatchGenericMotionEvent(seq: Integer; event: JMotionEvent; callback: JInputMethodSession_EventCallback); cdecl;
    procedure dispatchKeyEvent(seq: Integer; event: JKeyEvent; callback: JInputMethodSession_EventCallback); cdecl;
    procedure dispatchTrackballEvent(seq: Integer; event: JMotionEvent; callback: JInputMethodSession_EventCallback); cdecl;
    procedure displayCompletions(completions: TJavaObjectArray<JCompletionInfo>); cdecl;
    procedure finishInput; cdecl;
    procedure toggleSoftInput(showFlags: Integer; hideFlags: Integer); cdecl;
    procedure updateCursor(newCursor: JRect); cdecl;
    procedure updateCursorAnchorInfo(cursorAnchorInfo: JCursorAnchorInfo); cdecl;
    procedure updateExtractedText(token: Integer; text: JExtractedText); cdecl;
    procedure updateSelection(oldSelStart: Integer; oldSelEnd: Integer; newSelStart: Integer; newSelEnd: Integer; candidatesStart: Integer; candidatesEnd: Integer); cdecl;
    procedure viewClicked(focusChanged: Boolean); cdecl;
  end;
  TJInputMethodSession = class(TJavaGenericImport<JInputMethodSessionClass, JInputMethodSession>) end;

  JInputMethodSession_EventCallbackClass = interface(IJavaClass)
    ['{DC00D9CC-2852-44F7-9D2B-B1FD068D2FD0}']
  end;

  [JavaSignature('android/view/inputmethod/InputMethodSession$EventCallback')]
  JInputMethodSession_EventCallback = interface(IJavaInstance)
    ['{EA9CD00C-A636-46C5-A4B4-1FEC7600B74E}']
    procedure finishedEvent(seq: Integer; handled: Boolean); cdecl;
  end;
  TJInputMethodSession_EventCallback = class(TJavaGenericImport<JInputMethodSession_EventCallbackClass, JInputMethodSession_EventCallback>) end;

  JInputMethodSubtypeClass = interface(JObjectClass)
    ['{A4198834-6CE2-445E-9B56-9A46DA9B8FD1}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(nameId: Integer; iconId: Integer; locale: JString; mode: JString; extraValue: JString; isAuxiliary: Boolean; overridesImplicitlyEnabledSubtype: Boolean): JInputMethodSubtype; cdecl; overload;//Deprecated
    {class} function init(nameId: Integer; iconId: Integer; locale: JString; mode: JString; extraValue: JString; isAuxiliary: Boolean; overridesImplicitlyEnabledSubtype: Boolean; id: Integer): JInputMethodSubtype; cdecl; overload;//Deprecated
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/view/inputmethod/InputMethodSubtype')]
  JInputMethodSubtype = interface(JObject)
    ['{0BB46363-838A-4B33-81A3-9E7A33F90382}']
    function containsExtraValueKey(key: JString): Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getDisplayName(context: JContext; packageName: JString; appInfo: JApplicationInfo): JCharSequence; cdecl;
    function getExtraValue: JString; cdecl;
    function getExtraValueOf(key: JString): JString; cdecl;
    function getIconResId: Integer; cdecl;
    function getLocale: JString; cdecl;
    function getMode: JString; cdecl;
    function getNameResId: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isAsciiCapable: Boolean; cdecl;
    function isAuxiliary: Boolean; cdecl;
    function overridesImplicitlyEnabledSubtype: Boolean; cdecl;
    procedure writeToParcel(dest: JParcel; parcelableFlags: Integer); cdecl;
  end;
  TJInputMethodSubtype = class(TJavaGenericImport<JInputMethodSubtypeClass, JInputMethodSubtype>) end;

  JInputMethodSubtype_InputMethodSubtypeBuilderClass = interface(JObjectClass)
    ['{87F70DFA-7896-481E-B92C-6103525CB196}']
    {class} function init: JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
  end;

  [JavaSignature('android/view/inputmethod/InputMethodSubtype$InputMethodSubtypeBuilder')]
  JInputMethodSubtype_InputMethodSubtypeBuilder = interface(JObject)
    ['{D44B253D-C0FB-4406-A5CD-F9721973577A}']
    function build: JInputMethodSubtype; cdecl;
    function setIsAsciiCapable(isAsciiCapable: Boolean): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setIsAuxiliary(isAuxiliary: Boolean): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setOverridesImplicitlyEnabledSubtype(overridesImplicitlyEnabledSubtype: Boolean): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setSubtypeExtraValue(subtypeExtraValue: JString): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setSubtypeIconResId(subtypeIconResId: Integer): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setSubtypeId(subtypeId: Integer): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setSubtypeLocale(subtypeLocale: JString): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setSubtypeMode(subtypeMode: JString): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
    function setSubtypeNameResId(subtypeNameResId: Integer): JInputMethodSubtype_InputMethodSubtypeBuilder; cdecl;
  end;
  TJInputMethodSubtype_InputMethodSubtypeBuilder = class(TJavaGenericImport<JInputMethodSubtype_InputMethodSubtypeBuilderClass, JInputMethodSubtype_InputMethodSubtypeBuilder>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAbstractThreadedSyncAdapter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAbstractThreadedSyncAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JActivityNotFoundException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JActivityNotFoundException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAsyncQueryHandler', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAsyncQueryHandler));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLoader', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLoader));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAsyncTaskLoader', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAsyncTaskLoader));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBroadcastReceiver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBroadcastReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBroadcastReceiver_PendingResult', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBroadcastReceiver_PendingResult));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClipData', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClipData));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClipData_Item', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClipData_Item));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClipDescription', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClipDescription));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClipboardManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClipboardManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.Jcontent_ClipboardManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.Jcontent_ClipboardManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClipboardManager_OnPrimaryClipChangedListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClipboardManager_OnPrimaryClipChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JComponentCallbacks', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JComponentCallbacks));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JComponentCallbacks2', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JComponentCallbacks2));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JComponentName', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JComponentName));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentProvider', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentProvider));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentProvider_PipeDataWriter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentProvider_PipeDataWriter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentProviderClient', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentProviderClient));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentProviderOperation', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentProviderOperation));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentProviderOperation_Builder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentProviderOperation_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentProviderResult', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentProviderResult));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentQueryMap', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentQueryMap));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentResolver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentResolver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentUris', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentUris));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentValues', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentValues));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContext', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContext));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContextWrapper', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContextWrapper));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCursorLoader', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCursorLoader));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnCancelListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnCancelListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnDismissListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnDismissListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnKeyListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnKeyListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnMultiChoiceClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnMultiChoiceClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnShowListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDialogInterface_OnShowListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.Jcontent_Entity', TypeInfo(Androidapi.JNI.GraphicsContentViewText.Jcontent_Entity));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JEntity_NamedContentValues', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JEntity_NamedContentValues));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JEntityIterator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JEntityIterator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntent_FilterComparison', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntent_FilterComparison));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntent_ShortcutIconResource', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntent_ShortcutIconResource));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntentFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntentFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntentFilter_AuthorityEntry', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntentFilter_AuthorityEntry));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntentFilter_MalformedMimeTypeException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntentFilter_MalformedMimeTypeException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntentSender', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntentSender));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntentSender_OnFinished', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntentSender_OnFinished));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIntentSender_SendIntentException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIntentSender_SendIntentException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContentObserver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContentObserver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLoader_ForceLoadContentObserver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLoader_ForceLoadContentObserver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLoader_OnLoadCanceledListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLoader_OnLoadCanceledListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLoader_OnLoadCompleteListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLoader_OnLoadCompleteListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMutableContextWrapper', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMutableContextWrapper));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JOperationApplicationException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JOperationApplicationException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPeriodicSync', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPeriodicSync));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JReceiverCallNotAllowedException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JReceiverCallNotAllowedException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRestrictionEntry', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRestrictionEntry));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRestrictionsManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRestrictionsManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSearchRecentSuggestionsProvider', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSearchRecentSuggestionsProvider));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JServiceConnection', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JServiceConnection));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSharedPreferences', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSharedPreferences));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSharedPreferences_Editor', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSharedPreferences_Editor));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSharedPreferences_OnSharedPreferenceChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSharedPreferences_OnSharedPreferenceChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncAdapterType', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncAdapterType));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncContext', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncContext));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncRequest', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncRequest));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncRequest_Builder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncRequest_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncResult', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncResult));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncStats', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncStats));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSyncStatusObserver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSyncStatusObserver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JUriMatcher', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JUriMatcher));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JUriPermission', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JUriPermission));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageItemInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageItemInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JComponentInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JComponentInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JActivityInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JActivityInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JApplicationInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JApplicationInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JApplicationInfo_DisplayNameComparator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JApplicationInfo_DisplayNameComparator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JConfigurationInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JConfigurationInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JFeatureGroupInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JFeatureGroupInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JFeatureInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JFeatureInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInstrumentationInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInstrumentationInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLabeledIntent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLabeledIntent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLauncherActivityInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLauncherActivityInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLauncherApps', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLauncherApps));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLauncherApps_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLauncherApps_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageInstaller', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageInstaller));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_Session', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_Session));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_SessionCallback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_SessionCallback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_SessionInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_SessionInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_SessionParams', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageInstaller_SessionParams));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageItemInfo_DisplayNameComparator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageItemInfo_DisplayNameComparator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageManager_NameNotFoundException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageManager_NameNotFoundException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPackageStats', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPackageStats));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPathPermission', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPathPermission));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPermissionGroupInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPermissionGroupInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPermissionInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPermissionInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JProviderInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JProviderInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JResolveInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JResolveInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JResolveInfo_DisplayNameComparator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JResolveInfo_DisplayNameComparator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JServiceInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JServiceInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSignature', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSignature));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAssetFileDescriptor', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAssetFileDescriptor));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAssetFileDescriptor_AutoCloseInputStream', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAssetFileDescriptor_AutoCloseInputStream));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAssetFileDescriptor_AutoCloseOutputStream', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAssetFileDescriptor_AutoCloseOutputStream));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAssetManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAssetManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAssetManager_AssetInputStream', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAssetManager_AssetInputStream));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JColorStateList', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JColorStateList));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JConfiguration', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JConfiguration));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JObbInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JObbInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JObbScanner', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JObbScanner));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JResources', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JResources));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JResources_NotFoundException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JResources_NotFoundException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JResources_Theme', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JResources_Theme));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTypedArray', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTypedArray));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JXmlResourceParser', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JXmlResourceParser));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAbstractCursor', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAbstractCursor));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAbstractWindowedCursor', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAbstractWindowedCursor));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.Jdatabase_CharArrayBuffer', TypeInfo(Androidapi.JNI.GraphicsContentViewText.Jdatabase_CharArrayBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCursor', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCursor));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteClosable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteClosable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCursorWindow', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCursorWindow));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDataSetObserver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDataSetObserver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDatabaseErrorHandler', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDatabaseErrorHandler));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteCursorDriver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteCursorDriver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteDatabase', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteDatabase));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteDatabase_CursorFactory', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteDatabase_CursorFactory));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteProgram', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteProgram));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteQuery', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteQuery));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteStatement', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteStatement));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSQLiteTransactionListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSQLiteTransactionListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JXfermode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JXfermode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAvoidXfermode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAvoidXfermode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAvoidXfermode_Mode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAvoidXfermode_Mode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmap', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmap));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmap_CompressFormat', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmap_CompressFormat));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmap_Config', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmap_Config));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmapFactory', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmapFactory));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmapFactory_Options', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmapFactory_Options));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmapRegionDecoder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmapRegionDecoder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JShader', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JShader));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmapShader', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmapShader));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMaskFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMaskFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBlurMaskFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBlurMaskFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBlurMaskFilter_Blur', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBlurMaskFilter_Blur));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.Jgraphics_Camera', TypeInfo(Androidapi.JNI.GraphicsContentViewText.Jgraphics_Camera));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCanvas', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCanvas));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCanvas_EdgeType', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCanvas_EdgeType));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCanvas_VertexMode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCanvas_VertexMode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCanvasProperty', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCanvasProperty));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JColor', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JColor));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JColorFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JColorFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JColorMatrix', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JColorMatrix));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JColorMatrixColorFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JColorMatrixColorFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JComposePathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JComposePathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JComposeShader', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JComposeShader));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCornerPathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCornerPathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDashPathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDashPathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDiscretePathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDiscretePathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JEmbossMaskFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JEmbossMaskFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JImageFormat', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JImageFormat));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.Jgraphics_Interpolator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.Jgraphics_Interpolator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInterpolator_Result', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInterpolator_Result));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRasterizer', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRasterizer));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayerRasterizer', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayerRasterizer));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLightingColorFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLightingColorFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLinearGradient', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLinearGradient));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMatrix', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMatrix));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMatrix_ScaleToFit', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMatrix_ScaleToFit));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMovie', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMovie));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JNinePatch', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JNinePatch));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JOutline', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JOutline));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint_Align', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint_Align));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint_Cap', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint_Cap));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint_FontMetrics', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint_FontMetrics));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint_FontMetricsInt', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint_FontMetricsInt));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint_Join', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint_Join));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaint_Style', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaint_Style));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaintFlagsDrawFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaintFlagsDrawFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPath', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPath));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPath_Direction', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPath_Direction));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPath_FillType', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPath_FillType));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPath_Op', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPath_Op));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPathDashPathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPathDashPathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPathDashPathEffect_Style', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPathDashPathEffect_Style));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPathMeasure', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPathMeasure));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPicture', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPicture));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPixelFormat', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPixelFormat));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPixelXorXfermode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPixelXorXfermode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPoint', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPoint));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPointF', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPointF));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPorterDuff', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPorterDuff));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPorterDuff_Mode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPorterDuff_Mode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPorterDuffColorFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPorterDuffColorFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPorterDuffXfermode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPorterDuffXfermode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRadialGradient', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRadialGradient));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRectF', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRectF));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRegion', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRegion));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRegion_Op', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRegion_Op));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRegionIterator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRegionIterator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JShader_TileMode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JShader_TileMode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSumPathEffect', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSumPathEffect));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceTexture', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceTexture));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceTexture_OnFrameAvailableListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceTexture_OnFrameAvailableListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceTexture_OutOfResourcesException', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceTexture_OutOfResourcesException));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSweepGradient', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSweepGradient));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTypeface', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTypeface));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JYuvImage', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JYuvImage));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimatable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimatable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimatable2', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimatable2));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimatable2_AnimationCallback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimatable2_AnimationCallback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawableContainer', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawableContainer));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JStateListDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JStateListDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimatedStateListDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimatedStateListDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimatedVectorDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimatedVectorDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimationDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimationDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBitmapDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBitmapDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawableWrapper', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawableWrapper));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClipDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClipDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JColorDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JColorDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawable_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawable_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawable_ConstantState', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawable_ConstantState));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDrawableContainer_DrawableContainerState', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDrawableContainer_DrawableContainerState));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGradientDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGradientDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGradientDrawable_Orientation', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGradientDrawable_Orientation));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIcon', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIcon));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JIcon_OnDrawableLoadedListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JIcon_OnDrawableLoadedListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInsetDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInsetDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayerDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayerDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLevelListDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLevelListDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JNinePatchDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JNinePatchDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JShapeDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JShapeDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPaintDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPaintDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPictureDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPictureDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRippleComponent_RenderNodeAnimatorSet', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRippleComponent_RenderNodeAnimatorSet));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRippleDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRippleDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRotateDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRotateDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JScaleDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JScaleDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JShapeDrawable_ShaderFactory', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JShapeDrawable_ShaderFactory));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTransitionDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTransitionDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JVectorDrawable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JVectorDrawable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JShape', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JShape));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRectShape', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRectShape));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JArcShape', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JArcShape));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JOvalShape', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JOvalShape));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPathShape', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPathShape));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRoundRectShape', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRoundRectShape));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPdfDocument', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPdfDocument));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPdfDocument_Page', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPdfDocument_Page));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPdfDocument_PageInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPdfDocument_PageInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPageInfo_Builder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPageInfo_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPdfRenderer', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPdfRenderer));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JPdfRenderer_Page', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JPdfRenderer_Page));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JEditable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JEditable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JEditable_Factory', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JEditable_Factory));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputFilter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputFilter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputType', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputType));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayout', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayout));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayout_Alignment', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayout_Alignment));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayout_Directions', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayout_Directions));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JNoCopySpan', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JNoCopySpan));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSpanned', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSpanned));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSpannable', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSpannable));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSpannable_Factory', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSpannable_Factory));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTextPaint', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTextPaint));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTextUtils_TruncateAt', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTextUtils_TruncateAt));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTextWatcher', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTextWatcher));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JKeyListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JKeyListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMovementMethod', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMovementMethod));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTransformationMethod', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTransformationMethod));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCharacterStyle', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCharacterStyle));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JClickableSpan', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JClickableSpan));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTtsSpan', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTtsSpan));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JURLSpan', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JURLSpan));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JActionMode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JActionMode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JActionMode_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JActionMode_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JActionProvider', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JActionProvider));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JActionProvider_VisibilityListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JActionProvider_VisibilityListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMenu', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMenu));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContextMenu', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContextMenu));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContextMenu_ContextMenuInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContextMenu_ContextMenuInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JContextThemeWrapper', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JContextThemeWrapper));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDisplay', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDisplay));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDisplay_Mode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDisplay_Mode));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDisplayListCanvas', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDisplayListCanvas));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JDragEvent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JDragEvent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGestureDetector', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGestureDetector));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGestureDetector_OnContextClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGestureDetector_OnContextClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGestureDetector_OnDoubleTapListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGestureDetector_OnDoubleTapListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGestureDetector_OnGestureListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGestureDetector_OnGestureListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JGestureDetector_SimpleOnGestureListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JGestureDetector_SimpleOnGestureListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputDevice', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputDevice));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputDevice_MotionRange', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputDevice_MotionRange));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputEvent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputEvent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputQueue', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputQueue));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputQueue_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputQueue_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JKeyCharacterMap', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JKeyCharacterMap));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JKeyCharacterMap_KeyData', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JKeyCharacterMap_KeyData));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JKeyEvent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JKeyEvent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JKeyEvent_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JKeyEvent_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JKeyEvent_DispatcherState', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JKeyEvent_DispatcherState));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayoutInflater', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayoutInflater));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayoutInflater_Factory', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayoutInflater_Factory));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayoutInflater_Factory2', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayoutInflater_Factory2));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayoutInflater_Filter', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayoutInflater_Filter));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMenuInflater', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMenuInflater));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMenuItem', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMenuItem));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMenuItem_OnActionExpandListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMenuItem_OnActionExpandListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMenuItem_OnMenuItemClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMenuItem_OnMenuItemClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMotionEvent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMotionEvent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMotionEvent_PointerCoords', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMotionEvent_PointerCoords));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JMotionEvent_PointerProperties', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JMotionEvent_PointerProperties));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRenderNode', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRenderNode));
  //TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JRenderNodeAnimator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JRenderNodeAnimator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JScaleGestureDetector', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JScaleGestureDetector));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JScaleGestureDetector_OnScaleGestureListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JScaleGestureDetector_OnScaleGestureListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JScaleGestureDetector_SimpleOnScaleGestureListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JScaleGestureDetector_SimpleOnScaleGestureListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSearchEvent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSearchEvent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSubMenu', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSubMenu));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurface', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurface));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceHolder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceHolder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceHolder_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceHolder_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceHolder_Callback2', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceHolder_Callback2));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JSurfaceView', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JSurfaceView));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTouchDelegate', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTouchDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_AccessibilityDelegate', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_AccessibilityDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_DragShadowBuilder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_DragShadowBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnApplyWindowInsetsListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnApplyWindowInsetsListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnAttachStateChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnAttachStateChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnContextClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnContextClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnCreateContextMenuListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnCreateContextMenuListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnDragListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnDragListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnFocusChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnFocusChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnGenericMotionListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnGenericMotionListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnHoverListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnHoverListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnKeyListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnKeyListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnLayoutChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnLayoutChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnLongClickListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnLongClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnScrollChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnScrollChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnSystemUiVisibilityChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnSystemUiVisibilityChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JView_OnTouchListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JView_OnTouchListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewGroup', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewGroup));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewGroup_LayoutParams', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewGroup_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewGroup_MarginLayoutParams', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewGroup_MarginLayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewGroup_OnHierarchyChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewGroup_OnHierarchyChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewOverlay', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewOverlay));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewGroupOverlay', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewGroupOverlay));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewOutlineProvider', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewOutlineProvider));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewParent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewParent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewPropertyAnimator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewPropertyAnimator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewStructure', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewStructure));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnDrawListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnDrawListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnGlobalFocusChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnGlobalFocusChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnGlobalLayoutListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnGlobalLayoutListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnPreDrawListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnPreDrawListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnScrollChangedListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnScrollChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnTouchModeChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnTouchModeChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnWindowAttachListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnWindowAttachListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnWindowFocusChangeListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JViewTreeObserver_OnWindowFocusChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindow', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindow));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindow_Callback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindow_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindowId', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindowId));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindowId_FocusObserver', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindowId_FocusObserver));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindowInsets', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindowInsets));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindowManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindowManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JWindowManager_LayoutParams', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JWindowManager_LayoutParams));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityRecord', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityRecord));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityEvent', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityEvent));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_AccessibilityAction', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_AccessibilityAction));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_CollectionInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_CollectionInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_CollectionItemInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_CollectionItemInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_RangeInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeInfo_RangeInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeProvider', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityNodeProvider));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAccessibilityWindowInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAccessibilityWindowInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimation', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimation));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JAnimation_AnimationListener', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JAnimation_AnimationListener));
  //TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInterpolator', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInterpolator));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayoutAnimationController', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayoutAnimationController));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JLayoutAnimationController_AnimationParameters', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JLayoutAnimationController_AnimationParameters));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JTransformation', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JTransformation));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JBaseInputConnection', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JBaseInputConnection));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCompletionInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCompletionInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCorrectionInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCorrectionInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCursorAnchorInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCursorAnchorInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JCursorAnchorInfo_Builder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JCursorAnchorInfo_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JEditorInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JEditorInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JExtractedText', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JExtractedText));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JExtractedTextRequest', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JExtractedTextRequest));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputBinding', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputBinding));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputConnection', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputConnection));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputConnectionWrapper', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputConnectionWrapper));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethod', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethod));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethod_SessionCallback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethod_SessionCallback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethodInfo', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethodInfo));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethodManager', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethodManager));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethodSession', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethodSession));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethodSession_EventCallback', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethodSession_EventCallback));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethodSubtype', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethodSubtype));
  TRegTypes.RegisterType('Androidapi.JNI.GraphicsContentViewText.JInputMethodSubtype_InputMethodSubtypeBuilder', TypeInfo(Androidapi.JNI.GraphicsContentViewText.JInputMethodSubtype_InputMethodSubtypeBuilder));
end;

initialization
  RegisterTypes;
end.


