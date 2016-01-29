package euml.diagram.providers;

import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.gmf.runtime.diagram.core.providers.AbstractViewProvider;
import org.eclipse.gmf.runtime.emf.type.core.IElementType;
import org.eclipse.gmf.runtime.emf.type.core.IHintedType;
import org.eclipse.gmf.runtime.notation.View;

import euml.diagram.edit.parts.AttributeEditPart;
import euml.diagram.edit.parts.ClassAttributesEditPart;
import euml.diagram.edit.parts.ClassEditPart;
import euml.diagram.edit.parts.ClassNameEditPart;
import euml.diagram.edit.parts.ClassOperationsEditPart;
import euml.diagram.edit.parts.DependecyEditPart;
import euml.diagram.edit.parts.GeneralizationEditPart;
import euml.diagram.edit.parts.OperationEditPart;
import euml.diagram.edit.parts.Package2EditPart;
import euml.diagram.edit.parts.PackageEditPart;
import euml.diagram.edit.parts.PackageNameEditPart;
import euml.diagram.edit.parts.RealizationEditPart;
import euml.diagram.part.UmlVisualIDRegistry;
import euml.diagram.view.factories.AttributeViewFactory;
import euml.diagram.view.factories.ClassAttributesViewFactory;
import euml.diagram.view.factories.ClassNameViewFactory;
import euml.diagram.view.factories.ClassOperationsViewFactory;
import euml.diagram.view.factories.ClassViewFactory;
import euml.diagram.view.factories.DependecyViewFactory;
import euml.diagram.view.factories.GeneralizationViewFactory;
import euml.diagram.view.factories.OperationViewFactory;
import euml.diagram.view.factories.Package2ViewFactory;
import euml.diagram.view.factories.PackageNameViewFactory;
import euml.diagram.view.factories.PackageViewFactory;
import euml.diagram.view.factories.RealizationViewFactory;

/**
 * @generated
 */
public class UmlViewProvider extends AbstractViewProvider {

	/**
	 * @generated
	 */
	protected Class getDiagramViewClass(IAdaptable semanticAdapter,
			String diagramKind) {
		EObject semanticElement = getSemanticElement(semanticAdapter);
		if (PackageEditPart.MODEL_ID.equals(diagramKind)
				&& UmlVisualIDRegistry.getDiagramVisualID(semanticElement) != -1) {
			return PackageViewFactory.class;
		}
		return null;
	}

	/**
	 * @generated
	 */
	protected Class getNodeViewClass(IAdaptable semanticAdapter,
			View containerView, String semanticHint) {
		if (containerView == null) {
			return null;
		}
		IElementType elementType = getSemanticElementType(semanticAdapter);
		EObject domainElement = getSemanticElement(semanticAdapter);
		int visualID;
		if (semanticHint == null) {
			// Semantic hint is not specified. Can be a result of call from CanonicalEditPolicy.
			// In this situation there should be NO elementType, visualID will be determined
			// by VisualIDRegistry.getNodeVisualID() for domainElement.
			if (elementType != null || domainElement == null) {
				return null;
			}
			visualID = UmlVisualIDRegistry.getNodeVisualID(containerView,
					domainElement);
		} else {
			visualID = UmlVisualIDRegistry.getVisualID(semanticHint);
			if (elementType != null) {
				// Semantic hint is specified together with element type.
				// Both parameters should describe exactly the same diagram element.
				// In addition we check that visualID returned by VisualIDRegistry.getNodeVisualID() for
				// domainElement (if specified) is the same as in element type.
				if (!UmlElementTypes.isKnownElementType(elementType)
						|| (!(elementType instanceof IHintedType))) {
					return null; // foreign element type
				}
				String elementTypeHint = ((IHintedType) elementType)
						.getSemanticHint();
				if (!semanticHint.equals(elementTypeHint)) {
					return null; // if semantic hint is specified it should be the same as in element type
				}
				if (domainElement != null
						&& visualID != UmlVisualIDRegistry.getNodeVisualID(
								containerView, domainElement)) {
					return null; // visual id for node EClass should match visual id from element type
				}
			} else {
				// Element type is not specified. Domain element should be present (except pure design elements).
				// This method is called with EObjectAdapter as parameter from:
				//   - ViewService.createNode(View container, EObject eObject, String type, PreferencesHint preferencesHint) 
				//   - generated ViewFactory.decorateView() for parent element
				if (!PackageEditPart.MODEL_ID.equals(UmlVisualIDRegistry
						.getModelID(containerView))) {
					return null; // foreign diagram
				}
				switch (visualID) {
				case ClassEditPart.VISUAL_ID:
				case AttributeEditPart.VISUAL_ID:
				case OperationEditPart.VISUAL_ID:
				case Package2EditPart.VISUAL_ID:
					if (domainElement == null
							|| visualID != UmlVisualIDRegistry.getNodeVisualID(
									containerView, domainElement)) {
						return null; // visual id in semantic hint should match visual id for domain element
					}
					break;
				case ClassNameEditPart.VISUAL_ID:
				case ClassAttributesEditPart.VISUAL_ID:
				case ClassOperationsEditPart.VISUAL_ID:
					if (ClassEditPart.VISUAL_ID != UmlVisualIDRegistry
							.getVisualID(containerView)
							|| containerView.getElement() != domainElement) {
						return null; // wrong container
					}
					break;
				case PackageNameEditPart.VISUAL_ID:
					if (Package2EditPart.VISUAL_ID != UmlVisualIDRegistry
							.getVisualID(containerView)
							|| containerView.getElement() != domainElement) {
						return null; // wrong container
					}
					break;
				default:
					return null;
				}
			}
		}
		return getNodeViewClass(containerView, visualID);
	}

	/**
	 * @generated
	 */
	protected Class getNodeViewClass(View containerView, int visualID) {
		if (containerView == null
				|| !UmlVisualIDRegistry.canCreateNode(containerView, visualID)) {
			return null;
		}
		switch (visualID) {
		case ClassEditPart.VISUAL_ID:
			return ClassViewFactory.class;
		case ClassNameEditPart.VISUAL_ID:
			return ClassNameViewFactory.class;
		case Package2EditPart.VISUAL_ID:
			return Package2ViewFactory.class;
		case PackageNameEditPart.VISUAL_ID:
			return PackageNameViewFactory.class;
		case AttributeEditPart.VISUAL_ID:
			return AttributeViewFactory.class;
		case OperationEditPart.VISUAL_ID:
			return OperationViewFactory.class;
		case ClassAttributesEditPart.VISUAL_ID:
			return ClassAttributesViewFactory.class;
		case ClassOperationsEditPart.VISUAL_ID:
			return ClassOperationsViewFactory.class;
		}
		return null;
	}

	/**
	 * @generated
	 */
	protected Class getEdgeViewClass(IAdaptable semanticAdapter,
			View containerView, String semanticHint) {
		IElementType elementType = getSemanticElementType(semanticAdapter);
		if (!UmlElementTypes.isKnownElementType(elementType)
				|| (!(elementType instanceof IHintedType))) {
			return null; // foreign element type
		}
		String elementTypeHint = ((IHintedType) elementType).getSemanticHint();
		if (elementTypeHint == null) {
			return null; // our hint is visual id and must be specified
		}
		if (semanticHint != null && !semanticHint.equals(elementTypeHint)) {
			return null; // if semantic hint is specified it should be the same as in element type
		}
		int visualID = UmlVisualIDRegistry.getVisualID(elementTypeHint);
		EObject domainElement = getSemanticElement(semanticAdapter);
		if (domainElement != null
				&& visualID != UmlVisualIDRegistry
						.getLinkWithClassVisualID(domainElement)) {
			return null; // visual id for link EClass should match visual id from element type
		}
		return getEdgeViewClass(visualID);
	}

	/**
	 * @generated
	 */
	protected Class getEdgeViewClass(int visualID) {
		switch (visualID) {
		case DependecyEditPart.VISUAL_ID:
			return DependecyViewFactory.class;
		case RealizationEditPart.VISUAL_ID:
			return RealizationViewFactory.class;
		case GeneralizationEditPart.VISUAL_ID:
			return GeneralizationViewFactory.class;
		}
		return null;
	}

	/**
	 * @generated
	 */
	private IElementType getSemanticElementType(IAdaptable semanticAdapter) {
		if (semanticAdapter == null) {
			return null;
		}
		return (IElementType) semanticAdapter.getAdapter(IElementType.class);
	}
}
