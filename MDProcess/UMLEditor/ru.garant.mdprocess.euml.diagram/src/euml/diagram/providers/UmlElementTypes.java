package euml.diagram.providers;

import java.util.HashSet;
import java.util.IdentityHashMap;
import java.util.Map;
import java.util.Set;

import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EClassifier;
import org.eclipse.emf.ecore.ENamedElement;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.gmf.runtime.emf.type.core.ElementTypeRegistry;
import org.eclipse.gmf.runtime.emf.type.core.IElementType;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.resource.ImageRegistry;
import org.eclipse.swt.graphics.Image;

import euml.EumlPackage;
import euml.diagram.part.UmlDiagramEditorPlugin;

/**
 * @generated
 */
public class UmlElementTypes extends ElementInitializers {

	/**
	 * @generated
	 */
	private UmlElementTypes() {
	}

	/**
	 * @generated
	 */
	private static Map elements;

	/**
	 * @generated
	 */
	private static ImageRegistry imageRegistry;

	/**
	 * @generated
	 */
	private static Set KNOWN_ELEMENT_TYPES;

	/**
	 * @generated
	 */
	public static final IElementType Package_1000 = getElementType("ru.garant.mdprocess.euml.diagram.Package_1000"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Class_2001 = getElementType("ru.garant.mdprocess.euml.diagram.Class_2001"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Package_2002 = getElementType("ru.garant.mdprocess.euml.diagram.Package_2002"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Attribute_3001 = getElementType("ru.garant.mdprocess.euml.diagram.Attribute_3001"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Operation_3002 = getElementType("ru.garant.mdprocess.euml.diagram.Operation_3002"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Dependecy_4001 = getElementType("ru.garant.mdprocess.euml.diagram.Dependecy_4001"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Realization_4002 = getElementType("ru.garant.mdprocess.euml.diagram.Realization_4002"); //$NON-NLS-1$
	/**
	 * @generated
	 */
	public static final IElementType Generalization_4003 = getElementType("ru.garant.mdprocess.euml.diagram.Generalization_4003"); //$NON-NLS-1$

	/**
	 * @generated
	 */
	private static ImageRegistry getImageRegistry() {
		if (imageRegistry == null) {
			imageRegistry = new ImageRegistry();
		}
		return imageRegistry;
	}

	/**
	 * @generated
	 */
	private static String getImageRegistryKey(ENamedElement element) {
		return element.getName();
	}

	/**
	 * @generated
	 */
	private static ImageDescriptor getProvidedImageDescriptor(
			ENamedElement element) {
		if (element instanceof EStructuralFeature) {
			EStructuralFeature feature = ((EStructuralFeature) element);
			EClass eContainingClass = feature.getEContainingClass();
			EClassifier eType = feature.getEType();
			if (eContainingClass != null && !eContainingClass.isAbstract()) {
				element = eContainingClass;
			} else if (eType instanceof EClass
					&& !((EClass) eType).isAbstract()) {
				element = eType;
			}
		}
		if (element instanceof EClass) {
			EClass eClass = (EClass) element;
			if (!eClass.isAbstract()) {
				return UmlDiagramEditorPlugin.getInstance()
						.getItemImageDescriptor(
								eClass.getEPackage().getEFactoryInstance()
										.create(eClass));
			}
		}
		// TODO : support structural features
		return null;
	}

	/**
	 * @generated
	 */
	public static ImageDescriptor getImageDescriptor(ENamedElement element) {
		String key = getImageRegistryKey(element);
		ImageDescriptor imageDescriptor = getImageRegistry().getDescriptor(key);
		if (imageDescriptor == null) {
			imageDescriptor = getProvidedImageDescriptor(element);
			if (imageDescriptor == null) {
				imageDescriptor = ImageDescriptor.getMissingImageDescriptor();
			}
			getImageRegistry().put(key, imageDescriptor);
		}
		return imageDescriptor;
	}

	/**
	 * @generated
	 */
	public static Image getImage(ENamedElement element) {
		String key = getImageRegistryKey(element);
		Image image = getImageRegistry().get(key);
		if (image == null) {
			ImageDescriptor imageDescriptor = getProvidedImageDescriptor(element);
			if (imageDescriptor == null) {
				imageDescriptor = ImageDescriptor.getMissingImageDescriptor();
			}
			getImageRegistry().put(key, imageDescriptor);
			image = getImageRegistry().get(key);
		}
		return image;
	}

	/**
	 * @generated
	 */
	public static ImageDescriptor getImageDescriptor(IAdaptable hint) {
		ENamedElement element = getElement(hint);
		if (element == null) {
			return null;
		}
		return getImageDescriptor(element);
	}

	/**
	 * @generated
	 */
	public static Image getImage(IAdaptable hint) {
		ENamedElement element = getElement(hint);
		if (element == null) {
			return null;
		}
		return getImage(element);
	}

	/**
	 * Returns 'type' of the ecore object associated with the hint.
	 * 
	 * @generated
	 */
	public static ENamedElement getElement(IAdaptable hint) {
		Object type = hint.getAdapter(IElementType.class);
		if (elements == null) {
			elements = new IdentityHashMap();

			elements.put(Package_1000, EumlPackage.eINSTANCE.getPackage());

			elements.put(Class_2001, EumlPackage.eINSTANCE.getClass_());

			elements.put(Package_2002, EumlPackage.eINSTANCE.getPackage());

			elements.put(Attribute_3001, EumlPackage.eINSTANCE.getAttribute());

			elements.put(Operation_3002, EumlPackage.eINSTANCE.getOperation());

			elements.put(Dependecy_4001, EumlPackage.eINSTANCE.getDependecy());

			elements.put(Realization_4002, EumlPackage.eINSTANCE
					.getRealization());

			elements.put(Generalization_4003, EumlPackage.eINSTANCE
					.getGeneralization());
		}
		return (ENamedElement) elements.get(type);
	}

	/**
	 * @generated
	 */
	private static IElementType getElementType(String id) {
		return ElementTypeRegistry.getInstance().getType(id);
	}

	/**
	 * @generated
	 */
	public static boolean isKnownElementType(IElementType elementType) {
		if (KNOWN_ELEMENT_TYPES == null) {
			KNOWN_ELEMENT_TYPES = new HashSet();
			KNOWN_ELEMENT_TYPES.add(Package_1000);
			KNOWN_ELEMENT_TYPES.add(Class_2001);
			KNOWN_ELEMENT_TYPES.add(Package_2002);
			KNOWN_ELEMENT_TYPES.add(Attribute_3001);
			KNOWN_ELEMENT_TYPES.add(Operation_3002);
			KNOWN_ELEMENT_TYPES.add(Dependecy_4001);
			KNOWN_ELEMENT_TYPES.add(Realization_4002);
			KNOWN_ELEMENT_TYPES.add(Generalization_4003);
		}
		return KNOWN_ELEMENT_TYPES.contains(elementType);
	}

}
