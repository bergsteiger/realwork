package euml.diagram.navigator;

import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.gmf.runtime.common.ui.services.parser.IParser;
import org.eclipse.gmf.runtime.common.ui.services.parser.ParserOptions;
import org.eclipse.gmf.runtime.common.ui.services.parser.ParserService;
import org.eclipse.gmf.runtime.emf.type.core.IElementType;
import org.eclipse.gmf.runtime.notation.View;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.resource.ImageRegistry;
import org.eclipse.jface.viewers.ITreePathLabelProvider;
import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.jface.viewers.TreePath;
import org.eclipse.jface.viewers.ViewerLabel;
import org.eclipse.swt.graphics.Image;
import org.eclipse.ui.IMemento;
import org.eclipse.ui.navigator.ICommonContentExtensionSite;
import org.eclipse.ui.navigator.ICommonLabelProvider;

import euml.Package;
import euml.diagram.edit.parts.AttributeEditPart;
import euml.diagram.edit.parts.ClassEditPart;
import euml.diagram.edit.parts.ClassNameEditPart;
import euml.diagram.edit.parts.DependecyEditPart;
import euml.diagram.edit.parts.GeneralizationEditPart;
import euml.diagram.edit.parts.OperationEditPart;
import euml.diagram.edit.parts.Package2EditPart;
import euml.diagram.edit.parts.PackageEditPart;
import euml.diagram.edit.parts.PackageNameEditPart;
import euml.diagram.edit.parts.RealizationEditPart;
import euml.diagram.part.UmlDiagramEditorPlugin;
import euml.diagram.part.UmlVisualIDRegistry;
import euml.diagram.providers.UmlElementTypes;
import euml.diagram.providers.UmlParserProvider;

/**
 * @generated
 */
public class UmlNavigatorLabelProvider extends LabelProvider implements
		ICommonLabelProvider, ITreePathLabelProvider {

	/**
	 * @generated
	 */
	static {
		UmlDiagramEditorPlugin
				.getInstance()
				.getImageRegistry()
				.put(
						"Navigator?UnknownElement", ImageDescriptor.getMissingImageDescriptor()); //$NON-NLS-1$
		UmlDiagramEditorPlugin
				.getInstance()
				.getImageRegistry()
				.put(
						"Navigator?ImageNotFound", ImageDescriptor.getMissingImageDescriptor()); //$NON-NLS-1$
	}

	/**
	 * @generated
	 */
	public void updateLabel(ViewerLabel label, TreePath elementPath) {
		Object element = elementPath.getLastSegment();
		if (element instanceof UmlNavigatorItem
				&& !isOwnView(((UmlNavigatorItem) element).getView())) {
			return;
		}
		label.setText(getText(element));
		label.setImage(getImage(element));
	}

	/**
	 * @generated
	 */
	public Image getImage(Object element) {
		if (element instanceof UmlNavigatorGroup) {
			UmlNavigatorGroup group = (UmlNavigatorGroup) element;
			return UmlDiagramEditorPlugin.getInstance().getBundledImage(
					group.getIcon());
		}

		if (element instanceof UmlNavigatorItem) {
			UmlNavigatorItem navigatorItem = (UmlNavigatorItem) element;
			if (!isOwnView(navigatorItem.getView())) {
				return super.getImage(element);
			}
			return getImage(navigatorItem.getView());
		}

		return super.getImage(element);
	}

	/**
	 * @generated
	 */
	public Image getImage(View view) {
		switch (UmlVisualIDRegistry.getVisualID(view)) {
		case PackageEditPart.VISUAL_ID:
			return getImage(
					"Navigator?Diagram?ru.garant.mdprocess.euml?Package", UmlElementTypes.Package_1000); //$NON-NLS-1$
		case ClassEditPart.VISUAL_ID:
			return getImage(
					"Navigator?TopLevelNode?ru.garant.mdprocess.euml?Class", UmlElementTypes.Class_2003); //$NON-NLS-1$
		case Package2EditPart.VISUAL_ID:
			return getImage(
					"Navigator?TopLevelNode?ru.garant.mdprocess.euml?Package", UmlElementTypes.Package_2004); //$NON-NLS-1$
		case AttributeEditPart.VISUAL_ID:
			return getImage(
					"Navigator?Node?ru.garant.mdprocess.euml?Attribute", UmlElementTypes.Attribute_3003); //$NON-NLS-1$
		case OperationEditPart.VISUAL_ID:
			return getImage(
					"Navigator?Node?ru.garant.mdprocess.euml?Operation", UmlElementTypes.Operation_3004); //$NON-NLS-1$
		case DependecyEditPart.VISUAL_ID:
			return getImage(
					"Navigator?Link?ru.garant.mdprocess.euml?Dependecy", UmlElementTypes.Dependecy_4004); //$NON-NLS-1$
		case RealizationEditPart.VISUAL_ID:
			return getImage(
					"Navigator?Link?ru.garant.mdprocess.euml?Realization", UmlElementTypes.Realization_4005); //$NON-NLS-1$
		case GeneralizationEditPart.VISUAL_ID:
			return getImage(
					"Navigator?Link?ru.garant.mdprocess.euml?Generalization", UmlElementTypes.Generalization_4006); //$NON-NLS-1$
		}
		return getImage("Navigator?UnknownElement", null); //$NON-NLS-1$
	}

	/**
	 * @generated
	 */
	private Image getImage(String key, IElementType elementType) {
		ImageRegistry imageRegistry = UmlDiagramEditorPlugin.getInstance()
				.getImageRegistry();
		Image image = imageRegistry.get(key);
		if (image == null && elementType != null
				&& UmlElementTypes.isKnownElementType(elementType)) {
			image = UmlElementTypes.getImage(elementType);
			imageRegistry.put(key, image);
		}

		if (image == null) {
			image = imageRegistry.get("Navigator?ImageNotFound"); //$NON-NLS-1$
			imageRegistry.put(key, image);
		}
		return image;
	}

	/**
	 * @generated
	 */
	public String getText(Object element) {
		if (element instanceof UmlNavigatorGroup) {
			UmlNavigatorGroup group = (UmlNavigatorGroup) element;
			return group.getGroupName();
		}

		if (element instanceof UmlNavigatorItem) {
			UmlNavigatorItem navigatorItem = (UmlNavigatorItem) element;
			if (!isOwnView(navigatorItem.getView())) {
				return null;
			}
			return getText(navigatorItem.getView());
		}

		return super.getText(element);
	}

	/**
	 * @generated
	 */
	public String getText(View view) {
		if (view.getElement() != null && view.getElement().eIsProxy()) {
			return getUnresolvedDomainElementProxyText(view);
		}
		switch (UmlVisualIDRegistry.getVisualID(view)) {
		case PackageEditPart.VISUAL_ID:
			return getPackage_1000Text(view);
		case ClassEditPart.VISUAL_ID:
			return getClass_2003Text(view);
		case Package2EditPart.VISUAL_ID:
			return getPackage_2004Text(view);
		case AttributeEditPart.VISUAL_ID:
			return getAttribute_3003Text(view);
		case OperationEditPart.VISUAL_ID:
			return getOperation_3004Text(view);
		case DependecyEditPart.VISUAL_ID:
			return getDependecy_4004Text(view);
		case RealizationEditPart.VISUAL_ID:
			return getRealization_4005Text(view);
		case GeneralizationEditPart.VISUAL_ID:
			return getGeneralization_4006Text(view);
		}
		return getUnknownElementText(view);
	}

	/**
	 * @generated
	 */
	private String getPackage_1000Text(View view) {
		Package domainModelElement = (Package) view.getElement();
		if (domainModelElement != null) {
			return domainModelElement.getName();
		} else {
			UmlDiagramEditorPlugin.getInstance().logError(
					"No domain element for view with visualID = " + 1000); //$NON-NLS-1$
			return ""; //$NON-NLS-1$
		}
	}

	/**
	 * @generated
	 */
	private String getClass_2003Text(View view) {
		IAdaptable hintAdapter = new UmlParserProvider.HintAdapter(
				UmlElementTypes.Class_2003, (view.getElement() != null ? view
						.getElement() : view), UmlVisualIDRegistry
						.getType(ClassNameEditPart.VISUAL_ID));
		IParser parser = ParserService.getInstance().getParser(hintAdapter);

		if (parser != null) {
			return parser.getPrintString(hintAdapter, ParserOptions.NONE
					.intValue());
		} else {
			UmlDiagramEditorPlugin.getInstance().logError(
					"Parser was not found for label " + 5003); //$NON-NLS-1$
			return ""; //$NON-NLS-1$
		}

	}

	/**
	 * @generated
	 */
	private String getPackage_2004Text(View view) {
		IAdaptable hintAdapter = new UmlParserProvider.HintAdapter(
				UmlElementTypes.Package_2004, (view.getElement() != null ? view
						.getElement() : view), UmlVisualIDRegistry
						.getType(PackageNameEditPart.VISUAL_ID));
		IParser parser = ParserService.getInstance().getParser(hintAdapter);

		if (parser != null) {
			return parser.getPrintString(hintAdapter, ParserOptions.NONE
					.intValue());
		} else {
			UmlDiagramEditorPlugin.getInstance().logError(
					"Parser was not found for label " + 5004); //$NON-NLS-1$
			return ""; //$NON-NLS-1$
		}

	}

	/**
	 * @generated
	 */
	private String getAttribute_3003Text(View view) {
		IAdaptable hintAdapter = new UmlParserProvider.HintAdapter(
				UmlElementTypes.Attribute_3003,
				(view.getElement() != null ? view.getElement() : view),
				UmlVisualIDRegistry.getType(AttributeEditPart.VISUAL_ID));
		IParser parser = ParserService.getInstance().getParser(hintAdapter);

		if (parser != null) {
			return parser.getPrintString(hintAdapter, ParserOptions.NONE
					.intValue());
		} else {
			UmlDiagramEditorPlugin.getInstance().logError(
					"Parser was not found for label " + 3003); //$NON-NLS-1$
			return ""; //$NON-NLS-1$
		}
	}

	/**
	 * @generated
	 */
	private String getOperation_3004Text(View view) {
		IAdaptable hintAdapter = new UmlParserProvider.HintAdapter(
				UmlElementTypes.Operation_3004,
				(view.getElement() != null ? view.getElement() : view),
				UmlVisualIDRegistry.getType(OperationEditPart.VISUAL_ID));
		IParser parser = ParserService.getInstance().getParser(hintAdapter);

		if (parser != null) {
			return parser.getPrintString(hintAdapter, ParserOptions.NONE
					.intValue());
		} else {
			UmlDiagramEditorPlugin.getInstance().logError(
					"Parser was not found for label " + 3004); //$NON-NLS-1$
			return ""; //$NON-NLS-1$
		}
	}

	/**
	 * @generated
	 */
	private String getDependecy_4004Text(View view) {
		return ""; //$NON-NLS-1$
	}

	/**
	 * @generated
	 */
	private String getRealization_4005Text(View view) {
		return ""; //$NON-NLS-1$
	}

	/**
	 * @generated
	 */
	private String getGeneralization_4006Text(View view) {
		return ""; //$NON-NLS-1$
	}

	/**
	 * @generated
	 */
	private String getUnknownElementText(View view) {
		return "<UnknownElement Visual_ID = " + view.getType() + ">"; //$NON-NLS-1$ //$NON-NLS-2$
	}

	/**
	 * @generated
	 */
	private String getUnresolvedDomainElementProxyText(View view) {
		return "<Unresolved domain element Visual_ID = " + view.getType() + ">"; //$NON-NLS-1$ //$NON-NLS-2$
	}

	/**
	 * @generated
	 */
	public void init(ICommonContentExtensionSite aConfig) {
	}

	/**
	 * @generated
	 */
	public void restoreState(IMemento aMemento) {
	}

	/**
	 * @generated
	 */
	public void saveState(IMemento aMemento) {
	}

	/**
	 * @generated
	 */
	public String getDescription(Object anElement) {
		return null;
	}

	/**
	 * @generated
	 */
	private boolean isOwnView(View view) {
		return PackageEditPart.MODEL_ID.equals(UmlVisualIDRegistry
				.getModelID(view));
	}

}
