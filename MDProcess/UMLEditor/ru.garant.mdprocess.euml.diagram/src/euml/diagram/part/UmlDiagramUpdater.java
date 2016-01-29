package euml.diagram.part;

import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.gmf.runtime.notation.View;

import euml.Attribute;
import euml.Class;
import euml.Dependecy;
import euml.EumlPackage;
import euml.Generalization;
import euml.NamedElement;
import euml.Operation;
import euml.Package;
import euml.Realization;
import euml.diagram.edit.parts.AttributeEditPart;
import euml.diagram.edit.parts.ClassAttributesEditPart;
import euml.diagram.edit.parts.ClassEditPart;
import euml.diagram.edit.parts.ClassOperationsEditPart;
import euml.diagram.edit.parts.DependecyEditPart;
import euml.diagram.edit.parts.GeneralizationEditPart;
import euml.diagram.edit.parts.OperationEditPart;
import euml.diagram.edit.parts.Package2EditPart;
import euml.diagram.edit.parts.PackageEditPart;
import euml.diagram.edit.parts.RealizationEditPart;
import euml.diagram.providers.UmlElementTypes;

/**
 * @generated
 */
public class UmlDiagramUpdater {

	/**
	 * @generated
	 */
	public static List getSemanticChildren(View view) {
		switch (UmlVisualIDRegistry.getVisualID(view)) {
		case ClassAttributesEditPart.VISUAL_ID:
			return getClassAttributes_7001SemanticChildren(view);
		case ClassOperationsEditPart.VISUAL_ID:
			return getClassOperations_7002SemanticChildren(view);
		case PackageEditPart.VISUAL_ID:
			return getPackage_1000SemanticChildren(view);
		}
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getClassAttributes_7001SemanticChildren(View view) {
		if (false == view.eContainer() instanceof View) {
			return Collections.EMPTY_LIST;
		}
		View containerView = (View) view.eContainer();
		if (!containerView.isSetElement()) {
			return Collections.EMPTY_LIST;
		}
		Class modelElement = (Class) containerView.getElement();
		List result = new LinkedList();
		for (Iterator it = modelElement.getAttributes().iterator(); it
				.hasNext();) {
			Attribute childElement = (Attribute) it.next();
			int visualID = UmlVisualIDRegistry.getNodeVisualID(view,
					childElement);
			if (visualID == AttributeEditPart.VISUAL_ID) {
				result.add(new UmlNodeDescriptor(childElement, visualID));
				continue;
			}
		}
		return result;
	}

	/**
	 * @generated
	 */
	public static List getClassOperations_7002SemanticChildren(View view) {
		if (false == view.eContainer() instanceof View) {
			return Collections.EMPTY_LIST;
		}
		View containerView = (View) view.eContainer();
		if (!containerView.isSetElement()) {
			return Collections.EMPTY_LIST;
		}
		Class modelElement = (Class) containerView.getElement();
		List result = new LinkedList();
		for (Iterator it = modelElement.getOperations().iterator(); it
				.hasNext();) {
			Operation childElement = (Operation) it.next();
			int visualID = UmlVisualIDRegistry.getNodeVisualID(view,
					childElement);
			if (visualID == OperationEditPart.VISUAL_ID) {
				result.add(new UmlNodeDescriptor(childElement, visualID));
				continue;
			}
		}
		return result;
	}

	/**
	 * @generated
	 */
	public static List getPackage_1000SemanticChildren(View view) {
		if (!view.isSetElement()) {
			return Collections.EMPTY_LIST;
		}
		Package modelElement = (Package) view.getElement();
		List result = new LinkedList();
		for (Iterator it = modelElement.getClasses().iterator(); it.hasNext();) {
			Class childElement = (Class) it.next();
			int visualID = UmlVisualIDRegistry.getNodeVisualID(view,
					childElement);
			if (visualID == ClassEditPart.VISUAL_ID) {
				result.add(new UmlNodeDescriptor(childElement, visualID));
				continue;
			}
		}
		for (Iterator it = modelElement.getPackages().iterator(); it.hasNext();) {
			Package childElement = (Package) it.next();
			int visualID = UmlVisualIDRegistry.getNodeVisualID(view,
					childElement);
			if (visualID == Package2EditPart.VISUAL_ID) {
				result.add(new UmlNodeDescriptor(childElement, visualID));
				continue;
			}
		}
		return result;
	}

	/**
	 * @generated
	 */
	public static List getContainedLinks(View view) {
		switch (UmlVisualIDRegistry.getVisualID(view)) {
		case PackageEditPart.VISUAL_ID:
			return getPackage_1000ContainedLinks(view);
		case ClassEditPart.VISUAL_ID:
			return getClass_2001ContainedLinks(view);
		case Package2EditPart.VISUAL_ID:
			return getPackage_2002ContainedLinks(view);
		case AttributeEditPart.VISUAL_ID:
			return getAttribute_3001ContainedLinks(view);
		case OperationEditPart.VISUAL_ID:
			return getOperation_3002ContainedLinks(view);
		case DependecyEditPart.VISUAL_ID:
			return getDependecy_4001ContainedLinks(view);
		case RealizationEditPart.VISUAL_ID:
			return getRealization_4002ContainedLinks(view);
		case GeneralizationEditPart.VISUAL_ID:
			return getGeneralization_4003ContainedLinks(view);
		}
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getIncomingLinks(View view) {
		switch (UmlVisualIDRegistry.getVisualID(view)) {
		case ClassEditPart.VISUAL_ID:
			return getClass_2001IncomingLinks(view);
		case Package2EditPart.VISUAL_ID:
			return getPackage_2002IncomingLinks(view);
		case AttributeEditPart.VISUAL_ID:
			return getAttribute_3001IncomingLinks(view);
		case OperationEditPart.VISUAL_ID:
			return getOperation_3002IncomingLinks(view);
		case DependecyEditPart.VISUAL_ID:
			return getDependecy_4001IncomingLinks(view);
		case RealizationEditPart.VISUAL_ID:
			return getRealization_4002IncomingLinks(view);
		case GeneralizationEditPart.VISUAL_ID:
			return getGeneralization_4003IncomingLinks(view);
		}
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getOutgoingLinks(View view) {
		switch (UmlVisualIDRegistry.getVisualID(view)) {
		case ClassEditPart.VISUAL_ID:
			return getClass_2001OutgoingLinks(view);
		case Package2EditPart.VISUAL_ID:
			return getPackage_2002OutgoingLinks(view);
		case AttributeEditPart.VISUAL_ID:
			return getAttribute_3001OutgoingLinks(view);
		case OperationEditPart.VISUAL_ID:
			return getOperation_3002OutgoingLinks(view);
		case DependecyEditPart.VISUAL_ID:
			return getDependecy_4001OutgoingLinks(view);
		case RealizationEditPart.VISUAL_ID:
			return getRealization_4002OutgoingLinks(view);
		case GeneralizationEditPart.VISUAL_ID:
			return getGeneralization_4003OutgoingLinks(view);
		}
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getPackage_1000ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getClass_2001ContainedLinks(View view) {
		Class modelElement = (Class) view.getElement();
		List result = new LinkedList();
		result
				.addAll(getContainedTypeModelFacetLinks_Dependecy_4001(modelElement));
		result
				.addAll(getContainedTypeModelFacetLinks_Realization_4002(modelElement));
		result
				.addAll(getContainedTypeModelFacetLinks_Generalization_4003(modelElement));
		return result;
	}

	/**
	 * @generated
	 */
	public static List getPackage_2002ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getAttribute_3001ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getOperation_3002ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getDependecy_4001ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getRealization_4002ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getGeneralization_4003ContainedLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getClass_2001IncomingLinks(View view) {
		Class modelElement = (Class) view.getElement();
		Map crossReferences = EcoreUtil.CrossReferencer.find(view.eResource()
				.getResourceSet().getResources());
		List result = new LinkedList();
		result.addAll(getIncomingTypeModelFacetLinks_Dependecy_4001(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Realization_4002(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Generalization_4003(
				modelElement, crossReferences));
		return result;
	}

	/**
	 * @generated
	 */
	public static List getPackage_2002IncomingLinks(View view) {
		Package modelElement = (Package) view.getElement();
		Map crossReferences = EcoreUtil.CrossReferencer.find(view.eResource()
				.getResourceSet().getResources());
		List result = new LinkedList();
		result.addAll(getIncomingTypeModelFacetLinks_Dependecy_4001(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Realization_4002(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Generalization_4003(
				modelElement, crossReferences));
		return result;
	}

	/**
	 * @generated
	 */
	public static List getAttribute_3001IncomingLinks(View view) {
		Attribute modelElement = (Attribute) view.getElement();
		Map crossReferences = EcoreUtil.CrossReferencer.find(view.eResource()
				.getResourceSet().getResources());
		List result = new LinkedList();
		result.addAll(getIncomingTypeModelFacetLinks_Dependecy_4001(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Realization_4002(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Generalization_4003(
				modelElement, crossReferences));
		return result;
	}

	/**
	 * @generated
	 */
	public static List getOperation_3002IncomingLinks(View view) {
		Operation modelElement = (Operation) view.getElement();
		Map crossReferences = EcoreUtil.CrossReferencer.find(view.eResource()
				.getResourceSet().getResources());
		List result = new LinkedList();
		result.addAll(getIncomingTypeModelFacetLinks_Dependecy_4001(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Realization_4002(
				modelElement, crossReferences));
		result.addAll(getIncomingTypeModelFacetLinks_Generalization_4003(
				modelElement, crossReferences));
		return result;
	}

	/**
	 * @generated
	 */
	public static List getDependecy_4001IncomingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getRealization_4002IncomingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getGeneralization_4003IncomingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getClass_2001OutgoingLinks(View view) {
		Class modelElement = (Class) view.getElement();
		List result = new LinkedList();
		result
				.addAll(getContainedTypeModelFacetLinks_Dependecy_4001(modelElement));
		result
				.addAll(getContainedTypeModelFacetLinks_Realization_4002(modelElement));
		result
				.addAll(getContainedTypeModelFacetLinks_Generalization_4003(modelElement));
		return result;
	}

	/**
	 * @generated
	 */
	public static List getPackage_2002OutgoingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getAttribute_3001OutgoingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getOperation_3002OutgoingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getDependecy_4001OutgoingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getRealization_4002OutgoingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	public static List getGeneralization_4003OutgoingLinks(View view) {
		return Collections.EMPTY_LIST;
	}

	/**
	 * @generated
	 */
	private static Collection getContainedTypeModelFacetLinks_Dependecy_4001(
			Class container) {
		Collection result = new LinkedList();
		for (Iterator links = container.getDependencies().iterator(); links
				.hasNext();) {
			EObject linkObject = (EObject) links.next();
			if (false == linkObject instanceof Dependecy) {
				continue;
			}
			Dependecy link = (Dependecy) linkObject;
			if (DependecyEditPart.VISUAL_ID != UmlVisualIDRegistry
					.getLinkWithClassVisualID(link)) {
				continue;
			}
			NamedElement dst = link.getTarget();
			result
					.add(new UmlLinkDescriptor(container, dst, link,
							UmlElementTypes.Dependecy_4001,
							DependecyEditPart.VISUAL_ID));
		}
		return result;
	}

	/**
	 * @generated
	 */
	private static Collection getContainedTypeModelFacetLinks_Realization_4002(
			Class container) {
		Collection result = new LinkedList();
		for (Iterator links = container.getRealizations().iterator(); links
				.hasNext();) {
			EObject linkObject = (EObject) links.next();
			if (false == linkObject instanceof Realization) {
				continue;
			}
			Realization link = (Realization) linkObject;
			if (RealizationEditPart.VISUAL_ID != UmlVisualIDRegistry
					.getLinkWithClassVisualID(link)) {
				continue;
			}
			NamedElement dst = link.getTarget();
			result.add(new UmlLinkDescriptor(container, dst, link,
					UmlElementTypes.Realization_4002,
					RealizationEditPart.VISUAL_ID));
		}
		return result;
	}

	/**
	 * @generated
	 */
	private static Collection getContainedTypeModelFacetLinks_Generalization_4003(
			Class container) {
		Collection result = new LinkedList();
		for (Iterator links = container.getGeneralizations().iterator(); links
				.hasNext();) {
			EObject linkObject = (EObject) links.next();
			if (false == linkObject instanceof Generalization) {
				continue;
			}
			Generalization link = (Generalization) linkObject;
			if (GeneralizationEditPart.VISUAL_ID != UmlVisualIDRegistry
					.getLinkWithClassVisualID(link)) {
				continue;
			}
			NamedElement dst = link.getTarget();
			result.add(new UmlLinkDescriptor(container, dst, link,
					UmlElementTypes.Generalization_4003,
					GeneralizationEditPart.VISUAL_ID));
		}
		return result;
	}

	/**
	 * @generated
	 */
	private static Collection getIncomingTypeModelFacetLinks_Dependecy_4001(
			NamedElement target, Map crossReferences) {
		Collection result = new LinkedList();
		Collection settings = (Collection) crossReferences.get(target);
		for (Iterator it = settings.iterator(); it.hasNext();) {
			EStructuralFeature.Setting setting = (EStructuralFeature.Setting) it
					.next();
			if (setting.getEStructuralFeature() != EumlPackage.eINSTANCE
					.getRelations_Target()
					|| false == setting.getEObject() instanceof Dependecy) {
				continue;
			}
			Dependecy link = (Dependecy) setting.getEObject();
			if (DependecyEditPart.VISUAL_ID != UmlVisualIDRegistry
					.getLinkWithClassVisualID(link)) {
				continue;
			}
			if (false == link.eContainer() instanceof Class) {
				continue;
			}
			Class container = (Class) link.eContainer();
			result
					.add(new UmlLinkDescriptor(container, target, link,
							UmlElementTypes.Dependecy_4001,
							DependecyEditPart.VISUAL_ID));

		}
		return result;
	}

	/**
	 * @generated
	 */
	private static Collection getIncomingTypeModelFacetLinks_Realization_4002(
			NamedElement target, Map crossReferences) {
		Collection result = new LinkedList();
		Collection settings = (Collection) crossReferences.get(target);
		for (Iterator it = settings.iterator(); it.hasNext();) {
			EStructuralFeature.Setting setting = (EStructuralFeature.Setting) it
					.next();
			if (setting.getEStructuralFeature() != EumlPackage.eINSTANCE
					.getRelations_Target()
					|| false == setting.getEObject() instanceof Realization) {
				continue;
			}
			Realization link = (Realization) setting.getEObject();
			if (RealizationEditPart.VISUAL_ID != UmlVisualIDRegistry
					.getLinkWithClassVisualID(link)) {
				continue;
			}
			if (false == link.eContainer() instanceof Class) {
				continue;
			}
			Class container = (Class) link.eContainer();
			result.add(new UmlLinkDescriptor(container, target, link,
					UmlElementTypes.Realization_4002,
					RealizationEditPart.VISUAL_ID));

		}
		return result;
	}

	/**
	 * @generated
	 */
	private static Collection getIncomingTypeModelFacetLinks_Generalization_4003(
			NamedElement target, Map crossReferences) {
		Collection result = new LinkedList();
		Collection settings = (Collection) crossReferences.get(target);
		for (Iterator it = settings.iterator(); it.hasNext();) {
			EStructuralFeature.Setting setting = (EStructuralFeature.Setting) it
					.next();
			if (setting.getEStructuralFeature() != EumlPackage.eINSTANCE
					.getRelations_Target()
					|| false == setting.getEObject() instanceof Generalization) {
				continue;
			}
			Generalization link = (Generalization) setting.getEObject();
			if (GeneralizationEditPart.VISUAL_ID != UmlVisualIDRegistry
					.getLinkWithClassVisualID(link)) {
				continue;
			}
			if (false == link.eContainer() instanceof Class) {
				continue;
			}
			Class container = (Class) link.eContainer();
			result.add(new UmlLinkDescriptor(container, target, link,
					UmlElementTypes.Generalization_4003,
					GeneralizationEditPart.VISUAL_ID));

		}
		return result;
	}

}
